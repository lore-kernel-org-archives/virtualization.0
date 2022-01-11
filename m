Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCF4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 09:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EA2283E2E;
	Tue, 11 Jan 2022 09:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8mBqpDgsEvul; Tue, 11 Jan 2022 09:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B7CD82EA4;
	Tue, 11 Jan 2022 09:16:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8D94C0030;
	Tue, 11 Jan 2022 09:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E128CC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF4FC82EA4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JmvXDAGtAfqg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED08283E31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:16:06 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8dVwS019811; 
 Tue, 11 Jan 2022 09:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VZ1E7JxJ6Dw3HENr0nAd2A0kREdYMb3gPmTLevEa9tY=;
 b=HQOMoUTJTl+G8i2xSbuT9ovqvKVHqtAZkj+SpfloO25Pgi234MEjs7meJY3nejN/RDUN
 G4yBmdKW6XQxunQbITTtb18deIyTM31uWVFNCf2wjfUFN8PdYapWsrK3mwc5Uinhb79Q
 WJRoPCtRjUQJ1aSbfR6COnAcmyouRGXmCEwvaIJDwwkAuV+FwrDzz/3REDNEhXVkv4cC
 VlgAzEQkcCNk2JCVOdv5okcPWHBd4DrH1J8kcwUVEOKQOw6H+VxWjMvKgNJJ1wP1/XhT
 C4k/NPcz3Dd7MogTrNkuxhCdazW1wpoyYWoA5tF28PCmq4lqns/xpeqdBc0cagnBNoJi GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74aebj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:16:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B9ARvR017535;
 Tue, 11 Jan 2022 09:16:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by aserp3030.oracle.com with ESMTP id 3df0ndsf7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMcav+JTJvFKZKghSAbMDNMA+EnWn4Z1iEye8LgGR/yurdM6fN+O4BFXLZBa23Gn4612zrmeQQTqUBiQ1O1gq/Ut9qBGRA8wIYaPVF7IrwSDQg1CUGXEit7VYK3aOKGqsKzd7GUMtThzqgB7yL8BrRFUSLC6CbrcFswp6t8IIeclE4jhZxREneLNbwuzSSvl47+jHnp6suJlMPiuE5kNHYi+64PrPGpWmn0hMl4SvPlic0ud3WS/dwqQjdeF2wd/Mc2McH+T4BTNyEQC3sagDitEoyeYHvE/JoBr/ydux+QU50klP+qpDVxAHJInK3GHJ0UpOFxC6yMI0UwNKotiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ1E7JxJ6Dw3HENr0nAd2A0kREdYMb3gPmTLevEa9tY=;
 b=SQ2I7cAAKk24zPAfs/n9Qn7r26tEAKmyrmSqRWXjNtcyK54+quugOKstr3LxUh4yEniIIbQ5fYFs4t2fy40k5fHHLjrf2C3fcibmjd1U+wcK6gCawnrlXzkF2ZTzFQ/L5FMIshGh55TT68WEuBD4SSiefcvmT2STdPRB6K1O9WwJJ6twRsWtPGitfQc5ISD8tWHX575P1YCSBvYHgrSYHMbz08WE9uceyOdsrrGh5jMRSHACkdwsq6vhbL11RSyZ19tsCaXjc2mgZlFwGs1wIZmQzzlkhccJrcBCBTMmMOU48lrLPeRS9e7VdrGIdqRYsZ7moy8qb9rwr0+9gYuQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ1E7JxJ6Dw3HENr0nAd2A0kREdYMb3gPmTLevEa9tY=;
 b=BcKIM8zuDd/CA17LC5/yysM0gyHyEszg1uS4+E7BavbyahQBQnEg0ryJJHn4th5+XsFoiqDdjTH9iHFLZ3wTvitUdB0hqcccw/4xSEwccIqAuLEh79KaX6lIii3zAQnA5aTetOCjiEeIa9XQLZzqcPspNMqFvRgoeQqclo6oWeo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5597.namprd10.prod.outlook.com (2603:10b6:a03:3d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 09:16:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:16:01 +0000
Message-ID: <626d9dca-8361-55fd-54d2-f9edd91386a7@oracle.com>
Date: Tue, 11 Jan 2022 01:15:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
 <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
 <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
 <a4fefb05-958b-743c-87da-652420b98e70@oracle.com>
 <CACGkMEvgQ-Qq36Ldgu7aNBaZ85ERQbaFfW4CY0i3so8NzpcAGA@mail.gmail.com>
 <PH0PR12MB5481784AE87D6D563656A0CFDC519@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB5481784AE87D6D563656A0CFDC519@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN7PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:806:122::8) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cbfdd04-5ab2-46fd-6acc-08d9d4e2fc65
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5597:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5597F9A11760153AA2B0D1D4B1519@SJ0PR10MB5597.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHYSGWDjSJ1qXodyn5NfOXAq/KOxQpTyAC/o2p4xhryAtOfvu0j2WxMhnzs8KdEl4zMncpqC80WWKSvKOKl6LMN+CXXpByW1gpmL7K8WHA8cKjiHJ360nM/yia9s4s3PYVUm0Xmbo9rQ+YPpfNAO81DhEdFSYRJXDqmKtZYt3w00Dm59fqherQN0Rig2v7WNEfS3IQ8QRRejhdjcH/RNUJe1TgTuIsDGSXedRG/YYNrKZr9RD2Ub633u9OivhdLTJ3TAv16LgoMutOizkVEluRYNDeosO4qulDwY6SNJnHACqxyuWsVFpifL4vp8quM7PzD/6ur1cWeZmF04UO5V9kaHcSeKEEJynOGb6aMvYXcUVz1u8qegom3uEmSfsA9YL3ifhdWurS5CSl6MpzltelWTViVXYz9pvwlMj2Ouk19Nn19A3CIhEDfEyHLM+UEzITSfdOJlMBwg7g6JbE0PpHaNhFJifaI/CefidGK4E2HPgUex+4/1kevFAf5ugEe7YRlTl1yqP+6+WRQYnccPCVrednlaulup9rQbPF1ZZ/YeoaHmG63spQU6kRhtUsd2RTBX7XQfnehi+vuky2Q9S88U6hcj7//6Z+b78moPfM1/JGyhzOHcTWzii2NT6VZ4up3YPUKOQCC5iBX0Su//b7JZ1Abmc/w0tjFOmsoZK2H7mKgen3Gpc+zZL+XtfKrG92cTf0+1puibUaifb6hNXaqYX7RSSHVw/TBu1wQvJCLe/zPLGSFIrMl8QMWKlBs0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(6506007)(4326008)(86362001)(36756003)(508600001)(8936002)(186003)(53546011)(26005)(83380400001)(110136005)(31696002)(6486002)(66476007)(66556008)(66946007)(54906003)(31686004)(5660300002)(38100700002)(6666004)(36916002)(2616005)(316002)(6512007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWZYU04zaWlOd29tTEVjSFd1M2NmamJ0SzJJS3lDNk9KMm5zVFlKYmcxMkoz?=
 =?utf-8?B?N0hLZ3hHb0JpOVhzN1NuOTJyNUF1SEh3aXZhSDdFSGpQeWE3SDdFUTZRUDhJ?=
 =?utf-8?B?UWxCM3V4Mlh4VW1IaExreDFTT2hVREJTenUrbndOOXZHSEdiRnVFaWdDS1hW?=
 =?utf-8?B?alA3N2RKRzhmM1B5K3ZPQzVmSUt5RWJnNmJRWWFZRzIzaHNqNGhjZC9Oclll?=
 =?utf-8?B?NGxtR2g2SklDWDRIdXlYUzF2ZnJzaW83WERSdGoxV2lTV3dPOUErbVRWcncr?=
 =?utf-8?B?cU1NVVJ1Nzg4Vy9mTmFVSnNLZHlqalMyS1hTSUN3NTNCRmswSDJNeDJCOFcy?=
 =?utf-8?B?M2k0ZTF1anpPMmZUS29iaFN2alFmTWVtbEwvL1d6RVpQc0RibjRhNkZEYWl0?=
 =?utf-8?B?dk8vVGFFTWJEK2FPc0o3Ymd6dlJDVTZCdXEwNVV2RWxERFdIUndEd3hXRGtZ?=
 =?utf-8?B?UGlYYmh2eGhZMC9kTk1DOGNYQmtFNlNQbmh4T3cyNGRURUlpQ1ZFQ2lUMkp6?=
 =?utf-8?B?eDhyRjdYV1ZBdmxIWDNwOEhJalpYK2thZ2NqblVKbkFpeXdrZk1ydmkrSEFB?=
 =?utf-8?B?empiNUFTQVMralBVb2NocVlzdGVoTDdyQ3BienI0TU5KbktQSkF6L3l1QVVY?=
 =?utf-8?B?d2R0L3lOQ3dUVEtvelFPSndtQmxlY0lOUytSazVNTFpaVUNrYnVOR3ZuU1Fz?=
 =?utf-8?B?SVZWSlV6Tm5uZ0hNdytjbzBUNGk1bWJHdUpzc3lURWc5RUxuRGI1TndpdUVI?=
 =?utf-8?B?cTlIOFdqWDR3MUIzdEdDT3BKUGtLTXV0QTNkZThOZmpNWlMzbzd1d0dabzc3?=
 =?utf-8?B?TC9nTFpySTVJc01CWmtidG1vdVIwNGhHekswYzZDUUNHYTJ0S3h0dFFGYjNY?=
 =?utf-8?B?V2NVdDVFOFIxa1NtWHFheW5WaXMyS2xERDJYK1czdHh6S3Zidjl3eGdZSlho?=
 =?utf-8?B?OStucXc4cWp0MmtPSlBUNTU3TWR4ZUcrczBiMmcxREk1d1NGbWN5djFhNHhl?=
 =?utf-8?B?S1l2UXZsQjE2VDFBUzlrTmVFR1Vwa21oV0F0UWFjTDFMdHJHZlhYV2FCY2pP?=
 =?utf-8?B?a01kanRudDlURG9DTnNiOGtEYjlNK0RXb1pHQWdudFkwM0dtTEZ2cDd6QkJi?=
 =?utf-8?B?SnhwLzBoZm1XTEhSOHJ4YlNnWE1lc1RXOWE3bDBib0hIbjFhaEt5aWNyajV3?=
 =?utf-8?B?Q3JQUEYzUWh2bXN4OXI4OXRCS0FiZkJvTWNSMExaVmJOeVpUTVF6NERkUm5x?=
 =?utf-8?B?UDFyMDhQYTIwUlNKSGxaZmxYcnhvSlI3U1Z5aTE1cFpQS0Y1QVlvcmx3Zyty?=
 =?utf-8?B?NHQ1YkJ5azJkRzU5dlE3V3A3U25ZSk9tNnJNUVJwbkdrY2oxQ1pWbjh0MFox?=
 =?utf-8?B?UDlERjJwRUtralBHUnFyUHplQ2pycXVFczhBYW0zR09mQXUyQm1McHd0SEpL?=
 =?utf-8?B?aXVpdE1mTEhEckNzZjJEbHFEWUdyUkw1aUZhQXQ5NUV6QzhocTFYcVRCd25x?=
 =?utf-8?B?ZXk5UklTS2VVcmVjdVVMdmJOaEhhNlNCQVo0dUZWNHRjMENUem1tODQ0UVNV?=
 =?utf-8?B?bFQxOHhWdkhGUEhEOXRvQ3lsQjVMeC9PS2kzVWY3SklTVmpnUExzOXFScDc4?=
 =?utf-8?B?MDFaZDNpMFhTUnFPMFhjUExPbmQ4ZyswUEptaWxsVnc2ZnFnVVZjNnBqNHY3?=
 =?utf-8?B?M2NEbUxlTno3RVRGd09CVVU4REhnci9FUEpROGFMc3lJRWxzMGh1NDBBVGk1?=
 =?utf-8?B?OGdUK0xoOWlnZHYwWFVyVTJEc0wrRFpLSmpKaVAxYWc1NWhMN21ZVGJKcjlm?=
 =?utf-8?B?Q3Z5VW00NXJFOWVybFJkQnQ3Ullpd3B3TkhCdGhqRjlhNHFPZDNBM29qV2oz?=
 =?utf-8?B?SzZvYm1uRnVBbWF5WC9OWWVRY25yU25LNE1Db0RPWUpraHJpdDNxMEx6WU9K?=
 =?utf-8?B?bTBLeDRTZVB3ZE5LNjBLdnRUcUE1OUVKT1BjUnI0bVpsRTZ6T3NHM2hQdEZ5?=
 =?utf-8?B?NURtNzZyYklzYWNsY2ZQMS84WGZSZTlOTzJVL3laenFFa011ZFhObzR5bHNU?=
 =?utf-8?B?cjNFcElWR2xoWDVhd2lmSWZvSFp6M1Q5TDlFaWpiN3RJV3p6enY4alJEMmE3?=
 =?utf-8?B?RjJUdkc2UlMwVlBxY3J2bS9vMGhXTUhNeXlMaXIyWk5yOTYyUGJ2YXhDUEJ6?=
 =?utf-8?Q?vfBVHk37VYROUSvb3WhSOmM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbfdd04-5ab2-46fd-6acc-08d9d4e2fc65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:16:01.3869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRQSaQXr8QjXIMxcrion1rrIktvaTLimT2foM68Wu3TFPHr5ToFSt9TGsvN1iJcys/fkRsLABCXqAXr5IIKZGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5597
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110053
X-Proofpoint-ORIG-GUID: GHv0EQt6TJgjktqj23o231_b6cQLMtwO
X-Proofpoint-GUID: GHv0EQt6TJgjktqj23o231_b6cQLMtwO
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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



