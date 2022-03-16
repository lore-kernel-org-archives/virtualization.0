Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A04C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 22:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79009842F6;
	Wed, 16 Mar 2022 22:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcJ1DJV1BrgV; Wed, 16 Mar 2022 22:00:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C9DC842E3;
	Wed, 16 Mar 2022 22:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A547C0012;
	Wed, 16 Mar 2022 22:00:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE8FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 22:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CCC8842E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 22:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vxHguQxHlWYT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 22:00:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E181842E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 22:00:33 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GLE5LT030078; 
 Wed, 16 Mar 2022 22:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Zk2Xzff3FPF/IVQhwlAac/X1ynwIuTaFRTPwXpUzvOw=;
 b=Iued8YKsDWdqByBo2Ursgh0xfJvhfMi8+X7ZH7ejEVmFqXYgxc6femTCrBlVyfF9XC0q
 vUSEU2/DcugQal83tyNqDo/3oqW3LSJ3n2wMNVrJTn10IEVk3mlYlAUjIn5XN1lYeCj4
 xkmXUh9vXvP9NghmwEnvJRi3eOf/STEcoAVhHQ4OyY7LKbYkYqRwd7SMiQa/7ozN7lan
 3bLZioh2HUwR6eE5cWBP49Hn0RNQ67xDL/4oKN6ZmxAwL55ipH8JrFL+5R8rP/qsxodD
 r9MtCC2A9oNEEC+w7eUQbbTRK0ZMZSnSpGxhgot/FKKYAvNq7lJ1n6vafK3kuUvT8cqd Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may
 be forged)) by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu7sas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Mar 2022 22:00:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GLvj5I021496;
 Wed, 16 Mar 2022 22:00:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by userp3030.oracle.com with ESMTP id 3et65q1270-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Mar 2022 22:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvY+4as8mllSybYSeb6hPtzRmV0O3uZAe1QVB5faw22xkjkKRgcaKwDBSn9czjM+SFI01WiLTszYJN53pzU0EA6IX84OEj7Tb29LxqyRJS/019GTbYBH/p91sHwxynFtKCN9LbQ8UgoWh/lcc2KH767MRcMzhUHwCSAwjm8KsoEtBDjCVOtWWMIAEYNadYpNj8HY29KVhw5ymi6Ql2aNyrgIG4i3XzXvzpmMsAaAm8YGd1A/bV566TiC+MwTNx8qX2iUczX8swRr+KvU8XOaIE5g6FlpkSgIl3A8LZamuG8KYNvh//C1Zgk6kGeJXdQBG570V0mDPZswF9UQJniCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk2Xzff3FPF/IVQhwlAac/X1ynwIuTaFRTPwXpUzvOw=;
 b=TSKqT6sHPwgrAAT+fBXxHY2O43caLKEKZUlvyXVl/eVFkOkVpX7FVsEP1luRsmA6HYWUBoCF1sdImuIMmVLJ7jxCQHuEnGF38h1egtzBAYM4eywnwj/VINraTut1AJNqQXpFKI4grj8pLRK3WhoMtNg4XeYpNgRgxkKHKWCDfQxrpjP9A/yn4Bs6Z1XcpNi/DihD0qfeOxu1+QZWX4n0a68+ylIPKSzod/pCVHrNIgyOH4qoEU2zGo43xgopreZLgBUzLeTdGor/ltonPh2ChLjv8GNiNXawHZgGBKx22+Oo8qqxTAreOmKPTCTPzCZNuuDJNN9ldiycIEl00Uocqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk2Xzff3FPF/IVQhwlAac/X1ynwIuTaFRTPwXpUzvOw=;
 b=nncVLxVghUoCdzzGFB8f/nWQOgE7UQznAg49mMRv/M/DG9hEwikYK16II4PtRD4KewedWdsHcawx4j+P/ivR/yxtZQchB6ZxwGXa02reaL2wMnvHc1lgewpVkDBemwNA89ixgF0E9Qw+lIPAxsaE+T9LAA6RIPopmXJftcYvcXA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 22:00:28 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 22:00:28 +0000
Message-ID: <7fa43ec9-202e-0cbc-22fb-0770ed023c35@oracle.com>
Date: Wed, 16 Mar 2022 15:00:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
 <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
 <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
 <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
 <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
 <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
 <DM8PR12MB540086CCD1F535668D05E546AB0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <a30ac3c0-059d-4588-c5ac-599c060f6bbf@oracle.com>
 <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <61748d91-153c-ec79-c1f0-e3c44cdbea5d@oracle.com>
 <DM8PR12MB540054565515158F9209723EAB109@DM8PR12MB5400.namprd12.prod.outlook.com>
 <53dd5c21-5045-bb66-05fe-1a1157f7abe8@oracle.com>
 <DM8PR12MB5400E7B2359FE4797F190AC5AB119@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB5400E7B2359FE4797F190AC5AB119@DM8PR12MB5400.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9428fa1-3911-4628-ee6c-08da079861a5
