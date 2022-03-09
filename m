Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4CEC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 03:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80557400E3;
	Wed,  9 Mar 2022 03:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQz6Wm3b5ahp; Wed,  9 Mar 2022 03:32:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 20D9D400A6;
	Wed,  9 Mar 2022 03:32:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB27C0012;
	Wed,  9 Mar 2022 03:32:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64E0CC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A429417D3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:32:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="is4lfxw4";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="XFp5jMho"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKpaVFNHV2ze
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:32:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A07D3417D1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:32:51 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228M8wYM028053; 
 Wed, 9 Mar 2022 03:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UTK+QoEqBo3cz4u3k6k+5ZsR86ANhR11am7YKMkOFLY=;
 b=is4lfxw4FqSOMdOFddwfAAACOQWkDhr4R90jOFfnIY7zo4nEmn9GT76/Av1mGHe1iaCR
 xcMB49e8LafQHlLVsvVVtunAzbXhpd+K57vwkwPDL13ONi/FzC1OrkIn1x/S9OcVs/2x
 NE/o7oThcyeC0goJVkGImuxCBnJtoY1zRa0/wf4zZ/cwI/lmiROJ/9/J1/ly86AoE1Gn
 1/NEDad18k8OS12O4kwmm+slWBJv3PMgUy4ZWhMKt19HZAuFkfcL9ODWp9YLEqOz1y8Y
 K7oiKWXIe6wp+fmPT6Vg6zgfef2rMG6C2PzJx6vnf16q9igzAllz/22jLrKIgLqjqTSq HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2gueq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Mar 2022 03:32:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2293VBCY118686;
 Wed, 9 Mar 2022 03:32:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
 by aserp3020.oracle.com with ESMTP id 3ekyp2q102-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Mar 2022 03:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqSyE4TPMrpWyIThU/eLo3IyIKtBjuQ0Cf/hpXa+tOY3bH6W8fG1pImdXDrk6epTVMwNjf+JPFjc9n1zGnnUuHwZtpxpqa869AP7htlQogxTenTmQeXTeu/2D5O1KEXqhPJBgo3WF5vIPxDya845Na5AeiCR4mSQCZb7WNLbawhFtxseomjMrmFKidLN5Fm0seOJbvUQlq1lliomPG32PiIP9GghvikQXVvrWFzS11I1Z7liV6NPRubGAh5jISkGOty4Dea9c/XjLETycYHDVaQS5swITXY7+8rwmfLYRnM/ZFptBNA47UKnVJJ2RSKTtxd9/KMsBoMdGpqiJV5zFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTK+QoEqBo3cz4u3k6k+5ZsR86ANhR11am7YKMkOFLY=;
 b=OPw4mdXq3W8FkYqUb9Dt7pkZC4E6jMGzesdushrXRh9rophapkKK8pTp3XfeXFmSpkF+gLPXroWWCvAAgGlFdwaSNySfaWtSVBeOYk/BY9kDS4UOepb8dPiQkMcCuzP+yAQym2SxI7K7qvSdeNYcT5PyhK9aqJ2hfA4VvcPAjYthOaRpFtRb31pxGgJsmmn/qvCewSfoBqq0UwlkBRsS4yZIWR5ztYdDADyeIFHw5ulgb9vqIG5M6A/yvyvBoJcuCP8qzVZ8oPGYBKvZHNfXM+6SMUvl+GUYO34mR41i3QaGeR0S2/6pZ+CYC5L5t3RUOXLH+Ej1LtR3WM9+dCNSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTK+QoEqBo3cz4u3k6k+5ZsR86ANhR11am7YKMkOFLY=;
 b=XFp5jMho6gXg5LaHmPoHtDe1Er3ua1SyI9Zkz0QGe6EfH+9ZrZ9ay+j0k40j0OwXfDAUMwUu+QjMLSYEDa/1Qg8zj5X41XLXxeGLc+F90inJQuKKmM3vtRk68vST7XAUMlPDo6L7JVeOOlmUs2fY8Hp9MeJS4QiDcmaCkH9WJRM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3078.namprd10.prod.outlook.com (2603:10b6:a03:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:32:47 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:32:47 +0000
Message-ID: <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
Date: Tue, 8 Mar 2022 19:32:42 -0800
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
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47b70c3f-98b2-4313-f250-08da017d7a9b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3078:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB307885AA47C03BCA11892248B10A9@BYAPR10MB3078.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnU1wAhliX5+l1xe/jsqkcx/lQkfaI6DHtr5c7xKZBQhZNq83Ot7tvLDciIoPw6wT9BxhrZ6FlpUwHnozFC8+F9m41IAJKYvXp1kjJE0J+4q2UmHD/n6UeB2IOkNVgugnKEVLQqeznQh/dUc1A2+SoL8OUy21YzZ7jmG14vlrKZMi4c23XaMYOEJqMfRVsauxShHhXvH9GxHxzMBH3Z+xAtORzzhw6t80uVNC1M2lgaDb2epEY2uK6TyH/iMDN5HCRma9v+a5zifCAdsIANG6y+d8V/hWPvu/uxfXaZyLRL6PliGRAzt4i0X7rXvP3GfgdOufU6Kaq7P9+dRuPD9lIqqsOcYqXdDTqGOVQpBaZThRDV/rj5rwzl1RIS3LINDrnaZuCGb1dvC8kpkKCXnhgps1SDMRAUB0zJ/3uMQxZcR6n5IFUCdTy3u85fyK7h0xSPEciHUZ6AoTyTz3i96Lr54OzP2EK9mA0O4bgqN/cMlHQ1OYNkPLFjDVn5GveJUEyKaq8n0rHRq1Gj6NzN58jvIrH/mjCcoqaJYr1vlj/yoThzrtMaQ3SV6WorQuvrygH25a7/raNOyEOpT1MZq4PoQo+YphGAtvzgPdy8s7GwGhFSCVw3dXlSWAYB+0fIYU6EHQTilNQxeEBhMWBCHsLPjP83YDBUpQYkMrgUmlcb5tjQholTFrG9e8N6zSF+Na1SLiAEdKnGe2rKDLxx1eTh6lvSCqH7D4RhbvqCIwmMXFWw82sonhgKkaBKRdqfN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(86362001)(6916009)(36916002)(6486002)(6506007)(38100700002)(8936002)(36756003)(6512007)(30864003)(5660300002)(54906003)(2616005)(26005)(186003)(6666004)(2906002)(4326008)(31696002)(53546011)(31686004)(8676002)(66946007)(316002)(66476007)(83380400001)(66556008)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm5rUXMvN2dnZkFCcUROb3ByNXFEckd1Yk9tWjNyZ0RWQXMyRWVocC9Od0Ez?=
 =?utf-8?B?Y1FLRXVUSkJrSFdBLzRXMmZSOUJ0YVVyT0F4c3RyUUlmclgvcnM2S1VleW4y?=
 =?utf-8?B?Nk9Od1RzM2drRjR1L0JCbkZaZGxsV2dsNm4rc3RYaWFvQ2h1amY1ZGtNNTQy?=
 =?utf-8?B?SXlNNG5JZW95aS96NnYvYk93Wmd2TUR5YThMUUllYnY0cG9hY2RYSGZ1dDRB?=
 =?utf-8?B?MVZLQjlta3ZqRXFqZ3pJNDdqdGRYK29oTmFqSkoxeFZkeVJ5M1UzaUc2SXNR?=
 =?utf-8?B?a0pyZ21HbEoybGtGMi8rc0JyVGxCRGk3YU4yeWt0QVhuMmJ4bmRkLzNWb0hz?=
 =?utf-8?B?d1F2WUYyY3hUSXB1OVRub0xpWWEwQllGT0NaTDI2YXN6a2pTWEVkem1zWGpR?=
 =?utf-8?B?N08yOHc1YzhxcW5CcTVESVYvTW5ic1UvbXhuV3JyanhVUk4ydUNKdjBoZVoz?=
 =?utf-8?B?M2RkcXB1NS93TG1NOEtZdXQ4RndJcURTZ1p4cExDaEpNNVlMTlNNcUJSbEFL?=
 =?utf-8?B?QlBuamFCNWdCZTVrNm9KZUNMZ25WNVRXaWZ0cStzM2pvdGpvck40NGNBWnE4?=
 =?utf-8?B?blJQdDZ2Y25xaFo1YmV1MEZtRWhrODFya0VFb1FQaXhMY3dDOFhGenArZnd1?=
 =?utf-8?B?ZjBsVlY3a2Q5eUNxQTNXZTZHbmV2UzI4R0lSSjJJbTYveXVRbjhNRHU0Qm54?=
 =?utf-8?B?Ly9aM1Ywc2RUK3ppQmc5SkxERjF2Ui85QktueWR2eDFQOUh5Tzk4dDh1QzRj?=
 =?utf-8?B?ajJyZUhTVkpyQ3dRWVJGTDZGNjhEalIrem1HWHdMWFNCR3IyQm80WGRWNW42?=
 =?utf-8?B?VzdFOExqWXJOSHRxMVM5YkNoQnZRK3QrcUtNN3UxWk1va3hqZUlFU2VoU01D?=
 =?utf-8?B?d2JVZlRYUlFnS0M3TGdyOEtjR2h2aFNtY3NIdmtUYlhOMXVDSFlvUWN3aGY3?=
 =?utf-8?B?QTN6ZThkRlc1TWdzeHVVK2Fnc2puRWxwQ2JGS0lrWXNKaDkrYkYrdDZaSzFE?=
 =?utf-8?B?RURibVZmOXM5WkxqUHhBZEFrWXV1RjNqeXZjdVJDM2NGcmlRSXJJTGVQajdv?=
 =?utf-8?B?RUtGdWc4THhFSVhRZFJ1b2pnNFlHeWJqL3l0eHJRMWFNR2xSUTEzNUoza0tH?=
 =?utf-8?B?ZFgxa0FkT0owNUdGMFg5SzFtZFhaWWxMUGZ5RksyUDBOdnIvdFVweUx2WDJP?=
 =?utf-8?B?dDdSQ0ZwRXV3YzVYOXk3S1IvM1c2RUkxcTN5TXl6Z21QblFqd2tQaWZXeU5z?=
 =?utf-8?B?QXRINWc5a29LWmt1RkF6WkJsRFZyQkFKbGRoSXFYZVNlS2puM1ZobXJIWHpV?=
 =?utf-8?B?WGhnU3pMSW5VN3VHSXdrczVYVnQ0bWRJVFNkV3doSnVhVG05cm5WVG1uZDZN?=
 =?utf-8?B?dm1pVGFEN2VuUUI4R1U0dHl3MHhpOFlwL0RnMDl2L2VEc0RFQXlublduRXJm?=
 =?utf-8?B?SklJY1BuT29kTW1lcXhTbkpmWmJLdG1ib0c5NmdJZFdtY3pVVDR2S2F0Ykd0?=
 =?utf-8?B?bE9DdUh0RjhqWkN3SnBkZ3hYbmRiUDhsZm4yYWtkeCsvalpXclRJNGRNc0c3?=
 =?utf-8?B?TFJXWG1mbUNOYzVlZ0dNNG9hcTUyS1hISHNnOFBpZ09iamJPN1lZdm9ZYVVL?=
 =?utf-8?B?RDNrSjJ6bnhDcmhrdm02a2FaZUU1SGh0akxoOHJPS280VjVKYjBMdk1uTG9Y?=
 =?utf-8?B?Uk1NMituaDdoZXR1M3kvRWVlU2xuV0tCVDJCV3dSZ2c1bGlyRHNRZ1VlNGx3?=
 =?utf-8?B?WXR3QkNUR093c3gvOVY2K2pvbTdsR1NQY1JQZS85UHJUc3NmOTJVcDhmUlBW?=
 =?utf-8?B?VTYyb05uQ2lYZzZVYXFRMmtvTkNpS2xYVWcxbHcrVGFTM21ETmRnYkJ1OU43?=
 =?utf-8?B?NEpvWGpPTmtQVCtJbFNrWWRiOEhSeVdheVVMTy9xbjd1QkQ2a3JjeERlS3RN?=
 =?utf-8?B?ekY4UE5ibTRTSGNzOXE2V1JiKzRsZXlVWjZ2d1cycVhpQk5BbFJoZGpXcDJL?=
 =?utf-8?B?WlppYWRqT0VhRW5ZRkpnNVk2WmVBUitCZGo0TUlrekRrd2xmTmEwVjIyUlZX?=
 =?utf-8?B?VmdFMmhHQWt2bDJOM2tJWGpGUVpQYmNRU2pWbFI3VHpkZmdaWUhvRndhL2xo?=
 =?utf-8?B?VTlFeUVkZDBlY0VQcDlQeDBPQUl1Ly9CMWhYNTZ2cG1HNzhkUUZnRkJGanpX?=
 =?utf-8?Q?FEhvWvJzgKlZ3axoIsqLSKc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b70c3f-98b2-4313-f250-08da017d7a9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:32:46.9520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7TlOjELOryXBsw357sUWZOFbZmmH6y9RYyTXUrcBKhyXiN1wWYj5FNVmEUfC8rjjiWx/Q2ubwTJo7P6edupyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3078
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280
 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090018
X-Proofpoint-ORIG-GUID: Nay45b9RIgU2TuqGfKFHCqQRX30M7zHq
X-Proofpoint-GUID: Nay45b9RIgU2TuqGfKFHCqQRX30M7zHq
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



On 3/8/2022 6:13 AM, Eli Cohen wrote:
>
>> -----Original Message-----
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Tuesday, March 8, 2022 8:16 AM
>> To: Eli Cohen <elic@nvidia.com>
>> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
>> foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit <parav@nvidia.com>
>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
>>
>>
>>
>> On 3/6/2022 11:57 PM, Eli Cohen wrote:
>>>> -----Original Message-----
>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> Sent: Saturday, March 5, 2022 12:34 AM
>>>> To: Eli Cohen <elic@nvidia.com>
>>>> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
>>>> foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
>>>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit
>>>> <parav@nvidia.com>
>>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor
>>>> statistics
>>>>
>>>> Sorry, I somehow missed this after my break. Please see comments in line.
>>>>
>>>> On 2/16/2022 10:46 PM, Eli Cohen wrote:
>>>>> On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrote:
>>>>>> On 2/16/2022 12:00 AM, Eli Cohen wrote:
>>>>>>> Allows to read vendor statistics of a vdpa device. The specific
>>>>>>> statistics data is received by the upstream driver in the form of
>>>>>>> an (attribute name, attribute value) pairs.
>>>>>>>
>>>>>>> An example of statistics for mlx5_vdpa device are:
>>>>>>>
>>>>>>> received_desc - number of descriptors received by the virtqueue
>>>>>>> completed_desc - number of descriptors completed by the virtqueue
>>>>>>>
>>>>>>> A descriptor using indirect buffers is still counted as 1. In
>>>>>>> addition, N chained descriptors are counted correctly N times as
>>>>>>> one
>>>> would expect.
>>>>>>> A new callback was added to vdpa_config_ops which provides the
>>>>>>> means for the vdpa driver to return statistics results.
>>>>>>>
>>>>>>> The interface allows for reading all the supported virtqueues,
>>>>>>> including the control virtqueue if it exists.
>>>>>>>
>>>>>>> Below are some examples taken from mlx5_vdpa which are introduced
>>>>>>> in the following patch:
>>>>>>>
>>>>>>> 1. Read statistics for the virtqueue at index 1
>>>>>>>
>>>>>>> $ vdpa dev vstats show vdpa-a qidx 1
>>>>>>> vdpa-a:
>>>>>>> queue_type tx queue_index 1 received_desc 3844836 completed_desc
>>>>>>> 3844836
>>>>>>>
>>>>>>> 2. Read statistics for the virtqueue at index 32 $ vdpa dev vstats
>>>>>>> show vdpa-a qidx 32
>>>>>>> vdpa-a:
>>>>>>> queue_type control_vq queue_index 32 received_desc 62
>>>>>>> completed_desc
>>>>>>> 62
>>>>>>>
>>>>>>> 3. Read statisitics for the virtqueue at index 0 with json output
>>>>>>> $ vdpa -j dev vstats show vdpa-a qidx 0 {"vstats":{"vdpa-a":{
>>>>>>>
>>>> "queue_type":"rx","queue_index":0,"name":"received_desc","value":4177
>>>> 76,\
>>>>>>>      "name":"completed_desc","value":417548}}}
>>>>>>>
>>>>>>> 4. Read statistics for the virtqueue at index 0 with preety json
>>>>>>> output $ vdpa -jp dev vstats show vdpa-a qidx 0 {
>>>>>>>         "vstats": {
>>>>>>>             "vdpa-a": {
>>>>>>>
>>>>>>>                 "queue_type": "rx",
>>>>>> I wonder where this info can be inferred? I don't see relevant
>>>>>> change in the patch series that helps gather the
>> VDPA_ATTR_DEV_QUEUE_TYPE?
>>>>>> Is this an arbitrary string defined by the vendor as well? If so,
>>>>>> how does the user expect to consume it?
>>>>> The queue tupe is deduced from the index and whether we have a
>>>>> virtqueue. Even numbers are rx, odd numbers are tx and if there is
>>>>> CVQ, the last one is CVQ.
>>>> OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in this patch
>>>> might not be useful at all?
>>> Right, will remove.
>>>
>>>> And how do you determine in the vdpa tool if CVQ is negotiated or
>>>> not?
>>> I make a netlink call to get the same information as " vdpa dev config show"
>> retrieves. I use the negotiated features to determine if a CVQ is available. If it
>> is, the number of VQs equals the control VQ index. So there are two netlink
>> calls under the hood.
>> The lock vdpa_dev_mutex won't hold across the two separate netlink calls, and
>> it may end up with inconsistent state - theoretically things could happen like
>> that the first call gets CVQ negotiated, but the later call for
>> get_vendor_vq_stats() on the cvq might get -EINVAL due to device reset. Can
>> the negotiated status and stat query be done within one single netlink call?
> I see your concern.
> The only reason I do the extra call is to know if we have a control VQ and what
> index it is, just to print a descriptive string telling if it's a either rx, tx or control VQ.
>
> So the cure can be simple. Let's have a new attribute that returns the type of
> virtqueue.
I am not sure I follow the cure. Wouldn't it be possible to get both 
negotiated status and the queue stat in vdpa_nl_cmd_dev_stats_get_doit() 
under the same vdpa_dev_mutex lock? And I am not even sure if it is a 
must to display the queue type - it doesn't seem the output includes the 
vdpa class info, which makes it hard for script to parse the this field 
in generic way.

>   I think Jason did not like the idea of communicating the kind of VQ
> from kernel to userspace but under these circumstances, maybe he would approve.
> Jason?
>
>> What worried me is that the queue index being dynamic and depended on
>> negotiation status would make host admin user quite hard to follow. The guest
>> may or may not advertise F_MQ and/or F_CTRL_VQ across various phases, e.g.
>> firmware (UEFI), boot loader (grub) till OS driver is up and running, which can
>> be agnostic to host admin. For most of the part it's not easy to script and
>> predict the queue index which can change from time to time. Can we define
>> the order of host predictable queue index, which is independent from any
>> guest negotiated state?
Here I think we can just use the plain queue index in the host view - 
say if vdpa net has 4 pairs of data vqs and 1 control vq, user may use 
qindex 8 across the board to identify the control vq, regardless if the 
F_MQ feature is negotiated or not in guest.


Regards,
-Siwei

>>
>>>> Looks to me there are still some loose end I don't quite yet
>>>> understand.
>>>>
>>>>
>>>>>>>                 "queue_index": 0,
>>> I think this can be removed since the command is for a specific index.
>>>
>>>>>>>                 "name": "received_desc",
>>>>>>>                 "value": 417776,
>>>>>>>                 "name": "completed_desc",
>>>>>>>                 "value": 417548
>>>>>> Not for this kernel patch, but IMHO it's the best to put the name &
>>>>>> value pairs in an array instead of flat entries in json's
>>>>>> hash/dictionary. The hash entries can be re-ordered deliberately by
>>>>>> external json parsing tool, ending up with inconsistent stat values.
>>>> This comment is missed for some reason. Please change the example in
>>>> the log if you agree to address it in vdpa tool. Or justify why
>>>> keeping the order for json hash/dictionary is fine.
>>> Sorry for skipping this comment.
>>> Do you mean to present the information like:
>>> "received_desc": 417776,
>>> "completed_desc": 417548,
>> I mean the following presentation:
>>
>> $ vdpa -jp dev vstats show vdpa-a qidx 0 {
>>       "vstats": {
>>           "vdpa-a": {
>>               "queue_stats": [{
>>                   "queue_index": 0,
>>                   "queue_type": "rx",
>>                   "stat_name": [ "received_desc","completed_desc" ],
>>                   "stat_value": [ 417776,417548 ],
>>               }]
>>           }
>>       }
>> }
>>
>> I think Parav had similar suggestion, too.
>>
>> Thanks,
>> -Siwei
>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>>             }
>>>>>>>         }
>>>>>>> }
>>>>>>>
>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>>>> ---
>>>>>>>      drivers/vdpa/vdpa.c       | 129
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>>      include/linux/vdpa.h      |   5 ++
>>>>>>>      include/uapi/linux/vdpa.h |   7 +++
>>>>>>>      3 files changed, 141 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>>>>> 9846c9de4bfa..d0ff671baf88 100644
>>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device
>>>>>>> *vdev,
>>>> struct sk_buff *msg, u32 portid,
>>>>>>>      	return err;
>>>>>>>      }
>>>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct
>>>>>>> +sk_buff
>>>> *msg,
>>>>>>> +			       struct genl_info *info, u32 index) {
>>>>>>> +	int err;
>>>>>>> +
>>>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>>>>>> +		return -EMSGSIZE;
>>>>>>> +
>>>>>>> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info-
>>>>> extack);
>>>>>>> +	if (err)
>>>>>>> +		return err;
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff
>> *msg,
>>>>>>> +			     struct genl_info *info, u32 index) {
>>>>>>> +	int err;
>>>>>>> +
>>>>>>> +	if (!vdev->config->get_vendor_vq_stats)
>>>>>>> +		return -EOPNOTSUPP;
>>>>>>> +
>>>>>>> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>>>>>> +	if (err)
>>>>>>> +		return err;
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>>>>>> +				      struct sk_buff *msg,
>>>>>>> +				      struct genl_info *info, u32 index) {
>>>>>>> +	u32 device_id;
>>>>>>> +	void *hdr;
>>>>>>> +	int err;
>>>>>>> +	u32 portid = info->snd_portid;
>>>>>>> +	u32 seq = info->snd_seq;
>>>>>>> +	u32 flags = 0;
>>>>>>> +
>>>>>>> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>>>> +			  VDPA_CMD_DEV_VSTATS_GET);
>>>>>>> +	if (!hdr)
>>>>>>> +		return -EMSGSIZE;
>>>>>>> +
>>>>>>> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev-
>>>>> dev))) {
>>>>>>> +		err = -EMSGSIZE;
>>>>>>> +		goto undo_msg;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	device_id = vdev->config->get_device_id(vdev);
>>>>>>> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>>>>>> +		err = -EMSGSIZE;
>>>>>>> +		goto undo_msg;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	err = vendor_stats_fill(vdev, msg, info, index);
>>>>>>> +
>>>>>>> +	genlmsg_end(msg, hdr);
>>>>>>> +
>>>>>>> +	return err;
>>>>>>> +
>>>>>>> +undo_msg:
>>>>>>> +	genlmsg_cancel(msg, hdr);
>>>>>>> +	return err;
>>>>>>> +}
>>>>>>> +
>>>>>>>      static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff
>>>>>>> *skb, struct
>>>> genl_info *info)
>>>>>>>      {
>>>>>>>      	struct vdpa_device *vdev;
>>>>>>> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct
>>>> sk_buff *msg, struct netlink_callback *
>>>>>>>      	return msg->len;
>>>>>>>      }
>>>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>>>>>> +					  struct genl_info *info)
>>>>>>> +{
>>>>>>> +	struct vdpa_device *vdev;
>>>>>>> +	struct sk_buff *msg;
>>>>>>> +	const char *devname;
>>>>>>> +	struct device *dev;
>>>>>>> +	u32 index;
>>>>>>> +	int err;
>>>>>>> +
>>>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>>>>>> +		return -EINVAL;
>>>>>>> +
>>>>>>> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>>>>>> +		return -EINVAL;
>>>>>>> +
>>>>>>> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>>>>>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>>>>>> +	if (!msg)
>>>>>>> +		return -ENOMEM;
>>>>>>> +
>>>>>>> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>>>>>> +	mutex_lock(&vdpa_dev_mutex);
>>>>>>> +	dev = bus_find_device(&vdpa_bus, NULL, devname,
>>>> vdpa_name_match);
>>>>>>> +	if (!dev) {
>>>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>>>>>>> +		err = -ENODEV;
>>>>>>> +		goto dev_err;
>>>>>>> +	}
>>>>>>> +	vdev = container_of(dev, struct vdpa_device, dev);
>>>>>>> +	if (!vdev->mdev) {
>>>>>>> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa
>>>> device");
>>>>>>> +		err = -EINVAL;
>>>>>>> +		goto mdev_err;
>>>>>>> +	}
>>>>>>> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>>>>>> +	if (!err)
>>>>>>> +		err = genlmsg_reply(msg, info);
>>>>>>> +
>>>>>>> +	put_device(dev);
>>>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>>>> +
>>>>>>> +	if (err)
>>>>>>> +		nlmsg_free(msg);
>>>>>>> +
>>>>>>> +	return err;
>>>>>>> +
>>>>>>> +mdev_err:
>>>>>>> +	put_device(dev);
>>>>>>> +dev_err:
>>>>>>> +	mutex_unlock(&vdpa_dev_mutex);
>>>>>>> +	return err;
>>>>>>> +}
>>>>>>> +
>>>>>>>      static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>>>      	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =
>> NLA_NUL_STRING },
>>>>>>>      	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING
>> }, @@ -
>>>> 997,6
>>>>>>> +1119,7 @@ static const struct nla_policy
>>>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>>>      	[VDPA_ATTR_DEV_NET_CFG_MACADDR] =
>> NLA_POLICY_ETH_ADDR,
>>>>>>>      	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>>>>>      	[VDPA_ATTR_DEV_NET_CFG_MTU] =
>> NLA_POLICY_MIN(NLA_U16, 68),
>>>>>>> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0,
>>>> 65535),
>>>>>>>      };
>>>>>>>      static const struct genl_ops vdpa_nl_ops[] = { @@ -1030,6
>>>>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>>>>>      		.doit = vdpa_nl_cmd_dev_config_get_doit,
>>>>>>>      		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>>>>>      	},
>>>>>>> +	{
>>>>>>> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
>>>>>>> +		.validate = GENL_DONT_VALIDATE_STRICT |
>>>> GENL_DONT_VALIDATE_DUMP,
>>>>>>> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>>>>>>> +		.flags = GENL_ADMIN_PERM,
>>>>>>> +	},
>>>>>>>      };
>>>>>>>      static struct genl_family vdpa_nl_family __ro_after_init = {
>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
>>>>>>> 2de442ececae..274203845cfc 100644
>>>>>>> --- a/include/linux/vdpa.h
>>>>>>> +++ b/include/linux/vdpa.h
>>>>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
>>>>>>>      			    const struct vdpa_vq_state *state);
>>>>>>>      	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>>>>>      			    struct vdpa_vq_state *state);
>>>>>>> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>>>>>> +				   struct sk_buff *msg,
>>>>>>> +				   struct netlink_ext_ack *extack);
>>>>>>>      	struct vdpa_notification_area
>>>>>>>      	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>>>>>      	/* vq irq is not expected to be changed once DRIVER_OK is set
>>>>>>> */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
>>>>>>>      int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>>>>>      void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>>>>>> +
>>>>>>>      #endif /* _LINUX_VDPA_H */
>>>>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>>>>> index 1061d8d2d09d..c5f229a41dc2 100644
>>>>>>> --- a/include/uapi/linux/vdpa.h
>>>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>>>>>      	VDPA_CMD_DEV_DEL,
>>>>>>>      	VDPA_CMD_DEV_GET,		/* can dump */
>>>>>>>      	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>>>>>>> +	VDPA_CMD_DEV_VSTATS_GET,
>>>>>>>      };
>>>>>>>      enum vdpa_attr {
>>>>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
>>>>>>>      	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>>>>>>>      	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/*
>> u32 */
>>>>>>>      	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>>>>>>> +
>>>>>>> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
>>>>>>> +	VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
>>>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
>>>>>>> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>>>>>> +
>>>>>>>      	/* new attributes must be added above here */
>>>>>>>      	VDPA_ATTR_MAX,
>>>>>>>      };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
