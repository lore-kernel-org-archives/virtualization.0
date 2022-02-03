Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D720C433FE
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 13:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C082840A47;
	Thu,  3 Feb 2022 13:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Na7_PGrkLJSg; Thu,  3 Feb 2022 13:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CC7840A41;
	Thu,  3 Feb 2022 13:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F393EC0072;
	Thu,  3 Feb 2022 13:18:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4540FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C1244152D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Jm5CuMY6RZ9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:18:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0AAC4027B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 13:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH/vCzw5Vys8iGK7CnJky9V8e96wpn3QW4Z3A3TvZGeLDMZt35fm6K0Wr4O4UXYC35v2QfHLGkV6I8si4QU8p/gnqavm3w6FHyz56kZiRbvu0uz12F21vSpeyOjhBSxDZT6Ujjx+sfOkPMvn6ryuz+8/wogQflpyUW9Fep+nUOntsdf/dF8K3Wjwlf9nEVkLyrha4llQgXYwAQE6TIr23s/HjQUh193cRON/Q3Lz5c/5M3hkT/RG1b+/GcTUKbqBhVtGYbgjKtYp8jVo3UzaFuZCGx1yAxBIxqPqmcd8ATShPthaW8Ewt0cJxZXzPMHLsDsBx3jKnOKsDQ6gyl+7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W8TrdRp9GTsb3nOerdsmaGgiZw0iRhnUQ5vSw5s6Lw=;
 b=UAyz8nZnM6695tH7Z4zCqqDsCbao31H9ELQN/LjJipINMq6zVxY9D1qTpiM1FQ1Ac5l8gyHAjjLJhU7BRYiERqbuEOUGZ51N2MW3oB5FBc9+aIJX8BoLNFQCEmfNRgfd+qodEycX25ihCc2kn06TofUJRbDQVGss8mxkjvV1DIR/TnA80PBLU3W7rLQnVBYpmADOPELuIt42hlgXiiN32wnqm1vHnnmXDeY2v469NPeXZhS8jwMXL1jxjHhMRixj5fjNqkb+u9cd0C2Cu3MdOnrAiQI4AsONZ73tW1cjvQFJs9K9KEFdInb0yilpvPEsNiDVawo0M07MyBD91moL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W8TrdRp9GTsb3nOerdsmaGgiZw0iRhnUQ5vSw5s6Lw=;
 b=tvDia8gvT4XxsU6LGDiRxdr22NmbiiizEFZkU/1zxnN5w1x7TncuQl3crAXbDu9RBW/jhf9wTUPNaLJad3RWQnkdMY9hTtLiIDnwKLksG91cXBrWhI8uCs833fFjFN7rbVxkXlzzyvwJlrAtFX/yjlir6WBZ3ACMJvcGJbeOi6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:15 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:15 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/8] VMCI: dma dg: whitespace formatting change for vmci
 register defines
