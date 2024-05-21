Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755637CF39
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298758; cv=fail; b=AHgy6HyikDKVfre8I9rPNXtlYZkkDxGdvAB0nPzt9G0LeoadAzS8unEf2PRcR6F0xGQs7EX/freOc5TuXAZXalPSkb6y0XkhnLJ2BFYDId2+OZD95uN+PP9+idouKx7R1o/l/6hNZV4MErsOfU6OMQKQlAPStq8Tw/wmsUpwc2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298758; c=relaxed/simple;
	bh=CsDKWcXceen6/dpYIxGvH38MvEoxgbswlJGyKhgBG5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXQXFNwWcFy3oS36RiwdXe2HspXYOMsEsrP20Pz9Uq9/66B1OoB13G/iKKIjNKr0m2t+DizVBAUit/TLN2xXzozkQD1jk0x2EWKpB6TP7iiV6F9SOp8pwyCXLcLjLg3wb6B1R/G8Onl1kR0Vn8gFSXQsP4hpfsHpXtx1kPRMb0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O0ZyAKDi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jCy088Et; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0ZyAKDi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jCy088Et"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0363840637
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAsoxhTrDl3v for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 13:39:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AC86740622
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC86740622
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=O0ZyAKDi;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=jCy088Et
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC86740622
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:39:14 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCxkNA022563;
	Tue, 21 May 2024 13:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JTmcJIypSb/6BmWvDeG4Iqsai9jPP3Ac7qNjwmwv93U=;
 b=O0ZyAKDiRLK+b4afErCCxZAL04DPi5De/9m8V3HHXFsiMD642p0IXWjjh0OP9kZmSZ6r
 AHzGevjU363BV+CV5V6RONYkuGOFOaa1i5Nyn5VN07MktGQhpU1NWm+j5w7D4mO+f6bd
 Pcgc0+W8dOmV1z+5ZqRMfCdOXJGKxJ4wp8uqo8jZBiud2DRph/bNMk4rlx5NnV+LTj+d
 MmVZ0pZBxVx+7LzWIngOmw006fxwQhQLzT24O14E/O/yqthnzgpqj0ntMCJWHskayW9r
 UYACyRhrgoUQrc/lxFATC0Scs/180dWno2EkLXOK5MxkDq9+X5jvpONFTvhxUdux4AyY aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrenax1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 13:39:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LC7XHx038368;
	Tue, 21 May 2024 13:39:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsdr9p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 13:39:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDNMFw3MGxdk4fgyNylzC8cmFRVPpF0LJ7wwIGAaa9QhTW98q04t3s10hgYEahqmyDeH9rP10U7JhK9g/GkHmDVSp6i3j1lQ4hYiTCs8ENWQ30YNNELQ7TBG89Rrrgo7I2Mq+qeuFt1wc43MsEM2zVt+JLSgE0x+Hq3k9F2m1A9ZlYIK6PVZ+u7b58LwXbAFcLG3yZUaGsgY/Cj7EhbOhZFGGaYsBUly2vh4ZJc0kiR/K2uE6VVhjuaiWJvrumXZ0g10la/EFgdkLyzXbdsGQh/oDkWaAhWWqttpvr7QxaCMuSDP5TwAaMsnUwQwyAMeKHj8bqLRQaX1wSNBUAzwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTmcJIypSb/6BmWvDeG4Iqsai9jPP3Ac7qNjwmwv93U=;
 b=aFcVg0gZWv4YfHAETjgtkvGNiazXmiRbx10CjdwBDngAtWC8W77dGvswmvvSx7axThvyZz2eB+sfF2HfbfQED5qZ/buyaRIBUcoQWvsBS8dE/qPu7x2VxeLWXo6N7fmvcDBE4f9IG9+44wlt+ttuFuC52M18MAgs9bg7yyIpNdCYO6Bsgynr8lMkV3PUrkTEqzHCiRuhg4G2zkwTaf4C9JlRd8/Dv+szGhwx2P00S63QPPjQ7mtImzbsrQQ1B3FNtd1HbxIJLK585yco7SyL4zzhGqqqQAy8DeQbx9dvxNaHTTKglLoEVdsm7jCm+un3h8rrb9K0UvdcHeL3SFRTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTmcJIypSb/6BmWvDeG4Iqsai9jPP3Ac7qNjwmwv93U=;
 b=jCy088EtawPrqBejIOwlyL93OkkC6IC4B+TAUb8dkW5e8K82w3cVCDdui673GESgQoVghENZUrZtQ5Lqj7QC1obhZJeBvit9ssUQj8FSZWsUQ7e2QyCQ+I9I/DVxVjDUcoGbQQspYakk22Y5AoveEGuOFVzPDX+UEX5jOiSfrYc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 13:39:00 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:38:59 +0000