X-MS-TrafficTypeDiagnostic: BN0PR10MB5173:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB51733665C5F884BBE75EAA16B1119@BN0PR10MB5173.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQt86rpw2j/ZL8TStyw2SfMdPYIsmPCjy44JTjZAL5uxl43eyCmyg1MWzlaj7x6ZX4m8V0ikgxgCijaPerKKZ9U8EWuGU/vP3eyJwUvXKY/SNC5f8Gh74R5DxHAy/XMbcfTzAPFbgYROMaKXrUBKe4wNdblH9KOicWAJtOBQ2oIBj2JATkZ8E/Nzf8F0nNvvUptBYtU45uYmGiktGAHIWfcIM6HW1CI3hqOHBToK86yVb81Jrb+3kVS/XGXurRLnFCUBN5nw/de1MZFpL3TAOYLSE19hh6Ywv5zWWKm0jZLk6FN5444eCDCdU0qxeg0p2FT9UF1outEY5JK3gxskM0isp3HvYUe+e8QOyh9WCYnczHjqJ3yWnehyibZ/xqkggds/8XTb7vQy2OWAnuF86EQKDp70h0k9DCcs/TGCPNGJI3hoezyiPT8Ta5uM09F+uA/D2XDB3cSqVMQmGvVQJ0qeyq1gJvl0GRw73QrZsBq2kPVjyxzsK/vtsWRHUWWzKDh6OOa6P9D+m4oaRP/+y789Zd0ekDxuJ6fpnMcvSNTMMqkaLsgAROuIg5BmtIwrkvN2KshjgsAVri7JLd0HGwvOSYKIQ827uoowBNJzq9RsnF1Vh2uYYDpUnliYI6KDYyYJpia/Yv7wqUz370aODJh/DRGSPeMsIr2F7obg5T8M8gzSro5TE0FwXJWtZw7TKgMzd7UAob30affRc/bPYz2mhDKymvbJ6igcZcQs7JIlStxJYuwu3DjIkyjjxAKq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6666004)(38100700002)(30864003)(2616005)(31686004)(6916009)(36916002)(316002)(36756003)(54906003)(2906002)(4326008)(8676002)(83380400001)(6486002)(86362001)(31696002)(5660300002)(8936002)(53546011)(6506007)(186003)(26005)(66556008)(66476007)(66946007)(508600001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTZ0UXNYeWdsOURybGZ1R1dpamRFWlFsblZmUVQ1VkhFTEJMY2Q1anhvYjl2?=
 =?utf-8?B?SmVzVDZiSkt4WHVUM0N1Q000M1MrVFNqTDdkTXVMOFo3NStnUm5ZaS9kNDdz?=
 =?utf-8?B?MUJhODNXaG5NS2tMdStJbjN5Y1VUbmdzU1pPVm5ZaXByZGduRW9pd000WjJU?=
 =?utf-8?B?VFU2SWVpbmdUOW1obStZZ2xocE04NWxsZmdobWpteFd2YlhXeGFad2NOdWNu?=
 =?utf-8?B?NFozVUpvWTVsbk8zQXo5MzAxeVJ3VjE4NllDZWFIb2hUYmh4SWtiWFRpcmMw?=
 =?utf-8?B?Mmc3OU5ZOG0zdnByNnhrMzNpY2U0WWM2SVRqalBCZjF1TjJxMDhjb2NWWlBI?=
 =?utf-8?B?ZUNVcVhNV0l6aHJxL0lUdnZpTDRWWWQva2VSRlhzRHVENmRJejZxRXVSUzgv?=
 =?utf-8?B?SDFGVC9LQW0rV3p5NXNPTFBvQnhzdURzQlFZaVVHZ0FPM05zMkZYb283YVNn?=
 =?utf-8?B?MDRLMW52SDNwYjZ6MU9zMC9yQWFlaHc0UFVJNkI0SVVvaWU2WCtPVGdBMUNo?=
 =?utf-8?B?NVAvaVpnY3ZqcWJrNWM3RXlZVE4zS3haNkQ1ckRwQTJZdUZ4b3dWNWIrU0pT?=
 =?utf-8?B?Nk9nYW5kK1o0L3lqaHVlYnRhZHFWLyt4MzBzbnJ2ZGgvcmdvQ1hKR3lYblpN?=
 =?utf-8?B?TnNrcE1ISnBlRi9vSEJBbmRjaGlmMm8xTTBFUUxYVWJDckQ3UXVuTGpvNEpo?=
 =?utf-8?B?TDdOSUJoUDM4UHN3WnVrc08vT1p3NWhpVUxkUFNRREtwS2hCUnoxWnRkK0tF?=
 =?utf-8?B?TndETXBaNjJSanRzdDd2ejVFd3ZEcmNjUjBhNk9weThRcDBqRlVUdk5wU3Jr?=
 =?utf-8?B?bFo0a3JSTGwvdzUzWExxSUxqOVZiN3UrV0syazV6U05BRUVXVkN3VEd6RHdG?=
 =?utf-8?B?aGhTUnJObkJjZ0lGV3dzUWFyR0tJcjlvMWVNZy92bzdmZ1lDUkpLcjhvbGh2?=
 =?utf-8?B?SEJQMStWWFRDdlR0cmFIaktpdGdaMVNPSXlDbnBUalpFN0xjekxZNDhZRURa?=
 =?utf-8?B?dWk2Mk8va3NPZmIwZDl6eUFFaGVmdklPU3VQVVVDWkdQUmZrMDJCdER5WnBW?=
 =?utf-8?B?YmsyeW05ZjNmSmZuR2xSSzFodWVSVGdNQlRucWloTFR4Mm56V1dvWGlrRzgw?=
 =?utf-8?B?aWx1R0Q3ZFVaZ0NyaExVQ2ZsdkpodDBLbHB6M0RkWTFaSm83U1NLTjJzUU1Z?=
 =?utf-8?B?OGlIcVllRXI3aTZYZkQ0bjJQaHR5bGhMQkdJcEhRckVuTnVYbVVyWXhFN3JU?=
 =?utf-8?B?aW9URlhWWTYwU0Q4VzBNUDlKV1R2MzhOSFJMbVVsRDJ6bXFUc1hyaEpucUYx?=
 =?utf-8?B?TU9Na1BFOUE1TGEzdTFleU93V1R5Zk5xMzJsWnl1TE5GOGEzV0JoTDdzdVRL?=
 =?utf-8?B?OGlJbW9MQ3QrcEJLODBwdUxhbEYveDVDZkc3NHM4RVI0bmZrSXZBNnVuMG9R?=
 =?utf-8?B?a20yTm5NR3R0TzBDUXVES0dhbFVoSVBPcjVKWFpWSXhWMk1TNnVwYmIwTTlX?=
 =?utf-8?B?YzJBMy9nZ0pTVDhyTjVaYm5OVU5WR1JGaExBR01vUzBDY0ZCUWlNWUYzRkox?=
 =?utf-8?B?dyszVUhSYXloN2tPNXFrbGloS255Z0gybEswQ1dMOW1xclJKME5KSytlZFBN?=
 =?utf-8?B?ZE9waE5MNEtkbGNYTnpjZ0lIM1NtWW9aTW5YS0VDY1hack81aVVQNmovL1Vq?=
 =?utf-8?B?NU9uNWhVUXViL2Z2eDUrVE5QckNabGluN05kR0E4OTIreUtWOW85eVFLS0Jh?=
 =?utf-8?B?RUhQVjdmcW5jbTB6Nk5td2VGdnpOemdMRXNHVUh5VGhHNXJKVlg3dTg0d1ZW?=
 =?utf-8?B?Q2dQUVNrT0VGcHEyb3hxNzI0WHpYb2tXMWRRZHZJWkMzaUluZnJ4b1ZIQTNU?=
 =?utf-8?B?WVU3azd0KytQLzV5anRrWlFldTh4L0RERFFac2psZWRodVVHZHdoeFVsSUZy?=
 =?utf-8?B?TjlGSVdBeGtXTzVWc2hxUG82OUttQTBzdVhpSWJvSjBucTdWRzdIYTQ3ZURZ?=
 =?utf-8?B?WXlyang0c3d3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9428fa1-3911-4628-ee6c-08da079861a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 22:00:28.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvmUsYT8vkZ7Iu0k3Lwk0h/zLylMMNGbyqvrevHisVh7qtf1QO+3sgi8nTMosUm+mMaBOYn8yRe6z+4ZWsilIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288
 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160132
X-Proofpoint-GUID: hfk3Q8Ot4VdTkeSWdG7bF2P0b7w56Kgb
X-Proofpoint-ORIG-GUID: hfk3Q8Ot4VdTkeSWdG7bF2P0b7w56Kgb
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAzLzE2LzIwMjIgMTI6MTAgQU0sIEVsaSBDb2hlbiB3cm90ZToKPj4gRnJvbTogU2ktV2Vp
IExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE2
LCAyMDIyIDg6NTIgQU0KPj4gVG86IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+PiBDYzog
bXN0QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnOyBlcGVyZXptYUByZWRoYXQuY29tOyBhbW9yZW5vekByZWRo
YXQuY29tOwo+PiBsdml2aWVyQHJlZGhhdC5jb207IHNnYXJ6YXJlQHJlZGhhdC5jb207IFBhcmF2
IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJd
IHZkcGE6IEFkZCBzdXBwb3J0IGZvciBxdWVyeWluZyB2ZW5kb3Igc3RhdGlzdGljcwo+Pgo+Pgo+
Pgo+PiBPbiAzLzE1LzIwMjIgMjoxMCBBTSwgRWxpIENvaGVuIHdyb3RlOgo+Pgo+PiA8Li4uc25p
cC4uLj4KPj4KPj4+PiBTYXkgeW91IGdvdCBhIHZkcGEgbmV0IGRldmljZSBjcmVhdGVkIHdpdGgg
NCBkYXRhIHF1ZXVlIHBhaXJzIGFuZCBhCj4+Pj4gY29udHJvbCB2cS4gT24gYm9vdCBzb21lIGd1
ZXN0IGZpcm13YXJlIG1heSBzdXBwb3J0IGp1c3QgRl9DVFJMX1ZRIGJ1dAo+Pj4+IG5vdCBGX01R
LCB0aGVuIHRoZSBpbmRleCBmb3IgdGhlIGNvbnRyb2wgdnEgaW4gZ3Vlc3QgZW5kcyB1cCB3aXRo
IDIsIGFzCj4+Pj4gaW4gdGhpcyBjYXNlIHRoZXJlJ3Mgb25seSBhIHNpbmdsZSBxdWV1ZSBwYWly
IGVuYWJsZWQgZm9yIHJ4IChpbmRleCAwKQo+Pj4+IGFuZCB0eCAoaW5kZXggMSkuIEZyb20gdGhl
IGhvc3QgZHJpdmVyIChlLmcuIG1seDVfdmRwYSkgcGVyc3BlY3RpdmUsIHRoZQo+Pj4+IGNvbnRy
b2wgdnEgaXMgdGhlIGxhc3QgdnEgZm9sbG93aW5nIDgKPj4+IElmIHRoZSBob3N0IHNlZXMgRl9N
USB3YXMgbm90IG5lZ290aWF0ZWQgYnV0IEZfQ1RSTF9WUSB3YXMsIHRoZW4gaXQga25vd3MKPj4+
IHRoYXQgY29udHJvbCBWUSBpbmRleCBpcyAyCj4+IFJpZ2h0LCBidXQgSSBkb24ndCBzZWUgdGhp
cyBmZWF0dXJlIG5lZ290aWF0aW9uIGluZm8gZ2V0dGluZyByZXR1cm5lZAo+PiBmcm9tIHlvdXIg
dmRwYV9kZXZfdmVuZG9yX3N0YXRzX2ZpbGwoKSwgb3IgZGlkIEkgbWlzcyBzb21ldGhpbmc/IEhv
dyBkbwo+PiB5b3UgcGxhbiBmb3IgaG9zdCB1c2VyIHRvIGdldCB0aGlzIGluZm8/IElmIHlvdSBt
ZWFudCBhbm90aGVyICJ2ZHBhIGRldgo+PiBzaG93IiBjb21tYW5kIHRvIHF1ZXJ5IG5lZ290aWF0
ZWQgZmVhdHVyZXMgYWhlYWQsIHRoaXMgd29uJ3QgZ2V0IHRoZQo+PiBzYW1lIGxvY2sgcHJvdGVj
dGVkIGFzIHRoZSB0aW1lIHlvdSBydW4gdGhlIHN0YXQgcXVlcnkuIEl0J3MgdmVyeSBlYXN5Cj4+
IHRvIG1pc3MgdGhhdCBlcGhlbWVyYWwgcXVldWUgaW5kZXguCj4gUmlnaHQsIHNvIEkgc3VnZ2Vz
dGVkIHRvIGluY2x1ZGUgdGhlIG5lZ290aWF0ZWQgZmVhdHVyZXMgaW4gdGhlIG5ldGxpbmsgbWVz
c2FnZQo+IGZvciB0aGUgc3RhdGlzdGljcy4gVGhhdCB3b3VsZCBzYXZlIHVzIGZyb20gdXNpbmcg
dHdvIHN5c3RlbSBjYWxscyB0byBnZXQgdGhlCj4gaW5mb3JtYXRpb24gcmVxdWlyZWQgYW5kIGl0
IGFuc3dlcnMgeW91ciBjb25jZXJuIHdpdGggcmVzcGVjdCB0byBsb2NraW5nLgo+IEkgdGhpbmsg
SmFzb24gd2FzIHJlbHVjdGFudCB0byBhZGRpbmcgdGhpcyBhdHRyaWJ1dGUgdG8gdGhlIG1lc3Nh
Z2UgYnV0IGNhbid0Cj4gZmluZCB3aGVyZSBoZSBleHBsYWluZWQgdGhlIHJlYXNvbmluZy4KTWF5
YmUgSmFzb24gY2FuIGNsYXJpZnkgYW5kIGNvcnJlY3QgbWUsIGJ1dCBJIGp1c3QgZGlkIG5vdCBn
ZXQgdGhlIHNhbWUgCmltcHJlc3Npb24gYXMgd2hhdCB5b3Ugc2FpZD8gSSBqdXN0IHNraW1tZWQg
dGhyb3VnaCBhbGwgb2YgdGhlIGVtYWlscyBpbiAKdGhlIHRocmVhZCwgb25seSBmaW5kaW5nIHRo
YXQgaGUgZGlkbid0IHdhbnQgZGV2aWNlIHNwZWNpZmljIGF0dHJpYnV0ZSAKc3VjaCBhcyBxdWV1
ZSB0eXBlIHRvIGdldCByZXR1cm5lZCBieSB0aGUgdmRwYSBjb3JlLCB3aGljaCBJIGFncmVlLiBJ
J20gCm5vdCBzdXJlIGlmIGhlJ3MgZXhwbGljaXRseSBhZ2FpbnN0IHBpZ2d5YmFjayBuZWdvdGlh
dGVkIGZlYXR1cmVzIHRvIGFpZCAKdXNlcnNwYWNlIHBhcnNpbmcgdGhlIGluZGV4LgoKQW5vdGhl
ciB3YXkgYXJvdW5kLCB2ZHBhIHRvb2wgbWF5IHBhc3MgZG93biAtMSB0byBnZXRfdnFfdnN0YXQo
KSB0byAKcmVwcmVzZW50IHRoZSBxdWV1ZSBpbmRleCBmb3IgdGhlIGNvbnRyb2wgcXVldWUgLSBi
dXQgdGhhdCdzIGxlc3MgCmZhdm9yYWJsZSBhcyB0aGUgdmRwYSBjb3JlIG5lZWRzIHRvIG1haW50
YWluIGRldmljZSBzcGVjaWZpYyBrbm93bGVkZ2UuCgoKCj4KPj4+PiBkYXRhIHZxcyBvZiBhbGwg
NCBwYWlycywgaGVuY2UgZ290Cj4+Pj4gdGhlIDh0aCBpbmRleCBpbiB0aGUgcmFuay4gU2luY2Ug
Rl9NUSBpcyBub3QgbmVnb3RpYXRlZCBhbmQgb25seSAxIGRhdGEKPj4+PiBxdWV1ZSBwYWlyIGVu
YWJsZWQsIGluIHN1Y2ggZXZlbnQgb25seSBob3N0IHFpbmRleCAwLDEgYW5kIDggaGF2ZSB2ZW5k
b3IKPj4+PiBzdGF0cyBhdmFpbGFibGUsIGFuZCB0aGUgcmVzdCBvZiBxaW5kZXggd291bGQgZ2V0
IGludmFsaWQvZW1wdHkgc3RhdC4KPj4+Pgo+Pj4+IExhdGVyIG9uIHNheSBib290IGNvbnRpbnVl
cyB0b3dhcmRzIGxvYWRpbmcgdGhlIExpbnV4IHZpcnRpbyBkcml2ZXIsCj4+Pj4gdGhlbiBndWVz
dCBjb3VsZCBzdWNjZXNzZnVsbHkgbmVnb3RpYXRlIGJvdGggRl9DVFJMX1ZRIGFuZCBGX01RCj4+
Pj4gZmVhdHVyZXMuIEluIHRoaXMgY2FzZSwgYWxsIDggZGF0YSB2aXJ0cXVldWVzIGFyZSBmdWxs
eSBlbmFibGVkLCB0aGUKPj4+PiBpbmRleCBmb3IgdGhlIGNvbnRyb2wgdnEgZW5kcyB1cCBhcyA4
LCBmb2xsb3dpbmcgdGlnaHRseSBhZnRlciBhbGwgdGhlIDQKPj4+PiBkYXRhIHF1ZXVlIHBhaXJz
LiBPbmx5IHVudGlsIGJvdGggZmVhdHVyZXMgYXJlIG5lZ290aWF0ZWQsIHRoZSBndWVzdCBhbmQK
Pj4+PiBob3N0IGFyZSBhYmxlIHRvIHNlZSBjb25zaXN0ZW50IHZpZXcgaW4gaWRlbnRpZnlpbmcg
dGhlIGNvbnRyb2wgdnEuCj4+Pj4gU2luY2UgRl9NUSBpcyBuZWdvdGlhdGVkLCBhbGwgaG9zdCBx
dWV1ZXMsIGluZGV4ZWQgZnJvbSAwIHRocm91Z2ggOCwKPj4+PiBzaG91bGQgaGF2ZSB2ZW5kb3Ig
c3RhdHMgYXZhaWxhYmxlLgo+Pj4+Cj4+Pj4gVGhhdCdzIHdoeSBJIHNhaWQgdGhlIGd1ZXN0IHFp
bmRleCBpcyBlcGhlbWVyYWwgYW5kIGhhcmQgdG8gcHJlZGljdAo+Pj4+IHN1YmplY3RlZCB0byBu
ZWdvdGlhdGVkIGZlYXR1cmVzLCBidXQgaG9zdCBxaW5kZXggaXMgcmVsaWFibGUgYW5kIG1vcmUK
Pj4+PiBlbGlnaWJsZSBmb3IgY29tbWFuZCBsaW5lIGlkZW50aWZpY2F0aW9uIHB1cnBvc2UuCj4+
Pj4KPj4gPC4uLnNuaXAuLi4+Cj4+Pj4+IFNvIHdoYXQgYXJlIHlvdSBhY3R1YWxseSBwcm9wb3Np
bmc/IERpc3BsYXkgcmVjZWl2ZWQgYW5kIGNvbXBsZXRlZCBkZXNjcmlwdG9ycwo+Pj4+PiBwZXIg
cXVldWUgaW5kZXggd2l0aG91dCBmdXJ0aGVyIGludGVycHJldGF0aW9uPwo+Pj4+IEknZCBzdWdn
ZXN0IHVzaW5nIGEgbW9yZSBzdGFibGUgcXVldWUgaWQgaS5lLiB0aGUgaG9zdCBxdWV1ZSBpbmRl
eCB0bwo+Pj4+IHJlcHJlc2VudCB0aGUgcWlkeCAod2hpY2ggc2VlbXMgdG8gYmUgd2hhdCB5b3Un
cmUgZG9pbmcgbm93PyksIGFuZAo+Pj4+IGRpc3BsYXlpbmcgYm90aCB0aGUgaG9zdCBxaW5kZXgg
KHF1ZXVlX2luZGV4X2RldmljZSBpbiB0aGUgZXhhbXBsZQo+Pj4+IGJlbG93KSwgYXMgd2VsbCBh
cyB0aGUgZ3Vlc3QncyAocXVldWVfaW5kZXhfZHJpdmVyIGFzIGJlbG93KSBpbiB0aGUgb3V0cHV0
Ogo+Pj4+Cj4+PiBHaXZlbiB0aGF0IHBlciB2ZHBhIGRldmljZSB5b3UgY2FuIGRpc3BsYXkgc3Rh
dGlzdGljcyBvbmx5IGFmdGVyIGZlYXR1cmVzIGhhdmUKPj4+IGJlZW4gbmVnb3RpYXRlZCwgeW91
IGNhbiBhbHdheXMga25vdyB0aGUgY29ycmVjdCBxdWV1ZSBpbmRleCBmb3IgdGhlIGNvbnRyb2wK
Pj4+IFZRLgo+PiBUaGUgc3RhdHMgY2FuIGJlIGRpc3BsYXllZCBvbmx5IGFmdGVyIGZlYXR1cmVz
IGFyZSBuZWdvdGlhdGVkLCBhbmQgb25seQo+PiB3aGVuIHRoZSBjb3JyZXNwb25kaW5nIHF1ZXVl
IGlzIGVuYWJsZWQuIElmIHlvdSBrbm93IGl0IGZyb20gInZkcGEgZGV2Cj4+IHNob3ciIG9uIGRh
eSAxIHRoYXQgdGhlIGNvbnRyb2wgdnEgYW5kIG1xIGZlYXR1cmVzIGFyZSBuZWdvdGlhdGVkLCBi
dXQKPj4gdGhlbiBvbiBkYXkyIHlvdSBnb3Qgbm90aGluZyBmb3IgdGhlIHByZWRpY3RlZCBjb250
cm9sIHZxIGluZGV4LCB3aGF0Cj4+IHdvdWxkIHlvdSByZWNvbW1lbmQgdGhlIGhvc3QgYWRtaW4g
dG8gZG8gdG8gZ2V0IHRoZSByaWdodCBxaW5kZXggYWdhaW4/Cj4+IFJlLXJ1biB0aGUgc3RhdCBx
dWVyeSBvbiB0aGUgc2FtZSBxdWV1ZSBpbmRleCwgb3IgY2hlY2sgdGhlICJ2ZHBhIGRldgo+PiBz
aG93IiBvdXRwdXQgYWdhaW4gb24gZGF5IDM/IFRoaXMgQ0xJIGRlc2lnbiBtYWtlcyBjbG91ZCBh
ZG1pbmlzdHJhdG9yCj4+IHJlYWxseSBjaGFsbGVuZ2luZyB0byBmb2xsb3cgdGhlIGR5bmFtaWNz
IG9mIGd1ZXN0IGFjdGl2aXRpZXMgd2VyZSB0bwo+PiBtYW5hZ2UgaHVuZHJlZHMgb3IgdGhvdXNh
bmRzIG9mIHZpcnR1YWwgbWFjaGluZXMuLi4KPj4KPj4gSXQgd291bGQgYmUgZWFzaWVyLCBpbiBt
eSBvcGluaW9uLCB0byBncmFzcCBzb21lIHdlbGwtZGVmaW5lZCBoYW5kbGUKPj4gdGhhdCBpcyBl
YXNpbHkgcHJlZGljdGFibGUgb3IgZml4ZWQgYWNyb3NzIHRoZSBib2FyZCwgZm9yIGxvb2tpbmcg
dXAgdGhlCj4+IGNvbnRyb2wgdmlydHF1ZXVlLiBUaGlzIGNvdWxkIGJlIGEgY29uc3RhbnQgaG9z
dCBxdWV1ZSBpbmRleCwgb3IgYQo+PiBzcGVjaWFsIG1hZ2ljIGtleXdvcmQgbGlrZSAicWlkeCBj
dHJsdnEiLiBJZiBjbG91ZCBhZG1pbiBydW5zIHZzdGF0Cj4+IHF1ZXJ5IG9uIHRoZSBjb250cm9s
IHZxIHVzaW5nIGEgZGV0ZXJtaW5lZCBoYW5kbGUgYnV0IGdldCBub3RoaW5nIGJhY2ssCj4+IHRo
ZW4gcy9oZSBrbm93cyAqZm9yIHN1cmUqIHRoZSBjb250cm9sIHZxIHdhcyBub3QgYXZhaWxhYmxl
IGZvciBzb21lCj4+IHJlYXNvbiBhdCB0aGUgcG9pbnQgd2hlbiB0aGUgc3RhdCB3YXMgYmVpbmcg
Y29sbGVjdGVkLiBTL2hlIGRvZXNuJ3QgZXZlbgo+PiBuZWVkIHRvIGNhcmUgbmVnb3RpYXRlZCBz
dGF0dXMgdmlhICJ2ZHBhIGRldiBzaG93IiBhdCBhbGwuIFdoeSBib3RoZXI/Cj4gU28sIHBlciBt
eSBzdWdnZXN0aW9uIGFib3ZlLCBwYXNzaW5nIHRoZSBuZWdvdGlhdGVkIGF0dHJpYnV0ZSBpbiB0
aGUgbmV0bGluawo+IG1lc3NhZ2Ugd291bGQgc2F0aXNmeSB0aGUgcmVxdWlyZW1lbnRzIGZvciBh
dG9taWNpdHksIHJpZ2h0PwpZZXMsIGl0IHNhdGlzZmllZCB0aGUgYXRvbWljaXR5IHJlcXVpcmVt
ZW50LCB0aG91Z2ggbm90IHN1cmUgaG93IHlvdSAKd2FudCB0byByZXByZXNlbnQgdGhlIHF1ZXVl
IGluZGV4IGZvciBjb250cm9sIHZxPyBCYXNpY2FsbHkgaWYgY2xvdWQgCmFkbWluIHdhbnRzIHRv
IGR1bXAgY29udHJvbCBxdWV1ZSBzdGF0cyBleHBsaWNpdGx5IHdpdGggYSBmaXhlZCBoYW5kbGUg
Cm9yIGlkZW50aWZpZXIsIGhvdyB0aGF0IGNhbiBiZSBkb25lIHdpdGggdGhlIG5lZ290aWF0ZWQg
YXR0cmlidXRlPwoKVGhhbmtzLAotU2l3ZWkKPgo+Pj4gRG8geW91IHN0aWxsIGhvbGQgc2VlIHlv
dXIgcHJvcG9zYWwgcmVxdWlyZWQ/Cj4+IFllcywgdGhpcyBpcyBlc3NlbnRpYWwgdG8gYW55IGNs
b3VkIGFkbWluIHRoYXQgcnVucyBzdGF0IHF1ZXJ5IG9uIGFsbCBvZgo+PiB0aGUgcXVldWVzIG9u
IHBlcmlvZGljIGJhc2lzLiBZb3UnZCBnZXQgc29tZSBkZXRlcm1pbmlzdGljIHdpdGhvdXQKPj4g
YmxpbmRseSBndWVzc2luZyBvciBib3RoZXJpbmcgb3RoZXIgaXJyZWxldmFudCBjb21tYW5kLgo+
Pgo+Pgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pj4+ICQgdmRwYSAtanAgZGV2IHZzdGF0cyBzaG93
IHZkcGEtYSBxaWR4IDgKPj4+PiB7Cj4+Pj4gICAgwqDCoMKgICJ2c3RhdHMiOiB7Cj4+Pj4gICAg
wqDCoMKgwqDCoMKgwqAgInZkcGEtYSI6IHsKPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJxdWV1ZV9zdGF0cyI6IFt7Cj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJxdWV1ZV9pbmRleF9kZXZpY2UiOiA4LAo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAicXVldWVfaW5kZXhfZHJpdmVyIjogMiwKPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgInF1ZXVlX3R5cGUiOiAiY29udHJvbF92cSIsCj4+Pj4gICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJzdGF0X25hbWUiOiBbICJyZWNlaXZlZF9kZXNjIiwi
Y29tcGxldGVkX2Rlc2MiIF0sCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJzdGF0X3ZhbHVlIjogWyA0MTc3NzYsNDE3Nzc1IF0sCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9XQo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgIH0KPj4+PiAgICDCoMKgwqAgfQo+Pj4+
IH0KPj4+Pgo+Pj4+IE9wdGlvbmFsbHksIHVzZXIgbWF5IHVzZSBndWVzdCBxdWV1ZSBpbmRleCBn
cWlkeCwgd2hpY2ggaXMga2luZCBvZiBhbgo+Pj4+IGVwaGVtZXJhbCBJRCBhbmQgRl9NUSBuZWdv
dGlhdGlvbiBkZXBlbmRlZCwgdG8gcXVlcnkgdGhlIHN0YXQgb24gYQo+Pj4+IHNwZWNpZmljIGd1
ZXN0IHF1ZXVlOgo+Pj4+Cj4+Pj4gJCB2ZHBhIC1qcCBkZXYgdnN0YXRzIHNob3cgdmRwYS1hIGdx
aWR4IDIKPj4+PiB7Cj4+Pj4gICAgwqDCoMKgICJ2c3RhdHMiOiB7Cj4+Pj4gICAgwqDCoMKgwqDC
oMKgwqAgInZkcGEtYSI6IHsKPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJxdWV1ZV9z
dGF0cyI6IFt7Cj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJxdWV1ZV9p
bmRleF9kZXZpY2UiOiA4LAo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
cXVldWVfaW5kZXhfZHJpdmVyIjogMiwKPj4+PiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgInF1ZXVlX3R5cGUiOiAiY29udHJvbF92cSIsCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJzdGF0X25hbWUiOiBbICJyZWNlaXZlZF9kZXNjIiwiY29tcGxldGVk
X2Rlc2MiIF0sCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJzdGF0X3Zh
bHVlIjogWyA0MTc3NzYsNDE3Nzc1IF0sCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9
XQo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgIH0KPj4+PiAgICDCoMKgwqAgfQo+Pj4+IH0KPj4+Pgo+
Pj4+IFRoYW5rcywKPj4+PiAtU2l3ZWkKPj4+Pgo+Pj4+Pj4gVGhhbmtzLAo+Pj4+Pj4gLVNpd2Vp
Cj4+Pj4+Pgo+Pj4+Pj4+PiBSZWdhcmRzLAo+Pj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+IExvb2tzIHRvIG1lIHRoZXJlIGFyZSBzdGlsbCBzb21lIGxvb3NlIGVuZCBJIGRvbid0
IHF1aXRlIHlldAo+Pj4+Pj4+Pj4+Pj4gdW5kZXJzdGFuZC4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAicXVldWVfaW5kZXgiOiAw
LAo+Pj4+Pj4+Pj4+PiBJIHRoaW5rIHRoaXMgY2FuIGJlIHJlbW92ZWQgc2luY2UgdGhlIGNvbW1h
bmQgaXMgZm9yIGEgc3BlY2lmaWMgaW5kZXguCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICJuYW1lIjogInJlY2VpdmVkX2Rlc2MiLAo+Pj4+Pj4+Pj4+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAidmFsdWUiOiA0MTc3NzYsCj4+Pj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICJuYW1lIjogImNvbXBsZXRlZF9kZXNjIiwKPj4+Pj4+Pj4+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgInZhbHVlIjogNDE3NTQ4Cj4+Pj4+Pj4+Pj4+Pj4+IE5v
dCBmb3IgdGhpcyBrZXJuZWwgcGF0Y2gsIGJ1dCBJTUhPIGl0J3MgdGhlIGJlc3QgdG8gcHV0IHRo
ZSBuYW1lCj4+Pj4+Pj4+Pj4+Pj4+ICYgdmFsdWUgcGFpcnMgaW4gYW4gYXJyYXkgaW5zdGVhZCBv
ZiBmbGF0IGVudHJpZXMgaW4ganNvbidzCj4+Pj4+Pj4+Pj4+Pj4+IGhhc2gvZGljdGlvbmFyeS4g
VGhlIGhhc2ggZW50cmllcyBjYW4gYmUgcmUtb3JkZXJlZCBkZWxpYmVyYXRlbHkKPj4+Pj4+Pj4+
Pj4+Pj4gYnkgZXh0ZXJuYWwganNvbiBwYXJzaW5nIHRvb2wsIGVuZGluZyB1cCB3aXRoIGluY29u
c2lzdGVudCBzdGF0IHZhbHVlcy4KPj4+Pj4+Pj4+Pj4+IFRoaXMgY29tbWVudCBpcyBtaXNzZWQg
Zm9yIHNvbWUgcmVhc29uLiBQbGVhc2UgY2hhbmdlIHRoZSBleGFtcGxlCj4+Pj4+Pj4+Pj4+PiBp
biB0aGUgbG9nIGlmIHlvdSBhZ3JlZSB0byBhZGRyZXNzIGl0IGluIHZkcGEgdG9vbC4gT3IganVz
dGlmeSB3aHkKPj4+Pj4+Pj4+Pj4+IGtlZXBpbmcgdGhlIG9yZGVyIGZvciBqc29uIGhhc2gvZGlj
dGlvbmFyeSBpcyBmaW5lLgo+Pj4+Pj4+Pj4+PiBTb3JyeSBmb3Igc2tpcHBpbmcgdGhpcyBjb21t
ZW50Lgo+Pj4+Pj4+Pj4+PiBEbyB5b3UgbWVhbiB0byBwcmVzZW50IHRoZSBpbmZvcm1hdGlvbiBs
aWtlOgo+Pj4+Pj4+Pj4+PiAicmVjZWl2ZWRfZGVzYyI6IDQxNzc3NiwKPj4+Pj4+Pj4+Pj4gImNv
bXBsZXRlZF9kZXNjIjogNDE3NTQ4LAo+Pj4+Pj4+Pj4+IEkgbWVhbiB0aGUgZm9sbG93aW5nIHBy
ZXNlbnRhdGlvbjoKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+ICQgdmRwYSAtanAgZGV2IHZzdGF0cyBz
aG93IHZkcGEtYSBxaWR4IDAgewo+Pj4+Pj4+Pj4+ICAgICAgICAgICAidnN0YXRzIjogewo+Pj4+
Pj4+Pj4+ICAgICAgICAgICAgICAgInZkcGEtYSI6IHsKPj4+Pj4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAicXVldWVfc3RhdHMiOiBbewo+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAi
cXVldWVfaW5kZXgiOiAwLAo+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAicXVldWVf
dHlwZSI6ICJyeCIsCj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICJzdGF0X25hbWUi
OiBbICJyZWNlaXZlZF9kZXNjIiwiY29tcGxldGVkX2Rlc2MiIF0sCj4+Pj4+Pj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICJzdGF0X3ZhbHVlIjogWyA0MTc3NzYsNDE3NTQ4IF0sCj4+Pj4+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgfV0KPj4+Pj4+Pj4+PiAgICAgICAgICAgICAgIH0KPj4+Pj4+
Pj4+PiAgICAgICAgICAgfQo+Pj4+Pj4+Pj4+IH0KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEkgdGhp
bmsgUGFyYXYgaGFkIHNpbWlsYXIgc3VnZ2VzdGlvbiwgdG9vLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4gVGhhbmtzLAo+Pj4+Pj4+Pj4+IC1TaXdlaQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBUaGFu
a3MsCj4+Pj4+Pj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IFRoYW5r
cywKPj4+Pj4+Pj4+Pj4+Pj4gLVNpd2VpCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAg
fQo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgfQo+Pj4+Pj4+Pj4+Pj4+Pj4gfQo+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgo+Pj4+Pj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICBk
cml2ZXJzL3ZkcGEvdmRwYS5jICAgICAgIHwgMTI5Cj4+Pj4+Pj4+Pj4+PiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgaW5jbHVk
ZS9saW51eC92ZHBhLmggICAgICB8ICAgNSArKwo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgaW5j
bHVkZS91YXBpL2xpbnV4L3ZkcGEuaCB8ICAgNyArKysKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAg
IDMgZmlsZXMgY2hhbmdlZCwgMTQxIGluc2VydGlvbnMoKykKPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRw
YS92ZHBhLmMgaW5kZXgKPj4+Pj4+Pj4+Pj4+Pj4+IDk4NDZjOWRlNGJmYS4uZDBmZjY3MWJhZjg4
IDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+
Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+Pj4+Pj4+Pj4gQEAgLTkw
OSw2ICs5MDksNzQgQEAgdmRwYV9kZXZfY29uZmlnX2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlCj4+
Pj4+Pj4+Pj4+Pj4+PiAqdmRldiwKPj4+Pj4+Pj4+Pj4+IHN0cnVjdCBza19idWZmICptc2csIHUz
MiBwb3J0aWQsCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJcmV0dXJuIGVycjsKPj4+Pj4+Pj4+
Pj4+Pj4+ICAgICAgICAgIH0KPj4+Pj4+Pj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHZkcGFfZmlsbF9z
dGF0c19yZWMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3QKPj4+Pj4+Pj4+Pj4+Pj4+
ICtza19idWZmCj4+Pj4+Pj4+Pj4+PiAqbXNnLAo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJCSAgICAgICBz
dHJ1Y3QgZ2VubF9pbmZvICppbmZvLCB1MzIgaW5kZXgpIHsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaW50
IGVycjsKPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaWYgKG5sYV9wdXRfdTMy
KG1zZywgVkRQQV9BVFRSX0RFVl9RVUVVRV9JTkRFWCwgaW5kZXgpKQo+Pj4+Pj4+Pj4+Pj4+Pj4g
KwkJcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJ
ZXJyID0gdmRldi0+Y29uZmlnLT5nZXRfdmVuZG9yX3ZxX3N0YXRzKHZkZXYsIGluZGV4LCBtc2cs
Cj4+Pj4+Pj4+Pj4+Pj4+PiAraW5mby0KPj4+Pj4+Pj4+Pj4+PiBleHRhY2spOwo+Pj4+Pj4+Pj4+
Pj4+Pj4gKwlpZiAoZXJyKQo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJcmV0dXJuIGVycjsKPj4+Pj4+Pj4+
Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJcmV0dXJuIDA7Cj4+Pj4+Pj4+Pj4+Pj4+PiArfQo+
Pj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmVuZG9yX3N0YXRz
X2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3QKPj4+Pj4+Pj4+Pj4+Pj4+ICtz
a19idWZmCj4+Pj4+Pj4+Pj4gKm1zZywKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCQkgICAgIHN0cnVjdCBn
ZW5sX2luZm8gKmluZm8sIHUzMiBpbmRleCkgewo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlpbnQgZXJyOwo+
Pj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlpZiAoIXZkZXYtPmNvbmZpZy0+Z2V0
X3ZlbmRvcl92cV9zdGF0cykKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsK
Pj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJZXJyID0gdmRwYV9maWxsX3N0YXRz
X3JlYyh2ZGV2LCBtc2csIGluZm8sIGluZGV4KTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaWYgKGVycikK
Pj4+Pj4+Pj4+Pj4+Pj4+ICsJCXJldHVybiBlcnI7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+
Pj4+Pj4+PiArCXJldHVybiAwOwo+Pj4+Pj4+Pj4+Pj4+Pj4gK30KPj4+Pj4+Pj4+Pj4+Pj4+ICsK
Pj4+Pj4+Pj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHZkcGFfZGV2X3ZlbmRvcl9zdGF0c19maWxsKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCQkJICAgICAgc3RydWN0
IHNrX2J1ZmYgKm1zZywKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCQkJICAgICAgc3RydWN0IGdlbmxfaW5m
byAqaW5mbywgdTMyIGluZGV4KSB7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCXUzMiBkZXZpY2VfaWQ7Cj4+
Pj4+Pj4+Pj4+Pj4+PiArCXZvaWQgKmhkcjsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaW50IGVycjsKPj4+
Pj4+Pj4+Pj4+Pj4+ICsJdTMyIHBvcnRpZCA9IGluZm8tPnNuZF9wb3J0aWQ7Cj4+Pj4+Pj4+Pj4+
Pj4+PiArCXUzMiBzZXEgPSBpbmZvLT5zbmRfc2VxOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwl1MzIgZmxh
Z3MgPSAwOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwloZHIgPSBnZW5sbXNn
X3B1dChtc2csIHBvcnRpZCwgc2VxLCAmdmRwYV9ubF9mYW1pbHksIGZsYWdzLAo+Pj4+Pj4+Pj4+
Pj4+Pj4gKwkJCSAgVkRQQV9DTURfREVWX1ZTVEFUU19HRVQpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlp
ZiAoIWhkcikKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+Pj4+
Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArCWlmIChubGFfcHV0X3N0cmluZyhtc2csIFZEUEFfQVRU
Ul9ERVZfTkFNRSwKPj4+Pj4+Pj4gZGV2X25hbWUoJnZkZXYtCj4+Pj4+Pj4+Pj4+Pj4gZGV2KSkp
IHsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCWVyciA9IC1FTVNHU0laRTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJ
CWdvdG8gdW5kb19tc2c7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCX0KPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+
Pj4+Pj4+Pj4+Pj4+ICsJZGV2aWNlX2lkID0gdmRldi0+Y29uZmlnLT5nZXRfZGV2aWNlX2lkKHZk
ZXYpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlpZiAobmxhX3B1dF91MzIobXNnLCBWRFBBX0FUVFJfREVW
X0lELCBkZXZpY2VfaWQpKSB7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCQllcnIgPSAtRU1TR1NJWkU7Cj4+
Pj4+Pj4+Pj4+Pj4+PiArCQlnb3RvIHVuZG9fbXNnOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwl9Cj4+Pj4+
Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArCWVyciA9IHZlbmRvcl9zdGF0c19maWxsKHZk
ZXYsIG1zZywgaW5mbywgaW5kZXgpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+Pj4g
KwlnZW5sbXNnX2VuZChtc2csIGhkcik7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+
PiArCXJldHVybiBlcnI7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArdW5kb19t
c2c6Cj4+Pj4+Pj4+Pj4+Pj4+PiArCWdlbmxtc2dfY2FuY2VsKG1zZywgaGRyKTsKPj4+Pj4+Pj4+
Pj4+Pj4+ICsJcmV0dXJuIGVycjsKPj4+Pj4+Pj4+Pj4+Pj4+ICt9Cj4+Pj4+Pj4+Pj4+Pj4+PiAr
Cj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9jb25m
aWdfZ2V0X2RvaXQoc3RydWN0IHNrX2J1ZmYKPj4+Pj4+Pj4+Pj4+Pj4+ICpza2IsIHN0cnVjdAo+
Pj4+Pj4+Pj4+Pj4gZ2VubF9pbmZvICppbmZvKQo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgewo+
Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRldjsKPj4+Pj4+
Pj4+Pj4+Pj4+IEBAIC05OTAsNiArMTA1OCw2MCBAQAo+Pj4+Pj4+PiB2ZHBhX25sX2NtZF9kZXZf
Y29uZmlnX2dldF9kdW1waXQoc3RydWN0Cj4+Pj4+Pj4+Pj4+PiBza19idWZmICptc2csIHN0cnVj
dCBuZXRsaW5rX2NhbGxiYWNrICoKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIAlyZXR1cm4gbXNn
LT5sZW47Cj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICB9Cj4+Pj4+Pj4+Pj4+Pj4+PiArc3RhdGlj
IGludCB2ZHBhX25sX2NtZF9kZXZfc3RhdHNfZ2V0X2RvaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwK
Pj4+Pj4+Pj4+Pj4+Pj4+ICsJCQkJCSAgc3RydWN0IGdlbmxfaW5mbyAqaW5mbykKPj4+Pj4+Pj4+
Pj4+Pj4+ICt7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRldjsKPj4+
Pj4+Pj4+Pj4+Pj4+ICsJc3RydWN0IHNrX2J1ZmYgKm1zZzsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJY29u
c3QgY2hhciAqZGV2bmFtZTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJc3RydWN0IGRldmljZSAqZGV2Owo+
Pj4+Pj4+Pj4+Pj4+Pj4gKwl1MzIgaW5kZXg7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCWludCBlcnI7Cj4+
Pj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArCWlmICghaW5mby0+YXR0cnNbVkRQQV9B
VFRSX0RFVl9OQU1FXSkKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCXJldHVybiAtRUlOVkFMOwo+Pj4+Pj4+
Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlpZiAoIWluZm8tPmF0dHJzW1ZEUEFfQVRUUl9E
RVZfUVVFVUVfSU5ERVhdKQo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4+Pj4+
Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArCWRldm5hbWUgPSBubGFfZGF0YShpbmZvLT5h
dHRyc1tWRFBBX0FUVFJfREVWX05BTUVdKTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJbXNnID0gbmxtc2df
bmV3KE5MTVNHX0RFRkFVTFRfU0laRSwgR0ZQX0tFUk5FTCk7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCWlm
ICghbXNnKQo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4+Pj4+Pj4+Pj4+Pj4+
PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArCWluZGV4ID0gbmxhX2dldF91MzIoaW5mby0KPj4+Pj4+Pj4+
IGF0dHJzW1ZEUEFfQVRUUl9ERVZfUVVFVUVfSU5ERVhdKTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJbXV0
ZXhfbG9jaygmdmRwYV9kZXZfbXV0ZXgpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlkZXYgPSBidXNfZmlu
ZF9kZXZpY2UoJnZkcGFfYnVzLCBOVUxMLCBkZXZuYW1lLAo+Pj4+Pj4+Pj4+Pj4gdmRwYV9uYW1l
X21hdGNoKTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaWYgKCFkZXYpIHsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJ
CU5MX1NFVF9FUlJfTVNHX01PRChpbmZvLT5leHRhY2ssICJkZXZpY2Ugbm90Cj4+Pj4+Pj4+IGZv
dW5kIik7Cj4+Pj4+Pj4+Pj4+Pj4+PiArCQllcnIgPSAtRU5PREVWOwo+Pj4+Pj4+Pj4+Pj4+Pj4g
KwkJZ290byBkZXZfZXJyOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwl9Cj4+Pj4+Pj4+Pj4+Pj4+PiArCXZk
ZXYgPSBjb250YWluZXJfb2YoZGV2LCBzdHJ1Y3QgdmRwYV9kZXZpY2UsIGRldik7Cj4+Pj4+Pj4+
Pj4+Pj4+PiArCWlmICghdmRldi0+bWRldikgewo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJTkxfU0VUX0VS
Ul9NU0dfTU9EKGluZm8tPmV4dGFjaywgInVubWFuYWdlZAo+Pj4+Pj4+PiB2ZHBhCj4+Pj4+Pj4+
Pj4+PiBkZXZpY2UiKTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCWVyciA9IC1FSU5WQUw7Cj4+Pj4+Pj4+
Pj4+Pj4+PiArCQlnb3RvIG1kZXZfZXJyOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwl9Cj4+Pj4+Pj4+Pj4+
Pj4+PiArCWVyciA9IHZkcGFfZGV2X3ZlbmRvcl9zdGF0c19maWxsKHZkZXYsIG1zZywgaW5mbywg
aW5kZXgpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlpZiAoIWVycikKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCWVy
ciA9IGdlbmxtc2dfcmVwbHkobXNnLCBpbmZvKTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+
Pj4+Pj4+ICsJcHV0X2RldmljZShkZXYpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwltdXRleF91bmxvY2so
JnZkcGFfZGV2X211dGV4KTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaWYg
KGVycikKPj4+Pj4+Pj4+Pj4+Pj4+ICsJCW5sbXNnX2ZyZWUobXNnKTsKPj4+Pj4+Pj4+Pj4+Pj4+
ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJcmV0dXJuIGVycjsKPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+
Pj4+Pj4+Pj4+ICttZGV2X2VycjoKPj4+Pj4+Pj4+Pj4+Pj4+ICsJcHV0X2RldmljZShkZXYpOwo+
Pj4+Pj4+Pj4+Pj4+Pj4gK2Rldl9lcnI6Cj4+Pj4+Pj4+Pj4+Pj4+PiArCW11dGV4X3VubG9jaygm
dmRwYV9kZXZfbXV0ZXgpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlyZXR1cm4gZXJyOwo+Pj4+Pj4+Pj4+
Pj4+Pj4gK30KPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbmxhX3BvbGljeSB2ZHBhX25sX3BvbGljeVtWRFBBX0FUVFJfTUFYICsg
MV0KPj4+Pj4+Pj4gPSB7Cj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJW1ZEUEFfQVRUUl9NR01U
REVWX0JVU19OQU1FXSA9IHsgLnR5cGUgPQo+Pj4+Pj4+Pj4+IE5MQV9OVUxfU1RSSU5HIH0sCj4+
Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJW1ZEUEFfQVRUUl9NR01UREVWX0RFVl9OQU1FXSA9IHsg
LnR5cGUgPSBOTEFfU1RSSU5HCj4+Pj4+Pj4+Pj4gfSwgQEAgLQo+Pj4+Pj4+Pj4+Pj4gOTk3LDYK
Pj4+Pj4+Pj4+Pj4+Pj4+ICsxMTE5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBubGFfcG9saWN5
Cj4+Pj4+Pj4+Pj4+PiB2ZHBhX25sX3BvbGljeVtWRFBBX0FUVFJfTUFYICsgMV0gPSB7Cj4+Pj4+
Pj4+Pj4+Pj4+PiAgICAgICAgICAJW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSXSA9Cj4+
Pj4+Pj4+Pj4gTkxBX1BPTElDWV9FVEhfQUREUiwKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIAkv
KiB2aXJ0aW8gc3BlYyAxLjEgc2VjdGlvbiA1LjEuNC4xIGZvciB2YWxpZCBNVFUgcmFuZ2UgKi8K
Pj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIAlbVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVV0gPQo+
Pj4+Pj4+Pj4+IE5MQV9QT0xJQ1lfTUlOKE5MQV9VMTYsIDY4KSwKPj4+Pj4+Pj4+Pj4+Pj4+ICsJ
W1ZEUEFfQVRUUl9ERVZfUVVFVUVfSU5ERVhdID0KPj4+Pj4+Pj4gTkxBX1BPTElDWV9SQU5HRShO
TEFfVTMyLCAwLAo+Pj4+Pj4+Pj4+Pj4gNjU1MzUpLAo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAg
fTsKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZ2VubF9vcHMg
dmRwYV9ubF9vcHNbXSA9IHsgQEAgLTEwMzAsNgo+Pj4+Pj4+Pj4+Pj4+Pj4gKzExNTMsMTIgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBnZW5sX29wcyB2ZHBhX25sX29wc1tdID0gewo+Pj4+Pj4+Pj4+
Pj4+Pj4gICAgICAgICAgCQkuZG9pdCA9IHZkcGFfbmxfY21kX2Rldl9jb25maWdfZ2V0X2RvaXQs
Cj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJCS5kdW1waXQgPSB2ZHBhX25sX2NtZF9kZXZfY29u
ZmlnX2dldF9kdW1waXQsCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJfSwKPj4+Pj4+Pj4+Pj4+
Pj4+ICsJewo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJLmNtZCA9IFZEUEFfQ01EX0RFVl9WU1RBVFNfR0VU
LAo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJLnZhbGlkYXRlID0gR0VOTF9ET05UX1ZBTElEQVRFX1NUUklD
VCB8Cj4+Pj4+Pj4+Pj4+PiBHRU5MX0RPTlRfVkFMSURBVEVfRFVNUCwKPj4+Pj4+Pj4+Pj4+Pj4+
ICsJCS5kb2l0ID0gdmRwYV9ubF9jbWRfZGV2X3N0YXRzX2dldF9kb2l0LAo+Pj4+Pj4+Pj4+Pj4+
Pj4gKwkJLmZsYWdzID0gR0VOTF9BRE1JTl9QRVJNLAo+Pj4+Pj4+Pj4+Pj4+Pj4gKwl9LAo+Pj4+
Pj4+Pj4+Pj4+Pj4gICAgICAgICAgfTsKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIHN0YXRpYyBz
dHJ1Y3QgZ2VubF9mYW1pbHkgdmRwYV9ubF9mYW1pbHkgX19yb19hZnRlcl9pbml0ID0KPj4+Pj4+
Pj4+Pj4+Pj4+IHsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9s
aW51eC92ZHBhLmggaW5kZXgKPj4+Pj4+Pj4+Pj4+Pj4+IDJkZTQ0MmVjZWNhZS4uMjc0MjAzODQ1
Y2ZjIDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+
Pj4+Pj4+Pj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4+Pj4+Pj4+Pj4+PiBA
QCAtMjc1LDYgKzI3NSw5IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+Pj4+Pj4+Pj4+Pj4+
Pj4gICAgICAgICAgCQkJICAgIGNvbnN0IHN0cnVjdCB2ZHBhX3ZxX3N0YXRlICpzdGF0ZSk7Cj4+
Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJaW50ICgqZ2V0X3ZxX3N0YXRlKShzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkZXYsIHUxNiBpZHgsCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJCQkgICAgc3Ry
dWN0IHZkcGFfdnFfc3RhdGUgKnN0YXRlKTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsJaW50ICgqZ2V0X3Zl
bmRvcl92cV9zdGF0cykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAo+Pj4+Pj4+
Pj4+Pj4+Pj4gKwkJCQkgICBzdHJ1Y3Qgc2tfYnVmZiAqbXNnLAo+Pj4+Pj4+Pj4+Pj4+Pj4gKwkJ
CQkgICBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spOwo+Pj4+Pj4+Pj4+Pj4+Pj4gICAg
ICAgICAgCXN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAg
ICAgICAJKCpnZXRfdnFfbm90aWZpY2F0aW9uKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUx
NiBpZHgpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgCS8qIHZxIGlycSBpcyBub3QgZXhwZWN0
ZWQgdG8gYmUgY2hhbmdlZCBvbmNlIERSSVZFUl9PSyBpcwo+Pj4+Pj4+Pj4+Pj4+Pj4gc2V0ICov
IEBAIC00NjYsNCArNDY5LDYgQEAgc3RydWN0IHZkcGFfbWdtdF9kZXYgewo+Pj4+Pj4+Pj4+Pj4+
Pj4gICAgICAgICAgaW50IHZkcGFfbWdtdGRldl9yZWdpc3RlcihzdHJ1Y3QgdmRwYV9tZ210X2Rl
diAqbWRldik7Cj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICB2b2lkIHZkcGFfbWdtdGRldl91bnJl
Z2lzdGVyKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2KTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsjZGVm
aW5lIFZEUEFfSU5WQUxfUVVFVUVfSU5ERVggMHhmZmZmCj4+Pj4+Pj4+Pj4+Pj4+PiArCj4+Pj4+
Pj4+Pj4+Pj4+PiAgICAgICAgICAjZW5kaWYgLyogX0xJTlVYX1ZEUEFfSCAqLwo+Pj4+Pj4+Pj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmgKPj4+Pj4+Pj4+Pj4+
Pj4+IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaCBpbmRleCAxMDYxZDhkMmQwOWQuLmM1ZjIy
OWE0MWRjMgo+Pj4+Pj4+Pj4+Pj4+Pj4gMTAwNjQ0Cj4+Pj4+Pj4+Pj4+Pj4+PiAtLS0gYS9pbmNs
dWRlL3VhcGkvbGludXgvdmRwYS5oCj4+Pj4+Pj4+Pj4+Pj4+PiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdmRwYS5oCj4+Pj4+Pj4+Pj4+Pj4+PiBAQCAtMTgsNiArMTgsNyBAQCBlbnVtIHZkcGFf
Y29tbWFuZCB7Cj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAJVkRQQV9DTURfREVWX0RFTCwKPj4+
Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIAlWRFBBX0NNRF9ERVZfR0VULAkJLyogY2FuIGR1bXAgKi8K
Pj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIAlWRFBBX0NNRF9ERVZfQ09ORklHX0dFVCwJLyogY2Fu
IGR1bXAgKi8KPj4+Pj4+Pj4+Pj4+Pj4+ICsJVkRQQV9DTURfREVWX1ZTVEFUU19HRVQsCj4+Pj4+
Pj4+Pj4+Pj4+PiAgICAgICAgICB9Owo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgZW51bSB2ZHBh
X2F0dHIgewo+Pj4+Pj4+Pj4+Pj4+Pj4gQEAgLTQ2LDYgKzQ3LDEyIEBAIGVudW0gdmRwYV9hdHRy
IHsKPj4+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIAlWRFBBX0FUVFJfREVWX05FR09USUFURURfRkVB
VFVSRVMsCS8qIHU2NCAqLwo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgCVZEUEFfQVRUUl9ERVZf
TUdNVERFVl9NQVhfVlFTLAkJLyoKPj4+Pj4+Pj4+PiB1MzIgKi8KPj4+Pj4+Pj4+Pj4+Pj4+ICAg
ICAgICAgIAlWRFBBX0FUVFJfREVWX1NVUFBPUlRFRF9GRUFUVVJFUywJLyogdTY0ICovCj4+Pj4+
Pj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4+Pj4+PiArCVZEUEFfQVRUUl9ERVZfUVVFVUVfSU5ERVgs
ICAgICAgICAgICAgICAvKiB1MTYgKi8KPj4+Pj4+Pj4+Pj4+Pj4+ICsJVkRQQV9BVFRSX0RFVl9R
VUVVRV9UWVBFLCAgICAgICAgICAgICAgIC8qIHN0cmluZyAqLwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwlW
RFBBX0FUVFJfREVWX1ZFTkRPUl9BVFRSX05BTUUsCQkvKgo+Pj4+Pj4+PiBzdHJpbmcgKi8KPj4+
Pj4+Pj4+Pj4+Pj4+ICsJVkRQQV9BVFRSX0RFVl9WRU5ET1JfQVRUUl9WQUxVRSwgICAgICAgIC8q
IHU2NCAqLwo+Pj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgCS8qIG5l
dyBhdHRyaWJ1dGVzIG11c3QgYmUgYWRkZWQgYWJvdmUgaGVyZSAqLwo+Pj4+Pj4+Pj4+Pj4+Pj4g
ICAgICAgICAgCVZEUEFfQVRUUl9NQVgsCj4+Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICB9OwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

