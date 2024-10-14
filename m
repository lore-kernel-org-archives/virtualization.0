Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047714683
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939968; cv=fail; b=o9nsfPwFwvueRsos5brZwY4JNlkcfJk7S9Tnl4ZKGhdumsFRi55iygyWHI3KG1wqoNc9twe92EH9NsEZ8tXq+LumJp4Z7qqMCtfF4amgtbQO7qKU6mvizzcBNM6FOEA20WxPTHvplzj6S1VZYnbgNUZsEoVfgpqlHG3SvP2WUkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939968; c=relaxed/simple;
	bh=leRWoK21JbidY5OcvujF+1Wo0qD0JD5VUE+ydWRlvoI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AnurJI3uFOGSGrPx/hXMc+Z5eCaV//DxeW5+3h6O9ueIS1Ohp9waWAsKgt1eVHF4IrrCcKnbLPOLTk4C3jM/yeRQQhi7hWuQreO7USzbTFaHG+ZhaqewZbK9ozlxaiXYAR2QfPYIiybHVoWz2vy1t1HUiLdJHumpws4kaxaB4fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FR8P7NYb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qPq6Hw3H; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FR8P7NYb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qPq6Hw3H"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A569E81091
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 21:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DbsA6-HMDrD for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 21:06:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C040C80F47
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C040C80F47
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=FR8P7NYb;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qPq6Hw3H
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C040C80F47
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 21:06:05 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EKtdI6026169;
	Mon, 14 Oct 2024 21:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M6RHyTrRpFSCDdPyKm79on29qy9+PNzhmM9+dukEEcI=; b=
	FR8P7NYbafNF4q1iqvEbU5+Vr7ndV2bRCWCz/xqdP1gO4VbLpF9MR+ys7lZzJryh
	ao5nGdYOjuoAh3psBWj6MlXFWGSjx+hm3b7SuYo6O7681WlEwYiEG4GpP/deJaYz
	95K9qWaF4dYWfooLYzwGGxwjUzpmNe8yuMV3op9AQ5xG6V6JnTNCcnxhuteAduZq
	Ymq93woSZfiqNbKbeQL0yuYmYUzqgG4gLccobVSgKUFtdZw2ecTP06AWSG4ycVzz
	kDUU84MhVmZdqsiJ7QNOSxhDAuNc3EkKpjtW2/5O+31l+XXRCBWiygmj2CF+a+cw
	EKNUd2rAy3DbIywarTW9ZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcexm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:06:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EKFlC7036092;
	Mon, 14 Oct 2024 21:06:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcutcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKVIfqxQXcRkRh/jx1sBvpI8JotyPaRxmnu0o+M498Y9+qHne7prK5jcvmNdw38qv8nAghfwvpdx/QqsthCckuLOxEy9JeG/nkmy56Cj8C6iroNlaYatNhVDsCsmjOEA1uYIt5k86fjPI1HIqf8wp0ORKaw6X0nJPcE0uNANPzyg/lhqwC9gHdaY/Y+/9Kmo0V1B3jKYphAp+4XeBxtuTjrPFv7OUeHsplCdfjT4PGzdeilk8gk9VXXHaECZbqvbrcRKst3qLLPDTBt+FqM5QBmu2Uh9eZF3lpapohV80SN4RPE8o38fI3LPDeK8Fw/iepWgsqwK4wvtKz8NguZyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6RHyTrRpFSCDdPyKm79on29qy9+PNzhmM9+dukEEcI=;
 b=OeBDbHHpELs/Un1yDlycGnSbLAyTbd/8GkwOOUG8AYSLFO6bZzNT2ABR/ADyK7/nhKT0P10pxKf4X/AWSB1ECR9ZrqR7FNiVIRokV0LLSuaSLSBNuWJVl90JlMEFQGO/+vMbXlmOfGVuQz758qLZKzzYvujTv3WBv/FExEpZk6SuKntWn4G2mZz861fJCgjR49ZL8U9u2HTLSCvEe4SpELogv0k5D+A5oG02OhytQLtDu1iW0PfNQletL0mECegpHu/WHgwb2r5DKMKFKUYH3RjEGml1UOaWU4Oe8jDvIMnt+4FcLkz4RsrhwlzFBYY9xBiPObKi9EUOQP+I/Y/QIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6RHyTrRpFSCDdPyKm79on29qy9+PNzhmM9+dukEEcI=;
 b=qPq6Hw3HjTgfM8mZoIg4ibkzL0pJodLv0jn3iwFciqHuvF/GdV3CvuQYdVv+LV1rX3n1APFEHBGs7/nzcJF+DUNeeN0AzMUGnsBcKmb5WLtsWZuHdr+QkVPeyZjPM2pN+X7zTE2mTO11p2DR3079F06oQIvotRdeVGmWsT+iCNI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 21:06:01 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 21:06:01 +0000
