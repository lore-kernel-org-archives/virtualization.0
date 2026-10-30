Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360883;
	b=j/qozuQrduPVhTHL3C8afpuerqm4aUzXOhktW/XM51t7a64XqErBedsjGsvrH0TqxS08
	 lrFemJQNPcKSgESlZ4j6396XKkTBq1a7PSfxsMIVdBP/LWaejVs2Dr9pUUqYQC2Vv4ifr
	 4xWyANxHxVUPO1NyKEJaVoUEzC1WBQTLWAWarh2uc4Y89zSe0Mm8ZGxZOGG2a3jKTSt2X
	 RSzmxFUKW1X1Lyrqr1wDhPDbq4OQdzv5yG2IHhdFXChEam5e/alca+1CEhNOf9BYlv+8F
	 vrfr8weZnUTNJQzOILpjGOjDTMWRmNLSX6asnEhjhX0QP5T2qqM6Gjv4OlBU73Fzwyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360883;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FaeWdf7e5Egut/c5IuAOn2eUd4cxFgsEduxFwA8k3v4=;
	b=p6iSdPqRmPDLzAEBtmAJn4uSNXWXaZ/fDHfzDDiv36ctBYqgLSbkbQiaza80kLv9GOP/
	 djshKqFuSLOVbxqEtcZ9Wwc560UXMSZ4kfVj3ck87GuC4LUlLvM9OfKmaTOAgPSh+Kvkk
	 na8Zd8pC+RP9FHlc9iVco/pCSF7m+1Y14Z790LKT07gqUj/KqUYiM93jMLQoiwTqFNaFD
	 607CIaHdI95PBMyS6uk8aIFTKAo6vkpI3P9qN6F0xzzU5nKR31s/v6oA/jy9OQO8jX6Q+
	 26yvGu8icDqJcX230YM8htV5CciE8XAOW9cjG+NmNWt2C8Mgynq4J2VsDI8sYE4HJCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JJZNNOsp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.32
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2F606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 11:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EE2F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JJZNNOsp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8gCKB8A9Tx4mHKG971X+71q46qUmPoIX6MXyXA43VZaHk3+ArpOvsyT2+BpNPoj8htfVe4h7w6ieG874cV7mYmkyZA+zWKc7A3hjOqWC4TzLcS6kJxvY5oTMQLY+gTtM+MHml+N9iJ9o6zGT0VSeCjXZ/aHZaIrMXixsn7OofvShpdkPnMNjdFQ6diuHlEhHlYkF/cRCTxkVAYXjIicKiXeH9DOOTv2F7Z94yzYc74RvOTqHfKtdGA1UVjGCG+xyrfokSIfGCNmr2zOFUA59RmcdFt1saSmdfnkoZA/HDBA94QmCh+STVVlN9CG5VU9tfhBw38LGmgsud3Z7zCktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaeWdf7e5Egut/c5IuAOn2eUd4cxFgsEduxFwA8k3v4=;
 b=zUlw3c2cM/LXCEuW6Y9g5lwUOdU8n4MXYEIypAkKCJe1zguSgdPH67/qfxTqP4WRRjjjarXng6Bdqc4Y8FhsttvH3L3h8oyWVRX6hKXZ1iKZBvOPa9/fQBjK6v2A95kyUrdTQn8L7sfrOtK1egd0/eOhJEeJ8rTm0saqr+UhSRWr+0DXXIWNKEXKKxDZUdh0AwXuNkRW/85SS/W0ijn/WaZMtmQkogNGJxTfIi14l8zJXzXKVMIbuQINEPKvw3SZoPgHr7xqzPQfOJKbSvOaDVZvKm8mOtAtzy92qZ9ic0fT+RxNwRg1AjmxcD/p+lWW913B0W+ak2nUdwMTIo+QoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaeWdf7e5Egut/c5IuAOn2eUd4cxFgsEduxFwA8k3v4=;
 b=JJZNNOspyJECsuvBhZjMVr/phbCGJngh3S6zA0V8FKLykNZNdFjer8pBzdo+AQTl8hCPRgSqybcRUeTkJprkhTeDWsBXBHMQ3ep40t8leqILbns+O7LbvVG0R6horfgYAU5e30ZKoUcPKWA18FOrKyJCVlvdNN+26qxwl3xChRR2DJTCw5VqkckjcB7Oxl7dr8HgwNQ6jcBUUV3+gu8m2wYfwksaleO03r2AojPLMSlNOEaG7tdw+qrg7HgJzhN3w3lQho5DTBpdiIuwWkfPRGsGrXbCjcK4kybaRqd8fvFbFedY4T6dFvtS5sC37ItW+P0SMh3soveNt04U3hKAWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB7571.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:48:00 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:48:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net 2/2] net: validate xmit skbs in generic_xdp_tx()
