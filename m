Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AC9C433FE
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC9D0611D3;
	Tue, 17 May 2022 18:09:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XsEc6-srXQN6; Tue, 17 May 2022 18:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C27160D7F;
	Tue, 17 May 2022 18:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC2A3C0083;
	Tue, 17 May 2022 18:09:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBC7EC0081
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3DAA60B1B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYxhl7sb6UrE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7444960A84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:05 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSn6B019084;
 Tue, 17 May 2022 18:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=hFpgkw4F9mD7pAzxnxOeODtye8gQpIPjkntcnmhz+k0=;
 b=w+M/4OynCFvRGecMEnaIZ9zR9bojIhXXmPQPtaTFNUrCZpVixz6iTqs6r+LJrYatbTAI
 EjCKkmaYutn8p48XIyee23EzszxQ7d58pGghM+UJOh5B9UoUVE+Sd8zidRvAUHA9msFS
 DMhoAeHo/vLCVEZsroSTxFUbe8kJ1fOyFlU0FSN+GHLs9sUTPaHkqny7ECds0euiL70/
 JfSMcNTo5s/U9NRADX/+OcjkK1xPgeoPE15vntM/CqQ1kDqNqvZaVewAJDXJ3A4HKW2h
 9GoxTX7fi+uyFiAGw1QV+P7NKl3ydNhedKGL+Rl9SQFDds6Qfs6/X/Fylc2pLc9ac06F TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371y731-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI693K023985; Tue, 17 May 2022 18:09:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v8xk2y-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3kOFUuiUDx1abpzwXZmFpvXy5Glnb3bzKV42tH8MoxWNKAvAmFWApODxPp517ixbDruT6nAAlEkq0WR4SdQD6wCchcvDcDq4xZD8xbQl7nSyclG2mqc2X8pBpY81+GyQokzkjvphyw4E3K+UHODKtXUoTJzkT7ResoZyqavs/amGtYa09rF3TF5SLVqrmJ00Wm7i7tD2SGaUK8rrVVC+Cziwak6ntdPTlDj+xvYLT2IlB7jPFHGaelv6WMKvZGaDMYaNKVL7NqbXlABVrASw+0V+1/N3Kl2Qx+4u92yV5vpuBgeMZeW+HOIgjFlMSFI8LgqmsqOR9PgzeYfcygLsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFpgkw4F9mD7pAzxnxOeODtye8gQpIPjkntcnmhz+k0=;
 b=nS7zB1Keqx7pS12GUVsbdPkzSWuFZrsiz3uHbWjO6V4j+bUDobLOIr48Ztgdjt/HriFYYLYG0hqOFMFxum+npJPuSw/rVQkF05sKbhdOTBN4cO0srbOlt9x7BcWQRg0PLpF4ouZhmnGRhz3FWpfzZDXJa3V3EnmaHOd3bgRpAUjsD9cACm0xddLV23+gQrPyct9iDat+VZ3HTnwzh5si/ggFyg/g1h1XfbqllsML+haSC/mqdvedsCgPfMLOHbtq2KVRCbB6UylRdqVI0Lkw/8MT6ce+K9Yb9Q4Z/K4Qs2Kel+JkwQAVVyjjMwO+d3PjwROHjtMHis5byuPs3SaG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFpgkw4F9mD7pAzxnxOeODtye8gQpIPjkntcnmhz+k0=;
 b=JPtZj3NTGsD9+GqT/K6FPK+Xi3HKrzpII3Q0wqKOAJ9k9swnf4xYHRrlMg3/UqKbINu1ri5Ulc4ry+j9xtAcwWS5UJi7xIXZMsXXWI67yWZUxCgP5xbYlqIc87bbRlSepISpsOii+BdeLSAwMzc9MDFj8zAUlCcPhZEtGlYl81g=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 18:09:00 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:09:00 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 4/8] vhost_test: remove vhost_test_flush_vq()
