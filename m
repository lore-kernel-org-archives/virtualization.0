Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7592C43461
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E6A61440
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E6A61440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF7A41885;
	Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0c9yOT6OeBqZ; Wed, 28 Apr 2021 22:37:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC36F4188C;
	Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD11C0024;
	Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB169C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA60B844DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="OwQEw2oD";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="bJTBPxmG"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oAEkp5xw5Icf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9019844CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTkg9006961;
 Wed, 28 Apr 2021 22:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=pMyeBPOLrDmFQilpGV1TNOZnZNpNYo7MC91C4D8eBKo=;
 b=OwQEw2oD4uPlhFRzCGsGVL1JjGxD51xQWkHod4J4OYgNO/SkkAu3m/m6t9Khv4IoTJNH
 GnpN+Qn8qF6cT/uJ/7dKtuNdQFdlMAC3fB3H9d2Ig+0Efc9WPf3UvkVEdZpnyTOzXh5A
 XD5uGVItMtS7vBuXGICRPWdnRIOUqkf+HphXmcJxbFzFJwrapj3xwg2H73In4KAMAiGB
 SHV3V84UvfnwdNgNxh0QV2Pj6eqxMPHuyNgD/+x6LGPfg/Kq6xb0YvPDbf7SLe75tgOl
 3eytHh7y2/VR4esG8puOCKmeTmcfVzEcn13rvX5cYH3Fk3ermBxn0jcpBwW0EHa0gjt4 TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 385ahbthgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTquI184275;
 Wed, 28 Apr 2021 22:37:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
 by aserp3020.oracle.com with ESMTP id 384b59a4r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPbYouWBuEY8NjC41kVMoiaXw0kB3zLO6zo9R/ubI9D0x/lbUurrCLB4z2fSEDMwXn84aZ/W3u7U/BT8k/JVJ4e2v22zgS9l2rAv3pnhpKmYW/qMrc1FnQ2BoKgVQtdZMHV93YuL9NQONi8UeEVkWngJxrD09KZccy/y+8714CB+6xT++v+pnuyRJKfIYvZsntSoc5/WeMBcUOtglS50d3BQm9cdZwlttJN9M8gtMPKZw5f6X1UBsfg0Ju4C78XphxlIoF42/H8CRVJqUjcjaSIHKgwr9OIRo/fZS8BJNyj/AcJOVkmOKi+9CWPsxBcAiSCga2k1GwnbEPx2117yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMyeBPOLrDmFQilpGV1TNOZnZNpNYo7MC91C4D8eBKo=;
 b=ZC2KvUnWolREf0vwZap3TqeAz6c8qtDnlA3F7JkgZQG6V0tmPoGgfQpV1L7r/QRt4weeIRGggf0FnpDLbuF+/eR4ft0RYt+e5VAA7z+48eBrvUtYCnfr+w7qyji+UaJAYOKnkiNgR1P+c9zZi0yLOJEtjoCPFtTnzb8gtA16/hoY2d2iMQ9MHOiebjG7So2U3H+JATD+lsTg9xRxt2XbOB4RsjLYMuFUcEt7m1Wcyp3fb2XeIzyShRLLfGECi0YffOslv6laV/S8M5IotTathw9rEcwbbh1yKZ7IqDkiRQlU3KLzt5hzAbq28sjt1FDvf3aVH1q0kgG7nGWx+W8vKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMyeBPOLrDmFQilpGV1TNOZnZNpNYo7MC91C4D8eBKo=;
 b=bJTBPxmGsJkI1PFwOLLKrgYu9vVFw/D6OKpSwObsXVDjhK6qazOtTBUNk84im0q3cE32WA94Xxj5dOHi5MklVjGqxelcj7RSbHKTKyMqqpiiEogOjX3W4hPez7VpbJjnHlovPg2Ynq9YcBw1fvvFKgY5TsntDbA2m+fdfXcLZXU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:33 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:33 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 07/14] vhost: modify internal functions to take a
 vhost_worker
