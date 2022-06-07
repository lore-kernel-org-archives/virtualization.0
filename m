Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41973C43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 06:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E817640500;
	Tue,  7 Jun 2022 06:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VnpzsX54VN7k; Tue,  7 Jun 2022 06:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 854F5410B2;
	Tue,  7 Jun 2022 06:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59E37C0039;
	Tue,  7 Jun 2022 06:49:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60668C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CF4F60BBD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="mDQXek5y";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="t1ALRsbX"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GiofkPaCRGat
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E1AE60B12
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:49:41 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2575kc1m011536;
 Tue, 7 Jun 2022 06:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=6qtDwlKvjfK7zKvrNToarR+1YcevBJua6gWRMNVtf74=;
 b=mDQXek5yNGeoPwz+7BLjxBEQrhAwmrvcdYX9Z4suvcBAUe8/jwxALSV8IMQcEUi0A/mC
 8GbQphkBCSGunTZngS25iMnBXGzEc1JKKwmbkewj3dbgdeFn4Ihz2xQbEfIxpMnqUJrf
 /qQ8rIxuoRrEROMOA+5SaD+B3d75UUHFCGq+WnjgWhIwDbkKXnFCjmU4wgIhDedXWEsT
 oZyYX0lk2h+zwhOSriHMyP9u3WIQYeK3um1mem4RUUCqueys7EuWK8duwB+HUGYDvzkO
 L06R8NbTdfPamXGlvQfyRHkf3GLMwDF3W/lGZ7gqz1bjOp4Xv/VDlS+XoFBLz3wXYMxk Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekctt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jun 2022 06:49:40 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2576kTZJ032811; Tue, 7 Jun 2022 06:49:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gfwu274w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jun 2022 06:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo0U7iWm5UoTNhCLAJf5yRtHY+KuGfbUa5snjzB/x0ht8HqCh+x2f2qvcZsixgk7DwVMHk3b9BTavFcs4G+0b1eAzglZwQFMSEY9c/y1ZmUnwqTqYlwVxKZ/BImqu1KVyeNWrKBWYWOR09/xPvi/qO/euZB6LdB6Hr7/6STZII5+imCx3/0YZGRrP5dnFkkRt7AtGTDycyJLeurkfK2AucoDiFpPhzrPCr5r5uwKewbneTPUcRgF4Y2o4zft3TnPU8INMtufuhOpOQGmyuXAFBKjWH4JP1NNCJ5IcctNkbLAjVTmA8YgvML6T2Q+1nI0CN4j37byomWKImYY4+ztYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qtDwlKvjfK7zKvrNToarR+1YcevBJua6gWRMNVtf74=;
 b=PAkh/mjRZDwV/LFd60xFR0CctwvUYoMDbzauob+QPgUSNP+zPhHIbipNT/AGhR3wuZZS1nBAadjOE+IuyTlMs1+rQ1CG075fcplaligDglnL8KqCb28bxkXAIt4q3qUwCDQGwug9axmO2rZ+oUbjHZatCn8GLcADapm4fxGGjSb3HPT8y3iNOPTjdXczNKEhHsvVBs2NE7lYXwdFFPNzA9aDSeT284QRa6m3dE45wrpvlU02WPwFGNN0rqQvZjfRpPgKwkDnL9ITIg1aPS+hFkDKqwHpzLFPoMtmHnnmwfTL5gR1raU9tyfYpKtVNe46niJ9Zyiz/pV7FMw62mMixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qtDwlKvjfK7zKvrNToarR+1YcevBJua6gWRMNVtf74=;
 b=t1ALRsbXnaKDOmQYln2ac/VJKdx73jVUhRltO2ubp297H5wbq1vYkSfF6PrClk1YS+SV0UfiwzHSQxMse/AERCHgzoX6MZfosHZ0ajSw1SFtfmo4GOuAIIug/vSH+y5JLCUY7x9hyvroFjaqMEAOCrhqgZzfq/t7XOx/xUGGnWA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2616.namprd10.prod.outlook.com
 (2603:10b6:a02:af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 06:49:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 06:49:37 +0000
Date: Tue, 7 Jun 2022 09:49:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 1/2] vdpa/mlx5: fix error code for deleting vlan
Message-ID: <Yp709f1g9NcMBCHg@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0190.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1172cac-4b93-4371-1344-08da4851e34d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2616:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2616B661B4E37F18E4524CC18EA59@BYAPR10MB2616.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQDDEYX/IbNtHDFZwDh0xNZJi+M3MJa5XLeV+wa91tZgywq1q5Rib1v6glfALavDlQJHPB42gHA9ins2B5XjicFE1WBNeaO/1vitHxmsJomcM2IDU3sQNhiU/OLSBKAicCDnaXM9yYMbLLlz9dcMrj+M69wD/RLgUeYkXuSmiCQ++sUB0A6qolhnwxFRp6/8jfAIjeMfu/8iApAUicfCMMbfIY04+Z1YTn0YzAgk/XCYFoqL4FSakQ+OficIeTXzDdYmyMalBn59b+eQIWpdOu2RFOndAVpyF+7bU5UyyNV/+gjSVBIAig6LkIGeRnjSNmkGB8F/cAb5WS3kd34xRJ40YvADMesJaMULsCLq0GWx60AeCUWSrg8ZAwHGlF98e8n002w3omVJMHMSTNU2r/OcXVVD7FQjYyW8OwmrKLPBc3upZcU/SpsP0Epk0d5s4Pqlivx7QmOFJYubuN4Sw+r7aiYSjtxS1vEiQPnMsSp0XXHQ1rfcewMlsywRJRXogjqHmCj6obuIeb9oGsuZohuk9z+9SN+MDzLKlodIBhBFHPPUqTx+/7aX3a1S8KyjuWQsoFr+SUKSaocV+gmrB5NBjlUHjDJYaiqfYlDBOEmtCD4a16b0Jk96mJpIqry47HAzKP0qhioIhm3zc6pDk3w0nrI8HoJezOGE1uqepir6dEetzjMaPppNFff+CcMApvKFbr0bZx8Sd9FrbyzUFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(8936002)(8676002)(83380400001)(4326008)(52116002)(54906003)(110136005)(66946007)(66556008)(6486002)(66476007)(6666004)(316002)(2906002)(4744005)(38350700002)(508600001)(5660300002)(44832011)(6506007)(9686003)(86362001)(6512007)(186003)(26005)(33716001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XLHJNG6Ai/VO1OO90XYFr4mRLkgcHf4qpOfVEt2IPQfe6rUQVXtObwYm1JNB?=
 =?us-ascii?Q?P+l33Ig2wJqrqwRDyQQj09Q/TRmEvuWncNElwpdldKEobmC97un/gROw3COx?=
 =?us-ascii?Q?ojs6j7Kl8IRfyqBjUlS3xgw/qrfpm0G0rzDFiZchlf7/wqYbjaK997LzC7so?=
 =?us-ascii?Q?UyEwbT7xMb34BT5PMiFik4pZzIOZKwL5kO1aZfkF6Y5XeNDw/o73h2gvckKd?=
 =?us-ascii?Q?BLN5ltVeOOrkyobXM4a51tncXwEeNmoypM7uJaTFwehgrFQ1VCpKObvZMWFW?=
 =?us-ascii?Q?iE5dJZyywK5ulfW9n01hlzd7eqH9lsUIWIas85nJS28xWUuUIaCzaNFE4QEg?=
 =?us-ascii?Q?Un5NBWuG2Wv1HJoHnB0O1yfqsuIm4IctYuQEAg3ITDmIn1sARvU9LPAhC4Vw?=
 =?us-ascii?Q?tdni2+xrIcAfh57V8mu3a+nT+vwoIuqEcaUPXyezbG+iIkREOiYryI/Tshd6?=
 =?us-ascii?Q?z8xZVD1rX0aaOv0fhXgLR6Wdtusj8h6XGfRONPcOAOnAR6JjhYIpuqOYvSRU?=
 =?us-ascii?Q?kidy9uW7CvPdV6/Nxt1peTTxUxgS3pHlJEHerew0WdkaAG2K3lTTrggj3ifK?=
 =?us-ascii?Q?u1mNB5foK0WwgIq/tWGfwMN9wLaK24IewTEh7ZU+hbam5CKxT53aVCW6S+0x?=
 =?us-ascii?Q?nNfTokM4Hn2rJXs9Ul6IuMt2NRkizxM7RvtZ0TOHvXAvErtYhCZptYjAgfdi?=
 =?us-ascii?Q?NKdqbexJdVgdTICHCdXAVSK8kJKzBh9atD/qFkdsKDzAGq93qy/D7DIJZzMv?=
 =?us-ascii?Q?56wLsR/NvA5yo/TaD8FLfVJYj8+qq3yIgQhc2bsY8Gz82n4E8A+8XYk5L6Oe?=
 =?us-ascii?Q?DqyYG0NQjXvCp2t6bye+3KbDaoRjgVFt2Wp9+e6kpp6e+5NX7BcizdxsAEa3?=
 =?us-ascii?Q?ftbiJbS2peBfQpvIWIsxusb1JLT4U7X7V7flc9rWIsa+dKzwHnTi+6rRKaLD?=
 =?us-ascii?Q?bDapZLcYjxoe5GOT8CZn2RGdrWJbQJOLyCV3vKILJZCQJggvfOgHJrR2VYkY?=
 =?us-ascii?Q?kJCy8xLji6V0WxD9C0vpbOlGuihdMDg199KTF9lXP30lWkkEVE3YOltfDIjS?=
 =?us-ascii?Q?c5rrw3xLkUQl00r+O1B0AjeNL/81vyNrErEmGMvzB1Phbxd4ZPNJJq8zMJeV?=
 =?us-ascii?Q?e3LJoaSUUtgdiMdWngPygTblnNUi0eyALQL+irxrBAKjrwKcvS+1g66nq5f5?=
 =?us-ascii?Q?M95P2Q/+0JkEqQevKTXlSq8o/oyBdr7/70n8wuCevUHZg4LyNt7h/Bt9atSd?=
 =?us-ascii?Q?O1+Q+61qxdHDOg806mdmiF3PS2j6gNcty6XytVcghnnwmDW20CqvcHEajK2d?=
 =?us-ascii?Q?tQP59uUVGGKS+3u7KreZ/r71x2E6AGdnCIifDRc6lIJN0l0w7ZwZcB7rxLov?=
 =?us-ascii?Q?m1+6lKXJUzt4Lq+8CCSPI3PpHhjikEzg8DFyt+hnijqIJiwM1O8MmRLZ2lyx?=
 =?us-ascii?Q?LLjbKVOA/3ZKnhc9Zcel/th35MqboKkXBIcZmTrEgVgQbXl1ofkUmN2kPe0k?=
 =?us-ascii?Q?GaC+XLm7agVdujTR+FELBcv8B6OoSYIZaFyQv1QITNx38Wdlt/Ms9xU7W95g?=
 =?us-ascii?Q?AXYkRyq07F16MVdYH0pDLE76uMBu3p/31MjUU2ZUknBG+aItx+e+kGHXjLG8?=
 =?us-ascii?Q?3LQugCzTjTnpzLWPrqJ+Iy+7BKwT+blBEjMxlu5AeAeH1m04TL2K50tl/iWT?=
 =?us-ascii?Q?rc+GoLynoQw7plZXzx106OdTOrAoIpOLtRkTt2dZO1GE60enXxxr4meZbvXB?=
 =?us-ascii?Q?CGhl3Co7A1kQFjEOPO4BRA+8HEic3Ck=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1172cac-4b93-4371-1344-08da4851e34d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 06:49:37.1095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U92L1E9Dt/Qy15a8zMmFQSTOGC/sCwP0nWbL19NWooh9uqZ1Xm3z82TtbBNKbv3gQjo6TxRHg8jl4MyNJEVZ5//LXh0JLrELx950UMNWn0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.874
 definitions=2022-06-07_02:2022-06-02,
 2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206070027
X-Proofpoint-GUID: iiHQ4rAbAAwLVuLWoCTR-BDUqZTGrVVk
X-Proofpoint-ORIG-GUID: iiHQ4rAbAAwLVuLWoCTR-BDUqZTGrVVk
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Return success if we were able to delete a vlan.  The current code
always returns failure.

Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From review.  (Not tested).

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b7a955479156..c964f4161d7f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1814,6 +1814,7 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 		id = mlx5vdpa16_to_cpu(mvdev, vlan);
 		mac_vlan_del(ndev, ndev->config.mac, id, true);
+		status = VIRTIO_NET_OK;
 		break;
 	default:
 	break;
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