Date: Tue, 17 May 2022 13:08:46 -0500
Message-Id: <20220517180850.198915-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1365eea-93c8-4b3d-4f00-08da38305176
X-MS-TrafficTypeDiagnostic: DM6PR10MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2873E49138080038EC4B7DBBF1CE9@DM6PR10MB2873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /27Tg71mtWQW+Pv8uXaJ/1aFsoYk3EMVRJo2V9ozBBiNARvJyClX72RZmD68VK26LDSj2beUbKvZTjRxiSgDGbaTifGQSqF6vST0A8l8umIKrQNCELkTAm8onbV2D2WGYSqeiBXYGwNxXyMudwNHKioH2jmLDVUPTiGoZ3eN3yjiZN/zqAC5qevx5VzV4IfBKFtSw8se3M4uLglYbQlRZPmBGUq6MVgtjVpP9njLPqn2TA0TRmGx3DI+nSi7G/cgg528E0xy4f5Zcn2DU+90smyCFO0u1xD0lXtYGLR7BO06fKyx4+lHAQtHkPY8oXs46VxQ+Cc061sCkcMdk8UYjbZRbkCas6Ckcym8FLCyLvkdO15laHjPR3GtpEcE+RiwCaRIlIEJUIuG5/sC7I2Iedj1i1q/8HarqBO/XA0EZ/udJSKZ751e7bTyMFRidWCnCDyd4O7Qsd8sd6jwXxaWAHjiIgtTn4L/BtIQq+LDS41gr6KduhoylZ1a8uoOqhtl4vPU4CdNDF93GKvg54mkNnnvQTGI303NDpFDrMpCwh3SeWfGuVq3iEryvImNuBXhzUouCPNmJ6c+T3IsjtEdVmf0RKaEe5t5yHfKqC1lK5gqEEj/SIJrD0K3XRe4kIWtSnDcYJQLJb2pa2/66U8RfZFZPAai2IP8clarLUn4V3PKifhIheCVAJ5XoDe4zFKv3nTX7ZOor3QplckXrvyg2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(36756003)(5660300002)(83380400001)(6486002)(316002)(1076003)(38100700002)(54906003)(6512007)(6666004)(2906002)(6506007)(26005)(86362001)(2616005)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(508600001)(38350700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ed6Kgcf/b3vPEXZUtLkpB2IdqKBtYr04q66pMm8Ix7bO1Sjp5BBZ9gDdKff1?=
 =?us-ascii?Q?sa56//aLTlhRZh14rY748BF7v3Yvk9FNkkrWBiD3IUsS8kxLrPn5ch8Z8o86?=
 =?us-ascii?Q?sAgX5F6oTzl1XuH4EnBA8EYvREgG+yqQHSk2frC5DtH2iKyo3l+b0pSxLHn6?=
 =?us-ascii?Q?AH9Ww3D/8/Pz96W496h3wHX0z0JTs56Zh/GGMhbaFB2k6KJbSf5Evd0UPphL?=
 =?us-ascii?Q?dMVrf2I8hy8+hL9ZstmTW11iEef8GvcH8cc3VTlMkDi+tz8CnMJTkpDy75Y9?=
 =?us-ascii?Q?yGGGviEXPOFeC7SaYOs7fNan2VkLW3eCgxt5NRYnpjqtfwxYGnl2SfKW8XIN?=
 =?us-ascii?Q?Jsoh24SU8mEp8jtd3CEAoYq4dA4TzcIcOaWX2EJ3ovq65Gr9RddjSZ2TdchQ?=
 =?us-ascii?Q?gGnH58p7ahHRLnx8pahEq9HZM2vHKcungjE5BxCSjg1yLPmRKWAGdEF6adVK?=
 =?us-ascii?Q?D43T6f3CMCKtsAzOyX7iu8Ea03YzysjIJPt5iosHK2rmKa0ObYzUTUznb3vi?=
 =?us-ascii?Q?2HGzuMuh6y/lb8VbZe7OeQ3WtPVp+fG9b8eN4T8A74ZA3Han7nUw/sdJuPSs?=
 =?us-ascii?Q?n1iGNmqlSvn5iUmw+KsTTMjaYDQRVsYvX9yBJTX7QQI9Wa2Fw6TypccWR5o/?=
 =?us-ascii?Q?hMFyQ7XGmKdZ+sW0EhFLLJKz8uweK8lvrCvSxc0eSWOLf1w87DVGj/36uhSL?=
 =?us-ascii?Q?5yuUm+jhXf3NbS0qeRxaEZJbjskBey8SeZ+YDWWmRmY1j4OHjYRTG1ZTenL5?=
 =?us-ascii?Q?rDj1I06oMDfj1Pm+OrwsUQxaFTmJrmD8mvfwphDmCQ0trRkOb4FV3zoD1dwh?=
 =?us-ascii?Q?xyWCBKfNvGfHEEvoyd6TM7eNZiY+VesiInQEuK2lA3jK2vdDF9t5wiT/BI5g?=
 =?us-ascii?Q?c/UKqRsUi92yeAQqmIgJ+u+GHSCej+wcKCl6NTnNvbXCq67WmfWC6cDRLF6W?=
 =?us-ascii?Q?orKOnIPqfCUMuHqzHfvsgo2HAb1o6QkSR4r79CpzKIeotNXva1dRgsfJn5dG?=
 =?us-ascii?Q?G5hwta2pL1Lx4R27oGEKshL3WZacqKCkDgluzk65m1a5f8577QAd1hG41d8y?=
 =?us-ascii?Q?cgvXHQ6m3nfo/l0tnZOd0oSBnSF4uOqS5II/Tw8+t26lwE4T/3IKWEZ5tx2h?=
 =?us-ascii?Q?c+Ieut/M3IRNeDy28Rm4sOQ3A4xD8XurzgiOxYW4srivCbHzJTJZISG13W24?=
 =?us-ascii?Q?jXcUdpIwfSiydhm4pTHeOR9eswtn1HnJzgOsdR0p8yIOXBQchIKxeXL7vVlZ?=
 =?us-ascii?Q?7V5I+bgR8UzBf3yM5aKJHfeMmWqH4o2RCY0P+KXP5j7cs32T1q12f92BQuWH?=
 =?us-ascii?Q?3RHvY1ogsmdY1du7KFozJuxADB36uzq3fuKs63YiATqjNSoPX8YW9EArJ6ZW?=
 =?us-ascii?Q?Y7zv0Ahd4lmUYOwMVDWfj04NXQDHjc7gDDf6NLhLdxHZLTkVY5ZSDeVOJf2h?=
 =?us-ascii?Q?+ZuhwTVgw8XeEjDtAoZq5X62UTrsHxtB4LsdnfMDdaKrwKzRdWbCN19N4rqi?=
 =?us-ascii?Q?vF7HcchGN7pYaV0X9AMkEuepY+Hcj8iU4yF9vk4zWMhObfDJ0kEGgv60c71f?=
 =?us-ascii?Q?n5BF7My+8MmHJZfTjVMnLOHHvhzemkbasSNIv16wjdrMb6uId+sYB22kPJTz?=
 =?us-ascii?Q?rvDZoNsbVlefjLMtxky8tq0pwaAnmG5yn5jVOoRfH98HQyVd8582uyyKbQUL?=
 =?us-ascii?Q?Y3JXF6JJmU5yZcHLMkGaA2GqkswY4wcQPcdYvthPYmpLKAZruw6FrWaBynGu?=
 =?us-ascii?Q?3KsPPQTv0lNVjd6GrOaF7TwDrEtin3w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1365eea-93c8-4b3d-4f00-08da38305176
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:09:00.4046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 490iiNQzGkTMqlzLINSkHyE6Z2yLa4nBHxIxiNns7cYT7ra+c4lnHJ/pt1qO0Pnz55xJZyI6qo3U2o7g79olWXkGip4YJM+2PI93+tha2aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: 5mIgq8E0OFhi7MIzS-6TRM-m3DYgShY5
X-Proofpoint-ORIG-GUID: 5mIgq8E0OFhi7MIzS-6TRM-m3DYgShY5
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

vhost_test_flush_vq() just a simple wrapper around vhost_work_dev_flush()
which seems have no value. It's just easier to call vhost_work_dev_flush()
directly. Besides there is no point in obtaining vhost_dev pointer
via 'n->vqs[index].poll.dev' while we can just use &n->dev.
It's the same pointers, see vhost_test_open()/vhost_dev_init().

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index f0ac9e35f5d6..de39151366c5 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -144,14 +144,9 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 	*privatep = vhost_test_stop_vq(n, n->vqs + VHOST_TEST_VQ);
 }
 
-static void vhost_test_flush_vq(struct vhost_test *n, int index)
-{
-	vhost_work_dev_flush(n->vqs[index].poll.dev);
-}
-
 static void vhost_test_flush(struct vhost_test *n)
 {
-	vhost_test_flush_vq(n, VHOST_TEST_VQ);
+	vhost_work_dev_flush(&n->dev);
 }
 
 static int vhost_test_release(struct inode *inode, struct file *f)
@@ -210,7 +205,7 @@ static long vhost_test_run(struct vhost_test *n, int test)
 			goto err;
 
 		if (oldpriv) {
-			vhost_test_flush_vq(n, index);
+			vhost_test_flush(n);
 		}
 	}
 
@@ -303,7 +298,7 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	mutex_unlock(&vq->mutex);
 
 	if (enable) {
-		vhost_test_flush_vq(n, index);
+		vhost_test_flush(n);
 	}
 
 	mutex_unlock(&n->dev.mutex);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
