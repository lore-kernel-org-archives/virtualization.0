Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E20C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B0E60FDA
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06B0E60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC02340442;
	Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FcEEofEreLoY; Tue, 21 Sep 2021 21:53:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 590D940401;
	Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30188C0011;
	Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6AEC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9532340703
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="kORSLopR";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Y24jVUHg"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGCC194GbeWO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B0C4406FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:00 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEBDk028874; 
 Tue, 21 Sep 2021 21:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=OLIZZMLyEf1NfkscHwGARQnAIyr5646nMq5XwCJtd5g=;
 b=kORSLopR3VbrS1vSz3dSORALqgIGwWNmEnbKXp1NyD0f8rXbQ3gT70I8YVCAufbgvZhp
 5WZuMN4ypGsKu8HenJir/jkiGNzx85JyEIQvJ85atTfX1rneupYqeJWICdEtjhu5gDXR
 wmgpaY8JNjBvcNZW08cAVJzOpPaWS9B2sPQdyUCAVYrT4VGjnV6ti7AZID3dkDTkSPcv
 /L5IIwzdQ7i0diiS2/TPoVf3KyCG2tV3YzimD3LvhQ2VRnshqv8/Lrx2ppNpY+lBKSzY
 WSMVBo8KNQje3nqpLxL/039ZhGsh9ILDbMhNobPyKu0OOrxWLLgRCfQTegv12+U/kyks Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4r85f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLnv9g106589;
 Tue, 21 Sep 2021 21:52:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
 by userp3020.oracle.com with ESMTP id 3b7q5v97j1-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QklT46Dki+JV9NYOrD6gtFJrxYqplXkdHNBEfjJMdaZIf9uGd4B7DPsBROuK4jQkDJQL3KbqCugbjXs349n3RqFeANmi2qoEfL2Bf7gmXBMzRLq3McCpyZTY7yp9SdNvRVStJbDbaxUhIMgREUUjWv771zcif+n+TmxrgAJIPlWzIXdWmdf1RhVV2s6M8TU6m0iw1a+7vj1BTc7B86Jwo54ueJPHIaljvvBz6CnfmfOHIOGWPkY/l4GDszzZ10vqI6r+Vugvg1K3SXef2LaU61d1gWxv43rbd0XFcCoBWaOr20yxVGJR9SraH0krlPxTVETuZ4R43EHVxm4xvTJncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OLIZZMLyEf1NfkscHwGARQnAIyr5646nMq5XwCJtd5g=;
 b=TD4McsiMnrWjxSbvu1FOCZFwfhAbyWj1H/tG2t5+smbe3SDI3FnWJBLhk8jKGYvIq0cq0re/C2e4a21KMoIk91c+yxTMj8xTg5V6gBEVo/fDJNuMeWWiobTSMgyuUyCyxnLAXNKUvIxhJo5uOiMo3PdCaoe52CHueWH2tSU/77ZP12nP2UprqBDH/AfgreeLEJFUvIH072qWuyCaFHG2FxW45A8n4amOYSeDrohpHgJ7zQn1jWFDvBU8VfrCee2y7Ts+nDSEz7tvDjRb9UR8PuRnGCbhTxlTNBT5dPcy8McNUqhGOQPjbYmCG+ie4kAEYF2j9tg2IfziZHLfcJtdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLIZZMLyEf1NfkscHwGARQnAIyr5646nMq5XwCJtd5g=;
 b=Y24jVUHgfw2mkn/an2JRm7xwcOhVL6nYLL2OjyaAGfQuYqNPq21XJYil4WYl2ciNnYGtCKG20grhGg1tL8rGzDczxDtq5ZhCL7h3KmqDEEi9aUbvPtSlYLD3r0s2BBXikMFYg1DDYoKjX9+NjWlZoz4SuhJQSma3zg5iJBjDdog=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:30 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:30 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/9] fork: pass worker_flags to copy_thread
