Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C766C433F5
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7ED541A45;
	Tue, 17 May 2022 18:09:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIPvbES18zN7; Tue, 17 May 2022 18:09:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9D63408B7;
	Tue, 17 May 2022 18:09:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B081CC0032;
	Tue, 17 May 2022 18:09:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 624C4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4378783E09
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="W17NWgRC";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="b2R36l7C"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9_KgtcCumL3b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEE0883DF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:03 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSip2008006;
 Tue, 17 May 2022 18:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nyU7SoZSDyuu2KDkWMWWjfe4H6kUc7/GxEWStxj0F5o=;
 b=W17NWgRCts+CZjumMlBaRHazPJrb7VbwrFYEAJygLFDAMBxiy/QLxE+ZpI0/YuymPrVs
 r8GVMvZj+w7M/nrrtlIUMdjA2n4ybdf+L3M2bDP01lzCRr9C4RKNrzPqYYFIqVHIgmyx
 FaebNlQoXpI+db9aaDVblNf3ITjNSFDHbKjo5YFnfnqcm8keHjT5xwvgdse9MpxoAWeE
 VKZQUfkNHNrPPBTCSKkYiViCkU6yCH0gseM5mdyJxEKnA90SsIpuLcU/qmtHNPrzR2kd
 y1lTkFLJ2eZ+3TwMhWZkMFZJ6kuAQLPXvnQ9tY/30A/YjI8ea1q8epwiy7+PlscdIt1T XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc6xm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:02 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI69lW023951; Tue, 17 May 2022 18:09:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v8xk2b-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLp+w2pxGVDJ1DxFfWM5bwYdeErjacYuqv+t8UgtPwMAufmMQpPJm1aOaPNBHK7dTQRhY027d8lryL9+btnCiMqGa9CBJo9BHfTuTrJiMyrl/UYJd/gvMRVz1xiFHPuPpwJ0zszGqdbHIt55iUKFsqKfxl2SWoI5ePiOIEIstK0lNQRw33Heucf4x3UxtPRd0llo1ElizczJiQbdI8ULfsD6/9H8IOWUefsgP5dK5iWEFMm6vwiK8oE+ggGjYLCHxcTt+dLxgoXdoQW3DQsyWClLppfoqWxcoGuOODNVIZzlNnvyhjB44PEISaNg7LXJtbqjxOO7WAudQerLvOahhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyU7SoZSDyuu2KDkWMWWjfe4H6kUc7/GxEWStxj0F5o=;
 b=O7cYCTPHK9x1Pv75chBxQKWPOZDo/1b/NSi43zta8BSO443phVFL+wTY3pWpaTOOfTJXSfONoXt95QmmM3/CMF4eWqM/VB6qcDGTBJMcCtkru9Gw8nwV0hY6hweNChGRAbJgUXLpTN4aqUbf8O55ElI5zBeM58oZfWTcgE0n3V6yxeqS0C/bk08v8pX92O/SxPxlyyXk9xdreD2gxi8mRO2QL1NaPhUFNucS/CJeHExdmTzAfRLVbVB6WB8XUG948Cg6rU4PG5nrfHtU8z0jSYXg9z2fsfIo0/Z7CZn1Ol5Ai/mV2mqZ05g/6ezSzYerRewSuvi/6g1SG6+GG3vsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyU7SoZSDyuu2KDkWMWWjfe4H6kUc7/GxEWStxj0F5o=;
 b=b2R36l7CsYOCVgN+hPMoaGt6VByu4NIQSHl2kOjBDlBaUQVOFZXd3msybZcYsv+s0Jj8Tnk2/hUD2fcmEUmqQyRP51im0X77yve/4lCqQwE3GeFZdLlXjzRRb6v9R5DoVGhVtXrRsdSrUps4pyd5RnnHu2X/ljv+SKb4KCXSyeE=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3993.namprd10.prod.outlook.com (2603:10b6:5:1f6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Tue, 17 May 2022 18:08:59 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:08:59 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 1/8] vhost: get rid of vhost_poll_flush() wrapper
