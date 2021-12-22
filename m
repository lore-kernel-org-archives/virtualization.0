Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E896FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 02:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8778D81777;
	Wed, 22 Dec 2021 02:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vk4j1VQyY1ge; Wed, 22 Dec 2021 02:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C90A81765;
	Wed, 22 Dec 2021 02:02:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E569C002F;
	Wed, 22 Dec 2021 02:02:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7885C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9706560F86
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="PVD9LR5p";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="FUZbqz/n"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3H2Qrbie0vIH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:02:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC81060E8D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:01:59 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLEGkM011728; 
 Wed, 22 Dec 2021 02:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T0rSY64qhk1e1kmqIh7J0ONcTNU3+aQyjPvOx3kbhiI=;
 b=PVD9LR5ppDwnbQ2LiP4AWREi42AP5Hlmfqcw4362cy8/yqKmpFqHD/LL4xBxc/qwJk8l
 zOdUTU263V8y8nbPDxejX/AFjFxvnlHc8tr3dbB87XdqXHiDjTgvSKlNwRZbbS0L7/La
 wrCWM/7Cf+6GnOGXb4XpaZOzFAxnbWZqg5rJmZ9TIyFq3H0qo3H3+osJXoEqIt+U+uor
 WTO6qrbuIijAvSQvK3y6rsfAeHSb/Gu2GDoLaxq3wXOOuUvnvBjjrpa/7Is8NfeK61MB
 R0RB6faGUsyGFVwmClLYY0lmI0o3JphK+oyxT6Op/0P8Bi4sl76HRUD/cAg7SzgxXLUo FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2udccer4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:01:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM1uvjD075881;
 Wed, 22 Dec 2021 02:01:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by aserp3030.oracle.com with ESMTP id 3d15pe1kwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILUi7e4ZUchN4Knq66NJB3o6tQwceQHBfNVX89lSxBhylaYWepxj/RUXthMyPAPftyhvWuhmdIahO81A+Tbq92o7AdwXPI3ihEZj+sgEbNDTIZTZ+CUikiKH9IF0D3Jtc+gjGHAQi58fsX0ZJ+b5/4eoFisfBIeCZMzxXTXVNRojYrpebOPFc5zQTLFYnQRnr3aw05j54775Z2HhEx6ZzeKX5gqodvlMU4O01FvH6p80LT2iYegdMB3O+uLkjFtEBwbvQTbNpwyzyFmYyOFs5BeCb8+dADuTxZl3Ch0zhE52yrJ3CuCZynE/LoUIB4Z+Tn6IaJPNXC+7ARfelXxDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0rSY64qhk1e1kmqIh7J0ONcTNU3+aQyjPvOx3kbhiI=;
 b=ZgDl6iAqWgon3+Sbk3uxPo+QSCBZikisAeEZ0teBn21sPQPB1kQv7wjywdi3N0KzvVjSdg4SP4MBBsaF/+WKpLRUPRlQWML+eSlf9pSsyMwOcXEtKmVN5LOMZuEMm3LKFGZqkysj08v1fazWy9EVTMdAEhOrbymPDN5MvEWsj5TOtUftamS2L1A3E509XMPIxBcRGagvF+HUt6MYAmUIRC4IuJtBVR+scwPUMR0W/GAsZo1WsodBdWVyAWksec8P2NQBvKXSuE+8fw2YRzNCW9L4Nk4lsZ6CfpxfnsGU6zpoA1E+a+4KK7HDnQLF+L3FmSshTGbmAJ50C1JINGk7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0rSY64qhk1e1kmqIh7J0ONcTNU3+aQyjPvOx3kbhiI=;
 b=FUZbqz/ndPS1YGRHJpnXZtI/E3fQknL3Xi6pG7zA8OfmeXNkkQN+OdKYnePKF8bXp/rVCwhMsNA1ONrQjz5Nv1XIs5vg9Jpl7Jaw9WWJgOFysXSeK0dgX1JHXSDSUcFh9jSjUJTsrD+NjHsTca35rN9mDdh4FowAZb2dtFglCoE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3015.namprd10.prod.outlook.com (2603:10b6:a03:91::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 02:01:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:01:55 +0000
Message-ID: <3f7e7656-1466-a64e-f2be-1b280b99edbe@oracle.com>
Date: Tue, 21 Dec 2021 18:01:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 09/13] vdpa/mlx5: Restore cur_num_vqs in case of
 failure in change_num_qps()
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-10-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-10-elic@nvidia.com>
X-ClientProxiedBy: SN6PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:805:f2::32) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d138dd5-2c09-4cc8-b80f-08d9c4ef0790
X-MS-TrafficTypeDiagnostic: BYAPR10MB3015:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3015E6CAE4DD0C0D230842D9B17D9@BYAPR10MB3015.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hdtu+0dpkadCLFsNmXQmv5u6ns8c2EjZTPE3ICE0CLe6QC7YRGdwhc7AkyHcOtkYpXKLSveWOhs2WzGogX3uTkmfSN6kJuS7qV4PNExhkMx9py9HuU7y976tlRhd6nHME0YDIcPd4PJIcTDNLdWXdY8AiCYOupCEYJnw3oM1gcZUQw4iMOWRSfSIIxFnauLoZ+JlKVUqpPEusykG/X9KSKUcjwbbnw+5z8gnmF6LtiluSXqbxIky806Np2mnRcLC+MSF57uDAlSuuAIOR1HAYuVfpWZTFETZ1Qacw2DDsIRxYNPChrEkoDtjo0mydZ6yTT47A8j/k0ADO+v7skAbPnDQuAt0D19StdBPSeYvrchBUAJc9Rnhet2WVhtRiaSLXyseXwZTavfv+NePUVyG03gZ1cJvFTDRiBSVmGrO+h/UEN3dX7BRZHQpCjbOogBOvSBDiR3Nx6sd4tjD/TjZxXnWDaVoEogfUGV3l7MpFlFWhJ8bgnMyJDbkurXpb76bn/h6OqAtXEvwOGeXtct8lI56UL097uvNAma+Cwg37Qjrj0MoaZEiIORGC2u1zzalHSmpr9Tpak5lMhC/bCYP8/Kl6JVMi/AV8M1U9bGQS6xMStIIhkLWYSpxxiBuRfqtPQHQTcJti+YPEPeinwxmUz9bm6+jw3iLeYPfnsngC5o2x3oCNiY9x+lDv48BDNy2BR4Bb64RGAHkhGFCTJBnQmCU1LCypX+i2Eyjzgl+bA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(31696002)(66946007)(86362001)(508600001)(186003)(36916002)(53546011)(6506007)(26005)(4326008)(6666004)(2906002)(83380400001)(8676002)(8936002)(66556008)(4744005)(38100700002)(6512007)(66476007)(6486002)(31686004)(5660300002)(36756003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENQYnRTRi8xWVluMnk4Uk1uRnpIUXpZSjUwcnBEY2NQRnpDZUFyNTlyQWxn?=
 =?utf-8?B?eDVvUHZhZExSMHpMZ0F6L2djMndTajVCWDNzd0U1WHA1RC90NFA1aXZQSitF?=
 =?utf-8?B?b3ZIZFJ1M3dMQVdIRW1hZHBwaFpiK1c1RGRES25JMXVrZFNPT3lndkxVRXFC?=
 =?utf-8?B?K0NycWtkZUFYdExsbzVrUndtL3ovOWY4Nkd4UExtdk1BdFVEUEIxaVU5Ylg0?=
 =?utf-8?B?VC9Ra2pudmRVeW5YOHFhdGkwcWNjeDJWSWEzQnpDWlpzVlF5NzFJZU9iSFNV?=
 =?utf-8?B?eE9aQno5Y2JXcUtLcng1Wjh2K29JK1BNd1RiVU1KYWVhVEdhR2cyaWZTMFBT?=
 =?utf-8?B?a3ZZQ2pzRUFyenRBYUt4M1U0anl4V0R0MGVYbGlGMTFvczkvUTF6MmpoNGVs?=
 =?utf-8?B?NllObUZxemh3UG96elBMRFJhN1R4ZkhadXdZZHVmMkdtcDhlZTZKTGRDZjQ5?=
 =?utf-8?B?VFozblJCUHRrZit3dytRdjVONU0vemcxbFhrVVpEZmJPb1NDcThleTVhVUxn?=
 =?utf-8?B?UHpMUmJiR3VHM1R6aDkyWiswWWtyZkRwU2ZRQ1MrcnY3TGVDVzl1aXN4Mjgv?=
 =?utf-8?B?STdIU2h6bFVYM0Jhb1htL0o2ZW01bTRYdWRYSFJ4cHd0STdxUEtPUEViNk9W?=
 =?utf-8?B?bURxWlAvSFEzdk80WDAwZkF2akVacks0S2JaSkhoaGxmeUlwR3Q0V2lYRE1i?=
 =?utf-8?B?UWZSQTJNazRPVDd0ZkNpRnZ1U0RpS3c5WVJ1UjNzeEpLb2N5eDF4TDR0d3cw?=
 =?utf-8?B?WWNGRTNHS2UxdmdvVEVmNXVKQTY5bEVta2ttUFlSeFp0UVRLZy9vNVFvSFo3?=
 =?utf-8?B?UE44clhORm5JVTEvSjdRbzhIS2hwd2hLaU9JQnZ1TkpLeXVmQWViOGs2R0Ux?=
 =?utf-8?B?UEQxUGY5RjMvOEhXUGhLMGpwQlQzR1JIWi9JT3NMZVBVU01HSUxyU29hVHpH?=
 =?utf-8?B?RUtIb2d1NjU3Njhib2lJQjIvNFpHRDBraWJHSEJXc20wSjMrZENZWUpPdk5u?=
 =?utf-8?B?bnlEcmlCbFhwL3JsVVZDcHNUdy9sbkJ1eFptblpEdE40S3hvNEdSVHRybzJr?=
 =?utf-8?B?WlJXODdKcXNwdEZFenlGeDhSZ2hpdnN1UWw1aUNUSFpLOG5UUTJLMDV0SmJ0?=
 =?utf-8?B?ZDhsd1AreS93c01PQTdLTU5scnJQNFpQZy9jK0IwMDFSY0wzbGVxclNVbmY0?=
 =?utf-8?B?c3lDaFg1aDl4VDJUM0FJZEVBNnVlR0N6Y2xXbzN6ZTd2L01FUEp5MS80aEo3?=
 =?utf-8?B?U0RTV0FpckdRc284RklSWUlOYXcxOVVrRVJVdk1wdThmQkdBTDBna0p0VDdr?=
 =?utf-8?B?ZjJ3VmdBeFkwN1lpSWNJelRCTVN0aDRjdm1IdFBiZm9RSSsvN2k0U2lvZ2Q1?=
 =?utf-8?B?MUxJbDY4S3BuTHh3c2kzYm0rUzE0dVIwckpZdjZ1dlBmdlpsM3B5TEhPejV4?=
 =?utf-8?B?Sk1oUi9NMTdwYzMrVmpnTitxelcvbE41d3EzSllyWm1jNEhERlZINzZOVkg4?=
 =?utf-8?B?RUlhaGtLRlliWjZjMHF2OWJjSHp4cU5xZ3lMWmV0U3RxUUliZ3FiMmYyNGJZ?=
 =?utf-8?B?Y01OaG5YN2dHTFVTa2ozaHBnNnp1RGRpNTNmOGZpT09HenkvWVRPTzNwMWlj?=
 =?utf-8?B?TlRqRFd4Rnl6SnpnM0JtRXlWN1NXd0Y3eXBJL3FpMU5BejBFcWE2REZGcW56?=
 =?utf-8?B?enBLUnFabzNJQ1prbGZzZnlHblJaZWthaFE4a3ZCY1I2RXRSdmFBOVBpbStS?=
 =?utf-8?B?Ynp0T2NxRlRGRlpyUzAxdEF3UlBld0N0ZnJZUDgrQy9jV2NzUnU5QklwRlh0?=
 =?utf-8?B?cWlnMlUwTmhpYzJ6anY5eHA5SmNaUkcyV21JU0JHNGs5Q3hJSkprZEthTndu?=
 =?utf-8?B?b2FtcXFvRFlPbXI5OUZxem1vNVVNY3hQSTg2ZE9NVndYdDFQWE5VUjM5SnA1?=
 =?utf-8?B?L3BmYjlNWUpyVHpCWEh0SkJHUUh4aUVwcTJjYytKSVo0SWR4UnpDSjEzMnhr?=
 =?utf-8?B?UmkwRFVXMk5ZeThCblRBTEZFaDhtaGJUV0VnSVV1d0p3cEJ6UXNGYVQzRG5j?=
 =?utf-8?B?S3dYWDkrU1g3a0JvN2d1Sk5YeCt3SWF2T3FCOG1yN2xWV0t3QnppVFo3U01o?=
 =?utf-8?B?VlhUR3dINGZ2Q2xhd3FjVUIwNEd2Z2FtbXN5dHM5MmVKZmdMMzJVc3RHQjNw?=
 =?utf-8?Q?Q22LdyrkQXymXT9JsvD+3Ns=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d138dd5-2c09-4cc8-b80f-08d9c4ef0790
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:01:55.4194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V22rpqPaY22R8ahiB01+WMGJok8+R9XqwyUx5mUTi33l7ZvLk4NntT1CT3XUUYuZKLfmpQbgOjz8TnAD7fL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3015
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220010
X-Proofpoint-ORIG-GUID: 2U3cipqkd22Yuff5XjBjq-Fo_radFNQD
X-Proofpoint-GUID: 2U3cipqkd22Yuff5XjBjq-Fo_radFNQD
Cc: lvivier@redhat.com, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/21/2021 9:20 AM, Eli Cohen wrote:
> Restore ndev->cur_num_vqs to the original value in case change_num_qps()
> fails.
>
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>

> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 848eabbb1831..72ed5efbe35d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1536,9 +1536,11 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
>   	return 0;
>   
>   clean_added:
> -	for (--i; i >= cur_qps; --i)
> +	for (--i; i >= 2 * cur_qps; --i)
>   		teardown_vq(ndev, &ndev->vqs[i]);
>   
> +	ndev->cur_num_vqs = 2 * cur_qps;
> +
>   	return err;
>   }
>   

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
