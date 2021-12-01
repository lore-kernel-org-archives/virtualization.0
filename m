Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35C6C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 01:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5607B400D1;
	Wed,  1 Dec 2021 01:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RvMAWLTZYmrF; Wed,  1 Dec 2021 01:24:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 936F64012E;
	Wed,  1 Dec 2021 01:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60833C001C;
	Wed,  1 Dec 2021 01:24:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57924C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 328784032D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="GAS8F06O";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="t0Bl7Gf9"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UstG73Q4EUqS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:24:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 095B34032C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 01:24:13 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUNfnbV016593; 
 Wed, 1 Dec 2021 01:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HY6KEuFci8JS+Gb1BoJYNLycaWK7hVw6kk8jwcbCfyM=;
 b=GAS8F06OqnMn498tJTcN7It1tZmE6YGsjSnIhtcwaizsVHAjUcJ8Dy+yHDDkT9WtubBu
 Z2tZtZ6vdySib8iklZI66ZwgvPDiQhTc0ZgYTyKm7zgY9Arem5z5o8K0wWP3OCtWtH6L
 7FEwwthZZHe9SsjcInkiQYG6FDpxCnTacAA8K2442cr8U8Wi+toqyoN4tWetp8zoJYlC
 DXO9agtZsZxGq9mvcMnYWqLmJHgTQQWtXA4yb2V56SvD0L3qNudKopCcbryurodQNbCj
 MvjyLmELKBCX1xL9Fp7u660pC63mcJ/9KNtBroWk/mbb3pejzmwlo7AJahva1j8pkDh7 iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wmwr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 01:24:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B11FgNW189165;
 Wed, 1 Dec 2021 01:24:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by aserp3030.oracle.com with ESMTP id 3ckaqfq0bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Dec 2021 01:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyiqzLgtHJEk9enTpR6gG070DwBN+f8xRPd9Cvfpw/R82BhcIG3/DTdOVI/xEdYKc0v0ciaGWV9pQkEYYJiVHaWOPnaCzY49b6M9SetWqVaAD3lBv2H+C8/oEiIhOFihjxur7BTZ67tLJgO5R1wgFkQU9XOIfuqkv6yYC0PpNyBxjbIReA0FvQB0ysJ4M70Bo8OyLVsmUfKSbXDevD2806KYutSF/MKnW0CJh7Fw0f81dNCJtEA0z4CN4s+N6o7dexgqXjU5liygMyTnooCyY9mfjvjAmdkZDpTA9Q4hKy8LV8jjB02wP6/t9ciny7O746qDC94e+CalZZgG8IiGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY6KEuFci8JS+Gb1BoJYNLycaWK7hVw6kk8jwcbCfyM=;
 b=TGBE6KKCa6M29KmioiCLhDxg6QA7KPGRr6AnLz1JtqU7+ZGa60ZYNZroQl/ll34u34AJTrZGUq2S+snv2E7ONGmJVpy+E8+gZMZ4JZVe3sae3Ibz0xtrpu5UrwWWfKOrNIxyBKxvRu6RP/CgKl6raR4V9c5lypnhhVRJB3b7XJiFEULI7YPTYr1apRlNSTYhoJfgid2DYOfojb+z5YYJRVZ6OehwTf756ffbufTLmHOOcZsWp6BmpfDCQfeveeS1ddMFdHBRs5XvQgxzOK/8a4kYPLYUXlHmx8Thucc2nSxF7HVw8YREGvFlh/kwI8c80lmAOLzo7jF88EmCj8Vkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HY6KEuFci8JS+Gb1BoJYNLycaWK7hVw6kk8jwcbCfyM=;
 b=t0Bl7Gf9rglD80RBDhNkXhQN5f57982cmQE1cM2TN8qlSZ9jG+t53vny64v1Ar5LwnUeh9h2qQguTzO9LTkqcT0EZvFb9q3lVOHJF3kTykgwYM667W/4Wc7PVVolMdnPtX4ZSHzAVop45uPArgcI+M99PYBQz7t/js9+4gHsLwk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2981.namprd10.prod.outlook.com (2603:10b6:a03:8d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 01:24:08 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 01:24:08 +0000
Message-ID: <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
Date: Tue, 30 Nov 2021 17:24:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211130094838.15489-2-elic@nvidia.com>
X-ClientProxiedBy: SN4PR0501CA0127.namprd05.prod.outlook.com
 (2603:10b6:803:42::44) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.158.73] (138.3.200.9) by
 SN4PR0501CA0127.namprd05.prod.outlook.com (2603:10b6:803:42::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 01:24:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b53bc5-bf7c-4089-d3cd-08d9b469458b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2981:
X-Microsoft-Antispam-PRVS: <BYAPR10MB29815252371F50E33507270EB1689@BYAPR10MB2981.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsPwi5IjKo+r7/dluJ+TQOqoQ+aEBOF1BFnRUvNN3Bobwfv190ku07bDUzzG1SSufE2g7FGIYJ0xtF16c5aTESxVbOrtnW4NxuHH/faKgFz+Wr/0kmIZVb9Rx5gkwD5+ndOoIv+zNc942445xXiYsZDtt2GEZX4kMxSXS6bkYtNsG0h5ZR/B6/sbILdpJXRei0iZ82RL+xrZn0lC83wqFAWuU2/UF2kflqHndxJ/Sy5gsemv3vIeyvRVWFcpSqNrU2YeMZKohnIT6bn3yciKNccD95u0mQGFM+FDitIGQKanBc2xLbb+2LT8KqFZtm3X6rDlvZ54sH7Y8dIqKTjO5xmL0PZ3halvRzTVe+1mFD2iwoK2XZ2G3+gdkjyaOhv0/WuYpEsElBayJ7h1E18GuQSJiJowCz1evgMwyLJz0FKuSOIMZBPAMXearGXVJzcKrn0MQgvI+3sxuuDLt5XjlYKd26uHu9Sy7ClcTzRPnyM15MaebhIoEaByMEo1EtWwTK6XWCekyfHG/P/kFe9DhXdWQCiTz6g3JSc1fREjY4otd7GYDGEJDrJ67DOPEtFlFC2aa+JCwbD+KmvUn+s7skP//RY0yfzM7/f6+yWP5+cAKzcu/Pr9cylQnO4Y1FLthGEZ+tfBZgaDRzgg9Dg8IkLOScsla7yAoOxldR7gf8CzTTqy22cZD+SDLweTQypo/obR61ZIEwTMb/C7S3L8tZ36jwj98e+C8EIonUFNJ78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2616005)(6486002)(2906002)(83380400001)(66946007)(66476007)(26005)(956004)(6666004)(66556008)(316002)(53546011)(8936002)(8676002)(36756003)(38100700002)(31696002)(186003)(16576012)(5660300002)(4326008)(31686004)(86362001)(36916002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVZYYVpsT0ZZSDZ3bkcvYXdjSkFxWnZOSzMxSC9oMGVQZis1NHBwS25pZjh3?=
 =?utf-8?B?cTVRbThvUzJVVTRJTS9tQjIzSjhqamQxUEpRVGpmM1BaWGhOUk5pQW4vQnll?=
 =?utf-8?B?bzlkNXNLRE1ra3BQMGpVLzZKNjJFUjFDOTJDMXNwSFFybHZHczBENXZ3QzVF?=
 =?utf-8?B?SzJmbndObmtZM0pOaHp3bDZSNGZOZ1hQQnB2SFdOeExYN2M5NGJVRk5SbzRD?=
 =?utf-8?B?RWVqWFBoQUIrV2hrcGtSeHdJWTRkYlVRV1dtRllYenhPWG9FY0FiZzRTTmFM?=
 =?utf-8?B?cDZrNWRlV1IzM2JMMk8zWnpmd1V6c3NTUXFhNmp0VTAwajVHUUhOdTYvdWU0?=
 =?utf-8?B?WGZFM05MUFY0MG55Zm9KTVgrSXJuaEZFZGZhZmZIMG9JeVcxR1RhZDVXUEdE?=
 =?utf-8?B?UW1ndnd5cHI4NWhrWUI2bmdIcUlTN0RORnpFYzYzRFlQNFVkcDJSUnhiaW55?=
 =?utf-8?B?YnluZ1ZPMmlpYi9rZElMcXpSNVcxMUpkRStndGFmU3ArT0NiNmxRUWs5VzNS?=
 =?utf-8?B?cFBSM2tUYWg2c0FWQXh5NUlRamlNbndEMG9kWUFZa0xiWmErb1R2aHpqS3Ru?=
 =?utf-8?B?ZGRQUG5UL2hDMEtlaUZDQWJac2I3NzQzOEFrRi8zYnk5U3NnNGJseTBTazl2?=
 =?utf-8?B?Zm8zT0tWdFcxam9RcHc2ZTM2a1JYTlBjZ0ViK0o2U0VoTDArbmF2Szg5Y1Zr?=
 =?utf-8?B?MU16MDNqNENmSTZRZWJqNG9ubWJ5dmUrMThqMVJwcXN6bTdHTWdsTlJQYkIw?=
 =?utf-8?B?bDM0V3Fqd2V5bW8rNFdkZ1IrL2VqREo0RVhocmRwcWQ1UlRjaVh1bzVCenkr?=
 =?utf-8?B?TXhiYm0vSVFZMjJHWVpBaE8rNUJXSDJpbGpFb0R3OFhCaUdHbWFPZFJRVysy?=
 =?utf-8?B?TDBUcjMvdFJnY0IzVkNzUWl2R1EvaW1FVTAwNjY2OWp4Ty9HRWd5NlRmKzl3?=
 =?utf-8?B?NC9TYUhaZFh2L0pSS243cXgrKzFEYkV4ajhQMm9BMnNKUUoyYTdZL2EyTjVY?=
 =?utf-8?B?bmFLclczVFloMlRMcisvR1NrMWhkQ1RVQmJHTmlmR0NvajFRMUR4SnRtRG9p?=
 =?utf-8?B?dHRaRlZpdnJqRjNZei8xVyt3ZThzMk5BdjYvdGhBelpDMTMvQkhZaDRnSW1l?=
 =?utf-8?B?WXF0cGZLWW4zRUE2Yzc4VnFSdWZiMnRUUzJ5UUF1U2QrenJtNmp6Rk9KeHhP?=
 =?utf-8?B?UU1VUytnK1NjZXhlMTFJMzJpTGFUL3J4M3NUeEtoUHIxSnpGTis2VThvK1dO?=
 =?utf-8?B?czRZREZkUS9TZlQzWjdGTnVtSkp4Z0pTTWQ3NFdiWEtmUEN4ZzdqbGM3VGVa?=
 =?utf-8?B?TlYzODhubkZZSzZuMVVtck4rcWovZFoyN3lzMTNUeUZvdkVVaUlrZDFaKzdK?=
 =?utf-8?B?SHVBU3B5dXFYazZ1dml6UjJnUFdaaGdUNkxwSU5oYkpEemtpZTBJR2NFRGdL?=
 =?utf-8?B?MjdvOVBjNUZlMlhDaEd2TkJ3L2I3cDFjNFpkbU5Uek9wbTlGTVNWd25hNHpn?=
 =?utf-8?B?ek82NExrVFM0WEFJQ0dKdm1SdUo2ejN2V1F1Y2dQZWg0UlgybzVqRjlEM2RX?=
 =?utf-8?B?dkE1WHNTMnM1MzVhL1krM1pkaERaNk94bEQ1RDQyd0hSQ3N2YzM4dTBSYlJJ?=
 =?utf-8?B?dGpUdjd5M281dE5Dd0UxbDM0bnFBMkhyQjR4RnQxb09nT3RKUjVlZ3h2RzR3?=
 =?utf-8?B?bnJSMWJqcWQ4dzZ4Q3o0R1V6dE53V1pwYzArMW9OTmE2dlpMNkcyOWlmbGZq?=
 =?utf-8?B?TUdQbDRseFJSanpLdFNJdkM1dDJiZlFGN2k3Y09YTFJtc2ovcVdPQldtVGFa?=
 =?utf-8?B?Nk56MzVRTkJRd3N2cHJYTE1vVkMxZFhTeG9JRXpiTVVPTlVVdHgxVCtTRFNk?=
 =?utf-8?B?a0gxZG9qV2w3SVVDdFh2K1d2U1ZTYlNraUY1RkExRVJtU1UyWGtBMDhjL0lQ?=
 =?utf-8?B?c1p5RlJTT3YySUlHMzl3TWQ1NDdxLys4WlBkdncyWjYyczRyeGhJci81enNk?=
 =?utf-8?B?YUY4U01nT08wQXcrRkRUK014V0NDZDU3ZlU1MXo5azRQd2UvRjhsQlFDQmow?=
 =?utf-8?B?clFRQWVJMkFvUXRqelBUeVlmUnJsdW43RlJwcHZFTjV0cHFUbkkvRGxSUFUy?=
 =?utf-8?B?ZDZrcmMvTUp5L2dCVjB2L1R2amp1SkYyWmZDa0FnRmNpOGk0Rkl3eE83dzJr?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b53bc5-bf7c-4089-d3cd-08d9b469458b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 01:24:08.2552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja17MEp4oYjRy5I6jDvNz/MGZoKsZoEq8nz/at+1jh6tO+PhyARGGIjc7rH0f8DMWLZWSmmYNL+bkybhEHxZfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010006
X-Proofpoint-GUID: 0P-OiOjf5V-rKVXvFDWyHT3l5AOH91Qb
X-Proofpoint-ORIG-GUID: 0P-OiOjf5V-rKVXvFDWyHT3l5AOH91Qb
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



On 11/30/2021 1:48 AM, Eli Cohen wrote:
> Allow to configure the max virtqueues for a device.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c  | 16 +++++++++++++++-
>   include/linux/vdpa.h |  1 +
>   2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..e185ec2ee851 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   }
>   
>   #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
It seems VDPA_ATTR_DEV_MAX_VQS (u32) is what you want (# of data 
virtqueues instead of # of data virtqueue pairs)? Not sure what's 
possible use of VDPA_ATTR_DEV_NET_CFG_MAX_VQP, was it to dump/display 
the config space max_virtqueue_pairs value (u16, 1-32768) for 
virtio-net? Why there's such quasi-duplicate attribute introduced in the 
first place?

Not even sure VDPA_ATTR_DEV_MAX_VQS by definition should include other 
virtqueues as well: such as control virtqueue or event virtqueue. Hence 
the name will be more applicable to vdpa devices of other virtio type 
than just virtio-net. Otherwise I would think this attribute is slightly 
misnamed (max_data_vqs might be a proper name).

>   
>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -506,6 +507,19 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>   		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>   	}
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> +		config.max_virtqueues = nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> +		if (config.max_virtqueues < 2) {
> +			NL_SET_ERR_MSG_MOD(info->extack, "At least two virtqueues are required");
> +			return -EINVAL;
> +		}
> +		if ((config.max_virtqueues - 1) & config.max_virtqueues) {
> +			NL_SET_ERR_MSG_MOD(info->extack,
> +					   "Must provide power of two number of virtqueues");
Why there's such limitation for the number of vDPA virtqueues? I thought 
the software virtio doesn't have this limitation (power of two).

-Siwei

> +			return -EINVAL;
> +		}
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	}
>   
>   	/* Skip checking capability if user didn't prefer to configure any
>   	 * device networking attributes. It is likely that user might have used
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..2f0b09c6d1ae 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>   		u16 mtu;
>   	} net;
>   	u64 mask;
> +	u16 max_virtqueues;
>   };
>   
>   /**

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
