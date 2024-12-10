Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C522B5A9
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863744; cv=fail; b=uMsUUhCnEVu1RY+tXH3Plm/VAtfGcGYKhqp44skDAqBTCgyIUogTijkcWLm6uczMWSay/yz50J+KZkHMWiVWju1yUmAdY7sKW7zO6Vxs4shQcVbUR55Vzt70TdH9zNO5Xqwlk8NrBkdhZDy0y6INyOcG2/Io4qy7i6IbWxHHq58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863744; c=relaxed/simple;
	bh=mXZ6kBkhnG4CBVWK8n1OxTt2N7d/l3POLpm2bLqg6w0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eNet4uZybz6SraONhOuovP46xqHPs5itXc2VGhcoXp9sMdPud0zt8JlmLFgaA5ezJyCqA8PVJCgNv3Zi1yg4a5y59JdVnA5o0JO/OsfOs/ZuOZySy/qCOWZb20P52A5XAIsvISlw2A5JeIJyYcj4LtWIVQBGb0f/zJoq40VRgDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Vhh9RIqq; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Vhh9RIqq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5044D60A37
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 20:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZXo6kTBp8iv for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 20:49:02 +0000 (UTC)
X-Greylist: delayed 4023 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 10 Dec 2024 20:49:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 456116090C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=sony.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 456116090C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=Vhh9RIqq
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.132.183.11; helo=mx07-001d1705.pphosted.com; envelope-from=snild@sony.com; receiver=<UNKNOWN> 
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 456116090C
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 20:49:01 +0000 (UTC)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAIk6Tb026943
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 19:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=Xv99kDX
	f2sNbymMrwxhIYEYKyt0wc842vyBAsTgfIZk=; b=Vhh9RIqqHLRUSUQYdvDoeyj
	yCAJYj7iHTqQWFDHfd5QuMxlki8ClLBmXz+mjUOldVPQKMlekCPdXVSgpOKWP/j3
	z/Ln/8aIjEogk+0Dec9ZH4mQRDga1vjfCi41EH8G72DITk9R69ZY3VVV+VP2rqPz
	/YvaEIszTlcvEQso8LAqmA6tSur/OfGELbBXjA0Rkqumn0iYz0Lyd/UDpwoPWSku
	E/OV4R+R/UFddHdPtUSSKkXG0HM74xRPBrsrPVeZThYfpOblv9IJZ6VWUdYNQ9Hj
	LwASXLdZuJ319zz/+RCteycl1F8JZltaM3Q/SJQsgkqWtcmeJWubHwt8t67sU0A=
	=
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43cd7x35xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 19:41:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/JH0T4KxvVf7f3GREvHpP4K3VLViGAFRrAQCsOJZy8rJCC3U18CDF7uyiiQPB6zQ2X9FOSeh1DBaKFrPYD/wpp2fm1+ScOYN+0CyfsnZ6Rr5R3GdpQyIUGAhEvF9HOyHYHq8xZvM02C51YNJwda89RYLMj1N/yQ6cJ4ENckqbDPOKy/xsHfFT2Phg5HH8arEbeaEyIorPp8FGpNy2p4WAIjiW4nIwOLeK/XRt0b2qwNXeIRbdU50My8tzSwOcOn9xCOMQPi+bGoW5EwP4HKvtVH2PVAVvacKVqS3E67mDNtKFgxKIEQdi22oV1ouEwtLzjSJknrK/0nyDS9s6rgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv99kDXf2sNbymMrwxhIYEYKyt0wc842vyBAsTgfIZk=;
 b=UQTDIhNr3/t8bBmrMCLdMay+LRHNHlv1+AyHnDKuMXPGy9kklKgVJkHv2A90Zpglx1dmPcgwqHw9XpBlcJ4OqHyW1RveD0B25adluJC8bZTFpw0B3GR0SNbSq1VNMxu2CINym8HoEMN6de91gOPKy3rBFgPcciu0fgCSAlkUgI5LvE/5WlG5rbwFzrFXJaa1q876xRLLzUNvzTkTzwUoP2E6M/q0GF2vpQ6DcxA+zGt+7w1D4SMfTbNg4WLkVn9C1SQZZyC0Stv9CKKrIRMzgNR/dQBXwdZuIKZQjBbFdZxnRxijnwi9k6VHiX+K3yCDyvEF+W39Q0rVM8IEy6l+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1332.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30d::9)
 by VI1P193MB0637.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:152::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 19:41:48 +0000
