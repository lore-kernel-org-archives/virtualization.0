Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB06BC433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D1028484B;
	Fri, 27 May 2022 07:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CdDFyjv0Fm-G; Fri, 27 May 2022 07:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 188D18484A;
	Fri, 27 May 2022 07:37:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAD2AC0039;
	Fri, 27 May 2022 07:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60636C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E035414C9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Nq4ktX0V";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="S5gEQqBN"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pJ5Rru_aNyt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 133134148A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:37:40 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R60vrQ023343;
 Fri, 27 May 2022 07:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zji0AOhy4rGU97O1hui5VknzY/33Sg/XuHkwP9yLdpk=;
 b=Nq4ktX0VFLgT68244q6Xvq7WV+6qt5z0PagRb/xTHuplJK+OeamRvoTEO6MHzMVqED2f
 m52RoH7+Rg2WEuNlbAyoISaGzlBQ/iFt+vABwjMbWz8kThJJatzYisFs/NCMSIVFwduR
 JX28e+Ksi6nhaq7JE4fIpKSnaDXV071FPGiAtK9b4eUZDfRENBdOCj3MKZIiCoSqPDtE
 fiHeaLnYGZhNf1NMkG6gIKOadT8TunHS2bHuiKdmpfYmXp1zbp1FphGBSCEV/g7TEsPl
 VbmTxTFd+HiPTKjty9zs/gdYEmUasNjJQexwnNWnWDT7Z35SEe5EtMKIG3SldSA9XPWq 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tbeex2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 May 2022 07:37:27 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24R7a2iA039483; Fri, 27 May 2022 07:37:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g93x1gtw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 May 2022 07:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bn6VI24WF4C94kNYyliF1JONjTp9cB4Y5pZe2eV23JW5Odf2aPiZVlDXSoeLPCNhA4ppdU47q385JwrqofMTsytNP9H8oVT4Rmn/EC3sJHIkUvwJ2y7VQNKHyjEnD/Cz0SGEa8Yj9r+E8/liNO3mP8MbkLdEEutNHfJhmD34Vcmc+aIgUcquKEepfeFbqWTTwFz/nOoZmHm89qFme/Bx9ZI5PiF+R7jYMDRlwaw+BALWYOFgkTsc4qjrvNesPgn8DlPXUBPFt87DtiaIw4oqd2bqzsnFFOb7QlGcBbbwGIOVQt+TmQNCTXGpHfwydqQGy59jepWGqg5axJSsKDGVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zji0AOhy4rGU97O1hui5VknzY/33Sg/XuHkwP9yLdpk=;
 b=lyOROXOX6XqAjChc8IZ7tx0m6LEw6/0b8wC1N4eAMBwTN47UDWLDSVNjJohCePki6V0h2Pkrkg9GvMd/KoBTWApWd17iuv1tKE8wZrS0UCyvYmgiNrcs3w0HaUgtKdbDZlEoa9KREpvsqxkWx1lY9k2mLgynHNiqUjilmJ4tE5pcCDeqWLGa25LPaFUwRR0mZNhsQT8kKnkSdDYSwUmMrt+hoUvkG2TJBRevJ8os+uKGGcZtShx3H996vnsYKXdlSDgpJ0Zsc/C0Y5MDviIz5WX3j1HMDgJ5y1HxvPpJOkzPTWZVvYsmM0ZY3y7Q910VJGlXaPDOdT1No6yIdXOxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zji0AOhy4rGU97O1hui5VknzY/33Sg/XuHkwP9yLdpk=;
 b=S5gEQqBN7zDOd2w9OewixX/ojN5k1l+Z+AdAQzBGdjchYwWUYO5G3vNDj3rAfuHriZvm38SzAgMZB2cL7pO6hktiOvhboikIZLNUl0Bk/qFfcvipf6AomNYsS9Z93F13l4OSXGvg+h5AWj4bW4KCszs5Z3dT+lsFnsuADJ9Uk+U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5257.namprd10.prod.outlook.com
 (2603:10b6:610:df::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:37:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 07:37:25 +0000
Date: Fri, 27 May 2022 10:36:55 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v3 2/4] vhost-vdpa: introduce STOP backend feature bit
Message-ID: <20220527073654.GM2168@kadam>
References: <20220525105922.2413991-1-eperezma@redhat.com>
 <20220525105922.2413991-3-eperezma@redhat.com>
 <BL1PR12MB582520CC9CE024149141327499D69@BL1PR12MB5825.namprd12.prod.outlook.com>
 <CAJaqyWc9_ErCg4whLKrjNyP5z2DZno-LJm7PN=-9uk7PUT4fJw@mail.gmail.com>
 <20220526090706.maf645wayelb7mcp@sgarzare-redhat>
 <CAJaqyWf7PumZXy1g3PbbTNCdn3u1XH3XQF73tw2w8Py5yLkSAg@mail.gmail.com>
 <20220526132038.GF2168@kadam>
 <CAJaqyWe4311B6SK997eijEJyhwnAxkBUGJ_0iuDNd=wZSt0DmQ@mail.gmail.com>
 <20220526190630.GJ2168@kadam>
 <CAJaqyWdfWgC-uthR0aCjitCrBf=ca=Ee1oAB=JumffK=eSLgng@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAJaqyWdfWgC-uthR0aCjitCrBf=ca=Ee1oAB=JumffK=eSLgng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0057.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37b11589-85bb-462d-74fe-08da3fb3be44
