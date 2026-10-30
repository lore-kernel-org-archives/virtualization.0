Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360882;
	b=kuY07Ad0zEvGNlGGRvXx5Pj7x89QObwXd/25vFyXKfc+Wz//G1VHOMoT0QHK2xsv16Yw
	 a1wTSr1zb03s/PUBn5ANy1gVkPqNe6dDLZo9t+i8iUbi86ugwF4pzPUUISr+8x0sIHBrx
	 NL0LUGSbK2+fEbGK8RAFNizEoR8bWBYfWJYT+aeWBcwqyRDRENMxIJzBfPcJzHM9+Jva9
	 dWUoxDjAz5FhE9mHqGWiId97OVb35p6uDpZ+UH+TLtkov0BhV3ydT/+28ZmBxtwUX4lPV
	 bBt3+Vy8PGbxgnbvq/LUAPMiJYZVkCU2WfN8XUhcCIxu7GEm973PlKsgcowu9t+ZIVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360882;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HTeOB6YV+jgrF78grOKOC7Crho7VfrzZEJy4NurXtKM=;
	b=JbSWPY3iwEBFWPyiAlcQ30uKKG5FOv3Ez/Q0fPLNW2NTGyF+ymDTkBCtgHcqcho9ZXwz
	 BQ2qvl8BZiGIQTqXhrLVK9GNnrtM/FHsahHsY33RfUmZpVxqNGiCNLbHi7y4eR2nZdXLh
	 urQj2Ij2FhBy3BFOxgAQOaAOOc22IpG53KSItBnQBr652o2OyHEJQrx8orkWBRVa6APcr
	 l1wk41qriXfa9OCgPlOtMzlA0iZ/CkfLvE5ud+2skzeJ4k6WIV2Sf/MFQC/xJoibDUdch
	 rF7vXSjc0EI1eNvzz7yD9oIUGQKpwWcfZIeVv4tJF5cxvEIbC2Z8bljRIful2s7haVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iapwY4Rv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.32
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E005606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 11:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E005606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iapwY4Rv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhwDDaV38d4zlrWa2SzK8cFBvOPC3fBxoxbW6o8Q2oWm6Zwk64u6e7T+IzZsdPGwhxn+SMuaoN/VwvDo3ZxAcG2gWmWI7Y0eBC9LzSAFq9EaggqDkskYY5DMObjk+kvg6r+OmbLzPXPQU0rrG57Y525gTmDMBEY4L963pqlx3rI7BgZmO8aCCMszbw14W3ww8xfIkcr6ElSAlIIifaTaNyFXQ5Jm8XR4pSKPjwYtrOpXjCqcDVHtQJwS8glm5s0QcoZI5nvrL4+4UgglsuTN/9/Pr3BSw9FqvFosjmjUGIYarIHPBvglXp8nVmlN2HllSODLokt5CylIfLfZZrrJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTeOB6YV+jgrF78grOKOC7Crho7VfrzZEJy4NurXtKM=;
 b=tuRSdnaJcK7JlTfirG+QaDL/A99RdOsQZsPgWaLWp32fQVnZGE2QcMu8bQsN6uOuPSHkPTPWyjkFwa65MqgFIbpabJAVGjVMAWGsjJn98hbPowB2vGX1lIEuEwpQV7DCoq9nfXSq9gaqJ95pthUD88DKHR3+ogi5AUqoo1kl9944m2k0RdPrpAMc18pLT52GKsgwCSLzV3oCdpa7K7w8Hj6+QFAyy7WjjEsRnJzJGE3TVkh+blKnHBAzzw3JlU0vJpsnKmH8BFy+edYb3bEi3Jq7BGr4Kk+EjKBvp4NgqWAMUp9c7pdYJNd8cq+DprB+KFZFSBqT4VxYHS3uc1QpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTeOB6YV+jgrF78grOKOC7Crho7VfrzZEJy4NurXtKM=;
 b=iapwY4Rv7Zh2QKL9PoqBs7UXaHgNJ7uLTMuo3BPhJF5R5r/8p4DOlVLM7BsHlgSabP5LsGSRB+M3/rK4qhtewwowNx9h9b/EfsbdAUUmb1u36jlsME1VjSJ8TdDBhgJUxxs+gL6FnPLMp3NlErQ3s9TsRb7gPMuGWmeR94Xf1k+rxx594goHCFJSl1nh9IhSIbQ92NtZ0DLHu2jmRTDo3y0zvlXdWDmjcsav71eT6rwMu03Cmk0ovH7MAJ9vbzwb8E9akJ8xCNoDLk/R0gqh9pIkc4xLqapjOFganPAJMVrntrVhtJZAOKLfoelYkB8mYEIpcjjWhurW+ip9oikhKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB7571.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:47:58 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:47:58 +0000
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
Subject: [PATCH net 1/2] net: pass the XDP action to generic_xdp_tx() for tracing
Date: Fri, 30 Oct 2026 13:47:52 +0200
Message-ID: <20261030114753.185281-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0035.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::18) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 5ec29c31-12c3-42e6-65c9-08df367ba46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Q9Gt8zAuZyNqKaZjNdYqeHr5T9ccXwdd1b7WoszetLb7Gtw1BZTArhGIDIbP/UeBx3f38gWKa8vaW3c+b+LtgYeyRVfjhlYkFBCsGrl0hVUzjtUTJB1lDkv6SjuScDxxKKHPmQ+/IID141AwToVUlrEImbu+wuan5zZs74+TBXeo3GbgbHlrKiqcek1Y7Yyi7f+Fcq+vbRmzNZoaOfFyBlQLCQr0JLo2LXNIVxsZ2kCq85p5juB7QWEStt8ByVAUNVuBcqKEPmLldGDU9SzB4+QM1b4Db7DbqpYiCNUkni/iwZcnkEEdN1kmL2t0W3BMtOgfpTWTkzPsBUX4d8tsg/D3qjDdsaDb177QtQ4LDxKajNgDb0BEFroN0bt/QgkRaBJ4id6Kg8EZCMHUCN+us958nSkr/8LmHcGyCGW2unV2EnvJHEC7S8sL1SzzDH1Z2QZnR+JHdQN0jWH10iZSTjTuW5hfMjTGXfZnl2mX/f7UhOHZ9qe7PQfZ3ZhXTJ2gdr8l682jF4cVHA5fvESZyP8n5QrqABI8ivtWEMEXKft0WOlA7f5bn4oU3MoeQ44ih2UCGArRjBwrR9ei2wzg5R5X++ljhtYKv82beWPlPPe7jWfUZaiQDCENiVIi2/MAMvQ49SbcB+1gpHT14/dcAXSWouXB/7JTc7bH79XxYws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmmIMSi0zVFcx6qP/aLrns9UhK9R7CnkjFuNmxsCGHnF07UiVlQio7cnVfS0?=
 =?us-ascii?Q?AcaO+0u/ojIi4RIR6b4gMaXwtmiBmtSukJPBM/HwaolRrOqhTNwI1q4UNIeB?=
 =?us-ascii?Q?hDdIwl7uvCi7BdcGqXDypI7gJpsebnU/jTAwd86CDoAYAeS1jiEG8yuLdsbI?=
 =?us-ascii?Q?630zsk+bhpxDtEofZ9jpMOi84pK0efEc+L4+YLyPcubXzQdUOLmwgcdnFjPX?=
 =?us-ascii?Q?F7vKvac17G9BjHrQ1lZklbTpDs1VAt4BEi4dxatcn/qoZVnvcm7+7o8pe1Uu?=
 =?us-ascii?Q?GkN3QdD6mIf24v4SvFOYbe1Vd61eINGB+Jr6XklzjRGz9o9jgbGhZ4zEheCv?=
 =?us-ascii?Q?65saLlIabaV2uGRmekm3RljjG9TbHCKFw68e1w85zDtjS0/c5zaS9QgktNHA?=
 =?us-ascii?Q?Ag45ShSaXfZZ9BGWx2qZ1mai0nesj+cfXo8t3xqfbBn+NxuteEXlwhCHb5Fv?=
 =?us-ascii?Q?Scs43/zmEtANVFMBnKMUDI/MTQzghfr8/lJtfOhytmT3SPidWVXQbOXJ3xoc?=
 =?us-ascii?Q?tCEEuah7Z40K5ury3JFB88ZI6+uhtSvA2c3Il85M0ftyOuZc4F22ZvIB0eeV?=
 =?us-ascii?Q?bUqVw1sUSkgPpSWVSqrdcdcMDHiNrywl0NW/xkIPAYT/UfXweWn5fzZggbn7?=
 =?us-ascii?Q?dZXABSxqSQ7ggqGJKIHV2C0vN9LC5uw2rCFoU+TgZmGHXplKdhKVXpsOs7wz?=
 =?us-ascii?Q?Q1WFMxFnTtaMq9zVsJ9+eZC7T7MKyVZBXOoLjD2pRkMdUnAETd9Zs1L3ety8?=
 =?us-ascii?Q?BUunPrlDrz5twVySZGk9R0kv3fKDES+hlYKfpJ1E3AXlI2e3T8xJcg/43KEr?=
 =?us-ascii?Q?9Thwe0mmWavkT5cpkWK6J4x2KmeAWbU/jpTRKxTB+vQyOFapxiP9CNLod9d5?=
 =?us-ascii?Q?iqaZt/qAfy1W5zH+l45th1ewkDACkzmKfuig1KW0hLvCM3QSa+5+gS7Vs78B?=
 =?us-ascii?Q?akJlktIpE5GiIruofaRkpXIqZ9NHpBiEC6V/D0ktM2KRU3EU/jnQsU6LIS2q?=
 =?us-ascii?Q?e8uC6WXL6LmoIZPbMww2EKMVUHj4YvdjdxaqTTWoUQcWZ9mDQTh8wtZfgC10?=
 =?us-ascii?Q?YJ8ODiso4zfOWEjVkTnIOpZwga2C99ilnMnihd5/ftzWvm82je0xRdVQaZ5M?=
 =?us-ascii?Q?ZmQedjgDkZSPopPzOQy2OENnJFe1tmlV0iKx4KNUciWrJOwyhKJ1XrBB33PA?=
 =?us-ascii?Q?tMdDBkO25ePuy+xz4k8rnpSa4ypJ5v8Dv8uSlHwXmCtmhDWHID3Fbvb5Wwtd?=
 =?us-ascii?Q?izpIwSQoiFVmNTHp/GzA37dAny1pcU0Q3M1eBDKp+MkrtAp7q/kWSgbXveSA?=
 =?us-ascii?Q?hzfexnnfZtmihBxm9uKUsY7v95t6OlKuz0WSR2TusvPl0dES2R8gGrGTqO6P?=
 =?us-ascii?Q?X5q1H0rlQku6/UuOEebM3cRf9IyGBSU8+3UVNG1pfxns4WHrRhzSiYvg5G0L?=
 =?us-ascii?Q?7ld60+QHQvoldvu9URneDCoddALuakLFWqiXotTNrSOHYSMlfGwmItdm0jaZ?=
 =?us-ascii?Q?LTCEL7ANLOrvryBQxqA4GI8Fy2lkdxPb4g6GdzISpwfdIvVRTzdFdxY91l/D?=
 =?us-ascii?Q?N0rnQ8Q8ANJg+3HoyWQR6Mp1xuJLPiK0ZUndVOkcCBZVRc3OvtwS7hOUwur9?=
 =?us-ascii?Q?LmWdnK6eU6Fxz5ErTHJBixLXnIgtcxzy62uOTDAqADQinJPdX1arATnv+v/S?=
 =?us-ascii?Q?k2fNA9b9bFJ0eGCZb8FVEClC2k+4bb6hdz1QURzBfKCTE7RFChEwPr2k0Vvj?=
 =?us-ascii?Q?cLH+KUPyVcBZBWGeU2myzsBSfLnijC8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec29c31-12c3-42e6-65c9-08df367ba46d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:47:58.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9AfYLyKpwYqxRnMMhTCaHbisp0rKbCUv5HJ28igpsWeyl6fntZdEk2FGjWCCzye37Yv6jbb2dMrjsiRp7Z/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7571

