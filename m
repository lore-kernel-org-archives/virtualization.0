Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D75C43334
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 06:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4393E613DD;
	Tue,  7 Jun 2022 06:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7DDbM0cSogpt; Tue,  7 Jun 2022 06:50:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EEE5F60BBD;
	Tue,  7 Jun 2022 06:50:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C82CEC0039;
	Tue,  7 Jun 2022 06:50:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCFDAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB4D74161F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="YdEcwtSh";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="goLP16BH"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p6zOrpTFWIIq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E595E41619
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 06:50:24 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2576PFcb027046;
 Tue, 7 Jun 2022 06:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=iS+ecQl2MaCnHz8eOU4vbY+M1ulG8YvoHCvZ+t6OnQs=;
 b=YdEcwtShZuRzcFdDjxyB8x6stHgeyOmQX+hiP0sy8DtGJ6fOmvK3B/ktG26bDkKqkrxb
 gR4tLZDAC+sxf4CfRTCZFNGfkFlsjMnTB6HbiIYDnFCnPQxCptefUS/QhMdNTFvL3kLM
 NnUF5NtwX53UNLoz8zccyBfYgcx+O4CcBYl6MqWjwHP90WuXr/zHbgWfkAmbm7Sg474p
 qrFpNaW6lGvi1153ZRj+/lUTnPuMW8Zby7tYsw6e9kdi3UDXQhrVX/DZ2E67N3Yj1I9R
 ptm/hqW6793ZppGAximTsLAsYqspIxvZOoYvXTEp15wnj2+zSMuQzEW5FL2wjI2yCfCb cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfydqmv3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jun 2022 06:50:24 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2576kWK1008545; Tue, 7 Jun 2022 06:50:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gfwu27v3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jun 2022 06:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKwa+1aVGdJhuRCE7DUNTdr872qnbOTeyERZ5NnduAse4+S0cgcRoqgxDJCt8nP1f+O4kZVpcolAKVFUwOxWmA28f5OncbanwhsXV+MprCTPJkQTQo3DGhRk629QO2PhncouAZMgo96ic2vRNwA+L0kP9zqAUz6NfLker1Aj+Jwg9VKVVK7WS2De2r3ZMB+vkdg4arh9rknvNVuQExJT00XjCwvJ6b/lIBmSfbnesa0dt2A1n6TjT+aDPM7/HFMEJ+6lYXN6SW5RK4NBH01pEOovYMFiE2uVgJPwjLPm0hLD4HJ2wCqfK8HrXSjUjPr+VZV0KrwpsQVSJrbSNdGepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS+ecQl2MaCnHz8eOU4vbY+M1ulG8YvoHCvZ+t6OnQs=;
 b=cj55CoCqJQjuY/YaMiMCPiuMJ76yho6bIUmQ/10SmV3yMMUNCrAQ3mRMHUM/W3b9oxbltxln4/TfemBcQAgYIwjWukxiGCwCpOBa8fxGKOKXrQ4d+9Ki03iIrCw40AMiBCSwMju8RQTuYDc0JwH7i80Z3ug66qJkVm12p1tleXHDMHqkNO2k/uVSNf+Z/YjlmYoqGM+9Mt/7V8xRVaRgr5mP6mT+Bp6gOgT191pjnFotNxxJjqOCgUL1mfFh/bdlLkYNzlgdY0uHRAbUDjGHom7LkgqkRbe4Wj0dmNVTbJcVYqIsyoCUdGBewLo+cRHrfMdxrSdlGyVh/J0BXExNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS+ecQl2MaCnHz8eOU4vbY+M1ulG8YvoHCvZ+t6OnQs=;
 b=goLP16BH6IEaEckyug5iytyE3/syTB+CdDz8JCdA6QYYzPtVEJL+LztXAWkoZKhwmUl7vEc4qEXYenulEM4qslsBe/gVKsNFKNPoN9XHU61QSUm2p1pZjqRNLa6GArWxxDt93ZCg2/EkViDD9cLhMXKLb3Y8Vf3B5gMYkKUqcD8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2616.namprd10.prod.outlook.com
 (2603:10b6:a02:af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 06:50:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 06:50:21 +0000
Date: Tue, 7 Jun 2022 09:50:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH 2/2] vdpa/mlx5: clean up indenting in handle_ctrl_vlan()
Message-ID: <Yp71IYMP+QfuCJ8t@kili>
Content-Disposition: inline
In-Reply-To: <Yp709f1g9NcMBCHg@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c88f64-d53d-4992-6792-08da4851fda5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2616:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2616B437BC3D958BD67C25E28EA59@BYAPR10MB2616.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ov1c0OZkgPkx4sseDJjYGgBCeYKQg140tlDEdZNWdYKG752BtC0NfXvRDh69xBj8sLfq0tzbQZdzZA8lXJwmC+6QQ6VEUOC5bKlIw1mUqCaLLpk2Idw4tsSRJ82Idk0yNVF66KKfap7Jw22f6VxX0RjeI2lMLJuo3fhWBJjqZMcAJPti6mUen9nDxrxCSKZ9Miws0iPsDjBbbWLK9k/qAqKvdEjDqB20sja0N1PUYtG+Gw2iOpAp3kfcOcriIzqcMxGnEau2y+ZaPjyD7FZ9s4aTVICWPdcJU/cSLy0/HHqPP0bi1sFH9UnljPa3GcvyNzPa3u4pE0dX8lEmzwBzbyfd2u+gypmSjpOJ7GG2XLkhLFLcBD8iS3nwCwMzX8u3NbupCCvUgzR3u4gvBdcRYVIsCiOO1+QfVPHN7tv8Z57KJ1y8+ckGtpHWGs/Q//7rNTg54P+91vfeWUX/WaGLc9Cv23Axze3NZKS2pytjHJ6JfeAeLUL5ioKJbv6ov0LLhPPoXUUBkY2AVpUETduQ0Up5wAZ8NMieL7LlbKoaS7nMlrRGuRQxRitBKadWFNWHq9NiG5ya7fMqkwuXDl+GQx4xLYahdqxUSzxOsVpAjpvykkM4yhNtJaAlov0DfRAPPKBzisXuYFODNvWkZS+yU0AKpfuwMMXhP4s011MQ0xdsuDWm1POgC3mY+FlNrC8dnpz+FqdbxgSW9hC42bwVCuudbNAplgtDXGznApdV9LA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(8936002)(8676002)(83380400001)(4326008)(52116002)(54906003)(110136005)(66946007)(66556008)(6486002)(66476007)(6666004)(316002)(2906002)(4744005)(38350700002)(508600001)(5660300002)(44832011)(6506007)(9686003)(86362001)(6512007)(186003)(26005)(33716001)(38100700002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FV6utdQXLYaAzLMzbIzwROP1WrJ2kc+tryvRVYuHrIvllMrMIPrODddnW/3Z?=
 =?us-ascii?Q?UIC/CW63QJ37pzBSb7gQEYuh2U3PgANUJjYTfHSWHhirYBHaXkLyczo/3+MH?=
 =?us-ascii?Q?8SyDiY+zryHWNAgpXu8mspQdo6625xG7V6d/Uxr5JXscop7UOJqimz9F6VUO?=
 =?us-ascii?Q?C5HI+MOAkxtgD9hOwVies2Y1qyo5ybwjgYO0Jy3yDy55iEsr1uD0qzFW08Ki?=
 =?us-ascii?Q?RWqiCCPV2atmgwZlfX8NcAc9uUYkIMl/7zys2tPNdaiho3jHdloDeRC/Fx6O?=
 =?us-ascii?Q?HnDH7zZhR84P4u1l6xM3DcaxZQNTGZAGasu0Rb7j6rF5LzHBSjDqHG6n1Uui?=
 =?us-ascii?Q?ZIjnshLHUngZQx73dFA6DJDNGDIex7w41paG4pQtAcHMkgqdzDT1ZG/Q/dFs?=
 =?us-ascii?Q?Z0hKGoCKqgS0OBx8t0Lv6hGVqaP/AdyrozaCrNEVat10es2wuf2PMl0TiUiT?=
 =?us-ascii?Q?Tdl/4px8X2ktnM4dxVcmOq1XNNrECE9v26iepskZ50Nk5cbgURrkmqHpVxXO?=
 =?us-ascii?Q?cf4azBuqFPkbtpWVGL7QWaUiHXAoG/EzWNMY8Mri71TSkcnge08Q6TZ/kZ+f?=
 =?us-ascii?Q?vbGhETmyUdP+/fwH0zBakyocBSrjVOHXERSZHQry3SF9QkyzQhwUimfjpB50?=
 =?us-ascii?Q?F2Y21NI6jrvkUa6cdQtGDnkBVpQxyxiv9MZUmb1BNMZK1TCuZUe9YhFG1BcS?=
 =?us-ascii?Q?fh5eKrjmUKI/IrUVrDxXBRo9iH7c10wsogjJnNHIb5ij0LdBq/cROv9PzQf7?=
 =?us-ascii?Q?H1P+TKdlaup88yfbdrcwf5tdkpl6IRetfF8Ep+z+AmnXBgXKqRDLeBxmRXSC?=
 =?us-ascii?Q?U1jZkUFwvY1XFqri8NfMk+AWvTuRdp1HWvdNmpjL/Ak+tlgsHTYxMJIwaR0P?=
 =?us-ascii?Q?dKsEU78e+lJ5QvNJUITSVEOPM3ibiHSiKg32Tw9GDKvDe/pBt8ZOObfwSrYo?=
 =?us-ascii?Q?8cR/7LB5dnwSN0XTeXiBr4pXBlp6lyORDKFSP9fQkpbUth8sH/3A5VU4eFMv?=
 =?us-ascii?Q?+ZLtOFXNEuB29DBY53jysYsWi65VQvMpD+AbReapK6u9Ustp1vZCIEro2oVi?=
 =?us-ascii?Q?RfIGYrKYaTLMjdbkL12R/xiZXoPeyWBgkreaL7ZuPYpBK0v3AWRE9627/Ltu?=
 =?us-ascii?Q?JvNoWM7LZNnX7wZ0GJnRV90UYFjujOrQDeLfqys5YW4gCDLaoZ6uJjrF/rUi?=
 =?us-ascii?Q?b/J2W8iBCq/9Pp7Ceo9OZilldIMl4W3VcvOrBxUHWkGtSRWGeiXpTrwB5YLK?=
 =?us-ascii?Q?miOYBCulW1ihajb2GyZdiqe8tTI2SNWtDBuEM1n0r1+r9nxZRTulrLd++3z+?=
 =?us-ascii?Q?7rlLilUV/3r65tlpVQqMwHEe95CxYGxfYFlIOn8RfJPntrmQZhfA3RZ8M622?=
 =?us-ascii?Q?9L35PvuDcFnGWwdboISrLWmlM39pvjRmDLvK4ehKIfBB7JAE1gl9yL1rH5y4?=
 =?us-ascii?Q?VXBTt+8cZTb3/Bv6nVW+SPPEpiXZrLPv50JtkA7Y94yIpGkckSdjlcDBCkkY?=
 =?us-ascii?Q?q7+poR7CL448EPuiZOPs0Wqy1+gw8oYBB7iCLjB1R+0TSBdUG9eKNqd0wWjp?=
 =?us-ascii?Q?MDXWNo84nke82AKOyoMJwncx6X8RnMHL1rEbwLPRRfK+hFL72hkOo132EY/w?=
 =?us-ascii?Q?MmunLLPADAaW8D7QvJeJYZ/Fer/bAm1qrgwgAZ3h9Oy8dCDdRTN3son0ZJH+?=
 =?us-ascii?Q?pp7YE2ZtAKKPzJn/Nk8h1ZuzHNHbA8kevhL7/tZ6U2QAkG2GRf196DsvVJ2C?=
 =?us-ascii?Q?vGfWik0+BE563nCoh2ka/2yVlPeI6+I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c88f64-d53d-4992-6792-08da4851fda5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 06:50:21.2779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3JQUh0PwTe8w1TGya1/fNVcLsq5hKzqEqUMubXDJ3Vjvm/l3AnZXFowms4HSc5nyjo00twzOsvHcd5GooxuIePfiJAHLC1WjkFMy7f9CXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.874
 definitions=2022-06-07_02:2022-06-02,
 2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070027
X-Proofpoint-GUID: Wd-A-4JeQrA2fP3B4eJp_KVTddhDKGEt
X-Proofpoint-ORIG-GUID: Wd-A-4JeQrA2fP3B4eJp_KVTddhDKGEt
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

These lines were supposed to be indented.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index c964f4161d7f..83607b7488f1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1817,10 +1817,10 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 		status = VIRTIO_NET_OK;
 		break;
 	default:
-	break;
-}
+		break;
+	}
 
-return status;
+	return status;
 }
 
 static void mlx5_cvq_kick_handler(struct work_struct *work)
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
