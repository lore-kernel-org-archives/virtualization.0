Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B854BC433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 08:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A586409DE;
	Fri, 14 Jan 2022 08:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yRER3vnxCh0F; Fri, 14 Jan 2022 08:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C550E4028C;
	Fri, 14 Jan 2022 08:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E626C0030;
	Fri, 14 Jan 2022 08:52:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E299C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E88660F2F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new); dkim=neutral
 reason="invalid (public key: not available)" header.d=oracle.com
 header.b="0IMp5Hsh"; dkim=pass (1024-bit key)
 header.d=oracle.onmicrosoft.com header.b="Jo+/Va8F"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BdYsdwmd_n4l
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B2E360F26
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 08:52:11 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E8UiTh002522; 
 Fri, 14 Jan 2022 08:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VFNMxn1KpjqLQtgghLhuZFb7n46sHTAxdRuAgtRopzc=;
 b=0IMp5HshXHMLSrQ7Oea8j40tGZtxoGHkLkf/sWGZPRtlj1gw0x9HIrjL8eVgdRhIMiaM
 gdJ3oMV3KnnV81SGNMM6Z27BdDfxDNOSVYJNkIMKPSeI7Lvh8mDDC7JAZHvOkmkE2GGu
 PmK4M5VFasx/qYgtgtQxYG2FDsBj9Lkgn/X5am3dh7YeXbfr5Xgk0D+bHqf+og6A1Rfb
 63W8Up9Wfg5YMtMtoPB8b/+0PdhZpxLZqnEZm3muDDVTj78N8GUGFxVPmsukj15TI5Jq
 hdJ8bypVvpSCrueZk5z/b2FcV17e5VBJvGuH6gaIi5keSOG3BEQW9dSgh/HCiV23DOb5 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djkdnu7np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jan 2022 08:52:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20E8q8PR098760;
 Fri, 14 Jan 2022 08:52:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by aserp3020.oracle.com with ESMTP id 3df2e93ry0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jan 2022 08:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR80meGIkOMqKnid2BX+mfV9yoPELXUKjO9klC3/UdHnBJ/qIoiT87g57roIDtp0VDhYksP7MudNPVu8zgf3uA3ADzqM0TDG3/mYX2OobXvQyk6W849I8pHPRbU2BebUgwHVZ4cVwwtKJo2cigmy98H8KpHPDEM3hvPr0PWvTAmMe9m8c4iBNvV0XHMJDsj5cGih6qGSj4cgoKTNzelS21yB+xpSkzSLUuD3uGz3kYvz1yp0dJZySsQ+KRq4YiJ3b7uYWfo74fS7h5NbNDuEoY4Jyj2wnChY8JcdZBFjXfqzOdrN9UYgH4Dv5mUJNz7CZt5womY/oKrKAtxyUy/OJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFNMxn1KpjqLQtgghLhuZFb7n46sHTAxdRuAgtRopzc=;
 b=jweIuA3BCYF9uMmqAOMgk6q/QPJR8SEuSuT0xfCIxcUPn/+q1GvYU/5xntlEi9BFjPnMirVJHh8iGgR+l/zJuz5EddMkW7V29LWZ8p6gjA2D5B6i8PRNXN9VdYxmLQJA9zQ/MQ5l2EximqD1G93nY1SPnyIC2tzKKQqTllo8fSt5S5Iic4JTBrQw6qVbWuJhNnzr+OTB2q6DGiOAO+zTW2EF1EstztejSnJok4OI0+ilqFqmW/mBc+U41eAwRj1235mzLsHhGuyYgWqzcilCO2gWodYmVj4ANspkEBUmkmralp3/2wP20mFYCqln/RC7uaPfwOYOaJ2j/g3x/nyhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFNMxn1KpjqLQtgghLhuZFb7n46sHTAxdRuAgtRopzc=;
 b=Jo+/Va8FBcPoQoHyOOVNbpkJyvx+Hzbhn29NuunbattSML2ZYn5hIAxloJUDC7EeQB8znNft7GxUSEU1bhbK3Ru+3hgvHvXH+gVEybBxs7qZsNhxAZZXduSwzpKUqgavjqYXea4qsID/FV0fvYEF55inMgC9IBZSGzBd04ie6mg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM6PR10MB3546.namprd10.prod.outlook.com (2603:10b6:5:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 08:52:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 08:52:01 +0000
Message-ID: <5d0e9db9-5649-6afc-f7d0-9723cddd59b0@oracle.com>
Date: Fri, 14 Jan 2022 00:51:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 2/3] vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-3-git-send-email-si-wei.liu@oracle.com>
 <20220113014704-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220113014704-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c95ddd-6ed8-4460-86a4-08d9d73b2100
