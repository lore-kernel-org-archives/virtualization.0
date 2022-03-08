Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C6DC43219
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 06:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 678EB408D1;
	Tue,  8 Mar 2022 06:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Sp5ruXskiF2; Tue,  8 Mar 2022 06:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A71A4013D;
	Tue,  8 Mar 2022 06:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE466C0012;
	Tue,  8 Mar 2022 06:16:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F571C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA7768138E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="NAkYuN8M";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="xcyUQVoF"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kk3wSxO55te1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1DE38137F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:07 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2282WIbM022335; 
 Tue, 8 Mar 2022 06:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=D32RYhuBpLITAtt+0ygw8NG55uey12ImUABaKFz/LZ8=;
 b=NAkYuN8MZftgBP/yKn/KlcI0p5Ehw6vt94Frn3EXyJhcRqRnXtd+/CTGaJ8eE6r4FzL0
 RpGGrt1YAmAoyBzsHVtrLxiqcX/+XFyAbDoutcOkmIsGvXBPyTOnk03Wtpeu4wA/h18y
 rNfBnOvoeTyxTuyGjq/knZwpuBQiQvWt5z8Dro5egq/IoXVshHpG0alQcyX1H4l2uai/
 Q+5xsKPw/bBf6jkOEwSq0eBW7xzZJp6/X7n+RsiNE1fMsbwTC5CDIIbmKScOR4bnTnmk
 2c1sAtWX89HWXM8oCiDSAB9dBqw4APRQDlNBDonouMmiAHAlzTigMVN2XP7S1tu4M3Nb zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0p1g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Mar 2022 06:16:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2286CNLI093091;
 Tue, 8 Mar 2022 06:16:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by userp3020.oracle.com with ESMTP id 3envvjye77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Mar 2022 06:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/s79JwRoqGdyey4FHymGBv+efqUFuZZRma5w3UnShYg2jYN1pkRnYXOwVyG1tfl/uwYll/R/vMB2ikjvkJ0qwwLYXDc0UD9HOxRxugBVbwYPaDnPAJZp4VhRdOULWQAvAzQVa7K5HD5b9R1McO20y4e5rYpewjt57pqaRJIET5eXn+TSvYfCdSQ8HlVNeT+t0jWZWcAhvQty5UEZb8RFJw780PNfSalsjPP2xq/5DK603sP7tLENWorj+R4yrl9Y8oU92eR+dL6X8jVbOJsT0b0ddoCrHlj+fJTLuMqVIChklW8CIxBuI1fqWUcFa8JDXnISKju8qgTar/klErtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D32RYhuBpLITAtt+0ygw8NG55uey12ImUABaKFz/LZ8=;
 b=EBe9ibBsrx0z3PsMD0jXOesBNqQkEssCL7hnYcJFrL4Rm1wvvkC0C7/V5EfxJMJYvE9y8isBCOOwMzvQpmU5MShRNTBvt9/RSdF03jtF9usRv1Sqv/IHTVT4p4Ol8+VJBwqXP8wOzReJpPJzI3JTAGMjRIGg4jgZQ4swgfJYAhwHSdtstlq+uWJBmGUfOzlBNTb1tpnN6OwJ39XaJ7zKBC7YgcQhe49V8Y1+4lkcSCz8OYmKZEEZPOzDQ1ua/cfJ/HKHzYZRpLOPrByNdFxR+oX5V/pHrPmaZlnGGU01wpW3xY108i4m2ZOmReXblCqPcHuwRbU8A+ibvaiQsE6soA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D32RYhuBpLITAtt+0ygw8NG55uey12ImUABaKFz/LZ8=;
 b=xcyUQVoFy61GeYf8+0LHVqr7RGuUfFJ41SsKDxyuXCgh26Pit3OM6aDako7S1ZXCexYspknS4PnMkuC0RanFi/sJqwXlVlnRgNFLqDNQ+TekUyezwPcuI5eqi7a7W0V7y1WGeUEpH8YLgkfcXqLq/L3k0bHXVGwnlqaFOmVOF14=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MN2PR10MB3295.namprd10.prod.outlook.com (2603:10b6:208:12e::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 06:16:00 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:16:00 +0000
Message-ID: <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
Date: Mon, 7 Mar 2022 22:15:52 -0800
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
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
X-ClientProxiedBy: DM5PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:3:23::30) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ecb107-736a-4e9a-ebf2-08da00cb1dbc
X-MS-TrafficTypeDiagnostic: MN2PR10MB3295:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3295B208C04CBA9A570F4774B1099@MN2PR10MB3295.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5qdeLmvjz2AvYr6w7WK6C8QNLlfSM0nkyO7Agsor1cvnGA+86WFr3aS2spWcBqk6GlGtR3NvNGtRgPjg8Y00suuuOS7Pk4OYIMjSQ+BNr13FH0zYotG97OfA3yWzeiRPONjrxTs80RQUriWFDbXASE5/AmMJrPHUmrL700j1WY4cnw+Q++9vhGr5yBHLGkCMFucxUzr4Yi6bQbkxUkW+Xno5/iNQABUaUfuh131Tqbv3NXTTQQjqcOIRg7JUVNd7OX5QrEpvoVS9MtyU39lorSQGwOiz/M8LDTz1BTaaDlx6uY+poL78uDf5nkkumq75eRhmUvxJ8Z8E+A3GnPWP0C+wHDfZYeS23jOjexMjIdV6pUSvggo8I3a09BxRpT7c82zJLoHi6DyupCJVNC/O3Gb5EppWP0BlqZO1F3Jq6QKZsep9LDRGHBnY/NKNHIs7QcE0TQ+UxeSiD3CzGzA5V/fk6n+cSHLCchr6SvpTvcuCZ6HPTjWqS+R+I+OdfS/Pc8esikV70P5+ho2T+wLJDp1GnEYmICv+nufYU2n92FXTchf+9AecI8FQ8qWzptPXUoofPTz/BFpvEEwRk/fZXbQpH7typwVmJNM6r6jx8qKE95FMoqkBXx7VWmTEBQrAj06UpAeDuBJrWUvsypZXTLE0mJHOsrIMeNyhogm3MtSL6/owlINhH3pWSU/4TMg/nGkfQKX5Rxp1s4/lKSW1+wlvrN6LzWMknZrUmEu6Ic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(6486002)(31696002)(86362001)(83380400001)(2616005)(26005)(36916002)(6506007)(6512007)(6666004)(53546011)(2906002)(30864003)(4326008)(5660300002)(8676002)(66946007)(66476007)(66556008)(38100700002)(54906003)(316002)(31686004)(8936002)(36756003)(6916009)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NQd3FjSGkxSFhFTEFwZG1neUQyNGpEdmVGNGRWSTlMbEI3ZTc0QnRHT2Q3?=
 =?utf-8?B?ZlU1Q2lCbnhWWis4c3haUGEwMm1SZWRTT2JvRW5Md1hCNitYTlNUajFXQUti?=
 =?utf-8?B?NE5GYkRod0Y3eHhPK3FScU5hRmtpNzJaL05IRHBxZGp3SHJ6NFZZU2E5bXVr?=
 =?utf-8?B?WjRhWjNuMVhCM2FMc2RoeHgyRG83UFIrWFRNRWxIV1FzaGJ1NGNhdCtQR1Jh?=
 =?utf-8?B?SUo1dGFMT3hHYWtvZUVjMEVaWGpvYkdzaTF1NVRmMTg0bGZTeis0bXBYUGda?=
 =?utf-8?B?Wk8xdFFnQkJxYk5UdjFrb3dNRUI1UXduT2VTbVlCb0NGaTlpNFBlUzgyOEtB?=
 =?utf-8?B?WmJpY3laUUhVMFlUaVdtWVJjQm05RmtNRVB3VDZXRS94ZmZYdmdURmJIYmov?=
 =?utf-8?B?eEFOMk1JU1JPMFZienp0QXlTVFZ5SHBqOG8zSjZoR2NkYmhwOXZzOWRzZkFY?=
 =?utf-8?B?aGRtallGcXpHNjdoeDViQXl6ckQyNFQyWjZiUURXYjFTYmFrdkFjT3ZzWVZF?=
 =?utf-8?B?bEhKZXZVeDEvZ0Z3di9kQUlZMDk5cktpdGhLRDQrbWlCelRhUGkvL2cwMWs1?=
 =?utf-8?B?WUlXblpxaFhTL0tmTUsyRzRmcEJSZGU4OE91NEdJK2tZaDRoTDFFY1VPQ2tm?=
 =?utf-8?B?NEl3bmsyckJFRmNjakZyMkZhc0svNFZlU2c0V2N3WFgvU2dnc0lWdTV1c2gr?=
 =?utf-8?B?LzRKSnZXQVZHbHErVnQyNTFXUVpLY2VWa09jQWsxbVRnMHNFNitVUEJrdlJx?=
 =?utf-8?B?UGRENUEvNVNoZmtUeEd1eFduZUhJNGp3dWYvRWZwUkVFaDBtWTZKV0FEakZG?=
 =?utf-8?B?M3Q4QXBhYmFJM0QyUE5jRzhRMFU4Q1kvN3FpSzJUM1RXTVVkelhRNjBBaDlx?=
 =?utf-8?B?RXN0MmJVelVMOFpoeFZDaTFSRGpyMisyNndRQWlia1RNZERVSVRHSHZKVWIz?=
 =?utf-8?B?K2xHMlBLTEl6bU5QSHJ1LzRxVWlJZkYxRUZUOTBmM3RKZGYyWU55M2FCbHEz?=
 =?utf-8?B?UHFXM2l3TlFqcnR0cDZnOE45emFXb1lKdXM1SjgwNjNySGdSd3JnNDl5dDBJ?=
 =?utf-8?B?Rk9VYkhYY0RoTjBWVnQ0Sk0va05UTEtvU0JVSU81dkxJa2p1aVlUNXg1SXZR?=
 =?utf-8?B?Nk9FN0lBTlpZN1pIN1kvK0llc3kraWNCU05acXl5c3FYczhYVHJxQ2trZ1JI?=
 =?utf-8?B?QUpBTWJCeVVTOEhpMzJjSmh5endwZm9nZ0pJeHN2bkltbFR6dStRYUpLN0Mr?=
 =?utf-8?B?YkYxZ2VUSmdtdm9EZmRUTmU2eVpKK2N0azEwdnRMNUp1NVc1TzA3QTFHdXNa?=
 =?utf-8?B?dE10dE1DUmZOWU9pc0xhZHM3elU0N0xrdEZxcStnOGVxTHcwOEZJeDVhV2s4?=
 =?utf-8?B?cnhIR0RUNTErS3dQUlhjSVNJZTczc0tuSjc1M0ZEUFM5aUR0SFZ2NDJlNEVt?=
 =?utf-8?B?a2dSRms1ZmdYYmRmTFB0dnNlTmpjWndMNXkxQmdUdlJLT0JtTkxnSkExRXR0?=
 =?utf-8?B?QmNLVnhINjlXTysyUW9NSXZTQnJXZkgrQTlwZk9PdWQzTWlJZkI2cmdMUWpU?=
 =?utf-8?B?L01EL0plWWMzNE4rYThPSExlTVlNZlVuT21OUVBTek9CSkpNZ0FGajY2TThU?=
 =?utf-8?B?WUljUlZ5eWFxUUpDT2tNUkkrY2NybjRac2ZreDNvQTBDQ3laWkxmWTZ1Z3cz?=
 =?utf-8?B?VU5WUWl4ZS9NbS8rRzM3cGNpSmQ4ZjZBbFlVbUtBMDNYWUlOU0hFK3JuNlNr?=
 =?utf-8?B?QjFWSlg3NWFBTW55dWkrWVJiQ25rREZFalVWMytzRjRWU1p1d0dyZWhrbDlP?=
 =?utf-8?B?d3pmcFZvYThuQ3F3UnBuSUgwckZYaUdqZ0x4ZWhsUFk5T1ZybGcvV211d0NG?=
 =?utf-8?B?R1BPNVlYQnBNT2lPRHdQT2JNZnZCWnVMSHdlZW14cVd2U0lHcmRoUDdzSFlK?=
 =?utf-8?B?Z3E2TkwrQUpJVi9lQ2lZMHEvK1IrZHQ5b1J0M1VkSHAyMHhsdGpEMCtWRUlQ?=
 =?utf-8?B?ZzFnRU9zU3pXQkk3Tm5PSDJPd3JFRitqZytROE9NWkxmZ3BwcWxXckM2bzRL?=
 =?utf-8?B?VFozUGMveFkzLzZ6MytzTXJIOGdwWG1mRFpKcTVieU05Nk56M2xiaDB5M1NU?=
 =?utf-8?B?ckVGSFd4YmlyMXE3MEdxQlRuSGZaMklBOVNwbzcrYlExY1BsaTJUNXFZNUdH?=
 =?utf-8?Q?tBlPCQmQzzx4iYFoYnQaB9A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ecb107-736a-4e9a-ebf2-08da00cb1dbc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:16:00.6596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXOW4xjX1bSmTx+Rjl0yXMp7YE1qO7aPl2otN988VzS8vfktq9GKvNVL3YTX1q8GvMSd0IS9OFG9Bm/oEfsWPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3295
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279
 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080031