On 1/10/2022 10:26 PM, Parav Pandit wrote:
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Tuesday, January 11, 2022 10:17 AM
>>> I guess in this situation it would be better defer to the future patch
>>> to add such locking or wrapper, although right now there are just two
>>> additional calls taking the lock needlessly when vhost_vdpa_get_status
>>> is called. Maybe it's just me but I'm worried some future patch may
>>> calls the locked API wrapper thousands of times unintendedly, then the
>>> overhead becomes quite obvious.
>> I'm fine to remove this if others agree on this.
>>
>>>>
>>>>> Ok, but IMHO it might be better to get some comment here, otherwise
>>>>> it's quite confusing why the lock needs to be held. vhost_vdpa had
>>>>> done its own serialization in vhost_vdpa_unlocked_ioctl() through
>>>>> vhost_dev`mutex.
>>>>
>>>> Right, but they are done for different levels, one is for vhost_dev
>>>> antoher is for vdpa_dev.
>>> The cf_mutex is introduced to serialize the command line configure
>>> thread (via netlink) and the upstream driver calls from either the
>>> vhost_dev or virtio_dev. I don't see a case, even in future, where the
>>> netlink thread needs to update the virtio status on the fly. Can you
>>> enlighten me why that is at all possible?
> Sorry for my late response.
>
> Netlink reads the whole space while it is not getting modified by vhost/virtio driver side.
> A better to convert cf_mutex to rw_sem that clarifies the code more and still ensure that netlink doesn't read bytes while it is getting modified.
I missed the best timing for asking why it was not a rw_sem in the first 
place, but I don't mind multi-reader's case too much, so it's not a 
hurry for me to make the convert.

-Siwei
> Given that config bytes can be updated anytime and not on each field boundary, it is anyway not atomic.
> It was added where we wanted to modify the fields post creation, but eventually drop that idea.
>
> So yes, cf_mutex removal is fine too.
>
>> After some thought I don't see a case. I can think of NEEDS_RESET but it should
>> come with a config interrupt so we're probably fine without the mutex here.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
