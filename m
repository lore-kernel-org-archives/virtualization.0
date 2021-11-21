Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BF3C433FE
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C586607C3;
	Sun, 21 Nov 2021 17:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DhhE5pWEXFqn; Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 194A360712;
	Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA462C0039;
	Sun, 21 Nov 2021 17:50:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF8CC0039
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0ED680E0D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="MhCbiB+G";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="nfANXKmx"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qTpIxvo-a3H3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7B0280DE2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:56 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHPpo5007323; 
 Sun, 21 Nov 2021 17:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=rKFZEpItlm2lUNLisi2+heXgLazHNM5IiGQwUPko0ok=;
 b=MhCbiB+G6N//mGo0Cs9YFVDupg2APUyEs02X/KjhLnpQ2crZ1hmM31ecAgp2jHhDiBkI
 8x2eCpgLrIB1YH6pMG5w4orzZB4dxSy9BUCwAQ6x1j/EBqTz96OBjfMxuL/YyXfa/Sfc
 XANai+pX9tTanjzPEitz+a46blMakKexCKednjs7lZdn7FvdHG7IxYEGL6T4VK0Q97m9
 pbH/6YclupiRCwgIlYC3deIFoiI3qbH/uXg3ZXgbJNlsm0L+loMEPmAgzvjYGRjqTnY+
 7KnOPkkuS5nKZqG95wMVUvJSnXMT2U36npevhdurL3KO2wrfeZ06S62r9EWUud526YV3 Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cesjtmd5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUY0015043;
 Sun, 21 Nov 2021 17:49:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSKMwZKxd9KzD9KXQYPFBXDhCIKpvqkIoO4RE1412D5TpcIWZG1aIYZpe6t6/vFlJNh1Np8KeKFWH7oef3cKl2Nlb8YkrqW131yoVCDFn06GDHvjTWwFOrcrYVYN4YGyrhmCvjY35VlTbKO6vGcH0gqJFPRTKPIm2ZhAQq7ftLjJ+P3L5JFH4nEKV9EfhA33A+2wyPYMx2655/Wr0fV1sPE05fRgGOc1aCKx94enSsnP4g/neH+ISnIJfZkNX7fk2AxPUVv6BFDpDl4lvm3Tzgdh9c1pAwJRXCK5hgfJvyCepxtwE3dmP2yGZifWb5zO+Edy94cJ2qdmtVuzAD6yeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKFZEpItlm2lUNLisi2+heXgLazHNM5IiGQwUPko0ok=;
 b=O/wUrf6XWVLvoklUGo8fFlJJHSZJD8G5u9RQnpXA6Vap0/lWNd9oqnGdKslIdOzDnJUhfD95wm5gF2NGPshNvz1+EobmRxXM7nojCUWILn1o1+g3RTBzP4hONSKGvq/nFsb+GlE3UyUDelDP13KsszVO/+q+DTdpDGYi/l9CquF6LwuPuyn1oMBFZSzVKQnjFS8mFM7LJuSFQZKiH18uwHTYVHZg7S2bLjLI8BsoYs/AVS6Hqdx4KTqZLE3aLGhah/etpi/IdQ5idWF0L4gHLzTnvkKyzSiBB8VI79/Le+CuakyBRSsp9QB1vTHghYWSZIf24NVZSwdCZlv+nTnQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKFZEpItlm2lUNLisi2+heXgLazHNM5IiGQwUPko0ok=;
 b=nfANXKmxi03EpT20s06rfolnjxukhRPU+rwmM3aAVjj1PK8IP1aaIPrQOv/tzaZ6Zqp+lPtlpCeHbopdS4ojQSdTT27MLWQ1wGBBlX6/P9rZ+bvdw3KDbdGC/A/+W11mn0oGNj4iB8I1muzFo2NJmS0iLkFVDieqaaEmXBerR+8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:46 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:46 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 04/10] fork: Add KERNEL_WORKER flag to ignore signals
