Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3BEC4332F
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 21:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09EA941696;
	Thu, 23 Dec 2021 21:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-D3pMZOHbCf; Thu, 23 Dec 2021 21:59:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F88841681;
	Thu, 23 Dec 2021 21:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 480D8C002F;
	Thu, 23 Dec 2021 21:59:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C26BC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81C7F400C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="05hgap9r";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="h8p1OHuO"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3ivOU4Th-96
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:58:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54F154000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:58:58 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNJSrvI017927; 
 Thu, 23 Dec 2021 21:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wOY8ZyXrVqltJ0cd2qhMG4MPGxsM3M2fyZ4c0qUSSmA=;
 b=05hgap9rS7E2cp4Cq3wm/5U5dF3W+6TV++zKgxPbLOcKrZu01XQkEqfQlpui9vVn7Kko
 x9GP6CfW7fYISwITufwFzSVowvaFolSUtenkBLKrHxupzAtakVGLm6ET5xHxHRrvO3ms
 nremHiaf8Dn+Q1OMr0RJj6WzuYuAoUjNbrLZb7ojIpDMrUqtRCyfnut+dKpDsgZHgWxF
 K6dZbwoAx13TL7Pq4qsq7qgB4bU7LXQzgMwzVSIySKIsDhCYDv1j2WOx52P9uneVZ67N
 3GG37gjRAMBBbFfz3bR+4tWWYSlMXnDgR7IcSNCA3CZSM9EqwkK0hi2PI31yhm0HkUAN BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d47a0kabq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:58:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNLp03Q094443;
 Thu, 23 Dec 2021 21:58:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by aserp3020.oracle.com with ESMTP id 3d17f7653p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXg+34QG7cYRdV7cj2MAnjIFQv9hVHAuBwImD5Cw+pTkUGz4UfN1j8wl4zlI/+GChlEGE/pvA984wU6MG1cUmYIkXCxrpbJPmWz5JnD+d9QM4JdY0Djz9MremLj75tcyXNGhlYq52lIkLHALvbAdCS2hy/Mo7IOR4/4Ud/SNEzqs1y3clREGqpEaZ6r8lsV57R1aQKf3LO7/ZTGna1CQtYove969g2VFU07/4KbvULlcqeWhc/xMBIAtbmF6TYC2Gpe02vv2e6fpHyASFe2k83zyncDCoS32oQxCzvw7HZNpaqq810bFDFJ5BlEjvOKSBRWOiaELMvGaCwRikU34Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOY8ZyXrVqltJ0cd2qhMG4MPGxsM3M2fyZ4c0qUSSmA=;
 b=mY1yqtgb2i9q/I0JTbGxiZ58rHpdlyJCHk7E3xHFkEzO7BUs/IK1cHU8BlYrITX8OELvvjlFspqfSXG77jmek5d7ozwZoaWnGMG1gy6ewqmntv4s84Pn1+SHrQCSQe2eFNgSS6DWKxn0pHyRl8GDUuQY4Csx3OYBOPdepRQFR61BbTGTNki3in6IkmsKc0VzRzpi4pAH9zipkme1k8YkHk4au+PcWESrb0iV2kAZ55e2ZG8cXVJltqqZU8OwsenW6Mjqn1Grx0lZm7ya7zlWdFse45g4FJDyOEW/ZR7RvicyEjB/yCtuaREmT+RrgaMDmj519aJTLYgBffTx+sh3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOY8ZyXrVqltJ0cd2qhMG4MPGxsM3M2fyZ4c0qUSSmA=;
 b=h8p1OHuO9Vtrb4QPyj9+YCsu4t9eUHpjBBzi6w3T7MCnaHs7a34YFmnKzwA5dY1UDEhiUSgFl6s7OP+D+9YQgQifDblVUqkcFnGzbFiXhCBWBYAfkYYtDbVzi49JveBVHuO86N4uLgnEQzjf6nWeYqGAFXTetHw+t6uUz6luua0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4004.namprd10.prod.outlook.com (2603:10b6:a03:1b2::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Thu, 23 Dec
 2021 21:58:53 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 21:58:53 +0000
Message-ID: <d1f3361e-2d4f-a586-bcd9-5aef3600a04d@oracle.com>
Date: Thu, 23 Dec 2021 13:58:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 03/13] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211222142100.158423-1-elic@nvidia.com>
 <20211222142100.158423-4-elic@nvidia.com>
 <29ada96c-7ae6-4cdd-92e1-45b90334983a@oracle.com>
 <20211223054621.GB10014@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211223054621.GB10014@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8857f905-54e4-444b-85ba-08d9c65f68d7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4004:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB40040A3DCCB40A0539E049E2B17E9@BY5PR10MB4004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BLf61z8Vdf88VoRjSbE/FkYsc5Z9dHWh1plYbOXZm3+msQ3g5UlnMJHZZ8CCcdW0T2p7w6O5F72kgQ71JJT+Ju03lm/fLfGXttsx1BHsv8gAdQs2AMcGKPtnmv9Tjry7QE/38sNTOkZB5Cbol+ReISnXn5V7PKKyjxWVnKF3HFvVmF0+TbWZwW+PGBElqHXIOGZr05SheAiYf8Enk/6SPFZNCK5sEWSL8U+uFKkItVtsecnPbRkggx1O1aeV2tru0Hyq9OkSH0o/C6Nehf5PvYvexrBZJE1X64Sbjib7Rjw78TQ0BPXHmZcGwG92otG56uw0zUjzUUTi5KfQHJazX6g98bTkjL796eS03WM37wUil9P66qen8B0YUpkIJBZOnsq+yL7AdnrKvqPMn4XMA2XYG49VMEM5VRj+yf++eQNN8+bTQl5ZAL1mHTcULbJ+u6AgfkHhP0GR6yaZoiiIU0IcwQX9A/RFFnRpf9VUPcLO0Gpc49q6DcobOWIj06rrOu920hZPoS2xWugXBjnScFMgIeJKp+DqbXk6RjyRQge2kCT822HKNy1QzvEUJHRdYUXiZza3K0sLO/81V3q8tuBXlRsUYuvjUzKFf7vz7bHEFsSuscyC3MFAxwlAuKhu/7Ue1R/JfB4JWCAcFqLUV34O5keX5CCqtVb49l/0E7PWNkJ3wwikYfvRDAlixxJjAs4Jsi7IcB/AR06oTqxFHeaQ2Z/APYtYqQyMhm+6nlX9ARog/v1RjnwSpQxGiOo59dhEH2s/etDdEfXr9d8jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(4326008)(2906002)(316002)(38100700002)(36756003)(8936002)(8676002)(508600001)(6512007)(31696002)(86362001)(83380400001)(66476007)(31686004)(186003)(53546011)(26005)(36916002)(6916009)(6486002)(66946007)(2616005)(6506007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZnbGlCVGt3d0FobXFTTmVxMXBSdm80OFlSUERJY1krdCtPOXlKTS9td0Ji?=
 =?utf-8?B?SWxjZjNuOVY0RzhISnhPbTR6OHhCR25jU09VT2tTcC9qRnJjMEZRQ0F2UnpJ?=
 =?utf-8?B?QWx1clUzRU5razc0T3dLTDFlY01hS0hjN1hScFdkc2pFVjNLdXMzZmxzTi9C?=
 =?utf-8?B?SSs3eDVvSld0OGNuTTdoUlFTazdlUzh6SUZ2VGY3OE45VjkyaDgrMERlZFZB?=
 =?utf-8?B?Qk5TazZJWGh5SHBQRVNHZ3NmRjZEVlF2V3gwa0hGQXBvR0o0bmsyYWZ2M2hX?=
 =?utf-8?B?L3pLeGQxUlRCdnBGVXg1OGgvQTg3YXhhdVBiemQvREJnNW5PZVRKNmJtZjdt?=
 =?utf-8?B?aURSbmdVNzVEVDFnYkFBRklLUXl1OXpEQkJ6TlR3OGh6MVV0WVlzTW1jSHo4?=
 =?utf-8?B?bXZHS0RLeUpaaVpCUDlzdkhkaEVha1BzbGpYZ1VDc1lTWjExMmozRnVCalNp?=
 =?utf-8?B?RkovYThhamY1OUdhQzhQQ25QdzFhV3l5N1FGNkFybnN3UU9wZ1JOTm4vR0Fy?=
 =?utf-8?B?K0V3cytZS29iR09VUnlyeTJ3SmJlYXB2VEpMSXhkOGZzT3JKMi81VUVoVGVP?=
 =?utf-8?B?TGVIUFJaTjNIV2lhR3U5T0Fvd0kvQ3dlSzk3QXRkS0FMTnQrczZxckZMckhp?=
 =?utf-8?B?TVhxMjhNVy8xNkVqZ1RYZ3NlcHJMNzFXOTVnSXFReWN3QWRjK3BTaVFodjgr?=
 =?utf-8?B?ZGlaOUNERTh6cFFENWduaHlHUVEyQWMvRnFnU3NhMDZpMCtIMXdYcDd1cWcv?=
 =?utf-8?B?a3pJak5ndzFOVDNvY3ZqdDc0T3Z6MGxkSEVKcTRPRWc5Um1SaWUwWkJhd21y?=
 =?utf-8?B?NGplTktLRXJ0SHdCU09wanVVUXFmOWJkWUNWSXZMdUJLMXowVzR4RVI3elBF?=
 =?utf-8?B?ZlhkeFBTYlNhK29PU0dMSW14dEpFZnN2c1dtdXUxRm5qMTU2d1hUZjFBdDdF?=
 =?utf-8?B?V1pmMi9VMWdhYWtON3hiYU1PQzhsZ0tpSkRKb3JQWXRoZXBEYUFxS3A0UnI2?=
 =?utf-8?B?dUU3UzlaRHEvU1R5S3A0QmN6T2NxRnp2aTlGdlZtNkV0bmcyVk5rN0ZOVHF6?=
 =?utf-8?B?a1BqdEl6dUk2SlRKQkQvZUE1ZHd4eWM5cFFhcWdudlZYSDJXTHpkeDJFZnd2?=
 =?utf-8?B?cm8zbUhnR1ViaDNPU1QvOEIxaDI0WkxIYnJrcnFhaWtES2NKNzFaa2hMRTVN?=
 =?utf-8?B?T081QkdOaTQ4cHA5T0lLR2R3YkViMTFBMWdvZnJ0VkprNTFWYUhyZWd0RlQ5?=
 =?utf-8?B?UXpJVHlJbVhudTdNanpYbHF0QWNHaFIxTjlBcVh3c1hRVWpqSW1NQ3ZubGIr?=
 =?utf-8?B?YzR4QjNReEhpenJxWjFpYkpkQXFMWVhsWDVrVEh3aFBaTFdoemNCVENPejl0?=
 =?utf-8?B?MXBENlQ3REk1blE4MGxRc1FrWGZNRFRKV1crYTZuR0hnN3MxdCs5bkRER0FE?=
 =?utf-8?B?WjJLM0tkS3g0S0VKVFlHdWticXRib2M2cTNQdlc2YTBwRkRhQVViUlNqNWdO?=
 =?utf-8?B?SU95TGZlMzI5eldES0hjYnI3QmsrUkZybVJWcjVrdWFUdm5WdWJaTDZTa3NV?=
 =?utf-8?B?ekZzbDYyVFFkRlJjYmVsWWkzUzFnd29BZE51K0Rid3B3dXNzTzhNVmw1anBE?=
 =?utf-8?B?cHYxZ0wrTklvQ2ZXVlpFQXhObWkwSWlHSUVVSmR3QUsrRFB6VzN5WjRQWVFz?=
 =?utf-8?B?R1NyVTNaRkpBUFZDR0lITmNpRXFXd3Jhcm9TSDNXdkdLMW1hdjV3SExhbFg1?=
 =?utf-8?B?ckNsUHp1dFRnTTc5dllCL1huR2pOZGFScUFqbGRJTWtFbDZMY2h2SEt3VEJI?=
 =?utf-8?B?aHg0bTVtQkZCNXRrWnM2Ri9iYUNRMjhreWgwNHRLY2NOVXBhT3dpT1U3UzE1?=
 =?utf-8?B?ckR1TzF0cXkybmNjYWR2TVJ0Rjhsd3c4WlFicGZ2TWdlT1ZnQW1BdXYwT3ky?=
 =?utf-8?B?Vy9jdmxYcC9vbTgrRmJ6Y1B3L25PdEJwdHpPcmYzWGtuZUh1ektGQkRObGp1?=
 =?utf-8?B?czJIcjAvaHFLNko5V2tmajk2YjFNTnMya0pLQ2JmdTAwUWxKYlVlM1BRUUwr?=
 =?utf-8?B?cHh3NXJ2OGlzdWgrelExV3liTDNjaGhJRXNMR01RcFpDdVpQOXl1eUNDWnlr?=
 =?utf-8?B?VFozdTJmSEI5UVBZVXdsZ0FPYmhURk9mdGlQZU1tVXh6ZlFrRkp4S3MvcU0x?=
 =?utf-8?Q?FWQDiSqrJrEZXZiThSYGOfU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8857f905-54e4-444b-85ba-08d9c65f68d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 21:58:53.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoXm0nkaB3h3svq6gLpeGxafEIwn/C+eyJbQJSgtRgYWx8O/qVel9F6Xf7TDZ1jO2/m46pEdHH+2Bimp38oHDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10207
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230111
X-Proofpoint-ORIG-GUID: VPtkEmONoWeGYu5-zc4ypreJYcI4BZFC
X-Proofpoint-GUID: VPtkEmONoWeGYu5-zc4ypreJYcI4BZFC
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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



On 12/22/2021 9:46 PM, Eli Cohen wrote:
> On Wed, Dec 22, 2021 at 02:58:18PM -0800, Si-Wei Liu wrote:
>>
>> On 12/22/2021 6:20 AM, Eli Cohen wrote:
>>> Add wrappers to get/set status and protect these operations with
>>> cf_mutex to serialize these operations with respect to get/set config
>>> operations.
>> Need to protect vdpa_reset() which is essentially vdpa_set_status(0)
> And what about vdpa_set_features()?
Oh, that was missed... Indeed, it also needs to take the lock.

> Maybe it should be done as part of another patch to address this?
Isn't this patch the one adding the helpers for the locked API? I think 
it's fine if you'd like specific ones for reset or set_features.

>
> Shouldn't all these serializations requirements be handled by the caller?
If the caller remains in the vdpa core I think it should be fine. Or you 
want the vdpa bus drivers to take the serialization requirement? Perhaps 
not so good.

Thanks,
-Siwei

>
>> -Siwei
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/vdpa.c          | 19 +++++++++++++++++++
>>>    drivers/vhost/vdpa.c         |  7 +++----
>>>    drivers/virtio/virtio_vdpa.c |  3 +--
>>>    include/linux/vdpa.h         |  3 +++
>>>    4 files changed, 26 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>> index 42d71d60d5dc..5134c83c4a22 100644
>>> --- a/drivers/vdpa/vdpa.c
>>> +++ b/drivers/vdpa/vdpa.c
>>> @@ -21,6 +21,25 @@ static LIST_HEAD(mdev_head);
>>>    static DEFINE_MUTEX(vdpa_dev_mutex);
>>>    static DEFINE_IDA(vdpa_index_ida);
>>> +u8 vdpa_get_status(struct vdpa_device *vdev)
>>> +{
>>> +	u8 status;
>>> +
>>> +	mutex_lock(&vdev->cf_mutex);
>>> +	status = vdev->config->get_status(vdev);
>>> +	mutex_unlock(&vdev->cf_mutex);
>>> +	return status;
>>> +}
>>> +EXPORT_SYMBOL(vdpa_get_status);
>>> +
>>> +void vdpa_set_status(struct vdpa_device *vdev, u8 status)
>>> +{
>>> +	mutex_lock(&vdev->cf_mutex);
>>> +	vdev->config->set_status(vdev, status);
>>> +	mutex_unlock(&vdev->cf_mutex);
>>> +}
>>> +EXPORT_SYMBOL(vdpa_set_status);
>>> +
>>>    static struct genl_family vdpa_nl_family;
>>>    static int vdpa_dev_probe(struct device *d)
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index ebaa373e9b82..d9d499465e2e 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -142,10 +142,9 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>>>    static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>    {
>>>    	struct vdpa_device *vdpa = v->vdpa;
>>> -	const struct vdpa_config_ops *ops = vdpa->config;
>>>    	u8 status;
>>> -	status = ops->get_status(vdpa);
>>> +	status = vdpa_get_status(vdpa);
>>>    	if (copy_to_user(statusp, &status, sizeof(status)))
>>>    		return -EFAULT;
>>> @@ -164,7 +163,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>    	if (copy_from_user(&status, statusp, sizeof(status)))
>>>    		return -EFAULT;
>>> -	status_old = ops->get_status(vdpa);
>>> +	status_old = vdpa_get_status(vdpa);
>>>    	/*
>>>    	 * Userspace shouldn't remove status bits unless reset the
>>> @@ -182,7 +181,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>    		if (ret)
>>>    			return ret;
>>>    	} else
>>> -		ops->set_status(vdpa, status);
>>> +		vdpa_set_status(vdpa, status);
>>>    	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>>>    		for (i = 0; i < nvqs; i++)
>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>> index a84b04ba3195..76504559bc25 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -91,9 +91,8 @@ static u8 virtio_vdpa_get_status(struct virtio_device *vdev)
>>>    static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>>>    {
>>>    	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>> -	const struct vdpa_config_ops *ops = vdpa->config;
>>> -	return ops->set_status(vdpa, status);
>>> +	return vdpa_set_status(vdpa, status);
>>>    }
>>>    static void virtio_vdpa_reset(struct virtio_device *vdev)
>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>> index 9cc4291a79b3..ae047fae2603 100644
>>> --- a/include/linux/vdpa.h
>>> +++ b/include/linux/vdpa.h
>>> @@ -408,6 +408,9 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>    		     void *buf, unsigned int len);
>>>    void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>>>    		     const void *buf, unsigned int length);
>>> +u8 vdpa_get_status(struct vdpa_device *vdev);
>>> +void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>>> +
>>>    /**
>>>     * struct vdpa_mgmtdev_ops - vdpa device ops
>>>     * @dev_add: Add a vdpa device using alloc and register

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
