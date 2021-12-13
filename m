Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C70C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 23:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 805F5402FF;
	Mon, 13 Dec 2021 23:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrOowKnR6gMu; Mon, 13 Dec 2021 23:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28F8B401C4;
	Mon, 13 Dec 2021 23:51:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE66AC001E;
	Mon, 13 Dec 2021 23:51:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44B54C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40CCF60B5E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="HLOkYMKe";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="zUPK7hRS"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j0-NzCWHVSRS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:51:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82A4F60B1E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:51:01 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLKo0h005506; 
 Mon, 13 Dec 2021 23:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=axJqbUQju2734I5/NBHs6qUTYcCcUr5ULJYMiB8OYY4=;
 b=HLOkYMKe2PYZ9nRJw3F/l9w7BhSsBUsrIavjMmbPfFnU6A5/m8WBBuzMZgBfAKhcKRjO
 iEPe4v6KBTZg04K7WYthasUlwHPhf1jbUhp/XjG6/Y5h706b4HOnwFM4fjaEjuRyycKQ
 uyZ5xJdyUK3rtA0GLL6Lg/GC0xiNUfmOjpMSdbC9xz3JemmlDu8QwxvZtmZFNoig3aBR
 vSkAnyOlTN20dq1vFfXJd2gFpj2NZbs48bR1o2JgEXlZi+HV+9RJBM0YUJC18Oy9jM1J
 Jilq/mHLpVWASAHDVoQO7pDc45Puf8ikxhx9B3JsRU0E/bijrpS5tZM2ea0QEvLKC06G aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u1ycv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:50:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDNj2xL123262;
 Mon, 13 Dec 2021 23:50:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
 by userp3020.oracle.com with ESMTP id 3cvnenx8r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:50:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew5su+SxuhQtm5P1QAYRmo1SU3zGkrAUTrtx40/uQZor3oIyVakoZbBRKgV787Ea6ddpsc1QPUl6ctLiUfsnA4R7/Rb9YqWight3cLRV6BG/1uTSSaU/nqjTniYarYFUaYM4j/xl/GKjDltflZDSWx784IjHM9ovPIUEsApXhyeyeIij9bedSHU2raJ/hrvlmDQUDtRDkTLIuzoS1K3gDdstimLXKMLNk9la/O/JMUKkiIZT1ur5djG6tuSvMLy5zejs7IzModUtm0oB9bOAAnbzBTe/kYHNWyeiSao3Cib+ISostIWTCfYpntNp/2+/eNGP+wvIjZzcQx5bFc/V3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axJqbUQju2734I5/NBHs6qUTYcCcUr5ULJYMiB8OYY4=;
 b=S5UEv6W78j2sI9NM9C2X7X2cE+sKdNjL/QZUWLPT7zGn0ecKk6Ahk4JIU1bIpKcZtDrh0FY8KO72ydupFG+7X/LFdxjWLlXg2CC+qpBo5++QQ2CbDHzZv7Xl1I/uAX1e+ciDiyKGdEl4buiKo0YXubvsUFzuiLCVU85k9OU06na4BaWjn14Z6ysGNB0Oso2CJR+jUXJ+lNOfWSCbVNcOX94B/Y8FynS39fXRxa0PwWw/mVWmBhPbGmBwIdhucWaokQ6yau3hdEvOgSvHVD+SSbN0/gBXHHTAe1vMr1qkOVyABbFwbl5hvcIlOkwPIeEd7WftHZoNHDRIz7aDUnzh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axJqbUQju2734I5/NBHs6qUTYcCcUr5ULJYMiB8OYY4=;
 b=zUPK7hRSyhOchYpiR0j14zkKUw3fMIZTvCPb90V4BD4HSIhCSAk4yzeP0lNL49ABXbyECmVTuf0ELGz+t8s0HzV5YIHsfhTaTr3xJOwUY2F2jm1b5N8lKTCVjBUx7LH55t/fkZlppU6LdSi8JmZ9qcRnLp7ij30N50gUxQkdfnI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 23:50:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 23:50:55 +0000
