Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A8DC433F5
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 06:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78E02409C8;
	Thu, 13 Jan 2022 06:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ImePfUdXYWSC; Thu, 13 Jan 2022 06:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A08C14090C;
	Thu, 13 Jan 2022 06:05:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68DD3C001E;
	Thu, 13 Jan 2022 06:05:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D06FC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A475415F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="XpxW1SCa";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="sB1qLRiG"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eb6PpRo_mlgV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66A7E415F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:04:59 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0h5rM012722; 
 Thu, 13 Jan 2022 06:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=91tCfxBPwHkH0xIqB2wZ53ps1bXwp2Lt4sMIoGoq1/A=;
 b=XpxW1SCa0piTsbqqwEABn6/xjAYBIx4lAiJivbOha8gybLCSKD8zCO084DxVyQFUuubR
 61kIdoYz2B5KB0gfCSulUrbNDH9DSTpQraDBLMKhUsrJsy5T5vkIAryWs8Jo/fXui6SJ
 vJZW30+MDlTnQMKfEPHgg6pMXjMmYy4oY3SMaMWdETb8aVGJRw1YhEj2e38wMkBpUVOf
 N5+PyWaqk10uU3ClSP1ODbglqDBpEH+3JvA+aLnCF9iYgSXnKYbpoZWEFMCtpN/Seq1g
 eZeU3K3wovkdtBK4c3VpsZtUReTe251y0ER/mwL0OdYPN5W+zrXUlOUV6H7MkaXFVxqT 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtggjpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D5tiXo168433;
 Thu, 13 Jan 2022 06:04:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3020.oracle.com with ESMTP id 3df42qxdw7-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEPRUEUbDBz7Ffp79Q3qnNN+hQ+MwH5b6eAz0Hd232IFjK4wf0TD0N7EdiMROuuv3o263bENvYr8hmw9KsILndC1ujcC6cX1ess3lwOg0Q5/IRj82kQHcBAYDLN2PAuG36KXYdVfCXwbWZPeDM554hi4PtzXgLNGXxwRMDowjd7MdF++7vQaDXh1WdmvWHRYJ+NmKpqbuZSFZExcn/LBH6T9bVmjZjXV9AC78Coj8la5VOhLcCVWz/qU//abq9A28IKiHFhR92VGzN5Jbo8AGquA0rdCN8WSyysgj5iA3peqtufMsb8+l0vzCNX/Hkiu62yApm2qwsIzpkadb+NvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91tCfxBPwHkH0xIqB2wZ53ps1bXwp2Lt4sMIoGoq1/A=;
 b=VtzhZQG0f38O7w38QAO0dvlGX3T0IAUrKBHbuR7pkKyyYSLeGLzT1Ke5O3xZxMfPxvPmSUajiF8a3nw2x0XkittM5haCDssBZ76NRG8tPHWCjq+cuP38IUhNEKxM7D7t2WFv87S0zuI7I6drkNQKydU7WOqgZk3icJ7wpaKrxJSHv7DNjDxUjeiM6yymaqgQzGWjJB1uOm1Oy3QYsHoIOTzJEuWISbDuoj3ZTpIqKQkI3HZta5Wx/QlZXPuEaBHo4ZUBlW92AvXpwrnj6x4YQ7aKPCORrnyDt2MNHEk8N7Jg4kKK+B7rVT7mcjpUPvdjfoYU0qjw6qZpK/vy15KQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91tCfxBPwHkH0xIqB2wZ53ps1bXwp2Lt4sMIoGoq1/A=;
 b=sB1qLRiGfnOlA2H8avIXlXshQXfd/8xp2erY5NB5TISeoI1cpAR1OpqhFN56i+y6u1MeNn1NHlSl2VVmMBR5HBEzQuFWthbYcvtxgsolBNfGseE5I2NaWyEjjIxRYBTWLjNkeztkPPIkwx8V7PaUYqrcGFMaUdp6X8AiEBmpTT4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 06:04:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 06:04:55 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 3/3] vdpa/mlx5: validate the queue pair value from driver
