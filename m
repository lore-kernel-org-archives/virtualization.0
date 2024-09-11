Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB51AC42A
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071443; cv=fail; b=p1Rnh0PJoqPmEV4VpiKyeyqFI2+oWS46tvzGulk2+MEd84Vw6XgwDMVcLgLeoenEIe2YxDrCcwTtmQSPy9qwnJ+UqPGLM3C4zZZtcnqjVgXEGJYSn6h2Vwr7vnUDboNchhrBihVH7cSSQFFLmdCZavkRBhqxZvFemcPHtQ6g9PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071443; c=relaxed/simple;
	bh=74BplGe/M6TiLtTMUrJP+rYpaFzmGxebeurb9p1yerY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFN5cMohi7DugYBPvUzU+yHHgsWXTnkzwwwBr1A/71xA5LiJFmUn3nm3ImpFrIcwRT/HhlTL99SYBT/L10z3Iv/OhUGidxDb05RM4RTeZgaqt+K6vWIUvtn4x6/1EYNpqhgAuh1y47vkLow7ZSZQ8cvADPNcBWgOt7PrIEMXAyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JPZbIZr7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eE1JfnyY; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPZbIZr7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eE1JfnyY"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22E0940230
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 16:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vUSExOp5lVb for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 16:17:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8713940015
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8713940015
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=JPZbIZr7;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=eE1JfnyY
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8713940015
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 16:17:18 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCgFNL011572;
	Wed, 11 Sep 2024 16:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=EFqAP5uKcS4pfoixs7jCwogNNtHHtDOMv0ZXBm1PqOI=; b=
	JPZbIZr7Xa1RinlzxIxJMv9BrOVx4ViokhdjnpNGSKl/6VD4VY+lbroRx+SUcRVt
	AiFSqE58OU+W+vrgjSKMC+Ktaml8qxKX1F9cia0RrxmqM8izgaZjRihNm5IkaBSu
	pH81wBCVt5YJrGcjt4BOkPkjwvh64QEy4AgBfW7CzsqT9qEecM6HFQaGWnyMMuOZ
	HS4VIlTzkao3nxbc4a9MIzPnTUdusOHWhXSjbBhRdD71BWdXpTiwDpx7fCkrG04c
	f+840YbWUqcQEWM4SlR2TqFJmcJrJ2xp7DttTzbIwpUWXNsAVNVR9NxZaEQHcCwZ
	rm8hXX6Ld+6owqfh7gAr8A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbureht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 16:17:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BEwa2d033703;
	Wed, 11 Sep 2024 16:17:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9a5y8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 16:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imMV1XV2tdIBFrd2eJe6NLEfLYpHzoYPFLQCP7JYzj+nTjKAIVPQKTSpV6VqZFP1sD2BH9emeJXcf8A3W8BVKbnbslVbjZiRR38K0YXkS4OEKMJKlo0bQwG/k08gD5XZfppmYQfEOytZc+NVR5Ys1IDbcRLdA7WRBlUK9mRdlFzFlIqKBjsFftf1zTvdl4EKqz7SL77lcbpBfk3j/X77btlGPm8b0qO69oLeP6v/3/LrkDrp6xetYj9DozSS4ig0QNxkbCou/DSADZZK26+RbqwuuBclc3m9ZrVuifa2crOxrE9Lt0Vq8rKkkE0d7ZypMnVytYi5gj8UfWedjyOWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFqAP5uKcS4pfoixs7jCwogNNtHHtDOMv0ZXBm1PqOI=;
 b=l7Gh3ModZuJ8SNpam5nKjQVPrGvAvPL1U8k4HqNDP+GAMxT1cVdtcfvSQbgCwQukntG/GJQ7qkEL++g/mGq0E0ik2gA8aQfSe8yJmJ+FhKBClTASGVOdKxGEsRzaO7ahw6ibe19aOo+JoHL/Ok0ZMNnrJm2GFNCWM68qOitPEEpwiSmaybmg9Ya5ucVUNGxONF+qf0nHwk3Ex1AK8BwnBrTV4UWoEP5rZOJyITmTpyajAdGmTPZ6SF1oo5Q35UXg9JNEkFkVrXcsa48HmCx4fx9MJyPyD8aF8ewfZ+FEzdyfALrWqFQO9FSOX9p1vbDoAJBFjHb7Bftz2QChqH6eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFqAP5uKcS4pfoixs7jCwogNNtHHtDOMv0ZXBm1PqOI=;
 b=eE1JfnyYAonnurflTLaQfuEBziWzmE/sugLaFxcHwNOwapwa/U+mGa4n/eGkPBFReRNLlsjFdBBoVjkPxKTIRzkKg0XCTbkb7jyxYsv+0HqHnOKH8rdGCdHWvwH3hCzTVqTXl07xcGJ7ymT3We/VZA2TgkFEEDAA/e2De1q3HF4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS0PR10MB8173.namprd10.prod.outlook.com (2603:10b6:8:1f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:17:14 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%4]) with mapi id 15.20.7962.014; Wed, 11 Sep 2024
 16:17:13 +0000