X-MS-TrafficTypeDiagnostic: CH0PR10MB5257:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5257B1F3269656D78CF94EEA8ED89@CH0PR10MB5257.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mLCiadmS/OkKfKOQD7hpmoYeDTYnADQ4fODjMBLh3oFLzHHe6GCLJ0BNjXZw3RuFw7SKEXCLBBMwR/+E3LKHT3VD+d/cmbtn1w4VdpS5+7mb085g+PFCgm0rpqRQnwuwBwnZQDdnnEHLBV8EYrBFSZsOYn6Vgn9Yupx5eF6xSKa2se93kdr8V+MV+KePt9gvRByTD5kU/odgn9OBQPImVjJtg2MFiudW85It7H+f58CorGzn5x/7xm+ZAQHWs4OgtpFepEjWUUprpBcestGxDnKqTsYmlw32xnM6pas6iV9LWoNQRsHsBR14Q3QuYXw9srPTJfpgIyhU2sdFXrrCmaziM5Ir9oDeY1tBOm79RUc6/dQGkZbL0TdCu0HUZ8kKtZ4wPEl8popza442ZUrwg4WQ4JJUqvuJ5pwzLzID+3EReFse8rl74V9FpgF2cayXSrNBVl3i9VpYH1QFghzmakbT9BJs0IVwfs0bLqPEl0rt/052OmuFAMVtscnkwDmE+4uB6heA5X164zi0zPs1NSySmAb6RyfP+UL+DUhnpp6RtS/U/yGrIRpPusZRpE5g13eAK99VFE1YfNMvA6bUAZus4nbTnOFu3ycBCjPnNrBu+7et/NSxk1mDRk3jRwcH9X0bLmCaZLPiLO7qc4C3fdXTATN+mbhtTYM+djRlEbmtsmQFNoKwA+Q7XxCtVM6I7XJ22VmAPyj7Iklde87dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(508600001)(33656002)(53546011)(6486002)(86362001)(6506007)(186003)(52116002)(38100700002)(2906002)(44832011)(5660300002)(38350700002)(1076003)(26005)(7416002)(6666004)(6512007)(9686003)(83380400001)(8936002)(316002)(4326008)(8676002)(66556008)(66946007)(66476007)(6916009)(33716001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmhiIiYeWK0ceLp3fpPEzWxsp6D4JCgYWRsoCvyI8fPtLuHMKX/ViDy4SC3a?=
 =?us-ascii?Q?eV4+Z63sW4TGM2j2MIPwLYZ+0AklHRQbZkJyGffJlJEdcvBoZXnAAIsriAuM?=
 =?us-ascii?Q?95p+tfNeMTOtCCXg/f/ZXgpyU2my78J9GqAsoXluVUe+vM6xi1PlyLVFK1zf?=
 =?us-ascii?Q?qg+oud0zNGuBWc5WkayzoTXOfoo4Wg4FVocnQKt103QHdLlcMmL4O0B389kl?=
 =?us-ascii?Q?3GAn6gisqRF50+qez3hcfYd5YeEVdi12kflTa5qSaXlyJj83wkPOArn0sz3J?=
 =?us-ascii?Q?Ln7EWad5QOU56/UpngXJVJ+MHTh9RIYPz6dKKQSNFj3JybWkYb8xl780lU51?=
 =?us-ascii?Q?wce0VV9IMqq3mmyYOmYU9vKDFYsYIQCV3A0FEX9pyfkE/pCoejGO36j8LcRA?=
 =?us-ascii?Q?nJP5eTA6oNzcY0vazNuT26Q7/GTgllcuR0TdU7NUAXKH0OxMUaavGQt1ghjw?=
 =?us-ascii?Q?iBR+Mi+EdXEeAhSOjHXPH9v7fSrLXL9fcO0ghHj7BY60XYkARog3WZe7EhU9?=
 =?us-ascii?Q?cP9kvgr7jZRcCbaJMu40HMfGlL5mEYEdoWXKz6B5TN8qKTwaGZnWpo9o4rIt?=
 =?us-ascii?Q?XeHj8OUgQuh829bhq2cEsQbNFiQTAjF47r21q3VLR8fwzoPdL0vRGM7TeADP?=
 =?us-ascii?Q?EGvuxv8LV1LJTovkJZ5SNpnhTNhBCPLOgrQY8oHjpsvnc56Xu9nRkl6dDmP6?=
 =?us-ascii?Q?21jhgkDE+IAji4pxO/TpHIio7YDO6l6wlSxY7K6JBDEqyHcGy/f9rDtslneB?=
 =?us-ascii?Q?WcHc1ukglXxyDMukVX3VtUSnEPiebXBWu+wMYYS9RtCaeyhn56O7IEeTACOl?=
 =?us-ascii?Q?K18oaOLf3EyWaIZBKW9jQbxwO4/I0Y9q64jcnZLO1+dn2wujADVLyRk7Kygv?=
 =?us-ascii?Q?ZUCQiuCzYDveN3/kkTCjXlzKYVYqluMO7KiL9NEsqGhAh09Uky8hEQAofDUm?=
 =?us-ascii?Q?BIzEVXIucmqMhkJv7uJ3A974CpSLIBQcPkt954BOR+5mL21h2hJMWVElS3pd?=
 =?us-ascii?Q?cjo8OR8PZIQAjrTTIUfvUkiLpKVmrjrJISH2i4EJPjehsGyu816ZfIEtY9uy?=
 =?us-ascii?Q?H9ArhCINJ1g7HSo7dFbVPFFOEUWldh5raTZ1VEru4GEa3X4KO8UxF4ixwmzJ?=
 =?us-ascii?Q?jFMmVGR5GMzwEoSHEPc2cOsUoZW0oumkcDMQjSt4zneIjaCDCjIA/bt8ZOk0?=
 =?us-ascii?Q?WOoxakO8+gctdb5c7HTdwHYthQyRfFwoKjMD3mIiqrVbVPiup9sa1Pq+eXpA?=
 =?us-ascii?Q?f40YxP3RyiXqhAHo+nZ3ySKfWw9z1RxgSZWHU9PL7vRCAnqZ5qmguXVQ2Xnr?=
 =?us-ascii?Q?0qYZv5YQ9dcgD52UtgjQ/rYkRcOZXRvBRPxZg2mVhfJ/IVN6HYmRpS9GvvO3?=
 =?us-ascii?Q?vDkk8rvNIgv/dYZRQwPrCGAU/GuTQbg07KDPgbuJKKH+YPhcwgbovBxRLDO5?=
 =?us-ascii?Q?YQLgfHU4YtMZ1gnHe3UVe/3NRSTWwHDQnUpiZQr7xJ0w5P2SbjI+i4N2Pji1?=
 =?us-ascii?Q?RoSqlKfhazkdd6Q1xz3SYzDgjhRHzROhTWrVHa2dFMhne7p/d6DUMWSQAFEQ?=
 =?us-ascii?Q?IOAzIcmLq9vashVBr1rnZVSSdqi+FU2PMda+kerfwO1UWOXGyXyH9VUlqZb0?=
 =?us-ascii?Q?rqyiLRFWVo82TUgazjVRznoM82eJwmqcteY2Ky2gRx7iQtexeO2ZsserM+9Q?=
 =?us-ascii?Q?q2BAITTj3vAHX7f1FvhRoVwgvGYg4tOwfilozyZO/q9Vf85cClNnpf4gDxO1?=
 =?us-ascii?Q?6WvV/CaFeQNc4afuxxNnigjgaElxZAE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b11589-85bb-462d-74fe-08da3fb3be44
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:37:25.2387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrQDI716L5CVwrFqG9HRdSf12K0UcTeKyr4YuAWHFHoLygwJEP2IdNKZsMcOdtUVQOghImwuOTRX40q+uOBFy06OUmR0K+yzxq0bTDUJAC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5257
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-27_02:2022-05-25,
 2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270037
X-Proofpoint-GUID: qMVQANjfSk5cMv_82jJE4PkXdHKLEP70
X-Proofpoint-ORIG-GUID: qMVQANjfSk5cMv_82jJE4PkXdHKLEP70
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Dawar,
 Gautam" <gautam.dawar@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Fri, May 27, 2022 at 08:50:16AM +0200, Eugenio Perez Martin wrote:
> On Thu, May 26, 2022 at 9:07 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, May 26, 2022 at 07:00:06PM +0200, Eugenio Perez Martin wrote:
> > > > It feels like returning any literal that isn't 1 or 0 should trigger a
> > > > warning...  I've written that and will check it out tonight.
> > > >
> > >
> > > I'm not sure this should be so strict, or "literal" does not include pointers?
> > >
> >
> > What I mean in exact terms, is that if you're returning a known value
> > and the function returns bool then the known value should be 0 or 1.
> > Don't "return 3;".  This new warning will complain if you return a known
> > pointer as in "return &a;".  It won't complain if you return an
> > unknown pointer "return p;".
> >
> 
> Ok, thanks for the clarification.
> 
> > > As an experiment, can Smatch be used to count how many times a
> > > returned pointer is converted to int / bool before returning vs not
> > > converted?
> >
> > I'm not super excited to write that code...  :/
> >
> 
> Sure, I understand. I meant if it was possible or if that is too far
> beyond its scope.

To be honest, I misread what you were asking.  GCC won't let you return
a pointer with an implied cast to int.  It has to be explicit.  So there
are zero of those.  It's not hard to look for pointers with an implied
cast to bool.

static void match_pointer(struct expression *ret_value)
{
        struct symbol *type;
        char *name;

        type = cur_func_return_type();
        if (!type || sval_type_max(type).value != 1)
                return;

        if (!is_pointer(ret_value))
                return;

        name = expr_to_str(ret_value);
        sm_msg("'%s' return pointer cast to bool", name);
        free_string(name);
}

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