Message-ID: <aa58ee17-4768-0724-4e22-af2fd2eff646@oracle.com>
Date: Mon, 13 Dec 2021 15:50:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 09/10] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-10-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211213144258.179984-10-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:806:127::14) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cef9b8bf-a4b8-4a8d-4622-08d9be936770
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4477:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4477484D1CDEB9D118E2BBA5B1749@SJ0PR10MB4477.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0XKBWj9qTSj/qFzsC+7wUsf2wWVtfNnn5/ScV9HAwW7JVvEFNeCuzUZ/E79RfACwq8Mt6PdEZs5e+mfxZaMT06FM7qjpNRkNvElyEThDlqL8jJk3bpaGXJedJpfkW3RY18fTYx6zDxZoRbWmmlIJiAgDtCePJFSAO7txfBDOWuzhDnjUKCmol9AAWWP9SZeS4e9TixlI6a/+Rr4dLd5mznaT2xgFBrICbNeC5BUfJMbt4vmCfbjoELCV5wguaD+TA0E2ggxG5Re3+xAa/PLXPY03G9qYJ8+lPnm97crhjlwOKXU6i7hrcGr0QKEFOXI9pPJpLlvSwu9wRFiIcURbBlyfSG3vZtYCLyDegBh3MoGXh3ZsoZTwrvr9qdBAu2LcO/ZUjW6gkAabmdcj3DJ70uCTIUDQObF69bOD8ibR1PbyYMNW/TcrPTOCH7fTCQiYbUsgW5zjAcXND4ieCUzdhbwtng1ZrP0tWFVLSL/y4hEhfYBvZgI2hpFn/NmDp7lNFMvBD7k/26T6UVu9vcrJn8KJ3IBzh7wl7mFkwNxUrz9hC0nqb3oUdViGbbUsbuab956hVI+0O4yy966fBmiiBT0JcbZ5qDzgP2j968WwqSZ1hZrq5eGlc8Utzimrpc6UOu2vz8O7YIYxuhYHvLZGURRIbH+3Egy9Y6xuJQU1V/YWgjyHmntWVJvhn7gZo0vA6+b58ukyM+E9AvY4QOSodXrMM+nav5AlYo0YE4F930=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(8676002)(8936002)(2906002)(66476007)(5660300002)(2616005)(6512007)(86362001)(6486002)(83380400001)(31686004)(4326008)(6666004)(508600001)(53546011)(38100700002)(186003)(36916002)(36756003)(6506007)(26005)(66556008)(66946007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2F0RWQvbEl6Y25yeHlrVzRMRk9jM2xYSkw0WDdvZ0JOczU4dGFoaGsyVGYx?=
 =?utf-8?B?SVVBQWNsc1RzT1BHbHFFOFNiaWI3WVJDczgwZHcyU0haTFhrU2pCV20rZ3Bv?=
 =?utf-8?B?alFGZndUTWNRVXJVRk1pUTk1aUx0VFY0ODAxQlFsNmdFN0dvc3FsVTl1SzV0?=
 =?utf-8?B?NkpGMytqbFlhSXA5VzdYMUIzSFlyNTBLSWFnYWk0NjJ3SXd1UWdXcDBJMFBN?=
 =?utf-8?B?ZzVVYUxLZjJOSmVvYWR2OXd4cFBEZmZNNlZxRTE3L0lmQVZMZW9odWdzdjl6?=
 =?utf-8?B?eVUrRWZ1dms4SzJUNXdYam1jSVJJcWc1Vmh3ZWpDLzlIeWdrZFRzVGM3eWpv?=
 =?utf-8?B?aGd0WXRCdHJMdmdhQ3RRcE8yMUFOSWhMVlNFNjZVZHZLN3V6c0NKTUpqL3N3?=
 =?utf-8?B?STh2V1lLZEdlLzBhNXJ5TzdSRXZLWndGbzJRSVBRbFZOSkYyYkMvQkdHNVFz?=
 =?utf-8?B?SUZYSGJtL0hFWXp2OEhSNU9USUI4RFpkRk5MQUlwVnBaNElJQWhZNitQWWJa?=
 =?utf-8?B?ckhTcnNOUWgzQnJRU0JQeHJmdE5GY3FiTGkydmd0YlFnbFdUYVhSUXRPcjl0?=
 =?utf-8?B?TzVIdzVrQUp1ZHR6SU0vNGdFNkQ5aElvTnp1NitkUDhsUXVvdE84TDI2cGkv?=
 =?utf-8?B?dDdqTDBBTVhaUHRwcTJPeVJ3VlkyeFFwWUsvT0pZNE5IK2ZlZkVYN1BBdGhy?=
 =?utf-8?B?SDVvU3lnZnpjcmRJWHpkVnBqeHZwdDMyRHkvVzEva3NrWEZFRGpZOWZIVVdR?=
 =?utf-8?B?NVBDN21CV0h3UndkaXpPWkZ2aEdua2c4L0JzUllXcE5vL2Z0T0E4MkxPYUlw?=
 =?utf-8?B?SWVVUVA3Z1lkT3VYbDNrd2NpSzhGRXRWVTZld3JucnJ2RVp1RklYcURwZVp3?=
 =?utf-8?B?L3E5ZnFOR2pYYjJTbVhIL3RxRXN6NElpV3JKcjZLYUFzWUdSd2RKaG1DYUhS?=
 =?utf-8?B?dysyd2VtMHVPSFNpZ1lNdGZ6UzN4Zk10U2dDdW44aTBydUhIaTFnUjRjVENx?=
 =?utf-8?B?a2hyK2dHT2tIUkpYM2oxRUc3eHdybjVRYmNDUXNTaDQxTmc2T2JWalRUU0pk?=
 =?utf-8?B?SERZTXdzUGdjUjlZMitacFhEWjFFNldaS3p2Q3pkczU0ZGc4K1kzQ2x6eEtp?=
 =?utf-8?B?bE5jUXR1UHdnS1dqbG5zWFhTamtmY0tCbUZUOXY4akZkMmFjNUJFVkR2SVlB?=
 =?utf-8?B?V1V0S29lQnlsQS9vVWcwT0xiUENoeFk2Rkc4T0k4QUtwbnUvRjBzZlZXOFNh?=
 =?utf-8?B?aEZ6bEZ1ODBudGw4RlB1NWEzTHBDNUZsazNUeUY5RTRtSmY3MkJTT0xSMENp?=
 =?utf-8?B?S3NQYXBhWXhmaTM5NThXM0hsaWJhT3VPWXRla2g3VXJDRzhCRTMxQnEwTnhr?=
 =?utf-8?B?NHpsWWxISDNZb3BVRnlheG16dnEzajNvdWE2amE5VDcyMnJRR2tFM1o2RVdo?=
 =?utf-8?B?bW1rZXlIcXVIYWZXVm5OUEN4RDk0SHlUYlJ5NjRKbUZDbnZPakNMMTU0MTFo?=
 =?utf-8?B?TU5VbmtocnBrelhWUHRqSkhLOER5OVVTdXQxeWtQRUFHclR0MER2UHhkM2U0?=
 =?utf-8?B?QUt5N2NIeFBnQlp0MnBnYzlUbWg0SlJvVEJXOTdWM2UzR3NCQTJISDdPSHF6?=
 =?utf-8?B?ZG14YzhueUMwTEZMZ0lNNkpEUHpUN1VKalpkUkpLK0lSWnNBOFhCeWtFTXVq?=
 =?utf-8?B?WTlkWXhVa2JhUDg2MW11RGVwUnRIY015cDFhRDkyRldmbC9ySHB6RVlPajRi?=
 =?utf-8?B?UlE4RGNzOC8zM0ZaYWRZUFhNQlpSOWt2bmdocXVUaFpTa2JyUUJFYklJbmw2?=
 =?utf-8?B?bEt1RGZ0bzBEdEJ5b0hUTHNJQ0MxV1I3OXh3MWZXUDBuQ200ZzV5VzkvNlMw?=
 =?utf-8?B?Zk0wdmxPbFlFOE5UQjVDSC92YVRYeU1Gd2hLYTFjelNOaU1yQTBScjE0VlU2?=
 =?utf-8?B?V1F3Tnh1N0Z4clJ6WjhVTFZ3SjJMZE9yTFEzamE5MCtjUkZqSWVmcGF1YnZp?=
 =?utf-8?B?VGR0WERvQ3JLK3FFRW9VUDRxTnozMzNtUW1SWkYwdjdMNVBMNUZSeS9ROGVX?=
 =?utf-8?B?QmlsNUxDK0I4REVrN25VYmduL3dUZnR0YlB2OFJUTE9yR3NGWnJUUVU1d3R3?=
 =?utf-8?B?SnBhOUhVYk0waUtnbHZNQkxvL1I4dE9mMlNIR1FUb1VxZVFBUXEyRHdWYks5?=
 =?utf-8?Q?RA1QrDnDJ5D17MrbUZSmstE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef9b8bf-a4b8-4a8d-4622-08d9be936770
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 23:50:55.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PpL6zlflGCHrKLOSGJ+OPDPUwSNci6W01WkJ+7oShZj2eEkn4xUyMc3zbtoHPfBV64J1QTYE5rQTxGLdKDO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130139
X-Proofpoint-ORIG-GUID: Hdmwtsdr5vSI5Qicr3_trTIBVBevNhyG
X-Proofpoint-GUID: Hdmwtsdr5vSI5Qicr3_trTIBVBevNhyG
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



On 12/13/2021 6:42 AM, Eli Cohen wrote:
> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
> need to feel this value according to the device capabilities.
>
> This value is reported back in a netlink message when showing a device.
>
> Example:
>
> $ vdpa dev show
> vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
> 	max_vqp 3 max_vq_size 256 max_supported_vqs 256
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 2 ++
>   include/linux/vdpa.h      | 1 +
>   include/uapi/linux/vdpa.h | 1 +
>   3 files changed, 4 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 130a8d4aeaed..b9dd693146be 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -695,6 +695,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>   		goto msg_err;
>   	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>   		goto msg_err;
> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_DEV_VQS, vdev->mdev->max_supported_vqs))
> +		goto msg_err;
>   
>   	genlmsg_end(msg, hdr);
>   	return 0;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 9245dfbf1b08..72ea8ad7ba21 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -444,6 +444,7 @@ struct vdpa_mgmt_dev {
>   	const struct vdpa_mgmtdev_ops *ops;
>   	const struct virtio_device_id *id_table;
>   	u64 config_attr_mask;
> +	u16 max_supported_vqs;
>   	struct list_head list;
>   };
>   
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 23b854e3e5e2..1b758d77e228 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -42,6 +42,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>   	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
>   	VDPA_ATTR_DEV_FLAGS,			/* u64 */
> +	VDPA_ATTR_DEV_MAX_DEV_VQS,		/* u16 */

Adding new attr here would break existing userspace that is compiled 
with the older value. Need to append to the end.

-Siwei
>   
>   	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
>   	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
