Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BF15575E
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946614; cv=fail; b=fwKcpB/O6OCrAUb3D5NZEVhGO5sZW5VgdLmZmIqSOL/eZJTR541/7/EduFSAFGHyazInVX79KxcKHB83uagyaIlY1lHvRSIKB8Q/SlzkXEwuvmikDLB6kSz1XL8JJnZkcYwqPHUKGPPgoSD1ua3O42/bGMvoJxIvGcPBXi+/ZxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946614; c=relaxed/simple;
	bh=I1Ivrgl6/jBAc6qhXTGbzLyW/TTG3pKFbk5npcNWLPg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jJjPSFA8LRYIxThvmuOz3IJtOOJVe9hSCA9cdFh9XCrB4CHrwxM4PUu7Y0rKCGXhw9yxDcMm9gQVmx7VrKPKdBUD/5NnwhSdWwToFLEVi7IvaG3ThnYzK2NiMEGCzQgOEnxhFrFjaq4sdU5yfUVjuj1Xzc/jc00Fh+z/WbHscnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cz7F1X2h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HLsNWVso; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cz7F1X2h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HLsNWVso"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 121FB402E5
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 22:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVcSB35OFWjd for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 22:56:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8DFBF40287
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DFBF40287
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=Cz7F1X2h;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=HLsNWVso
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8DFBF40287
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 22:56:50 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ELMgXa000505;
	Mon, 14 Oct 2024 22:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YGm7jJZ9hzQnX7DwxXBx+28GJ/oyWf2OVb4C+Tl4JQM=; b=
	Cz7F1X2hdVzT1nHhLhTRfFWcchoOMKJ67F2SPkx/Saw/8r4wP1Is/A2sM4jeGryq
	fi7h3CqxHF8mxOk9qtsJKCw+apTaFfxnfoHrJi58Y85MbP0LMvhzKGWwohUzS1cK
	/9X7WJruEeKkgtq8TlZxIolLj/WFYCOHDFOJf2CKbI/OdhjYVN0ivxrca57A9mzl
	ZpIgUqJSexD8ggx0ZsMAISXz6gXqwkau3i93fpbu8HZlPtBi1PqOKVwtiSI4BA19
	+ycPtHU4qhkcdzvxmB7npBVAF+2wsxU/75O1PYG+9UkG85s75HCuWHEmhIfmOOLt
	57YsYf4zMA6y+4GkNQv1HQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1afbnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 22:56:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EMFCnf013886;
	Mon, 14 Oct 2024 22:56:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6nth9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 22:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4qB2mYdcDIFmElzNx8VvQR0XsEeJRlD4rzOAf3ToztAlPizT5GCQzHq0f1QgL84dkHI7dSk2TO9P0DLcV+E/NFDBiI9RG34etPfDCWsbKD5Raq9H0Y+4qZCHXrdHBQECLigcXo480cdehjz51Hiy+5TfblWFJTtbXxii2LtuEW68uGlzsgVdrJGCZGVYqbaAAx92HVjZFlrd/1lVa/dqAheyAbiIykinB7Jdy7hDsgjNC+VGUtyEpoSazApWSnk+vjbehFbxtIFQWlpqhvJOV7jKppN4qtBwLtVwwZlCmvwf3WhGGUeu9zYz0BF8XUBpdZbojIRVPG+MXRwKBStzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGm7jJZ9hzQnX7DwxXBx+28GJ/oyWf2OVb4C+Tl4JQM=;
 b=Tl9wn11+wt7PO/3fBgtPRWsdKc1/QNdu9l6m+mSneR/KjiuqdFbzSFWYrl2iPVkhuvhXWbvVJ/NIlAoAchTsPrMG2jhQrHCE4j3NLgOF7Tx6tszmgU/QhLsQ1rLgiph+PpBLQjdLBTAlF6mNSxQ41I0uTwPumMHPY1LTkvXQTTzJKDqtkeJ3YFCcY5BMHOVhgahO+mEZacCiCFkRNrG7OiQOltHsMhJPGYMM/WgC0vR0GnWL5AfdTTsX+zLmRUXGF1fdD9Jv47dwaIcLTacGhSQtq3Nv7Xb8wpxt6KI1kZDMdxffmo4vRSUpjTFNtmuAeqaW48Ybn+xuxTO983MDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGm7jJZ9hzQnX7DwxXBx+28GJ/oyWf2OVb4C+Tl4JQM=;
 b=HLsNWVsoAxGgdyz1HdqYijRya2tiF3UdaAuMn9KKd02rXGek8JJ5hftSErmk7sq71uDhGOubsZGqd7Rfmrd4wGUossgZ0hZnU1nO1ZIwnAM1OAqd1jg3+OvAPWdz8Inrk4ZpYrpU3Y8ayY8c60KTKeU3wkIDyfMMP49Jm/XrKIE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 22:56:46 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 22:56:46 +0000
