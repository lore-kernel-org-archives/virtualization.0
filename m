Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D87C43217
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D8C784061;
	Tue, 17 May 2022 18:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P8AEvXZEpk11; Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8310C84054;
	Tue, 17 May 2022 18:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4F9C0082;
	Tue, 17 May 2022 18:09:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCF1BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7DA240902
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="uyOEzwac";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="TwAyFz0F"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9RdVARWaXu6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87DF9408B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSnAZ019101;
 Tue, 17 May 2022 18:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zdWXOhmN4xdy/SuNTZQ9KL7riI20qc8tCiZfUA1mlzs=;
 b=uyOEzwacpUy4u74wIts7u9aYm311Nk32sI31+pRSgynHIZixOYhfr4IAGIuph3Vi4iaC
 qxM6A3+TipKQzjP+mljulo1QwW2oBxXBavrN3hs+ahTWB6ZXA574qlClk6N6lKJE1026
 3e6TDdqVD/4uR52uNvh8dFxkCeGfQPsuCXsIG3AIgTgN3zIAmxbk4oCAVBnscn5dCypw
 PYYbyHkV/4zGsKudfX1vo8ZX2fp+7wUv+dpzEEGYK0jZCLqWE7J4HHuGqZA1sTrTAz6Y
 rMKxHPuq2CVQ3eWVQZsnYofyz68RIx6/6Bp+bnLQF86XbLs7gg6DdjMKf0gR0MRrzQuu vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371y736-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:06 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI5VfU017126; Tue, 17 May 2022 18:09:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v359nm-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX0VnB7ZxF4xTfoqsnnoihsYqQNnalJTaPwVVOr8NmCJGYbk2CMqA8S1C1XewQBWZWsJHMz6Jk06iZX3cu1AdhtF3lwUaHYONhu3uXv501sylW12cFxI289vLi4wZhjLWD5NEnm3iuaHTvzenRq/7MdwA7x9/IckdPjyYrKdwAB6ib8+7zqOJNf8WgpxO2gme8JJqAx4Rw/AD+Su77T0JdyBoriaXMLgZZTnni1Abjlo07QV1kRXddf5j29CMxs3T9VMV5H7Ba329qBnLf3PrMsKoKmDmb9uwmBTl3yruqYCH1IFO6pWFYV9Xy8ieQmfI/XWHyhVWddOXSmRnAWaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdWXOhmN4xdy/SuNTZQ9KL7riI20qc8tCiZfUA1mlzs=;
 b=oc3lrX0zw5K3hmGYM0TLcChXfJIR3GFbKaJ88qQukUISDMAl24ky3/cCikmjjiVR8dYTqCgIFevBu4gxYBzdH1aLq6x5+DjFgK5rEc0Y1UOXOI5MBu36AQsbIqhxgh/kv0OlzC70cRFnEeOMboM12ZJMkzHbEW/pEk69ut3fU/Zl41ckbSMCgdAvVCaYYWPPxkKL2VyJFvAZrfBWYFAtvf73HRlWslQo+I56p9CDhKMCi5zbnyj2Euo4HaXnRUEyD84ErkEyqFJsg5lpa/O/ts7NQv+lOTpL5tRb6Uf0W5BK2IqVl8PdwLXX8VubN3KJ1S4qLKhzYjOW6WN6f8oNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdWXOhmN4xdy/SuNTZQ9KL7riI20qc8tCiZfUA1mlzs=;
 b=TwAyFz0Ftqo6/gDL6pEHXAymBr/6tbAvixXb3jpJOgowKXTkyT2TjfYKoX4n48USahngVer3cQb8NLKMnNUGdZUD6In2iY0TWGR38DtxMPerOnRolpUyNLBGx4ZCa9WPRa8uSMGWP06w7ihcg0E78heHly+DxurrrbDu1YT2/go=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 18:09:02 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:09:02 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 8/8] vhost: rename vhost_work_dev_flush
