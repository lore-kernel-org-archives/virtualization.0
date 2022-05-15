Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBD1C433FE
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAAF0401ED;
	Sun, 15 May 2022 20:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_uy76AiiLsL; Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38AA9400A4;
	Sun, 15 May 2022 20:29:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E72EC007F;
	Sun, 15 May 2022 20:29:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31060C0039
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12D01408E0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="NfsMUKnJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="tMB500sJ"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYj1pixyySPt
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACB364160F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:34 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEihuH016834;
 Sun, 15 May 2022 20:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=TcOrezH6XsHIiVFsqp1I8VEnYpEvmp+Z69siVMCui0w=;
 b=NfsMUKnJ7asq+goL9SdKFIQZVuAU29KWC6baKTbJIyJ14yJ+TAFYMp9Djomi64ZmPU7M
 SvFcIlf+5SZq5dsGfZrxiuz75fb5JnT5JD0rgzzxgpO5WjF1k+TbuZsgXbL2uLyKsDfF
 I1d4IsGsljeOyIjWCfzfR/6N+GsrCAjZ1Ob6i4Jg8C1vR5fYUcH+AUvZLxuBE/Oc5KCN
 g5MapETYCT0JzGaQsdzjf6n5ajQGISLX0Ny642i7fwgd8Vur1ilnhCJLG0G2o4s8QGuZ
 Nkyu3kXQZApTmf4pe8bv2EEC5/bGOzIHA+aoKIiHYwyq2fM/VjLb9vwKMlxe/qTYmVdO ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aa9teh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:33 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKOthC000789; Sun, 15 May 2022 20:29:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v17vqs-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haZE4ZeDUFHIbOo0VdHK7n4icl07r5cvcdgGvZQP78Sc1Xu6W7zJ3VtgXpaJq2VYjt5v7fq5B4NjyL//AiE5qAWgpX6kslJGPjg0Qq74W4BhJgddnD5EqR7TqIj491e9qAEgPXzouthst1Sa4RFV1vM4HdnsflcxAIGonxpGkgYv8BZbvHynsGSrbfoQF9fFS/D8BxO8HvdSUh8Plpg2gy6e4Ee4SwE5t1NhTz5BjZPUzmqGMlM8FHJMut0+v4Pp8rvgY5v5AhWYYQRNzdbuelWcVURmcbnQ/+MdUBv76I4VTTSG0/y7GmmRs2JDdZAyCTkLc/ko9kA7nwH0DDjAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcOrezH6XsHIiVFsqp1I8VEnYpEvmp+Z69siVMCui0w=;
 b=ogxEkZIs6r7v4CZt4W4TiYsdXx+Hk7bw0aoJd8VPx/9FJF6uT+0Azf1z8r9U3cT9LA6W2/UxkHJ4z+mR3VaCKCtMfaFeDfrenDFOqI7jJUwCdlhbyF5Gdq2yyDmSM29jExTNLusftSafjehNRtAPcqTT7LppN89TV6v++ODqhQ/YbAp7Ca/HNS6ahWNYQBle2G1ZyBfFzgBiMpw+q7/jL8IcP8fDFBFJUvQ/69erLZ+IREAVgRe5YqsksCajwAcuBe8sOymH/HMUZR/HV2XUug2Ff+Emrl2z4U4zbQrKI7He7ACIL3cJWF7o3N+y7y3T2927xGjiZbQIxCtNzOyOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcOrezH6XsHIiVFsqp1I8VEnYpEvmp+Z69siVMCui0w=;
 b=tMB500sJcbQ667m+ZBNPhaZuPwPATwFv+dE/j/yCKZCDjULJvH00mivyscF7E9b49Qk4z9hFqJhwo9CS8grBpejDRqWCqm9GwiN/LUIXUSX5JcFn+HLK25goU4/6rz7AuTVku5phxPRd/tdXtq6/OU+ni57DAfxsRfF9v8t3s8Q=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:31 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:31 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 2/8] vhost: flush dev once during vhost_dev_stop