X-MS-TrafficTypeDiagnostic: DM6PR10MB3546:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB35464907B73B2BB8CA30B048B1549@DM6PR10MB3546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kL5KQ0me5qiUPNMbkxv6vFiPTh1aU93QI32Rt1MCK2juJKTX3bXeM7rI9Ivoj3bJGtUaynqz7zTO4BRUwLevJsGbwwcCvgtfHVaEO915w3IjmChfUC7vuyREIAOJIkabBYQAgEVjnBk82V0cn9CPuf7XSI9aslXu6emRS674cMIB0zuvWMbhBhjiWQJDjuz+N/hcwLS6Toc1p673ajsVB3Qet5HfTxbM4brD3FJazyAHY4WBUpPcMjIVBKe8X465O5UKtZ1M8BwB/LSJI6WhhKRXSVMnHsM+n/iqmgQV/PbMPUnM8zp8xNvxu/IR/8aRJIe3fRUoE1TediR3Qb3tzYGMaSxFQHpdBr9LziIL8xlD+OaCbunUSK+pPoeX1+QRUoeXYPLdJ1IOBN1NIo4LUlWSn4FM1cu6uWK6II4dYljGoHXWGeZ35X7A5jtVUEJSGbbU4vBpf7nH61wXO69uqjbQIKGLCr/XTYznzO68C3t2hFx9Rj3OyieZCHh8wbmaED+zFXkdcCZaUgFhALUG8TqOdQdcwxGwUWs+ZsrwFuA9KwMYz2HC/zOY+ZrTB5ulG2eeY/7Uxy/jEvTVyb4Z1alo0mpxDoS3Cvyb/WlyWjhSqC8RN5kcKlslu2xgHCQJESNDN40qYTn3BlZIdXum7l2VLyBJByFz9cq9BD2+cPuOid1rZAsMTRBjpKdETNYDEAPas3HFyWhouOkSyeOOvCnt2kmC52RgzPDCVAbW+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8936002)(36756003)(86362001)(6916009)(38100700002)(83380400001)(2906002)(6486002)(2616005)(36916002)(316002)(4326008)(66556008)(53546011)(6506007)(66476007)(66946007)(26005)(508600001)(186003)(6512007)(31696002)(8676002)(31686004)(5660300002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1zYkZveGZ1anB2KzlIWDFtMDZpVVFoU0lrdUkwR2VkZzFuYk1OQXh3SmlT?=
 =?utf-8?B?dThMNW5JOFpCL3FrWHgyblFWVklRMnprOWJCd3VMTjdKbWE5UzVvN3FQNnFa?=
 =?utf-8?B?UThtc1JFRGlhcXVBS1duSGxsWlQwNVd1cS9URis1V0xicHUwWHNNMDZIOG9z?=
 =?utf-8?B?anc5RjlEZW1sQXRiaUtQc2xGc2N3SXl1M3NCNS9aZ1BNTHA5eXFPMVhteC9X?=
 =?utf-8?B?VjRSOUswSWJ6M2NJK1NTZHFuNjRTWk1jeWNERGw3cXBMVXgwMFg2UkEybUpN?=
 =?utf-8?B?dXZRMHRUTDgycmxZSFpETlZHQnNyZkd6RFlNTTZWWGZhMEVMczRWLy8yVXNz?=
 =?utf-8?B?bmZxUmhWMVBNUGc2eHhvS0tEaHVoTFEra1B2ZDlad3hMa1NHVWdSWjA2SVpy?=
 =?utf-8?B?YnNsRVRZbTdMYUdRczJ5RlVHcW0wTU11NXA4c01nWk4vNHVyalJoODl3UXhW?=
 =?utf-8?B?NXQxT0FiTEF2ZEhqd1VmWEp3dnpDYmJjRmE2UkQ4eWMxMlpBRUNVRVpWeGFs?=
 =?utf-8?B?Rit6Mnh5OHdNWFoxSFJWcFFZa2dnak9mcFVKcGkvcnhyWm1NQnJvN2VTaVhP?=
 =?utf-8?B?QUhsbHlvd1ZkZnlFa21FZG05clU2c3dzUGZnaERRSis1Y1pGL3hhQ2hCbllN?=
 =?utf-8?B?ZGtLQ0xBbmUvMDd3TG94MkVNaGxaT1VUUFBqQ3BGYzgvSWtRN21lK2lFVjQw?=
 =?utf-8?B?SE1mM3IzR09NR2ExTnQ2N2hlSURRd3VDUUR6NDRDMzIvVnUzMUpDUWF1U1h3?=
 =?utf-8?B?dXNvdnFubTVLQk1MU3lxdW4vYXNVTmJEeVV3YzRWUWJNTEJ1V2l6TUVBZmlo?=
 =?utf-8?B?cjhQVjQ4bk5qVm56NnhSVGpBRnpEYmY4SW4xMHlvUGlRTCtXNU5PeFZseUZW?=
 =?utf-8?B?cm40TG1GS2RJblEvS0dIcnVEUkRtNzFlbFNrR0RNTWpCbjJWblNLSE9Yemlw?=
 =?utf-8?B?aWp2Z1RZYksrV1BwYjdXNHdiSzNhVkovWkx5aDFkSllDak0vYS9OQ0ZRcWwy?=
 =?utf-8?B?UngxcFZmVi94aHVEN3BseXJLTjhxUkF3aVZRK04zSFY5UFFpeUY4R1FHMTVa?=
 =?utf-8?B?dlU1K1BFVUwzMEFCT1IzRytEeWYrTTI1Tkxubm5mcXF3RjhOeGxWSXgxbHZu?=
 =?utf-8?B?VDNYOW1jSy90UTc3QzhCclp1UEEvb25MdHVUOTRwT3IyTXRpMUE5a1ZPT0xH?=
 =?utf-8?B?RVk1YmMzcmJrTmRYbmhVRmhqQ1NYK1JIdGxuam1QRzFIQnM4Zk5hWWRrTExt?=
 =?utf-8?B?cUt4OGROazBMaE9BK0F3MEhNRy9vVmFleE1NSDcrK3ZsVWQyMWIydk5nZVlr?=
 =?utf-8?B?a0U4UUNlQTIyZFRmZGE0eWNiU1krOUZNWlZVcHVXNGkwcG10Mm14ZkhWdSsv?=
 =?utf-8?B?M2NPN2toMk9hVDJLWXV4aUhMYXMxRkhRNS8reTd0MjRVYnlqL2ZOSms5THdT?=
 =?utf-8?B?NW1FeWJRaWNGQUptR2RjZXUwOG13Unc1UlZzOXBoTk1nNE50bFptSGxSOWhP?=
 =?utf-8?B?UlN0VjZiUUVMZlFLSmRFZ3B1V0Nkdml6eTlyU2w3L09wc1N0dkZyTVNWMG9h?=
 =?utf-8?B?WXd1MG1UL2xScGJIK040dk9ZdlQvVzhGaTBaaDdCQ1JEeStLOXR5eUlyZTdo?=
 =?utf-8?B?Z1VtQkM0bERwZGdIOFA2aEwvS3QwV2hTcGkzVDhTY1F5c3VMQTFIUlBqdXRU?=
 =?utf-8?B?UWVmMFoyMHgxd3RCNjdSMVVqSGFsdlhYeTR3OW9JVjZZbERIY0VYVXFJQ1Rw?=
 =?utf-8?B?ak8vSUI1SkkwWk9GcFdaREY5OSs5MUErUm1jWmtOWlVRUkw0YWxIbDREaitm?=
 =?utf-8?B?NE1hMnRrUnBnN2JSWHpYcjhCRXRSMVUzdXcrTHMvZTZEUmQ5MUxDamdYMGlI?=
 =?utf-8?B?MHhHaGN3dWZrUU9COEJuYnZtbjl1RUtjaGMxMmdBUWxmR08yeGd2Sm5PazRu?=
 =?utf-8?B?Q25YUEROR3dqVWxGdzBubmQ2U2ROc0FBYzQvWTlPQy9mMENBMDJScXgrNFJQ?=
 =?utf-8?B?bzVycFUrSmprUmVjL29hR05TZ08wcVcwVE5qTHdvVzJzMHBMZU9nTHBnSVNr?=
 =?utf-8?B?UXo1K2YwM3BlazZLMHkzLytxcWxXQktCY2I1NzcyWURjMzJCcGZiNnZxa1JQ?=
 =?utf-8?B?STlRTzJITU5BZ3YzWWU0MHhvZUxrTTdLRkdyemdkRmFIWUx2aVNFT1R3TjI0?=
 =?utf-8?Q?lgcScINfJgKBkqkBGrEhUys=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c95ddd-6ed8-4460-86a4-08d9d73b2100
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 08:52:01.0891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHmoCcIhR9W1TafIsAmMGKs16nI4G5rLjJdB2qe/qwLsF01thBUE2G6hyzn9a42u7brVUJ4uLZJlUHi1MBRTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10226
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140059
X-Proofpoint-GUID: d2iRz4dwLVP3nY7GEtW_IfDxasQ-UoWh
X-Proofpoint-ORIG-GUID: d2iRz4dwLVP3nY7GEtW_IfDxasQ-UoWh
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 1/12/2022 10:57 PM, Michael S. Tsirkin wrote:
> On Thu, Jan 13, 2022 at 12:10:50AM -0500, Si-Wei Liu wrote:
>> Made corresponding change per spec:
>
>> The device MUST NOT offer a feature which requires another feature
>> which was not offered.
> Says nothing about the driver though, and you seem to be
> doing things to driver features?
Yes, it's about validation for driver features, though the spec doesn't 
have clear way how to deal with this situation. I guess this in reality 
leaves quite some space for the implementation. To step back, in recent 
days with latent spec revision for feature negotiation due to endianness 
and MTU validation, what do we expect device to work if the driver is 
not compliant and comes up with invalid features set? To clear a subset 
of driver features unsupported by the device, such that driver may 
figure out by reading it from device config space later on? Or fail the 
entire features and have driver to re-try a different setting? Do you 
feel its possible for device to clear a subset of invalid or unsupported 
features sent down by the driver, which may allow driver continue to 
work without having to fail the entire feature negotiation?

The current userspace implementation in qemu may filter out invalid 
features from driver by clearing a subset and tailor it to fit what 
host/device can offer. I thought it should be safe to follow the 
existing practice. That way guest driver can get know of the effective 
features during feature negotiation, or after features_ok is set (that's 
what I call by "re-read" of features, sorry if I used the wrong term). 
Did I miss something? I can definitely add more explanation for the 
motivation, remove the reference to spec and delete the Fixes tag to 
avoid confusions. Do you think this would work?

Another option would be just return failure for the 
set_driver_features() call when seeing (MQ && !CTRL_VQ). Simple enough 
and easy to implement. Efficient to indicate which individual feature is 
failing? Probably not, driver has to retry a few times using binary 
search to know.

> pls explain the motivation. which config are you trying to
> fix what is current and expected behaviour.
The current mq code for mlx5_vdpa driver is written in the assumption 
that MQ must come together with CTRL_VQ. I would like to point out that 
right now there's nowhere in the host side even QEMU to guarantee this 
assumption would hold. Were there a malicious driver sending down MQ 
without CTRL_VQ, it would compromise various spots such as 
is_index_valid() and is_ctrl_vq_idx(). This doesn't end up with 
immediate panic or security loophole in the host currently, but still 
the chance for this being taken advantage of is not zero, especially 
when future code change is involved. You can say it's code cleanup, but 
the added check helps harden the crispy assumption and assures peace of 
mind.

>
>> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
>
> It's all theoretical right? Fixes really means
> "if you have commit ABC then you should pick this one up".
> not really appropriate for theoretical fixes.
Yeah. This was discovered in code review. Didn't see a real issue. I can 
remove the tag.

-Siwei
>
>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index b53603d..46d4deb 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1897,11 +1897,21 @@ static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
>>   	return ndev->mvdev.mlx_features;
>>   }
>>   
>> -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
>> +static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 *features)
>
> Good rename actually but document in commit log with an
> explanation.
>
>>   {
>> -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
>> +	/* minimum features to expect */
>> +	if (!(*features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
>>   		return -EOPNOTSUPP;
>>   
>> +	/* Double check features combination sent down by the driver.
>> +	 * NACK invalid feature due to the absence of depended feature.
> Pls rewrite this to make it grammatical.  There's no NACK in spec. What
> does this do? Fails to set FEATURES_OK?
>
>> +	 * Driver is expected to re-read the negotiated features once
>> +	 * return from set_driver_features.
> once return is ungrammatical. What to say here depends on what
> you mean by this, so I'm not sure.
>
>
> Here's text from spec:
>
> \item\label{itm:General Initialization And Device Operation /
> Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
>     understood by the OS and driver to the device.  During this step the
>     driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
>
> \item\label{itm:General Initialization And Device Operation / Device Initialization / Set FEATURES-OK} Set the FEATURES_OK status bit.  The driver MUST NOT accept
>     new feature bits after this step.
>
> \item\label{itm:General Initialization And Device Operation / Device Initialization / Re-read FEATURES-OK} Re-read \field{device status} to ensure the FEATURES_OK bit is still
>     set: otherwise, the device does not support our subset of features
>     and the device is unusable.
>
> \item\label{itm:General Initialization And Device Operation / Device Initialization / Device-specific Setup} Perform device-specific setup, including discovery of virtqueues for the
>     device, optional per-bus setup, reading and possibly writing the
>     device's virtio configuration space, and population of virtqueues.
>
> does not seem to talk about re-reading features.
> What did I miss?
>
>
>> +	 */
>
> This comment confuses more than it clarifies. I would
> - quote the spec
> - explain why does code do what it does specifically for these features
>
>> +	if ((*features & (BIT_ULL(VIRTIO_NET_F_MQ) | BIT_ULL(VIRTIO_NET_F_CTRL_VQ))) ==
>> +            BIT_ULL(VIRTIO_NET_F_MQ))
>> +		*features &= ~BIT_ULL(VIRTIO_NET_F_MQ);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1977,7 +1987,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>>   
>>   	print_features(mvdev, features, true);
>>   
>> -	err = verify_min_features(mvdev, features);
>> +	err = verify_driver_features(mvdev, &features);
>>   	if (err)
>>   		return err;
>>   
>> -- 
>> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
