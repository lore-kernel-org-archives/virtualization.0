Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F41288AD
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550598; cv=fail; b=f5wx6838CuuKzXH5xKt+pQqOrGTn3ZoxbGclrAP0dRlx3DMnyTsvdg7AfvvFacU9oJp7aOMe1cpWSaReMUYUQJW+wjIASzGVgp001bH8kHuCToQxkzb02eBgM5YBgmXbZ99MlMOxKa/kq9Ub9eW1qHqWQTmZA/upCj2yXa3ScWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550598; c=relaxed/simple;
	bh=LZh2xDiFC9mubW9ODA9jRX08aLzH88vOvC9H3RMKF1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zq4h1bnuOjeybi15K8BYZHH/zTZabMiJdKwIOAxlzbGrz7rVI87RVLpiSl6/h18ngU0g2522h8kBHz/CyDzZms1xr+IDnbkSf8TLn6rlFp8/Jeb/7zzsCyYccn44GvDk9XS3iP6xodNLA88ZGJRstyFLQ5aLBZPW/mD+ZjCl6aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D9ewUoHo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=to4C/hAZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D9ewUoHo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="to4C/hAZ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563DZ5HC027080;
	Thu, 3 Jul 2025 13:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m9oPmUhWVyy8U1qaman8z2HIquP2d+dcNOsl423wxJM=; b=
	D9ewUoHoU33Koy6XU/RiPB+EotyEM2XNLOVUW/+tKia8QyY1bJS/L4PJtn3lsN6X
	VpP1IKH/mANokRNlVJW71eA/bfA6CdPHEptTqr0hPbAakV7LOxXlcHnez/1NrCgT
	qYihuF3ppEai40evc3zdD2kGHAHamjOW5qhf/ozL5cTbd3M4NkCcr9ocqLc6ZYNy
	s4qEMWQq5872rimkdpI7MwZf5u4kDxdEdftYbrQPabQzhuhkz9hjaA7IYgYrEkIY
	Yic9hfGme6vHyG/xxu7+NdmKePPE2ICAkTyWwFqeMZerBh4Z6p6rLjsjRfOH0m1Q
	dC/mRt5GW2hOqo+XOECFUw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx920n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 13:49:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563DbEt1030084;
	Thu, 3 Jul 2025 13:49:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ucngq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 13:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDt38Q4WALfhhAuQgK1WYnASmQa5lGVoyWjAeDuefUydgVDhqbNqsAMlJhighc38rC2giK/qlELJWU/HNhjka7A+xa0Sh8CiBYNKHka0iE49NxA/d6c/s5oalrXgvYX0kDph0iFRN8YoOweIKRK0sFxDqnYK8NbqPyeLF/RrInE3Vbhk6qmAk+qiPc9QpD9hUY8+bOB2tlqlyB2GyGrgyHZ5/1du3+sQsp36EGtAhKIGzo0SsqptuCJGW5DVy7C0Fh4ZCyeVmcQBpD8wSvFqt4+K+g7DGhEU2hY7RghIGB0DH9dwUbWV6eYiI3ka5ij201CLmbvdYQsaMIweuqg33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9oPmUhWVyy8U1qaman8z2HIquP2d+dcNOsl423wxJM=;
 b=OWJVUoj6ISF/b1VlERERhmVJCIizPIQtHzf903lflX/uYXOn/+8erdzjPYMeaouGs+IZXVG8PJewo0x96UA9xHgCqWvcSAYMJnFyS8hHvmzCOIZOVchZ2qv+AB7NhTsfo1Dwf5FlZmKyywQWg1b10hKw3pWYJw7N3ZwIgq8Zxn6+fpwrlNU+zveac6rnI2RJwWfq1hk/Wcxoi0Gi/fsqingzHNrHeusfYbx+haaHmHugI8Mt2gorpHddShGxn03p7vO+B7+rmSJCGFy+2hDQ09nrI233i1vZxDABi0QGTK0xiEsNXij5wSna3EscIOiUjbbMPxk/lV7gy1C0P8zfjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9oPmUhWVyy8U1qaman8z2HIquP2d+dcNOsl423wxJM=;
 b=to4C/hAZ1xb4RPclabkT97QpsFUKPFeHtmu0XggFUyVqbPX/corlcfo4hgawmUr4IkHXFBoKcWP/mPiItuC3NGbiNqx6oXraxy+mmnhxAibUvXoDA/wyZmMTLB0BPEygV4VkjkBpUVzq0bwjwsIhgV94DIZKoJGEU6nzwdmnnAc=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 3 Jul
 2025 13:49:47 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:49:46 +0000
