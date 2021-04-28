Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A13CC433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD366143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD366143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD6B44068E;
	Wed, 28 Apr 2021 22:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFbaJa7YbrMb; Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 159BE4023E;
	Wed, 28 Apr 2021 22:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2174C000D;
	Wed, 28 Apr 2021 22:37:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC2FAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F2EF41891
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="iNREf8lx";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="bs42JVha"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOklKz5xUqzs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74E7E41887
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:40 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMVeqn171387;
 Wed, 28 Apr 2021 22:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=2Y+fmlX7mDX9DwZKp2E/H6b98C+LTxDcyAA4Y++aPGk=;
 b=iNREf8lx1a2vVSCU9Emca17TM0h00TqEwOUZiuSUcsRoQpZ7f6V8PJ87tGLj/aKkwTYU
 4zzyZTqlPUhgBN7pGs3COMO6OrKvyWGNYbuZpFrgebfkNaifv7YSE5JgygztPDR6uVoc
 xu8gWGMT+/muPh6us1TH8asQGvQUCI51SfDRw/HRgR2xyOFR9IR+Xj/80dCV8KsV+fAS
 haXTgBFgv6oUbWHm0ufXADpJkaJzqsE5ehTklBvnUW/kNj/bufooTCX+0XK99Z5B4BqU
 XH4DGuDV4sj6/WdkpuBHDkxzaVLxXZlAgZRvLLobTMVdLVQRSrNcno9/IV8ZJREvNodm YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 385aft2gwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUkrS042749;
 Wed, 28 Apr 2021 22:37:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
 by aserp3030.oracle.com with ESMTP id 3874d2pbec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYGyC7HhkvRclKTyCBS/DC2C31WGKRP4O/LaKrWLrX45NPjkHa7PtCYxJQR8aENlI9W11p53HEuWKkqpKxameh1QuhHozqosLSGb6zJ1xl+yIt+062H2vVvTSh3ajITbW3Q8MrSpW+w6TZsQ6l8mXPIItCWB9OmAGQ73EGC8KYYCZoFweTEQ9ZgnLjljWbIsgXxTMQoiEjDkYqK6m6dkMhnW0cOckPSdGTyGR954B7qpZlYkfdyzFAriU8jzq+fsbo7zq5o5YuyW1uCkZI907bRZvPzVixkhJYH/+tgXZIVxxPGaMIOJzwQr5uPhDCv+3QiZGISPv1Xkck1DuQwFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y+fmlX7mDX9DwZKp2E/H6b98C+LTxDcyAA4Y++aPGk=;
 b=iIhKr8lFFmjRxSRq2FucPeKRCPeiygEaec+tU/YKUoo+rG/PAhUcONBR2x7tPlufG0uZrIScXCsziwNhLVzlH9HXmBmTCs/0HUtBfiKzH3DY1nOtfC6dV0PwNl6m8uPafimrirUilpt5oMPwjZa7YO59Ep5hEy7eNYRTqcO0/TcMdHYjJdWZ9ff0vZMWia6xW+iQLXN5K4EQpQdXsKf9uwxOl29zF1JJ6QfNducKThTUoPG14u4ueByffE6kcx88sDw9Tdu4Cwe3f/NCw/JyIZzdH7syIcBhDGwg1TBC/vkuBR7w5ovmjy1OvavmZwIvUgogCAVLWgTx+2bBXchTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y+fmlX7mDX9DwZKp2E/H6b98C+LTxDcyAA4Y++aPGk=;
 b=bs42JVhamYzKr0m9Ds9oGEuDLu+O2/JgTlaHAv66CiR93OUYb00ReyWbdsuZFF827miyEw/9opdCBjrXgK+VDQnxYvGNPlPJQ08E2NpiAA2fBVtfANze5NdRfQs3LaZJBZacUH0w1YRcjmM5ZEUwMRfCmjFWEx6HIMux04EA3FU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB3702.namprd10.prod.outlook.com (2603:10b6:a03:11a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 22:37:36 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:36 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 09/14] vhost-scsi: flush IO vqs then send TMF rsp
