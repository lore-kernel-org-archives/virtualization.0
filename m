Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6040CC433F5
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 13:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E81B04093E;
	Tue,  4 Jan 2022 13:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id quMd_n13-faf; Tue,  4 Jan 2022 13:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62B874093A;
	Tue,  4 Jan 2022 13:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 379DDC0030;
	Tue,  4 Jan 2022 13:05:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE79C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 445404093E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I3u5_Rq8wUNK
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:05:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE12C4093D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:05:04 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204Bn4Zu008977; 
 Tue, 4 Jan 2022 13:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=W158oB+mxTq7UJS2z3FPICJHyjca/sw7+5jVOFaPDoo=;
 b=L71U1vQhhHwHsTZPTeqMf228Ker4A1cxL7gFV/R0XOO2fXYA1x6JN893NwB8UyqMjGhM
 0uXByE4WXX5L2ZvOudLOdeTwaAB+5KmKOB/FdOow2BydFiK2EhH3hk2J3h5vNXXnflJY
 UCR8a2oxOD3K6ig7dCs9Bn/xoTAOwUdZiG+CzmlgiBBzkmSNjsOmS4rQ77djZPSQ2T2r
 pMalR1CkonwLaaU+V+Em5FF5ydHT4qaFRP61DWEO4rs1Go3uiq/NjS+nPrvCeyiQx51X
 cMjB0oB1ULQhn9T93WD94O1zqLb5SwZRmHtwO9VULoJsUXAl5n4vKQ8D++ZebYVK0b+Y bQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fj3wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jan 2022 13:05:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204D1m0m094780;
 Tue, 4 Jan 2022 13:05:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by userp3030.oracle.com with ESMTP id 3dac2wjhdv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jan 2022 13:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpMv03e0HxWkgVVIUm04SJXI6uz2arQdcGpsyijh1+tM9UjCBd25V3L94VCtBDOql5H5m+7KlM+lOQu389RnIrAizNE1dYmQgV8YhmvejqyxtbD5PDZBue+1kVrRYWKl4wTTuDgX96PTLG1KsTyOFFMOpFOtLBmHfeVfGQnVYV/AAhqcpHjhBbpB+s01tILWj7QC+/+BE1QYloQFRvFnUmN9Fw7QAlWdH6cOwA85vkWpU2ji5vFFq8KmnF5y0vPvv1UsKBR6C5Gwd7GYB+HWtlbXmTkRut6JPg60lbyNAd4hR8z2IL4y62D0uFubqc6Irny9f1w2jLfV4eXlZvWakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W158oB+mxTq7UJS2z3FPICJHyjca/sw7+5jVOFaPDoo=;
 b=OrvBCCOn0BMhoHEw8e2Ttf+wwnp0Tx8hdhhGu8AY/hNNYkfpfy12zeVnh6O0b8UalWZc/1H44DM+8CQtQUPb7z8BgkBussHsHb5/cAHaQRB/b6Z0o0KmVpkPiISA9xjl+HQgUioUbzva2YvnCFjnKGmdUmvOtyggPWVn8tBSM5wCQdfXaZXAwn5RWNmllHHlRdqxaYlG2JF5taviORdbH36KJoneTc7+qwWc2ogUsAWqX+7avzpqT05IXyCw6YS7oAAHWpTAidA16HLplTcx43upKjB6A3dvr+ftYHrtQ47n5xGcJc0W2a4ugPv8UQ8vCeXYVT+em7TNMH/zenZFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W158oB+mxTq7UJS2z3FPICJHyjca/sw7+5jVOFaPDoo=;
 b=Di/4rsngfZhZtDzbCBsydR+tvBu8ZQlVsSwwSYhsprUY5ZFRpSpEOPgTQgUNJ+uN3mFjtOzhiXH22f2f/NddY1tZ0nftADMnEclRiWbP5J3icNwEIURSii6iSri4sFCFSXS4IPP3BdrKZ1Ic8wANYk/+xv4CD/wLRyp+ndcRUCo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3365.namprd10.prod.outlook.com (2603:10b6:a03:15a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 13:04:59 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 13:04:59 +0000
Message-ID: <87ef49a4-628f-97a8-da6b-3d76c06bd947@oracle.com>
Date: Tue, 4 Jan 2022 05:04:53 -0800
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
 <d1f3361e-2d4f-a586-bcd9-5aef3600a04d@oracle.com>
 <20211228153610.GA240874@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211228153610.GA240874@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c67be0e-a186-4167-b4ad-08d9cf82d02d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3365:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3365315322B19DBC08FBA46DB14A9@BYAPR10MB3365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8NhHfE4/8C9zcaAViZkL1vXiGsNc5c2NrMVudUbsSdQ9ZkckA1YT5WMPtMBOvXJeNKW08nVxmimMgzKFVOSpyLrr3I2fv1eUUa0QGsM23VIlJFrb+8DX4vO2A8IGMDchAIhtU6nWbVLhOF8FoUc/PzrRf+EbJgGZ7w2ujvKSWU4tbrOZWqFJZ9XBnl9bo43CxjQTcCdG8oADhVNIF7Z0lEyS9qTCMGBGQBwLUiqSuovcv5DLEcAOFnC2b9tNueu+gcwHr2wsoWXSfBxBfq0U8katywiIIPsbtq54ojpb/nXTyxyEGOxq3Do4yoZiKK2xucsxI0xeeNSsnFgW3WohqRGbxchIIeHUcXaPNj+PGMDP/wmvVXADlsgi/iAnCr/7JXcwXjKoNBcK7/VSxDeKAP4cfY675GRVosyVwauRmquWBK3Sz2jyHTupZpIdP9aNuhJqAW0Zt4GEhsdl/Cm553xXuZNSkDNCeIHi0SkIcF3UzSs+Ar3LopBtqQKJ//4UnJmfn4j13fBC49YytbHrxaV0C6mLCzpo37kCSQs8JxxfKfX/R5Ro0CRID5irtCCdopCv6EIWVXluOEmMsPiZuLVtVscNAkGmwsN93Qm98ZhkhQAI4/2EFI21Tzj3uVrYiaejpW1P+n6RqXILShfR65dAZ37OdDtkKdgISDOXXUSrUKMayPG7HbzXaTkrpz2cugfkTPNbTr9taixVGd/6ngiesHI0jaZ0kcavNBMho8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(83380400001)(6916009)(8936002)(31696002)(86362001)(5660300002)(6486002)(6512007)(316002)(26005)(186003)(2616005)(6506007)(4326008)(38100700002)(31686004)(6666004)(36756003)(53546011)(66556008)(2906002)(66476007)(36916002)(508600001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHB4ZUVlZlpVWkI3Z0tlM0tRZUIrc1hSU1hWV0NnZDJtU0xJaU9ybjkxZ3Ex?=
 =?utf-8?B?akxwWHhibCt3UFI5OXpiL1FITlJDY2FaMUFLcU0vRGJmc1YxSlFkMXpvZ0lD?=
 =?utf-8?B?TEh1ekRqK3lsOThJYy9wOTlvNm01ZEVmSjVBTVZGbWE5NU4rYm12WEV4OUE1?=
 =?utf-8?B?QXBVUG1Jcmw2RDE4UXFvM0tqNjgxakJCckpHMzBNdFUrcEgrcEFIODNGWE9l?=
 =?utf-8?B?S2ZuQ2Y0QzVmTWdJM0lqaTMwU1c4VmZiUHFROTgyNUpSWS9WMjhtbk9BWFow?=
 =?utf-8?B?dGlYWFRlNkZlcEpqdzBacXNWaEF3b1N4bENtTVdDWnRVTWkvSHhIY3o0cmYw?=
 =?utf-8?B?aXpRYjRUWFd1NHpwMFdlRkhtNVBkUTRSMWh2TldpWnV5Zm84ajU3bXY2dlVC?=
 =?utf-8?B?RWdyVmxxUUF0UEVzMXNGREdicGN1QWdVNGZDbkdjUTZrL2puWDQzaE9kL2hF?=
 =?utf-8?B?ZUxMRTNJbFMzRXBhVEdBYUR0bW9lUUpjSjF4RFpMQVNlWDd2N3FrVUpRM3B2?=
 =?utf-8?B?eEZRK3N0SVZiMzRER2F0NWw4OSt3NHMxUUZ0UGZmVElzUGIxeEluK2x5Nk9Q?=
 =?utf-8?B?UjNoMHBLK2h6dWtjeVBSTzMxdmRtTXpzbFVjRVE5QXZPbkZUeXBlZlJnM0Nl?=
 =?utf-8?B?WTVRQmM1RThPOUtpK1NmRUFlQnVSYjNqbUZTY0dOWEZlb3lBb2lmb2RXL3lz?=
 =?utf-8?B?ck5jcHlVT3lNakVZMndXaXRHVE1NQU4rS3BkaEI4dExmendwdkVmZVpXT1Fy?=
 =?utf-8?B?NFhMVGlRL1lUaW9SeGlaMVFVVGxjRUJNK0NwNlVkM3NvbU56Q3J5d0dYcDd3?=
 =?utf-8?B?S2pWZ041bXhBY1FoZURDdFgwOWp3SWlzMGlMbFcrQVdidmQ3ZmRKZTZiaTZX?=
 =?utf-8?B?T1FKSW9QTloxekgrSy9hU0JuYzU4WEI1Ni9BZEI3d0NHQjY1RXA5akdnSmVZ?=
 =?utf-8?B?ekRnT2R2YVAyZ2VJdW0xajNxWC9seUVsdEQ3WWpGYlJxdlV3cm1oSGdZdXpR?=
 =?utf-8?B?NzhRZWY3UVVSZWh5NG5EbU9tWlp2ODRFdHVLdU5pRDJ4bTlMU0hhaUVWU0p4?=
 =?utf-8?B?RWFHZjhjYkJRTUh5bzBHcld1Z1VFd1k2bUgvTXdCb0xvdjF0Y3N6d2I1M2py?=
 =?utf-8?B?ajJiV0paYXk4QllRRGxScllTcjAvTUhLU1pIbms1b1J0aWpSVVZ3cC8xOXFR?=
 =?utf-8?B?bnQ5OWdkb0tpR2R0QTRIZ3VDUVRBeUhXMTRPcG9IcDEvcHAwUzdoNWdwbjhS?=
 =?utf-8?B?Sk5na0NZajZ0eGYwNk5mUTRQK1RtNnpkSjNTbU9DMEtQYkkwbnpwTHNjeTB5?=
 =?utf-8?B?MXJUQ2pSZDllazZxWGQvRWM3VzI0R2NIcWkwTUMzbDkzdVRrLzJJQkJwc2ph?=
 =?utf-8?B?ZVBJRkwxa1Mvb052UGRDSS9FNzgxODg4eXJTcGVRS3A2ay9VcjZSR1dtUlky?=
 =?utf-8?B?WmNjTlYrTVlXUXZhaWRZL0FRRDIrbWZ3dllUZUdtcjMxREwrcDhoVWxBYTdP?=
 =?utf-8?B?TWlrVVVjWmgvVXYrZEYzU0dNQ0g2c0hBbVpKVWJ3NTRnY1ovYzQ2RllPMDkx?=
 =?utf-8?B?RytCVHI4TVlXSE0yN2VTN0Z1eElQNDlLMzFEemNjdDgwbmVkRi9mbGRiako3?=
 =?utf-8?B?eVBuS1h1YlNueUs3aFdTbmFWY0tVa2EvT29LRWRRdVF3d3VDUHhGYmJaLyt5?=
 =?utf-8?B?c20wSjVnWmV0dTAwTEtYbXVsRml0cTZKemt4Y3dBajZjNXM2cXpIL2dVa3BZ?=
 =?utf-8?B?U1poL2R1UUpMWTFXN1lRWGxsNWZjUmpXSnRiUThtTjRMZkJXa09MeXlWdXRn?=
 =?utf-8?B?Q2R1dGVPT3IwaHJsOS9hMklkUHBxSVJwN1VOanJJUWhPazkxVEhEcXE0K2xu?=
 =?utf-8?B?UldxdVFXVUlxRDRqNWNtYnN6QXdLNGdHYUhQQlpnMVdWNFlscU1tS3hqaWJs?=
 =?utf-8?B?YVFHN29xUE1QZTVNam8yZjJ0a2FHMVIwaVYyeHh6eXRlSys3bGhPV2J3UVR3?=
 =?utf-8?B?M3UvdTg2dE5LNWtkUzBaeUhQQWk4WDdobkw4eXJNV1Q4TklVbVpLZFJNZ051?=
 =?utf-8?B?VzMxTXRMMkZpWFRkUXpuaXF3VVVUMUpPWTlQYUJvZzRncGN6RllYemxaNStC?=
 =?utf-8?B?Y2xFWDJGa3VoRCsyOUVtOWZOZnp4KzJYeUM4Z3FrUEtPY3RmQ2NiVzNUZkw3?=
 =?utf-8?Q?4MLpJeigeA+MAGad50p5PjE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c67be0e-a186-4167-b4ad-08d9cf82d02d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 13:04:59.7333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0wfkN2lYOiETInOWm+mZPlcqxZIP21sho1ikwsYy5AMUy0WTw52AvQ0Iu14+2JXa/b2eJaCLXY7ThPqIYbWRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3365
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040088
X-Proofpoint-ORIG-GUID: cmsfzEju9NahmAA3d158i7HmSmBWAYj-
X-Proofpoint-GUID: cmsfzEju9NahmAA3d158i7HmSmBWAYj-
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



On 12/28/2021 7:36 AM, Eli Cohen wrote:
> On Thu, Dec 23, 2021 at 01:58:50PM -0800, Si-Wei Liu wrote:
>>
>> On 12/22/2021 9:46 PM, Eli Cohen wrote:
>>> On Wed, Dec 22, 2021 at 02:58:18PM -0800, Si-Wei Liu wrote:
>>>> On 12/22/2021 6:20 AM, Eli Cohen wrote:
>>>>> Add wrappers to get/set status and protect these operations with
>>>>> cf_mutex to serialize these operations with respect to get/set config
>>>>> operations.
>>>> Need to protect vdpa_reset() which is essentially vdpa_set_status(0)
>>> And what about vdpa_set_features()?
>> Oh, that was missed... Indeed, it also needs to take the lock.
>>
>>> Maybe it should be done as part of another patch to address this?
>> Isn't this patch the one adding the helpers for the locked API? I think it's
>> fine if you'd like specific ones for reset or set_features.
>>
>>> Shouldn't all these serializations requirements be handled by the caller?
>> If the caller remains in the vdpa core I think it should be fine.
> I meant usually qemu makes these calls. Isn't it the one that will
> maintain required serialzation?
Actually, I am not concerned much about QEMU as all the vDPA ioctl's 
have been serialized in vhost_vdpa_unlocked_ioctl() through 
vhost_dev`mutex. The cf_mutex is primarily used to serialize the getter 
and setter of the virtio config. For getter we need to ensure the 
integrity and consistency for the "vdpa dev config show" command output, 
while the updaters for the virtio config are the set_status(), reset(), 
set_config() and set_features() calls, which can be from either 
vhost_vdpa or virtio_vdpa. It's better to have vdpa core maintain the 
locking and individual bus driver just call the vdpa locked API routines 
with atomiticy guarantee as needed.

>
>> Or you
>> want the vdpa bus drivers to take the serialization requirement? Perhaps not
>> so good.
> Can you give an example (or two) of secnarios you're concerned with.
For e.g. in vhost_vdpa_set_status() the ops->reset() call is not 
cf_mutex protected. Theoretically it's possible for a concurrent 
vdpa_dev_config_fill() thread to get already-reset-to-zero features or 
invalid config data, even though the _S_FEATURES_OK check had been 
passed pveriously before the reset() call. virtio_vdpa_reset() suffers 
from the same problem, too.

For vdpa_set_features(), it's possible the feature negotiation is not 
complete yet, thus a concurrent vdpa_dev_config_fill() call may get 
premature config data. Since your next patch explicitly checks 
_S_FEATURES_OK, in reality it's probably fine to not take the cf_mutex 
lock - although the check only works with virtio 1.0 guest driver. If 
legacy support will be added in future, this check and the corresponding 
locking has to be revisited then.

Thanks,
-Siwei



>
>> Thanks,
>> -Siwei
>>
>>>> -Siwei
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/vdpa.c          | 19 +++++++++++++++++++
>>>>>     drivers/vhost/vdpa.c         |  7 +++----
>>>>>     drivers/virtio/virtio_vdpa.c |  3 +--
>>>>>     include/linux/vdpa.h         |  3 +++
>>>>>     4 files changed, 26 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index 42d71d60d5dc..5134c83c4a22 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -21,6 +21,25 @@ static LIST_HEAD(mdev_head);
>>>>>     static DEFINE_MUTEX(vdpa_dev_mutex);
>>>>>     static DEFINE_IDA(vdpa_index_ida);
>>>>> +u8 vdpa_get_status(struct vdpa_device *vdev)
>>>>> +{
>>>>> +	u8 status;
>>>>> +
>>>>> +	mutex_lock(&vdev->cf_mutex);
>>>>> +	status = vdev->config->get_status(vdev);
>>>>> +	mutex_unlock(&vdev->cf_mutex);
>>>>> +	return status;
>>>>> +}
>>>>> +EXPORT_SYMBOL(vdpa_get_status);
>>>>> +
>>>>> +void vdpa_set_status(struct vdpa_device *vdev, u8 status)
>>>>> +{
>>>>> +	mutex_lock(&vdev->cf_mutex);
>>>>> +	vdev->config->set_status(vdev, status);
>>>>> +	mutex_unlock(&vdev->cf_mutex);
>>>>> +}
>>>>> +EXPORT_SYMBOL(vdpa_set_status);
>>>>> +
>>>>>     static struct genl_family vdpa_nl_family;
>>>>>     static int vdpa_dev_probe(struct device *d)
>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>> index ebaa373e9b82..d9d499465e2e 100644
>>>>> --- a/drivers/vhost/vdpa.c
>>>>> +++ b/drivers/vhost/vdpa.c
>>>>> @@ -142,10 +142,9 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>>>>>     static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>>>     {
>>>>>     	struct vdpa_device *vdpa = v->vdpa;
>>>>> -	const struct vdpa_config_ops *ops = vdpa->config;
>>>>>     	u8 status;
>>>>> -	status = ops->get_status(vdpa);
>>>>> +	status = vdpa_get_status(vdpa);
>>>>>     	if (copy_to_user(statusp, &status, sizeof(status)))
>>>>>     		return -EFAULT;
>>>>> @@ -164,7 +163,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>>>     	if (copy_from_user(&status, statusp, sizeof(status)))
>>>>>     		return -EFAULT;
>>>>> -	status_old = ops->get_status(vdpa);
>>>>> +	status_old = vdpa_get_status(vdpa);
>>>>>     	/*
>>>>>     	 * Userspace shouldn't remove status bits unless reset the
>>>>> @@ -182,7 +181,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>>>>     		if (ret)
>>>>>     			return ret;
>>>>>     	} else
>>>>> -		ops->set_status(vdpa, status);
>>>>> +		vdpa_set_status(vdpa, status);
>>>>>     	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>>>>>     		for (i = 0; i < nvqs; i++)
>>>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>>>> index a84b04ba3195..76504559bc25 100644
>>>>> --- a/drivers/virtio/virtio_vdpa.c
>>>>> +++ b/drivers/virtio/virtio_vdpa.c
>>>>> @@ -91,9 +91,8 @@ static u8 virtio_vdpa_get_status(struct virtio_device *vdev)
>>>>>     static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>>>>>     {
>>>>>     	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>>>> -	const struct vdpa_config_ops *ops = vdpa->config;
>>>>> -	return ops->set_status(vdpa, status);
>>>>> +	return vdpa_set_status(vdpa, status);
>>>>>     }
>>>>>     static void virtio_vdpa_reset(struct virtio_device *vdev)
>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>> index 9cc4291a79b3..ae047fae2603 100644
>>>>> --- a/include/linux/vdpa.h
>>>>> +++ b/include/linux/vdpa.h
>>>>> @@ -408,6 +408,9 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>>>     		     void *buf, unsigned int len);
>>>>>     void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>>>>>     		     const void *buf, unsigned int length);
>>>>> +u8 vdpa_get_status(struct vdpa_device *vdev);
>>>>> +void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>>>>> +
>>>>>     /**
>>>>>      * struct vdpa_mgmtdev_ops - vdpa device ops
>>>>>      * @dev_add: Add a vdpa device using alloc and register

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
