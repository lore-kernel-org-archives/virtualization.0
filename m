Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEF9C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 01:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52DAE60E8A;
	Wed, 22 Dec 2021 01:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRun__9dVm-Y; Wed, 22 Dec 2021 01:56:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0835C60D66;
	Wed, 22 Dec 2021 01:56:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B495BC002F;
	Wed, 22 Dec 2021 01:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF01C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 01:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72F8760E8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 01:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1KKTTcsh0N6Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 01:56:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2645960D66
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 01:56:05 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLE6Nn009627; 
 Wed, 22 Dec 2021 01:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kcuRM924w4G8274VDd8WlHEu+jG00GJxlA4K6yAWbAM=;
 b=ouq047GEsOu3YqUAzV6QhbcL4FsnKFKdw2L+cumkiZkEdtb7T44OxFAALc8NZQfNPFaL
 v+JGDjgpV3rCBZ9dsxL4Tku35Uj/bIheAmdowUC5BIkA6/5pec3J2H8rNWnA/gzsWG4g
 YFHVk16fj4VOe4CxjRr04l5k510l0vxGh6jXnOOZ0APwvt5bTX76tMtybn8l4Pac0tkt
 tPgO2Vs7mV46K66DMCO5/a15tJwu8J4ranjwaushLsYSeXWeTyZvyhkzL2+5g8VKmunP
 0I6Srd6ga1osWHA+ztggR+eDUeYo0i9lieeEULTYHjNtYYrNmadRJltm+ULiJ+9ShyNO 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2qk2cv88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 01:56:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM1l9Xq190970;
 Wed, 22 Dec 2021 01:56:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by userp3030.oracle.com with ESMTP id 3d14rwgfna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 01:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKE/yvoOHsHJ3c7TJDtRuJusdamPBZ6iL21VH/TgBujOZOEbfN8BMwben0kQaFrycugrgNu7q5lUeJ7eWDQod8nQs5lbAmDkSgfIZJy564fpREk81tVPNvlJ5CRF1dwOiBES8voIH3xaQ2IIi3Jn2TFTSLb8TpC6ClZUxE8XDuEE9eSzEs/DVcewiezct5wDorHRjH/NE+4VKbai8gGoTgbPv55kVPAX2dmJnIB5Enpeic6r4Cg3D05dK8USfMjxDDaLBCz9BIg+dVLOyRT3cA28JITpeI1KgH1wDWupo7wbWf7l4SX6ekIThL+n2O8A+NIZA1XWo2pCVXoka91FqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcuRM924w4G8274VDd8WlHEu+jG00GJxlA4K6yAWbAM=;
 b=m1GulBcjDTY4YSTSerhRvNZ64OLpxALNmTLHZJrbTP7Y02/By2koPNaeg9pcKqiwmyRm+SviqP7bwsyl3i6Tk2gO1xnS2+ILTBaxSWnZpFjGkRyTR6GEmGpGhrE3QiUSgneweF3IgbRB2Nw/9SKSzoE757IaWRzMohd3DyKJMDH4KEmAVbRhiwK+6JblMV3Ub9HUw+QQs8kxOVdaKth2OlbvLZTQRjjNQZX7ipFyxtP2k/p97X1V38d8yWmKreNHVo5/Ft8jcawt1RVPs/9H+BfsFAPVDkM0RY7/qa2ZMrlFOgr82dePY59KMIELFlnY9u5H7ZvoM7V54CqnX1md7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcuRM924w4G8274VDd8WlHEu+jG00GJxlA4K6yAWbAM=;
 b=YnGfPMWM0BOQRHNLJ8QHgcAThrs+4cXRBV+OGtmdGRwffW7DV6f4mvnrlA6PZ1Or/APWeHb3xgmcPwyWnd12dqHLwSgOPHsR+8/JjDiXg9cfV6NQb1KAvJdG+Sye5llm9ogV4kwrO4xB6LhJsgI4dCgJBgiRld07YyJIkGP6X/M=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2469.namprd10.prod.outlook.com (2603:10b6:a02:b0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 01:56:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 01:56:01 +0000
Message-ID: <facae337-8e0b-6c14-32de-d7a2f9d48f2c@oracle.com>
Date: Tue, 21 Dec 2021 17:55:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 04/13] vdpa: Read device configuration only if
 FEATURES_OK
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-5-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-5-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f22d145-3f7b-4692-004b-08d9c4ee348d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2469:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24697E7AC4C6DC176B79AB27B17D9@BYAPR10MB2469.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhO5jU/g90H12Wmn+/XAyZMx+E5frlpMG+Rah8ltQIfPBnTeEvI0t0EzKQdOAhDGNps2Yb59LBwvN/OO/DPzPUKlSgmcJ0o7QBcEubPZnSVQRlmk8pVbS17Q3uTwwsZgZJvMBEvKoGUTzgNNNlQ0TZFD6DA0vaNSP6Bb8e8X30N/uQ+J8l57S8vyE+i/iPZTxtEZpYgDUXEhCfa/0ubX7Y0lCDLULJ+drsRg8eDOPI7kSeF+CwBEuCSdzboQBBLd/WBhTs3dRxx9iLQUqmKnW27rm4yotRDrrwjAz18ODH04vAsJGXb4doPPyqq5zoqOVtC7MjyNVvuv8WFb+S/MjOms3RiMWyqMtHwj0wTExI7u0m4WKVpAplmrQK4rRWBxDhaWHzohArN/ScnxsWHoHD9y+ti8CAzi5o9XZ7j0oNxfKwg12vInyyAZivgLAuykQEm2Y5mckkqlr9vlbJuOiEG4TK1WMpG2e8/0WcvpgX9W/Ty9C7Sv174vmTUnZ1QU/Nj9L6EpNfsyXKMiEVSIUXMF8P/gQ0YnhA/FTN75ePE7K4HmqUEU66Ba3pAwtF/OHeWMYIILriZWbR3Gm1bRywizhpPRyqLSw3mSePJ/08RJpopR3tvsdORMabrMFSqhZykCAA0cfXd4X1OTjcv1vLlF2Sg27gK9QEQJiXHNrym7X53K76jIZoCZvgpBa5LJuR35LhBqbljX69JsWrOFirhEdC5mmJxHG62T9IsJuNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(5660300002)(6486002)(8936002)(86362001)(36756003)(316002)(38100700002)(4326008)(31686004)(66476007)(2616005)(6512007)(31696002)(186003)(53546011)(83380400001)(8676002)(6506007)(26005)(36916002)(66946007)(2906002)(66556008)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJOWU9ad0J1YzhXZVE4dE1JeUc5Zk9EUHAvRG1KME56MWJ2anpNaEFFUnI4?=
 =?utf-8?B?MUNKTlpQdVJ5RmhsRDlIZVc2eTRud2pCbW9IaWxUbE9kejF1cS9XaU16N0E4?=
 =?utf-8?B?Q2RGRkVmbFNkUml2Vk9WYWZncGpudUdKVUxod3ZsNkhOMUtpcWF1R3dpSkY5?=
 =?utf-8?B?UzhtRStWRWtzVzhvL1BRUjYzWE9PaFljUlZIRFNGTUgrakh4eFpoUXZ0c3Yy?=
 =?utf-8?B?OE9xUzlyNzZFT21YQmlqdFFZMkphTzFoekRncy9HUGJXSmNoNnVidUcwVG1I?=
 =?utf-8?B?YkNjWVlqZk1taG05R1hnL2c0UWZqdGE0M1g5UkMxcWdkcUVGQ3hZVThwNkdG?=
 =?utf-8?B?YXhsNkJJQlFMSTYvUGFRWjNCNERWdDVIemNqeWdscWZvcGthWmxNSnpjbC9j?=
 =?utf-8?B?aTh4K0Jua0hNYjhsdkZGQWQ3OVd4Uk5KczY5QmphT29nelV2OU40Tjczb2Yz?=
 =?utf-8?B?MWNIMHpWWU1Kd285RzFYQXplSVFGdDl2SDg4Vm5xcXN1dk9uTDBqaVVxR2tK?=
 =?utf-8?B?OGxPVkxxMjdwOWNrNVBkYTkzR3BMY29Ma2wvMVJpTDRUM05RZDVJb2htMWdu?=
 =?utf-8?B?RHh3WDBremhKUUZ5NnVTUzlXMTdOOHNrQ01VcEx0MTJ6TDdoN3JIVDRHajcz?=
 =?utf-8?B?MDFxN0kzeDhjMEVrRStCNTlvUzRoeitqVDJYUmdnZSthZWFRRGVKK3BrcXNC?=
 =?utf-8?B?elZMTTEyWHpmK0pIYVVlRjFhM0lYMi9zRmVzcFlwT1BsZ2g3M1R0cWc0SFZ4?=
 =?utf-8?B?VVk5bXNuRk8zdHhVaWpiaGtiekhPUWFkVFJpWTc1cFczZ1Vod3NoRVBIOEpY?=
 =?utf-8?B?bUs3WCtpM1JhWi85cEtrQkcwYWI2eGdXaXBtbFJTVWlQZGdCN3MwcGR5aUd0?=
 =?utf-8?B?RnFIaUpwcGR2bjNtblVMVnFxMnRNRXlPaW5RY3FKY3NwdTdjL2J5emxtNDVo?=
 =?utf-8?B?OU02UWtwUFhRdG5tU01XdDFqZkFWYXdwTlE3RFRDNEtkbWdLMUlOcHZsVVB4?=
 =?utf-8?B?ZDRNUitnaEJwU3dpMUd3MFg0cWZnYmFoVkdUOXJGWWlYMFlpRVBoazRSTVR3?=
 =?utf-8?B?NkVGZU5MK0ljYjhPVUI4eUJ1eGE5a1JDZGhHb2dsQ2NSQk5uYSsvL05IRjcr?=
 =?utf-8?B?OExnMDFBeTZIeUdJaDVhWFV4cHVmTm9WTzNrWDhYNXVpNGxQZWhwakYrc3hY?=
 =?utf-8?B?TjhEYVZkUEJiZWduVjBEdnl6aXRGS3cvVXBjWkVUNEFtWHlLWis4eXI1cHkz?=
 =?utf-8?B?cjlYaEZLRC9ISGxIUGJlSHh2di9oUkIybU5aRW9mQTdhREYyRlBZSHlncmNS?=
 =?utf-8?B?a2YwUTM0Q0R4K1pZc2pTOS9Fb2ZraURTNXA4NGc5RVBhQkI2UDNjSmpoK21p?=
 =?utf-8?B?MFJzYXA2c01PQ0NFRFZIeGlabEp0blVCWmp5OUtWN3pzZC9jOHF6cGVORS9O?=
 =?utf-8?B?MHZIZjRWL290VStrOG94MHN2dERhNFM5SG1rcHFFU1dqY2IvZVQraW0rOHpS?=
 =?utf-8?B?a2ErdlB2aU4wR1dRTWhGdlNmajI1OCt5aVdMZlBxVXFCQ2FkNW41clRrS05R?=
 =?utf-8?B?cFpBL0czSStwRXlqY0Y4d2ozUWh5dmFadVozSFNZT0pmMjlHL1JjdWVFRTlH?=
 =?utf-8?B?OUVyT0RjaVVPM0N1SDUvS0tjVXhtN2EzU1JQcDY5NHp0OFhHQ253UmxsMFBl?=
 =?utf-8?B?aURJYTVTclRpWmRjZlRFV3ljTHBZaHMwM2kwOFkxMHNnZUpKR0VteW9DVnlY?=
 =?utf-8?B?WDBVTmlKZ2xnbGtTeThUUUZiODFNbGVZNDFlSzRLaHdtMEVUTG1pNVcxdjE4?=
 =?utf-8?B?aUgyOGtWSFg4T0RCczRCVjZhWTZmSUQvUE5rWG1wOHJmRlYwcE5ZMmpGeVVU?=
 =?utf-8?B?b241U2pzTFNSN3RvbzFEM2RKdS9VM1krUDFJcDdMdjI4eHJlOWp6RERnVzd6?=
 =?utf-8?B?dFVpMHJKWkZjVll1ai93azk5WVVic21BOEtVWW01WEErcEZVdDV0MnQ5bWhX?=
 =?utf-8?B?bGlWdWtSbHN3N0ordmxrMEY1ZnBjQUR2alJrYmtSTHF5UHdnZDFKOGJrVnJ6?=
 =?utf-8?B?b2J1Ni85OHUyRVJTUXdXNmE0UlZ5eEJEOTV6UlhBM1hIejdFSlpBVUttMEd0?=
 =?utf-8?B?Q1J6dS90OW1DV2dLbFlDWnpqTWhwcFFrYlVhWFdqWTI5VU9URURVY3hYalFy?=
 =?utf-8?Q?8+yBF8rfOH8KjZ8pOKOa7t8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f22d145-3f7b-4692-004b-08d9c4ee348d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 01:56:01.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWGAVDPlNGVIzcyX6XC/8uxBcxo+zJtRFNBbo6p7KBCN5FGw4NfFRY2cg4pPGN+xvRQ/MOMNxS+DVPigaPCDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2469
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112220009
X-Proofpoint-GUID: I84aE4EPqXNcqUIhFubBMAFh6JQvSw9g
X-Proofpoint-ORIG-GUID: I84aE4EPqXNcqUIhFubBMAFh6JQvSw9g
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



On 12/21/2021 9:19 AM, Eli Cohen wrote:
> Avoid reading device configuration during feature negotiation. Read
> device status and verify that VIRTIO_CONFIG_S_FEATURES_OK is set.
>
> Otherwise, return -EAGAIN.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 5134c83c4a22..3285cebd89c0 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -838,8 +838,18 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>   {
>   	u32 device_id;
>   	void *hdr;
> +	u8 status;
>   	int err;
>   
> +	mutex_lock(&vdev->cf_mutex);
> +	status = vdev->config->get_status(vdev);
Atomicity and data consistency not guaranteed against vdpa_get_config 
and get_features in vdpa_dev_net_config_fill(). Need to use coarse locking.

-Siwei
> +	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
> +		mutex_unlock(&vdev->cf_mutex);
> +		return -EAGAIN;
> +	}
> +	mutex_unlock(&vdev->cf_mutex);
> +
>   	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>   			  VDPA_CMD_DEV_CONFIG_GET);
>   	if (!hdr)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
