Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C8C1E528
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915958; cv=fail; b=Tt9wtuhckIn9uZxB38wNNGy0yNRHyfsbbZpOGdmK/eW3XT4Flu6NwgLgW2lyPPiHepyJjnSbDgAQyUUSHVZFavBBRRfn19+8dPCu+XVjhvIKDFa0BZto6kKFuf4XmSIIM8rBtXusJT/XU3OQFsLPTc/oqAm9IswlrXHUKyQnsjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915958; c=relaxed/simple;
	bh=fSpxvQ6XvJGyKzHMC7FDA+e2BzptJhm+6281QUad4HY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HDzUbmq65fIOC8okv2Tt3bHGQFsQCWOIrUWBs8+C86b2L2QWq6lqjmt2E/l6+NgX8sCZL8/hFqHBWc+7nlAWK8I8/86FpjEckubhsY8KX9ZkIiUTvfp/u7wRcSGysiCy3k7BRr4UZIxVfOKdUDDMYNipMN8B52CJ76b09oZ9fRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=AU9uJTXp; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="AU9uJTXp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39A266061A
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 13:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id URR6DhzXNMOz for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Jul 2024 13:59:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c10d::; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=doug.miller@cornelisnetworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5CD4F60AB9
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CD4F60AB9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.a=rsa-sha256 header.s=selector1 header.b=AU9uJTXp
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5CD4F60AB9
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 13:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcA0TvXYPQpeEE8hP/T4Ww/2irCHbW6eVLam0gcxrTlnXwvxY+4Q9939d/ewafTTH1yFpB78Y8drARY0dSpFH1YchQKjwP3FbbFcIautxKJlhsU7a88aKUoVXuMj19gMpPD5aUhnN9h88NCL8eQnWXQdvh2u3nJpP8IMO6U+VxfUuDmHiOqNeINaZ7Uq8BtH9ul5eVWopnV3XHsb5P+1Afwvm2ettUAhC0beL/393HEzSsLZYj8VJO0YWmdPVR3myyhi2bYtSw/6fH7JjYqgrx9Mw+scm8IfCVhvVjN9sHopl2BLpqZ0Q4zyTpeVJIl0+SMwMeM1WNa4qfpy3kGGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSpxvQ6XvJGyKzHMC7FDA+e2BzptJhm+6281QUad4HY=;
 b=Jfs/HeEWbi5Jn8p0hnhxjTYVzsJyJ0FH1K/A7Loq88fUM+7/yNtszF7/5dhgtpSBv70xTba+hwqmHwNkYbbQckeaBxOJUjpqWxwSVfPNLy/6F0IR5q984iRUtKorHi/AEqz/6Q99Sf2hAnlrh3pfCKqvhMGc9INJ25xxa/5/Me0lfjMiA+LZlYKKIEIYYDzYC2I1WjCvAqgj6Se+RnrnUZNB8+57W2UVYQt0bu/jw8493yjqLePbQX6Jet3tD1rY7fwKqIk3ihdDr4mkemtcOWlb8FQF/fW03EhzItyagHYliZTBbnnbpbhGtQ0X780CXSBnt3XXNmGmg5HfWNQX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSpxvQ6XvJGyKzHMC7FDA+e2BzptJhm+6281QUad4HY=;
 b=AU9uJTXp91X+8APpY+tOAsvMIXYLis6sXovPTaTgzeUUKNONZ+YGKv3SAqLcKDy3++MNfbINKZsGui2fzkGB4dWu2Clk8ahEXIoxLpoAx41zL4/kN1bUhQeg88n9+ItXC2ZPRkvzRarzVIdDT5+mC6cqgZbffpxpKTn3oOcvYj6xkiisZALmURYnGtZnMzGN7nrhLg8JsjumZ60qtkCCq5eUjERhruYPRkaBT3pllcZHysl8Yg44mMWy6nsnD/m2qfzJn+FIZHXx7ukGO7i+KtsLjB9soc9CNBfWYcxnzzeycbUY+bR256p/WItl2nuMITN9okUIgogLrOpmGEra+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM8PR01MB6901.prod.exchangelabs.com (2603:10b6:8:12::10) by
 SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Thu, 25 Jul 2024 13:59:09 +0000
