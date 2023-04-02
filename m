Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD04C7619A
	for <virtualization@archiver.kernel.org>; Sun,  2 Apr 2023 12:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4547B8142D;
	Sun,  2 Apr 2023 12:52:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4547B8142D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=JMiD8MmS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7M80XyVnYwnc; Sun,  2 Apr 2023 12:52:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2A8E81437;
	Sun,  2 Apr 2023 12:52:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2A8E81437
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0D34C0037;
	Sun,  2 Apr 2023 12:52:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EDE6C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6048481437
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6048481437
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LlLQKZToMR_V
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8723D8142D
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::619])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8723D8142D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhFsou1OJU+0MYcWhGc4F+bvHUqiVFkxFf57BNdyXrJUpPLt4mMC6hpGZHHklGe+nOdQUEDOqNIQLTWUjAjDmd30bnV/P1TOlECQ2rGhMwYk+hIAQCeGGggv1kt0HQUDMtVRwIvP/FA7TS9uPsEbcQkMPcR76J/s0yr8tKUXoipH9eDPQdEf5E/bM4Ip9vfWAB5EpTwoZxiVSgMR+MC8QbTFjBCjKItbGz7/KfeRv0WCkOSXrVLT5oURah54iwlmPd6VCMVE2DNdgJU4gSm0IR9FJNowL+N6DF17X7s+ZyP/wvpH81i7Lj08zRidKooGawNP1pKzq3t4DHgP+svhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fycKRT8rPRiN1RToNPzVUtbiphKXy5oAKPOU8x+y8tk=;
 b=KAkIFEFByci2JcgXaY47G35Y1RoDhF0E7w8obqcsd1FA5iyTu7ZATkQCkNGEEIGeO6s0bkW1OvNga0Ay8FcWM9WnGLpTPJUUf9pBVW9hr0eqyfVI3x6tOa0WvQt2TnQ0JCVNurwim8w68R1iLKIMyI5eMfA3M88pACNkqt+lDNQdjI4kSxajwLxovQ4slCSBaN7AyrCXvo15PjqEnInwrJD/YaRSBmayVzpVoBcbarLAktigeos0c92nCaS4bzqe35mwPKfZzox5wvggCjfnz13D9vSHzWe1S7bZNSOe2tbW3Kop/+qhrisAE2+5CHoQrv/tPJkDZ/PhHg5GufQ/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fycKRT8rPRiN1RToNPzVUtbiphKXy5oAKPOU8x+y8tk=;
 b=JMiD8MmS5ZkH3GjPWJSqAMEb9W/xRxaIUSFjdc/arQv/qXBW7ja+C0FSQr7NyKk+JDgj3TPQTuXf8k6EZ84/CC9tnAVksD1B2Wfjn1c8lmG1z5kAueQR4RDx8nc1liApeOcP3ej0mkyDXcMOeGMMwYH+T/QYNnlXkw10We0S8rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7818.eurprd04.prod.outlook.com (2603:10a6:10:1f2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Sun, 2 Apr
 2023 12:52:32 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.030; Sun, 2 Apr 2023
 12:52:32 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH resend 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Date: Sun,  2 Apr 2023 15:52:17 +0300
Message-Id: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|DBBPR04MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cbd811-f719-4624-c023-08db33791f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wU3EWCqBdoPcacQY/FDsotq2rkq2G4zT1ja0IBXihVuE/K9c9F0HEqPmEcgz4rpYm13LLRJHYmFxQF/QLSF8qU4GwupXcDWeirMCzuY2uG0ySXjhTqVozk1dVRyj4fn3/gGz2OjcCr2TjT/qps2V6hUqE7VkygJkpOV3LqddGSyaMscb4UOPi1Cr9XSsxUjg1b//oMdaVdzeFrYgwROjG8e5LjO3HqgbtdQzH6mVxcLGjei9e/fK3gCu4N1+drLWY56/sK1GY4V6wZzyK0GSZKUV5KD6i9QjJky80MstkO+QiOKmOp0CtWgKaqdTSVaNEnPiz7yVbg9JxPJQ/oF+GWRxM/dEGo70yYJE6Cc0IFfWFzikGS8+6uizeydIzYSWxSJz3Kn8dcBY6OFlNy48v1AbeT0unEAZIZLp6wK8Gx99355jiPSagTgde9ryEeuO6qFPeOjmmnWJ8FE7IPnFDBcqkk75b0WzYhw/50NIY4prZif3TTLUrj6ds6wPqkGDUegeuJJrtNhZZpM5FZzJdDeoUOnm+OrKSQTIlZqW9a2eJ/scq9Ct1eYvFWcH3HSeTXupc6+4qxyhD3Io2IIeufLLH3uTl5CP5yC7yT9C/kAe9vMyn57GMtuswfOhcSrd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(136003)(376002)(366004)(396003)(346002)(451199021)(36756003)(316002)(26005)(6486002)(6512007)(66476007)(66556008)(8676002)(66946007)(4326008)(478600001)(52116002)(8936002)(5660300002)(44832011)(86362001)(15650500001)(4744005)(41300700001)(186003)(38350700002)(2616005)(38100700002)(6666004)(107886003)(6506007)(1076003)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBEYJ3mYY3l1yUUmcUeNtwllp4rARo3EIClFiSP1bZDxoehh2TSY4LUXBY6C?=
 =?us-ascii?Q?QhsXI1Bcyg1y0jkUgjoYxFl+gih9lO5MRcqQ1L6DhceGHDAeB/xw1ilOLfKY?=
 =?us-ascii?Q?huGJQ4xWHPpUjDp4DO54fbt8yz9Ght8k6b7buFC42qogIk8AojGaudybDn1Q?=
 =?us-ascii?Q?1FOMq1V7zyESoQxOXLTts9MJs2mZ4QNXvCa8c+VJHBzHxTEfQ75gOT9WQ78u?=
 =?us-ascii?Q?AUamNcp2nnwXn7vdfG+SnldrFXF2iG1J/MCUkhGsoTQ99l84mQw2wns1ZB3G?=
 =?us-ascii?Q?pUyIpzGb9bh1qhq5wD6YJhgZFNQMMGx/fYVosV6CI0jEdkzdngeTShz69DV+?=
 =?us-ascii?Q?DCy82ahd+Dr6Pabj5w9Kn2YlaV7p9OwC8E1VakRBCGa+ot7aDLSfqvCyt1Px?=
 =?us-ascii?Q?Tmuf304gV9Ngg2NOFpfojcync1/ZAeWo1v48tGUDNbWGXfLhjX2J2pVAgMkY?=
 =?us-ascii?Q?Pc1VZPkQcSB7C5Nwt31XnsIHrXur9GHP/+kxcdj9n/rY7GKT9BwgADvkq2hj?=
 =?us-ascii?Q?iXZhJLn76O/Ty55NgBgSONzwKXVtyQ9lH7h8TvwFQajvRKaz0VBDAeEDsgpu?=
 =?us-ascii?Q?wGxM9oofpKngMurOAVai6KlA3GSz7qXoHROp9ZOG0khNDJhhGP6zcpoq5y9H?=
 =?us-ascii?Q?7lZ87kfHDutqhhoWrd5uDuOMDqt7cA03GN5A8Clf96f1mtXLj1wfb8SiQHPU?=
 =?us-ascii?Q?7/1HcIojmx8K91SIDb2iW+sRMMCoZjEi7TTLwXI4DHUbL4QLDjVeSjbm3zVt?=
 =?us-ascii?Q?Ild0P6+lEgbWxIBDO3AVgJPMm+QXN7vnbN4PpSaQgt+IUVyOHcBrznanUFZ8?=
 =?us-ascii?Q?J0bMtHxct9ovZsS510oNHv5nca+XbbfV1T3ryRqVM3jVeDoLKg2QA3o1epl9?=
 =?us-ascii?Q?xYOutAYXLaYpbMCgmdOj5b2NDSGqrV77abBXgv0kXy/EFCg87f2y7NdNvcs1?=
 =?us-ascii?Q?fVFZqhShrOyt6poTs1vnIq3W6biFbcyA7ltuUSktrAhMlLQ5sbEqwA8+j8nt?=
 =?us-ascii?Q?BNl1vtTH9UP6f9wtdfUVvhX5F7A8Qzd2epwCxaX2uKp9gTv1IfyUFtbiSRFx?=
 =?us-ascii?Q?h3U1gjKAwkxFEYXWWcjam/JidK+VwBB+6qrMjWaK45xtk/5O5TXEoyVBc4O0?=
 =?us-ascii?Q?xTKRCNaOBeT8i07Lzx8O4adnRQS5D/gvdeVEn/UKYE/meSdAOfXAOPla6XDL?=
 =?us-ascii?Q?4XeM2T3fn8yzqMutd7HzOYTtyzHI1FesOe2YCaX78Nsn9WTVJmd8XUMJ513f?=
 =?us-ascii?Q?sg50oEezBqhRdBbLy27yJ1FOO/rB9PIMA2uWET2PzYpFBpq4EBeewCywBO6Q?=
 =?us-ascii?Q?SMEhxIiW9WCuEmId7vjJZhQnyf7zNXAcw/3cXR2IolINcaXdQWCXt9SHsYfC?=
 =?us-ascii?Q?P1rr8v4IxOG4F/RyJIjTClIQm6ApN1AEZ8aYgk5mL6HjuTa4+eB2qpeJ1Bh3?=
 =?us-ascii?Q?0qax4fX7rqlQlZxyvxOWrdqeTC3x0MP7AMNhth64P4z+ZoX5KXP56IOQSmua?=
 =?us-ascii?Q?5GnmrIBH5kqPL7ibXZ9Z1SBB4a2cvicKQN0DLLfOrz5GX7DASb81nrLHBU3O?=
 =?us-ascii?Q?rXF0CAJfriqNWF4uUGMMM8/dfFitmQgi5GtCyiyd5YdT2csv/06uEhHwYIWJ?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cbd811-f719-4624-c023-08db33791f9a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 12:52:32.1215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTVbidBAo6lXieHFR+hTVC16hGbd4ZHglLzr+WZ7LJQ2J5s1CMiHOwuhgUfsZWgivxeSShhbXgMrRsk/dM+M/t/1kEUpjR9KZfXopQcYwUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818
Cc: virtualization@lists.linux-foundation.org
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

Add more vDPA callbacks.

[s/g]et_vq_state is added in patch 1, including a new control mechanism
to read data from the DPU.

suspend is added in patch 2.

Alvaro Karsz (2):
  vdpa/snet: support getting and setting VQ state
  vdpa/snet: support the suspend vDPA callback

 drivers/vdpa/solidrun/Makefile     |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c  | 324 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 126 ++++++-----
 drivers/vdpa/solidrun/snet_vdpa.h  |  18 +-
 5 files changed, 400 insertions(+), 71 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
