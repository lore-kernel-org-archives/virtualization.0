Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467718EA9B
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053721; cv=fail; b=NovZu5R5qyTSH7h8v/oRtJFKNcq9luTZ9xXWQb/vgCz7AuOk1Q5QaJ2HXM0VzkdC3um7Uk4pTxHdfr472W9e6P6iLELMo2VJn1rkHVm2pTQ7mJ57VI2E5OD0kkblIxnk+yZIZUWZg2xnGe06q+HWhkdf3+F4PsCNZBDe+YfwljM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053721; c=relaxed/simple;
	bh=MBXEYoNbU6FZmq1IIFQ2TJJffGUeFL5/rcazCEB1Rc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TxvajiglxoCbb1QqUuatzwk7UZ81bt2HzD7gkHCmxVvWntpfZbtuvQtP2B4tvRMthsS3XvKSTWsQVd1Qk+iblVyOEHpxTHaz6h0W+gOs/fqjKeh3PZLaOe11mxJs9PCrwQZTgRvNA00GR0T+8DRPksCj9m+eGpUmvuhydzlFmM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfKiRt14; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JRhTyJ6r; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfKiRt14";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JRhTyJ6r"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48DA680FA4
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZlyJ5kSnnLL for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 14:28:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4015580F8E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4015580F8E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=FfKiRt14;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JRhTyJ6r
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4015580F8E
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:28:38 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENdWV014688;
	Mon, 15 Jul 2024 14:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=fpu7xguasNTblSP2IbMFRbVjrOlZvcTaqMh6EHG8BHw=; b=
	FfKiRt14HhL+4GzWf3BoihNWr2mL9WdNcGRm2qgf+wtjZLroaEBgvNc4xZ+O5w6I
	hD3FEvrUvtNx3cGFPIe1oS+mtZWtSi7syaz425nI4iLpa+ba4ZMuxBD/kspaK9dU
	aGouQYOaRWJ/6PvNzhTarcg4CT66JFaSGZN6KLYYl67mczkJ1T+Jop9S3xTcMO2T
	q6YnhYnLWnuACWbJiLGsBQa8senPHhs0DLdzobsSJl5MEethizuUhfJShlzBiJ8T
	GfIEqnkqhFjKc2gvuMgL7oKG9CGy1+395M/pFirRMLStrRSfwGkGaa8c9eSo+WF8
	Jzml1aO0psj0aW1q33fc1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg613gbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:28:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDSNcW040644;
	Mon, 15 Jul 2024 14:28:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17hq2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozuiq9dK8tYD6coyPhBuK2DXafJxhiwhhIJoujDVZYsSvPs8VbFWWaSatc7gB+JPmQkyFG+wsAjAhb7p+6kau08w+5pmyUxeanMF3UxNzeSE8Yqa9/U+64Nnr4M1CiPhbBFgQg0VyEz0eg21xPzAKx4uthBe2WYTLOmFII1FaB8CBF3XnmA2szVjQsB43i/GCK8mipVXGFx51ZZ8cvUaxOVcX9mPyChwJ6NjTKHTzHYvVMw3SHUYTNQrkhaETFVReRQWGbI0d/NETRZKnXevepk55TT9e9H4UPfns+X3gw3imSTz6HkzwF0cAsNj2JBORarcgMakJQ5+3cWw6wgsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpu7xguasNTblSP2IbMFRbVjrOlZvcTaqMh6EHG8BHw=;
 b=B7gIDKMRu34x8JrL1jkA28IHK2gyuBX1pREJMvbAYtUWBDPl/rRYo9K059dOIaOiv6O9pFeK6lFYsi5pp0CbO5GwVDkHQ5h8zXosbbRMqglvuBAp2iOF8Sh+o8jBKPoz0s4VHxDlRCvhV4w7i9gvaRRl1HgXSSEderB62ZjbDbqfhLwkBvjloLl4rhhCsGtfIJ0TPcZ1wr+F8REshcZXqI2vBYyn3+5pyb4dmCAFJBxO53bExml5EyBKP5X2jQmLB0njH6JrtFocEXQ3hFITiHYwXZKfPot5uMvtE4NRWlMT8tJajAP7EXWK28t7bCDXdy7OcAhOINUxhR5GEmjchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpu7xguasNTblSP2IbMFRbVjrOlZvcTaqMh6EHG8BHw=;
 b=JRhTyJ6r7edmL7QatWujB/ktWdIVceVU9uX7caTQBsYtfPeO25NTcHhUCMLE7WvQsBqpB0Phbtw7qnktVN1iXbT2BGnBXJ2NUKF+DLJwI30SVhs16cYCeGN6LnB3IqlDzORedFKrMniGogCpTeLroox+4CWRDpu0d62zytzKF4Y=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:28:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:28:11 +0000
