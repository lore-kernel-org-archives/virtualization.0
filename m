Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E646C433EF
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 08:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2D8841883;
	Mon, 23 May 2022 08:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AzTBx-Uav9BR; Mon, 23 May 2022 08:31:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3603F417EF;
	Mon, 23 May 2022 08:31:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F163FC0039;
	Mon, 23 May 2022 08:31:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F392C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0840F83EB3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="paG7/VcP";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="esb3fKE4"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-PE9m87__0s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:31:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 911A583F5D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 08:31:16 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N4iaCt026095;
 Mon, 23 May 2022 08:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YnXWPSaKrkrg+DknkfCoe6ltEUmowxUaVDgYDhR08qw=;
 b=paG7/VcP9jwAmp5nYtM8w7yPGn2oFt2BgmX6TpuKo76tGPzwGQhlAPLjdjRm2rI1seGB
 p8Xmr6x5BFqL65tGd+Bn93Al9OVSkiOX8bx2YKZ55fmcKrvp5lpmkvf3Wa1tfsMlPyeN
 vHgS0i4UtmzpL5yAJf20KVTpbwK5On9gaV1DRgbTzEG/bZR4IEwt8mW6PK+eEY/RNjIU
 XVEEDnctqaiyA/JvYlOg91wUPa2gFT+9pso9XFZ/auzCgrpJil/89+ZF6FpDMY9Z9avm
 yS1QbnV0+kAgg0eN1jyT1wInW4Ftf72KsZQrmkCaZzasiy4ZR9iwaD0lVmangnB8d8Fc pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qya2jw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 May 2022 08:31:11 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24N8SPBn017821; Mon, 23 May 2022 08:31:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g6ph18tsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 May 2022 08:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoXH6fsesUT4N46i40gemFxef8T00b4Tqi1XRJtN18DDAgwp3698IMLW8sarVyj0GLokT5S2TwIvQmfnVpEDbI8/2DFBziexLUsgIa412pvbbNNtnd5GX7RPYhokJbHNfV0FL4eYYnWxvDHG7p8CFT7bJatMYrS82FeYZasN1WFE+vsPiX7xIElkhni7RWFx7h9nB3gwPgqCj8D/yUyx0DctCNt337Cbh7zWI5ljpIrahbkiBIKr5mf6h1JcksQHcPUN98GY49Snz+j7yBKEdE8O98LI67bkW6U+FePt2l/JkE61ZsKt5bCXbiA8ZIeyVyUMZ9hXuFdEIz/IfacTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnXWPSaKrkrg+DknkfCoe6ltEUmowxUaVDgYDhR08qw=;
 b=jvlqWcrXTUsWdODjpVG708L3Szy78e+4g7p7eIGK/7uk+d7ksGEJSKDmKil4B00E6gESi8tzknBekSLWdFwuPq2+OcefAT9200d0021+McStZvujB9982s27wDrx6xvVNhUKiNfyqhfhAvcv5u6e2eLlXoehRxJUQllVU83LSdjBiUBDsJRbQK7ByXT9Ve0Gly8iyHdlL6FQ0h4LVsSpU87xuXErctGg71mp0KYGtFjSW2bOYp0r614vUFt3OlFstqu5S+Lmr+uLr+FIWq5FypLf2/rV24yT1YEjsGtTpaVkWpxns8UzcFW+G0ixFFSY92Ij0FQeF1KkhhFw1sRSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnXWPSaKrkrg+DknkfCoe6ltEUmowxUaVDgYDhR08qw=;
 b=esb3fKE4vtZnoCfgGxWMrpcv4JSyjXBVdV9vpOOhP4NCJjJ+EWXcEtO2G6GaVyxbE54ti0PO77AokmD2oT2HA3I7L/CzmUfo4RjZIuotv0fPFzUr3UPtA6jxU6Cw96+NJ0rrlHLucFTxAww8yV52phI2T5z7YfJs87T6QqHpnkY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1781.namprd10.prod.outlook.com
 (2603:10b6:910:a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 08:31:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 08:31:08 +0000
Date: Mon, 23 May 2022 11:30:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>
Subject: [PATCH] vdpasim: Off by one in vdpasim_set_group_asid()
Message-ID: <YotGQU1q224RKZR8@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b0197c-3cab-4c75-9692-08da3c9695f4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1781:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB17813D33514418A13172962C8ED49@CY4PR10MB1781.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQ3B4mslV6W3fsq5eu9MaCiaGbt5BTljb93i48102LpinWAR458l+BN3mz7Ut+d991SY7GxzXGLoJgsQRFgAxtSN19DkhvErVLOmm/3jtSnJgjSH5kjEj1nNro0m+kYJ+CPUIAK+ESFBcZPZuTvaxJIebGcreHjE/tuugu9cSdEslFfha9ecfRBrwrTvRcdnn9+Q6XTsoW/7uY18AR4TxtE6p/8iJM5mNJmDzXza+5M7TWn3yYxNWH+VkFyFTvorKda5SGUVcx4/v9D6kzPDS7SjY0FU3Egwe5tXwNsPJhksn1sPxpMec5z99hIrhTZhSUq3HteVOyTX6i3N1kUvgulbHIub8ptq4QGs0QV+eP0dkHMNXXSRnY+7B4IbCxbM6h+N9g60twHgaX5fj0MDAiKw/Oawj7sjqwdr4MRYQjBI6ItkAoDQCgZ1gFcY0TCCzdDggBpBmml9HiLTUkHyNZAJKBy5e9sXBoDIsJuSqMFIarAAvc4H/d2zUYC1MfgaSUmDKMJoJDZWTjEy2gnupTJuMNyGJAFlQKONLPbKqlvTrwbbpBWFP/zJR7FaXastqDqOdJMMglcUh6e+ogKYR9eiKe+ucW8vxBfFDJCyAoWs2sEq3VjEI7GC6UVa7wmSse9qmk52DjYuYfWUcucidr0H/Ga1C8FNWaQ9F/03bK8S+Ns+z8YzIix9VrvQ+f+F6RmtAgokh0TWN0w0sA7cQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(2906002)(66946007)(8676002)(4326008)(66556008)(4744005)(66476007)(44832011)(6486002)(5660300002)(33716001)(508600001)(8936002)(54906003)(38100700002)(38350700002)(110136005)(186003)(6506007)(86362001)(6666004)(52116002)(9686003)(316002)(83380400001)(26005)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FsKjkZHHZ61f/yDTWW7hMYbdL6dzj+mAdFZTuN0SljCwao5tsYeBJA/LJ9R?=
 =?us-ascii?Q?ojdsauVTQGqS/V96K9moXTC6mb8a2NVyBdvIT7it5XxGqlCsp1GQyoM7gs7Z?=
 =?us-ascii?Q?6xQiJlHAWxFmNgqHpzVUybBL9Q6OKG53tobbxYGNnYCoMVGjOeSAEOMWlu26?=
 =?us-ascii?Q?FC3uz6DLZ5Tlxc4YT0RSrOdzvy0VtEiV0emIgLAKKHF7eskTgXXfMnb7aW/V?=
 =?us-ascii?Q?m7k36C7YcW/Y5Tx/7N2dlrh8b4qDPFASjUxKmATt6tmcly7p1BdlIPHs3KxA?=
 =?us-ascii?Q?G4ueVU/hfBAWkweDaEiDRjNEecJ80aYZaWrIrQxtJZU9abX/72BFeFTE72lp?=
 =?us-ascii?Q?x4a8WrNfJfRsCX2TNaU0JiWNhdgG8eaa18W5m0TnAkbG2l35mQTkE1Dqq2GQ?=
 =?us-ascii?Q?bJZS3gpR48ZrodAaNalyXsysV4RgxuAfLKwZDHKM4JJWY8jBvH4ZOvgVJ/Mn?=
 =?us-ascii?Q?gl0b3ByXvvSF63kOYY7s/C7Ty6KeSQxsbLIgwvDqfYwFZk5NrP0VrVduiEY4?=
 =?us-ascii?Q?fEikP2eK720Sbg0UQJmG1ddkr9KA7Y+I++0SuSieDRArqhSyrROQIAPWmJkU?=
 =?us-ascii?Q?ZVMd1A510NHXcmrZvXn0sGOPKhZr4/fKd0kcgqLD1rNTSDOvyn/G+jSWdyIk?=
 =?us-ascii?Q?oJXhA/XgYVuXzSr3jk3IqwFIY6pkyRsgoDL2pO9YZPrH1eEQAikcs6e5sR60?=
 =?us-ascii?Q?XCokRCIq5oAggVCQdB8E2GZwPIxZpvzooPx2C/wdXR7tuO7LRom41zgEvBql?=
 =?us-ascii?Q?aK6hhVKc5Bs+tTGEDz+OUC7c/cLuJBkWWVbXic1o8LTs0CfDOLUfEGtSq7vq?=
 =?us-ascii?Q?/nsMlZkMzYsd03vyJXXMexlha5OqXvauM6v7GZX2JU/2iGCPDtNwKqfMrNau?=
 =?us-ascii?Q?kRmEgrj2jo6Jry+UuZru4vMMh5uM7F6dz9PdVGXDb+zS5EAQ7sKxqY9tErvW?=
 =?us-ascii?Q?woPAQmKKMIbVfSidvKXDBACc+ZoQ5swNNem3Z8b0+hseRYzN+DT7ty8xW1G7?=
 =?us-ascii?Q?j13du368pmOi3s5yM8EIO7t6EL3AcvZdIesPyqOqwWYDjet4lS27Ac10Kecd?=
 =?us-ascii?Q?EEi6DGp1YbB8xIFrewpYPMa73ZLQblyJgIj7yF/DvnTN7mB0vEmy1bGnYpDW?=
 =?us-ascii?Q?gzP6aL99TgVXzWJS7IVVU7BzNUIPqtuktSPBeANY2Kca9QvL6OpYn9Riiwru?=
 =?us-ascii?Q?TtNwkTG7VPYbjgo7RAVBIj0jBWgouu9h/s3tlIhdTznLpO7zhkcIb6ezrmBT?=
 =?us-ascii?Q?vn6pXKwpX4LOTEmRFaO2OsiUpwftRQjb8l+zp3P7J3QCt7lznI2wf0TVpbPg?=
 =?us-ascii?Q?HA+oWrwMZPA7FuxC+TSYzccuKybzCtib4o0I2WwUeM39/PO0E6a4qKwBIN/F?=
 =?us-ascii?Q?tIPivCG6BiM0/tce6ytMwzO2FGoMmSFnObiwkszYrX1y2kyjavpuEMN2IUgD?=
 =?us-ascii?Q?8DLLCMXiBufwveTRJ4cXA9vn0KY9YjLh/r9Xqepx42ETcW3JIXSbKpK7VDy0?=
 =?us-ascii?Q?4p1YQGeAqTKGk3EaTatA7dgJhq+gCNTsaArC0F3i7IfcBkDXz8jPDFdKqa6G?=
 =?us-ascii?Q?uAD9FO9aCODiJpIlKkgLAP64CCwqrnVkJlpD4+N6Lzrcmc0rh/aK+GYQDkJO?=
 =?us-ascii?Q?aKXT0ibkU3SLAqsTW5/G2c3uPRT5m/tE3mQAJ05cdWp2+th+jJD7aHEOF3rE?=
 =?us-ascii?Q?pcqO/RGHyi9rIsNQuDtypKAM5rgaz0mkhIxkf3bVU6nKGbpl7EQdkK8KV4ql?=
 =?us-ascii?Q?uBNd6Z6/psyi93Yv4QpfsU5IbvycRBY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b0197c-3cab-4c75-9692-08da3c9695f4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 08:31:08.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clRKg6NNM+VJAEPaYXa/hqrXIYv1TcV1RU5PzQL0XrP39ipXklpiMqSqdD8MwxVwiA9giXIZ3tY4egxjigNtNkEx7bwG1w4twYALhzzVNmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1781
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-23_02:2022-05-20,
 2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230044
X-Proofpoint-GUID: pGL7lTeEiiBiA2LMJ130mAI7JWTP-Ypf
X-Proofpoint-ORIG-GUID: pGL7lTeEiiBiA2LMJ130mAI7JWTP-Ypf
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

The > comparison needs to be >= to prevent an out of bounds access
of the vdpasim->iommu[] array.  The vdpasim->iommu[] is allocated in
vdpasim_create() and it has vdpasim->dev_attr.nas elements.

Fixes: 87e5afeac247 ("vdpasim: control virtqueue support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 50d721072beb..0f2865899647 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -567,7 +567,7 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
 	if (group > vdpasim->dev_attr.ngroups)
 		return -EINVAL;
 
-	if (asid > vdpasim->dev_attr.nas)
+	if (asid >= vdpasim->dev_attr.nas)
 		return -EINVAL;
 
 	iommu = &vdpasim->iommu[asid];
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