Date: Sun, 21 Nov 2021 11:49:24 -0600
Message-Id: <20211121174930.6690-5-michael.christie@oracle.com>
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
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14af73ff-5c3e-4033-5a62-08d9ad174ec1
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055A3221E9BF39360382B34F19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fShlro+QCHKYZ7GP+XIGrXkOQaoqBtvDrIvG537ZbuBYyBBllzK/vIHzgfaEbP1/6dIMYUtEUbw2hgAgRmBFOKNWno5cbcLsYmMgxtCrlKH4W286BTAv6j2scuYbySmCIjtzN6o80ti1875Rv4bX3vbvNTeeIzTtHBjacaSBXjbdMtV88c0g99D27mKiV3rXvfy9LRIN1Ipq26csczz+YJ7qoM+3qVjtOj4j2b96V1ARixz6ao56uGUWJkNV1MBEaUknr9j1tLXKU9mET7DL/2G3flPJQiJqDKuwBOvE37Ynl2kiJCpcULXfXMUrbwyvnDxk8H81lzeJumz0Vn24rYIw/8h+Em6ejZqdnD3ZCiy9CSko3DA/3HLxTUMOPnxYx6STBJREhYPc+GkcX0TSRJFjtiWSUhAoc9p7pVAlyJmIp1TdFFg9hJhR+LNVuf9KT31bQY9znaKVGN1GGlmMl3IA/D8oJ0L677XfYMEhGabI8jT1U7vu9MkZZWdBmKyMkcDHbwgDUNpG4b09owgLEAWBqIMPW0nGwHKBs+Tv0Xc4jb/FjP0InjNynRXv79gXcqFA9DakU2eom9NpNVHbk69UTBFV6Zo8CXyM5krcGCI+KJIyh642H9jdbrDGbsMa3FOYWgSb3ZEFrlypIoHE/yzyy8uMQbA76O3SBl/u635n9ngVKVXeGGPkSbE0jkbnhbPUH0d/QjPG/G7wuz6dGlNyiC/svTEDVbfU8vBfc/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IyP3CJIJ6ckxF/QPpRUzp14K3ngR3Qn538zaFnyumpmn7E96v2dXiY51BWfr?=
 =?us-ascii?Q?cEoPslR/qtLibX0KfKjF+kCvJ0X0XGDv5i3w6pCR5kwWv0k2wt/8E8gj/rH/?=
 =?us-ascii?Q?u+n7bxDHu/kwGIsGx7QXlioSkeBPLE+w140xlhRiIz2pG65eSombhHwNGZcz?=
 =?us-ascii?Q?5q+yqVS9A7dAz+U2TOUQgAXBigz+9T7H/yMserGUDehNP2Y/LCT1MPVB403+?=
 =?us-ascii?Q?NwdfbmKJjqDhlBoeLVSM9BskfxHLS1yPEVqctTMKGdySG3zkij2+6Dl7aekq?=
 =?us-ascii?Q?PYVkmz19lt6A0gAaxsL3pEJB2WPRdMMt0WlcsYyzFCoNY45cEhYMpuNowkKE?=
 =?us-ascii?Q?14+0PcUtN/L3C9dynJGoVSWWVcHrnc8fNZbgdIQY6Z2Zucnepn0y7aj9aT6Q?=
 =?us-ascii?Q?QLqjkhzkIQwQdCbkMMoNAHiTUmEq/6EGIGCiqZtXNTzFs+yNAnU2YWNbarw7?=
 =?us-ascii?Q?oggQBtbGJwaDzoYTV+3NYNfgF17Ql7+JKbkVTYhpyzOqLqq1ibrRr45LoQ0b?=
 =?us-ascii?Q?r20JhX79O+6Vqq86MC3xxHf60ec26mFHhibMtlJmIYdIBUoQ/Hgq2KWY2vf4?=
 =?us-ascii?Q?hmRkyYjGUtWJpQQHh/ficYtCSZYbEO98Y7wHT8uHvSgfgo46c55snCrdXPnN?=
 =?us-ascii?Q?J8P0BeV2sIxXOiScr2nYisr7tBDw/KzGmYr+y5jAuofjWlHW3uwrPdCcbJ0B?=
 =?us-ascii?Q?muah7uIIEmD3vPeMcs9+sSUmwuAXeRhExPun2r1x8zp+WyKLwzJf9Osw0Twf?=
 =?us-ascii?Q?8BGfJAZjF0Zti/QIMd9tIV2OHv4kykdJeX1SZLSYMCmzvKy0IAjnE69lEP0c?=
 =?us-ascii?Q?f6PKqgPbqtrUNNnqBzrHK9NH7s8KhzUdUWOiYKlBz+2fWFyijzMUGNmPaG3a?=
 =?us-ascii?Q?QvFTuaPMZtvIk4qNnhxRebmEYZFyEKMVAtNkevniGKaFzThHuPE7ow9q6FBE?=
 =?us-ascii?Q?TE8dvZyaU1MYA2kq6waSNVB+uwaAoSbuPz9MKs7Ir0ZyvjYdkPv/umTulRQQ?=
 =?us-ascii?Q?nTNuDVq4ppfjA/ZqWVPWfSP4KpgbajiE+7TjbWhVP4X7RoVERWsTkH5Ut0pR?=
 =?us-ascii?Q?3HVkGXkXxPFVjzJhVbu1y1xRrIQSjPrNFDqPY0SH9vCTVnctitDBrDjynPQE?=
 =?us-ascii?Q?tq15QW3vrxlSrXgMt9mvczheh05nw7Xi6+GU52j/QKT/+rGIPO7gahsNXSVL?=
 =?us-ascii?Q?I7XHwwKX+rb3AXtzHkUuKhburaHe6Gjbvxqkr+iSNsj0zIIyGsqazU7gdyWc?=
 =?us-ascii?Q?J7TSrHvGNJ7ot61Msb2VaF3TKFUDJz+4cYAjiabRhII0CiDUCCMmb0u8K4q9?=
 =?us-ascii?Q?i7UAQGJ1P+GNfzRTqBBtkXs9ivTQ3ZZY9l3jDmjbw7CZ7w43tPE5DbMhq161?=
 =?us-ascii?Q?LtQDYqwpvv2Lw/x4Tk6pwrzKiCASVPv52xdYP6/vCoz2WC7hA5ruASK4AYCg?=
 =?us-ascii?Q?xwwOxVloC3l5VLvRlxNL5EV17GOTnWv1mJQ7S4KrRoz/DdBsW+HdtF+nYcU9?=
 =?us-ascii?Q?insXvxbBnvAJYtOqAj7HMJ5P2c/yC9sjR12rL3/m6WYVDH7OIrJKxVQ2KSlW?=
 =?us-ascii?Q?RH8Ag5FBu4D8u31vHEAm9kMKCv0TbCcOb+UOIZtE4pt3zK2QfZNYtxL6koJD?=
 =?us-ascii?Q?aTkQHabxYk70gwn092KljhNCmM9iBPIvTvRI0GYkEMMquyOf4831vtrVv6lK?=
 =?us-ascii?Q?k00QYg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14af73ff-5c3e-4033-5a62-08d9ad174ec1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:46.8012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXBuIzpTujrjV1CBsM66aiudKAFRCIYaEsHo0JM2ot0/BAQQAGc8xIC1FpinCvEKIG3JbM2aau1iFxQD3Xh90yW/xffk9F58+O0hmhc7oXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: 1J8zI83h7KVol-OHoNYMEy6TZa-Z76_d
X-Proofpoint-ORIG-GUID: 1J8zI83h7KVol-OHoNYMEy6TZa-Z76_d
Cc: Christoph Hellwig <hch@lst.de>
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Since this is mirroring kthread's sig ignore api introduced in

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

this patch adds an option flag, KERNEL_WORKER_SIG_IGN, handled in
copy_process() after copy_sighand() and copy_signals() to ease the
transition from kthreads to this new api.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 47ede41b19c5..ef3a8e7f7ed9 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
 #define KERN_WORKER_NO_FILES	BIT(2)
+#define KERN_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index a1ba423eec4d..6e6050d588ae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2211,6 +2211,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & KERN_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