Date: Wed, 28 Apr 2021 17:37:07 -0500
Message-Id: <20210428223714.110486-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428223714.110486-1-michael.christie@oracle.com>
References: <20210428223714.110486-1-michael.christie@oracle.com>
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR1101CA0019.namprd11.prod.outlook.com
 (2603:10b6:4:4c::29) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0019.namprd11.prod.outlook.com (2603:10b6:4:4c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa2c0b01-d6f0-435e-eb14-08d90a96370b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB37021386FCD43717984AEA21F1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEglPWPtgUBHImnJfqviiefozgitau/AJnJga3xmJrwNuTR3EnvISIFxIFg3+jftcKaD4Z+I8KkXeENOx4YDOT6haIDgjxfAO9KYpjPVBeEIe4j4rDVB2YF51T348y4MQ4nvUv/Xdr5Owre0PeyH2ILMdqzhyHrEeriJSfsmwW0tT8bKOgZDC2erY4IHA4+hKyIbFBOGkHjliTnF+b0AhattIf/VMLGz4JyoW00zbURA1ZXYv+8FdgVMToJbx0sak4F1xjKP7ILhY/cdIIz0xyRfG0dnba1ECehLDnaVdaAN6PDWCxNN5/7ypbX6ZNe2hDd3qdq88Ltf80a5/GoPBI5Ji/+uLEsRghfRCUpYm7UC0lcOTdeBNWD4LK+V80Omh9mg3U669fbOYCkFZkC9VWdYvXbi6V6mgaz08DDpVVvFDRfY/RhKGIYUiu+CMeG8HUl+/xPLbcSl7jIhpvHlCugACxYQOtMgEEH0HEN/bxh/lomR2Blmjtwpaf8/u5gQyGfgSl7wPQK1VbXaHXeu5ivyrENe1bIsJLwxChtcrGayLQ3ci+IQqZbJfJiD1m80nuf1Eo/UB2tAmklaR8aRZVnXmL9qyrCIK0j/V2GJKAKYb/Ivm13w4upV8Q7sNz8uCitL18Z0qIcESods4WT50KV2DjSaAJvzrdS40jxa7vLLGsS1tWPo8xJrNjWisk6b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(83380400001)(6666004)(26005)(66556008)(107886003)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(4326008)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SVKORLiEp2x6A2jN7ct/Lu6AvMuupwulg1vpA4hnpU/5PQXNnMUn8731np4H?=
 =?us-ascii?Q?3T1oaT4ZtAPNtYmvKXwaiS1D+5vjEHO3wnrLtr2X6FzSdXrWerPC+P34XNd+?=
 =?us-ascii?Q?TgntYMEuS1xPYBTde1ojjXXZ3gPwqevHD+HnqfgSpK2tQuxeiAuvD16O8p0N?=
 =?us-ascii?Q?QV6U39KDRJCgvf23W2c9BZ6VLiXF5tMjX7ZcQH1HZBaFwLz/u+8MD013iPel?=
 =?us-ascii?Q?A2msqoT0u/20RwZ1EnKgq65uOhTjawiu2g2i8v0WSSAGExf4tz6Z/N0INwCX?=
 =?us-ascii?Q?ZYIZ9Vbxg/M6hGZcO1L26pU6sIdZGPOP+4c6voHKh+Y5LS5v2FqXNnKr/CBY?=
 =?us-ascii?Q?Wad8LwoJoWstW+PCzHQ5QrPy6wZav41Eu2AWpifR9CYKorlje0xjo4CbeG/T?=
 =?us-ascii?Q?DEvNjFE5Oz09PeQ7sIKM/hYj2WduXd5m1HSXgGj/gEl0n0/YErGo3eRQHpvh?=
 =?us-ascii?Q?CAvxTqQVQgvzL8I0Z6IOot1oZcR2YdWNfbbMCZXnJxsJti9HqEsfLlVDRT22?=
 =?us-ascii?Q?QfOXXwothJvKgjKl/CxuXvhXGlzqzEDx3MNU6mitxApW+MFaODsQY3Icy89J?=
 =?us-ascii?Q?UqAbSGDvmAugM7lkgmu5enWW447uvoSkZqkIR8aGHeDLCachqwnWoXxxc+W1?=
 =?us-ascii?Q?3eHn91XNoNRm7+HVzUhsFVTGed7FZrvRFvIpYGwR4rewxApadY/dId+FR/w3?=
 =?us-ascii?Q?bjRrAaDFBsteXoV/h6x7a3n14lXQgm9DWZ1S7RR/3fWImm3FR+Z/0bnmFkU7?=
 =?us-ascii?Q?pJWXhv0Ftoy3jS2i7ZIGRC02WfA7B/vppmyCI8zvXNRLPHS9LFStO2p7pu+W?=
 =?us-ascii?Q?p7NIDPj2Ip1LnEp0KZRdpFD4dlRpq9hgpVV8sJzct7VxI5FnIBxkyZkJmTLX?=
 =?us-ascii?Q?FKMOQtjovebghWxxiCRGum8K9qEG11yTLPMCVqjWeihOzqa4kgbaQUVPWh1r?=
 =?us-ascii?Q?TEgonCz4G6OLJQ8f4iBzKNT7O8CXXe/TsVXuvZX+OVzV46F/ey1YwU+js70V?=
 =?us-ascii?Q?YrCmh/tA8ACxMv7evUgEZhjaq8ANyStZwiM5PRaCT5QumdIqoGUkpyUkX8TH?=
 =?us-ascii?Q?rgmSipU/W0dYLSc5HMiEk63KVunLeF3kML2Z/9Q3jc9YUllRR67FcZ2oqvuS?=
 =?us-ascii?Q?pFUFB1S6JfxgLxnFBj9rJ2QsMNTN5eYyUmOh0FTi3hDIYOrHKNvRjxKVcdz9?=
 =?us-ascii?Q?lwi9fpG/uXlLdyDjZcgVrSgUnuI2W5w8tJpoifMAFwj5sru4T778lU45O8kX?=
 =?us-ascii?Q?MDhNBhGJVcGLnAuN2wG9285radCRa16QHXDzHk21ygHfhDumfSRFWHhwA46K?=
 =?us-ascii?Q?+mFUl8zzOVLkLjExSm4pZG1b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2c0b01-d6f0-435e-eb14-08d90a96370b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:33.5975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB1zqmndFmXphUSc4sj2J1s0hbhdPve5YYdBFparn6FjBR2ZB2dIEuhIMrN7NMeP23txg89sA0DYs1nbxIoJrTT45UcrMtvor4Qo7wX9PJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-GUID: 7aJ9yHsg-WT5imd4ws2wPjUEOYLPOJTR
X-Proofpoint-ORIG-GUID: 7aJ9yHsg-WT5imd4ws2wPjUEOYLPOJTR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
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

The final patches will allow us to have multiple vhost_workers per device
and be able to share them across devices. To prepare for that, this patch
allow us our internal work queueing, flush and cgroup attach functions to
take a vhost_worker as an arg.

The poll code required a change to the driver, so the next patch will
convert that code.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 136 ++++++++++++++++++++++++++++--------------
 drivers/vhost/vhost.h |   4 +-
 2 files changed, 94 insertions(+), 46 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a291cde95c43..4bfa9a7a51bb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,20 +231,6 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-void vhost_work_dev_flush(struct vhost_dev *dev)
-{
-	struct vhost_flush_struct flush;
-
-	if (dev->worker) {
-		init_completion(&flush.wait_event);
-		vhost_work_init(&flush.work, vhost_flush_work);
-
-		vhost_work_queue(dev, &flush.work);
-		wait_for_completion(&flush.wait_event);
-	}
-}
-EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
-
 /* Flush any work that has been scheduled. When calling this, don't hold any
  * locks that are also used by the callback. */
 void vhost_poll_flush(struct vhost_poll *poll)
@@ -253,26 +239,62 @@ void vhost_poll_flush(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_flush);
 
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+static void vhost_work_queue_on(struct vhost_work *work,
+				struct vhost_worker *worker)
 {
-	if (!dev->worker)
-		return;
-
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->task);
+		llist_add(&work->node, &worker->work_list);
+		wake_up_process(worker->task);
 	}
 }
