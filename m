Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8285EC433EF
	for <virtualization@archiver.kernel.org>; Sat, 11 Dec 2021 01:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08727421ED;
	Sat, 11 Dec 2021 01:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rn6WH72VXwaZ; Sat, 11 Dec 2021 01:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B593421EF;
	Sat, 11 Dec 2021 01:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 043A6C002F;
	Sat, 11 Dec 2021 01:44:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DBA9C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 01:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62A6C61C52
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 01:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="UrTOW8Ck";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="YdOK9UVU"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Swmv4p4_L9B4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 01:44:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A25361C2B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 01:44:24 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BANhcqt030122; 
 Sat, 11 Dec 2021 01:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HtYjb7iEoPXU7AC3EhbGr4vY+eZDX+/EM7gz8SV707Y=;
 b=UrTOW8Ck2mMYNOXUb7Rvg4rFBC/VCPT7gFCbsdCoMPTtiesG4DFK9QNKIcrjYXBoigCH
 6Em1vwoBIKm7zO008AdSSBSMiPk98ZTNiCQZ1CPc6y8tiNnZbSjO5HGsnWabj4nH9+NW
 rpQJZyIXgmlxOWtcq1OAWcU+MWe4bARGxolezu0mjd6YRwgTJsCYWIQm2HfnTbdUYBNr
 R8k4aTkjaUvbbWsUCHz8XzBzd7CqlCFwN2g9ChVg40H4gbBZa+PHX+TwGcdiXRZmOEbt
 dJogrmkXCfWlXCQzGKZuc65hn3ZLUme03EK28qLlOC1iR2qWh7uD+DvaSfYoti2AZHs6 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cve1ugbsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Dec 2021 01:44:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BB1fMdl046741;
 Sat, 11 Dec 2021 01:44:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by userp3030.oracle.com with ESMTP id 3cvh3sbwyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Dec 2021 01:44:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNL0nWjXtP0dSzxC1VrszlVfsNSpK1WyjgzJd1YhMLL64Wwy9NyfdBIdeaKA1ff7wf1vLkqz5oKoTkcVnvvR4sIBjMDs2cDpEf2NanAycFGseb7cAHId7vEiBFOtofHjF07a7kAU0DbXsxC/Sc5ByLU1aoFeJi3X2ul/2eZbp45WRpEvKiI4QheANHR1QaKkYVHR8BrCBAjtcKLfGnZF2c3rcsArtX0Sqh5oz5i9pD51BAcorJ34omL6L/vRdwl2+cTve3LyezpW9LmLvlyQCJ0TASarlByNPC0pi5DVg4YyGscCUOZRo+OtPmq31UXh/w0I5UKqKP9rPxsctuM5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtYjb7iEoPXU7AC3EhbGr4vY+eZDX+/EM7gz8SV707Y=;
 b=CRE9F2EfuJOeGplqUjwgsBr1ZVtp7FOJCc5VdX9BhzOZftCquUg+PU8t1RISB/xZc7sC0dFpWtGuSOGRZjf/XXEAdFRqPGCTNvl8evBmEjSbDigWIVdg8tSRTHiroSS3cC20kmke1l31+8vVRN2wfPbfOVWKlHg2hF8SHkSF1S54PyWLg75DzxJC0EWEYwpD7CkRaiObL242BQW/NSL6JmFiTr/rfqKS4GVJ1t6m6u86dNTDCwUE3mLrd+GHCGoaMCaDrpcW4yBSlMstx0OwT3Hzp8y0T5jYMlpl724nzXWaFs6NaAnxqAT7keiGruhp87lQ4Xt82VUNJOnDV0vuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtYjb7iEoPXU7AC3EhbGr4vY+eZDX+/EM7gz8SV707Y=;
 b=YdOK9UVUm9oSozc21JgFEN36sqKMg04cvBnqXNohv7keSegptbW/O2buVPeBgti73Ur5+79OcglU/0eZmxOIu7MO48Ya60ic1w92XQ0ExO36yc1wTRNy0hptoufze787/8BCnZmJ7EBm6WXWrknIog7sOVbxThtvIDMfP9QqGdQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3748.namprd10.prod.outlook.com (2603:10b6:a03:1b6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Sat, 11 Dec
 2021 01:44:19 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4755.025; Sat, 11 Dec 2021
 01:44:19 +0000
Message-ID: <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
Date: Fri, 10 Dec 2021 17:44:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5: set_features
 should allow reset to zero)
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.65.153.25] (138.3.200.25) by
 BYAPR06CA0034.namprd06.prod.outlook.com (2603:10b6:a03:d4::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Sat, 11 Dec 2021 01:44:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f37eda3-95d7-496e-54cc-08d9bc47bf97
X-MS-TrafficTypeDiagnostic: BY5PR10MB3748:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3748AE3B120261213FE8F677B1729@BY5PR10MB3748.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hj19dnd7MIAJSw6MovH7qZ1WLaHVWgkC14uXPWf6ryBAEzlmrsivLUyUP8es7p6lyTGvSFg+MN1+OYBvpgBDBgG7dh5yHmo/Z6d7MIjEiBI4RB6NaeF+6mm+wDUodq2Ud9TeMjwgCiuZhi6kGWoHGYWB95rqa8pDcYsMx/3ZvkcH6RACvBnY2oUVqsPqCrf4+HQgorlqTMyzq/ytoKtVqQ+EK/RiWcmdGYnE9s/5fkW0h6R4FJNyu8N/EqjLZy8gviZoaNzk9KVEBRATjLazBZ4XJqoiNkJoGDN02IuDB5HKDPUAxsECwZFyXRvh2TrBDttVJ1CR0NqUVYpvEU+ga95iU6WGQmY7qF8zaarf3PpVmcNTCiAFXQBGWjz4v03fTjZtL2sv/r/oFW4fECXPCgpAjc04Ky8V3/Ob58ImwjTNBXTV4kDDjDjg0M+NxY4rK3Wy4eDm5rqNfcusqjdROFiD8F83aBAIQcSJid1RHb7jcIwooY/8vPm9Zo0MSlnVrdTwW0egWg357i8PTzAcJ2rlJWvo5Kb16YPE+K2hDoJBEDVm89EBwHvRcsUj/sfOaUzde8c+7RbPf91Qm7VleP69EfobkmLtkLpdS4irjAzYDN8rBkc1w2vo0ayED8XVzpMoghDBlVzXxLACXnXbhxjpXBDGsU3wU2CM56F06HS/ZFRM8aYEoll0XzKEhhw6vF2fW4XuA19qjG8OB7EEsE0bmgo4jVXZNeQF2hsMg1q5Pe/r98vrebM+AgufrlgQvjSmxa6o4n7bbqsPoZ78g4Ig6kx8roh7aI+eELxEC4YxV4uKx5R2+OLSFefMaMiI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(26005)(66946007)(316002)(66476007)(31686004)(38100700002)(53546011)(86362001)(186003)(36756003)(36916002)(956004)(8936002)(2616005)(8676002)(6486002)(2906002)(6666004)(83380400001)(966005)(4326008)(66556008)(16576012)(110136005)(31696002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDF1aUVnZHp3YW9lbTk0bi9QdXUzOWRUTlowUXcvTU84RnNjV1RURFN4REVs?=
 =?utf-8?B?cURENENxcXhpc21seUJkanZTSWhIaXhTN21jeG4vb3VhOEFHVWQ4WEFXeFBp?=
 =?utf-8?B?SzQvTzd2TzJ2UnlsL1BNdnFZR2xCWjg4a0M0VDBSVzJWMnlWNldjck1PQnpz?=
 =?utf-8?B?eWl4NTg5Z3pnUmFzSlc5V2FULzBIbkNKVUtjd3h4MXR2RUZLY3B0OFlTaWUv?=
 =?utf-8?B?Q3l6T3ZOUnprTUpHTWg5RkpUSkFySkl1Q09mKzlFRzl3QVFycC9RSWNCRDVY?=
 =?utf-8?B?TFg3NGdhbThmRVZNWTNUZnNkVlQ0bG1TT2NPakdNRmNKWXlZZkdVTXE4VzZS?=
 =?utf-8?B?U2dSSitGKzZWUWwycktvbTUyTXRyZFVwRGVXNWhPN0FMYWdoWmdaVWxMMHRl?=
 =?utf-8?B?TEtwTklBWHBadjlxWE1PV3VoeDc2dElDNUFhVnhRRFNFbkR2OFArOG1jZmg0?=
 =?utf-8?B?bVU0b1UrcWZSeUQ4VUhSNFN3NE1GVjhPdUQ1V2pBT1dONloyUlhMYlNmNDND?=
 =?utf-8?B?M01KUllUMTUxRExVL2J4ekFPcUF4T0tBNE1JVjA0VmovSmVBK0dJRHBkUHMw?=
 =?utf-8?B?M0FONVRMUXFBTTllU0lGbUhHSEozRTZiamUzUnJOMnBoUWdnZmZHa2U1T3RL?=
 =?utf-8?B?L09GWXNqSmZBNXhFVVhVa2p2R2V1bFlyT0V0eEJlV1lQdENLU0VqaDRoUmNj?=
 =?utf-8?B?bjQ3OUcvQnhhdXNwc1JMcjlpU0R6UExqZGtTNjBqOTF6QmE3ZU5WZ1BxR2ND?=
 =?utf-8?B?Wm9VV3YzSW9FOXV5dHd5aHNEbFdrelZtZlUyaHJsMDNCeUZXRGpON2lWNU55?=
 =?utf-8?B?aGRncksxek9iM3VSMEg0WGVYQWV6WE1JTkwzbEtsSEdoSDExQlc5bU5xMUdI?=
 =?utf-8?B?RGxoOEJ0bE92TU9TZ0VudU1QckFGZ0s5OFNVbTFOUlh5YlpJUU9VSE94d3dh?=
 =?utf-8?B?QkNOaEhoUld1dGphK2I2aGozeTlIdUdwUmNxaTQzVW9URHQxazhKKzhoOFFT?=
 =?utf-8?B?aXo5L2RvVUk4SzNtdEs2QjRpWXF0cSt5MGhEUFJRTlB3dTZFK2Z1cUw3MFpS?=
 =?utf-8?B?NnkyYkJUeFlVT0xkMjJFbFZQSEtiWCtBdVYyQ2RjcUl5YVFhNVlESEtORHEv?=
 =?utf-8?B?WHJ0b21ic0F0UkluQTFYdlAyREt4TmpycWR1MlJMTFZpclg4WTEwVGk1dWNK?=
 =?utf-8?B?b1RKN1Rob2Y5YUJrM1psSjh0V0YvczlTWkNDVDh2OVQ0dUcxaHB1ZUhHK0k5?=
 =?utf-8?B?UmNFZitiMjROdmdIWFdlMmI4cVZ2SnBlaDRvVzQrTWpiQkxQejdybnBDd08r?=
 =?utf-8?B?NDlGc05Va1ZTSitNeC9yZ2N4VmFvM01oR2VmdUlzbXFXWGxhdEt5dm5IekJu?=
 =?utf-8?B?U2J6dGhPRWtFZ2NoeHc3K2pXRVM4bnhqTjVOMjBwYStibmtPSUJJaWFia3Nm?=
 =?utf-8?B?NUg3ck5LYU5PYzBwYkFqTU1QenhmcUdFVWJRVTluRkRzTDhRK0kxM29wcGwz?=
 =?utf-8?B?RXpYeUVTd25YSWV3NW9tcjc4RVFLOUJxM1lPTFRHTVpPMjRCSHJVNVUwYTlZ?=
 =?utf-8?B?NHROby8yZHdPUHhNaXM5K3lYV0hkaGFiUXN1TDJuVVFmaWVEanlhbHZRMU9Z?=
 =?utf-8?B?MmtSdlNRRnphK2E3OEpQSE41K280UWU2Qms3WVdnUVRqLzNWWWFHd2pBdFlI?=
 =?utf-8?B?ZzlNd2V6U3U2VGl6WDNvM3BuQlhocXBrOW9Ia1dhMFFoZXNIeDZYZFZyTklE?=
 =?utf-8?B?VWltQnBvdkxVV21LVEk4RDZOUVVkN0RTZnhMZEhySEd2TlU0UFRYSEpndktP?=
 =?utf-8?B?bXpjMDNCaWlDR2orVlY4cHVlVU1FNUxjNHBRbEVOem9PcHc2UldaSlZhZS9R?=
 =?utf-8?B?Ylo0M3lFTEtVVG9sNUdXVlVYVk52YmJaNkp2RjVKR21FM0VYTitLTmw0YTlV?=
 =?utf-8?B?RC9HbHJmQ1A2bDZTcVlOeTJJSHJkRDRReFlZQjdpTG9yNWhCRGFaeU0wL3ZH?=
 =?utf-8?B?T2gvRXQ1MDExeGxWYjRyOVloTktPWEtlY3VSc0JURnd2aXZSZ3phVEd0WnJr?=
 =?utf-8?B?dVhFVDRSYkk5VFVVbEgxSlJDc3huaU5zNFMzM3AzY09UQ2lrZURXK1RHRzNR?=
 =?utf-8?B?YUd2M3ZweDVJV0NqOWZiYUlmZG1JalpqMjRVRlNHQmFNbmJBTUhJeEt0Qm9l?=
 =?utf-8?Q?iOz6qBTl3ay2AgnB5uZLkoA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f37eda3-95d7-496e-54cc-08d9bc47bf97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2021 01:44:19.4732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mzs/lgdqm00l6aSBNZqlHnjjWOjk2IzQoGxast186IQjq5rTA7zYdqfwTSgF+3jkcPTvwBiXIZf2iSliRc32Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3748
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112110007
X-Proofpoint-GUID: Fa20rtltT8ib61QgmgIFpxpbhz34mvXC
X-Proofpoint-ORIG-GUID: Fa20rtltT8ib61QgmgIFpxpbhz34mvXC
Cc: netdev@vger.kernel.org, elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

U29ycnkgZm9yIHJldml2aW5nIHRoaXMgYW5jaWVudCB0aHJlYWQuIEkgd2FzIGtpbmRhIGxvc3Qg
Zm9yIHRoZSAKY29uY2x1c2lvbiBpdCBlbmRlZCB1cCB3aXRoLiBJIGhhdmUgdGhlIGZvbGxvd2lu
ZyBxdWVzdGlvbnMsCgoxLiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydDogZnJvbSB0aGUgcGFzdCBjb252
ZXJzYXRpb25zIGl0IGRvZXNuJ3Qgc2VlbSB0aGUgCnN1cHBvcnQgd2lsbCBiZSBjb21wbGV0ZWx5
IGRyb3BwZWQgZnJvbSB0aGUgdGFibGUsIGlzIG15IHVuZGVyc3RhbmRpbmcgCmNvcnJlY3Q/IEFj
dHVhbGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyB2aXJ0aW8gdjAuOTUgZ3Vlc3Qg
Zm9yIAp4ODYsIHdoaWNoIGlzIGJhY2tlZCBieSB0aGUgc3BlYyBhdCAKaHR0cHM6Ly9vemxhYnMu
b3JnL35ydXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmLiBUaG91Z2ggSSdtIG5vdCAK
c3VyZSBpZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBwb3J0IHdpbGRlciBsZWdhY3kgdmly
dGlvIHZlcnNpb25zIAplYXJsaWVyIGJleW9uZC4KCjIuIHN1cHBvc2Ugc29tZSBmb3JtIG9mIGxl
Z2FjeSBndWVzdCBzdXBwb3J0IG5lZWRzIHRvIGJlIHRoZXJlLCBob3cgZG8gCndlIGRlYWwgd2l0
aCB0aGUgYm9ndXMgYXNzdW1wdGlvbiBiZWxvdyBpbiB2ZHBhX2dldF9jb25maWcoKSBpbiB0aGUg
CnNob3J0IHRlcm0/IEl0IGxvb2tzIG9uZSBvZiB0aGUgaW50dWl0aXZlIGZpeCBpcyB0byBtb3Zl
IHRoZSAKdmRwYV9zZXRfZmVhdHVyZXMgY2FsbCBvdXQgb2YgdmRwYV9nZXRfY29uZmlnKCkgdG8g
dmRwYV9zZXRfY29uZmlnKCkuCgogwqDCoMKgwqDCoMKgwqAgLyoKIMKgwqDCoMKgwqDCoMKgwqAg
KiBDb25maWcgYWNjZXNzZXMgYXJlbid0IHN1cHBvc2VkIHRvIHRyaWdnZXIgYmVmb3JlIGZlYXR1
cmVzIAphcmUgc2V0LgogwqDCoMKgwqDCoMKgwqDCoCAqIElmIGl0IGRvZXMgaGFwcGVuIHdlIGFz
c3VtZSBhIGxlZ2FjeSBndWVzdC4KIMKgwqDCoMKgwqDCoMKgwqAgKi8KIMKgwqDCoMKgwqDCoMKg
IGlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7CiDCoMKgwqDCoMKgwqDCoCBvcHMtPmdldF9j
b25maWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7CgpJIGNhbiBwb3N0IGEgcGF0Y2ggdG8gZml4
IDIpIGlmIHRoZXJlJ3MgY29uc2Vuc3VzIGFscmVhZHkgcmVhY2hlZC4KClRoYW5rcywKLVNpd2Vp
CgpPbiAzLzIvMjAyMSAyOjUzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMS8zLzIg
NTo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4gT24gTW9uLCBNYXIgMDEs
IDIwMjEgYXQgMTE6NTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+IE9uIDIwMjEv
My8xIDU6MzQg5LiK5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4gT24gV2VkLCBG
ZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+
IERldGVjdGluZyBpdCBpc24ndCBlbm91Z2ggdGhvdWdoLCB3ZSB3aWxsIG5lZWQgYSBuZXcgaW9j
dGwgdG8gbm90aWZ5Cj4+Pj4+PiB0aGUga2VybmVsIHRoYXQgaXQncyBhIGxlZ2FjeSBndWVzdC4g
VWdoIDooCj4+Pj4+IFdlbGwsIGFsdGhvdWdoIEkgdGhpbmsgYWRkaW5nIGFuIGlvY3RsIGlzIGRv
YWJsZSwgbWF5IEkga25vdyB3aGF0IAo+Pj4+PiB0aGUgdXNlCj4+Pj4+IGNhc2UgdGhlcmUgd2ls
bCBiZSBmb3Iga2VybmVsIHRvIGxldmVyYWdlIHN1Y2ggaW5mbyBkaXJlY3RseT8gSXMgCj4+Pj4+
IHRoZXJlIGEKPj4+Pj4gY2FzZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUgaW9jdGxzIGxh
dGVyIGlmIHRoZXJlJ3MgaW5kZWVkCj4+Pj4+IGRpZmZlcmVudGlhdGlvbiAobGVnYWN5IHYucy4g
bW9kZXJuKSBuZWVkZWQ/Cj4+Pj4gQlRXIGEgZ29vZCBBUEkgY291bGQgYmUKPj4+Pgo+Pj4+ICNk
ZWZpbmUgVkhPU1RfU0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+Pj4+ICNk
ZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+Pj4+Cj4+
Pj4gd2UgZGlkIGl0IHBlciB2cmluZyBidXQgbWF5YmUgdGhhdCB3YXMgYSBtaXN0YWtlIC4uLgo+
Pj4KPj4+IEFjdHVhbGx5LCBJIHdvbmRlciB3aGV0aGVyIGl0J3MgZ29vZCB0aW1lIHRvIGp1c3Qg
bm90IHN1cHBvcnQgbGVnYWN5IAo+Pj4gZHJpdmVyCj4+PiBmb3IgdkRQQS4gQ29uc2lkZXI6Cj4+
Pgo+Pj4gMSkgSXQncyBkZWZpbml0aW9uIGlzIG5vLW5vcm1hdGl2ZQo+Pj4gMikgQSBsb3Qgb2Yg
YnVkcmVuIG9mIGNvZGVzCj4+Pgo+Pj4gU28gcWVtdSBjYW4gc3RpbGwgcHJlc2VudCB0aGUgbGVn
YWN5IGRldmljZSBzaW5jZSB0aGUgY29uZmlnIHNwYWNlIAo+Pj4gb3Igb3RoZXIKPj4+IHN0dWZm
cyB0aGF0IGlzIHByZXNlbnRlZCBieSB2aG9zdC12RFBBIGlzIG5vdCBleHBlY3RlZCB0byBiZSAK
Pj4+IGFjY2Vzc2VkIGJ5Cj4+PiBndWVzdCBkaXJlY3RseS4gUWVtdSBjYW4gZG8gdGhlIGVuZGlh
biBjb252ZXJzaW9uIHdoZW4gbmVjZXNzYXJ5IGluIAo+Pj4gdGhpcwo+Pj4gY2FzZT8KPj4+Cj4+
PiBUaGFua3MKPj4+Cj4+IE92ZXJhbGwgSSB3b3VsZCBiZSBmaW5lIHdpdGggdGhpcyBhcHByb2Fj
aCBidXQgd2UgbmVlZCB0byBhdm9pZCBicmVha2luZwo+PiB3b3JraW5nIHVzZXJzcGFjZSwgcWVt
dSByZWxlYXNlcyB3aXRoIHZkcGEgc3VwcG9ydCBhcmUgb3V0IHRoZXJlIGFuZAo+PiBzZWVtIHRv
IHdvcmsgZm9yIHBlb3BsZS4gQW55IGNoYW5nZXMgbmVlZCB0byB0YWtlIHRoYXQgaW50byBhY2Nv
dW50Cj4+IGFuZCBkb2N1bWVudCBjb21wYXRpYmlsaXR5IGNvbmNlcm5zLgo+Cj4KPiBBZ3JlZSwg
bGV0IG1lIGNoZWNrLgo+Cj4KPj4gwqAgSSBub3RlIHRoYXQgYW55IGhhcmR3YXJlCj4+IGltcGxl
bWVudGF0aW9uIGlzIGFscmVhZHkgYnJva2VuIGZvciBsZWdhY3kgZXhjZXB0IG9uIHBsYXRmb3Jt
cyB3aXRoCj4+IHN0cm9uZyBvcmRlcmluZyB3aGljaCBtaWdodCBiZSBoZWxwZnVsIGluIHJlZHVj
aW5nIHRoZSBzY29wZS4KPgo+Cj4gWWVzLgo+Cj4gVGhhbmtzCj4KPgo+Pgo+Pgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
