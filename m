Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625FEC433EF
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 16:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F20EE401A4;
	Mon, 22 Nov 2021 16:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0zUcxe9PFCli; Mon, 22 Nov 2021 16:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 521A5400CC;
	Mon, 22 Nov 2021 16:48:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F285C002E;
	Mon, 22 Nov 2021 16:48:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 607F3C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EF88405AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="L0hihobK";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="AdSv1iIa"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5P7gCNxFa2z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:48:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A1A5405AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:48:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMGZxWK006223; 
 Mon, 22 Nov 2021 16:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rmlrfvHOE+vc1jJgdXkKcyGMLcUVaCQoxcnA5ulo9/I=;
 b=L0hihobK+s5QeJ+GT86erfSX3BMqIbu7YQb0AbgIQlSAZlamFMLXvwz8EB+OFlk5gaUD
 eh0EjjEaG7cjv6zjOL9xhVw14nH0iZ4irCatcJSOAdhvuoGkLeyOddoX3C6rYJ89O1Le
 x7vV+2oxSrCYav+WhbCDk1I0FNhcdPIL5hvqXXyja+7BzcLVqeWEk+RhTj4lVLL1GnT4
 5iN0fIQBNQLQQ1BgNntIDdpOZuyGJczW6896w8qzxd5Lsfm3MvrLF2l9mGOd3qO1jB/F
 jk85k5tHKmYEYFScPofsYjiADb4VCqCCF8gryUKpobxSpt0AutuC6XoIHpWu4ygTrjv0 zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cg3053e4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Nov 2021 16:48:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMGkXUE055297;
 Mon, 22 Nov 2021 16:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by userp3030.oracle.com with ESMTP id 3cep4wyjhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Nov 2021 16:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDI+yflAVNutORdn24lKfZCTaghb/jXAZ60/URo+Rbx+RzA3TMoeQP56GxzNcXBMUDcq8en5gW92vIBXU6/bPcoi+1xzQ02ZikXd9627qpqEtk4LtTzFDMSSZIHwjiRz94vpWJbIqqg33erolp3JwoaLCL0b9bOxtIj3Z6kwHuWi3zCFcNZ/GBQiBGH1E7aaSAy7jHIzO4lUsxe4jDa9FJPO+Mi3xw4F7wF6IwXT8w9mgCUn0Nbww7CZ4WfcUjFbTdBCTdm3WlgKrDWBM1tRqK+IOqGMnyzFbkcpv/SPNunRp+rVNrSI2gaJR9zBh40QyCCRLKZs+2wRCJpgGiSh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmlrfvHOE+vc1jJgdXkKcyGMLcUVaCQoxcnA5ulo9/I=;
 b=kFqZSMocjmkU9wuQ3p1DmCP1ebK0aLmq5nMNhN7gOicKM3tZ6np7qLM7aV/5NaTAiHFj7UXm1ceG4dxttPHs+M0IDb4GK6sbWUq6orQxZsOfKIm0LEsX1MHOS0ol9EinurjX4phY1mdWgyDdWqxOp0/EwCmQShVVJd5+Vx3nVs3R4XZvxKfE0YbkUfFvawbb6Guf/cOsqB7P3+yE23y88H5/ce5ZDtP1c7ByMsvQVeVguqBkF5ZFLtcQI4ZVpmXP94A/zkUstM2JpNpvm6D7rZv9K/anvyB/9ProblyLoYcbzedRyS77bM1TOGRaGI2MR3rx+l/KZGFBU1IBFDdWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmlrfvHOE+vc1jJgdXkKcyGMLcUVaCQoxcnA5ulo9/I=;
 b=AdSv1iIaG69kT9fbzw5p1v4bG+Osvcf0JBsmGKi1MwX/ObNLhtM/HaO2+EOAbLO5OtOZo2fMTMfmiyS5mfu2QZasMmuOvmyQ02wwNHjelF2Rzv2qMYKcFKX488tgnhYWhrQSpVeZJlXxe7u1sjc+MWfkL1doXW/4Mu1Diy+IbWM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3067.namprd10.prod.outlook.com (2603:10b6:5:6e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Mon, 22 Nov 2021 16:47:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.025; Mon, 22 Nov
 2021 16:47:30 +0000
Message-ID: <766e8487-c83f-5ed1-1e49-0f17ef5ad97d@oracle.com>
Date: Mon, 22 Nov 2021 10:47:28 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <christian.brauner@ubuntu.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
 <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
 <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
 <f2a421da-1bb0-c65a-d8e2-7cbbb2cccfab@kernel.dk>
From: michael.christie@oracle.com
In-Reply-To: <f2a421da-1bb0-c65a-d8e2-7cbbb2cccfab@kernel.dk>
X-ClientProxiedBy: DS7PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::7) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.19] (73.88.28.6) by
 DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 16:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8a1c4f-457a-4db0-c861-08d9add7c631
