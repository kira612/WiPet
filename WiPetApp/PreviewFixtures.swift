import Foundation
import WiPetCore

enum PreviewFixtures {
    static let firstAncestorID = UUID(uuidString: "45B571D6-32AD-4C02-A58D-79941AE5E7DA")!

    static var luma: Creature {
        Creature(
            name: "Luma",
            species: .lunarian,
            genome: Genome(
                morph: MorphGenes(
                    face: .crystal,
                    body: .lunarian,
                    tail: .floating
                ),
                growth: GrowthGenes(
                    tailGrowth: ScalarGene(0.62),
                    glowGrowth: ScalarGene(0.78)
                ),
                motion: MotionGenes(
                    blink: ScalarGene(0.42),
                    float: ScalarGene(0.72),
                    tailMotion: ScalarGene(0.58)
                ),
                personality: PersonalityGenes(
                    curiosity: ScalarGene(0.66),
                    sociality: ScalarGene(0.54),
                    timidity: ScalarGene(0.38),
                    energy: ScalarGene(0.46),
                    sleepiness: ScalarGene(0.57),
                    mysticism: ScalarGene(0.81)
                ),
                pattern: PatternGenes(
                    contrast: ScalarGene(0.44),
                    glow: ScalarGene(0.76)
                )
            ),
            growthStage: .juvenile,
            generation: 3,
            parentIDs: [
                UUID(uuidString: "6A1BEE86-A7F0-47DF-936A-E8E71444362C")!,
                UUID(uuidString: "F0601F74-4A36-4133-9DAD-2EE6DC62981C")!
            ],
            discoveredTraits: [
                DiscoveryEvent(
                    title: "A quiet lunar glow deepened around the tail.",
                    kind: .glow,
                    stage: .juvenile
                ),
                DiscoveryEvent(
                    title: "The floating tail shimmer resembles the first ancestor.",
                    kind: .inheritedResemblance,
                    stage: .juvenile,
                    relatedAncestorID: firstAncestorID
                )
            ]
        )
    }

    static var grownLuma: Creature {
        var creature = luma
        creature.advanceGrowthStage()
        return creature
    }

    static var hornBudLuma: Creature {
        Creature(
            name: "Luma",
            species: .lunarian,
            genome: Genome(
                morph: luma.genome.morph,
                growth: GrowthGenes(
                    hornGrowth: ScalarGene(0.34),
                    tailGrowth: luma.genome.growth.tailGrowth,
                    glowGrowth: luma.genome.growth.glowGrowth
                ),
                motion: luma.genome.motion,
                personality: luma.genome.personality,
                pattern: luma.genome.pattern
            ),
            growthStage: .juvenile,
            generation: luma.generation,
            parentIDs: luma.parentIDs,
            discoveredTraits: luma.discoveredTraits
        )
    }

    static var crescentHornLuma: Creature {
        Creature(
            name: "Luma",
            species: .lunarian,
            genome: Genome(
                morph: luma.genome.morph,
                growth: GrowthGenes(
                    hornGrowth: ScalarGene(0.72),
                    tailGrowth: luma.genome.growth.tailGrowth,
                    glowGrowth: luma.genome.growth.glowGrowth
                ),
                motion: luma.genome.motion,
                personality: luma.genome.personality,
                pattern: luma.genome.pattern
            ),
            growthStage: .adult,
            generation: luma.generation,
            parentIDs: luma.parentIDs,
            discoveredTraits: [
                DiscoveryEvent(
                    title: "A soft crescent bud rounded above Luma's brow.",
                    kind: .growth,
                    stage: .adult
                ),
                DiscoveryEvent(
                    title: "The floating tail shimmer still resembles the first ancestor.",
                    kind: .inheritedResemblance,
                    stage: .adult,
                    relatedAncestorID: firstAncestorID
                )
            ]
        )
    }