Message-ID: <9c254fa8-7bb9-4484-8546-5f0a469619f9@oracle.com>
Date: Thu, 3 Jul 2025 09:49:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 19/19] virtio_ring: add in order support
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250616082518.10411-1-jasowang@redhat.com>
 <20250616082518.10411-20-jasowang@redhat.com>
 <20250701024602-mutt-send-email-mst@kernel.org>
 <CACGkMEuzTYPcDMamptLMQpSZu3gWxYx1Sr2nJef+pyuo2m35XQ@mail.gmail.com>
 <20250702064413-mutt-send-email-mst@kernel.org>
 <CACGkMEs0-FiRbUVTbtVyqPh=A8ufdW-Mh1XnR9hf8XQ7_Qf9sg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CACGkMEs0-FiRbUVTbtVyqPh=A8ufdW-Mh1XnR9hf8XQ7_Qf9sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MN2PR10MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a79b11-5162-41b6-d867-08ddba3878bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJrUWUxWVJHSmlncU56OE1Cc3FCVFMyWjIydEVialRCd1d0YWRHYWRBbCsr?=
 =?utf-8?B?WmhsMDl1K3FlZ25SMFI5YUtPOTBDMnJ4NytjZlBqZThFRm1uWno4eU51R1Ra?=
 =?utf-8?B?aktTQ2I2K3VPWDJKUVpjczN4RkVrR0RpbTIvNEQvR21YYnZGdVZxR0FUM1Zz?=
 =?utf-8?B?TkxqZlh6NmtOZ29ZOTQ3Nk0zUFBKUHF6clhuZ2g3VGUzVlcybysvMzRSSVRa?=
 =?utf-8?B?UTZiTVFsbDRNTGpNNVM2dHV6cWM5blpjZ0xNblp1OHBHUVd3OWw2WVZQQjcw?=
 =?utf-8?B?OUZIdXNaSWpUSGpqR1NpczdWRWpEWk1aaldMS01YUDFibGxBeVN0dVBVY0JG?=
 =?utf-8?B?Y0RKeTRwaktyR0wvOXh4WEhSSXF5eGdzK3JGQUJTRU05a0ZrQVVQdjkyUytn?=
 =?utf-8?B?MXkxQVMrS1o3d1RMblhyQklLL1lJNnZCZ0hrMGxiM1haZjYvOXM4OXZGVjJR?=
 =?utf-8?B?c0tpaXBMVXZTMzRFWjZpNTBzekk1bm9JRWNySHc1U2tXdUJsam5HVk56cisw?=
 =?utf-8?B?a1RNazhEVHRYSFJFdnNkL2lwWWVnZ3JqZnJudGxlQVRVR2pTOEtuVFA3SzFZ?=
 =?utf-8?B?VkZXQ1N4Wk5RblRXOXlDVGVoajVkbHViT1ljd1JUSDR2L1dGMEdDUUYvbjM0?=
 =?utf-8?B?YkZraVJpTFU1WG5FMHVzK0xmY2FuMkMxRXJndWNmY3E1emZGWThhR2tIRWV3?=
 =?utf-8?B?OGJzU0ZiL1ZxcmgwcEJhMFprSVkwK1NIRGNtTXJGMXZ3cjZ4R2VLa3dwTTRx?=
 =?utf-8?B?SFpTaEsrQlVJQzhKOC9TUmhBL0lkYSt3ZnZmbEViZ09UY0J5UjdQT0RqOWlT?=
 =?utf-8?B?bDhwNjJJcVZ2ZVM0eXlRNGR3Z0lGeUlhTkdrMlVqaElpcTBmWUFDbVJDMFhs?=
 =?utf-8?B?QTlQUDBvWjJkVDA5RkgzdzU5aG4xVTF3aHlwbGhjLzNrdm9oZE5VaHQyck5i?=
 =?utf-8?B?ZFhMRDdEdkV2aXl1WmNtRmlJMXVxQWpPNmJtUjBTeVB6WkdOSktCbHdVbUM4?=
 =?utf-8?B?UW5ySnlPbEFjZyswdjB5RlZOUVF0cUdNeXJZalE0NlRCQUpUYlRhZ1E3M0Nw?=
 =?utf-8?B?T3dmS2pWdEFyaGtVeGFNYmRLeXo3NHM3RENwM0JMMm01cnVRM3RDLzBmN3hM?=
 =?utf-8?B?d1U0Y0ZxMjU3dzFRUFVCYlgzN1UrT3cycnlFbllQVzMxbWZzY1U0d3FablJ4?=
 =?utf-8?B?WmsybGw5QjByTmdoNE5LZmI1bzZkRVVyVDlsWlBKS1FacXFuTkQwb0J5aUlE?=
 =?utf-8?B?bmVnVHdJaERiM2dzRDdqZ25aZlB3eXJod0lKSWI1aUREbmR5QzJMZ1UreVpE?=
 =?utf-8?B?WHN6OHZKUXhyOHdUZi9mSldBM3Q5QUVFbkdEZmduaHBiNUhtckF1QUY1aGU0?=
 =?utf-8?B?MmtkVUJRRGdhVzA5UDVncHNUeCthTnpFNXBzT1hpVjNOMDEycnliNGZZNE5O?=
 =?utf-8?B?ZndENVU3OHBHRG1oVEZCRGRXQWNFVDNPWmhqZDN2NmY4azF1RjBhdTErVnlt?=
 =?utf-8?B?eDdxUEpQekFuYnhGd0k5Q0NKSm1oNTdnZjNwQVI5c0o4YUMvVnRPUmZoNU85?=
 =?utf-8?B?WFZGSEdaRTRQWmtVK2NHVWdBSVY2bjE4MDhwaTlrcXRUM0NPZzJ6eWEyZThx?=
 =?utf-8?B?c0tyNlVWdUh5bERBbGY3YVl0REJYN3dnZytUUVRMeHdUYnA5Qk9OVWhybEE1?=
 =?utf-8?B?SzdyTTJiclRVb3o3MjNuVGdxV2RPNTNpSGNUSEFKblpFdW8wbFovRUdrUnlO?=
 =?utf-8?B?MXpXM0d3WERSV0hBLzVWaFFmYXJoaXBqekdOOFpGY1puaG5mR1ZvaHcxcUwx?=
 =?utf-8?B?ejJGQkxISFpLRHZjWk5XV0QrZTRUM3hRN0wzRzZHYi9qdEZIa0MrY282KzBQ?=
 =?utf-8?B?VHFJRzR0SmhJVUZnMEhob1cySkx1dzNmdm4ycVNtcmMxU0oxUlhXelNLSjdt?=
 =?utf-8?Q?Gd8Gid+Snzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4664.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVE1NTZ6TWljeUI1b3VEZzFSbURWQ2JEM0tIaSt5aDFuWThEZWZsdjhLL0tu?=
 =?utf-8?B?c1E4SUFjNG4raVBhRHY3WnN1d09ITEpLYk9xckVMenVaZHNqSCt5RFpsWFRM?=
 =?utf-8?B?QzdzZ2Y2eG5QSnE5UElVMWExZC85Q0NhZm9FU2hvbWRxcWJaanU5NmU4R1hB?=
 =?utf-8?B?MkdPU0VJZzY2TE1NRWdhYlFSV0F0OExjcUpMSFFvNVJ3UVhlL1hBSUpLc0dm?=
 =?utf-8?B?Z2dlOFNBVHRmeS9QcEJ6MVBXWU8wZUh6T29BKzkxY3ZrRXp0TVpROHVrSEVa?=
 =?utf-8?B?cUdvMDR3OUcyRjJaMnJDWlQ3SDZ2aFZoWjc2dDdHY1BxZWJNcFBDMmkzSnZq?=
 =?utf-8?B?eGRSNS9HeFJSdkd4cHNwd0dVUE5EZXd0Y3o2L1BVeXpFQUNQK0RreSs3Mm5E?=
 =?utf-8?B?ZmdKYklTWnhxTjk1ZmZGTG1tUEN1KzR0UDkraGx2Zy83YkJZWnM5VTNock80?=
 =?utf-8?B?RUNjMDBkVFVnQTY5VWlOdS9NWVFFczdWeCtPTmJkSU5NV1ZtTG9Cblk3cFJV?=
 =?utf-8?B?cXN6ekFET2FIbWZ3Q2dZOU15RkFMdGJMa2Y4bzhSbVZKQWJEWnNpM3cvdmxy?=
 =?utf-8?B?RDZQVmVjM0V2STM1VHJpaWUvRWZ1MHNkK3VsSTNkWkxZaldRUFA4OG94Y3RJ?=
 =?utf-8?B?R3NrcUhHMmFVZGxNSy9nb1B1V1RvaHZ5M2ZOak1mZjFya25qb0tvdXJwMC9L?=
 =?utf-8?B?WjZ3dzRtWEY4Si9tRmNPak1HOGlzdU1mK0xrUVIxUDlyOGFZRERiQ2dCV2ps?=
 =?utf-8?B?SGVQM1FWVjdXSnZkdC9WYmpsM1hmYTBlUFJJM0NrSGlEeXBnSnBIS2diMHRq?=
 =?utf-8?B?K3kwVHhMWWJFclV6aHFKbXlsTFpIVFBHSHNDMlBoai9hQ1YrOFdidHl2S3gz?=
 =?utf-8?B?WFpUK0NkSW9vdjlORi9EWDAvbzZXUlFIVU1BSkdHL0lBcmUxK0k3cVZMZWY4?=
 =?utf-8?B?eE5lWHpzcjhhL3pocDQwOGZsQlExc3RjRE1QMElVWTJJOXhDVXdkK3NpOFIr?=
 =?utf-8?B?STlOOGc0aDd1bS9Ma0phdWFyakZrSytPUkhXTFI1Wk1udHlpRFBnckFQYWVI?=
 =?utf-8?B?TEdiczY3bTNsY0N6U2U3akpRQkk4WURVZXYvMzF0Sms2Skc3MzB6NzBLR2tP?=
 =?utf-8?B?b0VHUVlvMDJKdzJadm1XSWUvdmdRbTdCbTh5aUYxSEpLTXhQUmJJblhkTWJY?=
 =?utf-8?B?UFdjdFJiTms5MklyWEJDcldSQnMreHpGWDkzUGt4TWdab3dVZHU2QWNqREtZ?=
 =?utf-8?B?S2dGRzB5T2lmUm0yV1VkSXhibWxMU3F1MUIwMVhFMzl5M2E2S3V3UDRaTVJj?=
 =?utf-8?B?ZFp1eVRxUENmbGEyb1ZWSXhEeENibnE2aWUxYzdLZEttVXc0RzNOUGQ5blJC?=
 =?utf-8?B?THBDd0xVNnVrQmMwWU1zaFFKaG5mQUZQYlAzRHEwR3VkUTZQVGltR2xyNU9B?=
 =?utf-8?B?UkdSRUF1YjFBbUt1blJDZUE4Q3RwY1BhOEg2eGxPYlVuYzZOSE51M1k2ajM4?=
 =?utf-8?B?R0hYa0RBdFRwSGE1R0E0ZlBva09tYkQ3eUFSb2pWVmVFdXFzYUVUTzR1bktj?=
 =?utf-8?B?VE5QTWM3YnRlYkJNQ3NWSEYyOFIrV3FsMmsrU042aTNDcVZSU0xuaE4wTndR?=
 =?utf-8?B?MkRESzd4ZEpTSFVTQllJQkVHT3VRK1h3NW15YVRYTkFZU3ZQTEZ3MXdaRlJt?=
 =?utf-8?B?OUlKNGNSc2ltL2ZydXJtNHB4emVGYUhkdWVmSERCSmh0ajhPd1NVQ3NaaWRw?=
 =?utf-8?B?TmZBbURvTVFFU3paeTI4QjNoOTJwcFV4ZVZBd2JtclBXNTl6ekkvUWZHWU5I?=
 =?utf-8?B?K0dKdDBjK2pZb2RFbXJwSzV1R3czeElRWC9vOStjY1lpZUN6QWpIL0lsZ21H?=
 =?utf-8?B?RzlManlYWjFDbk1ObnErUEx3WXQ0M3l2OXhsbjVCU2w1WTNDd2ZOUjlFM045?=
 =?utf-8?B?M2RpeDc4K1libzR3eHNOS1U0UktJOUM1SFlXNkxXNitLVUozcWxKLzFjQUxy?=
 =?utf-8?B?Mm5mQ2YzQWxIU3F0bGFEcTdYUGNnL3ZWRVJGR2l4c3pDanNDaWUwNnYvc0wz?=
 =?utf-8?B?YzlJOVhUY3l5dXdNeGxCRUZsTUJ4dEwrcDFOZkdvS1RjOWR1aGxaaVZCSmFs?=
 =?utf-8?Q?HG0vUUSkbhE2jD05aQucb5Oaf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tFqKWlehYOJTXxTMV+gG9PDjxKEEhV3A1bxyPFROpKXizhObkVGvpTbgJdYkBkc8aeeGRCeuVTVk+58Pf9aDNlEUoVB50PYRh8nmAOZpBWaRWhMQVHIsWfhoJKfAFJBz6rryQtE91by09HkodpLpezOmO/ju9CcORv16AoN3iok6rfFdBXNBJJ+fxeHeETg0vUWZCcIqe2c4/7G+mwbyExSv8UgowEav/IHthuG3Ulf9vqCUGgLdkXfhtxARv0moQiq2XJqWFHYksDtSi1FEmbPCAy2Chy6bEB7uMitSq1ugAUYK7ua7rGW20Cf8zqW7uRX1A+W5CopZ3DtWth6E+JoyJblI8fcE7QOWGYuHZ9izStAvO5HbvrkOg0SwzkXkgcwgaklVYzB+EHDJS1gG8C0JDD8kSsfPh8z+ubINLlN5Rg9neivh3peRbVEjOV5dxJWb+EOaDLhdwaMOkHW/B+6jSfg9xM/jbYAXnQJP9GhLrRJ24TkOFm2kowvqDil9F2mzuAzSMVLkT7tf8j4Ei64j/ivch0TUi+pAVcsppbmzmXmAGk0Qq7OA9bq5wfDVhMlCvAw/jvrXIVu6VGaSPu79pFBy/gZ+1RSE6xlLpoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a79b11-5162-41b6-d867-08ddba3878bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:49:46.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hj9gYWR3+hTdmsq2h8ZcKr1mlkCh1902JWiWTD7LmQID7SlM/dEsmnc1VUCL7UxgCGMs68/HJpHHkFCUo6LEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507030116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDExNiBTYWx0ZWRfX+TQosV8eBRrM J4Tcc7CToN2Oaw+zNtapBIXc3z3TOJh2pbbfa8tyxU6K/JKLGBXRVUlG4LwUlhuqXX/05MXhYC5 5VGoExvnuy4s7tmO6UzY4dTSnbq87ou+rxTVv4dYNBBgxOYUrbsRVN938EbTuWLlvUEHi1Ok4k6
 p4Q2/rhu594Z1u2ojKiH+SrDCT9gDdKCxUq4dMGB4wCw7nqwTatojIG/DpZtCocKuIGJkGVzBkO YtmllDwAsM7pz65ngwmMsdanjs6cu7KpFDXjBu9JpnB/O/aOjKMNYG/2UzTlkEqfJD333cE9eSQ 7Chmjq59GrsOc2wk0L9wVltOmz/xpMEgPU11Rcfv9YRl7tLC2Ps1pop7lsfabV3gJ6nw1NgumiK
 HEjKlt+pGiZYcvv19NrUEX6umU4dlD02JpS/prfk0U6tyZOQWL10sTjUNkOQ39Z2UxmYXb/c