Date: Fri, 30 Oct 2026 13:47:53 +0200
Message-ID: <20261030114753.185281-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030114753.185281-1-vladimir.oltean@nxp.com>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P309CA0023.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::27) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM9PR04MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c8de00-9476-43a1-38da-08df367ba585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|5023799004|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021135927099003|261021121427099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SpzUU8wFGdwYltNk5cDUUzViUc6O78x5TqQvXeJ/c9HxUGv9SdIJxo9POL54WcIGfrLFJry5WXZeobU3KHDH8+r5mCCx8YVfw2wEUcZZmI7qprW1rwwxE0RGvzHWPly+tW+4xkLf7ijTQNF/uZgciBKuGrjyupf5kVXdcOqxXz97TCtAw4frrh8KL6L9mnPTMCsXApp/vpgQm8e+vgORCDoIwWoYuKy+RGEtHPdy615QC2FPlAvralvjKd7dDqN40bLvH31YG81PyOPHFKixGuEKmsmRoypZ0zzInU/AlEyUhVTEn/ze7duwRa97UEb4IzfFvrchqIjSHx93T5Kx5ZhkvzVlynciCj+A4JcNVku+FyPK2NkVFEQseLwEC5FSRl2uGjAkdYn5JwPhLIuhAVhCAUuHYa3AS+06iA/oj3e1MiiVCOnyUJGLx7Y1Jslyr/k52oT6QLMKoYN28isiUBHTVHbobUQRWQHU968fAdGtVjVjI4Zvu3oqxjT2+jVMarFGDdRM3ymKVn2JALhEiu8ne12zF0HzjZo31md786hRpTUz8SZWooiZ3KCLMmTH+dCvFHRj2qk9qBiv5V22D/o9zNQddiboZAOy5FDQeui3gVqzJ0QIfl4O1aZpg563m1Kb6ayQ7GKnET3K3ssRQ4FrtYGmFhlb9Q7Le8yjUjc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gGHPcSnD0emN0fxpcSi/5h4t9IMXHNR8rmNvgxcJC/v3n7zoveAGEeM9mr7y?=
 =?us-ascii?Q?gbKY0Qz/4hJaoy1K7g6cm7dJG3Btr2yyXu/TDrUBlRDnavb098ccys8RukLA?=
 =?us-ascii?Q?KZv8jJ3CxRaoUAYVauxEleGcKYNUeM6nWpOo4PfzKSXKheAn77UTvnM/jbbf?=
 =?us-ascii?Q?CzEPAF/VWcFuUW7NgtQZ8uIjeW25ZM//MJbxO64dImayAi/Mlmfj9HBUjGNE?=
 =?us-ascii?Q?CJLBO5aBdoQjltIMUbRcQl+c9hc/9kgfNO48BeJYpRLrIiumeaooXDrgoYWc?=
 =?us-ascii?Q?JXTOU4ZFLcOFjTtMis6RcqexJWhHar5BFZDXlrKkqlYYGO7CscCftVOG/PFk?=
 =?us-ascii?Q?mIucIxuDDKTr/2tzpYeFS4UpVu5jnKO57Kq/FwfzNgXurGnhzfMdNlw5svyi?=
 =?us-ascii?Q?vlMz8WTLRsskum16mETDIjTx+1ydag9J8hgmaPk1/wr6lBgZg8ep3NJo6bnj?=
 =?us-ascii?Q?xBAtBww37AirFmDbXneVyHYL685GnyaKnhZimErLpnz4+UMlBP12kmVywGbm?=
 =?us-ascii?Q?+yzyPjyF2n6lxn/ycp5jadJOPOANL72u+As1hGNfnGdywTPjms9i59jYCQmP?=
 =?us-ascii?Q?vpJT7q8v2hVlqb7FEgS649FpIbkzmHwZurSLJ3/IQpvV+x11tBRYjW5GiTRl?=
 =?us-ascii?Q?ZR+UVS3XgXvyDdweQyO9+LLesS0S/Zzx8Yw1PsUpUtt8yRLfyzOmfKVUn5HC?=
 =?us-ascii?Q?hg9VvqYQd+utO4mJfQyzi2IJcS1iDqtho4XecTIfyZghQlGLRdz+yUNTrCU+?=
 =?us-ascii?Q?yZiBJozuxYI6ye8Xg2hsX6g0ho/Fb7KrWiPayR/MaYxJJcLfIVrnhJ8QqtHE?=
 =?us-ascii?Q?hbFx9GRWHUm6tN3RgQg1R0Zu89dfO54UuDuOpO+2PdWgCkO2WABpx8eBYxse?=
 =?us-ascii?Q?MSK9xYKpbGTRmlcaMB7lvhpxm2MSOp2j8xOgtwM4FsvLA/dMZseRfMmwsvid?=
 =?us-ascii?Q?UWXm9V8YVJ3lVVF/4neCD86T5ULQd1MD1SesWTBN86yWUx4NuhPASsQ1Mo/9?=
 =?us-ascii?Q?Op+oobE+0inkyzSs8LHji1CXPxMcQPxV8hlF5gO7gcPWZMuv9QbVxDhxQqUp?=
 =?us-ascii?Q?zWevFrpISY5rNHq0NTpDKrlcB7AlA2MZ1wgffpRV7Blhfqjp/JdAeV9ibx5Z?=
 =?us-ascii?Q?IoMlgNbjp0G5MIzOVoW7GPYzbl8lMborTq0nHxbwDTMN0igFspCVrnGeX2G8?=
 =?us-ascii?Q?uu+WdLRmDr5cTXfp5aIfKlD0EEF/TYfSujbnLNqjwDm2DyN0Xg4p5oBBXKsX?=
 =?us-ascii?Q?FNaIx+32b4w2leHgf8yd2lxrDJAw0kXX2hUSEu4xPCZ/en1yPprU+fSSyp3Y?=
 =?us-ascii?Q?DUv+LxGRtoMfNPr+KHRmPBR5IZABoUQBSVR4Q1liKVAEXIbabZtBUwjpZphP?=
 =?us-ascii?Q?goucm98AYUOSFQJ03bqOzZ3d8nWRNbDhYlBMypEr6X930j6jAOlKK/FxFvP5?=
 =?us-ascii?Q?K6MvrPFm7a9yh4JnRwV8eOcgnOa5l5rn9Rd4HkoXiYUQ0IC/I64h5lOuExoV?=
 =?us-ascii?Q?5l9BCw1ChL0VIUfeq7H/asOF2qibSHehKmyYL442eYSik+TgqW9LBU9VkP50?=
 =?us-ascii?Q?0rIVN2ko20sZEEsrc2R5GLKCVs7lWqvUi0n2lyOOI5uIX8kM+m6YTIeMun6F?=
 =?us-ascii?Q?9lirjGz+lkpWzmPqibq8BVWb93zpYYZg1Bsm3P4XJAnqyyv8sZfqexlylRZS?=
 =?us-ascii?Q?HPHiEwKhppTPvolpApWn7zA4F95Ggy/Nf+Ip4M+SI47TmXRNs5Jh+JrgRE7h?=
 =?us-ascii?Q?urAzxsa6Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c8de00-9476-43a1-38da-08df367ba585
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:47:59.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6KHnUgydIi7GsdMPQwIRpsoxsSzVTTn7k/k8P6nubUCxoYU9CmKXgFCaQRd+uWQcDhAB6jiEicdx+BosdWE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7571

