Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B862C38A2D
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 13:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E714240299;
	Mon, 24 Oct 2022 13:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E714240299
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=oVZJ+pBo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2drpyTy7roZC; Mon, 24 Oct 2022 13:41:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F02640294;
	Mon, 24 Oct 2022 13:41:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F02640294
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF7F9C0032;
	Mon, 24 Oct 2022 13:41:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27E53C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0F8B40294
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0F8B40294
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O9D2PxkGj7XN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EEA64025D
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EEA64025D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:08 +0000 (UTC)
Received: from 104.47.12.52_.trendmicro.com (unknown [172.21.183.236])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 8488C10000BA7;
 Mon, 24 Oct 2022 13:41:06 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666618861.342000
X-TM-MAIL-UUID: 9e157397-6108-4e9a-a759-eb7011619f73
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown
 [104.47.12.52])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 53D311000031C; Mon, 24 Oct 2022 13:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLNcJSiMspqVVpOrI6lzd4KwWo4QmoCRa+Zh1Y6owt7HKsKDC22Bx+t9FMMOmDJMBqweCvpXTxPBzmzdUihzldJNxWI6ri0lHI5P16fXP4Kn5r61ZOqT132n6dK61tcJCX006EWJM5qQ1Qvn6QDGjmR5XHGjHNz9fFtZWAM9+xiqEjIUZA7FO46KcU0G03lAHOqtcmuRNEJvwcE8c3w4NAwxG95LCA5WFovrvpb4nSpUQfHzYCwPyRupO2W039X0eNCzWM/TxALGGD1DQy28C8PcdKTEpES/JmsaruMpvvfm/4hAMdbqYM5cEAmUxisBssBldgvzr0qmaWsrztDRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUCWsYwSa4f8pb0D6lRzIM8Sfo43/oagQfT7nF480BU=;
 b=ei13Jny8wdZ78PS5poVUjNrYik/orMK8sN6fnhrUep1A6qidlMWmTatInt4U7omhy5WTLVFW0WjQQa2GoaxQewROjY+G8rXvLmAsuA4kv0yryRx8sBV5ddiCQr7b2NwfrwI3PWm06SbNLcqLb3I/5z4sG/gxo6lUfGuPpjhco/seb94NwKiDiATjwuwhoWo2VMuCjV/ZGcrM5sJAQ5ihUpRaWCpg4PnFngKBL9QHmxJkgSNgCrqJrrpRLo84PK9PhXGM5fyM77dKSWSzj/JpR64p5ZqqQ3OMoKCChxR/RqS/L+gApj3dw+00eao57AeMlN6SMDO9LoDjW165pBu8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To: virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
 mst@redhat.com
Subject: [PATCH v3 0/1] virtio_bt: Fix alignment in configuration struct
Date: Mon, 24 Oct 2022 15:40:32 +0200
Message-Id: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT010:EE_|AS8PR04MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bd2c82-b347-487c-ed2a-08dab5c56289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNotQ68KdvfvC3Gu3/kouHfOkBn65H/tdz4+7vbkZsIU8qXgpojMbmGmVj6EJCweEHacTEQocSWV9OwPWOkG+jRy8UIxdI1u96piPiFhXBjpGv5H3mvcq3RbxP2D2/NqlE1GUs/8ZRjgUiji6BvsvpuCaAGUgkY1t6obwE2J4TXqyq2iGNodjCw79MGOea0SlU1rt+LfKF7XkmuLWX3Z+dGUYa1MxPIzAM6R018atxD6Lx4nOEypDnACOsVWfb+7UK0eMpsNwbCmqqWlxCrY9ecyeLNWSXKb595KVEvt8IvlveKS3IYRagT4XCKAKv21UJNvKjWmvjEjpIje0T+zf75JhhEp+PIkJe0+lvPsoPzpW5bBryPLUSl+UQMXtI3qtbnAMYbul9C7htfDcV6FhBQgyDnOmmIR0Zo3IvCQwqIxcJyxpONswWn+so6F+MUA8fPTB4XP/T57qxMdQf5TOyEy+Dvnac05+Hk7VbtobsLTm0qSnhq33TeqKwJJRSTGEvcmrN9iBKUgecuTQ6r7/uGhGrtzQy/PV7tAoeH/fPvbFkCl/AqUJDj0BlTSWgxCvNyXG8ChJW8OLd8UUmGsuDYHxfH/bT+KMaainBzlym4fdAtT1rNYi2oVNoW17g7I+D5WcoU6TDP0WjPB0NwFJvvIawgmGJHuDN5VLrKvUOtrDhdcWU013PbfsEp+d8iq8UPZNSJgBbzpZmKVRhp8UaO/WWWgO2yvC3Igi1NGFGsFL400/lCjzUhx76tMTpVuEi3nGByFudOdfbd/1I9/J7hrZ6im/F0a5Lm1ARras0A=
X-Forefront-Antispam-Report: CIP:217.66.60.4; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SR-MAIL-03.open-synergy.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230022)(376002)(136003)(39830400003)(396003)(346002)(451199015)(36840700001)(46966006)(42186006)(83380400001)(316002)(86362001)(41300700001)(4326008)(36860700001)(336012)(40480700001)(26005)(2616005)(186003)(1076003)(8936002)(2906002)(8676002)(5660300002)(107886003)(70206006)(70586007)(82310400005)(47076005)(36756003)(66899015)(966005)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 13:40:59.1956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bd2c82-b347-487c-ed2a-08dab5c56289
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64; Ip=[217.66.60.4];
 Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770
