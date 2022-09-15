Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8644BC6FA82
	for <virtualization@archiver.kernel.org>; Thu, 15 Sep 2022 11:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0142940157;
	Thu, 15 Sep 2022 11:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0142940157
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ZWx86yqi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=IrtLG+BL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HuYkazQP65C6; Thu, 15 Sep 2022 11:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A141400DD;
	Thu, 15 Sep 2022 11:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A141400DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27E63C0032;
	Thu, 15 Sep 2022 11:14:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78891C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 11:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FA6E60F2C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 11:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FA6E60F2C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ZWx86yqi; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=IrtLG+BL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2cEsZAoleA5n
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 11:14:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9802360B78
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9802360B78
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 11:14:28 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F8sdNV014976;
 Thu, 15 Sep 2022 11:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=f0KHYX05aJTB5y37dqutczVknMalsLPD6rfDrT5h+mE=;
 b=ZWx86yqiaL5g1pmSmJI9q3ght24u82V9cLEMYfMFkYrz8Tkiznz/XKlqAn2myqHK8HRp
 lAueqaeQGwvqcrcYhxn2N35I9KVe/qly+fbvngQWh5rEL5F5YUlyRWFrTNzd2KthmvJk
 jvRirJ4sjbJGxGjFFhfu1AYb7hrZZeItjrRg3oHnWu2AsGzQelr34gXVNgRqgSkMxZUa
 tpbEObSHAFIKEg+438Uu0lzGLNEv5kJO+45A34RsYqkI88zsn4of/3T7aqC5CIPWapKV
 2gBK8YmBgouIY9xyqst/SOVK50hZWk2X4UemQ1gmwR9XvVErOx95esWAuFAt19w+X+E4 ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr53kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Sep 2022 11:14:24 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 28FBA1mI014549; Thu, 15 Sep 2022 11:14:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3jjym10wwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Sep 2022 11:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhzqmzaWQYPqLnRlJp0/e7w6gjN8vnEJWWFfR0Nhrp+ksCD2ycd4YKIOLi72J5cynVfOXFUKh3vJvYVTgnpf0aUOdOsqFvctydzwHGj08eY5g8YoJY0zq6yPK5qHhDnYXB8Vt9YC5AXdQnPbaWhZlt+QGtGj3BrGKkAuiylrVNTg7T3Kibr+LPcdtS2JX3RnxAQoW5Q496c/2efkrRAkGrbbd8rwNZn2NHbdFxme14LV0NGx5KbiUWz4Giyr/6n9K1wJjCOvoK4vkPVyn9OFgH/kVHCtPpetacZPwyvQgE0Tl7HYzftbR4eqMHhlry8H6zwYdITr3sl6LGd1bF7w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0KHYX05aJTB5y37dqutczVknMalsLPD6rfDrT5h+mE=;
 b=YuuyOsEZs6eIr2S/o8iablReMjVq9M4Wpju23U5tRy7HgezvfqDlsNmdSbXveZy7YesGHs5n/GIHzHsxwfrCfRW+HYAd/oQhdgTmBpnR+zMVKtjBcKdeD7JndS2V8nt8Hi/FexpvDzLId2gHHt/skFMt4tGE/eEKuCsS+P4CYK0AU9MzwLPhaNA1QeC96KNSjZLS5q6JD7DFmd4EwQDN4yrB9mMBuGWhDy5z9V8uijuOakpFmgbfDQA+abWkjs2xC0ocCc1preDKZnZEBBfJS3ntsgq7rxZkJYRN9yvP7598gzutOh/gJJ0a1fs6UoqdqDXlHLkSdvJGEGECnQrk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0KHYX05aJTB5y37dqutczVknMalsLPD6rfDrT5h+mE=;
 b=IrtLG+BLRKz27hqqaFqq5JukvFQYg9fGlVbtsnoqnkNGwWgMZGRz2gxEdW7fpKepX3FfUmcK/n9whaJKyvkMwCNhdM2hWQfjDv+PfqdbpUtuXCpZtdyIvWB7icr0NSHr6Fk2LNCiXDPNuArWZ9YK5XfdJkrjYqsfngUsBVw5oq4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4439.namprd10.prod.outlook.com
 (2603:10b6:510:41::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 15 Sep
 2022 11:14:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 11:14:21 +0000
Date: Thu, 15 Sep 2022 14:14:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: David Airlie <airlied@linux.ie>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Subject: [PATCH] virtio-gpu: fix shift wrapping bug in
 virtio_gpu_fence_event_create()
Message-ID: <YyMJBkId0c1lvrrO@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: LO6P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a9fc6f-8763-4da3-b3f2-08da970b7071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XB4be7m9ZKW8Zjup3t8dTHqYEEPc6PwxbOU2eFgQ7WsoxF8SKnIUGuk2+jJi0LoRp1VO/18K2q+t9xOIaP4nY2qrt3oscKK0Vw76o+aJti1dR3tmk4ZQ0Kit6jCAZPX4vk30eGgZ1UPlq4V7tA2I2q2Dxfi/ObcNl5ILjmAHN0NBPGnbJiNOZcZ6KyUiQ2zdMWiLkJbx2qV5elhzk7Cx6PTIZVXXbwbLPFDCTMjc9SVnIKzyQGEr+gJgw/BYsswDpJonf8tpAkdda7irXXIs/X6PmRfqMSsmBDb2Qkju45tV8oNumhKzT7/oR68zuaw4HAL9qPoXbrUKfQSwIDB3oddCfpLdkNB7oRsNGfmGLvkCINyqouUvL83v/V35/ULKzsx8V3Wwm+Duagd/zbbhmiqwqmwB2iOIkShUziXByHQctgg/4KyglzGfDV0USrwKgqMHU7cs19mssMiFoEU2Hoo5Vdfw7odWqtC+KGXS1QCj3iyZPM2gwVm2a6dndT7n/TflDwoONWxWTWKjwCjnSxcrrhrjaVNS3IZY0gft0FUGCE7GVIg2HnV5LuAkTdUMCieVyB6B82Esj2nQM3qOio130+CUoQR8KfMgDASRSsfKU1bU/wMW9ZPkBae2JCR2iGQEndbWgPiPmMiL3eGHddDvTsS1QBRt3Cu9QU20OL8pCITFbF+B2+F4iWhOhGOAXgL2+TCh/Id2kOhkgQY6iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(6506007)(316002)(54906003)(41300700001)(66476007)(6512007)(33716001)(9686003)(44832011)(4326008)(8936002)(6486002)(478600001)(66556008)(186003)(6666004)(66946007)(2906002)(110136005)(5660300002)(86362001)(26005)(4744005)(38100700002)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5c6PRB6ljJ5LPgNldzaCzR1FU12yyLA2jR+ufk4YDdoTDAoLlf6JMcjwXJ43?=
 =?us-ascii?Q?YeQQGgrS5Kir3s9I9OHh7XJWn6KlKCJCYdW5ijYH+1jFvZyvsJTNF6+GEIAL?=
 =?us-ascii?Q?9qtcR5cJlG7M3vzRSTQCaYDnnpRtc577rUG/gcAs3LpYkCVBrv1zCdDivNvf?=
 =?us-ascii?Q?fglfU4yK9Fq+w1iutnN8ZROv9BYB03MWNsVQkI7mhIjR+HcCvmkeCx5r7ay1?=
 =?us-ascii?Q?Nk4ZCMBh3Mwy2+h7pEaDC3gegV/J0MXkw2/bfzCurp6V84TyDq1wNGImEjzu?=
 =?us-ascii?Q?hENJdOz2WKq7b1o0HZBagwBREywUqJXdA0Wn+8ehkCfK7paXjcN7X02xL4PO?=
 =?us-ascii?Q?Er8s+vwejpO/lgahyUpyBfeYAPOmxU61mV1D9rSo9NgPs0qqeiCFoVUOfF2u?=
 =?us-ascii?Q?76vP+VrlRTnPySvoGGQqloQawqKqRxDsDo/E7W0ZY6I9C2x9s1trvQ2YmiLS?=
 =?us-ascii?Q?pleNyC20JXpooUniWd5Xb+hma0yCd4hsZqAOKRWu6hbrp9D4OIxIP/FgryoG?=
 =?us-ascii?Q?ruJrrzEQw9NSre26E6uqbwgCvUGCsfRGMjx/yzTass0vm0Bxsd/80U4rGBqd?=
 =?us-ascii?Q?aByFfubUjs0SFdMX9sQdv+pwG/JokOV4kXL1DaEqOpDhJ1jBzBwMG9ql0lt/?=
 =?us-ascii?Q?3PHpoQnxK05zhy3zRfp4tyEvS5fdd9HDPbf5XR3FxOPE5cFN6eHmokYfdqIU?=
 =?us-ascii?Q?HWIStQThVl9J5Wa/Lipds6bBr5SiroknzJx6Th+cFq9QES1VM4Vt+DqwlhFK?=
 =?us-ascii?Q?obsWwFzGYVNssCOkWcJHv0RFoBgf6dtpgx687cu9UeWwBK8VZpXwZCm33znJ?=
 =?us-ascii?Q?RK3vzGU2Of7BU2kE3hoAjHF31OKwp8Wvs2LG/Np/UJaBQgqvxHDTUrQyNkVy?=
 =?us-ascii?Q?LaQGXc3kjlAjxSD5fpSGScEhg5u2p8Hqv/aiAx07Do7GMx8lnyPkn8ifyMyc?=
 =?us-ascii?Q?3olE5DPZt9bfq1nhdYZvtUoNntAU5WZu9PTNzQktvHyILRRAZK/4Nnnuedn2?=
 =?us-ascii?Q?TirZhj1IHaZmCnVwDMjR5eKyt7Zcj6gMi6e3nj+myaTMDQSiWfo4BDBk4ko7?=
 =?us-ascii?Q?MyehYGPqkzt67XE//gPOMi9hx3P7MlaoS3Bc0yijuuq1DsIJMOnuaHLU6qXi?=
 =?us-ascii?Q?YJ0xuS30wiAC0tn3QzIWbbwKNBPyY7IOXSSjAVl1UrM6VYBLiibzQjo3EcMM?=
 =?us-ascii?Q?/BcsGEfVTM2o4qXNyjAr9ESyFaxb2Tw3JVsDeZ/jV7V3RQVgDD6jB4ueBA2p?=
 =?us-ascii?Q?E8rFma4+abWPlgQGfvMK5itFET+rRpKaVEqWE8Br1GqxNF6lQBjSc1Us6Bw5?=
 =?us-ascii?Q?tLVEmoWCmMtNv60sEDGJ7mbfkimbFr/PApXbOrjanyEJ7FMDe1UOwk4Lqvbh?=
 =?us-ascii?Q?ZiD2TPEB1AOYRBk8hWxm4KZoXGm6I0C0VZ1H4GGc7DFSUEmaEJVoThlzKZi+?=
 =?us-ascii?Q?h/PegfxiYjPl2M44+2yScRA5h9q3gYTtmsMzbJhZqIzHFF1Acwigpd+WwXgg?=
 =?us-ascii?Q?jiXcdjzG5/EJdSRn4HesGbwRVBICCt4sbOYmxbjY9yNga3lLRorKDbDc3wo7?=
 =?us-ascii?Q?ZBCI9Mu2kYhh4EKrJPFI/D8wAf1/D8swP+2GAuJ1LzjoXayc8bC6wosoqk8J?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a9fc6f-8763-4da3-b3f2-08da970b7071
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 11:14:21.4530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6IdGRaulJnMQ92dBPhKx8kqDKYnsgbpQWCdAJ2m7EpXESpVpkTcgOQZ5Y2dboAP227Lecg0wd/b7iYUmNO3Uljcm3qu1jv9DFBNK88Cbt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150062
X-Proofpoint-GUID: znpUdF0-IzAkq_w9ZHiQw-yYL7mz1W_-
X-Proofpoint-ORIG-GUID: znpUdF0-IzAkq_w9ZHiQw-yYL7mz1W_-
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>
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

The ->ring_idx_mask variable is a u64 so static checkers, Smatch in
this case, complain if the BIT() is not also a u64.

drivers/gpu/drm/virtio/virtgpu_ioctl.c:50 virtio_gpu_fence_event_create()
warn: should '(1 << ring_idx)' be a 64 bit type?

Fixes: cd7f5ca33585 ("drm/virtio: implement context init: add virtio_gpu_fence_event")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3b1701607aae..14eedb75f8a8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -47,7 +47,7 @@ static int virtio_gpu_fence_event_create(struct drm_device *dev,
 	struct virtio_gpu_fence_event *e = NULL;
 	int ret;
 
-	if (!(vfpriv->ring_idx_mask & (1 << ring_idx)))
+	if (!(vfpriv->ring_idx_mask & (1ULL << ring_idx)))
 		return 0;
 
 	e = kzalloc(sizeof(*e), GFP_KERNEL);
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
