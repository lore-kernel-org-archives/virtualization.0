Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DC5C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 01:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B7C7409E3;
	Tue, 11 Jan 2022 01:30:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ts_jBhrEQlbY; Tue, 11 Jan 2022 01:30:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C55AB401DB;
	Tue, 11 Jan 2022 01:30:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A634EC002F;
	Tue, 11 Jan 2022 01:30:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C810C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1CAC4061F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Ygsremdd";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="FQ2us0Ak"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFJ8qAUV50kC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4990A404F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 01:30:35 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B05RY9030654; 
 Tue, 11 Jan 2022 01:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pJbuB1DW8DQ9XVv+LecVveP3P4/RRRM7koNgHlXKuhw=;
 b=YgsremddumX7fe+y8zYLDi+MBgbiNVLfpS/ycKItPpvRIzLNYxFZxQx4XKXn96JEuyMP
 jndyBJbHxWlFuVg/FI6gIYn/qp4Gen75QwH890NuqlfV24wSHSk0oB+NWuu8uc9vU8vF
 RUgPRFSTY5CdtkmMeb5YXd1NT4CV6mviAp1G4KbMmfFA6cEGroSseoAtH7zDgemibo+A
 RxftG4XriDPcQELHqa3V5Q1CO4UuZApwCMwlMj5ZKqEOfQWCI/IBdmwsXgPdSyoHns9L
 OCUT2XhVGIDcjrPxsnmXQbYkC7wCAzUuhDS9ffnqFMGEU7NFhdNFl46fPwXqrhh+eEfp Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgn749qq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:30:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B1Fadr106196;
 Tue, 11 Jan 2022 01:30:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
 by userp3020.oracle.com with ESMTP id 3df42kvfbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 01:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMTvEkUwk+LtHyZ4gKtm43LVpGHaBycqHszYBxC0l2Xi0GJksu1HfEMO5fYT1Svgx2ukSnw1enofjbt5aLzZbHr90rP35ExU+nkQwYusHUKswscb1NhGpOpG5TKehvbF2ULbMnqD1yhfyL3Jf5Ygd7loPUyz2EuzT6wIsMkG00QbmAemBoMJNkiGBCmh10NeVhPE6x6IvDs4QmlaR6m1lheliO89glrnceuAyu09cZ411doHOTRwd8bo96isiZXu5USWmQpHtd8GkEizNq4zXKOo4DiisSUOqUjEYhiAjQ1hA7qAN1JNJE+/EGK+b7LL4CLv0CcQUNqeRfXQuy9KSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJbuB1DW8DQ9XVv+LecVveP3P4/RRRM7koNgHlXKuhw=;
 b=QKYchruULn5CGgIrSuWvbj5XSN6Efen0Zt5k71Omiysj/VnpTf3zL91xOrr7WDW9OzL8LC333oz7umNJB7+rQHU+SJ7pXMVe839UtQxv1J+taBmuXehFM5kzyHdPzxIi2mo8yXejHSH6BkJ+TGp2N+6oDNDCXGfyM5DBr9HQziE1edg5GSP7LyIl4VX0jwOKwgbR4avNX/GE39JOBRPGTq1PmfjyQ5FmMQTs4mZbXZcFm2nOmyglTP2S6S4xy/nz0fn98Gs4f5YiDO3AEs9ySvDcOLpdt1aJMs6MH5V27hB7JNMVIb+dklbGR98T9u0lUzRwQ9z05ZreW7B0KXCsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJbuB1DW8DQ9XVv+LecVveP3P4/RRRM7koNgHlXKuhw=;
 b=FQ2us0Ak7KrkPzQ9narJVb9ggc0OAkoSSLufsaf2ISlGSF+iNMwsouE/bKdTdm50si9JQ4KwqG3cy3CShAokKKYFPPgmC0Db9x5QKdK//5ko9JXaxRT67R7uL2mgXL4RH5FcuWncQBNtjsQIl/fQ3JyvqM34OpIKwhZPKvcZoiQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:30:28 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:30:28 +0000