Message-ID: <dd03e6d2-54e6-487c-8aa8-8a760213a42a@oracle.com>
Date: Mon, 14 Oct 2024 17:56:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] vhost: Add the vhost_worker to support kthread
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-5-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241004015937.2286459-5-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:610:53::15) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ac5d6b-192c-4993-de4e-08dceca37ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpzTHdnVmRWNlYySzZab3hQRWZVU1FNNkJDSVlhZzhvRXcveXZ1TGNReGdE?=
 =?utf-8?B?MTZWU1VxOWFxNHBUQ3JPWXI4V1ArRHB4WEphdnRnWW1CVXVTaS9ESWFxK0E3?=
 =?utf-8?B?YlhSaDRpSjVGdzMyWjZoMXJrbDVWaUlnZlFRZFk1dkJQMWFCNlNISDhUOERs?=
 =?utf-8?B?VkM1TTRHclBCVkFLMFhVQVRZUk9zbTNMVVlEWEVCaUluOUdSVDhjaVNhZkFN?=
 =?utf-8?B?VHgwQjlpNEp3dnBUbmVBWEJRdWFkZXlWVFhhcjRkV1BUL2d1VksrT2JvTW80?=
 =?utf-8?B?cXBHcEhsbmZrN092Q2h5Y0hmVExURlVWM24wYkg5NlR6aVRiS1VtaDl4ZllJ?=
 =?utf-8?B?bWIzcmh1VWtXa0tncTZsMjA5MmFKMWpDSmxFeUwxQlhHeU5xUy82Umx6eGlz?=
 =?utf-8?B?NjVSNU1CclFFTkQ4bjhDU0lzditwUkI5R0VxSUNJclFQRjRZd2JycEk2dmdE?=
 =?utf-8?B?RWZMZnhqSGJpQ2JuNEJJakZXQ0ltVkFXYlMyOWYzSFZTK1VmL25tVE9tckpr?=
 =?utf-8?B?WEREM3pZbG0xbUdtS2I3d1ZQTE5CNk5oYTNJWVlTZkQ2eEJmbUtHSXVXNHEy?=
 =?utf-8?B?ZnpjTi8wakpzV3Q1Smp6OHZXdGpxMEtLVjJIeVBzdFN2Qi93S1JnTjRJbjBk?=
 =?utf-8?B?bkROU3BDMnByMndYelBWcVFOa2QzK1U0b1JpMUlvRmpIU0prT2hVYWs3bFpw?=
 =?utf-8?B?WEpGR2lQaUkrTjE3SGxaby9ZUEwxeHFyQ0lET01GQ0xmS3B1UWM5U3p5ZkEy?=
 =?utf-8?B?OGJROGxtZVlSOTRja3luRHVkckZkQXdRaFZsVTNRNXVHQWNOZm5udlM5TU5Z?=
 =?utf-8?B?ZDk5Zmc3bFFlZjdIb2Y4TVdKVmdGeFhrQm96d0FxZ2pHdFVVbnBUSGxuOUZu?=
 =?utf-8?B?c2p4UzN5MEFmTU1HSTJacDlFK3FtYko2Tkw2ajkxZDJnNU1leHp6SEpuRmZh?=
 =?utf-8?B?QjgwakFRL0VUbWd0MlE5RGV6UW5ZajhVMXd3MzUvZlYvcUFVV2Z2N2ZjdTFI?=
 =?utf-8?B?MnJaU2VHUUVIQ1BIZ3dVMXNQTlhpQTNQSjRENUJ1Q0JoZDdxQXFVT0o5Zkdt?=
 =?utf-8?B?cXpTRDFUQi9RNm4xeGJEdTJGYktvM21LS0hIOENxaSt5ZGk2MEoxL000SDA0?=
 =?utf-8?B?WHdJWHZLKy9XNlZsVmVPVTlEbmtZcGFRU2o1YjkxSnVyK3R2SDFwdUxoaDdJ?=
 =?utf-8?B?OE1jaTg5MEhJTldHbzB0TzhxT0pMK2dyQlpvcDhqS3R1V0NIbks1b3RZN3RK?=
 =?utf-8?B?dkRadHJyS05MM0wxWE0zaEhjcWlVdnZORzlUbXl6ZTJCOEdPT2JVV0pmWld2?=
 =?utf-8?B?c3N2WExVZVFxVXRSQnBzYkhLVERKVXhjVlIwUDN1NTJ1dmZGSXFVQVRwS3hB?=
 =?utf-8?B?K2RjVDlpWXBJZ3pJQjNocEZLbWlrK1JhdGMxdUZGZmtBbTdNZnY3bXEvc2R4?=
 =?utf-8?B?M3AwcVNCMUR0c0pRcGtwcG1zOWJ1VUpRUGdCNmh5K2l2ckhxa1l2RFliWVRp?=
 =?utf-8?B?ZDI4akNIRGw3YzF5dC9VTU1WT1VGaWVNTGxISzJMQjN4ZkZUMEVZLzgxS005?=
 =?utf-8?B?YVBBcXoyVjhCdWJPaEZWVXA2VHlIT3ppR1VwWE9jelVwRUc1eE1rN3RlNmpY?=
 =?utf-8?B?akxTSEpTaU1lVVZHM05oWFl4WU9Sc0RZMXY2L25KeXNodW1WQ1l5YjMyOGE5?=
 =?utf-8?B?UXBJMzFPMTVKdjNObUtzODErT2EwZ25hUTJ5YmRQdE5VRng4aVBWMy9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFzdFFBdmxub21oeFF5em1tY09JZEJtenZIVnBrRGVCa1dhNVpPWHA2QldK?=
 =?utf-8?B?ZFd0MUtyT2lLZys5Ykpka0lzR2E4WUcwZy8yYS9pc3Q3QjA5Qm9zNHNFS2xr?=
 =?utf-8?B?WTRrdzdDYy9zM3ZYWTNUQ0Q2RWYyeDkybEQ3cWtrSFlWbHREdFRmU3dZTm9z?=
 =?utf-8?B?TWp4LzJ2bW1VeldtUlR5TGhqazJVSUt1bldIbytQYklNM3dvMWxnYWFGK053?=
 =?utf-8?B?Q0pXOEhKbW5pNDV4cVpYNVZqSTUyeTNkNXJBQVBqL2c1UU1SWm94eGxhc2or?=
 =?utf-8?B?eCtrMVprTEhWczdYMHVmM0FHUUFlM1dadWtUQnIrTDQyMEs0WXh2bzV6czl0?=
 =?utf-8?B?S3RtaS9peFJpOGdZTk0zZ0MrQXhYVUwwU1NDbCtrU0Q1d0dwRHYySkZid0hl?=
 =?utf-8?B?MHVSQnovZEF0RFdRcnhsYVc2WVdDa0hLQWYyUVN4Q21mK2xlT2tRZXgzNWla?=
 =?utf-8?B?MmU3UlBwS2tXRnhhOXFRNVI0OU55ZXp6L3BqMElMQmhackRKUGpJdFhSVkk0?=
 =?utf-8?B?MThTSk55aG12SzBzeHByUlVEa1lwRHFrS0tURnRlT0d0RE1TUEpmMEtwRzhF?=
 =?utf-8?B?QXd4NjFraHhUc3FDbGxEQy9sdEJVRFFJa2lDR3FIcWNlWmdSWEdPcFlIVkla?=
 =?utf-8?B?TVU3NDRxYWU0bitJUjRIdk5uT1JnTjNpK3dWc0N0MXJoVk9tQWY0V1hoeCt5?=
 =?utf-8?B?ckY4UUdvdkZDSnYrTjVpZWV4d0VvWVpXQWg0SUVGcmZXb2lmNU1tUVNsSG5u?=
 =?utf-8?B?eEZKcWZaQzFrUlBhaTZIb2E5cHJvcmxHKzZqOXQvblBpT0VXeENSb0NycStV?=
 =?utf-8?B?Sm9CZ3dodEVqZ1pnTnpKSm1UNkNmUmxGeUhuUTVPQzJwMjNSdENvc2NQMmQ2?=
 =?utf-8?B?RE8ydUwvcTBzNzZTc2hHR2h4REkrZEdXWUgxTEJUaHRlU1JBSWdZOG9FNWt0?=
 =?utf-8?B?eGVPSlZVbTNBZXRIM3JHL01RZmpXc3hidDQydlNwbW5POFdzc0R6ZW0zbXBi?=
 =?utf-8?B?VnR1bEpsVVhBY2IvVFZHdUtzTXlOVUNOMU53dVlPUWdyVU10OEdYWDJGelcx?=
 =?utf-8?B?ZFRCT1k5QUJkZnlidVo5eEc4YXhZVVZuMWJYdHZTWEhCRGpMT2lHamZNZCtQ?=
 =?utf-8?B?NFl3ZzBjV0dQbjZJRHYwR2E5NjJWdUcrSG9zQ28wTFBFUEM0RkhYS3F6S2Q1?=
 =?utf-8?B?aGk2ZncvMVhBR2VkSkZQT0MzMUxNSXErTkdQTWljRjFkZlFvR0R6TXQ3U2xa?=
 =?utf-8?B?cU1ncHhHU0xNVDJyMVV4VUhDd25vdXV5aHJhNUhwQ3RqdmZ2SW5VczFUMTBB?=
 =?utf-8?B?NURLNFdCYk9kYmI3Q2tRTnEydGxKbEdnbE9Zc1VlNW5samVMcDNUb1RaVzc1?=
 =?utf-8?B?KzdDY0JMb3NMN3l1TGNGVGJmc3g0c1l0aS9NRVFjdDF2RW0zczFOSGd5MEdW?=
 =?utf-8?B?U1VPRUFCRXhuUDdDdUtYbXFxek9Cb05uT1RLdUs3ZGVDbFRUUzFwNklQNE9x?=
 =?utf-8?B?eExsNklHdWdFYWNvNkJvaHRMbGFJNVluV080WXNPUEVtV2JPYkxBcDE4TlFl?=
 =?utf-8?B?eWxpMmRKTkFCRE5tdWxSdzltM0VyWGVRc20wb0ZBUHFuWG53ZloyN2hoQ0Rp?=
 =?utf-8?B?bkxLMS9LVElXSXRLcGhYNDN0NE45RUp3V0UzQzE5bmxoeG5tOEUwMUszbFJz?=
 =?utf-8?B?MlpISVZDcUd6TnJwemZlblNndC9qZ0g1dktWbis1UVIzN1I0cjl6Y1JLQ09m?=
 =?utf-8?B?U3hkMmJoSm5iSlhQTjRySmVNbHNnZzIwKzM2cEF6d29DUDNLUHNUV3ZJOTVO?=
 =?utf-8?B?V1YzbVV6VXhFdkVKVDNrRWFvWFc1SC9BNXd3dE1oSktGSlRhQWxtZCtDVzR4?=
 =?utf-8?B?K1pOakJ2QnVOTTlvMmFuTm55MWtjckdjZk9hWkR5dUtpMjA0bVovVHpBUTVq?=
 =?utf-8?B?KyticnlMZ2pXd0V5TVpZUUg3K2tGRTkzTWRUcWd4Ni8vd3VGUmVsd0RSUWlx?=
 =?utf-8?B?amdzTVNoTzBROUhhNDNyUGV3cmFpZzIyNmJYblU2cEFkWGxSem8zUjU4cVdp?=
 =?utf-8?B?RXlOREc4Yit4TW1CUG9aOE5FSVR0S3VkdTdXR3AvNS92Zks0M0ROdGp5NnVS?=
 =?utf-8?B?cEpuTmN4UGlQQldzMEUvUFp6dytiaEdrOEtFOERRaFp1WTNPRmR6NTR4THU5?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eYR5VXCsCHYGSQPrlPSkVLrLrZ4dOx0wzHY2XupB9+ZC2U+A6FtQbA/Ddg14JNfyHlLh7Vj+v1peprcymcu+8RYmKaoM+BGQYNb1Fb4f4PD426NIL7mDGuSeEki4d6BIik71bVHOhXAyMlUbfSLJjp3mwsmfMWWqwD/KdjoSzcQAjzXd40ataXhY50laqbGEITT8qw3nP1QK1o1NNYdo1jiiNBKV8bETorUNQr4uE5QMeMgCA1pJqvBpEqEmwJZYuTCRF+y61nGzYU0AVTq5G5fT5HaYZGERhLNG4/GLAb5DI3HSECBsdl7kwZA3VYUdAHnT0tKh6s03Aqqus/orZbsxwij1Uo1n9Kf6W/p8ZhcZ9zX0UWz5FoNG+2OpIQgaJgNiu8gAcD+Eh49UGVnKpQlfsQGo4HlC4VxElyniwPeFmQ0qgMYaOm/ac53hzMACl2PHTSP7aK8DnpUKV4erWyCtz4MZy793TPho5mGXtxLW6ZBJizhXwRHlkBFU94T9PlztYtGBxOEr9f/F3T2fTHJtW9EGvtptMtRwbd0WKqJBTrXbbvZXhUELuO8t2iTn1gtqzFCP7lE5+Yz7d0ybaBxujTpuhcGpylmLIi+9Obc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ac5d6b-192c-4993-de4e-08dceca37ae3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 22:56:46.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpDhvyE5mYPoayj7NAgHgOF03tqHUZOISORZCIkCpk3GlM3vI+qoe/e/nzeLj0JI8NqO+XpyQXqFNuVXNCwFYpef6nSwh095bJAcLpbBcYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_17,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140163
