Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1199C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 00:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91EB94175B;
	Wed,  8 Jun 2022 00:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T2hoNX3H3dWK; Wed,  8 Jun 2022 00:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB1684173E;
	Wed,  8 Jun 2022 00:21:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FDD7C0032;
	Wed,  8 Jun 2022 00:21:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3C1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2779404A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="aUrOmX7s";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="arGthCa3"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id khxTYdcgnwVS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:21:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81B1D40199
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 00:21:43 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257Na3Hc014272;
 Wed, 8 Jun 2022 00:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nlX5JxMr0QUtnQE3u5nF1vbR81ILhNvu+8GWiQInLCw=;
 b=aUrOmX7s4UIOfvtAKgvXwDzfV7556khKtGEPanKcoFZ1NZ85ZlCgvFTUMttpR7QLmBJo
 7gxIZk93KqBxhTYudYI6tpaZ8OI3xkNfXstXeAxbeef+nA9P2TDlp0sR5TgKuXJa7bdD
 8fs1jn96yICMGyALdXsDOTxDjV46ZHmoq4HZiKAyAWapf78v0O2VaeR/3sVQErjEOCs2
 wBE1Dp4XmWpb2s/viLVkzvmDFKn3loso+XhruucXicwQYgSpnldNcc0cdH+Od3Y+ECNH
 P2WwXRayKdpQe+oVbaTA5EHzerzrrA/h8hE2mYIDQEZnno1YzHd4EIxEH2ifEDt/xxKw Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmwbkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Jun 2022 00:21:42 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2580GTY3017963; Wed, 8 Jun 2022 00:21:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gfwu30sch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Jun 2022 00:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POZQvQBuHiyDrIbnFAR7rorN6GDTu9nHJYZSK0snSQ+CH3jdyQLIXmW+q/8vK8oa/TLi8m8z7cIyEdrfZDEVcBoNSt5XmabiY20G3ynzY5GIxFIcpka3+6OwBCGpzay5GMKM+W3w9XncQOIs/mw3++N4dw3M3hTWwsdqLAAkyzqe8FbjSTpsoTELdY74YWooVzEWhaQSDxA9mu4zEvFTubXCUfB0PQhKRYJBbFMtZdx+YSMm2hPG8N6BsNCj0lZXkDxVc6EwBWBfLCHRdthl9deMAL4PlR6s6GOzw+/LZj7HdPQJJBFZoOs4JLYobiVQOhW2MhKmEdRWdPSflyUn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlX5JxMr0QUtnQE3u5nF1vbR81ILhNvu+8GWiQInLCw=;
 b=IQb55uzUUUY8KKv/DCbqilrn+Pv+DaAnVINTHpF0xEsHxsahnP5GTTkcdm0HwG90fZO+TZyVZnVSpCv+hwRcc3DwiZvQCyilbgYKNxe+5TS67g6Jdf3uVacGpPzJ4BqEPLnlKgaDyAAvAPht8teMU+H2A9+rvQrXnyD4YtRSas/9GD6W4+BE1/aPR6mQF5ApxgzUo3fA52eNnTcayYzbl1+5rov0zxpvCWXlH2a05Qt8XnoE5fVD4UMSiL2Udt+HTdfuQpJZyLatjktDOuR+rI7mobM2lvJS+Xo7QFR4TP8/TxTNE14ZUOxghZKAqLRIS4iq02dXVl5XeZIm3WU1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlX5JxMr0QUtnQE3u5nF1vbR81ILhNvu+8GWiQInLCw=;
 b=arGthCa3EQrKylclTNK8OSvLfmR6X3uEYNpZ54b/iTffZpCeI3WXTBXeFsE2iI1JaJ4J+Htp1UaqMlBmbofXxEUSxXhQ9Zk2VuaE1P20AfT/RsqcR/8O/yBPXd56K5uOTQDlTqsuaFG7yOdLtclRGN8Av+FpXfk2NxBYK2Oqnik=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 00:21:39 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 00:21:39 +0000
