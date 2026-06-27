import SpriteKit
import WiPetCore

final class CreatureScene: SKScene {
    private let creature: Creature
    private let creatureNode: CreatureNode

    init(creature: Creature) {
        self.creature = creature
        self.creatureNode = CreatureNode(creature: creature)
        super.init(size: CGSize(width: 330, height: 330))
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(creatureNode)
        creatureNode.startIdleMotion()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        creatureNode.position = .zero
        creatureNode.setScale(min(size.width, size.height) / 330)
    }
}