Date: Wed, 28 Apr 2021 17:37:09 -0500
Message-Id: <20210428223714.110486-11-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649544e5-fd30-4b54-e1fb-08d90a963852
X-MS-TrafficTypeDiagnostic: BYAPR10MB3702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3702D8641A6F7C4775B42883F1409@BYAPR10MB3702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRYqVRcHBByjDZLbdzWXd36QF1Vx8L9Anvph1reDEou2BsQBvdEIsbmjbXFi+9ymF7KGkaRHvc8z/f0qZMHJ4IqMvm7YTnu5ggZkAaRFhI3dPDnsMGV4WxSVQQv7cA8x3fFIiuEa9Wm/0QWq07iGeZJXcHa2f9sqKAaubrvjQEqsQU16DqF5n3fWq5NXCaSdZX1jLSX56rqE/UzUXqqPUsHyLqmt2EWaA2YOJ8jYGka3+BaW7WFKfqdgtPbmnC76YTUpkd6zPwjGsLSMhjxeX4PbcFthNe194s6/VQDgQbgjGvCAawrGFX1rpre7ZUOYQ00i84lOXN06KN7Uec4sx91PnSdN7t2kQpcwpA7A+uQmWVHAmDheI67AN64LzNmV6ZBtlC/ggnhbwFym0Y7CRC7/F2/3bzCOs1JkNX9FxFimuI47hl+7Ix0KmXuvg29tnlsdVSJIWlcBeifE9FMJXZ168u/ErdpXLHvKxu9n5X7FXDUswxO+YFl/uA/Y7dOsacdizULCNfrWqRue2Q1QsOOpfdj52sOyefKzs2G8D1FWZ+YzWG7OTvO6UCkmcesHlWuy0eDuxqnMq50XpFr8TXwzfvCukbO82MScpW1jN7Z03Tcyr8skT39sRn0N+XqwAejaSe52sQbvAjBGuiQW9cEsHrMTJjwDHvmQDy/BHH4vZXyAOTxcap8rV7cYhghL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(376002)(39860400002)(346002)(6512007)(83380400001)(6666004)(26005)(66556008)(107886003)(956004)(316002)(38100700002)(38350700002)(8676002)(478600001)(4326008)(2616005)(6506007)(186003)(16526019)(5660300002)(8936002)(6486002)(66476007)(1076003)(86362001)(52116002)(66946007)(36756003)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4thS9g6HpKa/OkcG+xiPeW6s7TkKc0Jn7p2ws4rQbeVrwp9gDZg5CAf78d21?=
 =?us-ascii?Q?0KTYMWx+FindjOyrqdgiAHaQCQkcCDk7bgpLxtKH9kT8l36TV84t/Sqlk1/k?=
 =?us-ascii?Q?LMI9IniVTX3LNitODib+70kgakkW/WtEIWrzgDSDP06cjQZ1NhiCdh//xfPm?=
 =?us-ascii?Q?oL/0TPLXCvSR+2HUg7FWv9cvIpogxoZsqw1FeIRgiqbSgkfNoYBfuHfiZDM7?=
 =?us-ascii?Q?2ArlRQBmSPbIqMj7miWjn6BKQ1fQpafkxKARx8wjWloNMJoHOtF8Sp9hP0df?=
 =?us-ascii?Q?7gYmyUTg7/ZdUC4z4R1JYcbmOFWpC66nPwvxDf9dufrc3bQGsMpqC5HiqfI7?=
 =?us-ascii?Q?iVk4vvxQzhRAf84Rhrby0LVRWsK/SYgffS+8fZW5YjoqhNTcF/IGnW9Zbdoo?=
 =?us-ascii?Q?WKrJ2Z/1rd0znOCBbWAdc3pOwfwUCoqFQ1BKMFzXwCl6BX6w0RnMVtSfyCC5?=
 =?us-ascii?Q?2TYpaYXH3WrIuDdmFxqKui5UjwK5I1CbrKvEtd3jSNHf4R0n4a5+enOKshoN?=
 =?us-ascii?Q?V6QNa7KAHSRRS3HApFH2wjRfQ7zkbMGXrlQY/xIg6Dqn3Jns2QzGaLCFb+Yd?=
 =?us-ascii?Q?yHX61Qlfvw4LWRHfFh4nyUHJS8RaDy8/rd5jpdEUoBHuMDGvJMlDOGiXTlUS?=
 =?us-ascii?Q?1LRifuoPe5Rc8fOP2kmIPMqMh1ICDC8DQ2sLEyTVu+OkmK4kHOv3lm71zNXN?=
 =?us-ascii?Q?XtT3zzYedokqqeJ1lY/SqSDL5mGZn26kbFuBUB8l407pjIlOekrFqhhKZSLP?=
 =?us-ascii?Q?TInYSd4GCAkR0QdyraMY2DHsOtOWPleEVcu1eESNx8Jm6UZE+E5vXJaC9rkR?=
 =?us-ascii?Q?VNsKOeOIyXvZZYykWj4ZyekLF45MaHVKIVCMXZhfM+0zXHGSS5NtIkApUu5r?=
 =?us-ascii?Q?evJPiup5S0aVX0gtN+98oy5ZETP3Oi1Dy+sZkbxosqBVnU7Pp/dpeeGfXNG2?=
 =?us-ascii?Q?k2Awhypp5iSNlr8eHQ0FfzOBhM+t81KXJd3fNtAl7XegmffiqLYaSn/1Cp4q?=
 =?us-ascii?Q?MCFZ7B7nNoaWJm/GYbRH3MTvb9nGrmEi5HD/21MsM/gocxKnHYb/yjbXj0LY?=
 =?us-ascii?Q?Xqpop3cDwEhNCk3slHKFbv53IoJSNPCosh1JvZQbv195ikM2vkRC+TBvhVvj?=
 =?us-ascii?Q?4yhlbY2w1EgTM7DYyo0W3iKLMRGwPHzR/Z4iJAk461KvIdqj8V9Ico7CQYX7?=
 =?us-ascii?Q?TOxLit2+VgPX26LUdwF1wjwJJUWaNUq+wJwabxVL6RKawJLH4raWGkC+EsZA?=
 =?us-ascii?Q?lSbXXOG+cgCFqg2RzFLio8Zinx62+Sv6iponjcepJQtmYPUys1VqpHyhOJCA?=
 =?us-ascii?Q?LxYWk3aiGAaQ3XbMoQY5zVjm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649544e5-fd30-4b54-e1fb-08d90a963852
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:36.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWIuhos1CfveKeb6jVYS2c33p4LXH4wk0FKZbdsaCf5Y2Zp2wbFPKjt/m4MCAVK0CwgxIhWhzXJRnhmT0bFOu/j+kcqGi9fN4Cpwke2uAl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-GUID: ErZlLu24VeeHNj9T0GsJcjULhWyG3Kxh
X-Proofpoint-ORIG-GUID: ErZlLu24VeeHNj9T0GsJcjULhWyG3Kxh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280144
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