Message-ID: <b55cccfc-67b0-4f21-9070-127af6fd07a7@oracle.com>
Date: Tue, 21 May 2024 09:38:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] vduse: suspend
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
 <CACGkMEtfjHzdBBwgUWgRHDc5opekvgTuXp-_z4ku6L5cqOeAJA@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtfjHzdBBwgUWgRHDc5opekvgTuXp-_z4ku6L5cqOeAJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB4710:EE_
X-MS-Office365-Filtering-Correlation-Id: 183273f9-9dc2-47b0-0814-08dc799b5eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUU4WUQ2WXdhbFZ4SW1BV1ErdUR4ZVp0WlFDanpQNzcvaCtBeFNHMjlDQjZl?=
 =?utf-8?B?cGZqeDRqdnZmOHE2TGhMREh2Qm1vWEhMcTRQYUNIMmp4aVhOVk53SGNadDZ2?=
 =?utf-8?B?b2h1Q0NBL2E1VUxsQTlWbjJiamh4SVFzSDFZdm9vOG9vYm1VcWRuLzdaNUtK?=
 =?utf-8?B?bXRrL1N4Vko0LzA5UnlaYmp4ZGp6bktrZnFZb3NaYVNYMzE1dHN5RGxRQTRu?=
 =?utf-8?B?WTZmSmVEMmNzVnpaZWFCOG9EaEpyNGpudE1oamJBQ1dmbHgvY2tCVmtRM3U5?=
 =?utf-8?B?TDBIeU5IYnR2M3Y1c25PQWhrVmdrckUwZ2ZKREpKbHd0a1hoa3R4TUNpQU82?=
 =?utf-8?B?cnN4VzEwT0I0ZWpsMU4wOEU5SXhVcUhqc2t1NU5uc1NNR2dMYUVmSVRubkJ3?=
 =?utf-8?B?eVJrNG1xNG9COHozYWRGVUxnL21sTk9mSlN4YVpsOU1nQVpVRWNIT0hLemhi?=
 =?utf-8?B?T0E0WEh6bUR0NWxtQjFDVTRpYnh1eDgxZVhPNUpJUm1IM3FwK3NoZExCcXFi?=
 =?utf-8?B?ZW5JL2ExQ09xemt5ckZSK3ZwL0g4MXBpYURtc3Y3VXZXajNWUnFrSmR2VDE4?=
 =?utf-8?B?SVJTbERLaTVhblRWaDgxb3RDakVJdVF5cmpaZCtlWE0zSmp6SVdkTDJsMjMw?=
 =?utf-8?B?Tmd4eU1pU2pobkZCL2crWkdvYVRBS240SHpWd25qNmtweS9uejRYZEJoV2JG?=
 =?utf-8?B?QkpnaHlleHgzSHd2MXRVajVuVEdwWFFja2NRTzBXWDhkblpBczlFRE14Smtn?=
 =?utf-8?B?MFMxTU1FTEZZQUlGdWM0OERXQzZML2hteTh4SkwyaTcrSDhhak8wSXd2aGRD?=
 =?utf-8?B?aU1DeWpSQ2hvbVhwOUFCWTB2S0J0YjFnY0h3UEo4OU42RG5ydTQ2dnBtTFVD?=
 =?utf-8?B?SzVPMGFJK3lPU3Q4K3IrVkVPMXdQS0UvNHU3SitIM2lkMm4wY0RwK1V2UEQy?=
 =?utf-8?B?aUd0VFpJNkpjczRWYXREU3d4OVNoY2Z2YXBaLzJ2UEFqWStvTXVSV3ZVRHJO?=
 =?utf-8?B?K2xBTk5ieUpQYjJKMVgrSHI2OU1SUmhja3RUdDhpNlVCSlpjcWZlaTlCWUJW?=
 =?utf-8?B?MGRZNFNBdXVqREpmWFpsNzNGbDZiSEtpSFF4b2xRdVZzd0piekZiUDBUVVJp?=
 =?utf-8?B?WXpTN1BXUTh1TGM3WnlwSjhmVThaNVlSRVF2TGxwdTFhdERrenhYWjA2RVJH?=
 =?utf-8?B?VGhUY255bDhDK3NwUUx1VTkrTzhMNm0wamJDVG9mWFhNWFdyZ2h5YkhwSVFw?=
 =?utf-8?B?UURXR0lmM1k1cEgvVHBtbXUvUHViVHZ5QTRlQnQvd0kxYURSSnQ3RnhaN3BO?=
 =?utf-8?B?WS84K3VMUVhFMkxBSU1xZ2gyeHAxbWdIQksrNnFqcXIycDhvdnk1cXhrdGJ6?=
 =?utf-8?B?M21UemJiR3VyaVdqejNNZ0hsQzVrVUZLUlFscStzcU11ZVhPbUI3UFYzWnZJ?=
 =?utf-8?B?Qkg4Sng4eDJJN3RoVjkzMVZmeHl3WnhUQ2gvMi84NmVRNzBwcVVOWnRBRTBU?=
 =?utf-8?B?U0w2NTdYWmJBaUo2OC9haUVRK2hwZjBYRUZJck5QWkZnenE2ZDRLVWRFWHlz?=
 =?utf-8?B?dGdOVlpSdC9jTkpQYmVVVlRJRktUUTFmVXpxdDIrUzJWSHVrU3MwM0ZvMlZi?=
 =?utf-8?B?V2N6ZUw5RTVYM016eWxnTDNKdW1LSTByVXpobGZsRDZJUm1NMURyMzYrNC9l?=
 =?utf-8?B?K014V0hlbVpXai9nUDMvL3c2ZmhKRWxQelNJb0s1QUdxU0l0Nm5DRWdRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RDByUUhTM00yN0pkcjUwK0liNG1nT1RteWdFcVdFMW1EOTJBckkyYVFIQVY0?=
 =?utf-8?B?TGpnUk5FY210MFp6VXRtUjFYV09adGdlUjZwTXFENjZ4RkpOMEpDc0hQbFYx?=
 =?utf-8?B?SDVvSWhEaFpyWUNzUWNWL0pLK0RBeVdLMUFoTlFTQkliSHNIMjV3YlR2NnJV?=
 =?utf-8?B?R05naFF1LzVXWGdpWUYwV3lOS2J1bnVrc0RkWXRuTjhOVTNtVlZGb2UvOFFn?=
 =?utf-8?B?S3FTb21JUS9oY0d1M2FIL0t5YTJEU0hhNllwdTdRaTRWcm9mWldsYmpKeEhl?=
 =?utf-8?B?U2ZSMFJzSTY1Mm5Mei92MHJ2VndKbE5DeUpuaGNuTHJpZGRLSzloc2lLaW9T?=
 =?utf-8?B?d1pmZTFRbGJGeFhIbVdNNTh2VkFhQzNSUnBOTUZYNXRoZGlGemdJaHYwRHFE?=
 =?utf-8?B?aHdwc2hCUFVXRW1vbnRIWDNjc3BWWmo4WHF4SHJkREVXRFY3RjJqMjBjVmVE?=
 =?utf-8?B?Y0dqdDhuVlhOU3BiNE9CaFpMTjFwNGxWdmo3SHJTOGcyc0xGbmpIV0FuL3ZL?=
 =?utf-8?B?b2VLQWZUa1Z3SFF6aEFoMlJDM2NvVitPRU5xajkxWVdKRDJJRDdWMzVSYnNW?=
 =?utf-8?B?MC8ybE9Kbm5Yc1RmMzlST2JtODZ3SnViZHV6RTZPcHErZmJVdlJZbW1ETkdS?=
 =?utf-8?B?bEl1SXdqSVFLVnhHa0xuQURuanhoOHFuaUVzQXVUeUpKYVg4M0NXSkluTFox?=
 =?utf-8?B?ZmJiMFNyU3ZDZHdSalBzSFMxdzByalMvbnQ3SWIxMjRVdWg1Z1E5bFZMM2Mx?=
 =?utf-8?B?ZmRBWDV3SUZ6eGcyMFc1Z2FVYjQwOGxpaXJEY0J5UjZvTFZtUGxZZlRudTJX?=
 =?utf-8?B?WDc4ZmVPM2Y2WDZqWE5xbkxFdlkvMjUwVHl2a1JQcGRBYTZqVmR2bVFneUZN?=
 =?utf-8?B?SnBCNjZvb0l1UGMzNTFjeUhPMkl0bVdXWXNBMFJZb2s4OTBIeEE0cmNLeUVz?=
 =?utf-8?B?Z0xZOW1WclRjUzlZb1NhRllScVFPMm9FK2lTTyt6cmhZWnQ4WmN2bGgwc3VJ?=
 =?utf-8?B?ZTVoWWRGYk85N3Z6UGFnSWpOZnVkWDkzYk9nblBrOGd1b2lraFZGWnlCT0ZF?=
 =?utf-8?B?bHZ6bVlFR0V4K3BJVUY1blpiVm5LVWUzQ0RpeHZZMjJXUFpwSWpxNjUwOXBh?=
 =?utf-8?B?QmpmR2pyY3BrTERqUHoyK1dqWlB2NjN4dUdxdUtUb2NsZlcyRnVvM2tuZ01O?=
 =?utf-8?B?RXpnKzJ6RG8wQ3ZPc2MvYjZTZGFsY2NjeDZnTmdDTWc1MXJoVXRId3VzNEdZ?=
 =?utf-8?B?RDJ3NmtqNnVqVGFpQXg4Yk5icnZ5YUR3UWNVM1pkWVdGeEZnc2kyUy9ZWkR6?=
 =?utf-8?B?TVAycXg2SCtDRlFCcXNpekZscDlldGtWT1F5dlJROHVtUHlHbnFBbGtHZk1W?=
 =?utf-8?B?R1g1VGZNSUJKLzdyNWRlUFVSZFhiUjNnbzUvRTYwRWxlNDBuMjFvYjRGTkUw?=
 =?utf-8?B?ZUJLUEwxVHg0Ukg0ck93WGl6czEvU0xOOFgvVGZYcFZTSXF4b1lScG5GMDRP?=
 =?utf-8?B?dHZNWkY3b3RITXdCK3p2VUlidDVmSzk2N3czckVoc2lMYkdOemJ2OHRiV2I0?=
 =?utf-8?B?dGlGenFoLzREblBqOXppbWYvVCtjYTdjYUk3cS9jOERqaXdLUkhybWVhNkpP?=
 =?utf-8?B?eXVQUWgrWTFBYnlUMUxqYTBFZUlkTEQvbzQ3R3FSMGNUckZTdTByMHZzVllZ?=
 =?utf-8?B?QUFPMm9XZkdJVmg1ZHJscHROUVczN3UyaHh5OHIxb2Q2b3pUUE8vTHZRd1BJ?=
 =?utf-8?B?TmN5NGdlMkp4MGVsOVlXUEVlN0NjajUzS2IyUk9IUmlndFE1cTFNQUtxdDNi?=
 =?utf-8?B?YVI1Q0t0U0NtRWV6ZU1nN1NUaFhjVUg5cGhQN0dTTjVQQWFmNWtaanBVMk45?=
 =?utf-8?B?WjYwbXQxdzhaWXorRWpZTk9JQjZkU0kweDB6Rzg5dWdkZnl0dXlQRGZlaGdW?=
 =?utf-8?B?Z05WQ2hhbGtWK0NXdU1XUnRBMHFEVm5ydlBwM3l2SDhxMzRuZjhhSzdFOHVY?=
 =?utf-8?B?cDZXK01TRzVGallyLzhWem1ybVpUdGp2THlMMW9RMEFMbmFNVXlaTHlaM3R6?=
 =?utf-8?B?a3hZM3VZMFk2ZGtQSkplYzJ2enRsRjI4WHAvcDRoR0NkaU5zWjFScXIxYjE2?=
 =?utf-8?B?UWUyUGlZT3NtNDBrVks0cVpnaW5qcEExaFVpMzhaOE5kMTBnQ1drWWJvclB4?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HsOoCXVGQEU/hHpI4GrwylM2TF9LhxAA4RjJi7vCN87rbj8DfZ92BatXXbrRjnMH4VxbD4baoxj9oS5yg5KuDEAVptI3rciSx6CXOQAKVnAjTzpZvtCrx9I1752W/R7m70sNyzlYtijPYA2oLvgzTcftdKvD0/K7VMqhllhyKjumXAR/ZEtPgIiQa77H8Xx6D/1IW/10pnZX6br1LeMC/SOIqZknxAr+fgCFwJTdnirCBwjAuPrWU4xMTa1On1ZGxae7N65BFM/WjuFOyXjJWKeyxpoPbcWR8TVTvuo8NUG0Kofzg8q4fwSBkSygVcTCDFYoDe83AEej0YyAwYzRcGRt6zxxF9DCJ1cgCa3RdzkT8wwzPTnrlLKKSSmhiWrTkqtrAhb70ZEBTnO/jEmqlfYH2jetryMvGsbiD6dRt1ALt/0oX6sa9IOtaOZeZNFbL8egWF2eg7huYGwh3epYzNRm4Alm7kC2St4cg6nXPNJcyrUrxgAFsKHhrTqAmxcxsei/TeRT72iPR+xlH2kvdVw8Y32iNm21F2nSU97DjLUi5vmIcJKk50lptifdbOV+eOrbWamcDzHvPvpP2D/vJ3eyIJv9miyhH+T1wQCllYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183273f9-9dc2-47b0-0814-08dc799b5eb5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 13:38:59.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcu+93DNrvkhCW3QhdAdGlpCRQ4PoVVn79wajrJiiREM0Ehgk5jTBp7IpRdBVH2to3SlM1zCwvjC12ouuOb1b8crl09M/76MsPyJo0zF5uU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210103
