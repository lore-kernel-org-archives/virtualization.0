Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513E0C43217
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D944540291;
	Sun, 21 Nov 2021 17:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaYxIJcJRb6S; Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDF6F40240;
	Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56DDEC0039;
	Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE5EC0043
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D839480E25
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="x4EZCpVm";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="UB4Y8/IV"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqKb3alYcsKw
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B6C480DB6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:56 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALFh0tC000588; 
 Sun, 21 Nov 2021 17:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=wHkPAZMUmbVKywwn/ujrOrkVkV5ONQ7l9+ff7h/8pes=;
 b=x4EZCpVmrq9uG8Ht4RPobfTrIzV7INS+1xI/FVU5kIzrccGFj6/Hz8N4rXKx2rzHPTIV
 rvsx+5Tv4In48e6INLhhw9KpDLovSU7Dujol5qdEKMjD45sRnmcbKmru8ZpouDOMZ/8I
 okGiWIptyDNg++Uqk7cOu+V9xHVql+bkHhdu3V90OZpdhuCNEAgs+bgM1GvO+4Fwkxl4
 11szAZgX/KSlnNwTCkLvZnCeigQ98IlWi84nlchPocduauq0KA48RHrp9+/BttdmFN+v
 rYxqjh3NNkyeMPtRjrLZmW2ZMci8YkIFwzCU1AQfRSlCGIXWx286+1dym4uJMKbL+N4B yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cermsmgfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUXw015043;
 Sun, 21 Nov 2021 17:49:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5dkCdnM4hK/A3eXpNWlOEZNFqhg7n0RDkE7e9CeFXXh4FEHKGYf9FI7a0xA5KEYMw5r3bCE9BHLX7kMqez4MQ11H+F+dr6/dFsIQt5OrZAdpnMsPOM3f7OrqvBW9TUfWQKJClGJ6S68qsjMbD+4y4OOR+ekhG3BNpTWSV3kHkt2naXjY6O1BaQ3nQOed6DVkBuJcmFk2GQZS22b14M+CblQ+8YGSrtmWB8mMrbovPFKC+XiZ4Uvc2YyM8VoV+EOyAdxEPiGmXaJ3/vOFi4kUKL1Ld6roPhu/ZWDHEP2H23JeOrdjvkGlSTz6jC3/6ZDUVQntffqEaFogJVINJ0LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHkPAZMUmbVKywwn/ujrOrkVkV5ONQ7l9+ff7h/8pes=;
 b=DD19NUT+bhovlm3xXI8Z5TTGypdJNGDNdd+G8P5VbxVbAtsNa0jcahh4dsWDJ6p0NlmB32s9wYzqnzouKbWlSMAvReKjVTDmkJ/cTjOdQWvjMkL73/aFGdZX1xPinjwiwMulrqebfvw36u70AyvmEeGFDbh4oaEFvUV6+t2FtLSIGu/mM6JcGbLvmSCrdg5gPVEbbUpt/I5cO3cdTRWLHV8z9a0zFIjKWFICo92wGBw+b30WbZ3j+pxf/SJgRp/RT3juaCrHpIocmEObQtdyWYPTOXTThMz5w8wVz8H78dufDfDg+MkSF6ptoLEhY1V+DVgrUxrcT5q/1SdpHxRU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHkPAZMUmbVKywwn/ujrOrkVkV5ONQ7l9+ff7h/8pes=;
 b=UB4Y8/IV+RFUYusZ0ZQNxA1kZ18aBk/aKhijTfvvDPV38Ci8NWmXReKEm6G9mONLcWF/5i+TClhy7U1QUCytn8MHCu5mQAHughKK1e1o+CPK6mJo6mbmpnhRbNqqwhR45/SgCQcCyF21pJG+dvjHKhjpf5F6FtnOkC/demImb6M=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:45 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:45 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 02/10] fork/vm: Move common PF_IO_WORKER behavior to new
 flag