    static var mira: Creature {
        Creature(
            name: "Mira",
            species: .sylphian,
            genome: Genome(
                morph: MorphGenes(
                    face: .feline,
                    body: .sylphian,
                    wing: .fairy,
                    tail: .fish
                ),
                growth: GrowthGenes(
                    wingGrowth: ScalarGene(0.68),
                    tailGrowth: ScalarGene(0.34),
                    glowGrowth: ScalarGene(0.42)
                ),
                motion: MotionGenes(
                    blink: ScalarGene(0.64),
                    float: ScalarGene(0.82),
                    tailMotion: ScalarGene(0.38),
                    wingMotion: ScalarGene(0.72)
                ),
                personality: PersonalityGenes(
                    curiosity: ScalarGene(0.74),
                    sociality: ScalarGene(0.69),
                    timidity: ScalarGene(0.41),
                    energy: ScalarGene(0.62),
                    sleepiness: ScalarGene(0.36),
                    mysticism: ScalarGene(0.58)
                ),
                pattern: PatternGenes(
                    contrast: ScalarGene(0.62),
                    glow: ScalarGene(0.48)
                )
            ),
            growthStage: .juvenile,
            generation: 3,
            parentIDs: luma.parentIDs,
            discoveredTraits: [
                DiscoveryEvent(
                    title: "Mira's winglets opened like soft leaves.",
                    kind: .growth,
                    stage: .juvenile
                ),
                DiscoveryEvent(
                    title: "Mira's glow echoes Luma's moonlit tail.",
                    kind: .inheritedResemblance,
                    stage: .juvenile,
                    relatedAncestorID: firstAncestorID
                )
            ]
        )
    }

    static var axolotlFriend: Creature {
        Creature(
            name: "Nalu",
            species: .aquarian,
            genome: Genome(
                morph: MorphGenes(
                    face: .axolotl,
                    body: .aquarian,
                    wing: .jellyfish,
                    tail: .fish
                ),
                growth: GrowthGenes(
                    wingGrowth: ScalarGene(0.46),
                    tailGrowth: ScalarGene(0.48),
                    glowGrowth: ScalarGene(0.50)
                ),
                motion: MotionGenes(
                    blink: ScalarGene(0.52),
                    float: ScalarGene(0.67),
                    tailMotion: ScalarGene(0.62),
                    wingMotion: ScalarGene(0.44)
                ),
                personality: PersonalityGenes(
                    curiosity: ScalarGene(0.71),
                    sociality: ScalarGene(0.62),
                    timidity: ScalarGene(0.34),
                    energy: ScalarGene(0.55),
                    sleepiness: ScalarGene(0.42),
                    mysticism: ScalarGene(0.47)
                ),
                pattern: PatternGenes(
                    contrast: ScalarGene(0.40),
                    glow: ScalarGene(0.52)
                )
            ),
            growthStage: .juvenile,
            generation: 2,
            parentIDs: luma.parentIDs,
            discoveredTraits: [
                DiscoveryEvent(
                    title: "Nalu's wide little face kept its soft side cheek dots.",
                    kind: .inheritedResemblance,
                    stage: .juvenile,
                    relatedAncestorID: firstAncestorID
                )
            ]
        )
    }

    static var deerAncestorEcho: Creature {
        Creature(
            name: "Ori",
            species: .verdant,
            genome: Genome(
                morph: MorphGenes(
                    face: .deer,
                    body: .verdant,
                    wing: .plant,
                    tail: .plant
                ),
                growth: GrowthGenes(
                    wingGrowth: ScalarGene(0.44),
                    tailGrowth: ScalarGene(0.51),
                    glowGrowth: ScalarGene(0.36)
                ),
                motion: MotionGenes(
                    blink: ScalarGene(0.50),
                    float: ScalarGene(0.60),
                    tailMotion: ScalarGene(0.48),
                    wingMotion: ScalarGene(0.46)
                ),
                personality: PersonalityGenes(
                    curiosity: ScalarGene(0.48),
                    sociality: ScalarGene(0.57),
                    timidity: ScalarGene(0.52),
                    energy: ScalarGene(0.40),
                    sleepiness: ScalarGene(0.55),
                    mysticism: ScalarGene(0.63)
                ),
                pattern: PatternGenes(
                    contrast: ScalarGene(0.52),
                    glow: ScalarGene(0.36)
                )
            ),
            growthStage: .elder,
            generation: 1,
            parentIDs: [],
            discoveredTraits: [
                DiscoveryEvent(
                    title: "Ori's soft deer face became a quiet family echo.",
                    kind: .inheritedResemblance,
                    stage: .elder,
                    relatedAncestorID: firstAncestorID
                )
            ]
        )
    }
}
