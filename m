Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B4AC433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60266143B
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60266143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 483504186B;
	Wed, 28 Apr 2021 22:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tS0-S6jpsKOl; Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 387CF4186C;
	Wed, 28 Apr 2021 22:37:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5CB9C001C;
	Wed, 28 Apr 2021 22:37:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D7F8C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1376460D91
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Hzl07Ozs";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Zfr3RwyR"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7WrYUPKkfHQl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3B7D60D67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 22:37:30 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMUsA5127221;
 Wed, 28 Apr 2021 22:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=bpVzxYQ8v6iMHNZJzCmJMWbjcm5gw+h2i0XoVEi6hU4=;
 b=Hzl07Ozs/C2CAZYay0FPcYMJPdu9o/5BN517jAkYLIuHi3sbu5B/IKcrucL3QUhWaMYS
 bvAd5TgWiVnE+OexooTkBVwzNajZQWWnk/4wGxgRzN9C6DN1qH6r57KfzSRZzz0oo8wQ
 8uiccjNTGkv4jV+BQ/6/0aOvzqMGmggR6Xw2bLXfQgoDcVhs3x7WIu1DXgTyZXrieV9k
 tPYSSHGLdDPYn+3z1QrZsQXOuUdkZoUgdnQ9U4WciMAnQinngYKogfwCY9Ye1hbyafEU
 lhPoFhQzsMsGeTQB/CSG3Niud81Onn2N6mZgpfs/5jaRT9ewvBDRNVtmzTelg9AB+uPJ dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 385afq2k4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13SMTqJt184372;
 Wed, 28 Apr 2021 22:37:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by aserp3020.oracle.com with ESMTP id 384b59a4n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Apr 2021 22:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOTT2BSXw4J8njA38imZmgCAv+4x9rtvX3oywQeo/jJiEo30XW1d4QmXJL+IpnnSToZclZCIEgAfRXz/NrEGvm9eznErIlegJ8cRBElXZVXb1/Zfph8gTENXNSujVxn7kBd2sNJ4p1a31HBGUqUuBjLnDkVfFMRdAvhVTGSc60r8dCBte8IsTb40YEvjsZZADWf29/DM3mfNx7yUxgJGzxHwrABYPtpeHPFZltAlgyJEa95DCBLY/hiPbmfIIzymc9JP2kP2SbNqbMehzIvM7eiaMV4IiBe1dBGxde2HoUZu7kfRq/nmBj6GXBeOuCK60/5VbUCZXrwhIfsggeUNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpVzxYQ8v6iMHNZJzCmJMWbjcm5gw+h2i0XoVEi6hU4=;
 b=fdumeR9bfFa6z2P/2yVbOXK9EkI+3qnSvpxIUpQ3RaHlNGdH7LNAfIR9FJgF3q0wou/kitfKiI6xJyhF5iaoE6Sn+SUz8Ft+65Y7Re5TyV0fZN6XWc4n4GIP2Ri0WA1tXM1q9ipFYQExowTIRaYrw9GsRne2irfhjE+u0n9AU8k3QyVEpEldO1EynykmjfRvFdSSaWhcP74JvwSuHh/xq7bwo30fiNzU/fuehcOkJmlEJro5pNT0Inek6xyKidfiyQuTYrTCzbwTX4yslQ1dx/Q2s8/GF6/symakoQ0pV7f9yP57sFnp9VqAOynI5WWluHrFhN03LoUL8LsJRkgJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpVzxYQ8v6iMHNZJzCmJMWbjcm5gw+h2i0XoVEi6hU4=;
 b=Zfr3RwyRwLI5B66wmkB15nmZyyVjko1viIt9HsLImgwZMSGNpEsDLXWfeOqKBjiZ07hbFHT7W8jc+EaUTueH5R2puE/ZQo3lobBeSqXigP+ijZIPVzdhYGoK4gQyU97mq+yacpNOSadsknxbT8Ba1qnbAfgCfc8MNCocnufsJpA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 22:37:26 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 22:37:26 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 1/1] QEMU vhost-scsi: add support for
 VHOST_SET_VRING_WORKER
