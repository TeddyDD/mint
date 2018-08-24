module Mint
  class Formatter
    def format(node : Ast::Function) : String
      name =
        format node.name

      type =
        format node.type

      body =
        list [node.body] + node.head_comments + node.tail_comments

      arguments =
        unless node.arguments.empty?
          value =
            format node.arguments

          if value.map(&.size).sum > 50
            "(\n#{value.join(",\n").indent}\n) "
          else
            "(#{value.join(", ")}) "
          end
        end

      where =
        format node.where

      comment =
        node.comment.try { |item| "#{format item}\n" }

      "#{comment}fun #{name} #{arguments}: #{type} {\n#{body.indent}\n}#{where}"
    end
  end
end
