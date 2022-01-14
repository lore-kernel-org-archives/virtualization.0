Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C9C433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 09:24:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3C45416C5;
	Fri, 14 Jan 2022 09:24:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yw43QR1HeHC7; Fri, 14 Jan 2022 09:24:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 475FB416B0;
	Fri, 14 Jan 2022 09:24:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E0E2C002F;
	Fri, 14 Jan 2022 09:24:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E196C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C32F416B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MdP3VOl5_IKh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:24:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7102416B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 09:24:19 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E8VjnG005398; 
 Fri, 14 Jan 2022 09:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L+E+8qrM/4qcf5OLdesQKbfLL9BTJuksgYx6yhuwafs=;
 b=qboyc2Nm+3sYKVWWdm40AVXHnJG928ZIUfYLl8zp5YNRosnhAgNYAH8E35zbfByceVkO
 vwBUn/edQICo/mAUhIJfUYy+KmsitBc1x8R9QB3n9u11S55F+AXA0SpUz5UzIXp8L1+I
 RC0H8i4p2brsbR4ykRLWIOFIGT/kmqzyAuU813Qvz5/ibILxfRs2U4M17own8ZTkVOFL
 gHkXi1mqN583ywBehMzMWw+0lOGEAM2Wccjh2hSt8zvidDzaKldUjz4scgMtG6Cp/z5R
 U7onb4EkE+aw7YJcxqnoVZg+/WJ1BLHjgrYi4MepA0aBH/QCs0iz7S2rBT9TDm4hNyeg VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djgv6bp1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jan 2022 09:24:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20E9BmRo088419;
 Fri, 14 Jan 2022 09:24:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
 by userp3020.oracle.com with ESMTP id 3df42t1th6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jan 2022 09:24:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls3aJZ4iwj42VxVL4KLBLDtefoHC7veJUcC8ekXdVC2c6Ev3hxqbF02E3oxpRqA4m4duaHZmj4M2YMYGaGMgbIL0JvP7Diere85Yh0uKgSzgvXvbW1wuC3SjUwLJYtPkkYYqi+3GnNsO0PD9dCCe/3FPxftEd4V+qbAKTo1R56rNh1ZKjCIQEKvr9Ct3MOnzPzG8F4DqUrH+/e/QvaYq8gOxwhssypX+/GSjRaH7cSPlKYU0mWNoYpWr+tMQLXuinhyU6bl/1DhMd5dWrrVx4GUXhd+b3KT4KxbtcLRGO5MhBtUM0FQjcxOWx3J1Udb5mf7mRZ382w2sDfLavTUPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+E+8qrM/4qcf5OLdesQKbfLL9BTJuksgYx6yhuwafs=;
 b=FhwMSh8Zg4bdcr53BnoqJ90ZMZa1slN/k3UFHw+FJsHJv3R9k2Fw+WEz/NiKwj+1ps2tn3m038KdwlF4UM0BZ8s7ti0pUdnNiVty9wgnXXIZ5uwg/SwBprFFt8EUOLxHJetM94wgwEt3gy8sM9qibFa3bg7MMgnCWXsGwe/Lo+c+oVrGcSyoF8I2VRxV3+zCWUrm/WI9FD7lloKD4UjFGrSQN6kQnqWEZbT/M3Riq1JueiI8zZJN7XHEbf4hEA9U7NhwWnToIPUxHbdHMeGAeWr3J7xGYm3pfp7N+ZHQtSZy4aNqf8fqMf8fkwBtHyfHVDG5s44WoKlAWyy4x9gNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+E+8qrM/4qcf5OLdesQKbfLL9BTJuksgYx6yhuwafs=;
 b=hOTukvB4iyq3vSDvcjuY0QTRfjS7JlAhvQFZYhKaDMHMqRGHU182/p1mFZbaAMp/+nHPfg5JiLFrSP5eLHSESG5+7ytQY8wf7aQ8L2gXjEPMpsa91nPtJeJtPx0nr42WmGFFupBYEgBks1U1k+ZGyI8blva12fRBH7ieAbVOfHA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by PH0PR10MB4471.namprd10.prod.outlook.com (2603:10b6:510:38::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 09:24:15 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 09:24:15 +0000
Message-ID: <a1b0ca78-c255-3317-61dc-e80dfcbfa159@oracle.com>
Date: Fri, 14 Jan 2022 01:24:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] fixes for mlx5_vdpa multiqueue support
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <20220113020125-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220113020125-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA0PR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:806:d2::8) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a35ef91-7cf2-447f-7c62-08d9d73fa219
X-MS-TrafficTypeDiagnostic: PH0PR10MB4471:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44712500485E9A2F6A51DBF3B1549@PH0PR10MB4471.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Az4ZpGNEOwcpPXhOaY9Z7G7z/sCHJ6a1iAFehBqJS12K9xCzLXZWTMh+5VMjYyuFNl0BwFJcpvoG3q8h8NFWl5/g0o7uFHoPbF7SELn7AMtwvvBMnJEhBAKQlyDh6pQf9sD+Ux3khakThSsLVzLDpi+jwnha6b2UOps61Go/ee3Zy2/P2cYwyrICgcnf/vFRbhzFvZx3SUJS3rVkaMZIli81j7sMeSE7Sn6T08XJy1uFs9L0K8++GNLxSL7j/lRtOvc+J11RbL+kHBq48GlFUD5EFuqn9aCxL2nYk0uhEMPWsNlvqLRP1XdKfmbMkNqOoDL0f4BgOFT3RWd9q6L4GlUZvPYTrAyRiF7ohCpNx7KF0bF4ylFKiULvYZfcPT/ukRCBWs2fRobzTQhTwFfUJ8R0pq5iW2JsHhcKGbp4+lLEn/OnuN1mFguXiu3iYWBW0wxNICFAR5TCrRKh44mN7Nwp1/MBq4+/uFe9G+qdCUM7jnHxueVP3fKnEmJrZ41mwPJmfQu6cJADsr5DGG8DPgRN9VCrwYzoXML/EUQ4MU3FsHTCJJ9nOznLrD3AD+1lHftE2YHb2uiNi8WcxRe8Lx2rhErsZzVtd+lfb62ta90TV8qdAJn3kY9EPrz37PvcTCNhrHKSagiJBbb9nk2ObTgOqlrDlE3bLfUaLT1fRrejIm/L3Rwk8VBMNaRvWJsVZiaoYGZbzERgms34REzMTnJ54NdKIzzsboYR+B+Pds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(31696002)(38100700002)(53546011)(4326008)(8676002)(508600001)(66556008)(6512007)(6486002)(6666004)(186003)(6506007)(36916002)(316002)(26005)(2616005)(31686004)(8936002)(83380400001)(66946007)(2906002)(86362001)(5660300002)(66476007)(36756003)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFhaGd0U1RxclFEajZ6YWNkY0J5d2M2VXBvakFwNzZsV2lPYzBWaHJQY0hm?=
 =?utf-8?B?bzZEZXRxR3FVdytDVzV3VjlhMkJRNG1Ed3cxWmYzNHJGZ1NQODBaQTd4ZFpO?=
 =?utf-8?B?SDY0VDl2QkZYQmtxNVZialk2dC84S05qUGdEbWFkYWdxZ3Z5YldGMmtNcGcv?=
 =?utf-8?B?d3pON2NkT2txWTVKVnk5LzJKeXFuVEtxbTVrazNNNytkRUhnblRRbFBQbVJ4?=
 =?utf-8?B?Y0tHaXlWdDc2RW5TRWszSXhYR0hxTDZOWmsvdVJCVENNeTBzZTBhY0xkYk10?=
 =?utf-8?B?NGtsMGJzZDZCRU5EYi9qTlVmWFN2aEFBZzRzV3htSnRBSjQyajBtVDRvVjdU?=
 =?utf-8?B?S2F4TWpLanJPa3FaT0pQU0JHTTBxWHhEZlVUdit2aGFlZkMwRUVUako2OWNE?=
 =?utf-8?B?MVpsYmNXa2RMT0NyUEFCVmw2ZnJRZGxCVFloNS83Vlo3RGRET1M2OHFFdmNx?=
 =?utf-8?B?VmRjSTRBcHVZUzg3QjNQY1VneDM1TjN1OHBwSFJSbHRpdkd0all3cE9uZWJ5?=
 =?utf-8?B?N0s1cnliNDNDMGMwM1FLZ2dpWVFDakNEa2ZNWlgxekpHSXMxSHZQb2RKRVlF?=
 =?utf-8?B?Snp3bmt1S2FiRkhpT21vUUIyQkMwQXJwdXhwRU1NTm1JMG1jSDNYamg0MGMy?=
 =?utf-8?B?bitUd0NhbnIxVFNsSTZzY3BnS1VBQ3FaQTRMZDBLWEdUVkFCU2h2ektWemV4?=
 =?utf-8?B?U3BacVN5RzBFcGxvOHAzaUF3dU1jaFJ6ZEZFTzhZV0hnd2Y1N3RLUi9rVExF?=
 =?utf-8?B?MW9ic1NmbXJ4YWpVVU50UVpKblptc2x3SjA2ZDZTYkhCR3haUnJUR1J2blBp?=
 =?utf-8?B?MmQycjIvcnh5N25wRzhwckJIV1lQdVV3VnJFYVpRaFo2VlIzN2VoREdxSHRG?=
 =?utf-8?B?K1ozcGhUZW1EODlKM2FhQ0Uwd3FNcDQ0SXNYTFhhRE9XMVJjajNTUXhDLzdI?=
 =?utf-8?B?MGxwZjFST3NkdVIxNEFwRDBkSENvcTYrQzFydFFlNnovYjNiVm54WHdWelhZ?=
 =?utf-8?B?YW1WZTNtazg3NE9MajJ1WVJ0UWJISnNkYXdXdm9TWkhmRWxvazdkeWNoQ01o?=
 =?utf-8?B?K0RPVzhXUmZqZEtPZkFqQVBTclBVYmdBMEN3aTNsNjRBZVFqdTlwalZnVXJG?=
 =?utf-8?B?Q3lLN2cxMHVpZStuWWNXQmJrZlNYbzVLakhHdXJDSUpGb1oxeWQxTjlFTEtp?=
 =?utf-8?B?cXA5Vms0b3ZmVUVJUzVCby85QmRRd0tCcFBMUHhlWGtVMTVNZFM2ajIxNlV2?=
 =?utf-8?B?RGQvdkhJelZvUjM4NnZNNEdhODVJQjlYVUhtanlndWxvSmVWY0l3ZnBJL2JO?=
 =?utf-8?B?M3A1NlJpV2VXS0pSR0tzUTBjMnVvRGsrb3FHalBzNitQY3F2RXVzdk9zQ1JX?=
 =?utf-8?B?TWlWS2xRWUJob2EwQWYwRHBTekF6RjFhaTdNc085enZLMlV5aE5FOUkwUXhw?=
 =?utf-8?B?YUtFUG1INTRYRURqQ2kwczhVWnFLa1VPYy81aTh5bE9VRWJJS0lDdTNDeGFT?=
 =?utf-8?B?QjlnUmZNb05UVVZLYUllQnNQUTZ6OUdyUjFkQUVKMjBRWjNNb3h6TG1Pbk5W?=
 =?utf-8?B?c2FRUUl5eWJLcTh6WHV6OUN3eDcrOVNCcFAwK09YUFZ0SWJLRjZpKzlyYkJG?=
 =?utf-8?B?TzZIek9HMlQ4UU9YaS9IVEg3NWNCVGJmT3RsVDRNa1YxZVJQSmtCRVUzcWIv?=
 =?utf-8?B?aUU4VW50cWRsZlk2MGRTWFFrTzcwT3JIRjY4SndnRU0rdW5kTk92WUYvQnlz?=
 =?utf-8?B?VVZuTzJmMVNYcUFIOGgra1E4cG1lS05vcG5mM2FaRW1MZ1czbG1tZFdiSnJu?=
 =?utf-8?B?c1VFOW1VTnlGaVFoOE1QdkppRE9OYUNVS0wza09EU2ZVQW9jWEFnM04za2Fq?=
 =?utf-8?B?VjNEckwzMkZDTjh6dmFFV1hyR3h3VzN3UFdGaUdmcXVpaFRFQ0JndEpMTzMy?=
 =?utf-8?B?M0RTZkg1bjVOVVk1SnVobmoxQnFqdTVGK3ZnamliU2JHdHZxb2d3Y1FmZE4w?=
 =?utf-8?B?Nit4cFBlaUt4bythTWo0OTcxNHQxYmhRMkpjN1RFK3Noc21SQjZLZmhBS0da?=
 =?utf-8?B?di9EYTJPMWN6bGhVNm5lRTU5bXJqb2lNSjlUYzAzUENPQi8rcWJhNGRZYTdn?=
 =?utf-8?B?TmovcmpqU2ZXTW41V09SNUdLeG5jUDJsL1M3L1pqMHhlUmlqTHVtNUNMRzQv?=
 =?utf-8?Q?1ydUyFbKiX5XbEZq1gt4rag=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a35ef91-7cf2-447f-7c62-08d9d73fa219
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 09:24:15.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re9QYhMX24jk5xa7jXLfIHAdKHRGSEUnWtMuvW6QTn+TeuQmeKXOaMEpeW/6FflYChik83B/0Dc/GzE8BeTLLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4471
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140062
X-Proofpoint-ORIG-GUID: P-wGiNcwBm7NgOavAKldf69SnwtIWCY6
X-Proofpoint-GUID: P-wGiNcwBm7NgOavAKldf69SnwtIWCY6
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