X-Proofpoint-GUID: NnmwyP1R2Ec0-pebKoHCSHVtqvGCkAx2
X-Proofpoint-ORIG-GUID: NnmwyP1R2Ec0-pebKoHCSHVtqvGCkAx2

On 10/3/24 8:58 PM, Cindy Lu wrote:
> Add back the previously removed vhost_worker function to support the kthread
> and rename it vhost_run_work_kthread_list.
> 
> The old function vhost_worker was change to support task in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> change to xarray in
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fed6671c1ffb..349499139f4f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -418,6 +418,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  	__vhost_vq_meta_reset(vq);
>  }
>  
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +	struct vhost_worker *worker = data;
> +	struct vhost_work *work, *work_next;
> +	struct vhost_dev *dev = worker->dev;
> +	struct llist_node *node;
> +
> +	kthread_use_mm(dev->mm);
> +
> +	for (;;) {
> +		/* mb paired w/ kthread_stop */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (kthread_should_stop()) {
> +			__set_current_state(TASK_RUNNING);
> +			break;
> +		}
> +		node = llist_del_all(&worker->work_list);
> +		if (!node)
> +			schedule();
> +
> +		node = llist_reverse_order(node);
> +		/* make sure flag is seen after deletion */
> +		smp_wmb();
> +		llist_for_each_entry_safe(work, work_next, node, node) {
> +			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +			__set_current_state(TASK_RUNNING);
> +			kcov_remote_start_common(worker->kcov_handle);
> +			work->fn(work);
> +			kcov_remote_stop();
> +			cond_resched();
> +		}
> +	}
> +	kthread_unuse_mm(dev->mm);
> +
> +	return 0;
> +}
I think there is a lot of unneeded code duplication where in the functions
you are adding there's only 1-3 lines different. To fix this I think we
could:


