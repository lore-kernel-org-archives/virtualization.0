Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1780CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 19:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7B1E416D0;
	Thu, 26 May 2022 19:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KLgdg1wWFOfX; Thu, 26 May 2022 19:07:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BDB4415E4;
	Thu, 26 May 2022 19:07:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A80AC0039;
	Thu, 26 May 2022 19:07:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E660FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 19:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9B07614FA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 19:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="O7QgI4LY";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="URoocOD6"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M8pJBsutld9v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 19:07:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D07E61492
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 19:07:02 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QHMpTP013206;
 Thu, 26 May 2022 19:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aZbr2/SKig1qq8wfFYACdrO7dNZw5Kwx4Qk/0WiuV0Y=;
 b=O7QgI4LYjpRqjjOi0KP8ZCxEcfpUVIMVHAq+hDhCPDU+eDAmhiatdsv8NHwlZ/p5gXOY
 LgeVr7nqD+ORkXITL8wQK6z6wDJ6J3H3jnPU2s8psz43FISbqivhAoWaq05de2KdbTuS
 YZUzRxvdKe2E4pXaC6+kkT1d2PXV1vzOyC2pho68qm4JZucjujxwCyqXsMCiqa+Ix2Bm
 4YD4+d6VImVEPKgbT94tjGpknRDkBZrnsAJMZi2LQqOFnHmw//sED0GYtDbz4tMFaari
 SQfYMZYsBzvgi2K3L5XfenQudokDeJWNpPE8buRPWXZrqjMWjGUUAsEvaKpLl80OX/qZ nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tdwh7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 May 2022 19:06:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24QJ01Rc027662; Thu, 26 May 2022 19:06:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g93x12bag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 May 2022 19:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa6V3InbwPt9isMkdDk2SdBpkjHGGDz/04h30rE8XsvNGJasQObL3ZEwgYfTRvJsnQtDT0lQ2kjeNiG7YXTcnMH5KKTba1Ucbt4ND6WWv/vhN3OGw41SY/FNqAtdXbrh+hYQuFVdtDeNafMa72VMzpkpxhl4kOW+STSsEcuER6B53dcAX9Fg+aYoED6WLxBuQQk1vTSIH9kR/o+AVCbG49at8BfLfp6sBtgpX5p+ff3YO+roRrW+JTgTa6ISS2lMu6oOuze7M1vMg1E/mMmfYvANRgxrjYeFymUMiRUR0pgl0lO4NnDhZGLgZCI6w/4Qyo3kkP/UuIfQFbSLzMpjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZbr2/SKig1qq8wfFYACdrO7dNZw5Kwx4Qk/0WiuV0Y=;
 b=XekQ7NpHKXTBX/CQpqMOfSas8Np71S2a4ZMdkSBMHot0YyLHDNMxk0mHq5n16HurGdSnxEQVska4pGkQBk1t5lxb2juFUW0+rj4jBnj+Nkh8HYcAlIriVcBPI83n/Re/zH2CmHc3lG0lM7hxCopiCZu9e42iCj9W/yIiIJHxq6glB5GcTxVIJ9ctajkWN7XvKgXVA0i78/ksq9QlkheXX1yIvjvR/sHM9NbaKjz8jRejnPZghJHJK7w4dCgmsT1l76Jws7Zd7/9kkSdSh4dtlY6QptbcGGAQcmvgO2tAyTkSJZ+Es978e1cCSdQRDkfMc2uiBAh0Z3SHXiZA6zbL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZbr2/SKig1qq8wfFYACdrO7dNZw5Kwx4Qk/0WiuV0Y=;
 b=URoocOD6Q31txTN14yjA55lgNHrPQvtnMlg/Oc9iDduxQu0slaOe6IRluQkng2ACZwWjTks2y2IVSABwbDPfQdVytzAZw3wYhInBfTDFsHNosYYCuCs0AOOGl6+Em0ssm7Y7Aj97EhxymHdAXokW0Lb6EdbYOzaJHcRUQK3ulfs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3413.namprd10.prod.outlook.com
 (2603:10b6:a03:150::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 19:06:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 19:06:47 +0000
Date: Thu, 26 May 2022 22:06:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v3 2/4] vhost-vdpa: introduce STOP backend feature bit
Message-ID: <20220526190630.GJ2168@kadam>
References: <20220525105922.2413991-1-eperezma@redhat.com>
 <20220525105922.2413991-3-eperezma@redhat.com>
 <BL1PR12MB582520CC9CE024149141327499D69@BL1PR12MB5825.namprd12.prod.outlook.com>
 <CAJaqyWc9_ErCg4whLKrjNyP5z2DZno-LJm7PN=-9uk7PUT4fJw@mail.gmail.com>
 <20220526090706.maf645wayelb7mcp@sgarzare-redhat>
 <CAJaqyWf7PumZXy1g3PbbTNCdn3u1XH3XQF73tw2w8Py5yLkSAg@mail.gmail.com>
 <20220526132038.GF2168@kadam>
 <CAJaqyWe4311B6SK997eijEJyhwnAxkBUGJ_0iuDNd=wZSt0DmQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAJaqyWe4311B6SK997eijEJyhwnAxkBUGJ_0iuDNd=wZSt0DmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff934427-5ba4-4b13-c402-08da3f4ae19b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3413:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB34132BE0151F0EADBBB6D70C8ED99@BYAPR10MB3413.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArWKyKT+HVnJFbT/vb1yRv4FupOT9VRPUSQYsyk7FI66mnvIuTTggwzocvO9C+xztnbv0NAZc3EW6vCvBj0vxqh3iy2G4GjH9UAgt9eO6L04zALn9FqY9gGfAmc2krgGF1MaLPnzT9Jh5W3uwIlNEgOj7mYA2puWZkMVxjfPgufTqfWraR9F7KDru8svHVezz6V9RRtPz7SLToNWen9WyMBgWMrbhSpEjV15pZc+Nx2MhYBAnIzDVAXElH8BLoSNeFqpvoGsfo20VPp2axOWrYyPUWu1lZn/hgxC5Ex+x5yL8MVgEMkAS+UHnB14Svc1KLR1K1wgQq9NuUV+XNBWGmqx8WA1Ki6UpmnKROc9mTzsuQsvXnTn5OtiuTJENT2yDLIJ9XuyeQ/oG0W2+t2swMPeQoMZ9fD4UlYdyCOmCVsPVOZNF0dwvtOEZDQ4GBVZv7D3hTI4061IEKuertU8eOPxoFBm5IxkFPEvmL+nvG0ZZXkiUkzWg6eWNWRRxHv5uQObkSd9BDKPWj8Rl/nAMmpKZkvDBc09fc+QHgUEeYE9gHDrimgOMg8QiixkYNbbJ9FFnGkEWd0zkhRl8Uz8Oi7Km3gvk6Sx7fPEDax7VfNGnzEtJDwTimaJnwjXqbkgmzmw+r7T/LOrCs5xTcn9tWv2u/Rnwdv1tfH2n4+DTmiiam1zg2vFrRkSxYV7o56+5BsXTmlzgQpMKB3EvSMmqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(38350700002)(6666004)(66556008)(6506007)(66476007)(38100700002)(52116002)(8936002)(6486002)(7416002)(44832011)(86362001)(2906002)(5660300002)(33656002)(508600001)(33716001)(54906003)(83380400001)(6916009)(8676002)(316002)(1076003)(6512007)(26005)(9686003)(4326008)(186003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMPPplp/Bt3i9CSZA69jD79qjyi4n6nlYCEhBtdnucXPvqJrRpArimAfZUbb?=
 =?us-ascii?Q?62K8A628fcmF9qqs7s0iVegH+e8cPdm9AWcFulQVk07G2V1mL4fCNn2+uwIS?=
 =?us-ascii?Q?lDRErg8WiwRWnxCupcHR3LB8O44VpV3iAQJVpziycDb3KccNrKB2MKhrU1bk?=
 =?us-ascii?Q?PaoHCsvPe7om3MaJzHmMK1+JuOYcFXmq0SGjYb8FIf5509TvA+O60vQJ15rY?=
 =?us-ascii?Q?3ZhseM+CK8+H6/nmemjm70Xd7NG36NXovdr9w4G/0OBY44NBCbzVb924PRjL?=
 =?us-ascii?Q?vWrr7t/hW/JkxL3JSt1phO9FnvfBAN1RBUHYWurkSNXbWdGz3krqqpQYO+vg?=
 =?us-ascii?Q?nU4wU+OSX33zyJ4hQu9DyVSldJF/58aKfbCA8QNlrDylmVKtS+k9iAi7mRf3?=
 =?us-ascii?Q?FlcHLzgt9qZw/Lnk4me65ET7f1Do+gOzrJaEcDEPqcIVZWNmKYCk/iRdLTvW?=
 =?us-ascii?Q?5q0FpZdWOTLckMbx4OkPcKgo+Rj6/ib4hm4Yq70S0d0hDh8wivHSP+0/uz+l?=
 =?us-ascii?Q?mkW1S5x23z93yQQbBQ/7lFpanNFKmFhTZ11/eDBEwPfAwfG+rukpfzs+aBoU?=
 =?us-ascii?Q?V9yjwXT/sm6vNBcJwDQUD6H1iEKc4XgkC4/hPJzyh9lqVkVXMyI+v2douCC5?=
 =?us-ascii?Q?whxE7yIDY+gGVWhm/pb4MURX1V5gkJsc/XiKhKDNwxsOjAKJq8yzyLvBG/gu?=
 =?us-ascii?Q?I7nsSC6X/Yj4ugOtVmmkTw/+1ANJvFli0sPup647mp0bMHn2UkEXItmChuEl?=
 =?us-ascii?Q?FaLY0mjb9dp3bYgejIoI6dvdw1qktYIxLwWfYikxAvpPOlk1yMgGSULy/569?=
 =?us-ascii?Q?m1JwfheS0MBs29luyECT0vU+ZKvfUmZtK4/ozMdDvSZ8F++6jBB/64AeX0tQ?=
 =?us-ascii?Q?QpxNuaS6bA6gxwfysTe8e6dkWYq+8tiJyZAeJ9kTJ4BBZHywL8K6T3WmzCoz?=
 =?us-ascii?Q?8kKVQIXf0PoThObs+LLFax7fFSjPQDmlhX88svj8WdD73tbFAfPmQMeX5VMy?=
 =?us-ascii?Q?vHv8HK39HffGUtEIknuaiqsIV3oR66yqxkfvj3rrG/ISqzqjIBRysQyjTUbU?=
 =?us-ascii?Q?UfBoChreRXNpsMQJTY+17J0Fh+xDRBC80DMDVJEnK4BYepZQRJtn+hlQqw4z?=
 =?us-ascii?Q?fnusq0vf8o5DJQbEDtXDzsnAUJ1aNuWNsgGfQB5a3uln4WrtTM1NFf0eh+wQ?=
 =?us-ascii?Q?cJ7n+N7eP5k7vW3/VF2a/gRH3Q0IfKiP4ZL3GOlwJZANmoI5fveHHfvrLCMl?=
 =?us-ascii?Q?gxLrVFhjGhJAwquBNZOXiHkEg9Jgziq3ZeyYGF4W4BeGhHa5YaHoBwL5qVze?=
 =?us-ascii?Q?+yETalVXtEOeBcLGKuRHHhJUbjpqlWeI930PBZJOw4ZBi2Ng4tk8TscrFLg3?=
 =?us-ascii?Q?sDwlmAT5MslsVd6aObJ3Vr4eDYigfBOToH6LItvfcD2AEzCe4XHQ2spTJXyA?=
 =?us-ascii?Q?iLkywyvxKXEKO+PEmbZhnG8Sbl48/uhZHzchsZf8E05aiExTluFVD+s2GM/+?=
 =?us-ascii?Q?QrKKeApc0v1ct6SEyEuIOBSnUIyyfOytG0hSbvNSHIZCPh5XWOiOeOoGyxtC?=
 =?us-ascii?Q?MsDklNjrC7Too1AA9f4lsQpx6He28kJNue9lNxgPSSrnO5qUQh7umCqusPvQ?=
 =?us-ascii?Q?Z0MNsPTuxImG4jazNJDE+iliTIvz2Bp3ox7opN0SIBed4mlx4gZdVTl83Rxv?=
 =?us-ascii?Q?XZv083rAfLC9sqbiVgxa7JaFknSEJLOQwqMA4UX76PHULEybEHgxAlNLbiSC?=
 =?us-ascii?Q?kYER5RwhNwTBe2MAajHsIWfDnfMFDMU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff934427-5ba4-4b13-c402-08da3f4ae19b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:06:47.4526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2HfYmbMKwGF6x86xjgRjvlECno2aAgEQ3ztLCOORn2TsGoBvUQxRaI8Fu8Yo4Fl9793ti+iRHKV5XyfalN7Hv/mENmGkkL2BBWBZccjidg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3413
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-26_08:2022-05-25,
 2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260090
X-Proofpoint-GUID: hgG2c01FVMfAQBkFLyQ9j2HPoQPSQd-T
X-Proofpoint-ORIG-GUID: hgG2c01FVMfAQBkFLyQ9j2HPoQPSQd-T
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

On Thu, May 26, 2022 at 07:00:06PM +0200, Eugenio Perez Martin wrote:
> > It feels like returning any literal that isn't 1 or 0 should trigger a
> > warning...  I've written that and will check it out tonight.
> >
> 
> I'm not sure this should be so strict, or "literal" does not include pointers?
> 

What I mean in exact terms, is that if you're returning a known value
and the function returns bool then the known value should be 0 or 1.
Don't "return 3;".  This new warning will complain if you return a known
pointer as in "return &a;".  It won't complain if you return an
unknown pointer "return p;".

> As an experiment, can Smatch be used to count how many times a
> returned pointer is converted to int / bool before returning vs not
> converted?

I'm not super excited to write that code...  :/

> 
> I find Smatch interesting, especially when switching between projects
> frequently. Does it support changing the code like clang-format? To
> offload cognitive load to tools is usually good :).

No.  Coccinelle does that really well though.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
