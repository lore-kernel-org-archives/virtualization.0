Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06F4C433F5
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64B68416D9;
	Sun, 15 May 2022 20:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4FLyZ-V_gCZw; Sun, 15 May 2022 20:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9B6EB415F6;
	Sun, 15 May 2022 20:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80D68C0039;
	Sun, 15 May 2022 20:29:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBCBBC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC79760FEE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="tJWrgj8e";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Vg3wky5/"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uA7qGO-W8avh
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 395FE60F57
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEadqq020757;
 Sun, 15 May 2022 20:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZCbNvY6u0N/8C54qI6QOW7euyjQ1+xE3pKu2nvmwvSE=;
 b=tJWrgj8e1Cin/YWM9Zq36fS3s11ysqbsw8j6kH0i4V9/PwJrL86JXHfcZWqLlhIy6/gE
 GyFLIR6NpTgpA2JtOgPWMofjOtxMI/1g8rKwSMvTq1TL6YzKmu8ZyMwqtGuWXptlWJ//
 /Jj05HUrrKYDFzpxl3dw6MJPebqbBQEEuvTIhKxKTjwp+n4B+LqnP+JVOhZZUCcqVYID
 sxCMFaBh3BG2AzSqHmGwIZIlVQ7+BNm6EPdzaPlNIyar1S0Fpp5IQMhUZuzwXcJxaVem
 mM65jXQc5uxDq+CGkVBR1dHuMqCiZoVrWqC6mZlJtF4MmQJhOr7YbP3Ay5A+cz5k/VvF PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310hv2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:40 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKPP2J007035; Sun, 15 May 2022 20:29:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v0ycf9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX9VtKbP7IGfn0SsHZaR+HX5h42kkcSdFg948X0OB94NmE7uxZrWtKPl6UhnHd40iadKmQF2GSThQivh9usiLhd9NM/HhC4jlbCiAlxLLSqghm9J6CGDoUavgbMESHVVHeklBPcl6svXbZmjOwBAJaFnigu9gRoootawdTP/huVrXPgiFBBzwbLN7vBE0nbD2aHQgSIDSTB91RJZzNLxQEQaBEH+JO+3uFKg/fmRGR/02Zb5Po68BcZxcyur8aVYK/HOKIOd87H+TWnLqyr5vTy8gu4zoso5kkbniZmYvOS26wXw7VfsedTQdlbOc9Z2v3Zx1IWpxgT8HoidM8tWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCbNvY6u0N/8C54qI6QOW7euyjQ1+xE3pKu2nvmwvSE=;
 b=l8chaamuaTRgn503KvipOID7+G2vsFzrVLALXCjo3NB3O8QRB34JBBMN3PYVUFM+w+OwiyBpFQecma/3RwOvhgWPSfSOWsOtlfqd/JGI3I5jPOhB0LxmZogoJsGMeZPRUi6zHp/cjFuSZZwTINQCTLZX/H2+GeemOZAZRGKTuMD0k9r8mVHpedi2Vt2NRsem0AS8VJKMIUdph37FiADiSelJ8Syv4oxv4Z7/BoKncLU2cJRGkKMUEaHZyDEjAwuUHQFETuv9JiPemZQS1JD1afokStaYibHbsbUHt5vMFJ/p8c9g66wh2wpDALKxE4AE/brDy6Xc4OzFtkVE25VJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCbNvY6u0N/8C54qI6QOW7euyjQ1+xE3pKu2nvmwvSE=;
 b=Vg3wky5/b39I99p3Dfk0Ke/bTP1fOVRVwn+opjWPGSVKuDFYhRCaonuPFllvWfauV5kjtw1pzPgHkNVn+b5MRJx2ouQ0k0u5CbL6cAMzeiQ0zENhMCChjkdyyKNnhBYytEQ3/iROSKnGdJ0NtRskMW5lMsRs0oTI3O4mMs8+62w=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:33 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:33 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 6/8] vhost-scsi: drop flush after vhost_dev_cleanup
