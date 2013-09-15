class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    pairs = characters.zip(rotated_characters)
    Hash[pairs]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split("")
    results = letters.collect do |letter|
      encrypt_letter(letter, rotation)
    end
    results.join
  end

  def encrypt_file(filename, rotation)
    #Create the file handle to the input file
    input_file = File.open(filename, "r")
    file = input_file.read
    encrypted_file = encrypt(file, rotation)
    output_file = File.open("#{filename}.encrypted", "w")
    output_file.write(encrypted_file)
    output_file.close
  end

  def decrypt(string, rotation)
    encrypted_string = string.split("")
    negative_rotation = rotation * -1

    results = encrypted_string.collect do |string|
      encrypt_letter(string, negative_rotation)
    end
    results.join
  end

  def decrypt_file(filename, rotation)
    input_file = File.open(filename, "r")
    file = input_file.read
    decrypted_file = decrypt(file, rotation)
    output_filename = filename.gsub("encrypted", "decrypted")
    output_file = File.open(output_filename, "w")
    output_file.write(decrypted_file)
    output_file.close
  end

  def supported_characters
    (" ".."z").to_a
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      puts decrypt(message, attempt)
    end
  end

end