Date: Thu,  3 Feb 2022 05:12:30 -0800
Message-Id: <20220203131237.3380-2-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203131237.3380-1-jhansen@vmware.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74bd81f4-bac9-4a7f-7bf1-08d9e717a222
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB715088DEE11442562BB39C29DA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tL8qTqX/x9Wj80587FIXhot/xNN2+glydlFkFji8jp9aUbaGRVxrs59qwqBtOnUgCg0bckeOfinRwMsQMgsfqVsxhWcu0FT+yAiTfo+Dy8snIw6aERD3J7aZjN52U7St+MJe0l30JdoNLZUfvZ1rdxMUR+zKhGXKFNTKIJ3ctqf8ZlXcOZVPCtxn85Bh6bOQavPx0HblWhphVF2niQarCCVWy38jha1Mh68JfVgVX7hzp2YwRfixXmUMkFqW+e0o2y7KQJO75MkyqJ+Tt21bnVq2ms9SnWPQLIS17QqWk2kKaObvhH9N3CR9+mr/YFS95DOfWcxGivftsyGkAYRNzfMPiaSFpZ0GhW23dN63a2CMClhE++Gr44DOogzjpCeBckNxFOR8TccHrWQFoTpjvuBza1nehvv2hvDwEZLtfiZPhBKL2ubXLPQ89pYebZiT/Qo45U5JE/ocVDARficU4/efZPAlnPAx5edzMFRdHxVwR78Min9mxqn9fzqDrnEsw8QSVMCf2BLB/4Yfey8cGcFd2+7azgl1b0KwhEycSqqRmgnUpWC0nJtVuaQobYcyCmrOhToLsgBtLgoe8wiDmtGairushMaFraiqBGBR5ENdDCkty8oZhCnelRFECzZ49JOiqybitSNkyNPoF27Zm2kcEXnAYRso63+eEixROEIW2dvzHgaHkfWuKg7ykxvizN0HspPknjAvmZ7BQMJM3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8081.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pKjC2bDUq5OFiKlgOVuZdhxdrLJiK0FTkdIYjs+xZxFmybST6K00ENew8sdT?=
 =?us-ascii?Q?28CR9ZCYH6L49oa08KffbCVqjI9m+NcKSlCmz1BfGJtxUPyPfjCPc5ZVh+um?=
 =?us-ascii?Q?p50yx/VQPsirPMC36ID46TMxrFLdxnYMxbbkvCS1YpvYoh0O3UnB/wbReu9y?=
 =?us-ascii?Q?lhwbrjZHrxSecHIOcAG9ZGVKnueliBfsOHY0a3Gv1q9q/eHR28utv3DPSQL2?=
 =?us-ascii?Q?IHWj70XacfY7Vb0jllb+5ZItIGpjlR71vG5CUFg+BJkxz+5O6XDe/b0rmEVm?=
 =?us-ascii?Q?v93IPOlbjqHJPiRWSyjw0mRAOH5HxudP5FW29O5CZIicv8QnIhklDLSpFLBh?=
 =?us-ascii?Q?Hxd+20vvqawIupGv4Jjk5C+YyUAKrhHpyPMciHqAfc6Laa4DQqFuys/tLOS7?=
 =?us-ascii?Q?4B/E9oBLzpTfICVxsdkVdM09LOefAOJRecmvJBA+83pogZ7EPzN2a5Oy5wqz?=
 =?us-ascii?Q?WaUvAxlQYoPGYVI5Yel98lU7bhRNXucQ8PUpAX0O+AAeiWZzmaUsZU/vVBL7?=
 =?us-ascii?Q?PWCMRZ+IL0aDAD2jVi1btgWEpxubOz3+mSFLMqkC45TFmp+uhDNxYNnHztFv?=
 =?us-ascii?Q?FRMGWCab9lC1xWSGWPir1XP7y4nt5FP1mbQ7QYNM2Vi91R2huxnoR5fvDnDC?=
 =?us-ascii?Q?0+jUJ7EQaSf8EhB/WrzJK+oBv6J354qiFoh3ZQoPACRxN4PsU6vjyAGRCVzo?=
 =?us-ascii?Q?LZbbeXik03eqpacNJYK0inYcFHz5QOurQcohfzD1Y3pJ885tT9fPOX3JxZxs?=
 =?us-ascii?Q?5Z3u7Keoo9OVKDzqgW66qd8WIziGLzubCS8aTK7in0MAZSJwzbEdbKhp+MoL?=
 =?us-ascii?Q?EEqRK/iLwDSyqrcwY2djKSlByNiX81n0NeGo6IlxkVjHand2th/w2SEct0w9?=
 =?us-ascii?Q?JDgExdon5FvecBnrOC0ZMD2bJVJEWHB5+O4Y9tZqX5HQoJ0lDgurd/NJVHKL?=
 =?us-ascii?Q?Jhjw/AXaatxBNz+vx70Dj0h7oN2fDUqNaKrk+c2+xLBZc74QUpBr+8/lYM33?=
 =?us-ascii?Q?sP1BaiGCtZ+ARuZADDZqf0nNIBS3GUdsBNuT3iwSlPl+m6FEJXAfTK2BWeio?=
 =?us-ascii?Q?7ddF/+kX8TW37OrJC6OHGQ+f03xMyIuZJ1gurjiVIsnc1NCddUpF4hrzNtJb?=
 =?us-ascii?Q?5ww5eKIJtOY3ZEuhd/M/4ADv3DEidDl3sphELQTpwY3hizwInGJHw5chXPin?=
 =?us-ascii?Q?MStB89eX3pPWrltxJoNoRi5pTvgi8D5Tklrca4Pi9YluOXIx7ZaOGGastIwz?=
 =?us-ascii?Q?lp1+UHY6Pu5gbrnbu0VT+BfTorg+nZaPA1DQ92RDKK5jWq2iQJ1Yekpj0ohP?=
 =?us-ascii?Q?1ly4DTNE5FsCwsn3iDMQDkuQ75DpWxulAWvlHWXL/o3GO2hzs/GEmwBV3nvw?=
 =?us-ascii?Q?wQNTQ/Ksg/85/wzZ2KYLPzXDsa/MKbSXrYyS39uQNlxOqxs1/IR24k191r+W?=
 =?us-ascii?Q?6mj28lIOQVC6ibI+jIillZOsKKEkYWsZlmia9SCk8DTq2dcU9cbs2x+YouX8?=
 =?us-ascii?Q?ATqgDqLtqzCCPZ9D6eW6ZUOZzxolFtTm1vXN5BFnKKXXKDzr7f/umWDEdfcn?=
 =?us-ascii?Q?NNqdUIPJR0F//WebWLkju4F8U03Vlswz4KpBRY9cDen3oLKJHH0yBnImnmi9?=
 =?us-ascii?Q?EpbjtQBqAVJri2vKPeLd3DA=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd81f4-bac9-4a7f-7bf1-08d9e717a222
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:14.5862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WSZLkv5151BjoBF9qTO3G2k+IdWQ1UQFajKkpryM5/us0FJ+Rqb3SLNp9uDXtBK4oD/OHj6KxjlQMcZ547iMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 Vishnu Dasa <vdasa@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
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

Update formatting of existing register defines in preparation for
adding additional register definitions for the VMCI device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 include/linux/vmw_vmci_defs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index e36cb114c188..9911ecfc18ba 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -12,15 +12,15 @@
 #include <linux/bits.h>
 
 /* Register offsets. */
-#define VMCI_STATUS_ADDR      0x00
-#define VMCI_CONTROL_ADDR     0x04
-#define VMCI_ICR_ADDR	      0x08
-#define VMCI_IMR_ADDR         0x0c
-#define VMCI_DATA_OUT_ADDR    0x10
-#define VMCI_DATA_IN_ADDR     0x14
-#define VMCI_CAPS_ADDR        0x18
-#define VMCI_RESULT_LOW_ADDR  0x1c
-#define VMCI_RESULT_HIGH_ADDR 0x20
+#define VMCI_STATUS_ADDR        0x00
+#define VMCI_CONTROL_ADDR       0x04
+#define VMCI_ICR_ADDR           0x08
+#define VMCI_IMR_ADDR           0x0c
+#define VMCI_DATA_OUT_ADDR      0x10
+#define VMCI_DATA_IN_ADDR       0x14
+#define VMCI_CAPS_ADDR          0x18
+#define VMCI_RESULT_LOW_ADDR    0x1c
+#define VMCI_RESULT_HIGH_ADDR   0x20
 
 /* Max number of devices. */
 #define VMCI_MAX_DEVICES 1
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