While auditing the limits imposed by the network stack on the number of
GSO segments, I found that a GSO super-skb can reach a driver's
ndo_start_xmit() with skb_shinfo(skb)->gso_segs set to 0, contrary to
what drivers might expect. This involves SKB_GSO_DODGY, and can be
easily reproduced on hardware.

"Dodgy" GSO skbs are skbs whose GSO metadata comes from a source that
the kernel does not trust. The main producer is virtio_net_hdr_to_skb(),
which translates the offload request in a struct virtio_net_hdr into
skb_shinfo() fields. It is used by tun, tap, AF_PACKET with
PACKET_VNET_HDR and virtio_net on RX. It only does basic sanity checks
(csum_start/csum_offset, gso_type, a minimum gso_size), then sets
gso_size and gso_type, adds SKB_GSO_DODGY and leaves gso_segs at 0
("Header must be checked, and gso_segs computed"). The rest of the
validation is deferred to the transmit path, and the "dodgy" flag
stays set afterwards unless the skb is actually segmented.

On the dev_queue_xmit() path, qdisc_pkt_len_segs_init() already
recomputes gso_segs for SKB_GSO_DODGY skbs. After that,
validate_xmit_skb() decides whether the xmit netdev is capable of
fulfilling an offload or whether it should be applied in the core.
For GSO, skb_shinfo(skb)->gso_type is verified bitwise against the
netdev features in net_gso_ok(): SKB_GSO_TCPV4 against NETIF_F_TSO,
SKB_GSO_UDP_L4 against NETIF_F_GSO_UDP_L4, etc. For the SKB_GSO_DODGY
gso_type bit, the corresponding feature is NETIF_F_GSO_ROBUST, which
means "give me the unvalidated super-skb anyway".