1. Go really invasive and modify copy_process and its helpers so they take
a task_struct instead of using "current". We can then just pass in "current"
or kthreadd. We can then use most of the existing vhost code. We just
need a per vhost_worker check/field for the mm and cgroup use like:

vhost_task_fn():
{
...
	/* The mm would be passed in during creation for the kthread case */
	if (vtsk->mm)
		kthread_use_mm(vtsk->mm);

Or

2. Go hacky and in the vhost code, when we get a VHOST_SET_OWNER call create
a tmp kthread. The tmp kthread would then call the existing vhost_worker_create
function. The resulting vhost_task would inherit the kthreadd settings like we
want. We then just need a per vhost_worker check/field for the mm and cgroup use
like above.

Or

3. There doesn't seem to be a lot of differences in the functions you are
adding. In the function above the only differences are the mm calls and kthread
should stop. In the destroy functions it's kthread_stop. In the queue function its
wake_up_process. In create its kthread_create, stop and the cgroup functions.

I think we could add just some callouts on the vhost_task or vhost_worker for stop,
wakeup and use mm. For create we would do something like

vhost_worker_create()
....
	worker = kzalloc();

	if (inherit from caller) {
		worker->stop = vhost_task_stop;
		worker->wakeup = vhost_task_wakeup;

		worker->vtsk = vhost_task_create();
	} else {
		worker->stop = vhost_kthread_stop;
		worker->wakeup = vhost_kthread_wakeup;

		worker->tsk = kthread->create();
		vhost_kthread_setup_cgroups();
	}
...
}

vhost_worker_destroy()
{
        if (!worker)
                return;

        WARN_ON(!llist_empty(&worker->work_list));
        xa_erase(&dev->worker_xa, worker->id);
        worker->stop(worker);
        kfree(worker);
}