Date: Wed, 28 Apr 2021 17:37:01 -0500
Message-Id: <20210428223714.110486-3-michael.christie@oracle.com>
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
 15.20.4065.22 via Frontend Transport; Wed, 28 Apr 2021 22:37:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b6e826-e28b-4768-1b56-08d90a963302
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB3794FFF3A4D5DA23C5E2121DF1409@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjPKDxMrABySiGXCOhmc0oCaaiPtj1Uu/f5nQ6NuaZThzHqGQ3OfJMvsGYAf6Pb6Vr4ATDoEFJQqzH1GOC7+YLHU80DNzLrr8zxw3pZZdbTQrjp5C0JPufdx6xZLaa94was4tNVPl0wq+diYC6NLW5s9VN4Sh0nD3LjScLd/x/kKRjoBKbEwJD+p1V96Tdcx1VkHcsug8kAVIbftJs1muRcsHlayOCDwXpUn/mMTd9jhmZTRyo8cxqtclh19Quo3ctk3G466yHxpMpFW7uZnXbGd8hYN0VXxvzt1hHFGL2xR5ppS2wpNdzvkHubXymwSufRrnqHyr5aw65EOFoYhYOi89goOEXxol4T7RwRxQLZ0WOb/CjZlfncKofsWmbUvU2PiGlTO94CJxNgeSjd08wTc1SDAE8SXSjsfkrNxsSrZyrGwbnjJg5eKgdqSi+QT4LdPyIT8oV8mrGzQmcW84mcNpbcYLOf3w6Aa6+zmWq5KG5I5TsVsl7BWCfGFIUhMcAOlNKTNCVk48s+o+DlfHAhqlXvgSD0T6lr/zdYmWD8SQu2We2DnIwXYIj3tLwIvQekdWX7HvHDQq5ppwH9akDbLaObWVjnyGZhsjASWfwQz81iDExaqLDRsKN1VTOLAwacUIqChwGaJOb8JnbU0OdeLcS0aBYWgi365r1MQ1k2MaAKXUvLnYbFYE5Rj+41j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(1076003)(186003)(16526019)(6666004)(107886003)(83380400001)(86362001)(6512007)(8936002)(316002)(36756003)(52116002)(6506007)(2906002)(6486002)(956004)(38100700002)(478600001)(66476007)(4326008)(2616005)(5660300002)(66946007)(38350700002)(8676002)(66556008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V+j7smiHWEr3J/CMXGayq5FXbpHtar7P11qvUVutWWf70VLlthS2/6vXKLjx?=
 =?us-ascii?Q?SMJR7I3iM8LdOk/65qdiiexxmf+y3cp9c5RwzPdmhWO1xXCren18pVxojiog?=
 =?us-ascii?Q?t0N/mFZMGUrLmyvtpYomU/LrY0NMvdhD4wGP8m0qarCdexIGu4w8YsX6HP1q?=
 =?us-ascii?Q?XB/UouKtgrTKG9HvDm5jpvl5CJgbaNWP9rwa72o30XmYl+cmgBdZTQH0r5Yj?=
 =?us-ascii?Q?MlQ8E/Qiqgndv0L4HazLKkrbdXemRSbMmqmPUW4c51yM4Isv8i2m1zXwoMoN?=
 =?us-ascii?Q?PFFcXY/K5ZlhuxNGKwHF2JW4Am1wEkO/vnWCvyX/LTwIA2Azf/iGeYyl9P2R?=
 =?us-ascii?Q?7lBQtfAWH9nkMEqccjlah4bU2Euw+P2vamX0YaLXVDh7pakl4bvafXYnb8qf?=
 =?us-ascii?Q?8x9LjKyAc1ZJTx1WncSdk1LT6/QxtKrkY5Z1rqQUKUI0oDcwRzhSg4iT7aLo?=
 =?us-ascii?Q?3ryrLVIsMA1WEhULwVJeC8TravOTDlthx9CIl4CC9JzxrLL8g4WogBwV1KXf?=
 =?us-ascii?Q?BprjeIjJG7PbIXMdq2enC2cMvmUMglkT2r8ui5M2VzvF7rgwQmdq+Kdza1v0?=
 =?us-ascii?Q?s7NtIO6NufOKh8VO/rbgwDWwtCs5RDHcNPzrEkfxdApku56JY8rkLvFzREgN?=
 =?us-ascii?Q?Z/CN7vyug2NsTGcw1SUyL531ANltoCQQg3AYxhmF1Yjvvp7XqdXFxqYM6FM/?=
 =?us-ascii?Q?hOn74uyyZHtqwasBBTiRn1TzhFUSvvkaNS6cEmJT5JnZW8z9e12aB5s70+bM?=
 =?us-ascii?Q?3cT7+ZBMNIaTyUBKBJMFGX8bnH+No1uvjj/8rVzLtfV8iVbUvAws/D59rB75?=
 =?us-ascii?Q?9IwN/mPQ3fACyqIYA2SlpDWsp0H6yjwDeAIMe0GkW6+XvdsJZpdyRrW56X55?=
 =?us-ascii?Q?bJK6arly/k3Lb97+PquIYbJf5u8qLMcupli97dzUZafq8776jE4sl1GTuRCV?=
 =?us-ascii?Q?mI4+B2KOKDGH0SkrPxQ4zSCEIxnENzJIzB76/GJsv//RlEn1Q2V21VBDEg8k?=
 =?us-ascii?Q?7/ARPdrpnWpHFNhfXMUNF8AvJdGf6eCYzNAmL0bqg7Vo/oPVkYf1HftEaNMW?=
 =?us-ascii?Q?wsVTnfXpor8z6vKe+Jy0EGqc/mgOBgsnPQpKSCgECxuGxghhRDOjeQ0UXF0D?=
 =?us-ascii?Q?T82xXMZllcN7eO5wMEEUaxG+93C+mBfIIJFhnDixMCHcOesOyRI1d8xjRJ5L?=
 =?us-ascii?Q?S5hP4tNOxsc0qoNvPbauwnXfwOnkoMX0u5nyAJDAVEsDgAjlcc9O5+5PR1hD?=
 =?us-ascii?Q?1ZrhPRG+4yuhex47kmycpUN/qDw+mfePTxyqwNmOmZ0I5RYPAL76zP4b+a20?=
 =?us-ascii?Q?U4/cwI7evar+TeMrVw5oXXVO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b6e826-e28b-4768-1b56-08d90a963302
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 22:37:26.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g55SpkxmICwRCqvKjB4SquS/QN2hayE1k0ZY5dZPXhdsTQWR232/1blHkO2T88v2nG0izb83mTljM9E70KsWt2hPXhR6EhW2baXX1A8xM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280144
X-Proofpoint-ORIG-GUID: aLNWYVIWVdCxiMX7wPhKAFBgSaGu6j4Z
X-Proofpoint-GUID: aLNWYVIWVdCxiMX7wPhKAFBgSaGu6j4Z
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
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

This patch adds support for the proposed ioctl that allows userspace
to create virtqueue workers. For vhost-scsi you can set virtqueue_workers
to:

 0: default behavior where we have 1 worker for all vqs.
-1: create a worker per vq
>0: create N workers and allow the vqs to share them by assigning a
vq a worker by just doing round robin.

TODO:
- Allow sharing workers across devices.
- Bind to specific CPUs. Commands like "virsh emulatorpin" allow us
to set the group of vhost threads to different CPUs. But we can also
set a specific vq's worker to run on a CPU.
- I'm handling old kernel by just checking for EPERM. Does this require
a feature?

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 hw/scsi/vhost-scsi.c                         | 85 +++++++++++++++++++-
 hw/virtio/vhost-backend.c                    |  8 ++
 include/hw/virtio/vhost-backend.h            |  4 +
 include/hw/virtio/virtio-scsi.h              |  1 +
 include/standard-headers/linux/vhost_types.h |  9 +++
 linux-headers/linux/vhost.h                  |  7 ++
 6 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 4d70fa036bbe..9e3653d158c3 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -163,6 +163,76 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
     .pre_save = vhost_scsi_pre_save,
 };
 