Date: Sun, 15 May 2022 15:29:20 -0500
Message-Id: <20220515202922.174066-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 771b1a92-f55e-4384-63f2-08da36b19ea8
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2707ABD16A716BC39A8B5D7CF1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikdCr9eGiKnA1yZj3VzsE8YWMLPoJx0MG2zjiPnecm0b43zF70NtVazvdbzlrK2hYS8twCNWU7xHC3MpduGR+JQADbtk1hi5CUTjEzZCz4X3xMxrQCQh4YkdFJwoiVdu5rDa2gnWihx5YhDLR3CHELd/74kFGD1aYuQEDN/BOtfnwAjhoqo+JS5sB6BpOksD+BD1gkdYRfkPcFfaEafmqiUAtjTObNPrwIMbzDzMZvHIBu7bYXOt9OJ5dbS2sBO14O0sAYulqA0jIFvGk3LDqbFweAoQ1LVgLk4DW3MmtDlYDSh4DUhqgzBF/5Vh97fvEl1zYOD8BxkPdLwU1JLmv0xi54PfI6RvQFxS/QJT2GE1qCLdSYsdRgtDdo+l8UZt7qK6m8wWxjclbUGu9KLaRLP/l2xrY8YWhsnEPJ829tVPxASlubRUcg0qLbG3SF5D5jC/5gGCRCXffPOacBYsWsVrjJYfrXV9g88m883gJ6+vRG+b9pvupJAtD8IGaoLqEea9zpuAofxYb3XSJsTa2HEBgp+Oseu84pGIIJpnQqpqN3QI8FnJP3SFVw9P8GlJJ8VJT4F93mpEujEPQ90aiKQOauA3JWHqQbzoA/2jOXMnF3pTN5wXSVwQbQGqBbzHCnHnO8GpJMYpuwn0kBd2hxJt3n+uEncjHThsdWBq71J8YTvW+mlNUsS0VuKDXn3OYkYqmt7WMUPkohC355rDhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwZEXfCer2SGkj9YWlc79LrwilaiFc47IJMjSyTMna2T2/bEa9wLBoc5wo6l?=
 =?us-ascii?Q?8yyOkDAcNbONAn4OC6yfcIiNGrh4pu0jEqouMUR1VA2Hn11Jy3I0wRDUrjoB?=
 =?us-ascii?Q?djP3Udgfs+ZfxxBSPf65qRE1pbg7FVDFRn6gpiTjIWWQoiC55jzrnxUAY3v+?=
 =?us-ascii?Q?epGAUdN2TNfDHLpXRtajsnL/ThbxeHiG1izL4U/MGvA0Hp85l4cLCWvKTXqt?=
 =?us-ascii?Q?RRst9kkeH45pa5jKHOGMlUtT6TDPi56vM7kcp6EtgrRU74+G+a2Ea7QVAHlt?=
 =?us-ascii?Q?rqMNBxoFdD00DYXYbL0ukYtXd0CuNMPEJsX0S+Uw38/khixIqAPCD0Drq23l?=
 =?us-ascii?Q?aYxixFi1GvOJcUCqpQyXbiAXfi7C3lzZC2RDxN+DcI2P42H1RzAJgQHFJzLZ?=
 =?us-ascii?Q?SMwcebKVmIJMHUxZDODs/VDxZhKrjwoZBtJBsm52tKkB/MRYReBR6DxW2oTv?=
 =?us-ascii?Q?YUamD8KizfrzXmlFj8rny8PX2rqVMc9dpfFNUut6fj7J8kKs81fWj7lEFI85?=
 =?us-ascii?Q?cHqTDUZnQSL1ROj06tjIhI5ABPaPMWCiiYznFmtHo2nq2nqvw2joXs+uGDl6?=
 =?us-ascii?Q?U83+GdekQyu2Jb7nBPAkzvGm9AVE2Acob6pr6XxOS3caul/i0hDEU00w6QCU?=
 =?us-ascii?Q?vg2B2kMcp8p1UNnidaokhj55wOyv/ah5oaWzfpRrzE/veJ35/v4n05GiU6zT?=
 =?us-ascii?Q?I2t3kd+bngk5pzm+w2pdTR0L4V0Iyjc77JyvcN8aM00r/nirjYsrP6h+Z7Fc?=
 =?us-ascii?Q?A+hFgE2m2i3pFKiE9P6Vo4iWOBb3kdLvoGGx1iq2+j6r9CBiPz48NhJJl7BR?=
 =?us-ascii?Q?7nhsIHiCniB6zACOeoFl39MDYE/Jyad1dIcPunzmpm0SPB98h/19JYHMgorq?=
 =?us-ascii?Q?bfClTBzF5KJIMByySQlaiDo0hB/292hP8McDMYT6JBZShHd51LDhOm34gvEa?=
 =?us-ascii?Q?5qq+JLKZH0ZJuKNCWUbvpUg8U+0+IjTRPX89O1Ut6Anp6Wk1BxOpyxYc1kax?=
 =?us-ascii?Q?hIeW+/LqJCCnkrGjE5BVkXQAr3LuUobag+m3ubuCjoWZqc8QN09VVtwZrAZh?=
 =?us-ascii?Q?irLouPbjNGQcRj4gPnNeFRWdlULDMWnAKoEFTckA2n24E/NUnvSfri7aioVG?=
 =?us-ascii?Q?8vQFX4VIvfR+juVXr9XVZkhtnOTk4FOyIqrY/kEZRTO5TqUGXYGeXIcGaHMh?=
 =?us-ascii?Q?klbe9BPD7TfODoXU/UdW5NaXly2854Ao8a9EFTjuOJszM5kCKXuFeao0zK+q?=
 =?us-ascii?Q?MzY/BCl5kP1kvwhrlc/nOzEpZHcYRa5wLgWUwoVmKevFEDYKtu6Bnd559gtd?=
 =?us-ascii?Q?dZE3BsgadiYEM27yhJohL7mcA6y6ysZvC8WOIr9L9vWh5VqlvCBGh5GdD4Ac?=
 =?us-ascii?Q?9tO2fnb5MXlHRUez4N7V4yAC0cv429zN791DQZr9ijg9XT+amDv2i96CkNiA?=
 =?us-ascii?Q?WJ7gD1YRuUiY28TP7JDa9wIcFmHs6yGxpvNgF190I6URyhwkEDbgjZUQUN/B?=
 =?us-ascii?Q?x2xbstdoa9NIoiJAjwDtc9pjRXErLsMOcu9NCNLfvpRXGNJ87y7XV00Hbit7?=
 =?us-ascii?Q?/iQiDHyDdxsF8Z4Ul+f1HS9WUpcQwNhBk5ExjZY0T1x7dn49pAkr7Xqkc55H?=
 =?us-ascii?Q?6mqcjssN6DEpk7UDAIxXBi0YJA3Kpk50csN+PzW3F0bb+ARgNXV2bxB07ItF?=
 =?us-ascii?Q?6miKPpLggMNMzN223o7081G2wWTS15aPaM1ALQ78vjecR0MtPZ8P63MeV2+Z?=
 =?us-ascii?Q?BkLP/mAxk0JFyEwnic1uoGoPDcy1NNs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771b1a92-f55e-4384-63f2-08da36b19ea8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:32.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNM78RY2ingys/IjQZQQxWS5PDjUf9xDyU1LWcjXXUfazZO261A/eXFXgT97Y8P+Mu+DzA0Bo2mNc7YGDR/GkSM2PxS6n2WE//OT29qzyE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205150120
X-Proofpoint-ORIG-GUID: 52ckgqSA0Bpy2zF9jyYaWmFlEEy4MAZm
X-Proofpoint-GUID: 52ckgqSA0Bpy2zF9jyYaWmFlEEy4MAZm
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

The flush after vhost_dev_cleanup is not needed because:

1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
so the flush call will just return since the worker has not device.

2. It's not needed for the re-queue case. vhost_scsi_evt_handle_kick grabs
the mutex and if the backend is NULL will return without queueing a work.
vhost_scsi_clear_endpoint will set the backend to NULL under the vq->mutex
then drops the mutex and does a flush. So we know when
vhost_scsi_clear_endpoint has dropped the mutex after clearing the backend
no evt related work will be able to requeue. The flush would then make sure
any queued evts are run and return.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 532e204f2b1b..94535c813ef7 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1827,8 +1827,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_scsi_clear_endpoint(vs, &t);
 	vhost_dev_stop(&vs->dev);
 	vhost_dev_cleanup(&vs->dev);
-	/* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
-	vhost_scsi_flush(vs);
 	kfree(vs->dev.vqs);
 	kvfree(vs);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