Received: from AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 ([fe80::72fe:b5f5:564c:2262]) by AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 ([fe80::72fe:b5f5:564c:2262%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 19:41:48 +0000
Message-ID: <72ed0ff4-e7c6-442d-a395-9d48242e6936@sony.com>
Date: Tue, 10 Dec 2024 20:41:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: virtqueue_kick() falls back to returning true
Content-Language: en-US
From: Snild Dolkow <snild@sony.com>
To: virtualization@lists.linux-foundation.org
References: <077e99de-2e27-4d6c-863e-5c5524f68439@sony.com>
In-Reply-To: <077e99de-2e27-4d6c-863e-5c5524f68439@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:30d::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1332:EE_|VI1P193MB0637:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f71afe2-be11-487e-1ade-08dd1952afcb
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0t0TzJwRGtxVm03eGRjcFpKQXQyaVIzc1FWdzJ2eFoyRkRjNDB0YjBuMklV?=
 =?utf-8?B?L1NBWlBZNk1IOXUxajl2L1h5MkwrU0VzUHRDN3BDcWplOGkrNFJTeW1zMVpu?=
 =?utf-8?B?WVBuaGVZQnFaUXdQNlpscWNXNThPaysyeEgybGtrckd2akdmUDl1S05mWDNt?=
 =?utf-8?B?RGtWTXIxYUdCSmlYdGdoOUdtdWlPTW1xdTljMUpDQzk3MExpMTg2bUloTVFl?=
 =?utf-8?B?QUFWWG5zY21XVzBqeVFFOTNsbmNKQ3dwOVRLZTdwU3JtTGR1NUFiSmlvOXhx?=
 =?utf-8?B?UXB2YVA3alhib2ZWYXJIYjhqL2J4aWxYNlBHUzJWTWNWNjFKOGVTWFdmU0FU?=
 =?utf-8?B?V1ducE9JM2s3UitJWFBJdzBod29jNkZua2R3N1NCdUkrcEhnWEc4V3VFcmtT?=
 =?utf-8?B?ZG5heWxWUFpiT01nUmNsejdGUVRTMmdmVVFna2RnWkxocTZMY1AzcUw1cXZM?=
 =?utf-8?B?aTdsMmw4UjlXeTRHRGhEU2t3NEErVkRJeXpVTytvQS9CdzdGRVYzTVRENlN4?=
 =?utf-8?B?bXFld1FaSU13eHZEZ0paRzBqZkkzeVlZa09STU4vNCs0UG9kZkJMV25TRXN2?=
 =?utf-8?B?NCthVUJIOUtmSmRvSGJlR0FZcnNYc2gyWFRtT3ZTSjhhdnRpVUNrY2JFZ1FJ?=
 =?utf-8?B?QlpNMU56N0Q3cGxnOFBYUitaNFM5ZnVOalRNS0xNRkx1SUdVMDRTM1pHZ1RB?=
 =?utf-8?B?bFh3UkNtVWI4ZmVuWlY1cHdLRi9VTTlHUkU2a0Rmb0U5dlVhaGVMbzZZcnha?=
 =?utf-8?B?WkcwOVZiUlkxOWp2cHE4SWZ1cDlDUjJQdWErR2x3amsxTTRqUkNtSTNkdUlN?=
 =?utf-8?B?K3puemlOakpTaDFhRlZNditVZzhxWHljRXZkbWRyc1FPQzB1c3Y1cWVUdy9p?=
 =?utf-8?B?RlZySGQ3Y0N3UW9ETlZkQ2VkU1BQNWJPTVVXM2JwNHc5cUxhM3FkOUNOUmtP?=
 =?utf-8?B?VC82ZVpXYWlkSkNSSGY5T1k2cTAzQVNsZUVHWjdVSXFLTmk2bUtlYzNkUE1L?=
 =?utf-8?B?RGg5Rnd5aVFJL2pQVkZLU0FrdVpRcjc5ZWs3M1ZEOGRTSnBGdG1TejArNE81?=
 =?utf-8?B?MVUxVjVXOXFkY3pNV1NSY1ZVZnhEa2ppNmsvam1nOEFkOUVTYUJ2OTgrZ281?=
 =?utf-8?B?RjR6R0Z5UTNPN1pwZDZyQXUveTFIcVgvdkZCenV2MFlPYlNraUVWM3pUL2dE?=
 =?utf-8?B?UE5GcEFhNWVEZEc2emhZYmpnS3FqRnNCTVZqTlpjYTY2RlZIVHVtOStSalA3?=
 =?utf-8?B?NmtYNU40L2dLQm0yUHl1TjlDQ0xaWXdQa3JONFN1UC9WTzdPaVhObGx3YzBj?=
 =?utf-8?B?SmN2dVJ2cHhZb2VrS0NuUWdYbXU2OEF1cEFObzE3aW5oYTFtTGc4Q0dNbWRT?=
 =?utf-8?B?NFV0L21oeUlaQU5UWnFTSHJsYkdKam5neWgvRHFRMlF6ejl4R3JyMTVXRWU1?=
 =?utf-8?B?SmQ1RmkxelZBMkZlSWoyMURHSXRxaEhQTWlVL0dkTTIwUnBjeXFZczJhdytP?=
 =?utf-8?B?R2t3bXlyYmRyaE5wQnBLUjBwY01UWmd1MVpuUDdNdlcxbWx0Sy8xNGJyZVZ3?=
 =?utf-8?B?d0xNaERIL1JDYUh0UVFyN010UjJYYzdNNWU5TlVXK2dKeGxQK3o5TE96QnZr?=
 =?utf-8?B?K0NCMElZeGlqdjBQckJrZnljdTk4cjE4cm9tNGp1TU9tdmRjL05FVlZsUWdt?=
 =?utf-8?B?YkxPZ0xHM25lTk95MTc2eEdML2RrYUNDMUNTaWtMcTNwNGhpQS9MazBhVzhY?=
 =?utf-8?B?M0swdmkyaWtnamVZUXYwMWlLVFZPSGJqVFdhN0dsYTBHNE0yVktDMkhVVmxJ?=
 =?utf-8?B?Z3hXcXgza0FSZElpTkc0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1332.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTV6bm5yeXdoWERZMXJtblNGODlQdzhqVmVHV0pybUtxK28ra0lEQjVuaHhV?=
 =?utf-8?B?cldXZHlrV1ZEZHBOb0hyNzBrTGt3Ujl6K0RsWG9TYnBVam9Mb21Od3dyVnBa?=
 =?utf-8?B?T2U4M0ZYa3cwZVVxRHozbmw2blkyVEQzV24zcDlTKzQreUhITGIwZGZhQ0w5?=
 =?utf-8?B?ZS9jMjJUdUJaNS9hNG5ETW83SHV6dWxHQTV5L3FpdC9lVjZ6OEZ1dlRuY1hH?=
 =?utf-8?B?clh4di9GdFE1SXVtendWWWN4UXFuSlh5SUlZMzliRzJZSTRsV2dNZ3c2NFcx?=
 =?utf-8?B?SlZwSzI2NzhMd2l2cXlTNWJrSmpqN2xWUVRsc2ZERnFUMnJzQ2NLaFUvME5t?=
 =?utf-8?B?TDFuRDgwYjZTZHlWcVdYQlBnb2NMei9DMTErRFYrK3lsRlZSaWpkbVE1VHNj?=
 =?utf-8?B?dENPT0Q4UHBwcm94M3Z3WlZUQmdsdFIyZHJtZndCNktxRkhjK1RCWEdPcFdE?=
 =?utf-8?B?enNNbkV0UFUzalc4Uk9aZFBtSytsbGp1ZXZuZUNkR25qdU1HZFZSNklMd0lh?=
 =?utf-8?B?ajdheWY3SEszVkxEOGczUlI5YTRLakNMeUJERGw3eUNhZ051b2w4M0VxY044?=
 =?utf-8?B?aElWWkF6ZXU1c1FMNytCMXZWdFR0eGpxQ2NBL0ZTQzVvczAyYW1YZVVsQmsy?=
 =?utf-8?B?enlXVWF3NjJJV0RHNXd3eHFtMXo4Nk1saFhlUEgzS2cxQjZiamZKSDRsdm5O?=
 =?utf-8?B?VnEvNnhxQ1pDTnkrK095NEdRanlDSU5SL2drRGd1bTA3YVJxSnYyMXFpa1Bm?=
 =?utf-8?B?VEJxVHJKdlhqb0RzSFk1MEJYUmUrMjcxTnp1LzFCT2NPbVhuZHNRby9zMXBO?=
 =?utf-8?B?Y0ROWVd5czJPbTdCVjlaUnVvTlZPZkxnSHMrbklWYndsNUJKTFJGKzc1ZVQ2?=
 =?utf-8?B?RkE2RHJYcjJXVHU0ZXJyVG8yb1pXOTVtbWREZFp5SUN5N2kvY0piOXdKZ1Vj?=
 =?utf-8?B?TEIzaFFmM3ZWbjYycHpVQ3Vpb0U5S1lickFsNytSTHQ2c1I2cEYxN3RvcWd5?=
 =?utf-8?B?ck1rWDIrTWNBaDZMSXpJMWJHOWdhNnVXWnpZTGRwaGZDVDFEaU9PNGJHeDAx?=
 =?utf-8?B?RXFqUXZkNmVWMGtoYVY2TE1jejJiZy9taW1mSm9xbGFRNkhIUVZFRE84YmFk?=
 =?utf-8?B?UVFVNVRhbWRveUJvanNqM21ZdmFBTElvajJvb3QxS1pWUjk1K25aUUl4Qmk0?=
 =?utf-8?B?RVh0Um90bUtFeHljK0grdWdYQkJqZjg3RUE4VjJ4NTRJRy9CNzBXZk9vNVhs?=
 =?utf-8?B?TURnVnlRcU5aekk1dXdjVXBJeHJ6Z243bkpFeUp4dmNvTEZaeElIQytPNHdO?=
 =?utf-8?B?enZsaVJ4MHRJQkdMV3RvUHMxQXNUcEZDdkR3SkZrT0QzN1BLV1I3aVJEK0p4?=
 =?utf-8?B?eHN4QUVsSnVpRE56aEltSGdnTjB6MWo4dkxmT2FOMVNiQUlYaStNQWdFc2Rx?=
 =?utf-8?B?TzVneTQ4WW1rQVVsM3JSclk1ZFlpdCtrYTFYajBFQ1F2bEVROU9wU0F2R2hs?=
 =?utf-8?B?YjdFZ1F6OUhIc05RLzdHRXFFNkoxUm01bkxzNzY2MWpFNWZ0Wm81Qm0wU1FZ?=
 =?utf-8?B?U0tmSkZQU25zWDNmMXJIYzRUWUlUODluamhmVGM3b0p0UFBKeUVYSzNENkxT?=
 =?utf-8?B?K25ERHFxeDVTcmVWOHU0TktXZ3F4Nk5pbzIvd0RHL3lwYnJrUUsyZXpzMDlL?=
 =?utf-8?B?RVBNQ0VYbDBhQ2h4My9xQjh3dzlzZkRKMFo5RWMvdmJ3VVNnc1pCS1hZVDRN?=
 =?utf-8?B?cnIyakJxQVVuQUIrQVFXM0hhTjAxdGVURVM3NWNaWVVDcEw3Z0wvUDdTNGxR?=
 =?utf-8?B?N1VaVmlpTjd2djl2QUs4bEJ3OFdkNTJHNUtOMkxuczhjSkU2UHRoYldPbEZh?=
 =?utf-8?B?cHVFNUl4MzZQdm9FNUlES2l4VTl6WFE4RUxNL3Mvei9KWVRnblFHeXZMS3d3?=
 =?utf-8?B?YWpBMVMyb3A3MnJoWUhBeDVLaVRpZ2xLb2ZqMWROMmxaa28yWnlCUmN5ZURK?=
 =?utf-8?B?VTkweFVWZlNmTld0ZW00RUlad2lZWjVNM083OGxPcUdkMkQ0d1JZaVBCNEJk?=
 =?utf-8?B?K1Noek5yVm1sTEdtNEZYVGJMUE9teVBHWVFLUU1hNnBuS2JBZU5jUEJabXZD?=
 =?utf-8?B?cGdsNWhsNW5qaUdwdmwxVVJhd1RlU0owcThvN2JhV1JtdG5KMWxtSUR4R0tY?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dCKJwOsDwpBU0S53IN4BfJ1q+SUXp8cEdkO3y6gmaZyYbbsijwMPgEbvrwIPzsfaYDsXJ/ZTkxlP8gvdIqaWYkNAeWs8dfnvIgRnzb0DkYW5OBIXVD5aFACzWo+eYWI5OGe6H0EZlaKzdxsh+Xd1OmBURCUqKmsvEeu8qbwtdAuSSL8aWLiqQQo8PpF/5UlZiyoi59SfrGoWYw5wQiD+X55nl+0QlpcbxBxODR+ch78e9zsHTW+oByJLtQfrb9bzM+nnB60ZmqVEL/6y4E5fZ573Njy4yyndSyf1CjiBwDi6O4VCsGSwhecgxeuxVMh1OHW6JuyK57DostVG7VlyC/tSgdpTJaG2OTJGeOB83UWvIy18iXic87CJCzozP6yFrj698yRm8tYhhLdUWLcqaWfS9L20+8iLAkILVhBERYTxlnGHJUDAIjFwS6W19hwmJBWcfdTM8JQJfUsifQXvi+U3JYihCoGE3k5j+oAdg9bTYvpiaeqGfzh9zytnur3nJJK27xuTXxXALg5wvvFF++ptcQecoaWeHzcwNL8HFlWtGOO9GLp3ZABg6VaWCLGgHa2JBAyfTqlhd34fu4UCe+6k+ki9kxD5b6JpalCq/tkQ++wRcx2/rSKiU6YnxX+1
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f71afe2-be11-487e-1ade-08dd1952afcb
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 19:41:48.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZxbLkZEZKpHZ+2dV2M8nC9YM2Bf71QrztQreV4UWMoHenOSScOLo56vFTo80E5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0637
X-Proofpoint-GUID: rQUBThQnaU1HzwTmoHjyZ8SZ2KKbuWo2
X-Proofpoint-ORIG-GUID: rQUBThQnaU1HzwTmoHjyZ8SZ2KKbuWo2
X-Sony-Outbound-GUID: rQUBThQnaU1HzwTmoHjyZ8SZ2KKbuWo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_12,2024-12-10_01,2024-11-22_01

Reading this again today, I realized I was mistaken.

prepare() does not *fail*; a false return means "not needed" (e.g. the
device has set no-notify). The notify() is therefore skipped, but the
kick() as a whole is considered successful.

Sorry about the noise. Carry on.

//Snild

On 2024-11-22 14:55, Snild Dolkow wrote:
> If virtqueue_prepare() fails, virtqueue_kick() falls back to returning true:
> 
> 	/**
> 	 * virtqueue_kick - update after add_buf
> 	 * @vq: the struct virtqueue
> 	 *
> 	 * After one or more virtqueue_add_* calls, invoke this to kick
> 	 * the other side.
> 	 *
> 	 * Caller must ensure we don't call this with other virtqueue
> 	 * operations at the same time (except where noted).
> 	 *
> 	 * Returns false if kick failed, otherwise true.
> 	 */
> 	bool virtqueue_kick(struct virtqueue *vq)
> 	{
> 		if (virtqueue_kick_prepare(vq))
> 			return virtqueue_notify(vq);
> 		return true;
> 	}
> 
>>From the comment (and the return values of virtqueue_notify()), I
> would've expected that last line to return false.
> 
> It probably doesn't matter much; I could only find a few files that care
> about the return value, and I assume failures from prepare are *very* rare.
> 
> //Snild
> 