+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, int vq_workers)
+{
+    struct vhost_dev *dev = &vsc->dev;
+    int worker_index = 0, num_workers = 0;
+    struct vhost_vring_worker w;
+    pid_t *workers = NULL;
+    int i, ret;
+
+    if (vq_workers < -1)
+        return -EINVAL;
+
+   if (vq_workers > 0) {
+       if (vq_workers > dev->nvqs)
+           vq_workers = dev->nvqs;
+
+       workers = g_malloc0(vq_workers * sizeof(pid_t));
+    }
+
+    w.pid = -1;
+    for (i = 0; i < dev->nvqs; i++) {
+        w.index = i;
+
+        switch (vq_workers) {
+        case -1:
+             /*
+              * ctl/evt share the first worker since it will be rare for them
+              * to send cmds while IO is running. The rest of the vqs get their
+              * own worker.
+              */
+            if (i > VHOST_SCSI_VQ_NUM_FIXED)
+                w.pid = -1;
+            break;
+	case 0:
+            /* All vqs share 1 worker. Pass back the pid we got the first run */
+            break;
+        default:
+            /* Each worker handles N vqs. */
+            if (num_workers == vq_workers) {
+                w.pid = workers[worker_index];
+
+                worker_index++;
+                if (worker_index == vq_workers)
+                    worker_index = 0;
+            } else {
+                w.pid = -1;
+            }
+
+            break;
+        }
+
+        ret = dev->vhost_ops->vhost_set_vring_worker(dev, &w);
+        /* Ignore for now. Add feature in final patch */
+        if (ret == -EPERM) {
+            ret = 0;
+            goto free_workers;
+        } else if (ret)
+            goto free_workers;
+
+        if (vq_workers > 0 && num_workers < vq_workers) {
+            workers[num_workers] = w.pid;
+            num_workers++;
+        }
+    }
+
+free_workers:
+    if (workers)
+        g_free(workers);
+    return ret;
+}
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -226,6 +296,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
 