X-Proofpoint-ORIG-GUID: -GHframFzRZl5B59-BVzISoQ-K7dHcsu
X-Proofpoint-GUID: -GHframFzRZl5B59-BVzISoQ-K7dHcsu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 3/6/2022 11:57 PM, Eli Cohen wrote:
>
>> -----Original Message-----
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Saturday, March 5, 2022 12:34 AM
>> To: Eli Cohen <elic@nvidia.com>
>> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
>> foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit <parav@nvidia.com>
>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
>>
>> Sorry, I somehow missed this after my break. Please see comments in line.
>>
>> On 2/16/2022 10:46 PM, Eli Cohen wrote:
>>> On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrote:
>>>> On 2/16/2022 12:00 AM, Eli Cohen wrote:
>>>>> Allows to read vendor statistics of a vdpa device. The specific
>>>>> statistics data is received by the upstream driver in the form of an
>>>>> (attribute name, attribute value) pairs.
>>>>>
>>>>> An example of statistics for mlx5_vdpa device are:
>>>>>
>>>>> received_desc - number of descriptors received by the virtqueue
>>>>> completed_desc - number of descriptors completed by the virtqueue
>>>>>
>>>>> A descriptor using indirect buffers is still counted as 1. In
>>>>> addition, N chained descriptors are counted correctly N times as one
>> would expect.
>>>>> A new callback was added to vdpa_config_ops which provides the means
>>>>> for the vdpa driver to return statistics results.
>>>>>
>>>>> The interface allows for reading all the supported virtqueues,
>>>>> including the control virtqueue if it exists.
>>>>>
>>>>> Below are some examples taken from mlx5_vdpa which are introduced in
>>>>> the following patch:
>>>>>
>>>>> 1. Read statistics for the virtqueue at index 1
>>>>>
>>>>> $ vdpa dev vstats show vdpa-a qidx 1
>>>>> vdpa-a:
>>>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc
>>>>> 3844836
>>>>>
>>>>> 2. Read statistics for the virtqueue at index 32 $ vdpa dev vstats
>>>>> show vdpa-a qidx 32
>>>>> vdpa-a:
>>>>> queue_type control_vq queue_index 32 received_desc 62 completed_desc
>>>>> 62
>>>>>
>>>>> 3. Read statisitics for the virtqueue at index 0 with json output $
>>>>> vdpa -j dev vstats show vdpa-a qidx 0 {"vstats":{"vdpa-a":{
>>>>>
>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>>>>>     "name":"completed_desc","value":417548}}}
>>>>>
>>>>> 4. Read statistics for the virtqueue at index 0 with preety json
>>>>> output $ vdpa -jp dev vstats show vdpa-a qidx 0 {
>>>>>        "vstats": {
>>>>>            "vdpa-a": {
>>>>>
>>>>>                "queue_type": "rx",
>>>> I wonder where this info can be inferred? I don't see relevant change
>>>> in the patch series that helps gather the VDPA_ATTR_DEV_QUEUE_TYPE?
>>>> Is this an arbitrary string defined by the vendor as well? If so, how
>>>> does the user expect to consume it?
>>> The queue tupe is deduced from the index and whether we have a
>>> virtqueue. Even numbers are rx, odd numbers are tx and if there is
>>> CVQ, the last one is CVQ.
>> OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in this patch
>> might not be useful at all?
> Right, will remove.
>
>> And how do you determine in the vdpa tool if CVQ
>> is negotiated or not?
> I make a netlink call to get the same information as " vdpa dev config show" retrieves. I use the negotiated features to determine if a CVQ is available. If it is, the number of VQs equals the control VQ index. So there are two netlink calls under the hood.
The lock vdpa_dev_mutex won't hold across the two separate netlink 
calls, and it may end up with inconsistent state - theoretically things 
could happen like that the first call gets CVQ negotiated, but the later 
call for get_vendor_vq_stats() on the cvq might get -EINVAL due to 
device reset. Can the negotiated status and stat query be done within 
one single netlink call?

What worried me is that the queue index being dynamic and depended on 
negotiation status would make host admin user quite hard to follow. The 
guest may or may not advertise F_MQ and/or F_CTRL_VQ across various 
phases, e.g. firmware (UEFI), boot loader (grub) till OS driver is up 
and running, which can be agnostic to host admin. For most of the part 
it's not easy to script and predict the queue index which can change 
from time to time. Can we define the order of host predictable queue 
index, which is independent from any guest negotiated state?

>
>> Looks to me there are still some loose end I don't quite
>> yet understand.
>>
>>
>>>>>                "queue_index": 0,
> I think this can be removed since the command is for a specific index.
>
>>>>>                "name": "received_desc",
>>>>>                "value": 417776,
>>>>>                "name": "completed_desc",
>>>>>                "value": 417548
>>>> Not for this kernel patch, but IMHO it's the best to put the name &
>>>> value pairs in an array instead of flat entries in json's
>>>> hash/dictionary. The hash entries can be re-ordered deliberately by
>>>> external json parsing tool, ending up with inconsistent stat values.
>> This comment is missed for some reason. Please change the example in the log
>> if you agree to address it in vdpa tool. Or justify why keeping the order for json
>> hash/dictionary is fine.
> Sorry for skipping this comment.
> Do you mean to present the information like:
> "received_desc": 417776,
> "completed_desc": 417548,
I mean the following presentation:

$ vdpa -jp dev vstats show vdpa-a qidx 0
{
     "vstats": {
         "vdpa-a": {
             "queue_stats": [{
                 "queue_index": 0,
                 "queue_type": "rx",
                 "stat_name": [ "received_desc","completed_desc" ],
                 "stat_value": [ 417776,417548 ],
             }]
         }
     }
}

I think Parav had similar suggestion, too.

Thanks,
-Siwei

>
>> Thanks,
>> -Siwei
>>
>>>> Thanks,
>>>> -Siwei
>>>>>            }
>>>>>        }
>>>>> }
>>>>>
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/vdpa.c       | 129
>> ++++++++++++++++++++++++++++++++++++++
>>>>>     include/linux/vdpa.h      |   5 ++
>>>>>     include/uapi/linux/vdpa.h |   7 +++
>>>>>     3 files changed, 141 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>>> 9846c9de4bfa..d0ff671baf88 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
>> struct sk_buff *msg, u32 portid,
>>>>>     	return err;
>>>>>     }
>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff
>> *msg,
>>>>> +			       struct genl_info *info, u32 index) {
>>>>> +	int err;
>>>>> +
>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>>>> +		return -EMSGSIZE;
>>>>> +
>>>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info-
>>> extack);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>>>> +			     struct genl_info *info, u32 index) {
>>>>> +	int err;
>>>>> +
>>>>> +	if (!vdev->config->get_vendor_vq_stats)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>>>> +	if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>>>> +				      struct sk_buff *msg,
>>>>> +				      struct genl_info *info, u32 index) {
>>>>> +	u32 device_id;
>>>>> +	void *hdr;
>>>>> +	int err;
>>>>> +	u32 portid = info->snd_portid;
>>>>> +	u32 seq = info->snd_seq;
>>>>> +	u32 flags = 0;
>>>>> +
>>>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>>>> +	if (!hdr)
>>>>> +		return -EMSGSIZE;
>>>>> +
>>>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev-
>>> dev))) {
>>>>> +		err = -EMSGSIZE;
>>>>> +		goto undo_msg;
>>>>> +	}
>>>>> +
>>>>> +	device_id = vdev->config->get_device_id(vdev);
>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>>>> +		err = -EMSGSIZE;
>>>>> +		goto undo_msg;
>>>>> +	}
>>>>> +
>>>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>>>> +
>>>>> +	genlmsg_end(msg, hdr);
>>>>> +
>>>>> +	return err;
>>>>> +
>>>>> +undo_msg:
>>>>> +	genlmsg_cancel(msg, hdr);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>>     static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct
>> genl_info *info)
>>>>>     {
>>>>>     	struct vdpa_device *vdev;
>>>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct
>> sk_buff *msg, struct netlink_callback *
>>>>>     	return msg->len;
>>>>>     }
>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>>>> +					  struct genl_info *info)
>>>>> +{
>>>>> +	struct vdpa_device *vdev;
>>>>> +	struct sk_buff *msg;
>>>>> +	const char *devname;
>>>>> +	struct device *dev;
>>>>> +	u32 index;
>>>>> +	int err;
>>>>> +
>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>>>> +	if (!msg)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>>>> +	mutex_lock(&vdpa_dev_mutex);
>>>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname,
>> vdpa_name_match);
>>>>> +	if (!dev) {
>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>>>> +		err = -ENODEV;
>>>>> +		goto dev_err;
>>>>> +	}
>>>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>>>> +	if (!vdev->mdev) {
>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa
>> device");
>>>>> +		err = -EINVAL;
>>>>> +		goto mdev_err;
>>>>> +	}
>>>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>>>> +	if (!err)
>>>>> +		err = genlmsg_reply(msg, info);
>>>>> +
>>>>> +	put_device(dev);
>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>> +
>>>>> +	if (err)
>>>>> +		nlmsg_free(msg);
>>>>> +
>>>>> +	return err;
>>>>> +
>>>>> +mdev_err:
>>>>> +	put_device(dev);
>>>>> +dev_err:
>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>> +	return err;
>>>>> +}
>>>>> +
>>>>>     static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>     	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>>>>>     	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING }, @@ -
>> 997,6
>>>>> +1119,7 @@ static const struct nla_policy
>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>     	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>>>>>     	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>>>     	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>>>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0,
>> 65535),
>>>>>     };
>>>>>     static const struct genl_ops vdpa_nl_ops[] = { @@ -1030,6
>>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>>>     		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>>>     		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>>>     	},
>>>>> +	{
>>>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>>>> +		.validate = GENL_DONT_VALIDATE_STRICT |
>> GENL_DONT_VALIDATE_DUMP,
>>>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>>>> +		.flags = GENL_ADMIN_PERM,
>>>>> +	},
>>>>>     };
>>>>>     static struct genl_family vdpa_nl_family __ro_after_init = { diff
>>>>> --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
>>>>> 2de442ececae..274203845cfc 100644
>>>>> --- a/include/linux/vdpa.h
>>>>> +++ b/include/linux/vdpa.h
>>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
>>>>>     			    const struct vdpa_vq_state *state);
>>>>>     	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>>>     			    struct vdpa_vq_state *state);
>>>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>>>> +				   struct sk_buff *msg,
>>>>> +				   struct netlink_ext_ack *extack);
>>>>>     	struct vdpa_notification_area
>>>>>     	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>>>     	/* vq irq is not expected to be changed once DRIVER_OK is set */
>>>>> @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
>>>>>     int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>>>     void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>>>> +
>>>>>     #endif /* _LINUX_VDPA_H */
>>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>>> index 1061d8d2d09d..c5f229a41dc2 100644
>>>>> --- a/include/uapi/linux/vdpa.h
>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>>>     	VDPA_CMD_DEV_DEL,
>>>>>     	VDPA_CMD_DEV_GET,		/* can dump */
>>>>>     	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>>>     };
>>>>>     enum vdpa_attr {
>>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
>>>>>     	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>>>     	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>>>>>     	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>>>> +
>>>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
>>>>> +	VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>>>> +
>>>>>     	/* new attributes must be added above here */
>>>>>     	VDPA_ATTR_MAX,
>>>>>     };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