Message-ID: <1f0dd9ee-7929-3657-c743-9d077a8553fa@oracle.com>
Date: Tue, 7 Jun 2022 17:21:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] vdpa/mlx5: fix error code for deleting vlan
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <Yp709f1g9NcMBCHg@kili>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Yp709f1g9NcMBCHg@kili>
X-ClientProxiedBy: DM5PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:3:5d::11) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b67c167-e999-4e96-43b8-08da48e4daf5
X-MS-TrafficTypeDiagnostic: DS7PR10MB5056:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB505693B9B5ED932068D6B4A9B1A49@DS7PR10MB5056.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YU6YqAuh+Pv1y2sLTzqhAMEypVbBWHkG+siS318sO2C4zWGx/b1qKhmrQ+EvqRUfG/o8p1GHWlB0zx3YAgxnX1143Ow0duv3X8GPBYZFmDSrZnPj64CRoBFjtdwOlS38/KspIjcYEtql01V5KP9RxT1bjQXVeN8xXLmw6Cyy0U5FXJCpravyzaUcAXazaL9laf69A6XLqvoCJh12t4bdJ3srboT0GXpvQ1p+YY4V9jgaoTTr61TOq/DLQzkTL9Rj601ZhtY5l9aJSmpV9SHCRXfMo6rMaMVwMDHwm3Hl6mcG6qmO6ECda7Gm0xdzCIDm7hKhjctw/w99T+Fgw6nmfaveWVDNwDzu9K1DunqrgIji54sIm4ieI64V+ua/KMR4XQGgRn9j1UkHXFn0wp7FRfF6ais10nieVh30ua2erWO2V4Whpyu0ZI7/Jl40lZmT3NDaGZsamy6r1A4guQeG73OVV9whQK5yXvt9D9eV6NkiCEkFZLZC3JWOftoUtB39z/YcL+GHzov+2eFPaZISzRc1ZVCnWhiHTeEetxw5t+z96qCkQ7CnoPuUp6h7EsmdPInQz1iu1P8vgamX+w6iQBJffFQ5PlWzwxtP8ezFjcVNDYddxxtaozYkgDA9quWXDJ+A1zk3uiZKgU1eME+a7P6fvyU6TmpFaSKn0pvtH9AXjidf+WBwPmi/N4oMolia6bY5R0Sn9w+R2uAJ5AaiYCjdt5f8HL1/gWtQVjZpiC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(2906002)(66556008)(2616005)(8936002)(5660300002)(36756003)(186003)(26005)(316002)(83380400001)(31686004)(6512007)(110136005)(54906003)(4744005)(8676002)(38100700002)(31696002)(66476007)(66946007)(6506007)(53546011)(36916002)(6486002)(86362001)(4326008)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnA4K01JYmNYb1pNa2VGOEI4U25DbGRXemFhZ1V3aERPaWg2dkxlaUlsYjlx?=
 =?utf-8?B?UWJnTjM3UitUYmtMUmNYQnMxOVJlU0RzbC9DQllKMEtaU1BRZFl6eThQLzJT?=
 =?utf-8?B?M0F5ZWJUdURONXV5bzZUNERhTUhTL3B3UmR3MUZGUkJSeWIxQ2l6dlc0WDBk?=
 =?utf-8?B?TjNzdTVYVmp5UDlOTHpTWUptbWVIeEtXeFY1bkJqdHZORXp4ejR5b1lyU1Nl?=
 =?utf-8?B?SDR5ZzduaEdhNlNJeFl2YzBaRmtqSlNaUzlOVU53eFR4bDJDYUk3UVpGME1R?=
 =?utf-8?B?cExXaFhQZWJMbnVldHp0RjBkVHpDRklwOTdtYklXZmlNUjREZkxMeEJWRUJ1?=
 =?utf-8?B?YjBxWUVUMGFyMFBEMDVrV01HbFFBWWlqbGRjYklUdVhSbGx3cjAxRGRuM2xW?=
 =?utf-8?B?QzY4UDdGSHJSMEtCUjVyRTFlaVlvUEVlanRxWHBKeVVsYWkvNGI4ZktJNUsr?=
 =?utf-8?B?QVViQ2FMNzBCTjZKV0ZmZHpzakNmd0lyZjkxd1d4cXJOSFo0SkxKQzN5UStF?=
 =?utf-8?B?MXcyaFFFM3YwVWNyQjB4b2VnTnNqZ3RHdkxrR3krQW95emI4VVh2R1JWdUJH?=
 =?utf-8?B?bzJoQXdGa0pKemlDYk5ES3R4QkJaUHJIckIyd29tdGxtRWh3dXNjOXQ0Zjh3?=
 =?utf-8?B?VGw2ZFh0aWs3OHZORGxOYnN1b1hnLzNpOWtRT1dHWGxtVllheXcxRE5LeGha?=
 =?utf-8?B?dDIvM1c5d3pCNS85c0RaLzNJSGhDSlN6ZWdacFU3QncrL0VPUlFPNzA1VTZT?=
 =?utf-8?B?ckJWUHlKcC9jeEZWWWdWdCtnbDNTZXZDNXVoSVQ2L3RFZVRCY3FJVVhlWnB5?=
 =?utf-8?B?UVJiVUMyQU5xY25VTkRHc3VPT0tHOUR1aEZOeHJ3MVdpOXdsNVRvV2x0L0w5?=
 =?utf-8?B?bit2aEJYcEJvUlN6KzdRK2R5NVY4TW1wUExzQVViSEJEbDJOMkQxN0JubkpC?=
 =?utf-8?B?SDBFcnBRcWJReUdaUFZya0Y2WXV6QkxIWUhMcjB4N0hPVmtLOTVTaXJ3M0tE?=
 =?utf-8?B?VjNkTmsyMHQ4ZGRRK2FwaE9iRWxjTWdTb2p3MENiWU5PZWplbC9MTUFoanVm?=
 =?utf-8?B?SUNFTkMrOW8waktsZ0sydmRUQXJ3bFNjN3ZpY082a1d0YXE0Q3Z5eis1Z3Np?=
 =?utf-8?B?NmRqTFVoSEFwQ2trT0FYc3JjTGVsNXNzTTlxMDZPOWpXQTlNWGtsSWFrdHZz?=
 =?utf-8?B?c20wdGFQRUloaUlubzVzeGg0dTVQU2RmY3ZobVdJc0tyeUlRQWVveXd6S2JY?=
 =?utf-8?B?RVYrVUt4UUo4Tnd1ZWxRL3FBS1ZjN3puTFRlS0JORkhXVzR0R0FlZ2NMdjVm?=
 =?utf-8?B?SGdmYXJ3N2UwdTN2TWhzTmVIYktyNkFpMjViekgzZmNLaFZVZjF2QUdjZTMv?=
 =?utf-8?B?MnpEUWlZWVMyVW5BN2hrTnIxZTRRSk01cHhMRy9LY2xYNzdBTXZ3Z1ZDVDFS?=
 =?utf-8?B?R0E4ZzBtUmkrWkdPejRYeEJLUFdHWWMxR01sSVhHbFBYZC9ZbW40UjNoeVdI?=
 =?utf-8?B?UXIvRUxMdVRPbnVONVlObmhaMlh0Nk82Wk1ITEd3NERrQVV6L1Vha1dlZzZh?=
 =?utf-8?B?VTh6NVhoL3dSZ2tKaFFKNEl3VVF2Znk2ck4reWVrMFRSZFhveDZ5OGRtNVpk?=
 =?utf-8?B?UFFBdnJCamdSNkJ3aWVEcm1kTGptZW8xY2E0cUJFdUE5QitEclFiSi9YRS9x?=
 =?utf-8?B?ZEZ0VDhuUkpUYlUrWHBFdkFGQlJtTU9GTmxiUEZaY0RlZmJ2a0NraCtVbThv?=
 =?utf-8?B?Y2hRcGtNeVNlS1pORlduZ0N2NGtGK25EMnZPNno1S1FRNUZ5T3RtSnNwVGVH?=
 =?utf-8?B?M041cWs3OXh5Z29PTTFDRXk2Ty9Zbm5qN2RBaHRTMURsb2hhSENqTEVFODRN?=
 =?utf-8?B?ZzF3YUthcGZ4azhtZENtUFNBYUxWVlYvQktGRVZ4M081YVY4clgzNXJJaXYx?=
 =?utf-8?B?SEM5MnU3aWFRczFQNDNvSFpWVk5nRWRuZHZqU1Z3bHhpRnBEZTB2b1BKWkY0?=
 =?utf-8?B?bVhDT0YxQjMyRFBYS1I1b3lJT0dTLy9zQit1OEM2SXhQdGtYQVV6ZllDei84?=
 =?utf-8?B?SGRmQmMvaVRXYm5YcXdEQzYxd2hSelk5R1dqelREWVpyOFllQkk4R3MxOGFL?=
 =?utf-8?B?YTAwc3pXdVBSRG1HbG9GaEdhSmQrc2xSL2ZOTVc5OGg0ZklWNVpXL3FMSG81?=
 =?utf-8?B?TTRIUW81Y003VTJRLzZZM1RXdmdOTWViUWdUc3Nic2JJaG1JS0c5SEdyaXJP?=
 =?utf-8?B?RjMvbmo0WWNibjlFZU1rNHpQeGh3b2JWb1dYWlBrQk5nVFRQVDE4bkVKM2sr?=
 =?utf-8?B?eExDY2xmZDdkR0ttVm84OU5paWJQL0RKS09Wb1BDWmVNa3FXSjgzUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b67c167-e999-4e96-43b8-08da48e4daf5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 00:21:39.2877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2Pic7/CcnGYF398LUMFEsSI2lbFh0eI4028VYj4I6ZY1AGsPjDdtAYVCOP9xVZbOIAFst0Q2YoSe2BRLzbxOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.874
 definitions=2022-06-07_11:2022-06-07,
 2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080000
X-Proofpoint-GUID: SgiZs24EPb0uuMDlqrohYX5RM1NmESyl
X-Proofpoint-ORIG-GUID: SgiZs24EPb0uuMDlqrohYX5RM1NmESyl
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


On 6/6/2022 11:49 PM, Dan Carpenter wrote:
> Return success if we were able to delete a vlan.  The current code
> always returns failure.
>
> Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  From review.  (Not tested).
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b7a955479156..c964f4161d7f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1814,6 +1814,7 @@ static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   
>   		id = mlx5vdpa16_to_cpu(mvdev, vlan);
>   		mac_vlan_del(ndev, ndev->config.mac, id, true);
> +		status = VIRTIO_NET_OK;
>   		break;
>   	default:
>   	break;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