X-TM-AS-ERS: 104.47.12.52-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27220.007
X-TMASE-Result: 10-1.841600-4.000000
X-TMASE-MatchedRID: k/56TffKUsg4vjIDbvA3OMVUBXy8OM3/M9EkAUzyluGAI7Mvq/sL57ek
 d2LX0DpINaAGdu5Ot0eXJbVmtnHrxnI0shGAc7FenVTWWiNp+v+wQ8dOma+kqrwxqSK0GSPRjFK
 /NcS7G4llfaF/BQ/tikrFr2FVZxb3hYCiPfz7etn3dt27LH8hnKxAhf/GPomfeGHkpR2WBaL6Pq
 wEmsq4onoKNsImo9ohuXFEQJaCEz7+OhQWBlKflRRFJJyf5BJenOXVXbtyRcZUMLUJu4leYyq2r
 l3dzGQ11VrbCslo1IPzdrwMaU6LTMVEUeIHhCKcPpsnApkCOkM22y3gb14N8g==
X-TMASE-XGENCLOUD: 41de61e5-7a29-48f4-ad5f-068e5c6e9b47-0-0-200-0
X-TM-Deliver-Signature: CE0A99EB907CC0AE3CBC5D1BBF2D5FA8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1666618866;
 bh=LiTSONCq/pWfBg/3qES81Hhk0fxoeYLdcH3ISspf2kQ=; l=1320;
 h=From:To:Date;
 b=oVZJ+pBoTFsa4Xd/jB8f0DpuLtbmjpVUqITQOthmUe3ttiqtGp7eFEOBBHR4nn5Bg
 Q7GHFoorleOe9bsYeysXYonMdvOMF1AZQh2JjZS7DkCTGRHgk7MR9NuG3hl4tTZgko
 lt+5Zfforpes8Y4MdOKiSnhrCiV/iT9vKgUNa4T9jQjIwaJQMemHvR1zuK6YZpgp9V
 h6BvFqmCG6UPUWYhYErcQIkgGdEdwEmPWR+UY9pOjOFCG5LNEO8jnRR4Ii94JoUtjH
 0WRMafcZ4Q4yFUfeTlzl35sANppmraAlwnCIvSB/ktqEKNTD21vThX006VDQWpJxiN
 8cARgnxGIE6nQ==
Cc: johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, marcel@holtmann.org
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

According to specification [1], "For the device-specific configuration
space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
and aligned accesses for 32 and 64 bit wide fields.".

Current version of the configuration structure has non-aligned 16bit
fields.

This patch adds a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Changes in v4:
  v3 was corrupted by our smtp server.
Changes in v3:
  v2 had been sent from the wrong address, fixed.
Changes in v2:
  The first version of this patch just changed the configuration
  structure in uapi/linux/virtio_bt.h
  This can not be done, because it will break the userspace, so the
  second version offers a less radical approach - it introduces a new
  feature bit and a new configuration structure that both the device
  and the driver will use if this bit is negotiated.

Igor Skalkin (1):
  virtio_bt: Fix alignment in configuration struct

 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