CgpPbiAxLzEyLzIwMjIgMTE6MDMgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBU
aHUsIEphbiAxMywgMjAyMiBhdCAxMjoxMDo0OEFNIC0wNTAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
PiBUaGlzIHBhdGNoc2V0IGNvbnRhaW5zIHRoZSBmaXhlcyBmb3IgYSBmZXcgaXNzdWVzIHVuY292
ZXJlZCBkdXJpbmcgdGhlCj4+IHJldmlldyBmb3IgdGhlICJBbGxvdyBmb3IgY29uZmlndXJpbmcg
bWF4IG51bWJlciBvZiB2aXJ0cXVldWUgcGFpcnMiCj4+IHNlcmllcy4KPj4KPj4gSXQgaXMgYmFz
ZWQgb24gRWxpJ3MgZml4ZXM6Cj4+IDJlNGNkYTYzM2EyMiAoInZkcGEvbWx4NTogRml4IHRyYWNr
aW5nIG9mIGN1cnJlbnQgbnVtYmVyIG9mIFZRcyIpCj4+IGluIHRoZSB2aG9zdCB0cmVlLgo+IEl0
J3MgcmVhbGx5IGNsZWFudXBzIG1vcmUgdGhhbiBmaXhlcy4gSSdtIG5vdCBzdXJlIGFib3V0IHRo
ZQo+IGNvZGUgY2hhbmdlcyAodGhlIHZkcGEgY2hhbmdlIGxvb2tzIG9rLCBtbHg1IG9uZXMgbmVl
ZCByZXZpZXcKPiBieSBudmlkaWEgZm9sa3MpIGJ1dCBmcm9tIGRvY3VtZW50YXRpb24gUE9WIHRo
aXMgcGF0Y2hzZXQgbmVlZHMKPiBtb3JlIHdvcmsuClllYWgsIHRoaXMgY2hhbmdlc2V0IGlzIGFp
bWluZyB0byB0aWdodGVuIHRoZSBsb3NlIGVuZCBmb3VuZCBkdXJpbmcgY29kZSAKcmV2aWV3LsKg
IFdpbGwgdHJ5IHRvIGltcHJvdmUgY29tbWl0IG1lc3NhZ2UvY29tbWVudCBhbmQgZ2V0IGJhY2su
CgpUaGVyZSB3aWxsIGJlIGFub3RoZXIgc2V0IHRoYXQgSSBhbSB3b3JraW5nIG9uIGZvciByZWFs
IGlzc3Vlcy4gU3RheSB0dW5lZC4KCi1TaXdlaQo+Cj4+IFNpLVdlaSBMaXUgKDMpOgo+PiAgICB2
ZHBhOiBmYWN0b3Igb3V0IHZkcGFfc2V0X2ZlYXR1cmVzX3VubG9ja2VkIGZvciB2ZHBhIGludGVy
bmFsIHVzZQo+PiAgICB2ZHBhL21seDU6IHNldF9mZWF0dXJlcyBzaG91bGQgbmFjayBNUSBpZiBu
byBDVFJMX1ZRCj4+ICAgIHZkcGEvbWx4NTogdmFsaWRhdGUgdGhlIHF1ZXVlIHBhaXIgdmFsdWUg
ZnJvbSBkcml2ZXIKPj4KPj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKy0tLQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAg
ICAgICAgICAgICB8ICAyICstCj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICAgICAg
IHwgIDIgKy0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jICAgICAgfCAgMiArLQo+
PiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKy0t
LS0tLQo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pCj4+Cj4+IC0tIAo+PiAxLjguMy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
