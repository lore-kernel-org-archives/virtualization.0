Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7141CC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 00:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A6D8606F9;
	Thu,  9 Dec 2021 00:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kq8vy5GahD2I; Thu,  9 Dec 2021 00:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A62F46068F;
	Thu,  9 Dec 2021 00:12:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80C3AC002F;
	Thu,  9 Dec 2021 00:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6424C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B70DD825D3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="0+yZnvlr";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="uLeRpwzT"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sIZT23EeWNOf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2101825B1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:12:44 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MiG58023159; 
 Thu, 9 Dec 2021 00:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cVgUuo0fqaWLA+ubORX+CJra9j56F+y70F4jTkEHSIM=;
 b=0+yZnvlrkR6ciCXVYTeEXk7lA/7O4HextaEfSSNHsp3H+qggLu0lgqfmwKiKirqTg2Bc
 5Bepg6vBQIKQB3pLiFsnHbAHjVC034rvYSj0tmqYcB3M55u3CZPEAE+LxguUc1YCbdjr
 pw+T69YJNSVYhSRxaG5TLdtIdhkJnfXRqulyTNVctumTzfCh60RP5ovcI7oYwxK22TIB
 fpDN6hUZdeHReWrcTaxxggiybzGYpi+qKR8d/Zu0P1caTTYO2h6UR+Kzhcg0mszy7J3e
 lFpwsQvzLV8OQX4WAzRvu/vEnh43cHOgf38OYAy7uFSinyDXslQz3lMHJ27M4JVYvkZC xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctup51sgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 00:12:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B90AAt1045370;
 Thu, 9 Dec 2021 00:12:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
 by aserp3020.oracle.com with ESMTP id 3cr0573h5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Dec 2021 00:12:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbVTOXHBvSREzZPc0bM5EEc5jxDQP4z+ox3MpfP2xld11kA9881iIjE4ofP7GEOvhnRF+tgCTW7clGHC2AWvWZRvxbz9ihBcxCd5MbB6s7PBQ2v/3BAyvzt4Pt16FOjlX/0M1xPSXhCVowwMzxGF3zguZEsX9AP5BQVMJ7Ep9dlbB/AXHB9i/4ii8IDlycMnFGqs9TMLlm/0dlOonmfFvhJZdyq0XCrzxyFzoXy56QcPho84+EEDx8ew5e8iKPqQmF01qSc6aD0LwSN9dcI5yZ3og+Y0G1Bny9E35+zNyOiZ9KHgaSaXGf0+C3iXZPr7acBql5e9ZPyaBa87rYOX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVgUuo0fqaWLA+ubORX+CJra9j56F+y70F4jTkEHSIM=;
 b=aSnhX7sMVY1/X+nLOCOl5kDRmvF9EVT/nddSoZpNp8n4oCtBla6CzLTWa0XjTHtF3t32hOeiRyHxpzdyVrbeZeJNW87m5R4h0PvqRKuD5aJYEj5ixm6bESimlRRXq7DngQbBPNp/vDWDyifFDq38VG4xRVU32VmWRscfpNIsAfR9tuxZeGwQFlelD16Gyja/6lssT2emtdRJi2QgZIkX+CsqDHFKoVi8KeTfW6wqKBPl3icAnT3s4VvhYVZZuU3y0heKehVkCAwElZF7Pz3ar718WNtONGArrYHL+NnaFzAygmge204TL8EnGj2fo2rSBAgulxsYm5njrteqBFFq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVgUuo0fqaWLA+ubORX+CJra9j56F+y70F4jTkEHSIM=;
 b=uLeRpwzTiX+OLyyT1qQi3uVCY8bzOxiw3VLBouDIhskTX9LV/ihACLugG1tEAce5DL9t8lNOjMPKkI8NgTXHJGS+SSkW753YPPqoHvgDRGsCSnPbSKcFUmMVsNedQ6a7yHNsbpJVFvKVZ+scY0LuILyZTjL0IdmeTJDglgLuc0g=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5786.namprd10.prod.outlook.com (2603:10b6:a03:3d9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 00:12:40 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 00:12:40 +0000
Message-ID: <1ab6faaf-08fd-2a3e-8214-12e2049b9607@oracle.com>
Date: Wed, 8 Dec 2021 16:12:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 2/7] vdpa/mlx5: Distribute RX virtqueues in RQT object
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-3-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211208201430.73720-3-elic@nvidia.com>
X-ClientProxiedBy: BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40)
 To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.159.125] (138.3.200.61) by
 BYAPR01CA0063.prod.exchangelabs.com (2603:10b6:a03:94::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 00:12:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d71e87d-dfd7-43c8-8c1d-08d9baa89d32
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5786:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5786FB1F798B446477AAFF4DB1709@SJ0PR10MB5786.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSeiqRQZJsNcWFjgG3kfpzAR9xVsXDPI9gqMUWILSVwZZQLc/qXVMBzA2CXXtZ9cqSEQagxouMsuJr1Q6Yas/CQa3lxraISvGhPwkj1q4bUiEqBkUZsRZzmrSJaBGO8iUBBcTLBLA6WnVbMcSjkBzYPyQ5eSzh22cMBr4GrgUGd/VQPopJI7PaJw8nPfGe7SYHo4ab6RRpCowkjPYqXRBNI7wS+T4vKUBT/Nvbljk8/02EymMOMHMkqjmXSn1peNWhKVmxzCYCwGhqDP0ya3TU612nYb73aGB89JIYEsvA0mAuNvaShfJxSHoMF6JLtSKbNyoHCxe+C7lnzONf47o1nb/3lR7C/W0X9+x6Gu0SLU9g7dzbUmedeUxEkqgDfMx1nSXSOoeYSXWvGw/JOAFn48VGrEo8xPFh9qVUEKfi0Hb08jvG5PONedM0Yze9WQPxXnksR06WAj+ZtLDqxr11WXFwvK4SUStnQo2A/Ml6FKot/CkrKk+/BWCA9aMZMTYfBQQbmyWg++Ylmd/xl48gUbalHD2JtkN25ljOVGQrDnLK0nnbHz0KNwyObLUx6mMDAEXRzLMQBwjDy2/Aru5n06iEu5uiLC8ZTAb8x1b4Q1DibGycI3FBBjp/tR6qdu9YFzmBu1vkxwMnayKv+LV/F7jSOLXgUxyo208aQJzrtkWbARbExgiFdbv+7llzIQni5bpZaKCsLbYnGRsl+Pmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8936002)(186003)(6486002)(5660300002)(66476007)(6666004)(316002)(508600001)(36916002)(16576012)(86362001)(2906002)(26005)(66556008)(53546011)(38100700002)(4326008)(66946007)(31686004)(956004)(36756003)(83380400001)(2616005)(8676002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhGWlprWE82eWs1cFVDVDRrN1BCS0dDNE4ybkxjcXFzalk3SDZ6dDc3TEZO?=
 =?utf-8?B?Q3E4ZkJ1MzYxZWlZdzQ5YThURzEvQzRLT0tmWkJvRXJEMWIzckxoa1MrVVJw?=
 =?utf-8?B?NjZid2k0czYrei9Sd1YyYzNSOXo3UWRoMXJMd21tR3V3VlJYRkZ4TGtaS0cy?=
 =?utf-8?B?Mld3RlN4ZXcxWHJvTUliRVdPRlc1TFk3alRaRUJUTDJ0ckczV1ZLRk1XQlR2?=
 =?utf-8?B?Umh3bDAvVEloWmtNNGs3ZjBhRWk2NkpTTk1FUkorZ0hSZ2J0c1J4cDMrcm1z?=
 =?utf-8?B?MkZCNkI3T3A2ZFJLSitYWWN1MDF0UHZBSTFjakZ1OTZlQ1lMY2U2bDRqN2dV?=
 =?utf-8?B?UTNkWUdLdEpvVnM1Z1NDVGlzcWdjRjhCY1VyclVVc203ZWJnZGVMMkZFQ1Vq?=
 =?utf-8?B?Yk1xL241S0dieVFuclQxaTFiTE81YldvVFZJNXJGSG42ZXNoWHM2Nlk1Vm5u?=
 =?utf-8?B?NnBMYmVWQnJ2Z0s0RUNDU3d6TE5oNmpHZUxzcnY5ZGh0ZFRiUjltNTNlZ1hM?=
 =?utf-8?B?dWlnWEY3N25uSUdjU0I2NXRDZkRRLzEyeUkzYi9FWXpzdjdtcUwreVk2V2Vz?=
 =?utf-8?B?czN5bkx2RnNVUy9nbW5haVZLQVU2ZDQyOGpndWZQWFF0RmJEL0NKQjV6U2ZN?=
 =?utf-8?B?eGlxQ1IxVjJ3WWNuNGxMaUdYcFhEQk5FM2xLd2pLTVlaMm1WRm5MU2pqVUto?=
 =?utf-8?B?Y2NhSXpUYlN2NHM3NVJaRFRNeG5NaXdhak12TnZxNFdRM1RSYjMwQXlYQ1ln?=
 =?utf-8?B?K0RXVlMrZlhpY1JKa25pUkFELzF4cFZzNlJuazB5bkdhQU1HNjBIaERJRUFj?=
 =?utf-8?B?QmdrcUd0bDd4cEY5QUZ5M0dHeWhLbnVjQ1BsWklxZkE4TC92b3Y4L2hhNDBV?=
 =?utf-8?B?L0RjNUFVT094QUlPOHVqdVgzLzJXNmtMMVpMWHVMaTN1aDU1YjFLdVVnU2dW?=
 =?utf-8?B?TkhOeHB2dWVWRml2R2tkWHpWemQycWt4YjNUdGNuNUQ1YmRTZGdBT3BVcElz?=
 =?utf-8?B?REEzMnNGeTNmVEhNblJYdHlVeEpOZVJLaElmbmdqVm91WkF5a2pLeDZzRk4v?=
 =?utf-8?B?cUdNZTd0eS9QeWppQUJWdzhwRmt0Y3JibHNPd2tLeVZvdGZ1RWZKMU9lMTRm?=
 =?utf-8?B?a00rWmtNRk5Yamg1bzBtZExMbEpTUTJDRVl0bEVtS3VGSzRjd3REd204VUtV?=
 =?utf-8?B?czhpaXVPVldOSjh2RVNacjVmZm9rTllOV1hwUVJCeHo5M2R6NDNLZ2hpZG0r?=
 =?utf-8?B?TWM4MDNySHU0cS9OVG1NZ2QxcWNPOU1NMUFJUVN0QTBsaVAxMnpVQVFxellD?=
 =?utf-8?B?NW5waHhtZUh3N1RmL1hvcDdaRHljaGliNUI0RU9YNGlnWXRGTVJqYW5ScCsv?=
 =?utf-8?B?a3l4TjFnNmRiU0FuaVRobFJWMWpwd2dNWFI0NkZ1anhHR0U3bitPSXAyVWZw?=
 =?utf-8?B?NkMzMzNqQnBHa0h3UWM2Zzl3VnRzWTloOVNIcVlMRXRFNHl5OUNRUlQ3ZCtk?=
 =?utf-8?B?dk5tUVNyZ3ExaW4xbnNPYmpEYVJTSjYzR0ZnTmo1aW1rL0lKS2xNTEU3bzUr?=
 =?utf-8?B?MkgxSzZNdlJpSStVR29XZ1p5bDVBeDAyN255ZGhBZkNBWHhneG9UbU5ZQnkx?=
 =?utf-8?B?Q3BBQ1paMFBwLzdNSWU0NVU1Nk04STlaNjBqVHhsTEpBMVhNZndCVHdraWZL?=
 =?utf-8?B?V2xQc3dRVnI2aStVYXB0QXdwRW9vd3d3dnI0YlU0U01vYnBQYXB5L0xQbXNk?=
 =?utf-8?B?V0lMU09xcFdvb3JpcjZTRmE2NlQ0OXh1TTgzMk5NeTd4NHlMZFpnVGpjc2VB?=
 =?utf-8?B?RmpiNFN0WXlxWmpEYW9GSE9hL0xVRlpkQ0VsZm50WXVJSmVqVjEwNWthSFIv?=
 =?utf-8?B?OFRHTW1QZjhqTnhibHVKcVRJNlJpUWRKdUc0d1R2UkpORUpsOWFRTkNmS0Rx?=
 =?utf-8?B?QWdVbHBRRHpQZzYvMko4MXdyOSs0Q2VkOXlZMHR3TlZqaTRXQUxqOHZ1Q1ow?=
 =?utf-8?B?SG9mRmRFMmF3azhoUGE3MTRYODYybTk5YnAyR1dHaW02Ri9TYk1ZVXVWeFhJ?=
 =?utf-8?B?WVdxT3VIdzkxTUdjKzFFWnNGREREVXFJL0pJWk5LREFLRUQwanpBbzFwV1Fi?=
 =?utf-8?B?TDY1cWJxNW1QbUNxWGFpQitkNElseFJ2YXltZmxOSGRpQnhtQWM4RlVVbldE?=
 =?utf-8?Q?L1rWzfnz30Bb3qQhQQ8cYrE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d71e87d-dfd7-43c8-8c1d-08d9baa89d32
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 00:12:40.5493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crjCBMWrTP+9wsQtEV63deFkz9g4gVhz6OiHknj2zukODK4sqfl2W239AYwwzuNhHewnGpBrV2I8ftA++r5rGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5786
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080132
X-Proofpoint-GUID: uEpeng98eFyeGUJ-eVtoO3Xtv7Unnnxx
X-Proofpoint-ORIG-GUID: uEpeng98eFyeGUJ-eVtoO3Xtv7Unnnxx
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



On 12/8/2021 12:14 PM, Eli Cohen wrote:
> Distribute the available rx virtqueues amongst the available RQT
> entries.
>
> RQTs require to have a power of two entries. When creating or modifying
> the RQT, use the lowest number of power of two entries that is not less
> than the number of rx virtqueues. Distribute them in the available
> entries such that some virtqueus may be referenced twice.
>
> This allows to configure any number of virtqueue pairs when multiqueue
> is used.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++-----------------------
>   1 file changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ce2e13135dd8..e1a8a790f213 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1261,17 +1261,10 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>   	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; j < max_rqt; j++) {
> -		if (!ndev->vqs[j].initialized)
> -			continue;
Why the !initialized check is dropped from the new code?

> -
> -		if (!vq_is_tx(ndev->vqs[j].index)) {
> -			list[i] = cpu_to_be32(ndev->vqs[j].virtq_id);
> -			i++;
> -		}
> -	}
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, i);
> +	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->mvdev.max_vqs].virtq_id);
>   
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>   	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>   	kfree(in);
>   	if (err)
> @@ -1292,7 +1285,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>   	int i, j;
>   	int err;
>   
> -	max_rqt = min_t(int, ndev->cur_num_vqs / 2,
> +	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
>   			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>   	if (max_rqt < 1)
>   		return -EOPNOTSUPP;
> @@ -1308,16 +1301,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>   	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>   
>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; j < num; j++) {
> -		if (!ndev->vqs[j].initialized)
> -			continue;
Ditto.

-Siwei

> +	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> +		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>   
> -		if (!vq_is_tx(ndev->vqs[j].index)) {
> -			list[i] = cpu_to_be32(ndev->vqs[j].virtq_id);
> -			i++;
> -		}
> -	}
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, i);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>   	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>   	kfree(in);
>   	if (err)
> @@ -1581,9 +1568,6 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   			break;
>   		}
>   
> -		if (newqps & (newqps - 1))
> -			break;
> -
>   		if (!change_num_qps(mvdev, newqps))
>   			status = VIRTIO_NET_OK;
>   

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