X-Proofpoint-GUID: G6VjSAdO_KMnmIpy_JLs9QKwMl_5roZB
X-Proofpoint-ORIG-GUID: G6VjSAdO_KMnmIpy_JLs9QKwMl_5roZB

On 5/20/2024 10:30 PM, Jason Wang wrote:
> On Mon, May 20, 2024 at 11:21 PM Steve Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> Support the suspend operation.  There is little to do, except flush to
>> guarantee no workers are running when suspend returns.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>> index 73c89701fc9d..7dc46f771f12 100644
>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>> @@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>>          up_write(&dev->rwsem);
>>   }
>>
>> +static void vduse_flush_work(struct vduse_dev *dev)
>> +{
>> +       flush_work(&dev->inject);
>> +
>> +       for (int i = 0; i < dev->vq_num; i++) {
>> +               struct vduse_virtqueue *vq = dev->vqs[i];
>> +
>> +               flush_work(&vq->inject);
>> +               flush_work(&vq->kick);
>> +       }
>> +}
>> +
>>   static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
>>                                  u64 desc_area, u64 driver_area,
>>                                  u64 device_area)
>> @@ -724,6 +736,17 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>>          return ret;
>>   }
>>
>> +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
>> +{
>> +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>> +
>> +       down_write(&dev->rwsem);
>> +       vduse_flush_work(dev);
>> +       up_write(&dev->rwsem);
> 
> Can this forbid the new work to be scheduled?

Are you suggesting I return an error below if the dev is suspended?
I can do that.

However, I now suspect this implementation of vduse_vdpa_suspend is not
complete in other ways, so I withdraw this patch pending future work.
Thanks for looking at it.

- Steve

> static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>                                      struct work_struct *irq_work,
>                                      int irq_effective_cpu)
> {
>          int ret = -EINVAL;
> 
>          down_read(&dev->rwsem);
>          if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>                  goto unlock;
> 
>          ret = 0;
>          if (irq_effective_cpu == IRQ_UNBOUND)
>                  queue_work(vduse_irq_wq, irq_work);
>          else
>                  queue_work_on(irq_effective_cpu,
>                        vduse_irq_bound_wq, irq_work);
> unlock:
>          up_read(&dev->rwsem);
> 
>          return ret;
> }
> 
> Thanks
> 
>> +
>> +       return 0;
>> +}
>> +
>>   static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>>   {
>>          struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>> @@ -806,6 +829,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>>          .set_vq_affinity        = vduse_vdpa_set_vq_affinity,
>>          .get_vq_affinity        = vduse_vdpa_get_vq_affinity,
>>          .reset                  = vduse_vdpa_reset,
>> +       .suspend                = vduse_vdpa_suspend,
>>          .set_map                = vduse_vdpa_set_map,
>>          .free                   = vduse_vdpa_free,
>>   };
>> --
>> 2.39.3
>>
> 