When generic_xdp_tx() fails to transmit an skb, it reports the drop
through trace_xdp_exception() with the action hardcoded to XDP_TX.
That was right when generic XDP was added, and XDP_TX was the only
caller. Since then, two XDP_REDIRECT paths have started to transmit
through generic_xdp_tx() as well:

- xdp_do_generic_redirect(), for a redirect to an ifindex
- dev_map_generic_redirect(), for DEVMAP and DEVMAP_HASH redirects,
  including broadcast

Drops on those paths are reported as XDP_TX, an action which the
program never returned. Tools which count xdp:xdp_exception events per
action, such as the samples/bpf programs built on xdp_sample, therefore
attribute generic XDP redirect drops to the wrong action. Drivers with
native XDP already report XDP_TX and XDP_REDIRECT drops separately.

Add an "act" argument to generic_xdp_tx(), and have each caller pass
the action that led to the transmission: XDP_TX from do_xdp_generic(),
XDP_REDIRECT from the two redirect paths. generic_xdp_tx() is not
exported, so these are all of its users.

Fixes: 6103aa96ec07 ("net: implement XDP_REDIRECT for xdp generic")
Fixes: 6d5fc1957989 ("xdp: Fix handling of devmap in generic XDP")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/netdevice.h | 3 ++-
 kernel/bpf/devmap.c       | 2 +-
 net/core/dev.c            | 7 ++++---
 net/core/filter.c         | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344..b988afe797c3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4355,7 +4355,8 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog);
