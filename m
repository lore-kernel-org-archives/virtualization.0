Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E43C4332F
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 06:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9C1B409CB;
	Thu, 13 Jan 2022 06:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4v7ye3RklOA; Thu, 13 Jan 2022 06:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D4E9240988;
	Thu, 13 Jan 2022 06:05:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05862C0076;
	Thu, 13 Jan 2022 06:05:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B68C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5107A60BED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="YTUagCrJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="ELsJ5yGH"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQ0l42-hkhKS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F65260769
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:58 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0scIp031725; 
 Thu, 13 Jan 2022 06:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=SQAzyW11H/jQ9cXom9TpkFftoka+kfkXxoMHfW8xXi8=;
 b=YTUagCrJZd6f+LX3x/QLSQn2dJXsE+PD/O0zN0sm9ol/abDkHBh7CS2aMT27siQLHLKc
 GLKfQs7jrNB1VWPOVac8DP+ZVbotxaoJOx/sJ298WiNvQDWy/3IcdjO4GSy5nC9ud0sY
 m79L2gD/VNmI1pRefBwv8O7uYbAScHy6lebR9FOQBo1iwGCDfZkVgy7k502qgkVlgJm1
 8uqkRdPw3s6VdLKy4M2wjiiNXGPDbsv94RuOuvkxxiMJZY6GfKGtDz7lR7kBZuqDd89R
 gpKKYtE4SpgQHaSEOpRvJza7kGpbZ66B6wRncEtuJnNeh8NL/1tG97+rUkb9VRwF5J2V Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9g7mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D5tiXn168433;
 Thu, 13 Jan 2022 06:04:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3020.oracle.com with ESMTP id 3df42qxdw7-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBjH7UwL6Fi550hwIzeFfoer7R+bcm8u/4noS3Uwx4Tag8jEseI/OvhSbOsnvLtuoiAZhGrk09iwgW7MnghNkIneboCv5mVVuMJEtWkJ0GkzvXvK56/gQNuO/X7tSod8npO8Y4gvb20lr6QZyNNa8MpGcYq8EOIBQhYL+uROsjhigs4vU1jVsokBsq3SlxF1KyGQCT6JhVtVw0O8m/+xeCWkq8+TbYGq11sCq4CgX11H2eik3GQnmHum6Rsh5a4WL1YPS0734olyF9RMhNrTMgWLoby/w4i2xBOGr2WQV4VDV5M9DW3Xv/AW0h56zrcG5ypW5GXq8EucdTuy55hp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQAzyW11H/jQ9cXom9TpkFftoka+kfkXxoMHfW8xXi8=;
 b=LRmSE6h4iKdbaRA9wXcbDhWyb/d9pSDugZgycISOYqf8uP+PsSZG6OFAyIggp7qg94A8YdSKMIffcUkZdmicQiujC5RaoMpENiNhLeISfSBsay1DE32EVppKRHAPprsEUNzd57zeM7PMeTPZs+nFT4fVSUe6/6k4SqE2PXblp15IzkfQ7/g5LNCQqASGtpGE89ykOgLAFl13SacFm52hSwlYt6HzCk/xlPF80A94rE/JHgiWdJ4o9FNhvs+dt3AhfhW6+7k+xSN1+AeVcg6zuFAdk4IBzzNDHFXy4oy4p1B6zuByuMKhymmRkQcrLggXR+GBWupPk2x3sVxMYnDj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQAzyW11H/jQ9cXom9TpkFftoka+kfkXxoMHfW8xXi8=;
 b=ELsJ5yGHgsZ1/t+gtjnUKPCPmzQJ6PMsv4b+VGFwoYzN8Okn2JXZNl+p/uKLk3YcTBsJg4lQ+fMDKkBsY2DGdDZNNi74sLx5vJzgHvzwwiqCgltOpZ6A5LAn+BzZUtj+de17MlMVeM2OwLslYroDN8gWJYFZ+MQgcBLMtpnqRs4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 06:04:53 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:04:53 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 2/3] vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