Date: Sun, 15 May 2022 15:29:16 -0500
Message-Id: <20220515202922.174066-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2588f9af-5b37-4bd4-768d-08da36b19d91
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB27070E681C01926C875A2645F1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMXADkPhl7KFxd2IctvInwjErme1mnIAfZSsx9M24PG42Qex1y9Sb+JEdX12NZeZABcDGYgJRh0nEYTIWNi10Z2XO33f70TQOOWbWc79V1OGoO6BCixUZ2d0EiNjvOCkkrgoxQnX7IOn6SOPodkmkbl4aRHb1luBlb+5NOTx6M39WlVdlm58p9X+H5dJI+n35L032AmaiISy2TEjuCmaqKuyUoXKawmDLSW4uELrIOUpICcFt/xrOW2gesw+MPWbGYEVsFnaqWNmYgcjuekeYcEoqna6MAdR8Sq9CacF5pd8rTaLfPJ42Eb/mLGfS26Tj43nGTJWiG6C1q0+FoeFE0X5ZZWAmHYnRtOGIBs1WArRYUJlKdwXTzvt/NLsNCO0KnElvvv53A0wRpZh4BAOn/iZ+wsUo317KLQPfYtVoHfhrGALeSAjKaCOyvZuHq67IbkO/vxnBolQkBNImVkbhXzmvt5hX4vpQr/+1BofBiexyT60kyh+9hbq11raaD+B3kUKj3JaqBj3aHlH9wkD7eIqO44CmfTBMUcYFbvGjFGE26eesRy0nd6ao55N2iVo+E9/kruVYUHcQ6tXSWKLjzt0MmYzs35YInNJRQoVbaJeC8Mi16V8mscVzizMRmRTR1gzBu+tK4pBTD8ZwpaD3bYbFUWU6OFcOm7ObR2nCrWGaQrrJNUH142k4WocB02BECWYiBy8SLgkXJloYmcdSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(4744005)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K2PleYBv20DLLxI6/uoobqGMKvKq/Q+r8rsbvICG+ROuler1JeBKCBqk8nEx?=
 =?us-ascii?Q?IgcpQxAwrAB/sbgKT9KRbpcgNC2dKOlf0bkOUDZWNf/Bl2lDXr/Lvg3oNTbH?=
 =?us-ascii?Q?qFaFJlFWXHUpWBGIoJWz3moeEiS6AXdBCWYIza1g572xab/3/xnZl9o8unpn?=
 =?us-ascii?Q?YuuxevR/US10HJSb19JyuxidN3Qi7WdY5LLATAQ2HrN8UElSbL9M/2Wm6+fi?=
 =?us-ascii?Q?wtK7joN08dVJa3w7ZZ0ApJ4NiAjj+SDY45xB0i72bsLHtJ+TteeckGciAQdS?=
 =?us-ascii?Q?FztUYWG3iDw+c5NM6lYHggLvCqJHRv0sRDxKvdjTgLBqjFZtBverGJsnBlx8?=
 =?us-ascii?Q?66/+W/rfpCcWovX0wG9WqY4qykD0dCl4vJlcIC20XVetZMLeI1dZtrDrKD2u?=
 =?us-ascii?Q?mLAGwySlASZI6cIY0taqQPE3CKx/EbhWLRcJz084qWlFsu+81g9NJQ5CGdmo?=
 =?us-ascii?Q?LsJtGThsdFYscQy2pf8I16V1Z1FtEpdC9skBLMU9CU5ByNv0ff5xhDQNJmMe?=
 =?us-ascii?Q?zrrSzeXPr5xBiZ+n2rCpdD3vQ9LCnT9HJQjMoR4mSuwNL4infa8KF5Yya0e0?=
 =?us-ascii?Q?x/EIWiZ7iwmnmHVW0w1cK857af5m6VguVVvr+SYBLJIc6RTBNy7kOOMmnOnt?=
 =?us-ascii?Q?Ml7yZkLlnIdX9JLkjROHyPDxjAUCBvw+VCdO+kZeny/Bc70hhzAyaBEfz/yp?=
 =?us-ascii?Q?jaE++dd8GbcOcMBGjaJAlEazSA7/SFPavV0jEkuooPIXQ6eIZjmtcNP5X4is?=
 =?us-ascii?Q?BfNpHJDXnDEwXdOCXItwLBu9ZLHKIdJdDDByVOr7a/AN0ym0OjMQo74GfZe6?=
 =?us-ascii?Q?2ZY6d1HK1YUXpw1HLlE5rBODj+dnHodVlUjmIIUN5XtNrG04VftqATgmxPRw?=
 =?us-ascii?Q?I1+zCBbPzpNvhNTZI1nh2F3yir0ydruf3D8122HgKhiLJsCC4/yI34yEYC5L?=
 =?us-ascii?Q?Fps2F9M4jMNfbVBY8LANuhN7hp50Czxz4i5h8mW7MIf0G8RAxsEVSUl4ptEz?=
 =?us-ascii?Q?HQInLgwbAnn7gyZYzXwsQStFdQ/9NCh23LYMvs3/TE2T0px5a5yPQJYeJneW?=
 =?us-ascii?Q?5CCwndo9M6KU+dtqcODFXjZg00UGKsnep6nAp9Za54KKvOfuKBeCcMLTy/T7?=
 =?us-ascii?Q?4ssJxNMqFFkgk+S/LZTS+gF7WxRhMTCQPfyNftOVgVf5PM4skJMWTht/uuZP?=
 =?us-ascii?Q?bInohcu76gu5dGkl61rfVz3CX3jerKqjedIVL4w1SpcWiWJF72vW36mTOKjp?=
 =?us-ascii?Q?30x8UbcMHn75teuOsu6KdvmmL59HJJJP9GIzsijVL946JBvUAYTD9Qln8ZPz?=
 =?us-ascii?Q?w9zaLYNCKDCZcCP5bgSbPnv5/NlKRu+1ArFhKscfODD2MeEHWMCeSjnC2Y5J?=
 =?us-ascii?Q?qrClUdoHQFhuOXn8g/mEpvPrPusENj4X1hB/rtZ4WkC8MDNVFgFUqoqaQf9Z?=
 =?us-ascii?Q?/whtn5GIKDIvlo2iWLNGIlJm+OiMlGoNc3/cRWcr4g8H4XYZah8qGqlfP1rs?=
 =?us-ascii?Q?0e8MOCsUkSkkGokpJ25wkChjUJvTAUKvh9uBCpaDiXb4xY7WKmZoay5UsPTI?=
 =?us-ascii?Q?BvaYQsgmzTwWQv8Y2J6MJW30Y9lVP4dAJ2rlppE4L8qwRZHtvobU18KTxnWG?=
 =?us-ascii?Q?a5xHOC4rOfWXX7nvPaMA711EPbh9kFoQQj4Hy9ObHDihgoF53kqf7CA6hmgs?=
 =?us-ascii?Q?ASTn1E+oBkK8KwD/VN5X80TG6GTZKHyT9q00xb5IoS0jup2Zw9+FbmmHOKWs?=
 =?us-ascii?Q?azff5oRvOAO5h9dIQT9Pcv3ARj+UNHQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2588f9af-5b37-4bd4-768d-08da36b19d91
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:30.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNeeoQnVLZ1yFw82kQTBj4yoekorlvgeM0pGKjN0bxz6r4Z4bFBLi5a93m75w/szTbJkUlvNT494+/Hv2TFeB7IUDmhCfeWgpPTBpmHZx8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205150120
X-Proofpoint-ORIG-GUID: VQdwtU4Huv2U1Q7ZVWpCtodAjiDA4ZML
X-Proofpoint-GUID: VQdwtU4Huv2U1Q7ZVWpCtodAjiDA4ZML
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

When vhost_work_dev_flush returns all work queued at that time will have
completed. There is then no need to flush after every vhost_poll_stop
call, and we can move the flush call to after the loop that stops the
pollers.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1d84a2818c6f..9f8de04bb673 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -653,11 +653,11 @@ void vhost_dev_stop(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
+		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick)
 			vhost_poll_stop(&dev->vqs[i]->poll);
-			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
-		}
 	}
+
+	vhost_work_dev_flush(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
