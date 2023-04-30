Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAE5C77B73
	for <virtualization@archiver.kernel.org>; Sun, 30 Apr 2023 13:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE41081F2B;
	Sun, 30 Apr 2023 13:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE41081F2B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=gGXorwap
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wZdxKDq1sDs; Sun, 30 Apr 2023 13:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D08381EE3;
	Sun, 30 Apr 2023 13:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D08381EE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3BE8C0037;
	Sun, 30 Apr 2023 13:15:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04622C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEBF2403D6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEBF2403D6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=gGXorwap
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBX0WF38xalX
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A053140017
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::626])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A053140017
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRDcyzti6qtMWXHWACBSqZYQ4InxzWwF/QKYWxUNhM30vL3lUe+NIL3erIGXWYQq1WSgY53muMmOAicmRQqmYJ35/XJwwd2E4VtnYnpWAa+BgDPim+iVumBwE7ycZYBsjMMpexY0u7wwtn4a4QE0E9mKQfGkRFPcDt6ADxc9u3Y7Grng0MstG/Pwr7jqqMVzcvjj91wm5WhO/nnKex3/myyFzSGzbwDclk0ACY5f3jiV9bve1aF3LRhLWMZGt6E4lp1wOl5/V+pxhzSpUtSF4RkN1zlrmbWhNQ8dY9Ul8X1FJne0wQx+mfTZdyoBfS1dyU49JbGstfn4t2iHGFHJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P47KgdtsS9Lw6YlKDuzlqG+0mgrZuXRmzmheX8mHZ94=;
 b=Wp7/hkyH12lkiOiggHHNo5vS1od98wat29V6ZMJqIwVIe5nck6fC01EQBhk/JRNJUgtA4+27n6pMaTaEeu9cwGK0L+ZvbCw8+GOyUNldUOCA877vfPsn9+/yBTremro4+qAMjQ/aBtBa+zZy0k3UFA6Bq2aMt2nKTOSTz7Hu33sxhwh1m+tKW/7Vf3VPvF1qYFvaN8a1bHaRls6/02sQeYej5+VJQgfuG3Fy0Cboyk+WuTLAHBaerIjf3WHy/9JaelGgElPOFghHUnzPTQOpwfzV8dZPfNPweeSoexrBJuUpDz4cbwYBV1o+bCYF2yE++hEckZssu4H8XBhgphjtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P47KgdtsS9Lw6YlKDuzlqG+0mgrZuXRmzmheX8mHZ94=;
 b=gGXorwapbMP+aGwjBTNNXV1miTM4s1ZWzlme7OxunSmMVVTcp466Dd0RtoYEYbhL7vFc72XHIxhi5eNUwtvZRysqGgP1ea2TkcvEmufnUdyzzXPemQVHvpsZtlwPIXk7aQv+NEflSPEFeKUWHEXMsuPaYlOlrbWhx7rxtof0kxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Sun, 30 Apr
 2023 13:15:28 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106%5]) with mapi id 15.20.6340.026; Sun, 30 Apr 2023
 13:15:28 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Date: Sun, 30 Apr 2023 16:15:15 +0300