Date: Tue, 17 May 2022 13:08:43 -0500
Message-Id: <20220517180850.198915-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3f642f8-a8a4-4b96-8460-08da383050a4
X-MS-TrafficTypeDiagnostic: DM6PR10MB3993:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3993F1C07C02C0AA6D066027F1CE9@DM6PR10MB3993.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oLotuHYSmmS7lKWYWrkqMRSj2ZvOR0X+O0EDVS59aOkInw/HM7OklC0hunBnKY2qAU066VK0JTu5efXAsEBXoL/aq6y4MYFfTPSl9Ewl9eveQz++rUsfymFPWKaJuGUNi1b/c3Sro6sDRcajPd1TkSrYjX3JBfZVnPMnOMnYuKeSmsDLfF5If8EP6UfAzX/1xWSIb8FwEBYetR7Xyj9at+tNv1gCRVVGn9zXsESSNwdUDurF1zna2hMhjKyBBxrRj7/wIO1qXSIZImLnv205+DSXfyNzM7N+O0DhRF6C7EYbuXVvjEj4PYZzg8hKwT6jmtDMXfcUFzMaYPO5uBN1KJ1Nr7jVXsP7kfNW6YFDAGUs5BpTNXDeNBEVQv4l1ysySiE0c0JYsRTEbMOexuu/LlQqpfdcyGUcO9G4jvXyuzzxt5WFEWSUjbYVp2ZR1OPjfFlDtFalqQerjSnO0ZZy3OCThK+Ya2tNec8Px7FJrPkgJqeZsoGzixQGkouZ6v3mDNawwnSO16hVHjGhN8P30vqHHDT9YZW78qxspaTgTmDcAaAXaKv8+CXS3/Fa1HbMSpxlg0gldK4U9G+hYUvc0KAqi5FgT8r0svg9m5XI4OZ2z0U0V6iPS8nvRXOq/ADKQHIQU/416gQihixMMP51WrgQIYcIwPBMb70MnT3DfkRhqsslz8xUMLWDSMdAKLDjuuIjLu6ZXzD1FjhOmrsfhJ8mQlBdTjqDKQaCKPINhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(2616005)(83380400001)(6486002)(8936002)(508600001)(36756003)(38350700002)(6512007)(2906002)(8676002)(6506007)(5660300002)(26005)(186003)(66946007)(66556008)(52116002)(316002)(4326008)(66476007)(38100700002)(86362001)(6666004)(54906003)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVmvknCMGkT33UOUdWCaP8d+XNQI3JeLUQ40lHGluvaTwgwUVIQ9g2yCT+rg?=
 =?us-ascii?Q?B7egSX33eltEAtsjS2mKmC3+9QrB4HSvV1v8nwFjbS5b09tihPzSStPUR1Ko?=
 =?us-ascii?Q?mWFmJ+JH8vLNIh3PxeOJvDYAEPrAuTyLeulc8TtUyCfPi9q8DDwba1MgeobS?=
 =?us-ascii?Q?D9mjUOSJqm5yj5j/Y14MFITGaAtxXpBYYEqq4TFmvaOOMN2Bnd1Tu/x88kTU?=
 =?us-ascii?Q?sZVJZrQ855M8aF5wcaVkWKhuWTC4JzV+gPgrFPPBX9frQMLk4QKjPoh5Fs4v?=
 =?us-ascii?Q?ClGwS7WvgaY9AMIG/ATCOh8TTdLDmE4r3suxQGyEWCTraEYp/8d9dQqDCcwS?=
 =?us-ascii?Q?bStoT88Vp/XTKmy3RXVeytPZcNKwzJFhbSDEUnEQnEQzjisBGp41RRDAFHsB?=
 =?us-ascii?Q?ebucbRUImpMRX4+xnb1AxJHplp/wOqWscgqf0QJhcwI49khNolpzdtWioy4z?=
 =?us-ascii?Q?mI9Ze/hzH2HLVzJhT35qeCGUCGmrCMWye5RZ6DN77RexaeyP2XYEIrwEgglo?=
 =?us-ascii?Q?xLBXTelQhD8edy9SRPB2jUNkYGzEaPcLqBDR8WRAt3CV13UJpkK9zsdjAg1S?=
 =?us-ascii?Q?JGx9vGcPmNj/IQSDC1TeN+j1AF9sBO+6D/qgS7dKr5PDdqgM4ARBnCNMTvMH?=
 =?us-ascii?Q?oTigbD7Qnj5f59/Ang01P+l5l/Prs/sNyaqPYwcI56X9h9aIB29h/L3GcTFj?=
 =?us-ascii?Q?F1QYdOtJ04Ythlc4LrQKEfnsnuCO+ba4HkXk/LorxetZno6lbVLa2bX/R4ug?=
 =?us-ascii?Q?tboZ0DOQxEldQ5PBC9r/P3aNRQHcB1KFMt3wahQTjilJHomE7g/CQljs7yuy?=
 =?us-ascii?Q?Gwr+F3uCMJQuEkww1OB5MYJKYYLecF7R6iVOohq6oMbD8nS6Q53lgI5Ea/Ue?=
 =?us-ascii?Q?3YQ+1pSBoPl1qgOCEpSRVaCZXTI11mQj0iy5dVuZm9kC6fSIIuR6qq/6gh9e?=
 =?us-ascii?Q?O/QroBi6LTe5g7f5LEsM+SNRI3ReN+Lx7vB4RbN84q50XWVfZxQIHqFjZ62x?=
 =?us-ascii?Q?eo1HaKLamYgG0JHZSvsYSW5zmCwcBeDCi5fadazyerPFaEExNs86qO9jJRku?=
 =?us-ascii?Q?MlJhGwGS8BrDKPbp/U83qbNQ4l0uN1LeyfhdtZ67EDoNYgefhYjasAbYkUiB?=
 =?us-ascii?Q?hBoQ7jhWAnH9uhm/0nt+SV/JBKUYJLjEKKljUIBYQmvQsGU+Ur92SfAgvgX+?=
 =?us-ascii?Q?BWPdbniF+BZILS8QXM2/VjiOKuAjTMEgEb84hPHc3sQfYs4gSPGRfKqrffHm?=
 =?us-ascii?Q?+xkRoR3R3Hp9zBIsV/W2WL+0n76pziIaKu3BEmMJcUSGA0CkFp9ic5PdKsw2?=
 =?us-ascii?Q?bkHHq7BW/mdktI0IXWtuTniHWDJjx1FKHIEqfI86qcevoT88BPJzhiXHKGRC?=
 =?us-ascii?Q?Er1dJrpaMSzSAEYU+QSepYwUoW2MUmMp7bKyuAIjL7cP1XlydrgWSexU/Lib?=
 =?us-ascii?Q?dFnSNOYBrnyP/sXGaIu8CASy7IHUm2fsfGrsSiuxBRmp8kb67Xe5uwBd4LWO?=
 =?us-ascii?Q?tZDbNqu65x/zgcL6F0c3kqJBLsmU/rSoqtPu6H//4aZ54uCkwAOez55RK94t?=
 =?us-ascii?Q?WvojA29AJTCAFPFlD1AKDUkIqPqrIa5oAiM2tJRPM/sHwdy0H1Ydfkv6IPpg?=
 =?us-ascii?Q?eiPCqhV2ui3acHcS6V1pIOld00njkTSkKRH14h4gjhipSGlm3rWcgFSCCNgw?=
 =?us-ascii?Q?/nhlT/hhgdnFyplSUVG5dvhNMRvFb4z4SjuIotOQIHycs/2sGtMVt9aeSaW4?=
 =?us-ascii?Q?xC6yN2rrR+MkIqkb7J1dLIwedN58Y1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f642f8-a8a4-4b96-8460-08da383050a4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:08:58.9984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p94X8wex3KsHMkDOH3KHCiHFQH6iPr8n/C+kseV3J7B4uAdlJ2XDeySLbH3PhV3YGZ3B8O2py8K6eRUfgQWEhUNI4qQry2k74dGXkXwNWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3993
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: QYr3vH981cVKecfEOznVNnt7RGClKuts
X-Proofpoint-ORIG-GUID: QYr3vH981cVKecfEOznVNnt7RGClKuts
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