-void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
+		    u32 act);
 int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 1b8f0d7f8455..c73e8797c0fc 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -731,7 +731,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
 		return 0;
 
 	skb->dev = dst->dev;
-	generic_xdp_tx(skb, xdp_prog);
+	generic_xdp_tx(skb, xdp_prog, XDP_REDIRECT);
 
 	return 0;
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..88860185f583 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5851,7 +5851,8 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
  * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
  * queues, so they do not have this starvation issue.
  */
-void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
+void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
+		    u32 act)
 {
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
@@ -5868,7 +5869,7 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
 	}
 	HARD_TX_UNLOCK(dev, txq);
 	if (free_skb) {
-		trace_xdp_exception(dev, xdp_prog, XDP_TX);
+		trace_xdp_exception(dev, xdp_prog, act);
 		dev_core_stats_tx_dropped_inc(dev);
 		kfree_skb(skb);
 	}
@@ -5896,7 +5897,7 @@ int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 					goto out_redir;
 				break;
 			case XDP_TX:
-				generic_xdp_tx(*pskb, xdp_prog);
+				generic_xdp_tx(*pskb, xdp_prog, XDP_TX);
 				break;
 			}
 			bpf_net_ctx_clear(bpf_net_ctx);
diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a58c82a..7c6f8bcc6c29 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4821,7 +4821,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 
 		skb->dev = fwd;
 		_trace_xdp_redirect(dev, xdp_prog, ri->tgt_index);
-		generic_xdp_tx(skb, xdp_prog);
+		generic_xdp_tx(skb, xdp_prog, XDP_REDIRECT);
 		return 0;
 	}
 
-- 
2.43.0