Message-ID: <acb5ea13-9695-4158-9152-aff761401be3@oracle.com>
Date: Mon, 14 Oct 2024 16:05:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function
 vhost_workers_free()
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-4-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241004015937.2286459-4-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:610:4e::33) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfed125-6622-4b7f-03a1-08dcec9401ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkN0RjcwU3hFUUp2cm9GZGRsMFhGeXRtdGFZQXVLZWhaMDZWNGV5Sk1lOUc3?=
 =?utf-8?B?anFzSmxMNFRUQi80UVhSNW5jYTZSQU1udGoyaWgyRmhBZVRSVVZVTW1oeUZx?=
 =?utf-8?B?dGZhMEo3TEc1U3lyVlFmR2tXMXJoTzRGOUtKMUJXcTBiaUtocHc2RkNwTHds?=
 =?utf-8?B?aUV3azgrYkxMTnFkYVZuM0FCQXlwK0ZHMHpxRFNwY1BJRGU2U3NEMVdVR0d1?=
 =?utf-8?B?MzdvYVM4UnV5amRiYkFuUHppY0N5dlA4b3lMSjdKeHZxYlhrSytMb2YvZ1VT?=
 =?utf-8?B?aHdKdS8rQyt0UW96UmdYNm5Vbmp6RlpEU09Kb0pySlY0Q283NGNjRnVqaUxS?=
 =?utf-8?B?d2ErdzVpc2Q0d1o0Mk1JZnVMV2pIREpkU3FOU25qTnc0VWxMUGJrV2Y2akMz?=
 =?utf-8?B?bnhpRUc0U2ZrNC9GM3Z0dnEzVnVDSklpZldWVnhaUUg5ZXdQMHp2Qm01VjZU?=
 =?utf-8?B?dTlXSE51RGJ3ZFhuckRpYVQ3UHVqaElMc042WXhUWlRFUUpxWDN4Z2NRbkdZ?=
 =?utf-8?B?Mk9BZVY0SUNjVHhkOENNemtYRFpZdGQweEVuMFZtdFYzWU5WNXNBNFFDMFlt?=
 =?utf-8?B?ZEFTNysvakFTU0paYUxQMVhTWHYvUzgySjR2NjFzTUdWbHVPT1ljUmRxYjFN?=
 =?utf-8?B?bHcwQjNONm1vZzg4b05ybTFQaVRhK3pTQVVQaFZtSFpJUzVGTHZkL0tVWmhQ?=
 =?utf-8?B?WlBKWFRsVGhQdzN0eTdmTW9RLzVpMmd1TUZIdHRZaXYyT0YzaHE1TFJUK2Q1?=
 =?utf-8?B?NGJOaUtQazIrUVVGb3pONjNoY282bUxnUU5lY09OekUrcUlxSzdxbGpEVzln?=
 =?utf-8?B?N09PemNqaklHK093YWtSKzhxdis1TkN2Skc4OEI2SE9VWitoc2g2c2pkbC9P?=
 =?utf-8?B?TTRvZk9EejVITHpnSnIzNFpsSzJyQTN2OUFlM1VGMmNPa0VZNDZaWmh0cE1m?=
 =?utf-8?B?RWxmTVlvdDRRZHoyM05LK203WVJZVjRha09oVkdCN3U4aGh6TzJvWnlvM1c5?=
 =?utf-8?B?b3BMQ2VCOC9HWDhxOTBXbjVjMS9zQXpFUmhFZFk3MWNvNWVQb0ZOMExnNStv?=
 =?utf-8?B?VjA5VEs1TG1Iemo3bXlVS25IMkw1N0ZGbk9UNjFpS3k4WnRxM2dHRlZqWmlP?=
 =?utf-8?B?UzRJR2YvQTRrdmdyYkRGRWlLSUtxczZRVDhIWXVTcVA0eU5mKzA3cC80T1hP?=
 =?utf-8?B?R1FJRnVsdUI2bEZhOFRuN0NRMC9HVzVHTGh5V0xKeFZEKzY5anRMbjZ5N1Ns?=
 =?utf-8?B?SndSWjYrN2huQ2dQMEM1RHp3cDhpSHJockZUTnFSdjJsU0ZJTjZoTnowbnhM?=
 =?utf-8?B?T0FZTzQzWFJtMTNabDFlcGJiazJlaFZrNUMxT2p6T21CNmFIcE9wNldVZjh3?=
 =?utf-8?B?NmFCNDZJM0JBb0x3OGpwUEc5eUE2WWlLMTVjd0RURCtZaGdWUC9FNVFLazBp?=
 =?utf-8?B?THVuMVRnSUZhZnFERXhnM291WEtLN3p0cml5bzRHVmc4ekUyU0NGMkdyUnlq?=
 =?utf-8?B?YnBoSTZDb1FGT1RDWGF0cTlTd0wzR0JlaXhIQnFOQWNVSWYvbzNqN0NJOWU5?=
 =?utf-8?B?U0dMKzRPL1lZM05tKzlVdFJ1b2pzM1UrTkNXVTdkWklkYXRsK0lpQU91RjFZ?=
 =?utf-8?B?N09VZmRCaUI4SFFMV1Q4RGt0amRuTGMrNU5ETGdLUXkxZnRoSXJ5RnFMVW1K?=
 =?utf-8?B?K21aVlA1YXNkVEdPWnJoeE1IdE5ORk0wTDF0SG00bHllUGtabW1TVll3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjhCODEzZDBVcVloWkxLSTF2YzlyNUhlbTVQOEErUlFudVg2TkN5VWdkdkMy?=
 =?utf-8?B?ZHpLa2JYN3dvVlBLT3ptUHN3Y0I0YlI4MjQ2MSs1WDVCQmhlMnNicUVzTEhq?=
 =?utf-8?B?Yy9WeFVUcjhROExXa2dEc3JER0c4V0JveTlGV2s0WlZ0bmdQb3VjYjlONEhS?=
 =?utf-8?B?V3paclUxcXNDMG5EdkVSTmNDdmt0dmNMWEFsR2I5TWJsZU5vY1lmUVZWYTlt?=
 =?utf-8?B?aCtiT0E2QSsyRjdaRlErWmdsb0dWVGNkcERXQnVMSVBtK042MGcvbWt6MmYw?=
 =?utf-8?B?ejJENEtUS1B0L0htYWJEMUhKcXBlS2tVeExKMm1PbEczL1JuczlwRU83elJo?=
 =?utf-8?B?cVluaUJYcm1BNGNYb05OYm9VNFpMdWFVQkFXQW9vMHUzbS9ZOE1LaXJ5M2la?=
 =?utf-8?B?UjBGSnNlZVV6YW53Z04xZzlVNDZPMzRKRlVocGNCWi9XRFBPZkdpTGpXelBK?=
 =?utf-8?B?aHE4VDdWbXBwTnVQUk9oL2xKcGZLOGI0K2NlbUh4TGNOZ0FWYjVlNnNyM0xF?=
 =?utf-8?B?enpxQVNadWhOYWc0SjJtcmg4ZzZnMk9wR0pBY2Q2NEZWaktTZGlYWFBKQW9I?=
 =?utf-8?B?KzBwOEU1ZyszQVdqbkRuZVVyeXZlczZrRFplWGtQdi9QNE1uK3FIR2RkZWRI?=
 =?utf-8?B?R2paRHlRd21SRDdydFJtVkJJbVdHUW4vRlpTSktxRG1KdXJ0MXNyRlZDblRT?=
 =?utf-8?B?aENTMUZTMTc5RTJNQ1UxdkVaV3NPUlNpS2t4S2RoanVWTkJpeVVFMnF5Q0Yy?=
 =?utf-8?B?K2JWaTM0YnUyM2llSXhDamZwOFZNWWc4SXFSQmtCTnRLekdjbDJwNWZnRzg1?=
 =?utf-8?B?anpwWEcvRXZuMjdqQjBoNDZxdWRzeEc1S254bTVuTWxVV0dJWXM5YWc1cmxl?=
 =?utf-8?B?TkFvZ09ObE1ZZ3FCejhmOHM1dnFQcFRLNzBJRUdMRWM4Yk5MT1lyNnczZW5k?=
 =?utf-8?B?WXJrcW9CNEN5VXJtQmlTS0YrUVR0RXNvaXFXNUxjUDlaSGJHejc1UURRVjQ4?=
 =?utf-8?B?OXRDb0c3UFIwSlRJMGhrY3VvbnUyY2tTaEVLUXVGMUcvYmhwaTZwNmJ3Z1pj?=
 =?utf-8?B?YndvMUMxVkFHMVVIOCtPRHJxeVhyR3VjNktRTk5FZEw2OWl1NzVkcEJKZG1N?=
 =?utf-8?B?SUJ3SzBmdldUdmIzcmcrSGcwaldCY3pvc2RBOWMxbDhmZUZYM2R3eFBOeDVv?=
 =?utf-8?B?SVljUUVtT2o4NUtOd3ZNalFwWjZVQ1ZIVXJEdVljWXU1WU85bHk3Y3JjY0Zw?=
 =?utf-8?B?TW1ZRWlqeTRCMXA4TnQrdTNzWGd3QUtLNERiaEtYS1BaRlMyUSswWXlGN252?=
 =?utf-8?B?Sk1reFNQM1pXLy9BR3VJbnRvb1VERE5IbzdKVVlmR2M4UzFQSGRRdjZWWmY2?=
 =?utf-8?B?Nzlac2hIbFYzRjNZWGp4UHl0QXJLTU5BMTR2OCszSE1sNmFScnRzeWhBNkIy?=
 =?utf-8?B?OFFuSWhURHVvZGNUaHBZMFFMTy80S3JIVDhFMkV3U1F4eG9FR3dpWWZ0VWNn?=
 =?utf-8?B?YTFIZXM1UFZ1bzZKamxISzBjZTNoVDF2YTkyNDlmd1JVWHRHMjl2V3ZZQ0VN?=
 =?utf-8?B?bmVmbkZsell5QW5zOEpRQ0lMWmxhYTFpaXRwWFZSYnZqUE5pZG1iMlJtY3ZE?=
 =?utf-8?B?R3U4aTMzZU5aeGwybXFSMTVtb0lnTHAxc3RjUkFza2lDSnlYektrQ2tZNjYx?=
 =?utf-8?B?cDRoUHFLdjVoc3U5cHV5Zk5xZ09vaUVMWE5ENjV6UnRrcXZackVXZWx1Y1kv?=
 =?utf-8?B?NXl3YjdJa1d3a3lpdmd0T2pSb21zTTRMc2Zaam4vZ2VHOFdIM0o1d1FDZHF6?=
 =?utf-8?B?OU9aanc5WEkxdFFaZmp3eG1oMHlCYzE3REFKbmRnWFkxTkNXQlpqWlFLSVFN?=
 =?utf-8?B?ZGx3UysvcW8vYU9uZ1FHQzloVUY2U3dzWTJTSG1pM1RmbUNHQUdqQW5ReFRm?=
 =?utf-8?B?cXpKTE9VWkozRE1CL3BLVmVOYWtOSlh4dDNObWFQT0RNR1BRbitzWkk2T1lF?=
 =?utf-8?B?bExiKytCT2c4TjhiM1NZOUNJZGJ2dHpYTkpLWWZ4QWpJTjlJVmUxeGxyOHZ1?=
 =?utf-8?B?MnZ3cXc2RFJaejNoelF1TURkV25aUCtCMGVuc1NlOEhPWWgwQ3pEUjFPT0U3?=
 =?utf-8?B?bmNTdEc4QXNiMjUyV3JydjR5b2JEV05BUTVMb2dFOWE3aytqTmhrUkh1WUd5?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TN3Dq0pru1E4wtpOU8zZpaVrb6L2ZY/S28dZrrkPJgLKBtim+j347mAq/pUVNeSGiqcaDlNvNbJ04xVGuuX7VZwaWDW7OujgrVaauhXabwQEj6r3xqSTLYFWGmuuZxD37iSrVfiCOrctLnqf4bEqj0HsEzzs9a9wnKPUsijPM2xmHysw3VpA4Cx/IL/Xy9b8p7UU84uS1BpqECY/PMWYHOdWtB5MV3lnJO7O21tQWSL8xdtzKdNNl2DZ197W7Ms6Ky3jEW23Iy3fc6uA0Mgnu+efHgPIS8kq36bVDAMT3s3h8ke+oTWVWsiCAaQ+xScNKvYO3xEv+dahihYYfzmQ2KjDymqQueCtJUZxRznYkf8PggVEMXgZwpHkVwrnFB8xb3SUjlr5WYpENxY1ecmVp8/dxEXPKS71boRZULkK9XI9iH+lrSmYsU53Kevo1BdvQu+Y23htNLpcr/iAK9zlwYdOzykHESeIweVLfLxTB1W8RPT/7qqvO0T+smU0l6dVVEX+GCLKCnsqTKMJEnqFHzGGqbvZaErlA9SxxWZN9BstWN/c6eF7Ft/najh+02ApkDEf1U1HonebYURJsDG8/uNnhzCke04clUb2ToHCWwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfed125-6622-4b7f-03a1-08dcec9401ea
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 21:06:01.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3bVlORmt0kEPlUA6osZQlrWox3ZfCfiJ3QcJluTx9GaHpZxWMYsWw0a+H8POouUG6qu9Ysx5YoOjWAH9lm8alz/DZ9n0u4GlJaT+s9l2Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=983 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140149
X-Proofpoint-GUID: L9a-LvcNJq_P2tN_xWz_ShNLmXmfMgXn
X-Proofpoint-ORIG-GUID: L9a-LvcNJq_P2tN_xWz_ShNLmXmfMgXn

On 10/3/24 8:58 PM, Cindy Lu wrote:
> +static void vhost_workers_free(struct vhost_dev *dev)
> +{
> +	if (enforce_inherit_owner)
> +		vhost_workers_free_task(dev);
> +	else
> +		vhost_workers_free_kthread(dev);
> +}

With patch 7, userspace could change enforce_inherit_owner after
we created thread and we would call the wrong function above.