X-MS-TrafficTypeDiagnostic: DM6PR10MB3067:
X-Microsoft-Antispam-PRVS: <DM6PR10MB30672633EFB0E1836D41113DF19F9@DM6PR10MB3067.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqgvdg9I+kpbrbi9N/5cipuOHlF9uTKY3IJw5XL0DACLew8rV2eFOdJXjb71VRW5+kAB3dqcTT9ieQfi9jflK8btJor/Br8QEas1dGIRTmXRmkfh6Ew8LYPacG06fMv8Tri2BKP4yoTtW9Z2Hr9hNCBhgRgORVPG3JOxEaoQYNXp1GLlSBCW2tbghrJ51DbrHXAKoCSHLfcI4NFVoKivYdNx2KjKicBGxM/Tg/sD7xPRJlU4sjzvD5Crb6mxhxZIp3TLKdWrGRHb7Jnr1jPwrccPdP+hOWm8BXTDta/wTA/66/Kzxv0egBAHQ4DfJAt21SnC4CboaJz9T3oEgK7Ke+6jln9iomw2C1Y7hJFxJhzjhBXGTv6ehE2RMlBcfVhyYrzq/NoZTUJ6firuvcykSvLqkFNuSsohbNcLNlX3qTOIllI/fTAfXm8FEBqqG5zp3TAcS5AHGEDZNv/s4huI/TXIBrwBryhFtn6iltGtf36FykZ7yW9q9/1Vbr1QAPdJI1xOmZzYQ/vy/TRKfMX5z72SLpYJjud6Y7dMTjaKJINqK43ntDjg53hJtTvxvP//GcPeJ593Xlrc2RXoP4kqctIMW4wreXi4twOCoWcXhFEOLXJcAAiALcZLnaOd/MvuXEWUvi3abRl0rqfnYINmRhsjO+h3fCY2GXudwkK/o8ZESynJ2RA9zd/eMxRv+oXAUXTU8UqcY7WmVcM66PEEewdC2L5w+CYQGFqoW4RFxSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(110136005)(31696002)(26005)(8936002)(186003)(4326008)(16576012)(8676002)(6706004)(316002)(5660300002)(83380400001)(508600001)(9686003)(956004)(36756003)(66476007)(53546011)(2616005)(31686004)(66556008)(86362001)(7416002)(6486002)(38100700002)(66946007)(2906002)(78286007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHA3MTBEMFZWYzR0OGIrdmtoTmo5U1UvWi9KQSs3Z2UyVnhKRVVLQ295dzBW?=
 =?utf-8?B?QXZRMWFuRWZvU1loUzl0cmlpWjV6eHExOFN1SmpmRE1KQTh4VFZwNzY5aTMw?=
 =?utf-8?B?a3YySWN0N01JVmQ0VmxaQzRqSUlDbzVndmdrTGZyNDFreHNoRFQ5WjhWcm5k?=
 =?utf-8?B?SHduRDQ5QkpEZ1kzN3A2d25zK1V2eWU1QWpDOWdCVmZsekMyTlBtZjJjODVu?=
 =?utf-8?B?THBRSVVsampOYjN3UmMxMFdacTlWc3MyUFEvSlIyTlVod0RPdnhOak1IVmRK?=
 =?utf-8?B?bkZDT0hJWXJqTHNTWEI3NG5SdlBpQ2JGb0VFSHRVcE4rWDN4N1R0d1p0U1F2?=
 =?utf-8?B?QWdjSit2MmJQRmxzRktoTGtrR0NmRFlmYTV4OHdpMFFVbmNoRHJ2SUl4b3dR?=
 =?utf-8?B?VTllTk5ac1pmekFhSTlUcFltZGhPVkMvTk9ONVh6Y0ttcmlXNVMvOUtlamJV?=
 =?utf-8?B?UmhEOEtGZjBpazV4bUhMZURwcytNc2JHUHBKeEtYTmNBb2hYSXlzL2FzdC9p?=
 =?utf-8?B?clQ1V0JydXB5dmpja0krT0ZmelFLODNLS3BPNkdZUmN4SHJCQVlDOVliWGF1?=
 =?utf-8?B?RGlsaDQrZGpwUzlVR0FjSkF3Vm9VY0YzV3M2dlFnelN0Z2NVbkFwT05Fd2FR?=
 =?utf-8?B?emVxVUZsenQrbXJQK1pYNEJBc1pLY3Jqcml5bTA1aE42bU1lbzhYUXNmTGFB?=
 =?utf-8?B?cmdGdGxQSmpmUmUvK1pWN1VmS09DSFNYUDY4MStqeGV3QnFyZ2Ireng4U2ZV?=
 =?utf-8?B?alU1WTNkUFd4TVlXQk5tTGlyNWM3SkV4YmdBeCtUdXp3OUpaYnBWRFQwaHZo?=
 =?utf-8?B?Y21BWWNxUi9jeHlTbTV5K2xxd0Y4L05LZlRwK2k2bFpZWkI1cytpM2lVQUJZ?=
 =?utf-8?B?VE5MUjJ3dE0zaXZGdXdjMk0xRHlSSElaenhmZlpzWGlxZ2ppNzJYcjVrc1FX?=
 =?utf-8?B?Z0JMdTJJQ2JtUEJEamhrZytyY00zbGVVUUNnTHVTeHdDNm1CaFlvVCs3bTd0?=
 =?utf-8?B?TVl5bHZ5QkY0NFlqbW1ieDlRVTd2Qmg2Smd3YkZiU0RzT0ZxUmtMWG5kMmpy?=
 =?utf-8?B?K3hXZEVpM3ZTUFZLaXdkTTJZYVJjUnNjcDViU0ZURzlZM0VhT2g3QTl4cVJB?=
 =?utf-8?B?RWRXY3RRQjNxbnZxTk5WZGk3cEZ1eWlyVFRicjZPUVZkS2dFOEh6Q2xEMisx?=
 =?utf-8?B?aHlZMG8rRlhqc3kwd2ZpVm0wNVQxaFV0ZzRVMHV4ZlM2WVEwRmJ4OHBXSXVa?=
 =?utf-8?B?M3NudEtwWW9NNDMrZ0pHQVdUQk1BalF5Q2NqQWJpYWN1ZzdEM2tQZytDTjJ4?=
 =?utf-8?B?bkJhL1FFRDg0ODR5WEtJcUZvVUUwZitiZEdySEJEL3UvUVc5VmhPWm8xdkZq?=
 =?utf-8?B?VHRIdHh5emFHOVhDM3RYYzNSTUhhUC9JQkxiQjJNcFhXRjRadWxhREJPcFF6?=
 =?utf-8?B?RWFEektqbERBSXpMVWllVTVRZzVJVU9iS0pvdlNHRlpJaWpIOE5OSG5RMmQ1?=
 =?utf-8?B?Z2ZoNTcrNk1aTWM0OHlZM3daRmRSMTh1VnVlVElWbW1xVThyTkJyTG1URTNK?=
 =?utf-8?B?azdueHQreGJtbmtka0wrSEhGeEd5bnVzTFU5Z2tGblFNU0lFNnVKQWc1aUFy?=
 =?utf-8?B?ejd5VHVPUVVtWTY2Z0xtdkV2Z0ZQSURPWUNMMnNablhhZjM4ci8ySDFzRVpL?=
 =?utf-8?B?OXFjOHg5cEhZdVdxSHIrc25sdzdxaTlOU1dveE51THRSZEowQnFjOThyMktJ?=
 =?utf-8?B?VEJuQkNmV0JEZjdiSTVTc3MwWXdHZ0dCOTVxMDh2dVJONTJUTHEvY2lHcUFL?=
 =?utf-8?B?QWUrSnorUVBFRjJySnJhSndINlVnQXBwMHRSUlZjREhpQTdnWklZRnZLQU05?=
 =?utf-8?B?U2ZnNEMrOFZMYmo0amJBSEhCamlJczhxbndhbjV4SEVJRjAzWWxMdzFmZ1px?=
 =?utf-8?B?aVFvNmRCSWh2Z000dUUvd3pQTGJDbksrYzJwTWszT3lpd0NtWHhUV1dPVmVG?=
 =?utf-8?B?Nmw2YjYvZFF2SlNWQjUwRWFXckpLODI2Y05xdFNjbEwxME9LT2hWdlV4Y1RF?=
 =?utf-8?B?dHJYdkF2UTVtYktNdmZwZFcxejlyanpTV2RIQUxSU3hDSXZDMlhrelVNdmRo?=
 =?utf-8?B?K2RncnZpWUdnMlFHSDZHRmFQU2EvQnplT3FrekJkelpBZ3d3djAyM0hNUXdB?=
 =?utf-8?B?R3A2cVR5QXNkM0tNd01zVzZySXB2TzlRTU42ejJUWmRCVjErSXBrVUdmWWJK?=
 =?utf-8?B?V0hnZkVGREZiaTUyTEROb2VDZS93PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8a1c4f-457a-4db0-c861-08d9add7c631
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 16:47:30.6440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dm41NhcKWc3pZHvT2MzvEV+4KmA86/5PEHyBWO0D1U+f7gSwijWMXXQc4OuOWhFIoLdr+PNWnoRNqT3HGkzU9qOGHFRC2op+8jq29ar2bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3067
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220085
X-Proofpoint-GUID: -ITnadqsR3L0O8evZFcds7pyQ8712iYt
X-Proofpoint-ORIG-GUID: -ITnadqsR3L0O8evZFcds7pyQ8712iYt
Cc: hdanton@sina.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 vverma@digitalocean.com, geert@linux-m68k.org, stefanha@redhat.com,
 Christoph Hellwig <hch@lst.de>
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

On 11/22/21 8:20 AM, Jens Axboe wrote:
> On 11/22/21 3:02 AM, Christian Brauner wrote:
>> On Sun, Nov 21, 2021 at 11:17:11AM -0700, Jens Axboe wrote:
>>> On 11/21/21 10:49 AM, Mike Christie wrote:
>>>> Convert io_uring and io-wq to use kernel_worker.
>>>
>>> I don't like the kernel_worker name, that implies it's always giving you
>>> a kernel thread or kthread. That's not the io_uring use case, it's
>>> really just a thread off the original task that just happens to never
>>> exit to userspace.
>>>
>>> Can we do a better name? At least io_thread doesn't imply that.
>>
>> Yeah, I had thought about that as well and at first had kernel_uworker()
>> locally but wasn't convinced. Maybe we should just make it
>> create_user_worker()?
> 
> That's better, or maybe even create_user_inkernel_thread() or something?
> Pretty long, though... I'd be fine with create_user_worker().
> 

Ok, I'll do:

create_user_worker()
start_user_worker()

since you guys agree. It will also match the PF flag naming.

I'll also add more details to the commit message you requested.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