From: Andrey Ryabinin <arbn@yandex-team.com>

vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
It gives wrong impression that we are doing some work over vhost_poll,
while in fact it flushes vhost_poll->dev.
It only complicate understanding of the code and leads to mistakes
like flushing the same vhost_dev several times in a row.

Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
[merge vhost_poll_flush removal from Stefano Garzarella]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/net.c   |  4 ++--
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 12 ++----------
 drivers/vhost/vhost.h |  1 -
 drivers/vhost/vsock.c |  2 +-
 5 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 792ab5f23647..4e55ad8c942a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1376,8 +1376,8 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 
 static void vhost_net_flush_vq(struct vhost_net *n, int index)
 {
-	vhost_poll_flush(n->poll + index);
-	vhost_poll_flush(&n->vqs[index].vq.poll);
+	vhost_work_dev_flush(n->poll[index].dev);
+	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
 }
 
 static void vhost_net_flush(struct vhost_net *n)
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 05740cba1cd8..f0ac9e35f5d6 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 
 static void vhost_test_flush_vq(struct vhost_test *n, int index)
 {
-	vhost_poll_flush(&n->vqs[index].poll);
+	vhost_work_dev_flush(n->vqs[index].poll.dev);
 }
 
 static void vhost_test_flush(struct vhost_test *n)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d02173fb290c..1d84a2818c6f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -245,14 +245,6 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
 
-/* Flush any work that has been scheduled. When calling this, don't hold any
- * locks that are also used by the callback. */
-void vhost_poll_flush(struct vhost_poll *poll)
-{
-	vhost_work_dev_flush(poll->dev);
-}
-EXPORT_SYMBOL_GPL(vhost_poll_flush);
-
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
 	if (!dev->worker)
@@ -663,7 +655,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
 	for (i = 0; i < dev->nvqs; ++i) {
 		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
 			vhost_poll_stop(&dev->vqs[i]->poll);
-			vhost_poll_flush(&dev->vqs[i]->poll);
+			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
 		}
 	}
 }
@@ -1719,7 +1711,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	mutex_unlock(&vq->mutex);
 
 	if (pollstop && vq->handle_kick)
-		vhost_poll_flush(&vq->poll);
+		vhost_work_dev_flush(vq->poll.dev);
 	return r;
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..aeb8e1ad1496 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,7 +44,6 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 		     __poll_t mask, struct vhost_dev *dev);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
-void vhost_poll_flush(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
 void vhost_work_dev_flush(struct vhost_dev *dev);
 
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index e6c9d41db1de..a4c8ae92a0fb 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -709,7 +709,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
 		if (vsock->vqs[i].handle_kick)
-			vhost_poll_flush(&vsock->vqs[i].poll);
+			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
 	vhost_work_dev_flush(&vsock->dev);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
