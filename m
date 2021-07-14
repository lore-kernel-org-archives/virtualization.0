Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8173BC11F66
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 09:58:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BE46115A
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 09:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BE46115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D906660A80;
	Wed, 14 Jul 2021 09:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrHte3J6FaMc; Wed, 14 Jul 2021 09:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 64DB260A83;
	Wed, 14 Jul 2021 09:58:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB214C0020;
	Wed, 14 Jul 2021 09:58:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 590A1C000E;
 Wed, 14 Jul 2021 09:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45F724025E;
 Wed, 14 Jul 2021 09:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="y9+nHHjB";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="xSsO7jPy"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q-uTjwoq8kli; Wed, 14 Jul 2021 09:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 320394024E;
 Wed, 14 Jul 2021 09:58:17 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16E9vJVW000307; Wed, 14 Jul 2021 09:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=ySNrfuSY91tFx0j4QsaYgb5F0zahgoMS92DsTPCExWA=;
 b=y9+nHHjBLElIxGqAz11Zh30Zsk0lj+T1SKWorfZ2bT+E+fx2MDpD309U10Sv+zH6K99s
 oc9qU58oTl5te1QiDPvnCTWfBrKEK7lgAmrs3okOW4quvqm/pFCy0eEOy7Qf4pbZeoj/
 hDXJS6DQVe7zzWWvPhFAzR+cxBrECjLTchTRANqkRfu6W0qm7kJi2gY9xXrOuNTIFgQO
 EYEvM6coogOXu+z/uUUZwjuzWkt4AvUgNO3Mv26dk6FJ2xd53REGCicGQN4vangnv9Q8
 7wGm88f+2+gBWzTzG876BseK/G2qmxfe/BjeZjE6C4j8ryLlCrDpmYsiYRe4d5pKkl/h jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb4d8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jul 2021 09:57:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16E9uXGL195965;
 Wed, 14 Jul 2021 09:57:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by userp3030.oracle.com with ESMTP id 39q0p82suu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jul 2021 09:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLowqVdiwFSEwX9u5kQ6+lqKJl8h2ByYfR5ZFkdoAT8AkPvnRAGUsEsycWZUmvMUoeoM2zvqKDhGGLRf83H98avaCQGwMC7eFDOUdwQA1DWqKUGYg6MfLoCKQTaMn+G9phuheipNJ9H2GUDzmcqkRQRXZNEejhi1fQQI82Tgms8tbuau+3Acu6iC12h9PytzRUU5nO1bTqIQqsBJqXLRcCSZ5xyUqkykXB6Ev3qMySwmdXDUAYQVOlIvzPZn/Dmui+kxeMgLuKhxdQoLI+tUj2a9xIdHKIcpvcEmhQhBbztgKazbj4Kv9EQOF/KPy5neBXVKJ7/nqvCpcODZG3005Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySNrfuSY91tFx0j4QsaYgb5F0zahgoMS92DsTPCExWA=;
 b=HEfEpvb0KiMnV5P7hwJUWzOtWyQ7MEb7A/uKJc043EIFFVqpDd/kKH1nw1SWPpeqrVUoAnhV3aG0Ch6L6EDpG3wpe41RUXmQ6vvvGptj9y4c7sbHByAuo8pRrcGFmXDTemWuh6SHGiQms8T99X6glw64aEXbMoFMgjYHvLdAAbdT0z2XU/KFo/zHsi58TQ7fqWQ57FjUGBjzaaT9Xx5hH7wZl2hIt+G2YAfzla4+HrHplRHpf6+MV/HpCSHt2QWyvg2qY+anT2hc0oRxUZHKUgIRiFHtTdHrFQUEVciFYO38b6zIeMfSDMFceY8pZ0YFC7T/o3ymid1huUYlw80ZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySNrfuSY91tFx0j4QsaYgb5F0zahgoMS92DsTPCExWA=;
 b=xSsO7jPyYy6XmEeBPu6qXTvrjUe/6E9S9YfsuIRaVeQCZz4CoBr+2u3LxDFoVyvAR8WflAllyhyQe8770NrRnjNBecghzuAphijTuSqd03tGOQy5oWeOK8r0gBhph0GYFFhX5jwUQBU5PV791pGuPoERdjUOyQn0gWIX3+Vv2dA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1359.namprd10.prod.outlook.com
 (2603:10b6:300:1f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 09:57:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 09:57:52 +0000
Date: Wed, 14 Jul 2021 12:57:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
Message-ID: <20210714095722.GC25548@kadam>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com>
 <20210713113114.GL1954@kadam>
 <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
 <20210714080512.GW1954@kadam>
 <db02315d-0ffe-f4a2-da67-5a014060fa4a@redhat.com>
Content-Disposition: inline
In-Reply-To: <db02315d-0ffe-f4a2-da67-5a014060fa4a@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by
 JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 09:57:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a437edd-4bd6-410e-d4eb-08d946add800
X-MS-TrafficTypeDiagnostic: MWHPR10MB1359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1359BE47C729E943858EB9368E139@MWHPR10MB1359.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IH+SB1WMCzv3wS2junlOy+9m+l2X7s1XJ0MzcI1/5Z74c3lahO8rc6uXNrZeoeQ8MdK/YQkNinxHzXB5roZ9pyVC6CfiohzHGHvh0FSzK8Kf7UP4rq5GDvyA/RtbVqXo7iu3PNnCOaqFFRSDJrE44ChR0DAebXfckM1+gJ2xPErdFmgrR50j6fB/UhYlBYFdovu0TzSuql3AEz8w9LIJq1eJfpVhwDjYBhj++jhV4mx/z214xrnuqpx7Xi6N9dwmZpN6EjkE9XuMS4OtI1uQ+SyyBbuwObVC+hm2W6BPjg5kmnZ6Dr3dko+I8uY6adZHJkRA7XOPePL1A1N9kc03JS+l+CRVEQWwnpF8xBMUgfOcFf5V79mvoGrlVkm20tee6FgqmKbWtUvWTc8xgNaIzF8RmooQlzXu6LnB/MwqTx9lZWqAYNS3ohys/dm0bwIZ7+4HcUUsk4cIV1lGPzAv3SZ/Mo902U+oePasb/qZjs3fEPZpTneM9lqNUlUyfwu4Em7m9TwNMGnpe76HU0BoMIpWWo4mQCQ14eolVxT8cnCskJV8Hwi8dsdGCJXDSq66RVHQReAdaoLHufXwSwG36exEHmTHz6Eag0RltqCdCizbmNyO+sbT4L920QDKANTv/q9JVqcwhL/llcdweM7YcxogIbUA4tiYR1SR6UPFT6Yx7wTqUrmeUa+gr+lZGsY1mKEguAX76DShdnaOy4YZNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(26005)(6666004)(55016002)(33716001)(2906002)(186003)(38350700002)(478600001)(7416002)(52116002)(4326008)(6916009)(1076003)(9686003)(8676002)(66946007)(66476007)(86362001)(956004)(66556008)(8936002)(5660300002)(33656002)(316002)(44832011)(6496006)(83380400001)(9576002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE8rajllYzJEb1dGbVBBRlFCM1laVkYyK3U2ZjVwUFV0SGpRV0RTaWN0bTNW?=
 =?utf-8?B?QU8wc2lkc2l1d0NrTFRVOExFdDkxSTFZVUpOTFR5aTJIRHVkL3FsZGNNK3dz?=
 =?utf-8?B?dlAreHl2ZlNoZkpTNm1WenZEVy83WWdHUmJOWXVIUStaemdDL0pPL21mYkEv?=
 =?utf-8?B?ZVUvVEVVZm5sZkhkZ2lIS2hydGZMWkZxYWtCWktxSFJadU9NUmI2RU5SaXg5?=
 =?utf-8?B?U3pzQkwrUStmTVduR1hVMVJ0bVlzbS94RW1LK2hpMDM1N2ZVdlNyYXV4NTlq?=
 =?utf-8?B?VmdxbXNoWVE2Q2ZoQnVubmkrOEkxb0tGYnhvTEhMb0cvTkwxeXU1S1ZwZys5?=
 =?utf-8?B?bDF4YUlDeG9neGh1UEFFYUUzMEx6Wm16MDFXcE83NXR5b25vR3pjSW9uZ0RM?=
 =?utf-8?B?ZWdKaXkzMkJwUjRlRzBZQW9hU2pQR3Q0R3dYQno0Y0NJQ3pseFFJTDRFYXdU?=
 =?utf-8?B?U3VvNWNlTUxIVWxNUjh3OGlzdVJhNlV1K1NmY24ydWtzS01NWmJnY2dpVldi?=
 =?utf-8?B?SFpYekdjVkozM3NSWG4rdzJCVHZnRVVPRVlhRFQwa08wSkFpNG1LbjR3Q0xR?=
 =?utf-8?B?YncwVlRlQkI1cGg5ZTBBR0VTR1QranBRd0E3VjMrUmxRd0x5UUsyRUJkTEJB?=
 =?utf-8?B?dkduWS9hSnhsRWQ2MllmcmlNSERzcFVBK3h4N0JwT1I1LzJzTW4zZWluM1JP?=
 =?utf-8?B?YldRU1oxYWZBaVFFTDFEOXVESVNtNXRWcHdwU09VTzRUdkZOdHBjVlp0TUp5?=
 =?utf-8?B?N01ZRFJOTm1xMTcxSy80dXowVjJaOExIZFVSVGRWbjRhOHZwc29UaFgvTVRn?=
 =?utf-8?B?ekZzWXpaa09HSE9VZGFiTHAySXI5UVRVVEVmc1pIRDhYQ2RmR2RESkJyL0tw?=
 =?utf-8?B?bTNvUFJFMllWRy9BL3I2QmtoN2NVLzVnS2xTUGVRT09VdjlmL3h0NXl5VEdP?=
 =?utf-8?B?Z0FFWXZ0SnRXZ2xlUy9MWDVjbk9RS1ZaWkZXSlV6MWlHbk41cFF1RnRpdVFI?=
 =?utf-8?B?OGpidzAxbSt0eitCUGZEMjc5b2M0OHVMUU95Z2p1aFVmSWpsckZXRXVKekxr?=
 =?utf-8?B?a2pxSjI0V3ZqTEdUcW9vSnB2aDhUeC9xUVNSenpNRGRBalF2U2tlb2lURXdL?=
 =?utf-8?B?dE9MQmorN3E3cWFnSWVUWGI1WTFYdGd4VWUvTFRSN3hHYU93d01sdEEzRDBz?=
 =?utf-8?B?VEZwSFF3UjJDRDJadFNXZzRLMFVFNllWL2FZK3E2ZzUxblZPdXJjUHh6TEdK?=
 =?utf-8?B?VGJMMmlsZStOVFBydnNXYkxFbGJIVWhIS0ovYUh6SFo4VkJwclJDVldxcmJt?=
 =?utf-8?B?Z1FEL1NkNFFRV0pWL1dLUGg0Q2FSeElnMlVPdFNXVFhUeXhCTzJjck0vRFUx?=
 =?utf-8?B?RWFoVis4cjQzQnEzMWlzWEJQd1RqRGd1Q0lkcDRjUXhuODZwc0RJa1FNV1Ro?=
 =?utf-8?B?S01TSGlUTm9QYjRoS2ljRFArY05JRVJJWElCRG4yRkRGYk9iaVhpSlNQVVZh?=
 =?utf-8?B?ejBSNmJHWWlVdXFlUTM3WlB5Umd6My9jditXTjdzcXdwRERzTktxd3JhSTYw?=
 =?utf-8?B?d2JqajhRMXp0NkswLzRtMEJkdkZKQWpJNW05NGxadmtNWmYwRUZLMm9ub2p5?=
 =?utf-8?B?em5rdThFb3Q4OFlSVThQTjB3Rndqd09EL1Myb1oyYVNJY2NKS1lYZVdQcUt3?=
 =?utf-8?B?cSthV1dkeGVYODNldDlucXBZYUhXMVlTRWxrZGIzSjBBeGFoejh3MWRhOFFN?=
 =?utf-8?Q?ulGB0DroMR0nHsjc4TPp7Hj3TPYT9kR0H1uaTiH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a437edd-4bd6-410e-d4eb-08d946add800
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 09:57:52.2392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So+Yubu+n1JsCLF1nKs1Um64geOaxRSaPFNRJ5TbPh2KaHC73D7I+NSyj1Uo6Ao+PBZGzTLFd2P+4iWqKwBR6OwDCsiCydOtDMJQnjdZdpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1359
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=844 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140065
X-Proofpoint-ORIG-GUID: PhHiYWmApShfgBOj5Zgb6NL3N1Tg7NRL
X-Proofpoint-GUID: PhHiYWmApShfgBOj5Zgb6NL3N1Tg7NRL
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, xiaodong.liu@intel.com,
 viro@zeniv.linux.org.uk, stefanha@redhat.com, songmuchun@bytedance.com,
 axboe@kernel.dk, zhe.he@windriver.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBKdWwgMTQsIDIwMjEgYXQgMDU6NDE6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS83LzE0IOS4i+WNiDQ6MDUsIERhbiBDYXJwZW50ZXIg5YaZ6YGTOgo+
ID4gT24gV2VkLCBKdWwgMTQsIDIwMjEgYXQgMTA6MTQ6MzJBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4g5ZyoIDIwMjEvNy8xMyDkuIvljYg3OjMxLCBEYW4gQ2FycGVudGVyIOWGmemB
kzoKPiA+ID4gPiBPbiBUdWUsIEp1bCAxMywgMjAyMSBhdCAwNDo0Njo1MlBNICswODAwLCBYaWUg
WW9uZ2ppIHdyb3RlOgo+ID4gPiA+ID4gQEAgLTYxMywzNyArNjE4LDI4IEBAIHN0YXRpYyB2b2lk
IHZob3N0X3ZkcGFfdW5tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU2NCBpb3ZhLCB1NjQgc2l6
ZSkKPiA+ID4gPiA+ICAgIAl9Cj4gPiA+ID4gPiAgICB9Cj4gPiA+ID4gPiAtc3RhdGljIGludCB2
aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ID4g
PiA+ID4gLQkJCQkJICAgc3RydWN0IHZob3N0X2lvdGxiX21zZyAqbXNnKQo+ID4gPiA+ID4gK3N0
YXRpYyBpbnQgdmhvc3RfdmRwYV9wYV9tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gPiA+ID4g
PiArCQkJICAgICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCB1YWRkciwgdTMyIHBlcm0pCj4gPiA+
ID4gPiAgICB7Cj4gPiA+ID4gPiAgICAJc3RydWN0IHZob3N0X2RldiAqZGV2ID0gJnYtPnZkZXY7
Cj4gPiA+ID4gPiAtCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIgPSBkZXYtPmlvdGxiOwo+ID4g
PiA+ID4gICAgCXN0cnVjdCBwYWdlICoqcGFnZV9saXN0Owo+ID4gPiA+ID4gICAgCXVuc2lnbmVk
IGxvbmcgbGlzdF9zaXplID0gUEFHRV9TSVpFIC8gc2l6ZW9mKHN0cnVjdCBwYWdlICopOwo+ID4g
PiA+ID4gICAgCXVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOwo+ID4gPiA+
ID4gICAgCXVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3BmbiwgbGFzdF9wZm4g
PSAwOwo+ID4gPiA+ID4gICAgCXVuc2lnbmVkIGxvbmcgbG9ja19saW1pdCwgc3oycGluLCBuY2h1
bmtzLCBpOwo+ID4gPiA+ID4gLQl1NjQgaW92YSA9IG1zZy0+aW92YTsKPiA+ID4gPiA+ICsJdTY0
IHN0YXJ0ID0gaW92YTsKPiA+ID4gPiA+ICAgIAlsb25nIHBpbm5lZDsKPiA+ID4gPiA+ICAgIAlp
bnQgcmV0ID0gMDsKPiA+ID4gPiA+IC0JaWYgKG1zZy0+aW92YSA8IHYtPnJhbmdlLmZpcnN0IHx8
Cj4gPiA+ID4gPiAtCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxID4gdi0+cmFuZ2UubGFz
dCkKPiA+ID4gPiA+IC0JCXJldHVybiAtRUlOVkFMOwo+ID4gPiA+IFRoaXMgaXMgbm90IHJlbGF0
ZWQgdG8geW91ciBwYXRjaCwgYnV0IGNhbiB0aGUgIm1zZy0+aW92YSArIG1zZy0+c2l6ZSIKPiA+
ID4gPiBhZGRpdGlvbiBjYW4gaGF2ZSBhbiBpbnRlZ2VyIG92ZXJmbG93LiAgRnJvbSBsb29raW5n
IGF0IHRoZSBjYWxsZXJzIGl0Cj4gPiA+ID4gc2VlbXMgbGlrZSBpdCBjYW4uICBtc2cgY29tZXMg
ZnJvbToKPiA+ID4gPiAgICAgdmhvc3RfY2hyX3dyaXRlX2l0ZXIoKQo+ID4gPiA+ICAgICAtLT4g
ZGV2LT5tc2dfaGFuZGxlcihkZXYsICZtc2cpOwo+ID4gPiA+ICAgICAgICAgLS0+IHZob3N0X3Zk
cGFfcHJvY2Vzc19pb3RsYl9tc2coKQo+ID4gPiA+ICAgICAgICAgICAgLS0+IHZob3N0X3ZkcGFf
cHJvY2Vzc19pb3RsYl91cGRhdGUoKQo+ID4gPiAKPiA+ID4gWWVzLgo+ID4gPiAKPiA+ID4gCj4g
PiA+ID4gSWYgSSdtIHRoaW5raW5nIG9mIHRoZSByaWdodCB0aGluZyB0aGVuIHRoZXNlIGFyZSBh
bGxvd2VkIHRvIG92ZXJmbG93IHRvCj4gPiA+ID4gMCBiZWNhdXNlIG9mIHRoZSAiIC0gMSIgYnV0
IG5vdCBmdXJ0aGVyIHRoYW4gdGhhdC4gIEkgYmVsaWV2ZSB0aGUgY2hlY2sKPiA+ID4gPiBuZWVk
cyB0byBiZSBzb21ldGhpbmcgbGlrZToKPiA+ID4gPiAKPiA+ID4gPiAJaWYgKG1zZy0+aW92YSA8
IHYtPnJhbmdlLmZpcnN0IHx8Cj4gPiA+ID4gCSAgICBtc2ctPmlvdmEgLSAxID4gVTY0X01BWCAt
IG1zZy0+c2l6ZSB8fAo+ID4gPiAKPiA+ID4gSSBndWVzcyB3ZSBkb24ndCBuZWVkIC0gMSBoZXJl
Pwo+ID4gVGhlIC0gMSBpcyBpbXBvcnRhbnQuICBUaGUgaGlnaGVzdCBhZGRyZXNzIGlzIDB4ZmZm
ZmZmZmYuICBTbyBpdCBnb2VzCj4gPiBzdGFydCArIHNpemUgPSAwIGFuZCB0aGVuIHN0YXJ0ICsg
c2l6ZSAtIDEgPT0gMHhmZmZmZmZmZi4KPiAKPiAKPiBSaWdodCwgc28gYWN0dWFsbHkKPiAKPiBt
c2ctPmlvdmEgPSAweGZmZmZmZmZlLCBtc2ctPnNpemU9MiBpcyB2YWxpZC4KCkkgYmVsaWV2ZSBz
bywgeWVzLiAgSXQncyBpbmNsdXNpdmUgb2YgMHhmZmZmZmZmZSBhbmQgMHhmZmZmZmZmZi4KKE5v
dCBhbiBleHBlcnQpLgoKcmVnYXJkcywKZGFuIGNhcnBlbnRlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