Message-ID: <94c76200-05b2-4142-a637-bf2115827116@oracle.com>
Date: Wed, 11 Sep 2024 11:17:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
 <CACGkMEvrti4E2fZBMHGR9LKifZDqtzBqOSg=v7AkKK-r9OZ3wQ@mail.gmail.com>
 <20240910044139-mutt-send-email-mst@kernel.org>
 <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEv71_eUY_2361TNKhTxqxnR4iTyOXq6aKR_6MqaxqM5Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::16) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS0PR10MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: c76ffebf-7305-4c19-cdf1-08dcd27d3240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTh4NlordXc3MFdwR2d6aDcyanVTVktkTmZKeHNrUm16bENUcXF5Q2REd3Vy?=
 =?utf-8?B?L3NkSHhmYUw3SDJ3MWU0eWlDMFcvbEd1aFlvbGExYlVDWmRHODRLYUxwNDRK?=
 =?utf-8?B?RFVJcHE2OHRMSlZucFY0WXJRZGNlWUZYRW1yaEYyVTdrSVIxNW9lZTFaRTZI?=
 =?utf-8?B?MWRpb3VUY2paTHI1aURZSHpST1FCWm9OQzFyTzhXWXM1WVYvZmNPczRNaGVQ?=
 =?utf-8?B?YjZnSUxGL0hJamR2WlAzWUQxUjk4dGFJOUZvM2kzcVIyWEZEZlI5U3Arek01?=
 =?utf-8?B?T2NXTW1Lb0w2aEhyM3lHWVJEVVoyelBEMTE4ZXRYZy9rUjBSTU15TnRYK0h1?=
 =?utf-8?B?RW9laXRhc2xKRVR3MWlDQXhDQ3JQU1NtaTRKN2MvN1A4djExTVFwMUJVLzhD?=
 =?utf-8?B?NW9pVkFpdEIzNFF2RWdxemU1bFZiTitsLzB3cXlJMkVmOXQ5YmVvaFBIN0xK?=
 =?utf-8?B?Q3hSTXhmUHdOeHhxZTF6Z3QvWW85N0hIb2d2NjZIaUp0YldpeTRpcDd3U0Zm?=
 =?utf-8?B?VDhWbm9sV0ZxeFg0dk5JcVRnOHViaXYvWVRYcGdENXdka3FDOWJ0c3dzVWhJ?=
 =?utf-8?B?Q0F3WEdod2hzSkVqRVl0SHcwY09DTDZSMGc4eHJETlNGdmVmdzFELzNzMVNZ?=
 =?utf-8?B?dCtCN01RRzJUeUhCMjZsN0R2bjVYYVpBd3RmbmtrSTcvNDRVRE5IOGIwTDU4?=
 =?utf-8?B?NDUrUVJvc3VrZWlJaTNSb3htbXBRc1hnSWNpUWhiLzFkMFU4MVdERDgrWlpq?=
 =?utf-8?B?U2ZvVjJUdzk5RFpCTWM3U3RIeDJSeVNVOWRPZXY4dWVLZ1BINUpjSkl3SjVo?=
 =?utf-8?B?MEliZThQNFB5UzF3L01OL0tvMFRJdTdLWUpwdGtKMlZrWDZPRU1JNmFCOC9v?=
 =?utf-8?B?UGtIMzB6VnNtUXVrSFpNVm9mZTFocDFreFJlOCtXc0ZERllHTWk3U2hWQS84?=
 =?utf-8?B?LzJteTlsb2phUnFkYnVtQmhuS0dVbDdSRks5ZGpYcmp6cnZReFZxaytIbVVP?=
 =?utf-8?B?MmpyeG9ZT2Nmd2Y0WjdlczZJdmNJRDc5VTlBcEVSMDJxUVQzZzlNTjVnbEo0?=
 =?utf-8?B?eTdEWnJMYkNuTDQ4VlVzdGRrV2FwS2tpcU5zWCszOWREbzdxN29QWDA5aldP?=
 =?utf-8?B?ZVJyNzArYm4yWVJUTVBpZU00NmdtRUtMZ3AwaWVFb1VaSjZVc0JSOUxnUjFs?=
 =?utf-8?B?TnJLc3MrTEsxRGtCVnVmWE8vcmtsK25TdjBGU2pLc0IzRzZUaWx4UVZkQ0Ir?=
 =?utf-8?B?ZnZhVjB5N0NxYkVUN2wydWhDZ2J6NlNqbWJIUFNkUTRtODRWdmcvT3pReEly?=
 =?utf-8?B?NC9yNG8vUFVCWEZWMFJuc3QxeDNVbEN6YXRhT0Q0UXpyZ1d0UVk4TGxvbDQy?=
 =?utf-8?B?c1poUmF6VW9Ua1BsbWM1bFpaUWpWM3hiWDRvek9WNjB1NkJPalFobmRYTGJO?=
 =?utf-8?B?eVJTMUdBVHk1azRsTDQvRlR5OUIrNnJOSENZM0JoSStmeUhqc01Xc1prcklR?=
 =?utf-8?B?UUxDbE1YVTUyb2p1blRQN2U4Z3RDdUM4NllTMlVTQXFJYzA2bEZ0M2lQT1Yv?=
 =?utf-8?B?MEw3SXdnR08rL0R2c1d6aEw4MVlLdEhpbTkwK2hJMnJHdjFYN3JFVFc1YnV3?=
 =?utf-8?B?cEhxYXVKcmkweU93RUZRSW1TUjBwT1dQOXNYUUREWmE5aG15RkdQUWx2ZGtD?=
 =?utf-8?B?Q2hyRjRjNXhVamJaSWZEV0I1M3puNGNEMjlmSGhFViswMGVoS2RmNzhiRkZT?=
 =?utf-8?Q?HhklfwGYwFmDvAgHy96/D7F551Y95+IOUjBIk5s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkppc1lPdEtCZ3NJclhwUUU2WmRHaFNHR2hVdUNVbjNmK0t3SjloR2p2ZVhU?=
 =?utf-8?B?R0s3TzVvUldUem90N3kzbVRmamNSeTdyYmMwUTg3ZWhkUTRoODhqcnFVMTJV?=
 =?utf-8?B?ZGFrbkRtRDJCdk1JK0hJTC9RcWFtZ21RYm8wbk1oakJQMVlCUDg5Nm1rZnMz?=
 =?utf-8?B?UXFQQ1lza253eUpvbTcxVTQ5WkNPRGJYZkxIbVFTQ2E2bUdzS3Y4QkExZGFy?=
 =?utf-8?B?cVlnaitBRklQSXJybFRsa2hrV200YXRiMHdsTUhnWjExdkhjY1VhYTNTYWZV?=
 =?utf-8?B?elFpT2VucER1ZUJhU2ZJTUJlMjVCQWJzT1ByNzdxZ2hYV0ZtNUFrMkJhTzY3?=
 =?utf-8?B?ZnlxYkFwbU1Na2V5dTQwTStMNW9MY3dEQ1greCsvK2xxVm9JbUZNTEsrQXJ0?=
 =?utf-8?B?YzVOcmUyUkhrcXlPK2F2bXpQUW9IQzBGZTF6b0pXOHlRWWdWVW5KQ2oyTHha?=
 =?utf-8?B?bHpnSFNHaDIzR1pudEpKQU5FOXQ1T3dQS1RJdlhhWGpHV1ZuOU81a0pGa1N0?=
 =?utf-8?B?MVllcUV4WUdWamhDNk9JQ04zMThkVmRESDR4dGNlK2hlTTl0RVUzUmVkb0xX?=
 =?utf-8?B?bWlFUHErTk5mcGEwN0lVWUNZQzFleVBveG1wcVlodmJIamhtL2p5SzZ5aEFn?=
 =?utf-8?B?dHEyUytqY3hTWTlCdFpYOFZGcExzcDFGeG8zVEJIVDN0TmcvNjh1aVJqbDJD?=
 =?utf-8?B?Rm1pMDZCOGhYa2ROd3ZkY1FjV2k3UC9OSnpaR0ZuandUeUR4SU5QV2w5TTJJ?=
 =?utf-8?B?YStNUkN1VkJWdXI5SHJLaksyS2NNWTJIVjM1V29ZVC9QMERpT3RqOG4rZmFh?=
 =?utf-8?B?QnNhVGxUQVFGTUJtSTRWSGVvMUtEbjZMR1N6L2xDYmRiQXNNeHpjbUVtN0tU?=
 =?utf-8?B?Q3FpMFFXeU55Q05nZ2pyZm05UCtCQzJlN3dCaVZlcWpHVWFyR3VoSjN4NDdh?=
 =?utf-8?B?MHpnVi9OTkxFWWxlOU9mcFlWeWhUVVh5YTYzTUpuVGNrWSt2aEhzckpTVGFE?=
 =?utf-8?B?Y29HNUpUcUlmOUkwcGJDbjZBdjhTc3lGVzhwR0h0MFY0bjltNEtzQTVRdm5o?=
 =?utf-8?B?QmpsTnc0cmFqdXd2aEZjV3IyYkhYeHFtbzA0NmxDQkRXVVNWZ2pmeEZHSXYw?=
 =?utf-8?B?amxNRlZBMHlIM1hFQlE5VHZiVGtueWVkOEFXeEE0b2dQaVc5L3h1bUg3c28v?=
 =?utf-8?B?czhrcjVEcTd6b1ZaZG1pMHhQb1BPV3J5WU1YWVBoaE5KanZxeWp5clRmWUNU?=
 =?utf-8?B?SkQwdWVwbFMxVUNwL2NpeU8zdHdWMEM1dmk2RXp6WjBPZ0d3WVhrRjc5dC9i?=
 =?utf-8?B?K21jODFBY01hVklRc01rUy9FWnVEbE9WK0hwMk5SVEN5WUJQTGtTN1pKWjM0?=
 =?utf-8?B?QVZjMkk0R0JobGxtZ29YaEY0bHBlOG1xRmlyazdnTGdZTDlRQVE4OHo2RnBR?=
 =?utf-8?B?SFdobk5CTWJRclphdXJVNGk4RzRRWXFTY2hRMXg0WnFWcEZXSXBkd1BBTHRH?=
 =?utf-8?B?Uzk1eVJOdGVOMHJuektOTFJReHB0bVhQNlBOeHRVRFpCODMxWis5RzFyU1lX?=
 =?utf-8?B?Tlphc0VOeWxxMlRIWUhGbXEzcUZhaXF5NzBha05rTUNmY3VucHk5YUdFRUNC?=
 =?utf-8?B?YzE1SzgrQ1llSWxvakcrQnpydEJMZlRFdlFMeE03d0hzTUpkeUFBWnBtaUpv?=
 =?utf-8?B?UVgvU1FZT2xYSDl0VjRRbHE1TERvSHp4S3FvdjluZERIUEZudmxRMjl2NGVV?=
 =?utf-8?B?RE12TDI2b1VjTWFpalg2aWludlRzQ2lCRlZBK2RzTzlxd3RqN09vMmx1UEhh?=
 =?utf-8?B?Q1o1VXJwTzlzYkFyQkJWYUlWS0JaaC9qc25EanhxbTZzRGZtdmpycG04WGJj?=
 =?utf-8?B?Y21KczJmem1qQVdFZVdrRnVFSXdYSyt1R0dDY2FNQTYzUWRia0crOFRyT09Q?=
 =?utf-8?B?alNpd3ZlcUE0R1VBekFZOVFvSEUxYkU3RnJMVDVPVlhjSDhNWFFEU3BLT2xo?=
 =?utf-8?B?LzVRR3hweGgzb0dxeVp4di9hSmpGTjBoL3pPcUlNM3JweUV4ODA3Z0JURVJC?=
 =?utf-8?B?UW5qNmIrSmRxMTl6RmRVb2F0dm9yTWFXQ1dWQjBPL1dYTndoZlVvWFVXWUhT?=
 =?utf-8?B?dytLRGJ4QlRTQjIxaEZTbVpIWWJZS0hPaERlZFNZOXY2WGFRbmtCbFBZMzFU?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6kesvCUoY28jYlKctiq6LxAqAKGbobRODhKzF78aGtGulxXqWzwRrDs+jTiGGI0S5QDLZTSjWGo3NOtlbNztO+fEr1s6ByKPruEyXV85pFSvSX2ok2uRi8JRlaETC0sI6dLvs31/lzCAoaeT+MlQUti3mJij1K3n/fSGOosh1xMv1hhxpKr+zC1uj/WtU+/DjfGoIs/nHysZ5x4jmqTPWDK8MApCOyuP9uXE4vXsLXvS3qi4iFKiEfXQr5nm49ZFM3U6H8QDVNLh/2KBkZIuhT8n7iv1tlcYb3Ji00WmcIeExsv5KdUoAbqeqL72wGx8izW5QO9YrNWi/mfi/xl1S/f5yUPyaDgrN3JRcdC9T0SoZj5rCD6w+WjIypbD45kRoBq1RGcZpF2Qyaxf91437tjlDwf13dPcCrmvmIZOQL6sw3RA1sQBnLV97iztF5/YztyuvwDGIPHgB/PhlQDEyGHQdGTQK+f66SIJok8LpbBPYIqkOrRBAqT5Xmy6UO2hR1AkuDVRiq8ckxN/pou2oeyBfDhyPvIMQzOexID20Ft1+QyApvDrM4ksz+7UgnVD3VPJXys7bD/pLCNDRAYbHsb4f4zpns+cpi7fPycgOWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76ffebf-7305-4c19-cdf1-08dcd27d3240
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:17:13.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/TdBuHclAFcsqFHRmFVb3P6D9NGIFRSNTyzQfzzSjUYVkuAIb3TAFXpHzUyuVvQ8eM7PkiAoDC8tL0l8YT8L7qqx3qlumnhS1+7PSTa7Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409110123
X-Proofpoint-GUID: uoiOJwnkNHl6BRDQx9pZCcVOFdwRGQ2e
X-Proofpoint-ORIG-GUID: uoiOJwnkNHl6BRDQx9pZCcVOFdwRGQ2e

On 9/10/24 10:45 PM, Jason Wang wrote:
>>> It depends on how we define "secure". There's plenty of users of
>>> kthread and if I was not wrong, mike may still need to fix some bugs.
>>>
>>
>> which bugs?
> 
> https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com/T/

The SIGKILL issue in that specific email is fixed. The patches are
merged upstream. I don't know of any other bugs like that (crashes,
hangs, etc). There is the one we can't reproduce so are not sure if
it's the vhost changes.

There is the change in behavior type of bug we discussed in that
thread:

https://lore.kernel.org/all/06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com/T/#m026f7dd96e064e3a604155e45e7ae9d5c949ae23