Date: Tue, 17 May 2022 13:08:50 -0500
Message-Id: <20220517180850.198915-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0468ec-416f-43c3-c595-08da38305296
X-MS-TrafficTypeDiagnostic: DM6PR10MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB28738F42B7190F0E51396DC3F1CE9@DM6PR10MB2873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUe6Crx47uEH7z6fWG1hF3QAuS4nw7827Zr8EXklvV83GaVMetvLdKhZk68dvJkikXdy80UKzA4FZRLRcKrilV1R9ADlgeLqZduluZW8/Xs3BBQFJFKM957xbh3YPdiV8S7ncfdCAHu/8PbHexRwk0jAl2WoNxPVK5M4QrLOUO0j2fIKVBmkkAAIcszSVIlaoggKfgDbHcuJOQhEAIV6Oe70KR4MHvgFTLDu+dmudS3/+ZEaNFhKjIEEklI+HLARCDMdI8ENI9UZlUMSlRY44bAkWn4EX51dv8J4pt4hZUT5FOzZXqIx0xc+D0dKb4xyO2wBDZHb/xGdYQKCAGZ7z8rffMK5A8sdPHDn2/1lCvBDRiJtsjtlk6bby6y7kWbEnLV7ImtTwqX7bK/baTYwFFBwtCPaJYEaiIICghDt7N1UHKN9I9jRwk7GTtHjuiRcCuLTAAmJtaI4+7qf40L6dult01awhGAQf7+iWT/KjgG8ycEtoMISCi0ouhFYK389PdaZIF3/9vbcVaBHmQuN5wTrLUm8jMJJtGiXtd0eCu1IcqlQxubH6RIAwDUS2ZtMpH5V4o5bat9WbLdHds/kS5pUKyfV6xJNnBCoa5K1xFqfAuFN9D/L7bhA9Gi7Q04rJ95F+zrDOnytAyIew3m8XV5FJolGRhFZwhMQAiKjrMHA/d90SdvJlP3FxCGa6FPa2r4XNCaC+ubofuCkUDX4Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(36756003)(5660300002)(83380400001)(6486002)(316002)(1076003)(107886003)(38100700002)(6512007)(6666004)(2906002)(6506007)(26005)(86362001)(2616005)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(508600001)(38350700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wLWc4tUQ8i/i1H1WA60/jedxSKZX39z7xJ+Ot/N8aMwdFgy6TvfD3GC3+vi9?=
 =?us-ascii?Q?UzqJ92sslhkOrn+g16dMNSqekyYKqLjos5yMqqKEoan3BnXibEX4LikqodHy?=
 =?us-ascii?Q?H5hZznxUwDkTNRPr7moF0MliqIiGKrA1WiopYRZk44rEq+CgjSrs16cqWJHW?=
 =?us-ascii?Q?wZ+Hb/JxTrUuyylfOE95XD2AQgh7JFolWckFr+Tonw1wbYSe/wX9oNbi+QBI?=
 =?us-ascii?Q?ImGOBzGRcwOeDxuBJdc1VpVel7LA0bEWOQuByPsrutoBYkmJaLm2/MP1IqDa?=
 =?us-ascii?Q?gxC1cpRnPTHRIz5T65+smU9GSdZtPykS07+Fi40w/NGehBkneLrqHw1hk4CF?=
 =?us-ascii?Q?98XrZQzTY0BE+w9zcJEt1AMNCtU5dIkBizWfM2SucEwaKp1MKv77/2RbylrV?=
 =?us-ascii?Q?h6K3YcJD3ToDezraViAZUm5/kAGWV8iNUntMJ7htCFmoYhjXYJllXXXYfQim?=
 =?us-ascii?Q?e4rLBuUqdRlOV0Wl1kuZHXQR1Ku5//2jUI03CQde5SLghrzjfJQ1bZjsWa0o?=
 =?us-ascii?Q?GwBIApJ10BfddMfvTAehKXwWataHVslaYQUlbixJZJckcvnT8nZxstDHi20L?=
 =?us-ascii?Q?i4krYQfDAm51O1CFrEZ2u5khm7iFo1i51M2WRn21+v4SjqNQSu3xz4rY509H?=
 =?us-ascii?Q?Mty7W6Tw5TbA9+U2QHt9m8NgLjAfRcehTmqx6v0hfx+aGn8W0KxcdqhuFJge?=
 =?us-ascii?Q?ojypwxsXitxdVnnTIHBm2XDzgWAg90c3YGoeqU7tSxl5+BPpyAofbe4owvrw?=
 =?us-ascii?Q?vHwNuB3peSO4rXatiVhd6pujUHcaPhh4xcUF5nU0ib0Rj3mSNVME/q64MgwE?=
 =?us-ascii?Q?nmC2AAil5EywIBLQW30LgW27rUBvrpIoS90B8mrVC8sn5tq2Q7T6vTTQVaa8?=
 =?us-ascii?Q?9dhO+cOHZbF4Cr4sr8PqDLiF8xfYB+KmCptrl13oPeXOW3sDYOsULd/cxyy/?=
 =?us-ascii?Q?eQTr4RYc5JGIIt7KaAPyGPwPI/zrq1ttzxfOwF5Fw31b0KO3jDUTNXE7b63f?=
 =?us-ascii?Q?quEpPIJq8pipShDOzJfhgeiQ9IgMjua71xxFjpFRqjD+cF0TBj8Fsbtl61z7?=
 =?us-ascii?Q?YcC6xp/NhCgjiGrvzGmEE6oHLXrwoCtgjrHPWNV6v2KRzQG7rEUR7fSF/qHz?=
 =?us-ascii?Q?jbv+xkzE8BOmmHH2CQHX1NZEUtgUcHGDFO+iGc9Spbw4Nl3exWHBIaUiPwz1?=
 =?us-ascii?Q?RGoJmwTNAcL8UW9+kwmPQ5YY7iQ+2kJos5v++zzlB4X+o8+flFjveAYJsoqX?=
 =?us-ascii?Q?HJO9R5dq9p4rA9B/kQB31aUJ3RrUthk5W63zfNB2h782sZUys1wjJhzOT/DX?=
 =?us-ascii?Q?AGcDyRjwtCzHjSLDlU3xsB2MepWjJv/1XMKF3obCeYKlwFesYqAeD1cj06Mo?=
 =?us-ascii?Q?c7af5RmJ01o9zYqlMZ39RDDiESC662+ssH1hv9mKtmFl7M3Rlk3X+cd+ir1p?=
 =?us-ascii?Q?lrVen9vEl1Bcf1Fhq1Ply8cmnd894p1H7iMiRbP8dwcxJP4UgC7OgG+osfG4?=
 =?us-ascii?Q?zRCbG5KkvrbOs6VMV9p5GwENSbgf7qhskEjtyPAQ+5xCSlA1SdawO5zjhicd?=
 =?us-ascii?Q?mJDJguJcDLzjxT+9rS8rl5Z+pGXP7LrTEYvgqazvNQhAyzySNzQBDokozdZS?=
 =?us-ascii?Q?w+AmTS3aNQtMrBfPEM+zRuTnEQyDVc2T/IZbN13sgEov9wHejtXDyjjIEZAW?=
 =?us-ascii?Q?4GT/GXBRcLY9HrOuUd6gpx8/zzEbl6xHHgnIb2ohre0+TF6HDx9TlbUfq+63?=
 =?us-ascii?Q?W2eQp1j58tXjclADSjM6CyaD3Fu2DhQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0468ec-416f-43c3-c595-08da38305296
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:09:02.2638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wttqVD1qH1ucVh5gY2b1nzWKQoAcWZPcWfIQ/fG+iFUKoF7t3hGfcBkHkDgP0OVMwhmiN1nH/MEJdKdMWsdgw960dUsibisDWBLNp7mW1OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: vGkw45GfQyNY-kGy2qDwUZM3vwdOQStC
X-Proofpoint-ORIG-GUID: vGkw45GfQyNY-kGy2qDwUZM3vwdOQStC
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

This patch renames vhost_work_dev_flush to just vhost_dev_flush to
relfect that it flushes everything on the device and that drivers
don't know/care that polls are based on vhost_works. Drivers just
flush the entire device and polls, and works for vhost-scsi
management TMFs and IO net virtqueues, etc all are flushed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/net.c   |  4 ++--
 drivers/vhost/scsi.c  |  2 +-
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 10 +++++-----
 drivers/vhost/vhost.h |  2 +-
 drivers/vhost/vsock.c |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 047b7b05109a..0e4ff6a08f5f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1376,7 +1376,7 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 
 static void vhost_net_flush(struct vhost_net *n)
 {
-	vhost_work_dev_flush(&n->dev);
+	vhost_dev_flush(&n->dev);
 	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = true;
@@ -1566,7 +1566,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	}
 
 	if (oldsock) {
-		vhost_work_dev_flush(&n->dev);
+		vhost_dev_flush(&n->dev);
 		sockfd_put(oldsock);
 	}
 
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 94535c813ef7..ffd9e6c2ffc1 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1436,7 +1436,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 		kref_put(&old_inflight[i]->kref, vhost_scsi_done_inflight);
 
 	/* Flush both the vhost poll and vhost work */
-	vhost_work_dev_flush(&vs->dev);
+	vhost_dev_flush(&vs->dev);
 
 	/* Wait for all reqs issued before the flush to be finished */
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 6c139f18bc54..bc8e7fb1e635 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 
 static void vhost_test_flush(struct vhost_test *n)
 {
-	vhost_work_dev_flush(&n->dev);
+	vhost_dev_flush(&n->dev);
 }
 
 static int vhost_test_release(struct inode *inode, struct file *f)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9f8de04bb673..716a80c61fa9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,7 +231,7 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-void vhost_work_dev_flush(struct vhost_dev *dev)
+void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
@@ -243,7 +243,7 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
 		wait_for_completion(&flush.wait_event);
 	}
 }
-EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
+EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
@@ -530,7 +530,7 @@ static int vhost_attach_cgroups(struct vhost_dev *dev)
 	attach.owner = current;
 	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
 	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
+	vhost_dev_flush(dev);
 	return attach.ret;
 }
 
@@ -657,7 +657,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
 			vhost_poll_stop(&dev->vqs[i]->poll);
 	}
 
-	vhost_work_dev_flush(dev);
+	vhost_dev_flush(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
@@ -1711,7 +1711,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	mutex_unlock(&vq->mutex);
 
 	if (pollstop && vq->handle_kick)
-		vhost_work_dev_flush(vq->poll.dev);
+		vhost_dev_flush(vq->poll.dev);
 	return r;
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index aeb8e1ad1496..d02adf1b2bf8 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +45,7 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
-void vhost_work_dev_flush(struct vhost_dev *dev);
+void vhost_dev_flush(struct vhost_dev *dev);
 
 struct vhost_log {
 	u64 addr;
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 96be63697117..368330417bde 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -705,7 +705,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 static void vhost_vsock_flush(struct vhost_vsock *vsock)
 {
-	vhost_work_dev_flush(&vsock->dev);
+	vhost_dev_flush(&vsock->dev);
 }
 
 static void vhost_vsock_reset_orphans(struct sock *sk)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