When the xmit netdev lacks a feature corresponding to a set bit in
gso_type, __skb_gso_segment() is called, which dispatches to the
protocol's net_offload :: gso_segment() method (inet_gso_segment() ->
tcp4_gso_segment() etc). Physical NICs do not advertise
NETIF_F_GSO_ROBUST, so for them the SKB_GSO_DODGY bit alone is enough
to get here, even if they support TSO. tcp_gso_segment() and
__udp_gso_segment() then have this code:

	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
		/* Packet is from an untrusted source, reset gso_segs. */

		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);

		segs = NULL;
		goto out;
	}

This fixes up the gso_segs value and returns NULL, which means that
the protocol did not segment the super-skb, but that this is not an
error either, so execution continues. The "dodgy" super-skb reaches the
driver's ndo_start_xmit() with a valid gso_segs value and gets
segmented there or in hardware.

Generic XDP skips all of this. Instead of calling dev_queue_xmit() or
dev_direct_xmit(), the XDP_TX and XDP_REDIRECT actions end up in
generic_xdp_tx(), which calls netdev_start_xmit() directly. There are
three callers:
- do_xdp_generic(), for XDP_TX
- xdp_do_generic_redirect(), for XDP_REDIRECT to an ifindex
- dev_map_generic_redirect(), for XDP_REDIRECT through a DEVMAP or
  DEVMAP_HASH map, including broadcast
None of them validates the skb against the features of the egress
device.

A process can reach this path by write()-ing a struct virtio_net_hdr
followed by an Ethernet frame to a TAP interface created by tun.c with
IFF_VNET_HDR. No virtual machine, virtio-net driver or vhost-net is
needed. Creating the interface and attaching the XDP program require
CAP_NET_ADMIN, but a persistent TAP interface whose owner was set with
TUNSETOWNER can then be written to by an unprivileged process. When the
virtio-net header requests GSO, tun_get_user() does not run tun's own
XDP program on an xdp_buff. It builds an skb and passes it to
do_xdp_generic() instead. vhost-net reaches the same code through
tun_xdp_one(). A program attached in generic mode runs on the same skb
from __netif_receive_skb_core(). In all cases, the program sees an skb
which virtio_net_hdr_to_skb() has just marked SKB_GSO_DODGY with
gso_segs = 0. If the program redirects it to a physical interface, that
interface's ndo_start_xmit() receives the skb unchanged.

The same happens inside a guest whose virtio_net interface runs a
generic XDP program, with GSO metadata coming from the host. virtio_net
only disables guest offloads (or refuses the program, if
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is not negotiated) when XDP is
attached in native mode; a program attached in skb mode keeps receiving
GSO packets from the host.

macvtap and ipvtap (drivers/net/tap.c) also accept virtio-net headers
from user space, but are not affected. For them, a write from user
space is a transmit: tap_get_user() passes the skb to dev_queue_xmit()
on the macvtap/ipvtap interface, where qdisc_pkt_len_segs_init()
recomputes gso_segs. Only then can the skb reach an XDP hook, for
example when macvlan in bridge mode forwards it to a sibling interface.
Their RX path also runs generic XDP, but only on skbs that the lower
device received and handed up through macvlan_handle_frame() or
ipvlan_handle_frame(), before tap_handle_frame() queues them to user
space. Similarly, an skb that has gone through __dev_queue_xmit() once
(bridge, veth) normally has a valid gso_segs when it reaches generic XDP
on another interface.