Message-ID: <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
Date: Mon, 15 Jul 2024 10:28:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d29071e-8f82-4199-c2f0-08dca4da5ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDJVdVZqbmZieVF6RzdqekYwTWRZSGhhTTZDZ1RIM3RmaHYyaUhXZE1TY2Zt?=
 =?utf-8?B?K2hwbEFDd3F5TUVoQmRqSnk0RTZHWTFzUHh4KzhWbkNvc2tOUnRNcWNpT3Zt?=
 =?utf-8?B?TzFrcXE1ZlQ2WUQwKzhqTjRGam8zbFZqK0QyalRDRG8rWFNUZVBwTDJBWFFn?=
 =?utf-8?B?eUM2cVJENENCejdBMTR4QnZ2Q2dZYy9ROFBCT1R3Q0ZzUGFRMVZ4WlVSNTFl?=
 =?utf-8?B?bkQwbkNSNURxYjc4ZlNScDhTL3FJZmM4bU1rZGxRMTVQWVJsWXFRUXN1cVB5?=
 =?utf-8?B?Q0ZVSUJMWHBpZDc2TitEY090OXJ5Z2hMVVMxRGM2MzNLYTRXK0J6OGZyREZN?=
 =?utf-8?B?U0xpOEVyeE14Ylpoem1UNktxdWRDNlgwYWNlQld1dlpwU3lNYTJQZ2o3Q0Qv?=
 =?utf-8?B?azRMOFVHYTlrYy9WZVRWeG5XWVJJSW5qM1MvY1NNS0lDNGdLNlM4MFBzcWxF?=
 =?utf-8?B?NHZSczJrQnA2bUVOVXY0VTZ3aEhCK3ZXZERNZGpjRml3NmViaFFva3JBMVUv?=
 =?utf-8?B?ejczd2hzWFFMaUE0MHdGbDRpaVd2QlJwNmVkTEZ5L1g2TzFSZWdKQ0JmWUZi?=
 =?utf-8?B?T3pyZlE3Rk9mWCtnbmx2endVQTJGdTR0OVFmdUZEVFFXZHZCVG5DbVdNYnR5?=
 =?utf-8?B?TUl0RytTNGJPUVpIb3VaVW9MaWpSeHptbjI1bVRSZEtUNmF5VDdDeHRaVWY1?=
 =?utf-8?B?M1RJdmxLcjNydkpRTkIxYk5NUDdBTGxQNWxUQUlTR1puSnN3NjVlWkxFc1JK?=
 =?utf-8?B?RUZidWlMNnpXb1RCNXhKZG9rWDA3WEVZWVZmVDQxRFUwbzNKTGowK1ZSZkV2?=
 =?utf-8?B?bS93OHg2MUNRODl6UmcyVU1Ob0NlQ0hVSUdPTkdBSzdadEgvQTZjN3REYlJG?=
 =?utf-8?B?MlJ0dUtMd2NSRFVrZnpjQ3lNU09hcEJUTHlaOVJTWlVFMDE3c2tQa0llOXVS?=
 =?utf-8?B?a0JJRFVydjN3U1lseWdqT1VQMDdITDdQVWExeDl0aHM0N2lrY1dqRFArN2dr?=
 =?utf-8?B?WDVoYklnaDhVRmJRV3lScUJIelI3WGxDUUxWZFUyUVp3aTNXUmNkVFd6QXdE?=
 =?utf-8?B?cWs4NnNkbWJLUkF0L0hOR2MvbkhhSmtvbjBiSHRqc3hwTlcwNGtjcHNnSzd0?=
 =?utf-8?B?UU5GaTJESENvSTFMKzhwRVZaWDJZdEhoR2w3azZJcUxqQUI5NGVEOUhsa0VQ?=
 =?utf-8?B?RmZSU1NrZGlaQXpSK0hNcGY3MlpPK0h4Q2ZNekx2YnhzZVZvUUVId1VaWFN4?=
 =?utf-8?B?REcvTUdFczZLd3oyMlA2OXZJOUcwenFGRFk0VXRLc0tSOVFOa09Yek4veFY0?=
 =?utf-8?B?dG9maStMU1Q3QzlOTllWQ0RrMzZOM2d0Q1JYV0xJd1dhamlwQTFWaEtnV0xZ?=
 =?utf-8?B?eXg4RVUwT2t4QjV0V2NrK2ZFUFN5T2lZaHRBbENJdU9nc3kyUGU2dTcvRjJa?=
 =?utf-8?B?RjJubEQzTEJFL25RTnlwK2J6dmpHR2hUSjFhZElEL1JsUlNvMmFSc0thWVdJ?=
 =?utf-8?B?OGVOalZwWlFRMSs2OUpYOC9ranFqdUJCMm55MWo1Vkl5cVBFVC9wK1QzMncv?=
 =?utf-8?B?K1MzWlN1a3ljYUNIZ0R1NjZHUnlKUmpqb3B0OEllaGw1MmlrWGhYempuZkVw?=
 =?utf-8?B?a1dhaEpYQUZJQ0xwSCt3OXExYnVCOG0rN0NnT2N2VFZscTQxRjVqellka2dM?=
 =?utf-8?B?aFFzUDhEZjROY3AvQVRXUWE2aU82aUtMbmpYYmZWZHhmSlh0UDlkZjVWNmNT?=
 =?utf-8?B?di84WU1kSEh6NXd3bHJuRnBhZGFBK1ZIa1F6d1h0QjVhY3FFcTg5R05BZDdM?=
 =?utf-8?B?QTFxYXZXdG0rTS9RYkY1QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlJRRWZhQWpWQzl5eTZ4TWQ5Ri9WOGVOeFE0OTZLS2xCbTdMcGtKdXVFU2dn?=
 =?utf-8?B?N1RER21mUWxkNlpERXBPdm5DeENjakRhYVhqUEVqc2dZc0d1UmF4V1JvTm1T?=
 =?utf-8?B?YUJYZnV4cC9aNEVSeXc2L3FQSk1STTBHRm90bjBER3BTMC9tMUtrWFo1VzdE?=
 =?utf-8?B?N1lWcEp0SlJZR3VLRjhYZnJLZ3h4WE9WL2hYdnh5UDRxWE9JZ0ZvL2tyZmJM?=
 =?utf-8?B?MWhvY0MwMFpKbHMxS1E5dWRRWHkrT2t1Vkl4YmlzaWVHakoxRjg2NUtqSnlh?=
 =?utf-8?B?bUhiOFFGeTlzS3ZobHNlZmJkcjNnTDdoUGZ2R0FzRW1uQ2R6bUdWb2xnUXBE?=
 =?utf-8?B?Y3U0djkvY0llaWprVkpyYm9KYms1NXYxbzVWL2ZUTC9GSmFHWDFnNS9YMjdh?=
 =?utf-8?B?eHZ2a0EyUzVYNE9iSEExVkZQdU1DL201VmZqa0hucmUzeS9hTXJ4MlYxaHFJ?=
 =?utf-8?B?OVRWbEpOVVlRUkFiSHZsUlNDdlZlV2VjTjNQdnVJS0JCOTlJd2huYWNtcHEx?=
 =?utf-8?B?ay85NStNZ2xuUk1QTXVFMlEvcXFzYTRSb0d2aHg1OGJpVHlWMkM0U0JRY1dI?=
 =?utf-8?B?N25vZk5Kc0FPQU8zNUk4V2hpM1NuNUJDcStFWWkwY25NOXdUdTJZRVo5VzNs?=
 =?utf-8?B?bTNLdTNtL0VLQlgrU04yT2VveWh3aDdwOHNtT00xWlM0bSt4WHo0K1ZXczZi?=
 =?utf-8?B?ZVN2NHFDN0I4QzZmbVdqME54K25sZVV0b2htOFVON2gwSDRVbUdpb1B3RFIx?=
 =?utf-8?B?VE1lK1JBQm45c0x0RWZvVGROeDFsWWV1UkVSeWtYYzFNcTV3S1dvN0Q5RE5w?=
 =?utf-8?B?SnFBVmt4d3F2NU5jOGxoWGNIdDIxM05GUE9vR0xqMkRHRVpOU0o0MTM5REZa?=
 =?utf-8?B?dFk2c1g2bE1QMUZ6VzBvdWtxU3J3d0dDNjFoVU8zZEZ5SWY2UWZLUGo4NUFG?=
 =?utf-8?B?WTZsSSszMS9Hck9GMS9hZzl3UVYycWYzZ2pjWVNtUVBrUWZhYzZKUWlFU245?=
 =?utf-8?B?WXB0ZUVnRzhNWmJUaldjNlVBeHdMeG84Q052Sm5jV1BHb0RTZFlKTnhhSmRw?=
 =?utf-8?B?cDBmZXlSd1ZLU1VJNEJkLzMrYTZ4L0tlN1hETndWVDJ2czRVdkM1bTduc3pp?=
 =?utf-8?B?b2FnQ1RHU2hCdjJKVUVTbzdqbWtWY045NytJVGxkN0IrbzZ1RncwTFYvTndz?=
 =?utf-8?B?b01NckZtcExiNjJNNGpFV2JXZTZObFlYZHptS3JkRU5QaEhDS0FpeTdLNEZJ?=
 =?utf-8?B?UGw4cHBhb1F0ZVFwU3lnbXl1Z29oSmFlc3U4eno1aE9CVjI1MmE5b0pzcXVz?=
 =?utf-8?B?LzFWMFlMcTJBc0RQM24rc2lZOUdtM1F1MmJvOGI3TUo4NjFYdldwMDJqT2FG?=
 =?utf-8?B?TFdNV1BwanRicDZveFRGeklVR2lUeHpWQitETEZGUW5mNHM4akpGNUZvdldQ?=
 =?utf-8?B?d2lrVHQ2bklYY0NhYWtPSzF0dGFwR1dNdkthOEpKdEhXd2tLZUZhdDlvN051?=
 =?utf-8?B?S1NHc1ZCR0VvOVdHRVcrdUNXR0kxcjk3YkcvTm5UVHlnOXJ3MnhWSmxndmJM?=
 =?utf-8?B?ZldHQndpVHJsclRDazhXTUJVdFNiM0JPSDJRTm1yVlY1a3N1dVovaVhydlVI?=
 =?utf-8?B?OFl1NC9DOHlnSmROOGo2TEd6K0pwR01oL2xLdjFuTzFGTHlrVGdDL3RDcUZl?=
 =?utf-8?B?eEZnZ1dRTzQyWlQ3TDFITnFEVmRzMUFwSzJvWHRRalhyT0M5ejhoWHRLQnVo?=
 =?utf-8?B?U0k5eUxZRWNjNDlLaGY5SFNqNzBaNWgwN3hkUzhRM0pHYjNUOUgrUlE5N1lO?=
 =?utf-8?B?THIrZG93ekFnaS9xUk96N1ZGZ1BrUkdwYjQwZCtweTlja3JRK1B0WGhQdzk5?=
 =?utf-8?B?bzRPY0cyWEdwdzZmT015Q2VITHJKTmozcUtTc25ZK3ZwM1RCSEU3dTlCM2xs?=
 =?utf-8?B?Z3NRZEwxRjliZG1HZlFONUZudnk0TmxXcWlkWktjSmZPUDAwallGUVhENENS?=
 =?utf-8?B?akpVUGk2b1pCQ2dnWWp1UThidEI1N2NFSnNiSWhNOWFmTFY2K2lLYTkza1V3?=
 =?utf-8?B?OWhoajJLNXNWS1hzanluNlBHRnBIUjVscXJMcXVWZEFlSVdVZWRPNE42RGlL?=
 =?utf-8?B?UmVDOXNjUTBjcnZGcGhRQUlVdzZhMnhzTkVFbS9COXJBNzZBUXpXWlplaFFY?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	53N9/cIICtrkaY+g4k786kiE/Z3EKe/ThArZOpITUlQrtEKgaRDCnKy4n1psiE9mDa4OotWupMVQ8RxJbO9Ke5f6RWFD9FUvdzcZhyoxNiWQUJyhctl4wjAgbfhNqaEZyuXlMQZUk1aXbITcmwdj63K6TymLJ4MYXU9a9uu74rAfPEpYMrk0avga59xngNu4ybeaPo+23y5bx8GQbiaRlxl9x/EGvBjcfWQSq1jBw2Oox3VKiwnLEkM2fg5ilFzM1yPvNAET+485lU2Cqk0IeowhWPx8ZuRIN85olmde5DV0X7I3mumX/0/KmL4UKLtjY/3zlVRViB/cYnwRXixZDnQjUkK8XOZ7TyV3AuwEqw8Di4haQ7T9AZtnOOsPurRCe2bURNoGkS43a/s3u4sW7f/obe1BR/qawOpWp79wJ/Xdc0o7K6WER1gPzmLR8TQwq5IeMCSa2KzHTTen8nwsWwvwqyejfvoKDn62Vo/qhV7DeUIgdkuUmz45pZQGEDhdS/iZIKT48aWrMIW8VdQPSy9wLrD9RY4uwwtw9aTiN6AJhnLuKGNwHB9LfuOZddntaAlHNechgWvOdBY6owQft2r6uxwP4YnyKzzltAPWvGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d29071e-8f82-4199-c2f0-08dca4da5ad5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:28:11.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRsEJRJz6jFXdWWvxp8OtBYi8bVw9B9GIOWyeaD+vVJ1Wg5K64mJzcX85b5aRZdYspMWYrnoNktQ0suvOvvrGIZi5u7xA7qf5TKpwboR8zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150114