Message-Id: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0191.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::10) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6694bf-ee99-45b7-6355-08db497cf749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFQasYSxOwrAXse/01JWueoMMi2ztfoNhR6fLop5I8HfWqBkleWC2kL+0q1MbANdR7imnn3WA2WeOBEpPFXrfgr5eQVgif+owHHkrpk9tkRTA4CBu284s2eMSGfG0voPd90xOv+KWyeZMYRAIgJ2dzHb2e1Qq1gfTQucEWdlDw1TmqIZ09eNfKDdJBfch2Lr8GwQks20zWaNIqsAwDmgf1ekPVOk5R4ISbqoCOULYrEQ1HTgYhoAtEt3650a1WDRaIpou6pZ0X09Lbw25PL33F5aR8SQBm0bxEsY4J3jXOC00G3T3LYL3ipxudXUH1XUVfXQ3BgKCTcAqokfEw3N8Xmk3Jo3BrvyQeW9+5FgE2werqRcyRh5a70J0mz5r8fhtCAdjaSqIX9WzYLnctZwBViWjRn4VOW68EioiAS0XtHZoqad3pzkb/P8H4LW/TZwpCAXcwh9GPCTID8s0hT1A1HFLMxGSimewhm2xBJIbMOBniHkT2i9+tR5/Wx/ZpEtFX5XTeDKSWbsrzDiM+dRAicQ3QZP9AmKOE0jKr8OPPsOq+eXLPvzq5PXxuz50ai+/DbUpJUHPdQCKx5yd46whUxdnIHjQgGlpcitbrNAuoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39830400003)(451199021)(86362001)(36756003)(38100700002)(38350700002)(7416002)(5660300002)(4326008)(66946007)(316002)(66476007)(44832011)(8936002)(41300700001)(66556008)(8676002)(2906002)(83380400001)(2616005)(6666004)(52116002)(478600001)(6486002)(966005)(6506007)(1076003)(26005)(107886003)(6512007)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sX1XukeSGy2rIraseQYCfgCZAx11PBfdBu/Y5mGavYfMYyEpuLdxvRygPNSw?=
 =?us-ascii?Q?6i8bgJTBkUHeUTzSdXvzzdHPeIqEmhWB3ViHnmkFhmTVG937sRerUHh3miJu?=
 =?us-ascii?Q?xmSgVGet7LvhE6D8Rrj5/32DpNCO+YLIHQ7SEjgqi7JkXFdpH7joMboThiMa?=
 =?us-ascii?Q?EODYOBWGi4fPH0ytm+ghEkuNVLbDUU8W2yBZwWZanTrmdtIjm2TVu+p+AQTu?=
 =?us-ascii?Q?D306i9czX4l6Xf09BqQD3D69sBF4K1VVozyJRI/hREhnw/V+lkc6jLImDLKI?=
 =?us-ascii?Q?gL/INuPvjLAnZbAwXUJ25eLQiKkU4xV43rUnjnSRFAe6+98s0atbIE7gYnvn?=
 =?us-ascii?Q?evz09xOLoai9aOWU63WBofx+8r5h5U8ei1gtKVxGxdPDthqbW0aoszc1tDTv?=
 =?us-ascii?Q?PpZoeXD3OY15wKn0hSMcRCQFZn3kjH86C0bX1UU3eGiy/tYWRdu7G8/2csNT?=
 =?us-ascii?Q?cFwUDGSt5opDfVxlqFc8NCT2ZJFxYd+6tcFs3/Eyu032dCLBM49S7icdd2Zw?=
 =?us-ascii?Q?r2J8uKn6xZQrIg3o9SG1azooQ3mM0HjMouWQfBQGZQC+CR3VXItTRCMCp09m?=
 =?us-ascii?Q?72tUDXODrbuua6eN0jAWmTm0BBndGQdW0NyX4+eyHalUDSA/5x0Jum6PKDJc?=
 =?us-ascii?Q?7sk9E33GwO4HDIhyHyF+vwCko/dID/bMjoWsZJnNKdqIHmC2xiHwHH/Z8GLK?=
 =?us-ascii?Q?FFv8Nn0cNp2dkevXobKIxe+SE5PzvoaLMMD1I9MzchZJUXeOrJyuxdiUgrHE?=
 =?us-ascii?Q?fZO2ySe4qLMHaWqhT6KeYAy9DA16RnVXUSpsSKmjQaZaU02+rNx19w9/GAIv?=
 =?us-ascii?Q?DABDoEBDghMgNQ/RUBj8e68Z5Li6lmRVCoKeNeLhTiUY4x5k/yxNVqiHiwe4?=
 =?us-ascii?Q?XGmuMKD5ZoRI0TebU8WlMQupcFfW9t4uTqov3kx+usZF2sVZVjEusi+IiTby?=
 =?us-ascii?Q?8S711QPPIS29wazHejda68TT9Pk0/QqxTu4QoqcfAWsAc8uKEiEGwikldS9q?=
 =?us-ascii?Q?LO/xW42s4UbJO9abv2knnlw7ayUzwYlSOJyAzGBkfadII7f4tbEjXYakk/g9?=
 =?us-ascii?Q?cXc8pIXiLw4ckUPSzUcYGMxVvwZqQByEzQKjUmkCQVlJ3521SDpqZR7gbRjx?=
 =?us-ascii?Q?YNmhnebjXHfoJQaaTTYehqVEmuTxb9OMxJvmy6thE8jHhiyfBlE8evVUjk/Z?=
 =?us-ascii?Q?pQNe7EzE+ZD4xQ4Gt8tzvF/gx9P4n/31iy8qUq1BEmesgr308F/2B2JKJ4aE?=
 =?us-ascii?Q?OiicWngnr82IYkX8tjHBiGGXgHOO8125JRqmmsUMx+VkRl0Khuqs69KlAzHM?=
 =?us-ascii?Q?4gBzTtIjouE8CCFusHiIDb0DJb2Qr6z8B3UsVs89Tf5TCwpA8LoicW0Mm7+j?=
 =?us-ascii?Q?kmrefio2hGdqwPTiuBfg6jJ4dWKajw05gfeTAF7lf7YELN0QxdS2ZG5eMZHu?=
 =?us-ascii?Q?hyzM6yKUAqViU8IhfjSEjqguor6dG5cbei6jEdr/zH14tk/ZziDTngVj/jzg?=
 =?us-ascii?Q?zEOU/A5uOn/cSGxhwv7Yt1D/dGpia/n+rCI5gS/ku7H6aaW25hWsrFG8MU2k?=
 =?us-ascii?Q?CJidR+Zl4hl7pMH11nqG9TA0XJ6mOJpyYYyW9RTBbUvKklL8XhvopEkXDDI5?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6694bf-ee99-45b7-6355-08db497cf749
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 13:15:27.9213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjGZnrVT2EL3gYPWk350L2rUHHEqypYzVaCkmBIi++CZcEFmoyBKlt6L+c6MSNiMpdOVT15JhO4DTrrB2OMde5mqRAfYolKsF4SOsN78k5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