Date: Tue, 21 Sep 2021 16:52:11 -0500
Message-Id: <20210921215218.89844-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210921215218.89844-1-michael.christie@oracle.com>
References: <20210921215218.89844-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7996a1-b18a-4f7e-bbce-08d97d4a1c11
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3892AEC97CFD3EFFB4A8066AF1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KMnBFS+yccoOTKJf2HMpoj6W7GLMWfpxtJ3H8dN1295Phc/jW3Xy4bZtOZAX4pCv2fH8bUtZ26k7Ti+YyQ10JRoyBK3JoOP1EsAE0bFph9bNikcOoSAOCyjCA4AQ13rzudWQ/2tDefnyZV51vFu5SRYFXArtbaXSSOHUY7xddUuyLY7tguwuNKyVi6yLGx8HQblGVyvv8Ri94c3mG7XjhEygB+Y5Izz7L+f1KG9V6O+LMO06fkRF4bN9yEfiIE0cgi27XomShTXIEMQYHBSIN0g3LJel+82JhImIpGxPNaQgMbgnyzTe/m/xSnQ4RcZ5Zr14NxiWab3ZxY84BTp/qqNa1AKiqG7BnOpiFY6EXAw2qYd47pY7E9C9xhQJLPX6vodSBqK2Vx3fknNJDVM2UZ0qNsclwhHlUxWBUf/z0XTMtsdyeSKHaH4RhElvViVx15GCsWhXIvGojJSeigBGvaEEqC3VEYu+c4M/oA/XrIaCCz0BikuAv2g/0hvCryx9fYLKsHzNyA+2Qh4uu7hl8P/9ENOM5dwACgpygaA2FdlYbsDOw86Bsyn3Mr/HMlqhxQSG9sVdsfH40P/o+65s31cMAqX8HUtMMTnFUtfQsRLdbnF2F1koc3QL+BzYLb/s6W+Ja6B/tTKYjCc9G30yWKmguYfAsUgOfA0mAXU5MYwlrGjkKOHtB7I9hIgJ6h/C/iMVy0eKLhxELCDeJXeIdkzFyF+s8D1X+eAuc+CCXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(30864003)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFaluIbN3UjqVMQLeiEkLAYZBgWaDEikWSYqIKYbwO9ONtYeb0/J7iZMxHh1?=
 =?us-ascii?Q?lCFJJg3IN+gdLCU+BNgVNpmDUJIfJo3nB29O8H/ISJVSJ/torVP8SRjHnzlk?=
 =?us-ascii?Q?m7fYz34hsnD6DBQ5tRXaFmNhMNWEp1WxeFenr6kniIbPoHU0Lop5uEuMN1Fz?=
 =?us-ascii?Q?jMhwA3R0yG7UyADcTK/sRuccsyFb6Nj9ZwzjtX8bjlexJLWsoQFV8YxBVrtl?=
 =?us-ascii?Q?f9RLJ4ET136/pqAQ7mNfAfvpsrwdUzgedFEhDgJ8L32B5u3Lczw/eAr579g+?=
 =?us-ascii?Q?tGCou+UH8LLpQlqmE89SbOCWKgScUHnXXZ1RaC1Eyu3nXv8Lub/eqiZVLLT0?=
 =?us-ascii?Q?lImHAkLtCr9NPGLe3RUzMiRGVduUaJk4fCyzyqXABxmbrYUe/KteTcmRmTCR?=
 =?us-ascii?Q?MN/cw6gBR57Fxn5Jdq6chCfmZqDk4qnyDgSbYXbNSS9wGf4ZG/NanXQoPdTp?=
 =?us-ascii?Q?wFD9h1UVg6wwq3CHieIwsHZOHx4VTRAzRbV+hPS6+sN0QS886MWTU7msOObB?=
 =?us-ascii?Q?LAyuK9kfiCms6b3uoEvHcSgJF2t1xkeFBVkxlxYbSlaundeX/Pu1xZYykgyt?=
 =?us-ascii?Q?ax4f28vlkkiiGdP8rWp8dmshJHljvY1U45OdB3WLdTMxjcan3e/IRJ2C+hyo?=
 =?us-ascii?Q?qwZp3lboFYENjwiR6mN1OjEHGpX4wlfCJPhKcjBQH9keI9LHWFsk/3xIp3Qy?=
 =?us-ascii?Q?kZzyYRp9DorNJWXFM8eehpG9YMJgS/ED7x3Y1avHdhgvxAHEAcQxXCOc5HFx?=
 =?us-ascii?Q?eH2UFT7+q0gv2r1UsROFNsIWF11qe+AoE8vXW2jx58lMtFcPQC14zONNqXhg?=
 =?us-ascii?Q?pXvgL5QhwMwp3+zUSGzJmY64BGpY9SH69kOJkYYA84Y4IY/6JA3Vy04+pT0k?=
 =?us-ascii?Q?bcUR3ql4CIPI2Cz5Gz9P4CCc83uE7E8YibJOZRzD8xMH7TeA+DMWoFOExHMZ?=
 =?us-ascii?Q?mojgXr24rvHolkY2YbUvfMOoiBqUn1JyLRlDEyYfgq2KwM2FetRi06pvpV5D?=
 =?us-ascii?Q?fPILNxqzgQmMyRzBrJ/hqkOVtjHJZVYO3gx3GKXLxplKzrVvveogTHLa2uDH?=
 =?us-ascii?Q?fC0teKupioqlslL2wbSitYWguTUNdmS8fAc1BQid5VIbwq7Qekuig9YheMRc?=
 =?us-ascii?Q?dC+X5Mf5tCz09ndA+zKX9ULpgqbQdd6FZR8p2R+IcJcWayDZsJc64I2gUngg?=
 =?us-ascii?Q?z6dfJPcOqaZ8eXHtPZFvUafKyxhX7avj3pGMPGQ3JpWxBnvdbzbz4LmJqYOl?=
 =?us-ascii?Q?TYuSYIu4sL2rW2+nsdfXuCCv+W7wzO6/oy4frwpqkaLZ/8mtnajKSx72fyEH?=
 =?us-ascii?Q?CHlVpGSV+la3AvscJ5Io+ZtB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7996a1-b18a-4f7e-bbce-08d97d4a1c11
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:30.3650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlJzbw26kNQ6pOLKIwu0irI1JqOboeyq/0/y3So43g/YvgfIfEXo0wxIm5+yNM3FMyqKxNVyBuqG3mp6uiDUdeU4rH89QLD8HexSnPkaat0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=811 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109210130
X-Proofpoint-GUID: DnHi7AlSwMKK3uAcAix1KS0OzsvWFjGT
X-Proofpoint-ORIG-GUID: DnHi7AlSwMKK3uAcAix1KS0OzsvWFjGT
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