The impact depends on how the egress driver uses gso_segs:

- Drivers which do software TSO and check for TX ring space with
  tso_count_descs() (enetc, fec, mvneta, mv643xx_eth, mvpp2), or with a
  similar gso_segs based estimate (thunder nicvf, octeontx2), compute
  that only nr_frags descriptors (or none) are needed. They then write
  descriptors for every real segment. xdp_ok_fwd_dev() limits skb->len
  to about the MTU, but gso_size can be as small as TCP_MIN_GSO_SIZE
  (8 bytes). With a 9000 byte MTU, enetc without hardware LSO needs
  2240 BDs for one such skb, so it overruns its 2048 entry ring and
  overwrites BDs that are still in use.
- nfp with the NFDK data path programs gso_segs into the TX descriptor
  as the total segment count, and sfc ef100 treats gso_segs == 0 as a
  non-TSO packet.
- igb, igc, ixgbe, i40e, iavf and libwx compute
  "bytecount += (gso_segs - 1) * hdr_len" and count gso_segs packets on
  completion. With gso_segs == 0, the TSO packet is counted as zero
  packets, and since (gso_segs - 1) is -1 after integer promotion, its
  byte count is skb->len - hdr_len. A completion interval with only
  such packets looks idle to the adaptive interrupt moderation of igb
  and igc ("packets == 0"). hns3 uses the same byte formula, but counts
  one packet per skb.
- Drivers that use gso_segs only for statistics and fall back to
  "gso_segs ?: 1" (e1000, e1000e, igbvf, r8152, lan78xx, ax88179_178a,
  be2net) count such an skb as one packet of skb->len bytes. This is
  the same convention as the core uses (qdisc_pkt_len_segs_init(),
  ip_select_ident_segs() callers): a gso_segs of 0 means "not filled
  in", not "no segments", and since any transmitted skb puts at least
  one frame on the wire, 1 is the smallest count that can be true.
  These drivers undercount, but the result is still a lower bound of
  what was sent, consistent between bytes and packets, and their
  descriptor use does not depend on gso_segs. Such a fallback would
  not help the software TSO drivers above, where an underestimate
  causes the overrun.
- Drivers that pass only gso_size and gso_type to a backend and
  advertise NETIF_F_GSO_ROBUST (such as virtio_net) never read
  gso_segs and are not affected.

Two places for the fix were considered: the XDP_REDIRECT callers of
generic_xdp_tx(), or generic_xdp_tx() itself.

XDP_TX is not affected by the gso_segs problem, because it transmits on
the interface which received the packet. The only interfaces whose RX
path hands generic XDP a GSO skb with gso_segs == 0 are those which
build it from a virtio-net header supplied by user space or a
hypervisor, such as tun and virtio_net. Their ndo_start_xmit() converts
the skb back into such a header using only gso_type and gso_size, and
never reads gso_segs. Physical NICs do not produce such skbs:
generic_xdp_install() turns off LRO and GRO_HW, and GSO skbs built by
GRO or by software interfaces like veth, lo or macvlan have a valid
gso_segs. Validating only in the redirect callers would therefore keep
XDP_TX on its current fast path.

However, validating in generic_xdp_tx() is still the better choice:

- Implementation-wise it is easier, since it covers all redirect paths
  at once. The alternative would be to add separate validation paths in
  xdp_do_generic_redirect() and in dev_map_generic_redirect(), which
  both call generic_xdp_tx(). There are also challenges to validation
  placement, which has to be done after skb->dev has been set to the
  egress device (which is already set properly in generic_xdp_tx()).
  Furthermore, generic_xdp_tx() is the only place which already
  transmits the skb, and so can handle what validation returns.
  validate_xmit_skb_list() may segment the skb, or free it and return
  NULL. If a caller validated the skb and it got segmented, the caller
  would have to transmit the segments itself. If it got freed, the
  caller could not report an error either, because do_xdp_generic()
  frees the skb again on error. Inside generic_xdp_tx(), the segments
  are transmitted one by one, and any left over when the queue stops are
  freed with kfree_skb_list().