Date: Sun, 21 Nov 2021 11:49:22 -0600
Message-Id: <20211121174930.6690-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121174930.6690-1-michael.christie@oracle.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27972e90-e3c6-4411-4f96-08d9ad174dab
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055E3BAB82F82A4F641A7DCF19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Js1yatNASkIYKQdht7qDydSITkXhgDaBXCG95udyyADOs3Nd1yAYs1OjMl329dkeJS2zo3fhH8yUI5mY259siGxivrupUGqQyS0AIQ2DPeVH1vL7z9sso91gljSwQKWaLULvYypF/97lKjWJSwKDRpF/HmHQ91s5r66U5W8IFkn1sivPW7D1+GOmK6nTAbdfO8FaGGaLEBdgu9eVNyxnGcw78aaz3kRV9lX65Dthc9PlX3rkqrZTQwh1p8RrLXoQAuwyFTLpvylX8VIk65ebas1i6bvHZxiao99g8ar5kM5opy/B0mxHOC66ZdoqRHU+DDeiwmw96GSRhqbG0W7n8S840a9kdbGxY7AX0tA3sgB5mk5BeffQTG+e7kcj/AWVXklWC+Hm/grVGUvAQoZvuZ8pWFuQfaBRNhRV9cKCayzPpd/QFDQ62H0Gx/QlooTUoX0BTD1nRhIF1RXLNy8rlVNiBEMi4pVxet8abnJC9fI9/3wiw5HjyYbOD7pSwqVL1pzn7UHYaz+15HvwcFqBgJse/6GpIjQ29G5uEKa37nj13+Ma4J/VtixdSGSRJPKOm3eLal0OC5j9SfbX3wAh3HTRJpPOJ9ozWI33TM4cksGzMgw/YUevCHY/pR2jsDOlQ9gONPdfFl4sK8pyLVBD+Rf4t0cHrQe4FQj/S3kFHbHLgD6JJb12h+xoKc/Svow4zLv2lqkJoYDx9I0QFAjEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(107886003)(921005)(508600001)(38100700002)(6486002)(83380400001)(30864003)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jQ8kz99sBAFGMA0OBGeSQ+ox0SO5CKzWPSAW52kI9wUa6KtTHCKH+x43R/E?=
 =?us-ascii?Q?2tEbSgMBRQIZLjgMGSAdDjfQ01+AhPFeARF7SfQ7WkXL+6XeWg9ldo4XGL58?=
 =?us-ascii?Q?C6yVLTGBFp6/4lXatXwgwN42wxD8PaT5ukZtZ7axkNW5M6I6VnNIWvbsWks+?=
 =?us-ascii?Q?gJxlXdVe1r16jxuKhz71ezBBSbQylQfkhW3jSDThecSiYTJMo7OzgKSrwCbx?=
 =?us-ascii?Q?33t59ccVh+ezTezk1pK9VbRQpthfTQzjDUD/aymCC/KRQsJCCHeZUWLA/zA+?=
 =?us-ascii?Q?4k7sxE5JmJ6LaZt8+aPwMKGVJTHqxlrT1J21M7SuPecXOKZvqcGAigLRbkU5?=
 =?us-ascii?Q?WpqurhTonR9CUSMe4M9aYPN0tbBhkNKm+YRgwr5WsS2nTh8PIDFfombTobX/?=
 =?us-ascii?Q?oovYAJaEXledUB+QQRTlr3wriMLv6R+un+BcavGuvb74gfCPOf9zTl8AoTf2?=
 =?us-ascii?Q?r1F4xTa1Nsx4JYoxfFJAKhitjSFP5w/UAXiWS1fIIhWRePaukibyQ/8FM+S0?=
 =?us-ascii?Q?GZbDeUJCtF3PP5xqPqkv2nb963aBppDARwaoDqJUfZkGHmX4LYHn53ahNS4E?=
 =?us-ascii?Q?WqYnU5sYPhFVyAKTZkDyuQX7otKSGQTcA8vETAAmpGV7hJa3oc1seMsswxgO?=
 =?us-ascii?Q?7Zc8PQ/Nz+6QR7FnCb67RuDXyoj3RvCRMAkkWlpNzMCavlOpC4oe/jBk1L7h?=
 =?us-ascii?Q?IcqDmYWr4IdYqywkFZYVxNEsFWwqGTz3kPq+tRVU+6U2Tnux+pKUmJCcFbjz?=
 =?us-ascii?Q?i5+9oVzCcZTaR64nZv/yHyAS3Gm6IUSMh9WDgeb2cdhGtDWS083Ls95iSFzt?=
 =?us-ascii?Q?QymoUZEkbOsvPAPmJGZY6VAy0pM4pGGqUntKp51Kmjc2fsqN3fUx5ch6B8Bw?=
 =?us-ascii?Q?CZhR/t/OoYhvMDBsqvAv778jEJCSYQuZ5X9GxpU2t1Koj6SBO0Ds4OLMq0iy?=
 =?us-ascii?Q?1Os29cpqwrhb0+jeNARksTMJ+NldDNG+6V614hLyYkQtUdZ+lmY6Y1Q7FTfm?=
 =?us-ascii?Q?f3A31NGZcZmMneWPz0HJ9ttSYgTLxzqfhMDXq7WFCM/W17D+/8wRQrf8xK2p?=
 =?us-ascii?Q?BLQXx4rcPjylF7bEvSbOsxxn2nvaSTQme2nN7/lw2OrGEjJzklomM+J1mvOv?=
 =?us-ascii?Q?UyxJSHLQnYLIi62u7H2R2EUMvCeQIGIJXNszWAcoTrLnrR+nMHqgaEenlMOF?=
 =?us-ascii?Q?EjD0wJvqsjUJ1Zp+YS6/uDXx1VgPGG5cl2oq8o1Rbnznnt35x1NqEiIhbXIF?=
 =?us-ascii?Q?zZcyukeKUyceYNDRzP/RsQKTs9bwOcu5QF3rLCCpTnDyVDFPIMOrVRcHM/jV?=
 =?us-ascii?Q?3Bnp7wJ7p/W7cua84NJZHls9bpsoJi+hjNsC2DKEROjKqjDDRhXWkVjGmWFx?=
 =?us-ascii?Q?EHncFOLymDfeVCkRUytQD00+sIeoA4Jh3JVfy6Icvjckn9UuqUXxKNM0MtGC?=
 =?us-ascii?Q?w/WJ0/CXeN9WEUx5Yr03bWsxLjLALXvimpwhRWHx4hG1hOTcDz/zTxCuids/?=
 =?us-ascii?Q?3FJGP+rhm+J9sGaOJqxcaGJvnEplxNpuvIQQxpzJYVm8of+SqrJwCY6pnqdp?=
 =?us-ascii?Q?TraZxVCSBgbvCERi4ten5jedXvpqxTEff2cvsfdepxLpK/UsVO6fRZgr/rl2?=
 =?us-ascii?Q?+GPcp6s+K3327CjNdZrASkpjw4zscu1GSZQ4fl9lvIm1WSsH3zMOssCX4p9Q?=
 =?us-ascii?Q?oGol6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27972e90-e3c6-4411-4f96-08d9ad174dab
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:45.0960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIqZH+76IUj2B7fUUd12d/x8swBHlPUdZ5j7mJ6MEFl5IDa+mhULvYkPQBw6mQ8Udq7ahplPCOsNLTUt6sozJpN75SezqH6vi+DUV9I3xpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: 6xGF6vSQ8fZWeiCBKwhFEVguov491LUk
X-Proofpoint-ORIG-GUID: 6xGF6vSQ8fZWeiCBKwhFEVguov491LUk
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

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use the new
kernel_worker helpers that will use the flag and are added later in this
patchset.