We need to break up PF_IO_WORKER into the parts that are used for
scheduling and signal handling and the part that tells copy_thread to
treat it as a special type of thread during setup. This patch passes the
worker_flags to copy_thread, so in the next patch we can add new worker
flags that function can see.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 3 ++-
 arch/arm64/kernel/process.c      | 3 ++-
 arch/csky/kernel/process.c       | 3 ++-
 arch/h8300/kernel/process.c      | 3 ++-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 3 ++-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 3 ++-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 3 ++-
 arch/parisc/kernel/process.c     | 3 ++-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 3 ++-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 3 ++-
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched/task.h       | 2 +-
 kernel/fork.c                    | 3 ++-
 26 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a5123ea426ce..6005b0dfe7e2 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -235,7 +235,7 @@ release_thread(struct task_struct *dead_task)
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	extern void ret_from_fork(void);
 	extern void ret_from_kernel_thread(void);
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 3793876f42d9..4e307e5b5205 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -164,7 +164,7 @@ asmlinkage void ret_from_fork(void);
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *c_regs;        /* child's pt_regs */
 	unsigned long *childksp;       /* to unwind out of __switch_to() */
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0e2d3051741e..07ae4444b6ab 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -230,7 +230,8 @@ void release_thread(struct task_struct *dead_task)
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs = task_pt_regs(p);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..7979ec253c29 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -316,7 +316,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 asmlinkage void ret_from_fork(void) asm("ret_from_fork");
 
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..f38b668515ae 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -34,7 +34,8 @@ int copy_thread(unsigned long clone_flags,
 		unsigned long usp,
 		unsigned long kthread_arg,
 		struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls,
+		u32 worker_flags)
 {
 	struct switch_stack *childstack;
 	struct pt_regs *childregs = task_pt_regs(p);
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 2ac27e4248a4..9a8f6c033ad1 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -106,7 +106,8 @@ void flush_thread(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long topstk, struct task_struct *p, unsigned long tls)
+		unsigned long topstk, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct pt_regs *childregs;
 
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 6a6835fb4242..664367be55e5 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -51,7 +51,7 @@ void arch_cpu_idle(void)
  * Copy architecture-specific thread state
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index e56d63f4abf9..a69cc33b5e32 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -296,7 +296,8 @@ ia64_load_extra (struct task_struct *task)
  */
 int
 copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
-	    unsigned long user_stack_size, struct task_struct *p, unsigned long tls)
+	    unsigned long user_stack_size, struct task_struct *p, unsigned long tls,
+	    u32 worker_flags)
 {
 	extern char ia64_ret_from_clone;
 	struct switch_stack *child_stack, *stack;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index db49f9091711..ebcea8a1b680 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -139,7 +139,7 @@ asmlinkage int m68k_clone3(struct pt_regs *regs)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct fork_frame {
 		struct switch_stack sw;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 62aa237180b6..b8eb544e1fd6 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -54,7 +54,7 @@ void flush_thread(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 95aa86fa6077..d494e1d76e71 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -107,7 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 391895b54d13..1ca8900f9d07 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -150,7 +150,8 @@ DEFINE_PER_CPU(struct task_struct *, __entry_task);
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p, unsigned long tls)
+		unsigned long stk_sz, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 9ff37ba2bb60..b49dc6500118 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -101,7 +101,7 @@ void flush_thread(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct pt_regs *regs;
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b0698d9ce14f..7b356a9a8dc7 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -127,6 +127,7 @@ extern asmlinkage void ret_from_fork(void);
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
  * @tls: the Thread Local Storage pointer for the new process
+ * @worker_flags: kernel_clone_args's worker_flags
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
  * structures.  The first (topmost) is the userspace context of the thread.
@@ -153,7 +154,7 @@ extern asmlinkage void ret_from_fork(void);
 
 int
 copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-	    struct task_struct *p, unsigned long tls)
+	    struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *userregs;
 	struct pt_regs *kregs;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 38ec4ae81239..d9555ccf1e9c 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -186,7 +186,8 @@ arch_initcall(parisc_idle_init);
  */
 int
 copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
+	    unsigned long kthread_arg, struct task_struct *p, unsigned long tls,
+	    u32 worker_flags)
 {
 	struct pt_regs *cregs = &(p->thread.regs);
 	void *stack = task_stack_page(p);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..d2f2301b0ad1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1682,7 +1682,7 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
  */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..3d0e6390f34c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -120,7 +120,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 350e94d0cac2..01b969bb868e 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -95,7 +95,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
-		unsigned long arg, struct task_struct *p, unsigned long tls)
+		unsigned long arg, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	struct fake_frame
 	{
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 717de05c81f4..d199805552c0 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -93,7 +93,7 @@ asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
 int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index bbbe0cfef746..6e04cfc64b99 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -260,7 +260,7 @@ extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
 int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d1cc410d2f64..b339eaa1f890 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -575,7 +575,7 @@ void fault_in_user_windows(struct pt_regs *regs)
  * Child  -->  %o0 == parents pid, %o1 == 1
  */
 int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct thread_info *t = task_thread_info(p);
 	struct pt_regs *regs = current_pt_regs();
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 457a38db368b..0815a43b9f4a 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -154,7 +154,8 @@ void fork_handler(void)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct * p, unsigned long tls)
+		unsigned long arg, struct task_struct *p, unsigned long tls,
+		u32 worker_flags)
 {
 	void (*handler)(void);
 	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..20d9bab61b14 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -117,7 +117,7 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+		struct task_struct *p, unsigned long tls, u32 worker_flags)
 {
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 060165340612..a0ad9f0cc0cf 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -203,7 +203,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 		unsigned long thread_fn_arg, struct task_struct *p,
-		unsigned long tls)
+		unsigned long tls, u32 worker_flags)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 48417c735438..ffc7c6a384ad 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -68,7 +68,7 @@ extern void fork_init(void);
 extern void release_task(struct task_struct * p);
 
 extern int copy_thread(unsigned long, unsigned long, unsigned long,
-		       struct task_struct *, unsigned long);
+		       struct task_struct *, unsigned long, u32);
 
 extern void flush_thread(void);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3988106e9609..3c3624786e4d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2200,7 +2200,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_io(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
-	retval = copy_thread(clone_flags, args->stack, args->stack_size, p, args->tls);
+	retval = copy_thread(clone_flags, args->stack, args->stack_size, p,
+			     args->tls, args->worker_flags);
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