+
+void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+{
+	if (!dev->workers)
+		return;
+	/*
+	 * devs with use_worker=true created by tools that do not support the
+	 * worker creation ioctl will always have at least one worker.
+	 */
+	vhost_work_queue_on(work, dev->workers[0]);
+}
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
+static void vhost_work_dev_flush_on(struct vhost_worker *worker)
+{
+	struct vhost_flush_struct flush;
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+
+	vhost_work_queue_on(&flush.work, worker);
+	wait_for_completion(&flush.wait_event);
+}
+
+void vhost_work_dev_flush(struct vhost_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->num_workers; i++)
+		vhost_work_dev_flush_on(dev->workers[i]);
+}
+EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
+
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return dev->worker && !llist_empty(&dev->worker->work_list);
+	int i;
+
+	for (i = 0; i < dev->num_workers; i++) {
+		if (!llist_empty(&dev->workers[i]->work_list))
+			return true;
+	}
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -482,7 +504,8 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	dev->worker = NULL;
+	dev->workers = NULL;
+	dev->num_workers = 0;
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -531,14 +554,14 @@ static void vhost_attach_cgroups_work(struct vhost_work *work)
 	s->ret = cgroup_attach_task_all(s->owner, current);
 }
 
-static int vhost_attach_cgroups(struct vhost_dev *dev)
+static int vhost_attach_cgroups_on(struct vhost_worker *worker)
 {
 	struct vhost_attach_cgroups_struct attach;
 
 	attach.owner = current;
 	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
+	vhost_work_queue_on(&attach.work, worker);
+	vhost_work_dev_flush_on(worker);
 	return attach.ret;
 }
 
