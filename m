Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF7C433ED
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE72B6143D
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE72B6143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 846A640687;
	Wed, 28 Apr 2021 22:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9_nMKXjctNl; Wed, 28 Apr 2021 22:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECB5C40685;
	Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C2FBC001C;
	Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B712C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CB834187A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="msyuvWLq";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="buv3enZB"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDbvZ3bKjBKM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 313AA4186B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUKFW170839;
 Wed, 28 Apr 2021 22:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=w0C/YRVZwIr8DLYDJYl3nLzlEwiGE4rZYC6WF3ucdZA=;
 b=msyuvWLqxhAJQarbYXARkP27YMr/hyWAnMDPqkca73y73vIEC4Y3d7ChuQJp8MpzBgxh
 /+NGtQaUoXFgv7NxBukqhA9wBjQbctObhQLcrNpDESm9IXZVLb5G5hkEi4hlmfTWpGLE
 7FRU8zHQWdh1tjptorqpCD759GW8QV1HLUafrMjxPaZr574X+IgzhvZK1x3sd3SUIcUD
 FL5iQe89g/fOsoFk6I33vRpY/LpFmIkCfyLE5TJXFn4t1QzOxODNKujcWX9Q8jEtRGKR
 4LXg9xrPJQcVU8ligxL4RC/LD2aaoaHofkSQ5aHj1ODwK/uBFymYwsBiLMpKF19y2Ebj JA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 385aft2gwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUZCT116152;
 Wed, 28 Apr 2021 22:37:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by userp3020.oracle.com with ESMTP id 384w3vb0qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/zUfhb+jHxedxQmSPsLN8cWc44nhVDwq0/nxYnP9HrJefFj4guftVXdyH87SsNKPxmyy+p89vc+GKCEZU+JRqDJdt/RdNrg6P64BRLStpyJZOuSO96pZT/3P+Y9idxCrTe4GB+WJVkO6R41O2tT+1m8AOTJNTHPyms+6W6wj3fB1iIk/Q2N3SygvqIAyIGoW3mVb1BeOsiK5raU02zuBrntYJmzFuhObRcL7w9yJmDb3LtczE5VYo9k2UZMBnDwFax5PpaTn3QZ2fhG3KuwwsePn6TEJrqfqk4OUCfyXQofnLoOe9V4ub4O9WoXC3qxCxWgpG3w084UIz0Jf/4/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0C/YRVZwIr8DLYDJYl3nLzlEwiGE4rZYC6WF3ucdZA=;
 b=ErEt8yzlvrq0mq2oBfMWSLXAsnZXzYzkdwS4h0r4XLGkNfTHgwQcCdsPEECrvqSuLt07TLF5dGvyYGBhowji5m96J24QL6vKknHb9SKMLwHsvA7SFWoP2imW5S5MKyhAhJqEtRCBfIupcSEjXOf7fTaLRKkHIwcBOOcm400dbExI0W9uMqQeLrKYqeHosHonGydqUYWxWp4NMlfvJDhIby88hXUv0aCkS09LxFX+0xnVHhvCFEIh5z1snX/Pe/KUXx6tBXB5KfWLo6pisvRRxZbq7l0TUI2HF0mReVUsyCS5kLRQ5ECEUJLwevM8UseqHYd50AopJym2k5LLxswlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0C/YRVZwIr8DLYDJYl3nLzlEwiGE4rZYC6WF3ucdZA=;
 b=buv3enZB2uzFWnv23pwvancXt+0JBuW9QWWP3eUFF1wjM/0l6l22Z1Mt8ydgSdGgAhRFDu5itRqd6l+jEDKngwhDNxcK2TKEDHZIEpbD5xeWIUm8wsRwGV4rCKySW6X4HnH7ajDppwAKhmTA3EO99tA7EMv6oOHRYqMetSVLD+Q=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:30 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:30 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 04/14] vhost: fix poll coding style