X-Proofpoint-ORIG-GUID: b5ntolQL22M7em93MYd2c0Fu1KA49X88
X-Proofpoint-GUID: b5ntolQL22M7em93MYd2c0Fu1KA49X88
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=68668a7f cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=yPCof4ZbAAAA:8 a=5F-Uq1MTy0yxj0o1_IsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22



On 7/2/25 11:13 PM, Jason Wang wrote:
> On Wed, Jul 2, 2025 at 6:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Wed, Jul 02, 2025 at 05:29:18PM +0800, Jason Wang wrote:
>>> On Tue, Jul 1, 2025 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Mon, Jun 16, 2025 at 04:25:17PM +0800, Jason Wang wrote:
>>>>> This patch implements in order support for both split virtqueue and
>>>>> packed virtqueue.
>>>>
>>>> I'd like to see more motivation for this work, documented.
>>>> It's not really performance, not as it stands, see below:
>>>>
>>>>>
>>>>> Benchmark with KVM guest + testpmd on the host shows:
>>>>>
>>>>> For split virtqueue: no obvious differences were noticed
>>>>>
>>>>> For packed virtqueue:
>>>>>
>>>>> 1) RX gets 3.1% PPS improvements from 6.3 Mpps to 6.5 Mpps
>>>>> 2) TX gets 4.6% PPS improvements from 8.6 Mpps to 9.0 Mpps
>>>>>
>>>>
>>>> That's a very modest improvement for a lot of code.
>>>> I also note you put in some batching just for in-order.
>>>> Which could also explain the gains maybe?
>>>> What if you just put in a simple implementation with no
>>>> batching tricks? do you still see a gain?
>>>
>>> It is used to implement the batch used updating.
>>>
>>> """
>>> Some devices always use descriptors in the same order in which they
>>> have been made available. These devices can offer the
>>> VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
>>> devices to notify the use of a batch of buffers to the driver by only
>>> writing out a single used ring entry with the id corresponding to the
>>> head entry of the descriptor chain describing the last buffer in the
>>> batch.
>>> """
>>>
>>> DPDK implements this behavior, so it's a must for the virtio driver.
>>>
>>>> Does any hardware implement this? Maybe that can demonstrate
>>>> bigger gains.
>>>
>>> Maybe but I don't have one in my hand.
>>>
>>> For performance, I think it should be sufficient as a starter. I can
>>> say in the next version something like "more optimizations could be
>>> done on top"
>>
>> What are some optimizations you have in mind?
> 
> One thing in my mind, spec currently said:
> 
> """
>   If negotiated, this knowledge allows devices to notify the use of a
> batch of buffers to the driver by only writing out a single used
> descriptor with the Buffer ID corresponding to the last descriptor in
> the batch.
> """
> 
> If the device writes the last descriptor ID instead of the buffer ID
> and skip the number of descriptors in the used ring. For split
> virtqueue, the avail ring is not needed anymore. Device knows the
> availability of buffers via avail_idx. In this way, we completely
> eliminate the access of the available ring. This reduces the memory
> access which is expensive for both:
> 
> 1) kernel vhost-net where small user space memory access is expensive
> 2) hardware PCI transactions
> 
> Does this make sense?
> 
>>
>>
>>
>>> Note that the patch that introduces packed virtqueue, there's not even
>>> any numbers:
>>>
>>> commit 1ce9e6055fa0a9043405c5604cf19169ec5379ff
>>> Author: Tiwei Bie <tiwei.bie@intel.com>
>>> Date:   Wed Nov 21 18:03:27 2018 +0800
>>>
>>>      virtio_ring: introduce packed ring support
>>>
>>>      Introduce the packed ring support. Packed ring can only be
>>>      created by vring_create_virtqueue() and each chunk of packed
>>>      ring will be allocated individually. Packed ring can not be
>>>      created on preallocated memory by vring_new_virtqueue() or
>>>      the likes currently.
>>>
>>>      Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>>      Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>>
>> I think the assumption there was that intel has hardware that
>> requires packed. That's why Dave merged this.
> 
> I think it should according to Qemu patch:
> 
> commit c03213fdc9d7b680cc575cd1e725750702a10b09
> Author: Jonah Palmer <jonah.palmer@oracle.com>
> Date:   Wed Jul 10 08:55:18 2024 -0400
> 
>      vhost,vhost-user: Add VIRTIO_F_IN_ORDER to vhost feature bits
> 
>      Add support for the VIRTIO_F_IN_ORDER feature across a variety of vhost
>      devices.
> 
>      The inclusion of VIRTIO_F_IN_ORDER in the feature bits arrays for these
>      devices ensures that the backend is capable of offering and providing
>      support for this feature, and that it can be disabled if the backend
>      does not support it.
> 
>      Acked-by: Eugenio Pérez <eperezma@redhat.com>
>      Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>      Message-Id: <20240710125522.4168043-6-jonah.palmer@oracle.com>
>      Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>      Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Adding Jonah for more thought here.
> 

