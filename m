Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3A4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 18:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8674961C17;
	Wed, 16 Feb 2022 18:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_kxmZaeu-pk; Wed, 16 Feb 2022 18:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BED7A61C1E;
	Wed, 16 Feb 2022 18:49:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC87C002D;
	Wed, 16 Feb 2022 18:49:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C74A2C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4AA6416E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="rLLDrvvI";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="VlPT3fMp"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Xtr8_QoRdIP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:49:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C1C5416E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 18:49:37 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GHiL8B005266; 
 Wed, 16 Feb 2022 18:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zu48ArganP17pupbkUWYM0gGJUdONWJgv7nD4nDbpgk=;
 b=rLLDrvvIofjmHFWToJiAspUbbTB+K/2+ImVVHFRV2TBkufX59diPV3yFPjwFSzeH9M89
 TM3DMN+Fxw7k2r/6hk2tTOgz4ThIpOoBTZuBTaEMQIALwqtiaIA7H7qxMc8yEZv0Nd/E
 3gzRtP/KHSK2tZ8kcIrBOTUrc7ImLUcdzg420DQWh3DsstbOn4CjccmLfPq45NZcnfNk
 ONwcm20HQo+eO4ehlUds9Rj58LiaRQWd7uPAXKw0AKMnHbCA0tjtcbdkgfNHZ1V9Fq7s
 MYLFqf8vGA80/7pG6m21UDQyR+gkLi9gye5mMGc42ND+RCdXX1bBqmL3HSrheFSV3TQe dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncau4m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Feb 2022 18:49:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GIVHkV149211;
 Wed, 16 Feb 2022 18:49:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by userp3030.oracle.com with ESMTP id 3e8nkycktd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Feb 2022 18:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBNSPT8lpgWnohXjIzMWpgAo3Qbl4nDhWmuJhgDbzpGPKBmrJNdIvNHKOuY9uOoZGG4JBkBiVEKuUDtp4nZcFy7v0F4DIjlNxSEBKSZ0g/oTcpwGukFvCKMi/7c4eybLzxK7u+W7yB3xeiqj26tPyq2XCm9xb1DS5PPNPyXMWSaWluvv8c8BRJAjSXGBgJHhTLTXSURVVXE/JupUZFt9Ci6lygRbwZsS7RHMzQg/ABSwjApACID+/o+wbZP5PwTVNn54fZMvOyACXkYRkVV0J8Beo1f6yZYSuewkfSNEj7K7zk968ix0i6BX1pFYWHGgUiLZN3Q9mJLB0gISbrMJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu48ArganP17pupbkUWYM0gGJUdONWJgv7nD4nDbpgk=;
 b=eU7wU5Msq9b2iD1/gYVZi0/xZRdMcCbKZljxCEqn+kNiTOENVHDY4hFje2my7/h3ESVRHTxdRwnxecR/C3W5C02bUr9bsR40EKTok/4X6rl43mPbiKD+XsBvqHpGqwtG6byfLI0t1uyEaTA/nbThjB5h6zMLpMzztm359kN78IRIUJTegav0TDg/otZqX0j1kOPyVRZZv6BUvV0mjSB2RFzMvxEGgs5WAjpX3m9bIACk2ZhCXajnVTOl5lBfg3CT9KgoN1R5reiK1tU6qGW5I/fcllB7d/R550Cbltbg2e1CUg9M7La6yznqnHrf9eGw2WlmuaCHStMgSnVqIJZZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu48ArganP17pupbkUWYM0gGJUdONWJgv7nD4nDbpgk=;
 b=VlPT3fMpayEibnQnRnpbuBYtFCIg54R+gG1fOrMkiaH7LqhPzG4TSAmxcFC31zwmo5XOPkwaNY99AdNDOg/RbTbE8HQvzLgwRTZzdmJXWnGkoTH/5eMwuWEABRql+L952kLkpnG50aMU6+UbXu0FM3c2/9P+W3gONvLzOCYWfmQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4033.namprd10.prod.outlook.com (2603:10b6:a03:1fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 18:49:30 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::54c5:b7e1:92a:60dd]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::54c5:b7e1:92a:60dd%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 18:49:30 +0000
