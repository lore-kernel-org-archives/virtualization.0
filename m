Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F7EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 11:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98BDC60E0B;
	Tue,  7 Dec 2021 11:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21EnPpWvbATk; Tue,  7 Dec 2021 11:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44184606A3;
	Tue,  7 Dec 2021 11:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 100B6C001E;
	Tue,  7 Dec 2021 11:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC55C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADC72606B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lKICfqjXBIcW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E49C7606A3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:22:23 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79HsFg004042; 
 Tue, 7 Dec 2021 11:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=oUfJ17c69WblhvB0KQMsuJzVaFNrme1OoWT60F4HpFQ=;
 b=NPVoxOilXCCfad0TX1a0NuKiZ/sFxPyd2lOEIMdC9XSsfBNBtCw/o5OBg06LVTnU5eNt
 dhAvPIlYiiPF4VfKcUYKZfZQmerO5cekgtiKVYJyBZk4eTtI2VgfM3zJ1jSKXLuvSOIT
 LZhGS2EHiW/2zQnjSNcHHTyMH6bkB4ke4PDqgpuvPIeORJv1B7oHdvwi3dzAUtGzN+gU
 qQOGyO+wh1O/3wPsrYTEKFBd4colCYTp4V0INpNlSmBbEh10phq0goc6vIg/G1gZ9Nyp
 o/5tNUyDeeKlGzzX+2n5M96LeFWxEI76+wOjpKuCSeLCXQpl+4yzZMwfnRlRHcV84qEV BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcd99j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:22:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7BKiRD128221;
 Tue, 7 Dec 2021 11:22:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by userp3020.oracle.com with ESMTP id 3cr1sntgqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6sgB8ips0xWhHYe2RQo2E9KSmhyahIVNsyxiAAr+ZMbCHH+AI5XFuvgS//C6I/tdoNnpGM9McmgqQaaq+9diVvBJIs/+5GZJPcx5EuD+nZ4SPN7fla8AkgJQVv0WFQZGEQL9uxWRUPYV4Jw7NcK5En6g4CtHsejmZge+FGIUc9pBmUKSOOzSQRcuzwtmV9F9hS7WFtRWngb/aa7w1W35EoJa6Qb8JAmPtH0Cbuoe09AtdF7R7qW8tNOXG2KW2GVomidCCa53gmGKj+8W3ne7NEcwobTAR1DPyOQCtwKksrzKfIDKwfrFR1YLeZr17WvXZCzl2Af+PeEqdXFm3ac+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUfJ17c69WblhvB0KQMsuJzVaFNrme1OoWT60F4HpFQ=;
 b=UYsuuJ/VfTynVaHk5ZaWxiVCkX1KdlmfO7X7e7yibQRBTFvr4JuGfFi/LgBwfI7TuyTaix3Me1qLKGupu2X6XifDN5GcXI0CbG8/LS4kghQa071D11drhfirT3sGxuOO20CtVVsGYHC1aRu9Fdn3ucHYHr9I8gR1yLFA8JmDS2nT2jMMNpY9AreYBJWvU+J7y/VhoowxuJeBhazHH2VgjJ1ZuVBh9xGbzx9FKGT0OLo9gu/gw5ocHG3KpT6IKhBTaPoznLf92n+tnSTlTL6s0TbtD15E93aspKC0uKSWwtijhb7i9nVhEYplTIEOOWYQKgBvxm8b55EnwvwFieYT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUfJ17c69WblhvB0KQMsuJzVaFNrme1OoWT60F4HpFQ=;
 b=m4mt999SFh6SN01CKZVfyAPqhsmL33sHw/WWlU0d7sbYBGnPBxo+4E8z4M1vr36LeBLtPOiB2YNWrrIKVfQXlbLaubF/tTC8LhlsMQyCWahsV7vYEtY4ZXw5/CYOL/nBWzdSkyYO6ye6wA+xXZjVJUuLUV5Dd45qX0Nryi+LIUs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5459.namprd10.prod.outlook.com
 (2603:10b6:5:359::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 11:22:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 11:22:16 +0000
Date: Tue, 7 Dec 2021 14:21:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] vduse: vduse: fix memory corruption in vduse_dev_ioctl()
Message-ID: <20211207112146.GA27784@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Tue, 7 Dec 2021 11:22:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0742e83-af66-4538-7cca-08d9b973d315
X-MS-TrafficTypeDiagnostic: CO6PR10MB5459:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5459B7E4C8F7E8CBF06A9D408E6E9@CO6PR10MB5459.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIPGm88gfjb48zPMbhRgrIlkK82nvyDayWA4uEoH1DIidaEgXuAvtGgw3vqNdr6Wo198YHDgQTyYDBvixZ/417uAOerFeOW64JIGzsuc73RDoRxeZR/ZbEpL10mRHFo4OxuzaAtqTg2KLP+ZboCvFXqsG8sAPfR4l4/mQLpjPmGkmC1HUeHtBB7iuw0MVLoilakoVRBfeqehhK0KYwV0+UZNMEKkFkU+wNRlO3ydgeonneX9lNOtEDLAe2s4RB0PdW+YxuNVcseP+vf1zLf1iXkT4Kj5Vjvd+nruX/diMIClGOBsd1lhhAP9IjICAA98hIEDquDLBOxrajpGS75vcYsQUal5O1drJr2M88UHz4sQZdBXYKsBBSvBGYTG39a4M5LYWGg616Zchcq7+VyQ1GeH66XVe5X4pDHUSLf71vYFMq/uztWf2nbvcgPmrlhY14ckEKpoaltaP1gSamIqOqQjtzBynCTkZPJ1I+AT5Dda/SXBdHBnIXqV5OwQBVdCjfkTTGoNRuEuv7wIU04jreKKcnpyUe9U/qU+ynzOh/JUmluCxNKyHuX+zotRos6k0KIjrsHLkuJS7rg6jySOG3FylY2Ad6aIXXeji9n7F9BpANEAwQj5h3yMIj9NuYrQF+3sPIFHT1I3HyR3xwR6qhN4Sjcir6ERm/QgEH0t9sronHxwE9iMewtYAiO1X7cFhIFkEW3hpN/0OSROXI5UZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(86362001)(6496006)(5660300002)(33716001)(4326008)(316002)(33656002)(9686003)(66556008)(38100700002)(956004)(66476007)(6666004)(52116002)(2906002)(186003)(55016003)(44832011)(1076003)(6916009)(26005)(54906003)(508600001)(38350700002)(9576002)(8936002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZnrKYrRaHYnUrCpcI5pBFD5k/BDm6l70pLNysV//zNlZQVQsUlmq3+R621yO?=
 =?us-ascii?Q?olDZDHt/4cXiB0mlBx8EA2uF3W3BeoHv6rlqJ/s2onnzujupSfqWgbIMlsvg?=
 =?us-ascii?Q?elUPAtkYLFQPV4onjXlhzLgLaMlZmZPJnfQkrv5Loffp0EgR5zCG8UC+irwz?=
 =?us-ascii?Q?v7DL2ebeLSmmCw4Fe3/SZLtjp98V8QO69+Bxyv2hayjyNMlSqlUMoB/jTxLL?=
 =?us-ascii?Q?fawt3gHUlLRZC1M8I7e8soWKR4UHzsLUAWR1odnPF9NofIFDWdMyOM8AYHHn?=
 =?us-ascii?Q?9qHbzoXdSsXmWOk3z6A4+iFsxnVXveBj+8tNvsgM/q73hrG/Sats2rF0kwrT?=
 =?us-ascii?Q?dPhCgFdVD4kWuERVIbXFPbHTpZkkyK4FF3dzB343VtCZ6r2D/ystzbhVy0kt?=
 =?us-ascii?Q?IexFrQN9r/YEHJGXBN3KZAQ3IvfQQYZL/Y/P1Fe1DG/edV10raQYzrxklkTT?=
 =?us-ascii?Q?ORBjtm59K1WAADUuMJIPvCUaKGvvmEebE92SY808pslQR3r6nACrSbZOF/Y+?=
 =?us-ascii?Q?K8crzdOj7UyH6gJ5C6EM2t5YPHn1R2MjgeTuLhaX9epAE4EuekK/0PoCw/RK?=
 =?us-ascii?Q?QULuMeaHw0xqOoenByNe0CI0tfJYG+zolaI4Zd+Dqv6RaX2bp9DzaeQl2QUQ?=
 =?us-ascii?Q?2JTWucTvFhSsMpdk5L/S71c22jbfjUzWpcSoc116sUkdzv2FYEaHgwm396D4?=
 =?us-ascii?Q?9AId8eDW2BvFHZecfh89FSuHUzDkbpn9/rshjNESclAO8z9/GYT6qxkIOaXa?=
 =?us-ascii?Q?0p9EdpPmhJuBNddZRmPvp8NLaEE9cuxwxYEIhvnAqOrTc0sRo+7myTKinohp?=
 =?us-ascii?Q?3Wv4A1aQRO7EzxkiAfFM9zSoNyybiO9rUG2U8QFhYW79rKfNXs2iOUNtVtZJ?=
 =?us-ascii?Q?L1BFKioOJ7rm/kYxvUAbxIDigTmfyORDMWX7X+Cw9fsocnE3chumgwxtXaMO?=
 =?us-ascii?Q?l+a3OIaATxeNLbRf1uuAAHt4R0olUHZ22VB4jEZKLRuXg0uWH6CRpdKIKYiS?=
 =?us-ascii?Q?LZqAxj7c4tCGTe/k0mh8Qf0LrOFSNA8tgzhov4xLd+Q7pKQk3/TibmauP9xl?=
 =?us-ascii?Q?p1aKk8TfrD2XlFteqimSeSNLMiys7yc+oQ2Mz9PwQf8YyZu+5WGTqf8rjYB3?=
 =?us-ascii?Q?yUd0+9WFoSFFarPoDoxZxhFOaHZcnp858hEQ12LiBY6peivfW9xj1KlKerck?=
 =?us-ascii?Q?taya4sHREAzZLg9zUk5/aFCzj7UYNT/Dyr8h6O4Ac+C3cwOxjwARFyPECAZM?=
 =?us-ascii?Q?jq42qVsUQ75DHMw3stqxmdoD1cu7vxadOD62Of+4cekSF8mR0GsK4YLQOFdR?=
 =?us-ascii?Q?qALeB/YozMC1sjz6w3RLCogepQtkkllFLdQp70JNcMbCDI2TPTsALrXUHSip?=
 =?us-ascii?Q?1/d0hp2IWv3YkoKr7nHP+XPYPiaQl+v6OLJBOMLa5le6HmXbRTmUDRZSL8TD?=
 =?us-ascii?Q?RelkKZlLL+6FtKJisVWebaA1LVGgQfF4zyVWqD/sMjt+ovsIqkxpg+vH7UYr?=
 =?us-ascii?Q?FuAI5UcVcjUL75UH6rby/I1O32t6les0UADZ9LiT5oh8qQbdZVKIDVjP1Q6v?=
 =?us-ascii?Q?srnQFVwAERfW9vsbML2vGUPWrxzhdyVc8ePWmbIVKtQTV4baH8KFY5bdbsex?=
 =?us-ascii?Q?RkzMwqU59gEcakk4z3WX/4pdrwGbNq6aTbw3jFYTS/kB9qdAtQuhRL+Spwhs?=
 =?us-ascii?Q?DAyT2GL0yXaN0Yv/kL20OfOQ7w0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0742e83-af66-4538-7cca-08d9b973d315
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 11:22:16.7122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSCQiGg4nizizh1gdwFwTrn4Vy1eTYuWbJWvn8CQ6+yyVccnpMRwHj1i1VUPrHJjiD6599NicOk5Psw+UyRk1N+Huw+HCIZeI/g3rPGaKxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5459
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070065
X-Proofpoint-ORIG-GUID: sGJg2xstaQkPfJhOvusSFomn6dYDmBMI
X-Proofpoint-GUID: sGJg2xstaQkPfJhOvusSFomn6dYDmBMI
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>
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

The "config.offset" comes from the user.  There needs to a check to
prevent it being out of bounds.  The "config.offset" and
"dev->config_size" variables are both type u32.  So if the offset if
out of bounds then the "dev->config_size - config.offset" subtraction
results in a very high u32 value.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: version 1 had a reversed if statement

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c9204c62f339..1a206f95d73a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -975,7 +975,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (config.length == 0 ||
+		if (config.offset > dev->config_size ||
+		    config.length == 0 ||
 		    config.length > dev->config_size - config.offset)
 			break;
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