At the moment, if a virtio network device uses vrings with less than
MAX_SKB_FRAGS + 2 entries, the device won't be functional.

The following condition vq->num_free >= 2 + MAX_SKB_FRAGS will always
evaluate to false, leading to TX timeouts.

This patchset attempts this fix this bug, and to allow small rings down
to 4 entries.

The first patch introduces a new mechanism in virtio core - it allows to
block features in probe time.

If a virtio drivers blocks features and fails probe, virtio core will
reset the device, re-negotiate the features and probe again.

This is needed since some virtio net features are not supported with
small rings.

This patchset follows a discussion in the mailing list [1].

This fixes only part of the bug, rings with less than 4 entries won't
work.
My intention is to split the effort and fix the RING_SIZE < 4 case in a
follow up patchset.

Maybe we should fail probe if RING_SIZE < 4 until the follow up patchset?

I tested the patchset with SNET DPU (drivers/vdpa/solidrun), with packed
and split VQs, with rings down to 4 entries, with and without
VIRTIO_NET_F_MRG_RXBUF, with big MTUs.

I would appreciate more testing.
Xuan: I wasn't able to test XDP with my setup, maybe you can help with
that?

[1] https://lore.kernel.org/lkml/20230416074607.292616-1-alvaro.karsz@solid-run.com/

Alvaro Karsz (3):
  virtio: re-negotiate features if probe fails and features are blocked
  virtio-net: allow usage of vrings smaller than MAX_SKB_FRAGS + 2
  virtio-net: block ethtool from converting a ring to a small ring

 drivers/net/virtio_net.c | 161 +++++++++++++++++++++++++++++++++++++--
 drivers/virtio/virtio.c  |  73 +++++++++++++-----
 include/linux/virtio.h   |   3 +
 3 files changed, 212 insertions(+), 25 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