The common behavior PF_USER_WORKER covers is the initial frame and fpu
setup and the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 2 +-
 arch/arm64/kernel/process.c      | 2 +-
 arch/csky/kernel/process.c       | 2 +-
 arch/h8300/kernel/process.c      | 2 +-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 2 +-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 2 +-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 2 +-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 2 +-
 arch/x86/kernel/fpu/core.c       | 4 ++--
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched.h            | 1 +
 include/linux/sched/task.h       | 1 +
 kernel/fork.c                    | 5 ++++-
 mm/vmscan.c                      | 4 ++--
 29 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..f4759e4ee4a9 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 8e90052f6f05..b409ecb1407f 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d47159f3791c..44603062d661 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -251,7 +251,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index aacf2f5559a8..b4c6c41847be 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -333,7 +333,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..509f2bfe4ace 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -49,7 +49,7 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 8833fa4f5d51..050aca44ba6d 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 232dfd8956aa..40f8294c6c7c 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 834df24a88f1..29015ebdcf1d 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -338,7 +338,7 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index a6030dbaa089..cbb693012b5e 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 5e2b91c1e8ce..de1da9900f7e 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cbff1b974f88..6f1ed337cd41 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..dba91dd1e289 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index f8ea522a1588..eabf3452e5e2 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..aa110383cfa1 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -172,7 +172,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ea3d83b6fb62..a76120e30eb4 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -197,7 +197,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 406d7ee9e322..0b06b7809816 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1700,7 +1700,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..8deeb94eb51e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index e8858b2de24b..5ce90a23b1eb 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -130,7 +130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 1c28e3cddb60..0506a739b0a8 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 2dc0bf9fe62e..5386e56b5e6c 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index f5b2cac8669f..6058b3966f71 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 82107373ac7e..2cb57aefacbe 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = current->flags & (PF_KTHREAD | PF_USER_WORKER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8ea306b1bf8e..f3fc1b1db999 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -485,10 +485,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	/*
-	 * No FPU state inheritance for kernel threads and IO
+	 * No FPU state inheritance for kernel threads and user
 	 * worker threads.
 	 */
-	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+	if (dst->flags & (PF_KTHREAD | PF_USER_WORKER)) {
 		/* Clear out the minimal state */
 		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e9ee8b526319..3120a1aa37f3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -195,7 +195,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
 		 * An IO thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index bd80df890b1e..00d81668ead4 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -224,7 +224,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 #error Unsupported Xtensa ABI
 #endif
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..5ca45456a77a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1683,6 +1683,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_USER_WORKER		0x01000000	/* Kernel thread cloned from userspace thread */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c688e1d2e3e3..1ad98e31d5bc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -19,6 +19,7 @@ struct css_set;
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
 #define KERN_WORKER_IO		BIT(0)
+#define KERN_WORKER_USER	BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 58dcbf7dd28d..8f6cd9581e2e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2032,6 +2032,9 @@ static __latent_entropy struct task_struct *copy_process(
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 
+	if (args->worker_flags & KERN_WORKER_USER)
+		p->flags |= PF_USER_WORKER;
+
 	/*
 	 * This _must_ happen before we call free_task(), i.e. before we jump
 	 * to any of the bad_fork_* labels. This is to avoid freeing
@@ -2524,7 +2527,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.worker_flags	= KERN_WORKER_IO,
+		.worker_flags	= KERN_WORKER_IO | KERN_WORKER_USER,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..f504ff88a09d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1028,12 +1028,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD))
 		return;
 
 	/*
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