+    ret = vhost_scsi_set_workers(vsc, vs->conf.virtqueue_workers);
+    if (ret < 0) {
+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
+                   strerror(-ret));
+        goto free_vqs;
+    }
+
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -271,18 +348,20 @@ static Property vhost_scsi_properties[] = {
     DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
-                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
+                       8),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
-                       128),
+                       1024),
     DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
                       true),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
-    DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
+    DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 1024),
     DEFINE_PROP_BIT64("t10_pi", VHostSCSICommon, host_features,
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
+    DEFINE_PROP_INT32("virtqueue_workers", VirtIOSCSICommon,
+                      conf.virtqueue_workers, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 31b33bde37b2..0dc9acfca7ec 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -150,6 +150,13 @@ static int vhost_kernel_set_vring_busyloop_timeout(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_VRING_BUSYLOOP_TIMEOUT, s);
 }
 
+static int vhost_kernel_set_vring_worker(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_SET_VRING_WORKER, worker);
+}
+
+
 static int vhost_kernel_set_features(struct vhost_dev *dev,
                                      uint64_t features)
 {
@@ -311,6 +318,7 @@ static const VhostOps kernel_ops = {
         .vhost_set_vring_call = vhost_kernel_set_vring_call,
         .vhost_set_vring_busyloop_timeout =
                                 vhost_kernel_set_vring_busyloop_timeout,
+        .vhost_set_vring_worker = vhost_kernel_set_vring_worker,
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 8a6f8e2a7a30..375fd6e79d8f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -33,6 +33,7 @@ struct vhost_memory;
 struct vhost_vring_file;
 struct vhost_vring_state;
 struct vhost_vring_addr;
+struct vhost_vring_worker;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
@@ -70,6 +71,8 @@ typedef int (*vhost_set_vring_call_op)(struct vhost_dev *dev,
                                        struct vhost_vring_file *file);
 typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
                                                    struct vhost_vring_state *r);
+typedef int (*vhost_set_vring_worker_op)(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -145,6 +148,7 @@ typedef struct VhostOps {
     vhost_set_vring_kick_op vhost_set_vring_kick;
     vhost_set_vring_call_op vhost_set_vring_call;
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
+    vhost_set_vring_worker_op vhost_set_vring_worker;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 543681bc1838..694221601dad 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -58,6 +58,7 @@ struct VirtIOSCSIConf {
 #ifdef CONFIG_VHOST_SCSI
     char *vhostfd;
     char *wwpn;
+    int virtqueue_workers;
 #endif
     CharBackend chardev;
     uint32_t boot_tpgt;
diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
index 0bd2684a2ae4..0d81ff6b2f1f 100644
--- a/include/standard-headers/linux/vhost_types.h
+++ b/include/standard-headers/linux/vhost_types.h
@@ -47,6 +47,15 @@ struct vhost_vring_addr {
 	uint64_t log_guest_addr;
 };
 
+struct vhost_vring_worker {
+	unsigned int index;
+	/*
+	 * The pid of the vhost worker that the vq will be bound to. If -1,
+	 * a new worker will be created and it's pid will be returned in pid.
+	 */
+	pid_t pid;
+};
+
 /* no alignment requirement */
 struct vhost_iotlb_msg {
 	uint64_t iova;
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index c998860d7bbc..24569f89611b 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -70,6 +70,13 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Create/bind a vhost worker to a virtqueue. If pid > 0 and matches an existing
+ * vhost_worker thread it will be bound to the vq. If pid is -1, then a new
+ * worker will be created and bound to the vq.
+ */
+#define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vring_worker)
+/* Return the vqs worker's pid. If no worker is set pid is -1 */
+#define VHOST_GET_VRING_WORKER _IOR(VHOST_VIRTIO, 0x16, struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