Message-ID: <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
Date: Wed, 16 Feb 2022 10:49:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 amorenoz@redhat.com, lvivier@redhat.com, sgarzare@redhat.com,
 parav@nvidia.com
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220216080022.56707-2-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:806:126::12) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa91e89-8b56-4a96-c262-08d9f17d10de
X-MS-TrafficTypeDiagnostic: BY5PR10MB4033:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4033C56FC63AECA10C908E03B1359@BY5PR10MB4033.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tEcnAXuGA6iejEbM8Qwyz92OrqzRVRU5UbPojxUeWyYBNlHM4Jj3rd6nKjnV0sY77ajXVQ44q20LKaYpcAM9VXsF51Yu34TMEVg+m34wKtcs2QF/L4+zmw/eG4unKgsabNiWiQrzpc3m/MpDvyY4FosD30kl75NWhfUvIRKa8E3/XIh6BZldKk8aPSSpZKJPxAM28obSSEJ2+dJBLy8OSXpWioht/9fb2QUvF4SbB1o4Ol2pA6S8ibCsasSGcLBX57deuGwYFMrMRfp7nnYhuEbImVI/zc3ncFiwBDMbxzyIHgPrkt4Nm1cT7+MkyRVywc/gmX4Y++WNtHp9c9wZ08fiXhwimocfx4knmzUdLXFStxoHgRHu+r1SeVAn+dGeeLhTen4SbfWlwc8v2yaUVCZVtmLltLlP6uVbUY14az+9Oby/krTxAJYOJPrD3fdmLuNfv70uZt3+7drZRg4ZKQBazPcrpJqRjcGkVk1JGbeBBrlyxIE60+nwn9Ch0KBXrhdtRTIdt4fRwMHjMG497op1rKn5QGi2+fYD+o12/WsnX98/y7nDTM8/kxmUcS1IPnPHCLdrItnf1/oW8zc/oRXxD3bcAjfswJTm0EhsdSWh9Q9plN/HjRmi0hHITbeGmHjigIgKloPIvXEdBoANaREl8JITjDMrNh/3JrJRFJ1Hiisfyr4zzONFBjeXI2yRfV641gT9WsfXmSYVwE9lsV74Yp54XZKVBEva98BarRI8VZJHQKOKysD5A7Tvv11
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(316002)(36756003)(53546011)(6666004)(6486002)(31686004)(36916002)(6506007)(86362001)(6512007)(2906002)(508600001)(38100700002)(8936002)(31696002)(26005)(5660300002)(186003)(2616005)(66946007)(83380400001)(66476007)(8676002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di92aGNCb3dFdzZveTBlQUZFWVBFckw2UUQxL2NuTlVYa0RYV3Z6eFNyaGlM?=
 =?utf-8?B?a2tIREZKUmszRlVhelFFUVY5RlB3cEh0TjVCL3MxS0dsTDFzR2dTT3E5dHdC?=
 =?utf-8?B?cDluYmN2UU1uNlpubEIvbTY1R1pOWXJLd2hIVVFoTUhObHlrZzc2bFNQSXBw?=
 =?utf-8?B?Tk9QdkI0MllDUkE0UjFkNmJBZWttQlpxWlFJV3NJaS9GdlZjcENScWVSTjcr?=
 =?utf-8?B?K2NuOXVjOE4xQmpqdkN6OTlwaGNvRDZUU1hQeWRRR3d3bmpvY0dMTWRRaWNY?=
 =?utf-8?B?MUdURXVFMGZoZTRQZmZSSXMxSWRrWlRCVkwwTnpucERqKzNGZzVFdFpTK3dD?=
 =?utf-8?B?MUppdWJjdmR3T1NKNS9nNU1UYm5xWVRobUY5eloweU9GOGkrWkVnZGVQZ0c4?=
 =?utf-8?B?RUFtWlRkUjFtWUZqM0hIWDRVVE9CSEJyTncreUc0TmZiRE5oRG1lU3k0eUsy?=
 =?utf-8?B?MDZLZXFGM0hZU21qR0x4eGFnMDN5YURPbjJwdnRnMkZONU9PSTgrTG9sb3dQ?=
 =?utf-8?B?cnk3eWZTVWlCWXFDaUlUc2gvclkvT2x1Zm9nUTR6SGc3S1Z1NnlvK05DRFph?=
 =?utf-8?B?QVcreDhqVmtqWEUwNXpaelFub255ODVZUW1MMHhVRTZieEJ4RDlvSVhxRXdH?=
 =?utf-8?B?bXBXYU0xU1RNeVVJWGw1T3FBeU1RSmE2YkQ5akVWWHZMNHN5dWgrMGdXQldr?=
 =?utf-8?B?YXdCK3NUSDkzWERFZzkveStWeXBTSFNQczFzcEdIajhpTmF0T1JMb2lTRW1Z?=
 =?utf-8?B?T0RLbDEzaDNPUUVBTmRGbjRuSDdLZkRaL2pQNXgrUWVwZ0xjNVY5M2Y2ZUNx?=
 =?utf-8?B?Ty95MzVPZmM5UlRXSzkxZUgyT3FFaXpkZ3UzQmdFTTUrR0tPV0dqbHFoeDBu?=
 =?utf-8?B?clgzUTlBdklzdDl2T1BTV3BoY3gzWkxJOGNzblBnSDY2NmMzMXlmUjFTTk9h?=
 =?utf-8?B?eHZjcEZrYVdOUnptcWl6TU16T0RFWnYvcFo4ZVAyZ1phQlY3MzdMUmd5VDZr?=
 =?utf-8?B?MzIwWGtnRDFjMTZ6RVdjeHNWSWVFRkoxMUNLRTkxNThvRzlhVE1rcXlQTVpr?=
 =?utf-8?B?bVgrR0NNbW0zcEQ3QUZOZytXK3ZlRjVuR04vdTMvZnM1M3ZuOFd2Q2FQMWNU?=
 =?utf-8?B?S2hZYmNBai9LbEdlWmY0WTI5K3RXYXlXMzZjVW00NkVYaVg2NFkwaWdVNUo4?=
 =?utf-8?B?RHZLTTh5WFdKSmtRM3NQUStRRllyLzg0Nm9pTk5Wb1JtRUg2dkhZdEpYN1BX?=
 =?utf-8?B?cm1XU2NoUzdmcTd0QUZ6cEI0MThsU1YxZlIzTDhnYjgzU0dMWmk4NXNwbW80?=
 =?utf-8?B?S2pPelNQRzJpSmNGYk1JYTBtZGdnUE1PVEtPakE0ZEVYYyt4REZZYU92SWZz?=
 =?utf-8?B?aFZMNFVuTFMvYVdqY2N4N1dFVjJiN2YrRFVIVjM3NW9mOGplaEtERlRhbTQv?=
 =?utf-8?B?NEk2ZnYvNzY5UmdrMHBNYjNFdjFhVmllcnVhdWVDQ0E4T0cwcjI4cmMrTWs1?=
 =?utf-8?B?N1l6V3VlYUJBVDd6dWRrSnI0dmpVNDdmSS9vek5qZUZwNmI1OUlqeXJva0ZE?=
 =?utf-8?B?cHByOXorVTJhaXZEbUF6ZXF0U3Z6YVJOeFpxYk5laWxqYjFuWDF4Qkhzb0lV?=
 =?utf-8?B?TWNqVkFpSkdnVnorSHhSSWovUG5VNGpoV2xSZkFXZ1ZQSzVkMEx1My9jQ2da?=
 =?utf-8?B?bEtON3A4ZkJQK09ydldhSEt0SmNONG0ycDBFOHI2aXp0VEJxbjBldUNTL0NH?=
 =?utf-8?B?NFdiQ3RWeFFTSlhjaXZFaTAxeVFrZG5ocldGei95SVlNZVlCc0JXbWQ5MzBL?=
 =?utf-8?B?SVdWSkt4cEhoZEcvaitNUExBK1NaZkFYSU53NTNuSytLTk5lUTF4MnZvOG41?=
 =?utf-8?B?OW5qRFRzUmdPS05xMU8ra2dWeHl1RXRpODJncUZnQit6SUdOL3JnamRBR3J0?=
 =?utf-8?B?ZFZHT0p0bjUvekUycnl1eFNNcSszOHBZZmxSb1JsS3UrMTF3c2NpU2dQV0pq?=
 =?utf-8?B?eFpnMVdGQnlERU1XK09VZ0NZNG9SN1NvOGlZYldvMHZhT1llL2NSU0JVelZn?=
 =?utf-8?B?R1ZrVEt5ZlJ5RnJnTW1tbWZtaFNRblA4Tzd5bnJlcmV0OHZ6UDdPNDdGT1VU?=
 =?utf-8?B?SGY2dUY4WlNvUkJUWC9pc0hPYjJIdWtOWEZZM1NzOXBVRVZJNUJ3aVp1K0ZR?=
 =?utf-8?Q?cLh9L277y/uqJajZeBNQlEg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa91e89-8b56-4a96-c262-08d9f17d10de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 18:49:30.8219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5VYWbeIHPIPnFrU8Nt4GMwZufoU6sbwZ5RmEI77F8tFmdL+LxMMviN6xAKvkYi0YGHbIpXXheOsYZrD7hjs5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4033
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260
 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160104
X-Proofpoint-ORIG-GUID: _fKU9y4XIVqU9sFTDzjlf0Uo-thjtMvF
X-Proofpoint-GUID: _fKU9y4XIVqU9sFTDzjlf0Uo-thjtMvF
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



On 2/16/2022 12:00 AM, Eli Cohen wrote:
> Allows to read vendor statistics of a vdpa device. The specific statistics
> data is received by the upstream driver in the form of an (attribute
> name, attribute value) pairs.
>
> An example of statistics for mlx5_vdpa device are:
>
> received_desc - number of descriptors received by the virtqueue
> completed_desc - number of descriptors completed by the virtqueue
>
> A descriptor using indirect buffers is still counted as 1. In addition,
> N chained descriptors are counted correctly N times as one would expect.
>
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
>
> The interface allows for reading all the supported virtqueues, including
> the control virtqueue if it exists.
>
> Below are some examples taken from mlx5_vdpa which are introduced in the
> following patch:
>
> 1. Read statistics for the virtqueue at index 1
>
> $ vdpa dev vstats show vdpa-a qidx 1
> vdpa-a:
> queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836
>
> 2. Read statistics for the virtqueue at index 32
> $ vdpa dev vstats show vdpa-a qidx 32
> vdpa-a:
> queue_type control_vq queue_index 32 received_desc 62 completed_desc 62
>
> 3. Read statisitics for the virtqueue at index 0 with json output
> $ vdpa -j dev vstats show vdpa-a qidx 0
> {"vstats":{"vdpa-a":{
> "queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
>   "name":"completed_desc","value":417548}}}
>
> 4. Read statistics for the virtqueue at index 0 with preety json output
> $ vdpa -jp dev vstats show vdpa-a qidx 0
> {
>      "vstats": {
>          "vdpa-a": {
>
>              "queue_type": "rx",
I wonder where this info can be inferred? I don't see relevant change in 
the patch series that helps gather the VDPA_ATTR_DEV_QUEUE_TYPE? Is this 
an arbitrary string defined by the vendor as well? If so, how does the 
user expect to consume it?

>              "queue_index": 0,
>              "name": "received_desc",
>              "value": 417776,
>              "name": "completed_desc",
>              "value": 417548
Not for this kernel patch, but IMHO it's the best to put the name & 
value pairs in an array instead of flat entries in json's 
hash/dictionary. The hash entries can be re-ordered deliberately by 
external json parsing tool, ending up with inconsistent stat values.

Thanks,
-Siwei
>          }
>      }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vdpa.h      |   5 ++
>   include/uapi/linux/vdpa.h |   7 +++
>   3 files changed, 141 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 9846c9de4bfa..d0ff671baf88 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>   	return err;
>   }
>   
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> +			       struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> +		return -EMSGSIZE;
> +
> +	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> +			     struct genl_info *info, u32 index)
> +{
> +	int err;
> +
> +	if (!vdev->config->get_vendor_vq_stats)
> +		return -EOPNOTSUPP;
> +
> +	err = vdpa_fill_stats_rec(vdev, msg, info, index);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
> +				      struct sk_buff *msg,
> +				      struct genl_info *info, u32 index)
> +{
> +	u32 device_id;
> +	void *hdr;
> +	int err;
> +	u32 portid = info->snd_portid;
> +	u32 seq = info->snd_seq;
> +	u32 flags = 0;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +			  VDPA_CMD_DEV_VSTATS_GET);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	device_id = vdev->config->get_device_id(vdev);
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +		err = -EMSGSIZE;
> +		goto undo_msg;
> +	}
> +
> +	err = vendor_stats_fill(vdev, msg, info, index);
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return err;
> +
> +undo_msg:
> +	genlmsg_cancel(msg, hdr);
> +	return err;
> +}
> +
>   static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>   {
>   	struct vdpa_device *vdev;
> @@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>   	return msg->len;
>   }
>   
> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> +					  struct genl_info *info)
> +{
> +	struct vdpa_device *vdev;
> +	struct sk_buff *msg;
> +	const char *devname;
> +	struct device *dev;
> +	u32 index;
> +	int err;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +		return -EINVAL;
> +
> +	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> +	mutex_lock(&vdpa_dev_mutex);
> +	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
> +	if (!err)
> +		err = genlmsg_reply(msg, info);
> +
> +	put_device(dev);
> +	mutex_unlock(&vdpa_dev_mutex);
> +
> +	if (err)
> +		nlmsg_free(msg);
> +
> +	return err;
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	mutex_unlock(&vdpa_dev_mutex);
> +	return err;
> +}
> +
>   static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>   	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>   	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>   	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>   	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>   	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
>   };
>   
>   static const struct genl_ops vdpa_nl_ops[] = {
> @@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>   		.doit = vdpa_nl_cmd_dev_config_get_doit,
>   		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>   	},
> +	{
> +		.cmd = VDPA_CMD_DEV_VSTATS_GET,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = vdpa_nl_cmd_dev_stats_get_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>   };
>   
>   static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2de442ececae..274203845cfc 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
>   			    const struct vdpa_vq_state *state);
>   	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>   			    struct vdpa_vq_state *state);
> +	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
> +				   struct sk_buff *msg,
> +				   struct netlink_ext_ack *extack);
>   	struct vdpa_notification_area
>   	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>   	/* vq irq is not expected to be changed once DRIVER_OK is set */
> @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
>   int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>   void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>   
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> +
>   #endif /* _LINUX_VDPA_H */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 1061d8d2d09d..c5f229a41dc2 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,6 +18,7 @@ enum vdpa_command {
>   	VDPA_CMD_DEV_DEL,
>   	VDPA_CMD_DEV_GET,		/* can dump */
>   	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
> +	VDPA_CMD_DEV_VSTATS_GET,
>   };
>   
>   enum vdpa_attr {
> @@ -46,6 +47,12 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +
> +	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> +	VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> +	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> +
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