@@ -579,20 +602,29 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_free(struct vhost_dev *dev)
+static void vhost_worker_free(struct vhost_worker *worker)
 {
-	struct vhost_worker *worker = dev->worker;
-
-	if (!worker)
-		return;
-
-	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
 	kthread_stop(worker->task);
 	kfree(worker);
 }
 
-static int vhost_worker_create(struct vhost_dev *dev)
+static void vhost_workers_free(struct vhost_dev *dev)
+{
+	int i;
+
+	if (!dev->workers)
+		return;
+
+	for (i = 0; i < dev->num_workers; i++)
+		vhost_worker_free(dev->workers[i]);
+
+	kfree(dev->workers);
+	dev->num_workers = 0;
+	dev->workers = NULL;
+}
+
+static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct task_struct *task;
@@ -600,42 +632,56 @@ static int vhost_worker_create(struct vhost_dev *dev)
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL);
 	if (!worker)
-		return -ENOMEM;
+		return NULL;
 
-	dev->worker = worker;
+	worker->id = dev->num_workers;
 	worker->dev = dev;
 	init_llist_head(&worker->work_list);
 
 	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
-	if (IS_ERR(task)) {
-		ret = PTR_ERR(task);
+	if (IS_ERR(task))
 		goto free_worker;
-	}
 
 	worker->task = task;
 	wake_up_process(task); /* avoid contributing to loadavg */
 
-	ret = vhost_attach_cgroups(dev);
+	ret = vhost_attach_cgroups_on(worker);
 	if (ret)
 		goto stop_worker;
 
-	return 0;
+	return worker;
 
 stop_worker:
 	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
-	dev->worker = NULL;
-	return ret;
+	return NULL;
 }
 
 /* Caller must have device mutex */
 static int vhost_worker_try_create_def(struct vhost_dev *dev)
 {
-	if (!dev->use_worker || dev->worker)
+	struct vhost_worker *worker;
+
+	if (!dev->use_worker || dev->workers)
 		return 0;
 
-	return vhost_worker_create(dev);
+	dev->workers = kcalloc(1, sizeof(struct vhost_worker *), GFP_KERNEL);
+	if (!dev->workers)
+		return -ENOMEM;
+
+	worker = vhost_worker_create(dev);
+	if (!worker)
+		goto free_workers;
+
+	dev->workers[worker->id] = worker;
+	dev->num_workers++;
+	return 0;
+
+free_workers:
+	kfree(dev->workers);
+	dev->workers = NULL;
+	return -ENOMEM;
 }
 
 /* Caller should have device mutex */
@@ -750,7 +796,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	vhost_worker_free(dev);
+	vhost_workers_free(dev);
 	vhost_detach_mm(dev);
 	dev->kcov_handle = 0;
 }
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 5b1e4cdc7756..9eb7c3bf0bd6 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -29,6 +29,7 @@ struct vhost_worker {
 	struct task_struct	*task;
 	struct llist_head	work_list;
 	struct vhost_dev	*dev;
+	int			id;
 };
 
 /* Poll a file (eventfd or socket) */
@@ -155,7 +156,8 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
+	struct vhost_worker **workers;
+	int num_workers;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