Date: Thu, 13 Jan 2022 00:10:50 -0500
Message-Id: <1642050651-16197-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b67b4961-9ef7-4327-7a12-08d9d65a9e03
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5599:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB55992BFDAE5C7BE6C3C42E39B1539@SJ0PR10MB5599.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILkypve3BMPj2JyfpVeZ0dBtfF+hQ+YR+DGxByKZzzr7aPOwNoUZvNfyQFQvfAkekY9ECxOgYVFyQsBvRBeuTnQkDxNvnidYteY8mhwEJrU53lNfC/ucofwAc9mGhThlzXTTV4uvxN64Sqq0w6bo5E2jkxXZ/i/cFDGx6FsLe7P7ZX1ZjolPfQWy3riDhTf21NMKdEVgjbVNzOm5+aa5/OIdfHyOgtD1NScbFLuQs3tNRRm5HoMcNP7f6+bcIcxdGP3FXk1cYHhp8CBiapGFdTDidBld3qHUrgcEry5S3WufFW1u7fEAGWM4H1aVhx9qC9nPa+qr8DBbUBVBK/pCdy3aeCcjUoXcftpLMizNjjZgHD49NFNlL+NWM/FqL8O9DsjOVfYnAjHHiUNH177IZE84mGj3RUEjFa7m94rS1U0kB0PMQ83Wrb/jjuPOs4hR/CrDJ6Eb4gDFlzsPrx9ZK6C8WUkMr5q+ysQigq8t8Cba76Lc3Rm9jiQB1/qYqptpHFm/yjvIrjU2nf5vbKwoN7g7wntAhhC2BlZ/zVuiTBtAdozw9eWyxMOn3r3KCtJWSP8eyYcxvgNJVvXq8k/JKv0lMLQAVNtJp2kpbLTRGhB8w7tJIGHX9/CHsIR+0AXwF5rtBkxGfbijugHJqk/iKkpa98Uww543AJIsOIxSqbL4qCzBRvaufO4o0b8vW4yhXDhybMW21OmK3vbl0+SGtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(83380400001)(36756003)(52116002)(26005)(6506007)(38100700002)(8936002)(8676002)(6486002)(2616005)(107886003)(38350700002)(66946007)(508600001)(66556008)(2906002)(66476007)(6512007)(4326008)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yw8dOPb5JAkUw4jJ9a5FcPeUutJIQklM33MwEN1EebZuYhFKRKPJ8tM4NZ/y?=
 =?us-ascii?Q?H28zIOvSW03CoRHDyW6jQ/z059eJeV3orPIz5EZ2Erj/sigKkPm9em3+yeMJ?=
 =?us-ascii?Q?U/OqWXsYu8sTNXLYriRR6zUOc2zp0GowCtGAxJcCPfUJGQPLhJe6zATqGF/a?=
 =?us-ascii?Q?ESIWuOBiBI6W1qWlsALdbbJeK8SkyVMy83l3W57FMu6AXSBX2sFKlk3MHf0B?=
 =?us-ascii?Q?H5MEYJeyc7vkOkvUj3xl0PATqgYsUreT2K46VyTP3s4585Pb/hgqlz1Ncvux?=
 =?us-ascii?Q?NgcwsLjC9IR/RG0AbGJ3tsWYXrqV6QbWBxigIRymFHtDCPheRR0Acm24SiBw?=
 =?us-ascii?Q?0v5686ZOsuKsu9kLr3DBltVP759DQ50hqrxmJOY2mVsP7y7JOhHBdWf1SKDW?=
 =?us-ascii?Q?/mbOO0MW5M8D4wlkqimeFFdnYwbXh9W57f8ThDgPPljCyQjT+aOXVcopHmY4?=
 =?us-ascii?Q?pO/URVFJdKMDWv4uStGqM82CtH1/48KM6nsjFwCVW7p3rESop+pqVtG1lSTY?=
 =?us-ascii?Q?4LIIjHvK+QX+hsGeqkqHafyiZ2LXvow/ZC++cAZyqSEEvmK6A2oIQ1u/jI3I?=
 =?us-ascii?Q?A4pq+oSvVhYifEoZ/EEE4ECrclmVCGH8Yv8oI9eG7XIrE+hgLVmCcS9n8X5g?=
 =?us-ascii?Q?UnMlpWv3xxc3FmHGATpxtb+T+F991SsjEk12/cB4hAYc3MTHSEntGYiG7Glk?=
 =?us-ascii?Q?gef1omlPwbZrp1ELmea1S2PP0c6jiPby7YIk43yla88EARW6SCd0ZqoW51J/?=
 =?us-ascii?Q?9py0le+0h4OcjhVP7dW5MAPqUCvs/iYZXCOwqcoydbOZ02Am/uXgOaqtyW0p?=
 =?us-ascii?Q?1gwSu1h1zL7fPeQ3ram3dBGX8yodv19z/l68at3BSxWUIVzRFb0vJOuCgung?=
 =?us-ascii?Q?Y5wSkD8+r7OorEAESYLyk7NB0EL4U+5lfX/02o6FthX4L+voWNJcCdSXtVz9?=
 =?us-ascii?Q?o8CBWNPmxcVjo/MK65M9lKAj8czUvwsH5d9k0ym6DuAzmAdNHubCoRFwCF4x?=
 =?us-ascii?Q?d7/68lKemQzoFPa5gSM/iQn0vyfveemzzMUyI60P49WXOWL7dHpB+aJPkKmK?=
 =?us-ascii?Q?FVUyVVg2HnTzomiEwOBgV4Xrvtod43pTTHp8WHDdrlv27YlQzLxjozL594Ik?=
 =?us-ascii?Q?FIf+qA4deJ3e5KN2kL/CRpWJrTRGazzjdk6azupJ9YZNADC4DrcLhYp58I4h?=
 =?us-ascii?Q?WioW12sghHu5Dc7ggXu1Jv5cko0D3DgtuOuqF3gsffGFZzotqTbVVmJyfLgD?=
 =?us-ascii?Q?LTSjXUk3VXAhYDWHFQdWS9UI+xg196YlF9tRWRqIfGIK6eh0se7sngWDE/mW?=
 =?us-ascii?Q?RxCeUPbz8Rv5xWeE26PUKD+Dl7kndNPI55Mx6MjsSbCq9+Y2gJaE8mYuDDhZ?=
 =?us-ascii?Q?ObCi4gy6l3B+DY5rW7eU5ScIvFGi2Wiauv1PYPBLTsHf5ClgdUgwBXpaCadp?=
 =?us-ascii?Q?bLjDE1S5ngJ+q+ycoJ0gXMv3mbIUcyJl61kfLhXtKtmGQq4XRJ0N4JrDTiLo?=
 =?us-ascii?Q?UaDupP/wm9dk05hCRTCJJBETfCXUocyP3fgZ7KO/XYi2AXigZNyMB5/5CIHh?=
 =?us-ascii?Q?QuuFkC7FgZUbDfN1cAzAKXVHLR9g8aDx3N7Sr9kiVGTAlHDgm3RW3S0YuUv/?=
 =?us-ascii?Q?80ktDFSHZXy/K0Mva90U+JY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67b4961-9ef7-4327-7a12-08d9d65a9e03
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:04:53.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjUYpl1ofM+d8NCaY/ceKUJly5z8FhlDocJYiThxD8lpa/Jt70TFPKj0ufsFWe+DGqBba0/honrtFM/BvOH2bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130031
X-Proofpoint-GUID: s_5tYMyI8Vs4lQca8eZ_U_0IkzCx8AaP
X-Proofpoint-ORIG-GUID: s_5tYMyI8Vs4lQca8eZ_U_0IkzCx8AaP
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

Made corresponding change per spec:

The device MUST NOT offer a feature which requires another feature
which was not offered.

Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b53603d..46d4deb 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1897,11 +1897,21 @@ static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
 	return ndev->mvdev.mlx_features;
 }
 
-static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
+static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 *features)
 {
-	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
+	/* minimum features to expect */
+	if (!(*features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
 		return -EOPNOTSUPP;
 
+	/* Double check features combination sent down by the driver.
+	 * NACK invalid feature due to the absence of depended feature.
+	 * Driver is expected to re-read the negotiated features once
+	 * return from set_driver_features.
+	 */
+	if ((*features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
+            BIT_ULL(VIRTIO_NET_F_MQ))
+		*features &= ~BIT_ULL(VIRTIO_NET_F_MQ);
+
 	return 0;
 }
 
@@ -1977,7 +1987,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 
 	print_features(mvdev, features, true);
 
-	err = verify_min_features(mvdev, features);
+	err = verify_driver_features(mvdev, &features);
 	if (err)
 		return err;
 
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