X-Proofpoint-GUID: XRxJ1-bBGWGw5IjY9yZwtfg8IpT-dNXg
X-Proofpoint-ORIG-GUID: XRxJ1-bBGWGw5IjY9yZwtfg8IpT-dNXg

On 7/14/2024 10:34 PM, Jason Wang wrote:
> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> When device ownership is passed to a new process via VHOST_NEW_OWNER,
>> some devices need to know the new userland addresses of the dma mappings.
>> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
>> of a mapping.  The new uaddr must address the same memory object as
>> originally mapped.
>>
>> The user must suspend the device before the old address is invalidated,
>> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
>> requirement is not enforced by the API.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/vhost/vdpa.c             | 58 ++++++++++++++++++++++++++++++++
>>   include/uapi/linux/vhost_types.h | 11 +++++-
>>   2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 4396fe1a90c4..51f71c45c4a9 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -1257,6 +1257,61 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>>
>>   }
>>
>> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
>> +                                         struct vhost_iotlb *iotlb,
>> +                                         struct vhost_iotlb_msg *msg)
>> +{
>> +       struct vdpa_device *vdpa = v->vdpa;
>> +       const struct vdpa_config_ops *ops = vdpa->config;
>> +       u32 asid = iotlb_to_asid(iotlb);
>> +       u64 start = msg->iova;
>> +       u64 last = start + msg->size - 1;
>> +       struct vhost_iotlb_map *map;
>> +       int r = 0;
>> +
>> +       if (msg->perm || !msg->size)
>> +               return -EINVAL;
>> +
>> +       map = vhost_iotlb_itree_first(iotlb, start, last);
>> +       if (!map)
>> +               return -ENOENT;
>> +
>> +       if (map->start != start || map->last != last)
>> +               return -EINVAL;
> 
> I had a question here, if a buggy user space that:
> 
> 1) forget to update some of the mappings
> 2) address is wrong
> 3) other cases.
> 
> Does this mean the device can DMA to the previous owner?