Message-ID: <a4fefb05-958b-743c-87da-652420b98e70@oracle.com>
Date: Mon, 10 Jan 2022 17:30:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
 <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
 <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
X-ClientProxiedBy: SN7PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:806:125::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87ef6b51-ded7-4b4c-5afa-08d9d4a1f32d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5600:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56004E38DE4D192A86833994B1519@SJ0PR10MB5600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lACai9eKzeREWaD1gMLTbArxg6lRDQpM2nPskOLyARvKj9QkIs2se3G3koDaMDBf9iL/knWX86gZOhIvmcCAgQDEh+3OW5PDzizio9MW9VY21XasAEXav2uzN6M/YNz3nWQ2S18dYNk/EpeDql+lbAkCunz6d4wWkqAdk/y486Jif4xjYqnqCgW1AfPn47lZJr/vXIMi/uzWmGzwDafk5xwx5Vqple1XsFj7o6ViY11aYQ4rTUP0o/4LoBZQlT0+JTDovuz0kvYBxcHwxrmV45wZpe6GZaMDK2NItsGzKD6N3dVsgax5Rl4qwh9GZNfsZ5vR79x+9Q4I/qS/mYxw0zyvaYUrRWroSn+rjMFtTWx5X3TizjaFrTVPIXHipjCEWIgqLSw5gm5HkD2kmspXBjAhTNWa4NX1sl56pD9sK39dm1flVBYFNJSSc2C8z1CDMPzH3XN3hzr/SI23P0i5A2o3nyoCjJZKDfamImE4y59vL4nW3lmf/Niz3WUeT/ZPBGYTcF/jAJkuwB+bEn+tYZER2gK/aOYu6WH9Qm5tHULncDZDDZfvaluFzjCwH+vJ3kiBQcU7urtWlz8pvsEvpBSizEkyMYPiex8OVP4UwocuxNtsUZEpSPYziRK/ehEJtLvuDk0rRfb7TMnAd/pc2DwlDN5aUZhKek2c7rOTnZc2PIO6DQb/0fv0SZTlENPyjU9KYvaVVXvnVhFHFZ2xTEtDd552Ub0zcElNvHbQfG/301BRijjR/6bS4COC2goR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(86362001)(8936002)(36756003)(83380400001)(4326008)(6666004)(36916002)(6506007)(6486002)(110136005)(316002)(31686004)(31696002)(66476007)(53546011)(66946007)(186003)(2616005)(508600001)(66556008)(6512007)(2906002)(26005)(5660300002)(38100700002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUF2RHFWU1BBWDVxRDkwYjRnOXYyT3hXdXhkTzd4d2FYSGRrUW1NbFhvc1BL?=
 =?utf-8?B?elhEd01wVUtBNXRJQzBkN0VxZnJRaVo5N1lQTVNITnpLVDRwd0pSTjFGc1di?=
 =?utf-8?B?YlVVVjRDNkpEZHQ4S296YkV3VWp6VzZhbUQ5VkVBaXl1eUlZUU1YYlB1bVR4?=
 =?utf-8?B?Q1hsejZkTWRZVHpSU3grZTRJSEVEWXZ3c3dHT0s2UncxK1ROWTdxOTJsMTEr?=
 =?utf-8?B?V1E4T3lwaUErSXlKamlqcVU5bVl0eWMrZVphSTRMSExuODZ6MWRjaGw4SkJE?=
 =?utf-8?B?Q3FqMGl5RzZlVUZMZ016NS9EN3BsUkJ0UUVvdWxxNDhUK255V3RXUlVKVWdK?=
 =?utf-8?B?Q0tNZWpVVzR3QzFpRzlady9GYVZyL0xOTlpWYlI0blRDSHdnOUJOL1BZYzNx?=
 =?utf-8?B?dTlELzNuaXpWRlBCZmRCZWpORVlPT1ZveEJxSTFJUWZxZ0lVR2RwK2N2Yzgv?=
 =?utf-8?B?UjdxU3QyWnY4T1RBWER3cGRyTjRDa2xXZ05yeFVKSE1GRVF0QUhtdVRSNGlN?=
 =?utf-8?B?amJJbmNzL0hwVTYyU0FrMkNQaW9qK0FtTDF0RWh4aU5tNEpPRTJzSGNtL29T?=
 =?utf-8?B?OGdCN2JQMFdIRlBhWjVCbGcxYmRkanU3d1ZHOWtzOXYxcFRzSkQ0TTBsMFVv?=
 =?utf-8?B?SHR2dnUwTUNsc2IyUGR6WlBBZlBja3JGZjlpMmovdEh0Nko3MUNQa2RDMzNY?=
 =?utf-8?B?aGQwUjdhVkVnaS9NZEZOVDdDTmNSNWRMV21XZ3VXVTNacmFTSkhLUjNKZE5P?=
 =?utf-8?B?TWpWZ1JpNVp0V3gwaXBTanVJWThXRDZaenNjMysrM0JXS0VHMkJlNTM5a0hQ?=
 =?utf-8?B?aEMyL1NxOGRlaG9XRFNDeVlrRW9kV3ArUFhNczRGZ1R1c200dW8rRXhsdUtk?=
 =?utf-8?B?ZzdNVlFHWTI2S1lEckdsUmMvODB4OHF3OUxINm5PbTMrTXpkTE1kOWdRcWhL?=
 =?utf-8?B?RjU1QW9uNVV0eWxRKzZhMXdlVDdTZldkdHVaNmZiY09waW9kUGxISXMrVUpv?=
 =?utf-8?B?cHhFb3UwbnJUM3ljRnF4dVBQc2RpQ0J5RTFoVnJyRm56MExITXFKTlBaQnV4?=
 =?utf-8?B?SzNmWkc3Unp5M1JGWUFTZ2dVaTc1VWFYZ0R6RnZKSWRoTnVsQlhGbWpRUy9L?=
 =?utf-8?B?cGlTTDJ4MjVvaGRlNVRYRkFrSkNnM1k2b0RnL3F2b1V2YmNzenpEVzZ1WXd3?=
 =?utf-8?B?cEZac0hiVE9BWW9kcStRNXMyR0JPOVZjSTBEd2MxTjFFYkxqckJTMXppaXV5?=
 =?utf-8?B?eU9WZjkvR1g5S2IvbmFlWTkrTEJKMkd3UVFvMXkvZVhUbnlLZmJCaHlzZ3Bj?=
 =?utf-8?B?Y3FFV3BBK2VHUEJqNk1NSG8zTjJTZTdrbUhVYmNXNGROVmppd1h1Qm9hbHFQ?=
 =?utf-8?B?RXRURUlyQitMZkZZSnlmNmZJWHpKSE1vbmh3cGhHb0p2ZFM1dUsySjFQVGo1?=
 =?utf-8?B?dDlVN1haaXB0UkhWemZWQXZJM2NUaFdsWlRLYzRQNDhkQVB5cTFYWDNNRFpF?=
 =?utf-8?B?aDI1ZzVmK0gzVUZxamp2VlAzTko4UjBrUG9paGpSV1VKek5GRlhsc3BkY3hh?=
 =?utf-8?B?cEFnRjcwK2IrY1dlU0wxbmhFLy9xQzZKVVU4bTF2UEZoUURWWHBuQ2FLQ2xF?=
 =?utf-8?B?QVBqZ3JwZzQ3ZGc4UHBFWGxaeHJvQ0FSZGJRVVFIbXlSUllJZjlieE16UDZJ?=
 =?utf-8?B?Nk1XNmVVM2xyUU43NDN4czZGZmhIc0ZIdEppSUxyenRnNUtBQU1iNTlMV0JF?=
 =?utf-8?B?R3plaUMxWnFaaUUyUWpNS2Z0ZjQvMFBlR2F4a3Bvc25WOThtcG53ZVB3ampN?=
 =?utf-8?B?TlpHaW5Ld1JCcWpYSVpkbFNqRzRYQTkvb1V3MVBnWWJ2b083LyszTTB3dnlm?=
 =?utf-8?B?MDNJQWNEOFB0eWxhQ3ZZZS84Ry9OOEV0M2lHYmdNN3hLT29lR2h0TDI5T2Y5?=
 =?utf-8?B?aldUbVhhMjFCeUtVUTNFS2gySjJTZDhvMTByVHBKekpETUpoeWhSUjVBLzZU?=
 =?utf-8?B?ZDZsdmE3VzBHajMxSUZHeEFjMG5VK1loaVJSWjBwYzNrclFTa3pRNVpIeDBw?=
 =?utf-8?B?b0tIdUdzbEprTUhRZFZTamEvSGJ5MFR1NmtJNWRrdmxpRHpuaUVoRmk0OU1s?=
 =?utf-8?B?TzRkdVc0cytoRUpYc1BpZmpYcHBENWNaSHVjVFlGQURJYUJRMjNncGpiai9D?=
 =?utf-8?Q?2MnzgbPmBeWMJ8HXmNrn9Io=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ef6b51-ded7-4b4c-5afa-08d9d4a1f32d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:30:28.5701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REYjqXp96MOA3s98DzJaCbgSUwnB7y06wK+JWBVBKKNKTuQ8Ub+gw2W2vS5hzJxMH1r4ig1iuiyitrGCOUdWig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110002
X-Proofpoint-ORIG-GUID: noiJ581XSFM9qF2ayFq76ZB4OvyVMaOM
X-Proofpoint-GUID: noiJ581XSFM9qF2ayFq76ZB4OvyVMaOM
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxLzkvMjAyMiAxMDowNSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIyLzEv
OCDkuIrljYg5OjIzLCBTaS1XZWkgTGl1IOWGmemBkzoKPj4KPj4KPj4gT24gMS82LzIwMjIgOTow
OCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Cj4+PiDlnKggMjAyMi8xLzcg5LiK5Y2IODozMywg
U2ktV2VpIExpdSDlhpnpgZM6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDEvNS8yMDIyIDM6NDYgQU0sIEVs
aSBDb2hlbiB3cm90ZToKPj4+Pj4gQWRkIHdyYXBwZXJzIHRvIGdldC9zZXQgc3RhdHVzIGFuZCBw
cm90ZWN0IHRoZXNlIG9wZXJhdGlvbnMgd2l0aAo+Pj4+PiBjZl9tdXRleCB0byBzZXJpYWxpemUg
dGhlc2Ugb3BlcmF0aW9ucyB3aXRoIHJlc3BlY3QgdG8gZ2V0L3NldCBjb25maWcKPj4+Pj4gb3Bl
cmF0aW9ucy4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL3ZkcGEvdmRwYS5jwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+Pj4+PiDCoCBkcml2ZXJzL3Zob3N0L3Zk
cGEuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrLS0tLQo+Pj4+PiDCoCBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fdmRwYS5jIHzCoCAzICstLQo+Pj4+PiDCoCBpbmNsdWRlL2xpbnV4L3ZkcGEuaMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrCj4+Pj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4+IGluZGV4IDQyZDcxZDYw
ZDVkYy4uNTEzNGM4M2M0YTIyIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5j
Cj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4gQEAgLTIxLDYgKzIxLDI1IEBA
IHN0YXRpYyBMSVNUX0hFQUQobWRldl9oZWFkKTsKPj4+Pj4gwqAgc3RhdGljIERFRklORV9NVVRF
WCh2ZHBhX2Rldl9tdXRleCk7Cj4+Pj4+IMKgIHN0YXRpYyBERUZJTkVfSURBKHZkcGFfaW5kZXhf
aWRhKTsKPj4+Pj4gwqAgK3U4IHZkcGFfZ2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAgdTggc3RhdHVzOwo+Pj4+PiArCj4+Pj4+ICvCoMKg
wqAgbXV0ZXhfbG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+Pj4+PiArwqDCoMKgIHN0YXR1cyA9IHZk
ZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyh2ZGV2KTsKPj4+Pj4gK8KgwqDCoCBtdXRleF91bmxvY2so
JnZkZXYtPmNmX211dGV4KTsKPj4+Pj4gK8KgwqDCoCByZXR1cm4gc3RhdHVzOwo+Pj4+PiArfQo+
Pj4+PiArRVhQT1JUX1NZTUJPTCh2ZHBhX2dldF9zdGF0dXMpOwo+Pj4+PiArCj4+Pj4+ICt2b2lk
IHZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPj4+
Pj4gK3sKPj4+Pj4gK8KgwqDCoCBtdXRleF9sb2NrKCZ2ZGV2LT5jZl9tdXRleCk7Cj4+Pj4+ICvC
oMKgwqAgdmRldi0+Y29uZmlnLT5zZXRfc3RhdHVzKHZkZXYsIHN0YXR1cyk7Cj4+Pj4+ICvCoMKg
wqAgbXV0ZXhfdW5sb2NrKCZ2ZGV2LT5jZl9tdXRleCk7Cj4+Pj4+ICt9Cj4+Pj4+ICtFWFBPUlRf
U1lNQk9MKHZkcGFfc2V0X3N0YXR1cyk7Cj4+Pj4+ICsKPj4+Pj4gwqAgc3RhdGljIHN0cnVjdCBn
ZW5sX2ZhbWlseSB2ZHBhX25sX2ZhbWlseTsKPj4+Pj4gwqAgwqAgc3RhdGljIGludCB2ZHBhX2Rl
dl9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkKQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9z
dC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+PiBpbmRleCBlYmFhMzczZTliODIu
LmQ5ZDQ5OTQ2NWUyZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+
Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4gQEAgLTE0MiwxMCArMTQyLDkgQEAg
c3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCAKPj4+Pj4gdmhvc3Rf
dmRwYSAqdiwgdTggX191c2VyICphcmdwKQo+Pj4+PiDCoCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBh
X2dldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU4IAo+Pj4+PiBfX3VzZXIgKnN0YXR1
c3ApCj4+Pj4+IMKgIHsKPj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEg
PSB2LT52ZHBhOwo+Pj4+PiAtwqDCoMKgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9w
cyA9IHZkcGEtPmNvbmZpZzsKPj4+Pj4gwqDCoMKgwqDCoCB1OCBzdGF0dXM7Cj4+Pj4+IMKgIC3C
oMKgwqAgc3RhdHVzID0gb3BzLT5nZXRfc3RhdHVzKHZkcGEpOwo+Pj4+PiArwqDCoMKgIHN0YXR1
cyA9IHZkcGFfZ2V0X3N0YXR1cyh2ZHBhKTsKPj4+PiBOb3Qgc3VyZSB3aHkgd2UgbmVlZCB0byB0
YWtlIGNmX211dGV4IGhlcmUuIEFwcGVhcnMgdG8gbWUgb25seSAKPj4+PiBzZXR0ZXJzIChzZXRf
c3RhdHVzIGFuZCByZXNldCkgbmVlZCB0byB0YWtlIHRoZSBsb2NrIGluIHRoaXMgZnVuY3Rpb24u
Cj4+Pgo+Pj4KPj4+IFlvdSBtYXkgYmUgcmlnaHQgYnV0IGl0IGRvZXNuJ3QgaGFybSBhbmQgaXQg
aXMgZ3VhcmFudGVlZCB0byBiZSAKPj4+IGNvcnJlY3QgaWYgd2UgcHJvdGVjdCBpdCB3aXRoIG11
dGV4IGhlcmUuCj4+IElzIGl0IG1vcmUgZm9yIGZ1dHVyZSBwcm9vZj8KPgo+Cj4gSSB0aGluayBz
by4KCkkgZ3Vlc3MgaW4gdGhpcyBzaXR1YXRpb24gaXQgd291bGQgYmUgYmV0dGVyIGRlZmVyIHRv
IHRoZSBmdXR1cmUgcGF0Y2ggCnRvIGFkZCBzdWNoIGxvY2tpbmcgb3Igd3JhcHBlciwgYWx0aG91
Z2ggcmlnaHQgbm93IHRoZXJlIGFyZSBqdXN0IHR3byAKYWRkaXRpb25hbCBjYWxscyB0YWtpbmcg
dGhlIGxvY2sgbmVlZGxlc3NseSB3aGVuIHZob3N0X3ZkcGFfZ2V0X3N0YXR1cyAKaXMgY2FsbGVk
LiBNYXliZSBpdCdzIGp1c3QgbWUgYnV0IEknbSB3b3JyaWVkIHNvbWUgZnV0dXJlIHBhdGNoIG1h
eSAKY2FsbHMgdGhlIGxvY2tlZCBBUEkgd3JhcHBlciB0aG91c2FuZHMgb2YgdGltZXMgdW5pbnRl
bmRlZGx5LCB0aGVuIHRoZSAKb3ZlcmhlYWQgYmVjb21lcyBxdWl0ZSBvYnZpb3VzLgoKPgo+Cj4+
IE9rLCBidXQgSU1ITyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gZ2V0IHNvbWUgY29tbWVudCBoZXJl
LCBvdGhlcndpc2UgCj4+IGl0J3MgcXVpdGUgY29uZnVzaW5nIHdoeSB0aGUgbG9jayBuZWVkcyB0
byBiZSBoZWxkLiB2aG9zdF92ZHBhIGhhZCAKPj4gZG9uZSBpdHMgb3duIHNlcmlhbGl6YXRpb24g
aW4gdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bCgpIHRocm91Z2ggCj4+IHZob3N0X2RldmBtdXRl
eC4KPgo+Cj4gUmlnaHQsIGJ1dCB0aGV5IGFyZSBkb25lIGZvciBkaWZmZXJlbnQgbGV2ZWxzLCBv
bmUgaXMgZm9yIHZob3N0X2RldiAKPiBhbnRvaGVyIGlzIGZvciB2ZHBhX2Rldi4KVGhlIGNmX211
dGV4IGlzIGludHJvZHVjZWQgdG8gc2VyaWFsaXplIHRoZSBjb21tYW5kIGxpbmUgY29uZmlndXJl
IAp0aHJlYWQgKHZpYSBuZXRsaW5rKSBhbmQgdGhlIHVwc3RyZWFtIGRyaXZlciBjYWxscyBmcm9t
IGVpdGhlciB0aGUgCnZob3N0X2RldiBvciB2aXJ0aW9fZGV2LiBJIGRvbid0IHNlZSBhIGNhc2Us
IGV2ZW4gaW4gZnV0dXJlLCB3aGVyZSB0aGUgCm5ldGxpbmsgdGhyZWFkIG5lZWRzIHRvIHVwZGF0
ZSB0aGUgdmlydGlvIHN0YXR1cyBvbiB0aGUgZmx5LiBDYW4geW91IAplbmxpZ2h0ZW4gbWUgd2h5
IHRoYXQgaXMgYXQgYWxsIHBvc3NpYmxlPwoKVGhhbmtzLAotU2l3ZWkKPgo+IFRoYW5rcwo+Cj4K
Pj4KPj4gLVNpd2VpCj4+Cj4+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4KPj4+Pgo+Pj4+PiDCoCDCoMKg
wqDCoMKgIGlmIChjb3B5X3RvX3VzZXIoc3RhdHVzcCwgJnN0YXR1cywgc2l6ZW9mKHN0YXR1cykp
KQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FRkFVTFQ7Cj4+Pj4+IEBAIC0xNjQs
NyArMTYzLDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCAKPj4+
Pj4gdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+Pj4+PiDCoMKgwqDCoMKgIGlm
IChjb3B5X2Zyb21fdXNlcigmc3RhdHVzLCBzdGF0dXNwLCBzaXplb2Yoc3RhdHVzKSkpCj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVGQVVMVDsKPj4+Pj4gwqAgLcKgwqDCoCBzdGF0
dXNfb2xkID0gb3BzLT5nZXRfc3RhdHVzKHZkcGEpOwo+Pj4+PiArwqDCoMKgIHN0YXR1c19vbGQg
PSB2ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4+Pj4gRGl0dG8uCj4+Pj4KPj4+Pj4gwqAgwqDCoMKg
wqDCoCAvKgo+Pj4+PiDCoMKgwqDCoMKgwqAgKiBVc2Vyc3BhY2Ugc2hvdWxkbid0IHJlbW92ZSBz
dGF0dXMgYml0cyB1bmxlc3MgcmVzZXQgdGhlCj4+Pj4+IEBAIC0xODIsNyArMTgxLDcgQEAgc3Rh
dGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCAKPj4+Pj4gdmhvc3RfdmRwYSAq
diwgdTggX191c2VyICpzdGF0dXNwKQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkK
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+Pj4gwqDCoMKg
wqDCoCB9IGVsc2UKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIG9wcy0+c2V0X3N0YXR1cyh2ZHBhLCBz
dGF0dXMpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdmRwYV9zZXRfc3RhdHVzKHZkcGEsIHN0YXR1
cyk7Cj4+Pj4gVGhlIHJlc2V0KCkgY2FsbCBpbiB0aGUgaWYgYnJhbmNoIGFib3ZlIG5lZWRzIHRv
IHRha2UgdGhlIGNmX211dGV4LCAKPj4+PiB0aGUgc2FtZSB3YXkgYXMgdGhhdCBmb3Igc2V0X3N0
YXR1cygpLiBUaGUgcmVzZXQoKSBpcyBlZmZlY3RpdmVseSAKPj4+PiBzZXRfc3RhdHVzKHZkcGEs
IDApLgo+Pj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+IC1TaXdlaQo+Pj4+Cj4+Pj4+IMKgIMKgwqDCoMKg
wqAgaWYgKChzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSAmJiAhKHN0YXR1c19v
bGQgJiAKPj4+Pj4gVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykpCj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnZxczsgaSsrKQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyAKPj4+Pj4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
dmRwYS5jCj4+Pj4+IGluZGV4IGE4NGIwNGJhMzE5NS4uNzY1MDQ1NTliYzI1IDEwMDY0NAo+Pj4+
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+Pj4gQEAgLTkxLDkgKzkxLDggQEAgc3RhdGljIHU4IHZp
cnRpb192ZHBhX2dldF9zdGF0dXMoc3RydWN0IAo+Pj4+PiB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
Pj4+PiDCoCBzdGF0aWMgdm9pZCB2aXJ0aW9fdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2LCAKPj4+Pj4gdTggc3RhdHVzKQo+Pj4+PiDCoCB7Cj4+Pj4+IMKgwqDCoMKg
wqAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdmRfZ2V0X3ZkcGEodmRldik7Cj4+Pj4+IC3C
oMKgwqAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+
Pj4+PiDCoCAtwqDCoMKgIHJldHVybiBvcHMtPnNldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPj4+
Pj4gK8KgwqDCoCByZXR1cm4gdmRwYV9zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+Pj4+IMKg
IH0KPj4+Pj4gwqAgwqAgc3RhdGljIHZvaWQgdmlydGlvX3ZkcGFfcmVzZXQoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBi
L2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4+IGluZGV4IDljYzQyOTFhNzliMy4uYWUwNDdmYWUy
NjAzIDEwMDY0NAo+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+PiArKysgYi9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+PiBAQCAtNDA4LDYgKzQwOCw5IEBAIHZvaWQgdmRwYV9n
ZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgCj4+Pj4+IHVuc2lnbmVkIGludCBv
ZmZzZXQsCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqYnVmLCB1bnNp
Z25lZCBpbnQgbGVuKTsKPj4+Pj4gwqAgdm9pZCB2ZHBhX3NldF9jb25maWcoc3RydWN0IHZkcGFf
ZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVuZ3RoKTsKPj4+Pj4g
K3U4IHZkcGFfZ2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pj4+PiArdm9p
ZCB2ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpOwo+
Pj4+PiArCj4+Pj4+IMKgIC8qKgo+Pj4+PiDCoMKgICogc3RydWN0IHZkcGFfbWdtdGRldl9vcHMg
LSB2ZHBhIGRldmljZSBvcHMKPj4+Pj4gwqDCoCAqIEBkZXZfYWRkOiBBZGQgYSB2ZHBhIGRldmlj
ZSB1c2luZyBhbGxvYyBhbmQgcmVnaXN0ZXIKPj4+Pgo+Pj4KPj4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