Received: from DM8PR01MB6901.prod.exchangelabs.com
 ([fe80::7850:2655:cfde:c9e0]) by DM8PR01MB6901.prod.exchangelabs.com
 ([fe80::7850:2655:cfde:c9e0%6]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 13:59:02 +0000
Message-ID: <8d56cc54-c787-4b02-b3fa-abbbc57f8fea@cornelisnetworks.com>
Date: Thu, 25 Jul 2024 08:59:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Looking for guidance on using virtqueues and virtio devices
From: Doug Miller <doug.miller@cornelisnetworks.com>
To: virtualization@lists.linux-foundation.org
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <4c719bee-b0f1-4320-86dc-c2be08f236a1@cornelisnetworks.com>
 <eab4e459-b1d2-4522-98b0-0b8b1edd81d7@cornelisnetworks.com>
Content-Language: en-US
In-Reply-To: <eab4e459-b1d2-4522-98b0-0b8b1edd81d7@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:32::12) To DM8PR01MB6901.prod.exchangelabs.com
 (2603:10b6:8:12::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6901:EE_|SJ2PR01MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3b34c8-3057-4374-fdc2-08dcacb1f092
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE50Zy9OSVdXUTdac1F1YUNLT3M1ZlZ4c0JVbzUxeTdyY0JadGIyMjZScWtw?=
 =?utf-8?B?b2d6UU9sdmJQTjZ5eVRISituN3RqSW1WS29qWWI2RUdLa1Z6VXBqUEZYRUF4?=
 =?utf-8?B?cEtmdllleWNBNlE4VHhLNHdnQjJySkNHNE5rbFJ2Qko5UkRsZmFkbGJDN2pK?=
 =?utf-8?B?UW9rMnpDRjVHRkpkS0dxVTlRS3B6cTl5NVlYSnBEWGNoUXJobDVTeEtMcXl4?=
 =?utf-8?B?VlZwTlQxbTY3L0ZVZ1NnU09MZTg0amZDZDZaYUlrYU5xQW8xeXJjV2ZoQzht?=
 =?utf-8?B?d0hEN3EyditnSTEzVUcyKytVNjc1SlJKcHZ1amVEOEZQSTRNVXlhZ3dncFFR?=
 =?utf-8?B?bVhleFNYZnhqODdFREVSbnJ3WUtaNzh5Q0dkenIyWW5DWHRQZUxESmg1V3Yr?=
 =?utf-8?B?bGQySWNvQWtaMTNmRndoTTNaRUl3ejRvSy80emp6N2dVcjRUb2FSRG82dXNp?=
 =?utf-8?B?RnNiclg3OFp6NDFKVGtySVNSNVN3aS9oM0Q0RTZRcVM1dXF4TTBkbVRmaEQ0?=
 =?utf-8?B?eWtTcmVvVE9odkF6aVAzdVg1bVFIT3Y5WkRHdzlvUGluMGdzK3pGUUZHY2VT?=
 =?utf-8?B?VitnSExraFBkbGFQdEI1Q0hKdFc1VlNEZkRvdWVCTVhIdHpDVGhvQ08xUnM1?=
 =?utf-8?B?b1J0dTkvQXVycWlnOG5TNEhoMnI3QjZhOFUyTW43YWh1S2VYSGlVSm5kcFNN?=
 =?utf-8?B?SDlGWkJiSXpPL1JjWVdTamZuclZSdjFYMzZ6U1dVLzdTY0lMbDdYZnhESTZF?=
 =?utf-8?B?L3pkNnVFK1JMdTJVTk9pTCsxS1JPYkF5K2Zka1ViVmliNjNQRkpDbWN0UzF1?=
 =?utf-8?B?UTFDZEg2OXc4RXlRUlp3bWJKQVR5Q1hVSW82ZmF6aEhkbWpDQ3hJQUpLQkhM?=
 =?utf-8?B?N2EvR3NhTEJFT25oSHlRb1dHL3Y1Z2E2eFR1Q2hYaURqQVJtNytDMTIzY1By?=
 =?utf-8?B?YzNBMWxOeVRtVnFDaHhpUTFHWlp6QUhjLzluOXZLMzZuTzF1WkhZd2JqejlZ?=
 =?utf-8?B?NTNzVHVYL25PVTdiWnk0T29UM1BSU2hpLzljaWRid3prOGxDLzhlckN0eEQx?=
 =?utf-8?B?WHFmUW5LQ1RJNzVYQXJkdWF0bjg0SGtheHFubDgwNDIxN2lKaVo1NWMrQlF5?=
 =?utf-8?B?ZnJZUDhXa3pIRGdzaDRUVWtkMkJRSStrOGVaanZBYm44WDJmUm5WMC80MW5L?=
 =?utf-8?B?WDEzU0pYWUJBVUZtWUpMQUlsOTdqajZna0VRQ2w5K1hlRFdhQzR4SXpCY0Jr?=
 =?utf-8?B?YWZpajIvd1NGYldjTzdvM1pRaXpmclFockpSU0t6N0QrRWxsWXhYTXhFclov?=
 =?utf-8?B?RFRZMTdkNks2MlNtSHB3MWhhcnR0cDNxOUt6Y2YwV3ZYazhVSXFKNzFLdmVh?=
 =?utf-8?B?Y256bndNUGpmQUZjTU9SWWJiODA1SGs2RndzNFp3eU1HMGpwd1V6bFV0ODBs?=
 =?utf-8?B?TkRaN3ZTK1NVM2RVVEt1ZWhYeTFvWkJjT3JwU0ZGRVFYR2M4UWpwdzljOEFx?=
 =?utf-8?B?Vkk3RzkwQVhjTHRDQ2wySzZhYzdJWnRzQ1RvaFRhZTdnRFhHcWJlalF2VmEx?=
 =?utf-8?B?cUtJUTRCQTNGdmJXcUNuV1VxZk92NSs4dytrRXp4VHVzdmxURzlKT3BsRC9R?=
 =?utf-8?B?QjlyWlQrQkF3cU81YlQyZjhXVEN0UU5OY2t0YnFhUnVMcWZub25xcng3L1Va?=
 =?utf-8?B?Mlp2RHRmVVJJZkwwbGdTbG1nc2ZNYW95RXFpQmxoTDJMa2xEVkVVandXUnpK?=
 =?utf-8?B?MVhuMThSc3ZpN3JJVUhwV09tUFIzYTZyeDZERWZVMGpVeDZvenVtRFdNZjNM?=
 =?utf-8?B?ekU2bDFSbFZQTHp5TXJhQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6901.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clJyelVJeXFpc1FBL01vMDdWRVVZaFh2bVVCdnhZeis1M0tvQ2R1c0h6UkZL?=
 =?utf-8?B?bWpuVThWa1ZBNUk5UFB3TENwdGUvS3FFZ0hlRDJoSFEwbmlQTS96WEV2MU9I?=
 =?utf-8?B?Ulp0TEFSK2FxeVdoTnJMKzZCaEc5d0VvZ2hqeElEd0tiQURXTlIvMWxINWg1?=
 =?utf-8?B?VnprY0JBTjlsaXBGeExadnpSK3FSQ1FHWjJkT2NJeE5hc053QVM5Nzl2WWFX?=
 =?utf-8?B?M2xQQUVZbEF3R0RwQkF4ZVQxbUZtQ3A1WFdxYXBHVlh3Z2cyak5PcExxWTQ3?=
 =?utf-8?B?clljTFl3cmFBKzkrdSsrUldCUWswVFFSUFlmc3pqaUZzb2RuTlF2MUFaRW1T?=
 =?utf-8?B?Q3Y1d21relJzYXRHbWs0L1c0QmJDVndEZ25wS2E1UzFWTEtWWk9ab3IxaWtw?=
 =?utf-8?B?eUlWcWx0dDUvcTZuakZaNDlOVEk3ZHJ6UVpNYVVYQzlvOTJIdGxpOVdDVGFP?=
 =?utf-8?B?OG1lUWJCU3N2Zm5wZElxVml6azRsRUtkc2N1TFU0Tjd3Sk9HZ2dtTzZDYXg5?=
 =?utf-8?B?czg0TFA3TzJTWFBIcmVMaExWYnAxMCt4ay8rSzVuMHdKMVQ0c2NBYXQ2RHkw?=
 =?utf-8?B?ZUlBVWpJMFZMODEvVkVHemszK2haTENZZWpsaHd0WGdFaUtMSkJGNEt0L3RM?=
 =?utf-8?B?Ykt0Q1dNenNYK2JrRW9qazR1NFdJS0RoY2lkelZZcTlkYTY5bW9xSFM1eG5v?=
 =?utf-8?B?WTZqWTBkbWk5NVpaMjUySkFQMkQ5c2QyTHk1QUtvbjc5VkN3KytnQVF4bWRj?=
 =?utf-8?B?blZaa1FONjl5b3I1a1dNUEZhTE9SbWZhM3lpVXNiQlpnVVdXUnM0bkxwY2Yz?=
 =?utf-8?B?OTF4RmdNSFpza21EaG5sSVN3STR4ZkU4SUd1aXgwekpDREZLQVVmdTNLQ1pl?=
 =?utf-8?B?dUVjbHhPejlxYkJSNnBuMFYxc2wvZnVySDVtTEdSWkVMckZuT0xucUNXbEpU?=
 =?utf-8?B?dEdMeWx4OHM3ZXJLQUJ3aDBmcWZLaFJsK1VWUElUS2RIRzJiK0RUUGtwQVhh?=
 =?utf-8?B?UTVqQWxxa0RPOGZIM1NhdzZKVHhiQ0F3ZlFPUXBsYzgxR244WEdja2szbDFR?=
 =?utf-8?B?WlVNYjFQRzJrVWtkeTVnRnYreVNjNXgzcENRV2hFbnF0Z0tOazM0aDlhS3Bs?=
 =?utf-8?B?ZlczQTc0bk1OR1pVU2xzcy9NSDVOejIrdm1WOWV1dU5FZ3h1L3FMOFNOWllO?=
 =?utf-8?B?V1JvbDhmTXF1d2tUY1BHNGNQRlY5bUJBaUJlQmoxMk55L1o4anhCZFo4OHRt?=
 =?utf-8?B?RGpZTjN3VmlRenV2OU1kSVBGSFdwTzBoaXZ6SnlkNzBzVW9JK2ROQmpiV2xa?=
 =?utf-8?B?MityOFVJakVzSG1aTnVtR0NSMVdyYUh3eEhSNTVxajJZYURNeXJOVFoyVkNP?=
 =?utf-8?B?c29GcXJrUmFPVUhPKzBDRDQ5RWhlbmtCTHBDc2lTcU9qcVd0ckVHK2s2c2NV?=
 =?utf-8?B?d0VxcWdWWGpOanNuaEFKMzRlbEZpMzdXYzM4RXJHbGFlek9LUTd1eUYzSjg3?=
 =?utf-8?B?dUNRL3ZOTzBGQkJBRmZySXB3UldwOGlZeEl6WklDaC85MGxWaENUczB4TWl6?=
 =?utf-8?B?RmU5MDhVTEF2KzdYVDV0OElVdDUvTXJVcWtpZFIrZmdlMnBwK0s0YlBnOGpQ?=
 =?utf-8?B?eFIzc1l4TjUrcUluSXMrMDBhelNORkFVZUNMdzNTclZuQjRWbmowWVlRSGFS?=
 =?utf-8?B?UlNuR01QcEo3VnA4c3VEUFNRTkd2bS8zbTAwQlhoQ29QZU55cnpLRnlhTWh3?=
 =?utf-8?B?WkRwVFAyUlFWT1lvNGhOMUJhbm9xaWFNdC9EVFVtb3NxQjdBWVlXTHFxbGt1?=
 =?utf-8?B?OElkaXN1VWNkSkRYcUdPRUhWdjFWSzBMWXkxNW96M0xibEdLWDFJMFhtUzBG?=
 =?utf-8?B?Mm5vWnpOdnRCaFRpaU5aSDJQVUZHczE4ZVhxdWRoaXgzdklJUXZ5Mk5Zd2lH?=
 =?utf-8?B?UmNLMm12c0ZpWEpuRkM0UGR5Tk1YYnE5M1U3T04wWkNxZ1g2S0hOUTd1VEhj?=
 =?utf-8?B?OEwrcWE1SGFGYXVZNk9tOG1xOWxQR1g5UDlZbnh1ckt2VC96Q1ZMN09paDJq?=
 =?utf-8?B?c2U0dkNrVmNTU2E4VGxwRW9lZnk1Q243ZEhvbGFxU3pwWklOYWtCTDYwWkYy?=
 =?utf-8?B?Q2d2aUw0SGd2U29XTERYbi9WcGlzZjhEQ0l1bnhybjhiRWdKVHMvbmtkZWZP?=
 =?utf-8?Q?4lsLQfa+6FLPFdBiXLA7vfs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3b34c8-3057-4374-fdc2-08dcacb1f092
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6901.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 13:59:02.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJq/BgCfd8ZW3HTc1TAaQj48YEndvFRM5QBPcJuU9lOa3ctdgHqaJlNKCviIjrhUnvz19ljremavYyJue4gIeB4Y1WNMVUv9la48aq26IjDRmq/L/tAdmzmZ16GXbBDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8150

On 6/12/2024 11:35 AM, Doug Miller wrote:
> On 6/11/2024 3:41 PM, Doug Miller wrote:
>> We are adding support for a new adapter to the hfi1 driver. This new
>> adapter supports SR-IOV and we need a way to communicate between VFs
>> and PFO. There are some resources that need to be requested from the
>> VFs and some notifications needed from PF0 to the VFs. I am looking
>> at using virtqueues to allow a VF running in a VM to communicate with
>> PF0 on the host, but am not sure how virtio devices/drivers should be
>> used for this. Is there a general-purpose message-passing virtio
>> device that can be used for this? Or do we have to create a new
>> device specifically for our driver to use? Or is there some other
>> communication mechanism that is better suited for this?
>>
>> Thanks,
>> Doug
>>
> It looks like rpmsg (over virtio) may be what we're looking for. Is
> this the kind of thing rpmsg is suited for? Communication between
> drivers running in different "realms"?
>
I've been trying to learn more about rpmsg and how to use it for what we
need. It appears to me that each guest (VFx) would operate as an rpmsg
driver, and the host (PF0) would be an rpmsg device(s). However, I'm not
finding documentation or examples on how to setup and use an rpmsg
device inside Linux, in spite of finding CONFIG_RPMSG (etc.), which
seems to enable the related interfaces. There is an example of an rpmsg
driver.

Is this the right approach for what we need to do? Are there any
examples of using the rpmsg device interfaces in Linux? Is there
documentation on these interfaces?

Also, I see some interfaces (such as rpmsg_send()) that have comments
like "Can only be called from process context (for now)". Is this still
a restriction and what do these routines do that requires process context?

Thanks,
Doug

External recipient