With one worker we will always send the scsi cmd responses then send the
TMF rsp, because LIO will always complete the scsi cmds first which
calls vhost_scsi_release_cmd to add them to the work queue.

When the next patches adds multiple worker support, the worker threads
could still be sending their responses when the tmf's work is run.
So this patch has vhost-scsi flush the IO vqs on other worker threads
before we send the tmf response.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c  | 17 ++++++++++++++---
 drivers/vhost/vhost.c |  6 ++++++
 drivers/vhost/vhost.h |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 46f897e41217..96462032a972 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1168,12 +1168,23 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 {
 	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
 						  vwork);
-	int resp_code;
+	int resp_code, i;
+
+	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE) {
+		/*
+		 * When processing a TMF, lio completes the cmds then the
+		 * TMF, so with one worker the TMF always completes after
+		 * cmds. For multiple worker support, we must flush the
+		 * IO vqs that do not share a worker with the ctl vq (vqs
+		 * 3 and up) to make sure they have completed their cmds.
+		 */
+		for (i = 1; i < tmf->vhost->dev.num_workers; i++)
+			vhost_vq_work_flush(&tmf->vhost->vqs[i + VHOST_SCSI_VQ_IO].vq);
 
-	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-	else
+	} else {
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
+	}
 
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3cc1196d465b..345ade0af133 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -300,6 +300,12 @@ bool vhost_has_work(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
+void vhost_vq_work_flush(struct vhost_virtqueue *vq)
+{
+	vhost_work_dev_flush_on(vq->worker);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_work_flush);
+
 void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 {
 	vhost_work_queue_on(work, vq->worker);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 56a6806be8f6..973889ec7d62 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -47,6 +47,7 @@ struct vhost_poll {
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
+void vhost_vq_work_flush(struct vhost_virtqueue *vq);
 void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
