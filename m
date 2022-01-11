Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D1AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 09:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C005C40649;
	Tue, 11 Jan 2022 09:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JdtPe9dYnKb6; Tue, 11 Jan 2022 09:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 173E740143;
	Tue, 11 Jan 2022 09:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEBD4C0030;
	Tue, 11 Jan 2022 09:28:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ED70C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66498402E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3uOrKybU4JQs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:28:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3920A40143
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:28:09 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8crrx020092; 
 Tue, 11 Jan 2022 09:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oHWBQ0/orPAa2PoK1Q01jPGelmAFpGAzPfvszYr/oZc=;
 b=msJPF/fLnmCA4bHHvGKoK2HDucOh/u71syV2YeYn8eZLU20bhV0G5fANRYmkr3Xe6YIS
 d5OSFaTXLIQYL992S8dgj0VFEK6jR2N7meZXY9s9haVVAFNxsyttUvdPRIINkrnJIJsJ
 4DVH9zNZtXh4jUG0fLQfUwob01mZZyIYDTJNYASh+5kBE8XXCXlVsTLgqbRtO+PonwVW
 V5pUadRBxE4/GXk+k2jOIj+NCNlD0RKPaEwS0sOQ8k+Z5wxxvcjMFpBBiWM6HA1hdbj+
 gLcDXGRZJlm5pCzGyRCt1ezuU7qLI9GusbT/E/tOp6ZSvKcWX5crLaKo2D5KX+otkyeA Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7njc7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:28:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B9BxX2013513;
 Tue, 11 Jan 2022 09:28:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by aserp3020.oracle.com with ESMTP id 3df2e4h9m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:28:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNhGliVIVG75hKWEIOE2rDBoUae/l9eRw/v0hd/gIlp+AZiA8EzE/PVIhV9NtZp8iSv0iRiOPsvtaQ8N56Hgw4VxkkdrxIkeDGlUigl5g6QW1b8dfbspal3famJnu/E7pqgXds7SfNPj3QDHQl9q/jH5uApsG2bHtvyYt8kitE0TCrcM9+3Xuoykcjy23BRP/F39iEzrEH27uZ2bJCtDWOQhLQyiJyYGLKECfVJRSyV1/ZlyFVQic0Qo3700YHqOrCRAA4bmY85yDc+cUKMCMTs44D+RJ13DRx9IK5YUoKPsXjz9WA6OCBk2YSt2sZI2fmetH6e8lHS9LNaWfSD7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHWBQ0/orPAa2PoK1Q01jPGelmAFpGAzPfvszYr/oZc=;
 b=lC5s/Pt/wBKKNvrtWsAUIJZ/W2i5UATRWAYMdh0h7rdvWr3pT7RFlXn+vw3c6N8x5HZzYIzbrWx7/ISAYK8mgZuDFRQURrn31voHA+dRZOA+YkPYf9BvPkdEEfJHVPR5Gykr2HApeCk4DhM7aDPEkgOI+LVGmFffKrJZ6ZwhwU8n2HJkvXOrvgF8tImpa7s8duMI5Jt6Ld/TrjuSf13oIe9LtpbVPA8cy0CTLLHicrYEXosFYf/uNWT0guo3mwwYtHX1pX0b1gcA4LiIJymUQgywUkhwx9puW61lF8tNobro/aO2u3QeWRhG3EQWn3llIiwj556AJE1scFgXGeO3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHWBQ0/orPAa2PoK1Q01jPGelmAFpGAzPfvszYr/oZc=;
 b=mKqM9zW6dR/T/GNPzUhlY6FeNGCvPduW2TIIgVpPHoFOxPz6hShj/az8nfonA68mthGsLV5ILCnyT7QZltE04rkbYPRr1/EOdhxBg2LOML4beBHmrQfhAtxFZQy3bYN1PCaxQcjYsdichk55f5QsdScs7+72M2zGLCSMVQX4DMs=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3703.namprd10.prod.outlook.com (2603:10b6:a03:122::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 09:28:04 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:28:04 +0000
Message-ID: <02dce333-32a3-5966-a282-57717e02ca41@oracle.com>
Date: Tue, 11 Jan 2022 01:27:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/4] vdpa: Protect vdpa reset with cf_mutex
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220111072217.101836-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220111072217.101836-1-elic@nvidia.com>
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e296865-8030-460b-6141-08d9d4e4ab94
X-MS-TrafficTypeDiagnostic: BYAPR10MB3703:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37039C9F3DBDC7143EA9341FB1519@BYAPR10MB3703.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mEPcYQghLkGalYu0Ly/DLT9YAaZSKzv4u9EvRk5ERUmLEbXKOoHZdVJ0AnBg0dzO7XRB9vskS5joiJIHRHwWtunytIc8dZEvsT6+drkTE8CnFJvDaBgBdjO1I8KSRWq3sH7M5iPDBMFyH4tERJr+L+Jed87a7LLBxBKTNZqgAnWPKBsivL2hk5y2fFFBO5VBY6k/f2HeafRKrIGMJBmFujaM11VxwA8PoOi9uPwKybD+c23XgulyThbzGyr7Eyy4QUv63ExONr9iVVS2t6qTT3nZ9bk7VonQwfL/OUKyLmGy0rUqwje9kygiwP4snBQpIHhwA5uREL+Mhuf3pxIc8l0cP7WXsY0EXiSddpjMx/Ec6IlM0Kvl3j4fOPEPf94ViJtFtzh/sGZRfsOqNDdvVSMbrhA6Gn3Vr2jqmpba0gseYfmmV8M11AGnuohnnyr4Z00I2YfhJoiUOTZMJcDw70nBonRyNL/wkNhqLuqwbuUckEN0otcHJr3smoMjUIUei25hk/NJrM/Yszm8S8r02PuoueG0v8Oeo4Uva4L6A6ZHLlbfflOJ00SJx9V/BpfBDpBqSv69m5SaeMfdS90X1MlYgymI8u2eFTgeF6INvH9sIKi58MUrhhu+b3736aUGtQQTwlSq+ozR1dD++SfbKOsiod3tCrSICpFVdcIku3GinqslGGy7KJjkNKrhBykbs5JtBJN3KjibNw+AApNptGxs+xJ9wpf3O19H1fOTz8tB4moGTphgw6HcVhcE8gk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(6666004)(186003)(66946007)(5660300002)(8676002)(36916002)(66476007)(53546011)(6506007)(66556008)(316002)(83380400001)(36756003)(31696002)(38100700002)(6486002)(4326008)(2616005)(86362001)(6512007)(31686004)(2906002)(508600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRCajg3bW1GWDlWU0tQclN3N20xamtFNm5IeHl2R1NrQ1pWdG4vVDRhZnZI?=
 =?utf-8?B?ZEk2SzdwMEk5aFlLbW90cjBXYXRzcVl1Nk4zNHJRbGFaRHR2S1o4L0t6OUlH?=
 =?utf-8?B?Q1VqQ0hPSlBqVW5HdUFRU1NaN0ZOc0VNSGRDU2F3MjlsWkpHQjU3anhRcVFL?=
 =?utf-8?B?OGpMVnE5bG1kTTNjamJmL2hIejNMUWpWWVNrQ2dXZDI4RlgvL1NzMisvbER5?=
 =?utf-8?B?ejBqTjh5bjQxZ0E4d0tEOXZQek05dzNXYVNxK0llRVlkeThWTWRtSnkybFF1?=
 =?utf-8?B?cVBSY2FvdzEwa3NtT3JYUXhNU21ORG50VUNsNFM0S2svZ0ZzVkF3b3VnRkR3?=
 =?utf-8?B?S3laRHVUV0VQLzFYcjRzQnBWeFc0cEcvQ3lVTWVOV0c4NkU4S28rOFJ6cDZh?=
 =?utf-8?B?SWtIaUhCZkZyWmRNRng2YlQzZDEyVFk3bDhlYUFlWjVsQjZTNkd4NGNPREVp?=
 =?utf-8?B?MDJ4VXcvSE95OEJ1dGNiRTJQdkZCdGNZcXJOUjhObmh6QVhvaVJuOXNqbXhI?=
 =?utf-8?B?MVkxNjVGWE1yUTNoUG9jYUtsSVhYSTlIbkpQdjdGWjlrUXVrTFMyQ3hJb1NC?=
 =?utf-8?B?ZjlHbGZGb2lud3Y0a2dsMXJaOVRCaEpUd3dQbTdTdnZtMS9aVHJZeXQwR2N6?=
 =?utf-8?B?RldaYVZIVnZTK3FtRjVObUNjczVxWllWSXduVGpQQThyUnBhSXZmSHpTVHFB?=
 =?utf-8?B?dHl1OGhzK0x3WHVveWI4djd2RzRrWFZmTElKYUplN1ZFazhTM2xidyt3elVv?=
 =?utf-8?B?TTRoMi9hSW02MDhpMDVXbHJwdjk4ZitkQkhhdC9xeXo3QmFMNmNzNW0rTW05?=
 =?utf-8?B?eVV3NGZmR3MyLzVxcmhHNE04dGVqZGZvOWtkWWNaNndHaGRHMFZSS2xzcnU4?=
 =?utf-8?B?bUFqYndJcFlLQVBtdC9wekxqejNTQWdIdytCVEFtclkvTjU4ckJrTHdBcFFo?=
 =?utf-8?B?alVyeElYZTdCY0dQTHFRWGZHZ3NleGtTRzEzWVFnN1lsUmljZlYyRmQwdE1G?=
 =?utf-8?B?S2hFR3dJVXRxSGY1bXR3Myt5MVFzeWJ3cU40Nmw2RWxYdmpPTXhJWTJDOFIy?=
 =?utf-8?B?bG80UDdueWwrb2NacnFQQ3BoRXZtTEVhb1M4akkrNmUzZjVNT2Z4R2JQU0Y4?=
 =?utf-8?B?ODliME5DMlJSalozZ0VBek9TV3pNeG8yL21WWU5OVzZnZjdvZUh3bUYwSE9F?=
 =?utf-8?B?TEVkemttVlcxeDN0V3o3bGwvRWNKRG5ZOFdBV3pIMHBhOVViNGZyZTczejBE?=
 =?utf-8?B?cER1cE4xTFBtb2x4QzhyY2NyN3hDdW14RGZUeHR4WEdyKzkrZUhxYjNRYXd2?=
 =?utf-8?B?V3ViOFBwTjdmR3ZYcXdQb0ZRa0ptQkRNZTBXTFV6R2RXei96VFJjTnFrWWd2?=
 =?utf-8?B?NC96WThYODUzWjkweEZPdW9BSkFIc0lsWFZaalZXWjdKamlTazc5ZytNaWJv?=
 =?utf-8?B?ZDhPNE4rTnlUbjB2a3l5UW9jVFJsaDJRWjluK25rZ3liUWIxU3dTQzlnZ0Zi?=
 =?utf-8?B?QVNOcmhmZUhLcXN0Uk1vTUNJRW00cGJHd3c1emZuQzBwZy8xdzNHeEJkamlK?=
 =?utf-8?B?R2tELzVBSjFwV2dZVmM2SThPOHIzeU00YkdvT1gxbGx5d25XUzlPbFRjc3dO?=
 =?utf-8?B?Vi92N3pUZjc4MHpiM2NVZkxWSnJvdDV3TDg1dlpjMnlyWXZ5alE4TkRsbEE2?=
 =?utf-8?B?cnlvTXhaMlVxK1hIcFlqWWdzNDZ3VEZ4dE5USjFaMjAwZ2c2eUpOTjF5T2lW?=
 =?utf-8?B?QUt4YTMzR3dZY0pqZXdqekNSWlRnVzV5UGJpVDNnRFltQVJSUVQ0cVZEcFNT?=
 =?utf-8?B?amlaMlU0SndDRW1Makt5WmdJaXZTN3dQSWU2eEt0SnFIYktBUGsrekNuY0Nv?=
 =?utf-8?B?SHYrTFpETFlEVWVMejFWNER2VVc2Tnc5dUphVVozMVZNUHJmYnNURXJnZUNX?=
 =?utf-8?B?K2I5L0xmRDRPemJrbUhFa0Fjc2pxWkJvekMrRDQ4RG5vMmFWRjJaZGZpU0Iz?=
 =?utf-8?B?RkUrSFhqdFNqZkZ4SUlzVVpvTEdZek1JWGE4SUhGY2hoQXV6VzgwRnpEckgr?=
 =?utf-8?B?SnVhZ1YvVUlMNWNPMzNodFBFRm9BeGlKRUQ5Rys5Y2FZWmhyQ01XQ3QxUHNQ?=
 =?utf-8?B?NGVkMTI5c2pYd09JVlQ4OERqMC9heHFsUGFOOXlTazcrK2h0cGwreG1DdnRU?=
 =?utf-8?Q?AkFG92peG6zF0nHOqFZPs/g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e296865-8030-460b-6141-08d9d4e4ab94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:28:04.7927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmtBbQys9mOxKecnexIDBkraTSEuWzcx+9CRsREwIbbziq/PwcGtt7dGFMrmZMdhknArV0YXipWSJz++xWIlmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3703
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110053
X-Proofpoint-GUID: opPlKNtl1Q3UZ6L2_iSUkWU9SUiQszYE
X-Proofpoint-ORIG-GUID: opPlKNtl1Q3UZ6L2_iSUkWU9SUiQszYE
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



On 1/10/2022 11:22 PM, Eli Cohen wrote:
> Call reset using the wrapper function vdpa_reset() to make sure the
> operation is serialized with cf_mutex.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vhost/vdpa.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6e7edaf2472b..fe0bbea4dab6 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -155,7 +155,6 @@ static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>   static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   {
>   	struct vdpa_device *vdpa = v->vdpa;
> -	const struct vdpa_config_ops *ops = vdpa->config;
It is okay to remove this line from the patch, but a follow-up patch to 
remove the locking for get_status would need to reintroduce the same 
line. If possible please try post these two together in a same series.

Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>

>   	u8 status, status_old;
>   	int ret, nvqs = v->nvqs;
>   	u16 i;
> @@ -177,7 +176,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   			vhost_vdpa_unsetup_vq_irq(v, i);
>   
>   	if (status == 0) {
> -		ret = ops->reset(vdpa);
> +		ret = vdpa_reset(vdpa);
>   		if (ret)
>   			return ret;
>   	} else

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