Yes, but only to the mappings which were already pinned for DMA for this
device, and the old owner is giving the new owner permission to DMA to that
memory even without bugs.

> If yes, does
> this have security implications?

No.  The previous owner has given the new owner permission to take over.  They
trust each other completely. In the live update case, they are the same; the new
owner is the old owner reincarnated.

- Steve

>> +
>> +       /*
>> +        * The current implementation does not support the platform iommu
>> +        * with use_va.  And if !use_va, remap is not necessary.
>> +        */
>> +       if (!ops->set_map && !ops->dma_map)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * The current implementation supports set_map but not dma_map.
>> +        */
>> +       if (!ops->set_map)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Do not verify that the new size@uaddr points to the same physical
>> +        * pages as the old size@uaddr, because that would take time O(npages),
>> +        * and would increase guest down time during live update.  If the app
>> +        * is buggy and they differ, then the app may corrupt its own memory,
>> +        * but no one else's.
>> +        */
>> +
>> +       /*
>> +        * Batch will finish later in BATCH_END by calling set_map for the new
>> +        * addresses collected here.  Non-batch must do it now.
>> +        */
>> +       if (!v->in_batch)
>> +               r = ops->set_map(vdpa, asid, iotlb);
>> +       if (!r)
>> +               map->addr = msg->uaddr;
>> +
>> +       return r;
>> +}
>> +
>>   static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>                                             struct vhost_iotlb *iotlb,
>>                                             struct vhost_iotlb_msg *msg)
>> @@ -1336,6 +1391,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>>                          ops->set_map(vdpa, asid, iotlb);
>>                  v->in_batch = false;
>>                  break;
>> +       case VHOST_IOTLB_REMAP:
>> +               r = vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
>> +               break;
>>          default:
>>                  r = -EINVAL;
>>                  break;
>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index 9177843951e9..35908315ff55 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>>   /*
>>    * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>>    * multiple mappings in one go: beginning with
>> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
>> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP or
>>    * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>>    * When one of these two values is used as the message type, the rest
>>    * of the fields in the message are ignored. There's no guarantee that
>> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>>    */
>>   #define VHOST_IOTLB_BATCH_BEGIN    5
>>   #define VHOST_IOTLB_BATCH_END      6
>> +
>> +/*
>> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at iova.
>> + * The new uaddr must address the same memory object as originally mapped.
>> + * Failure to do so will result in user memory corruption and/or device
>> + * misbehavior.  iova and size must match the arguments used to create the
>> + * an existing mapping.  Protection is not changed, and perm must be 0.
>> + */
>> +#define VHOST_IOTLB_REMAP          7
>>          __u8 type;
>>   };
> 
> Thanks
> 
>>
>> --
>> 2.39.3
>>
> 