- Validation is not only about gso_segs, and XDP_TX benefits from the
  rest of it too. With IFF_VNET_HDR, a tun interface accepts GSO
  packets from user space even if user space never enabled TSO with
  TUNSETOFFLOAD. XDP_TX on such a packet currently sends it back to
  user space with a GSO virtio-net header, an offload that user space
  never said it could handle. Checksum offload has the same problem.
  Validation fixes these cases by segmenting or checksumming the packet
  in software when the device lacks the feature.

So do in generic_xdp_tx() what __dev_queue_xmit() does before handing
the skb to the driver:

- Call qdisc_pkt_len_segs_init() first. It recomputes gso_segs for
  SKB_GSO_DODGY skbs and drops malformed ones. Without it,
  validate_xmit_skb() would compare the untrusted gso_segs = 0 against
  dev->gso_max_segs in gso_within_dev_limits(), and the check would
  always pass. The protocol's gso_segment() would then fix up gso_segs
  without comparing it against the limit, and with a 9000 byte MTU, a
  super-skb with about 1120 segments would reach a driver which set a
  lower limit with netif_set_tso_max_segs().

- Pick the TX queue before validation, as __dev_queue_xmit() does.
  netdev_core_pick_tx() doesn't operate on lists, but setting the queue
  mapping of the super-skb allows segments created by validation to
  inherit it.

- Call validate_xmit_skb_list() and transmit the resulting list. Each
  segment is passed with more = false, as the single skb was before, so
  drivers don't rely on a later call to flush their TX queue. The
  "again" result, which only xfrm offload sets, is ignored, as in
  __dev_direct_xmit().

Drops on either check now also fire trace_xdp_exception() with the
caller's action, like the other drops in generic_xdp_tx(). Network taps
are still bypassed, as before.

Invoking validation also unavoidably changes what happens to VLAN tags
that the ingress device placed into the hwaccel area. Generic XDP runs
in __netif_receive_skb_core() before the VLAN tag is handled, so the
hwaccel tag is still there in generic_xdp_tx(), outside the packet data
the XDP program saw. Egress devices without VLAN TX offload will ignore
it, and the frame goes out untagged. Now validate_xmit_vlan() inserts
the tag into the frame on such devices, as dev_queue_xmit() does, so the
frame is tagged whatever the egress device. This should be the more
correct behaviour, but I only consider it a positive side effect and not
itself worthy of a dedicated Fixes: tag.

Fixes: 6103aa96ec07 ("net: implement XDP_REDIRECT for xdp generic")
Fixes: 6d5fc1957989 ("xdp: Fix handling of devmap in generic XDP")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/core/dev.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 88860185f583..e98d85a53991 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5855,23 +5855,44 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
 		    u32 act)
 {
 	struct net_device *dev = skb->dev;
+	enum skb_drop_reason reason;
 	struct netdev_queue *txq;
-	bool free_skb = true;
+	bool again = false;
 	int cpu, rc;
 
+	reason = qdisc_pkt_len_segs_init(skb);
+	if (unlikely(reason)) {
+		trace_xdp_exception(dev, xdp_prog, act);
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb_reason(skb, reason);
+		return;
+	}
+
 	txq = netdev_core_pick_tx(dev, skb, NULL);
+	skb = validate_xmit_skb_list(skb, dev, &again);
+	if (!skb) {
+		trace_xdp_exception(dev, xdp_prog, act);
+		return;
+	}
+
 	cpu = smp_processor_id();
 	HARD_TX_LOCK(dev, txq, cpu);
-	if (!netif_xmit_frozen_or_drv_stopped(txq)) {
-		rc = netdev_start_xmit(skb, dev, txq, 0);
-		if (dev_xmit_complete(rc))
-			free_skb = false;
+	while (skb && !netif_xmit_frozen_or_drv_stopped(txq)) {
+		struct sk_buff *next = skb->next;
+
+		skb_mark_not_on_list(skb);
+		rc = netdev_start_xmit(skb, dev, txq, false);
+		if (!dev_xmit_complete(rc)) {
+			skb->next = next;
+			break;
+		}
+		skb = next;
 	}
 	HARD_TX_UNLOCK(dev, txq);
-	if (free_skb) {
+	if (skb) {
 		trace_xdp_exception(dev, xdp_prog, act);
 		dev_core_stats_tx_dropped_inc(dev);
-		kfree_skb(skb);
+		kfree_skb_list(skb);
 	}
 }
 
-- 
2.43.0