Date: Wed, 28 Apr 2021 17:37:04 -0500
Message-Id: <20210428223714.110486-6-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972c3058-3dff-4f06-ce59-08d90a9634f2
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB37946BFD39FC075F745CFF41F1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNWRsR+z0TOX+C3af2V2r4jtC31KdkLQEZHgJqJGQgBuujs7g78X1fuIJ9LyhhWZbbFXGwAamqXUpT9pJQt1REPKThR4YCJe7rOHrp96/Isv+nG8bpPnW8ZIu4CgWjGtmVH9UHgCOzR7DZlfuf6VtUOU5EXEd4D3xXG5gOZU16vXZdQ5dHMgYXjNSAdt6wZwRcFyTyjJHOTT6rGtMFQeB5hubT/cyeYtnJniC45QWmhjqotx+br+37vg/KEMz/st/1K0Ak1ZyQxeMmRrVm97t289VdlnRSCeWJSaUTKQAUn9SozOow6Wf4tW7oCLdDTosPo5upjes5+JbdH7khpEicskjaChNki1vKhzwkWvtlEmpmaf+wK9lrWnFN3N8IjSaogORg0SQh21CRfGY5zXCz59fHmkGEHF2m0Zgy7pIEdNMqTQsJq2aMnOIFUa0kYrvDHt2S8IwOFKRzqBdQYceY7ZkZldLJCMnIfJPHnkF7Waoo2HQsyOKKdUpz3Ku6/Wr5mLGvxgiNdgwE0347Pw1xQ1Q8sYr82d9SrWZgJrsrxP8XdQpxhljt7yCqZ1JOA46oAhvJKXIQdwc+6VxZ0XeMGnx/NkEPzE2xmQ86z+sgVO5FFzAa+DoLP8hYuiulSWRS6t8cZ/+qMp0QCaM1R6vAzSnUxL9N6GIfRqnSpvlQXNQPUPYSIVKcnZW4gVpG8p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(54906003)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xZ4KXfmdrEBhpF13HZrgh2VZofKH1rP2ATEYL3iIyGNt/EIzSA9U0MLq03+5?=
 =?us-ascii?Q?Ay77I1DNMhsieBTT5TD/dtw35yi42GSmi4x8OGVQGo9TNMI+5jCiee4ZqZ0/?=
 =?us-ascii?Q?EF80mM6HiaSxe7WLBr6TZHYUdHNEtQLfX3ioGPKNdR21w361rqM+4m3EFVS8?=
 =?us-ascii?Q?tKFn7rf9z+y/h2Ii87hfaQgk778lD3euxkEF2hAbM531FWPyfHvYBM+AH+F9?=
 =?us-ascii?Q?sxPSp+pBE6aiFaM0t0SfDZByPRyOsXMg3JZi4boHLaRKfmBOmCDA20JwHxze?=
 =?us-ascii?Q?2MIkS7wMP62+F/lLoxWYU9Zl14jjJvLVafrAVuQHvwR5WfswL2AiB5EEuAOx?=
 =?us-ascii?Q?wgIc6hhOa/4TIjsJdFHo5IWUCSGpqxupvvcRM1Ws0v5281Z3uLzZTVNgxye1?=
 =?us-ascii?Q?Ibn7PKXTR7b6HTT8nvUdgsD+IznfITc+L645sipFIbZOdrGk9ust9blRHb7r?=
 =?us-ascii?Q?TJGC5JoRfew1pYX3ZwO8klaefF4YM7M6wD5rxk/ddiHDAhfYAqHCrG+jiDjD?=
 =?us-ascii?Q?ng02UcZUgbl4b3mauEN5xf8Wzbo1m2lJXvJA6q7XCeeSzsp7lVDAK30GmofL?=
 =?us-ascii?Q?WW4Xj3zgpO9OHwPuZdVQnYLbTz7FAKWF3XOOB7z9XKFBEuHboDQc8U8IluBE?=
 =?us-ascii?Q?xsIqt0HSJLfSaz6ue5VvLxsjKlz5zs3HpS5gmU35skfHAe5VoWeyTcsblUWY?=
 =?us-ascii?Q?OVsjJEnwX+B1/KpTKLJWAk9lNavFyQ/FtBEDP43TvCzbpG3P4frAf5UY041J?=
 =?us-ascii?Q?w1ZkciQmwKNyaum0auZm832OvvA6v++ZT+F0ZBaj8+ShiS3LxjHXZmA7OY6x?=
 =?us-ascii?Q?wohpc/pZCWwKmNgAxghVYSi34xtRvO+o2qOmS9d/6Gso6TfAxpdNFNFb2AR8?=
 =?us-ascii?Q?WuKqClh7lwOR5TclkxV6fMzVhUAMz/ljN8HMgooxhh9NiSlx8nBSb475y6ZH?=
 =?us-ascii?Q?TX8PLtFL8Erf3VrQMIkQ0SVeE5+t2e79jaCSXIw/rWmElixIg/YR3TyxP186?=
 =?us-ascii?Q?2Mlwyo75gIOXmtVrYb4GI8bx4Z/nugqxVXD8B3q5yrN4w34B7PksF4wjNV+M?=
 =?us-ascii?Q?QWZ64yf7Sh/LOCdrUmokEMcuL99BAPGG2Yc2f8yh4dTfaNQIYOQLDE/clxBA?=
 =?us-ascii?Q?pnC6UVdclkujTmUxT4xk2I14Z9K1TOwcF0qQtXdN+mVzjRoN3z0d2xnN1HJU?=
 =?us-ascii?Q?kbdo4YZVKTGueFm9DH3nrL0Xrp4xyLW8+FueuVeWA25wMqrVv6r8ZCGsUFxQ?=
 =?us-ascii?Q?ZK6bHzK9jkhbKshVDcaDFWXlQMlRTnQ9TtAtq5Md05UKmxm7Qor84j0HYdgd?=
 =?us-ascii?Q?oUxNjYEUNRrT5c8AHAkqGIE8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972c3058-3dff-4f06-ce59-08d90a9634f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:30.2424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5YwleZcqmNRFz0IC1ZtWiVhgqdLgGHQO4YHetCajSUIF2E/hkA5CTovb3VKCfkT/EJmlPsetU03oeuTCT+pNm8fp9axbJfezHeRcpxzdkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-GUID: ScoxdvxGIQeuH6P3cKj6UrUtEEtDP93L
X-Proofpoint-ORIG-GUID: ScoxdvxGIQeuH6P3cKj6UrUtEEtDP93L
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280144
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

We use like 3 coding styles in this struct. Switch to just tabs.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 1ba8e814989d..575c8180caad 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -28,12 +28,12 @@ struct vhost_work {
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
-	poll_table                table;
-	wait_queue_head_t        *wqh;
-	wait_queue_entry_t              wait;
-	struct vhost_work	  work;
-	__poll_t		  mask;
-	struct vhost_dev	 *dev;
+	poll_table		table;
+	wait_queue_head_t	*wqh;
+	wait_queue_entry_t	wait;
+	struct vhost_work	work;
+	__poll_t		mask;
+	struct vhost_dev	*dev;
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