Hi. By "it should", are you referring to Intel having hardware requiring 
this feature? Sorry, just having a bit of trouble following.

In any case, this looks like a good first implementation that can be 
used as a foundation for future implementations to further improve its 
performance.

This was the thought process I had when I implemented this feature in 
Qemu. That is, get a solid framework down that supports this feature 
(which had some small, modest performance improvements for some devices) 
and then add on future patches (perhaps device-specific and/or general 
implementations) that take advantage of the fact that data follows this 
FIFO model.

As Jason mentioned, one such future implementation could remove the need 
for the use of the avail ring in the split VQ case since the device 
wouldn't need to read it to learn which descriptor comes next.

Another example could be with vhost-net / vhost-vdpa. Currently each 
queue tracks 3 separate indices and keeps a per-descriptor bookkeeping 
table to handle buffers completing out of order. If the backend knows 
data is FIFO, we might be able to drop these trackers and just use a 
head and tail counter with a single contiguous iovec ring. This could 
result in a smaller cache footprint and fewer DMAs.

Jonah

>>
>>>>
>>>>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> ---
>>>>>   drivers/virtio/virtio_ring.c | 423 +++++++++++++++++++++++++++++++++--
>>>>>   1 file changed, 402 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>>> index 27a9459a0555..21d456392ba0 100644
>>>>> --- a/drivers/virtio/virtio_ring.c
>>>>> +++ b/drivers/virtio/virtio_ring.c
>>>>> @@ -70,11 +70,14 @@
>>>>>   enum vq_layout {
>>>>>        SPLIT = 0,
>>>>>        PACKED,
>>>>> +     SPLIT_IN_ORDER,
>>>>> +     PACKED_IN_ORDER,
>>>>>        VQ_TYPE_MAX,
>>>>>   };
>>>>>
>>>>>   struct vring_desc_state_split {
>>>>>        void *data;                     /* Data for callback. */
>>>>> +     u32 total_len;                  /* Buffer Length */
>>>>>
>>>>>        /* Indirect desc table and extra table, if any. These two will be
>>>>>         * allocated together. So we won't stress more to the memory allocator.
>>>>> @@ -84,6 +87,7 @@ struct vring_desc_state_split {
>>>>>
>>>>>   struct vring_desc_state_packed {
>>>>>        void *data;                     /* Data for callback. */
>>>>> +     u32 total_len;                  /* Buffer Length */
>>>>>
>>>>>        /* Indirect desc table and extra table, if any. These two will be
>>>>>         * allocated together. So we won't stress more to the memory allocator.
>>>>
>>>> We are bloating up the cache footprint for everyone,
>>>> so there's a chance of regressions.
>>>> Pls include benchmark for in order off, to make sure we
>>>> are not regressing.
>>>
>>> Ok.
>>>
>>>> How big was the ring?
>>>
>>> 256.
>>
>> that is very modest, you want to fill at least one cache way,
>> preferably more.
> 
> I can test larger queue sizes.
> 
>>
>>>> Worth trying with a biggish one, where there is more cache
>>>> pressure.
>>>
>>> Ok.
>>>
>>>>
>>>>
>>>> Why not have a separate state for in-order?
>>>
>>> It can work.
>>>
>>>>
>>>>
>>>>
>>>>> @@ -206,6 +210,12 @@ struct vring_virtqueue {
>>>>>
>>>>>        /* Head of free buffer list. */
>>>>>        unsigned int free_head;
>>>>> +
>>>>> +     /* Head of the batched used buffers, vq->num means no batching */
>>>>> +     unsigned int batch_head;
>>>>> +
>>>>> +     unsigned int batch_len;
>>>>> +
>>>>
>>>> Are these two only used for in-order? Please document that.
>>>
>>> Yes, I will do that.
>>>
>>>> I also want some documentation about the batching trickery
>>>> used please.
>>>> What is batched, when, how is batching flushed, why are we
>>>> only batching in-order ...
>>>
>>> I'm not sure I get things like this, what you want seems to be the
>>> behaviour of the device which has been stated by the spec or I may
>>> miss something here.
>>
>> "a single used ring entry with the id corresponding to the
>>   head entry of the descriptor chain describing the last buffer in the
>>   batch"
>> ?
> 
> Exactly.
> 
>>
>> so together they form this used ring entry describing the last buffer?
>> "head" is the id and "len" the length?
> 
> Yes.
> 
>>
>> maybe
>>
>>          /*
>>           * With IN_ORDER, devices write a single used ring entry with
>>           * the id corresponding to the head entry of the descriptor chain
>>           * describing the last buffer in the batch
>>           */
>>          struct used_entry {
>>                  u32 id;
>>                  u32 len;
>>          } batch_last;
>>
>> ?
> 
> This should be fine.
> 
>>
>>
>>
>>
>>>>
>>>>
>>>>
>>>>
>>>>>        /* Number we've added since last sync. */
>>>>>        unsigned int num_added;
>>>>>
>>>>> @@ -256,10 +266,14 @@ static void vring_free(struct virtqueue *_vq);
>>>>>
>>>>>   #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
>>>>>
>>>>> -
>>>>>   static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
>>>>>   {
>>>>> -     return vq->layout == PACKED;
>>>>> +     return vq->layout == PACKED || vq->layout == PACKED_IN_ORDER;
>>>>> +}
>>>>> +
>>>>> +static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
>>>>> +{
>>>>> +     return vq->layout == SPLIT_IN_ORDER || vq->layout == PACKED_IN_ORDER;
>>>>>   }
>>>>>
>>>>>   static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>>>>> @@ -570,7 +584,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>>>>>        struct vring_desc_extra *extra;
>>>>>        struct scatterlist *sg;
>>>>>        struct vring_desc *desc;
>>>>> -     unsigned int i, n, c, avail, descs_used, err_idx;
>>>>> +     unsigned int i, n, c, avail, descs_used, err_idx, total_len = 0;
>>>>
>>>>
>>>> I would add a comment here:
>>>>
>>>> /* Total length for in-order */
>>>> unsigned int total_len = 0;
>>>
>>> Ok.
>>>
>>> Thanks
>>
> 