Date: Thu, 13 Jan 2022 00:10:51 -0500
Message-Id: <1642050651-16197-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
X-ClientProxiedBy: SA0PR11CA0188.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ace231e-3642-4d1b-6a6d-08d9d65a9efb
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5599:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5599A37BA78A20F52828A637B1539@SJ0PR10MB5599.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVpxesSB5PLI9IasjIXaLEvZOk0wVCZKfr2XVuEC5+bYMjcAaQ7ul0/tamUReKAPZQ279WDEcX6NwDOH+Aa4/P2EhCmiR78AE750/12ydU5dpcmW3P0/zcMlu720QyZcbmcC3cJGuB9zyP0iX5u4NniTHXEel0DgGdzhGkKwxB3NlRMrmMVeKajVLYutguP/LYkLhakcXynQSmnwVVcyIISqelRHTLioHCoVmaiUVnOb5j4HMad3HX9/FRTmOdNjTjgMnsjBeB7/MQgBI9HMaqil40vcD5/KfUOWUFxqTxwSfvDZn9hKunsB/ZrmWVpsq8l0FB7UqlIng0uWBsfZiXthAkV47TzrpGrK/ZEnpmqQNyxOTjG0JnzBArgsOAciblagy6bdKamdMBh3hWSDPjNJSBsovs1Ku0m6OCWsKAWm1JxnveRtiY/4S8jFaLk2bDEjj7fy+OAj5+9JCkAnv++M3IirXDSDHRrxSCGnle6YW7Yvt45772AuxiYEi1OzNH4ZYYV3z+IaR2awbTsVtn5RUE4Qo3GeLX4dayjLLwwfhXx30T9sKGqESPE31xLT9T7IeU48DVNzcHXamrS/z1D7w+2/FraXUKqCwuqm3FhFXyWn5rxlcIY7cRvN+IpXZVjRX1jomqF8kcnm7OdoQfHm3v+jdFOncx5dQ5NrMqJqekzkJ6C6g45OeIpO+NtIjdN3BbSv03BFaHcl90PLgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(52116002)(26005)(6506007)(38100700002)(8936002)(8676002)(6486002)(2616005)(107886003)(38350700002)(66946007)(508600001)(6666004)(66556008)(2906002)(66476007)(6512007)(4326008)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YrmGa970iiX8ywWJYF7tS1LqPZyS2NSjlLJ8LunFowR5V/9VlH8s5l5YvWNi?=
 =?us-ascii?Q?Jv4TTxmTME1PRRNnd9fDbZX5kJA5jLOlJ/uUlpq9p1IdBa/mdAaIWbYw++yR?=
 =?us-ascii?Q?5VJDJFFJX5wcz4lanQJv82aKQhP7LNlBIzHfm8CrJOKemar3nkrNbKlG1o+u?=
 =?us-ascii?Q?XW4qPy7HGSswCsQnT67cY8rSBNLHFAPG3y/BwLQos7ziKOS30PcPfYJooXBA?=
 =?us-ascii?Q?7e5m/MyQj/SyE2+4X1Rs7qdjnmE1L9ARJIV7dSmH7Le800C+mf3OuYWcZNyF?=
 =?us-ascii?Q?mPbbQuHZDKRHrcXW72fIkLnSEmRHdhDpfvfPSBhkkbY1dnqcUoWEhhP3mkbH?=
 =?us-ascii?Q?vmDSxnlaU/fCoZj5Eem4y0y225m9zH8BfNvryPV9C2fggVfCSQXeM5DSrE/Q?=
 =?us-ascii?Q?nNcpU1fLKPg7d/HP0JoVqRzkVxqwrrRRINGox07XY6EOp1BRkIg4NalufeYU?=
 =?us-ascii?Q?oGGSFjP6ZzmUFrHJmL7XSImpFDefOV9HNMg9lE9XXFG/qA7J0tzn+fVNV6bL?=
 =?us-ascii?Q?+828bn9uCMvxwsxIRR2GWUBZ9Hg6QWAdusWcr4g9KK+gzj/ZdmBqh/to4r0Q?=
 =?us-ascii?Q?XY+HjXhxNRjirvBXDsBoIZdpNLTW1ftZv44qb8n/yH6EFySAOLBu4nj23t3G?=
 =?us-ascii?Q?WyhKIN7Xvl0jfD8BjMYvKTDYA7YXEKj+zhglxcuN4SLlIJs46QhVYEGSQYas?=
 =?us-ascii?Q?geTHd6SjrrcfhyWEWJXxDHbREAo+yJR7uuh0pJcW2HNDQ+GquY5R87Xsz5RH?=
 =?us-ascii?Q?e9kmSFs60zs5k/5G0pQLNLMghJhaz6/ffeY5WSg5JceAyqw1TgnUt4f+pnUq?=
 =?us-ascii?Q?IJKhSvbEWJuBekP0+iulNK8HwEtkDkUj/thGGDW5shdJQ2eB2FxwwFAB/ir3?=
 =?us-ascii?Q?tk48DRHswodcI1NsW7bs0lV+cbvik8X8nWrFrgDQ4yyr+rLfvcWF+8YBSYKM?=
 =?us-ascii?Q?Q1IJdMPa+UR/3mKZsYii2GaMI1ePUZjHgSUoT6FG5V2FnTHb5r771tSmBMz5?=
 =?us-ascii?Q?Mv0QctMsw7KM42ipQphz0WJZa+P2jns1zp1hIF5y/1U+SeykWkdHIxt593xq?=
 =?us-ascii?Q?ftXNwgUzHkWQGEKm70CM57bqP5y1RklhTjz9E+1w1gyfx5Owv0J4GrjBDexV?=
 =?us-ascii?Q?2oP67Zbeilll0OnCzFgmPC4R+IkNR7YFTb3I+NxRtUOV8KpLER04ExuD1n/b?=
 =?us-ascii?Q?6x83k2V9iH9WChYyAAut2SJVN/3geVE6anSNLCSfm11GW2DPzNfY73+jzpFf?=
 =?us-ascii?Q?A/FCdZP9W0qHjRiUhx0oenhwjUMqOnwfD307xFtlOkVcfXyTvqrODoVsyvwT?=
 =?us-ascii?Q?jhW5hPcvzwwmnTBmykGtuEUJo2O+LpU805fJx2CE8EDSZQo0tY8ZxzNa9Z7Q?=
 =?us-ascii?Q?8je6sbg129h4yyVwAtstFtGXGHt1iCsln7kLRFvcywsn5J61E+EWAQs9+JFA?=
 =?us-ascii?Q?D+tR9xeIutP3UWDPsAMqEfDzY2beRU3qlHI7tFhegyY3rv1uMOG89AjhsFC6?=
 =?us-ascii?Q?swYr3A2yOWw49Hq5z0zvenvkVdG8Sb9qQRj+QBRjTfZdO57/MYz9kRCtFT/2?=
 =?us-ascii?Q?WJ6CDxOiSnq8GDgRIHX8KTZEkdE8lAs2H02//NLetgDlMOYazWfXmJj8npUo?=
 =?us-ascii?Q?eYEHDUn/kiGqoUyGfKNyeCo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ace231e-3642-4d1b-6a6d-08d9d65a9efb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:04:55.4032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CV80zOW+vYRMuB7dbHjGPJtX+xDU9m+GCSJgxg4SB/rUvzJiGS9E+kn6KjL8yOe6XsSrb1OrpT9RzSWaO/6c3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130031
X-Proofpoint-GUID: -ekCIiJ7PfHC9EXz1qH2K-50zUgaqzFc
X-Proofpoint-ORIG-GUID: -ekCIiJ7PfHC9EXz1qH2K-50zUgaqzFc
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

Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 46d4deb..491127f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1563,11 +1563,21 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 	switch (cmd) {
 	case VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET:
+		/* This mq feature check aligns with pre-existing userspace implementation,
+		 * although the spec doesn't mandate so.
+		 */
+		if (!MLX5_FEATURE(mvdev, VIRTIO_NET_F_MQ))
+			break;
+
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&mq, sizeof(mq));
 		if (read != sizeof(mq))
 			break;
 
 		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
+		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
+		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
+			break;
+
 		if (ndev->cur_num_vqs == 2 * newqps) {
 			status = VIRTIO_NET_OK;
 			break;
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
