Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF1171D2
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Nov 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285701; cv=fail; b=GQzc7fm/ammfuYEV13lo+LfGXsXmNtzMcEZGjCSyXx0sVD9BrmZBM79J49d6XQOvCQbVBT80rKGccDYI5/7P44CAgzfLXFKShIAp67Zht9Uxy7gNG7hdgBNMzoma3+22DkwrZTGMQLGg70RUrJhDgPD7ZiOKOCVomjedWUZh66U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285701; c=relaxed/simple;
	bh=eew295zAccvQCR2fB76HgEAIRcrrVkpSe7LSJo7ABHI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Fc4zieTR0ltyqYUnx6f3zfbu1X9aWeZxbCScSxjqP9O2RTYMgOBtg6+FIEwtGNkFXFxpghcRUIpgcET0cr2jb2G5N8USwN6UZuVdjIqH2UPBoq3ZecOhcP7J57gSytmDlU+oO8VKRBe8DoJ3pwR98EWX7zfDLECT1rNTdn2+yGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=OdKsUJG6; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="OdKsUJG6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EA4C849C7
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Nov 2024 14:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWKGDTfF5trC for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Nov 2024 14:28:19 +0000 (UTC)
X-Greylist: delayed 1959 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 22 Nov 2024 14:28:18 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 47B59849C2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=sony.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47B59849C2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=sony.com header.i=@sony.com header.a=rsa-sha256 header.s=S1 header.b=OdKsUJG6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.183.30.70; helo=mx08-001d1705.pphosted.com; envelope-from=snild@sony.com; receiver=<UNKNOWN> 
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47B59849C2
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Nov 2024 14:28:18 +0000 (UTC)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDAZD3011063
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Nov 2024 13:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=gfTFTrkSVY807tCV23y6oaTdYI4x7
	9uo0n8M83l4f00=; b=OdKsUJG6J3WDm9K2nDETozr6FaA+qFHKBbHHtsWI0gqU/
	glxKBu5tlW1hepljR+VuKenYYO2rO8b4fbn2+/WaFOF4a/99RZUuSPR6M7eaOSGY
	a/7o6veYJmx+QoFikclGMWd5JoUKWXqzZ+2Wu1Z02KlIeu2xDGjP4WzJ/CiYtYNB
	u/pBxsIWsk2K5GAhL1oVMe3o5Z7ZCpYfuM2OB7uKnTA/FOSYIBkvr/pJ75nmTGdW
	xkv/Txe3/6ebXeX22pVw5pwL7L8Nq5Rl0jZzsNx0Hc9/ZXP7cQJUd/8cLUzMtJZI
	sbnmcPuyWqISi3LvVJzxCOZfhR49HUtmKfwPHmk7w==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42xma35e4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Nov 2024 13:55:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWWPOsiFvsQwe7bj/cggVGA4ItAA5ARrz5nYxgbjrkaNqh5WMWPwNwubDkU7+Vu+0TCldrCNoFWy9BUaBIuYF0rZzTGyMF3iJYksHgivp0fEv7qH4RSc1iu8GbjSWxyEysH37NFK9Azh5CNYoVQMc6NrRHLcWwC+++xIwMC4bS5SnS+1ZLi6dh6zbF+eYptoRp3/ycoq3eIQxQnhzXQg6U4rXddXonOubHmFB5QPlGUM+XhKYRMKL92oE8gwWyHX7elktdWQLF6SlMaSum9A/4oxRi/WKjX+Bh1yXRA3fMztyvwtZu+noRlYIp0aV4xW+yiLkwIATc5wAKui3ft/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfTFTrkSVY807tCV23y6oaTdYI4x79uo0n8M83l4f00=;
 b=OuzJiZrAgZYN/BvmbyUJzHBDzD/BgQ+A2yhjecur+8vIUzJoO67B7nFG42mARJqNuxtog2T83o4/oxJeQx6fSM4jKatqLhGnWT4/E9gO7ebfIRKnyLEIiByeb5sCtrRD44zEesdlLf78jcl02Pg4fPNtv5AqhKXS3reNbFdaN0itVU8aqMyV48VajpHUNvdqKbti0o2hJazF70vCqvwWvmt5Yn8S8QZOSn7A2U/X09306fsoI/j0f2m65IEdhMP/Bg0/E+e+0p3zJajLn7Xo2m1TvgaGx5HCYmnbc5frspH2S2al76MAuY3O7HuHLUd8fydXeCkTH726YgFpFCUdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1332.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30d::9)
 by PR3P193MB0713.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 13:55:31 +0000
Received: from AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 ([fe80::72fe:b5f5:564c:2262]) by AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 ([fe80::72fe:b5f5:564c:2262%6]) with mapi id 15.20.8182.018; Fri, 22 Nov 2024
 13:55:31 +0000
Message-ID: <077e99de-2e27-4d6c-863e-5c5524f68439@sony.com>
Date: Fri, 22 Nov 2024 14:55:29 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: virtualization@lists.linux-foundation.org
From: Snild Dolkow <snild@sony.com>
Subject: virtqueue_kick() falls back to returning true
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:30d::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1332:EE_|PR3P193MB0713:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d2fe12-d6c3-40a4-e263-08dd0afd5434
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xubmhTV2tYclY5T3NQaEtucUoxVU0yOHpmYTNYVlFXakVnM01GbDJ0ZFFQ?=
 =?utf-8?B?QzVpNXdRNWczMDRYUDRzZ1drajU3aWRSYVpJYlVENWlJbHJZUVpHOUFRaXla?=
 =?utf-8?B?NGI1c3BCR1UwajlRY05BWXYwWHU4cmF1d2ZHV1N4dHVSQW5pQlJZZk9EaFd4?=
 =?utf-8?B?cHFTTEFJemJyNW4xeHlkMGJSU09vRkNhTGE4cDF5L1NIM2JuMUN6MlFaMjFv?=
 =?utf-8?B?TFNoZTNUUzRCdzVWZjdqUDdlbDM5NUEyb210NkFSbmlXdURLSk4xdVhjZVZN?=
 =?utf-8?B?KzBXaCtvL2ZBOFZNRDZ4QWp4T0EyMDVKZ3VjV0JmeUxZODNMVGZOOFQrbS9z?=
 =?utf-8?B?Q0NxZjV3OTNrT0FBbmlIVjFDVUN6QzUvQnQ5R29JT0FZZmp6dzNhMU9EU3p2?=
 =?utf-8?B?UWFGRWZyMkg1cFNDamcxNHhHakpFaWtrNTZXNk9qYS9lbWp4UHRLOEVRTmhN?=
 =?utf-8?B?bjhTZWRLY2VDMXc5TGlOT1hBVVF6MmdUaUFYZW52UzN6d1lMdG5abU00emN4?=
 =?utf-8?B?K25KM0c4V1RJdk5qdGJCM2ZmWFVJY0F6Z2d1ekZVMWt2UEo5aE8xbE5ZNENU?=
 =?utf-8?B?RlZxQlNYdnZuSURxTVBzU2NTc3VFUkZlb1RQNnRaNUxJazhWeExUVE5IcXJ0?=
 =?utf-8?B?TEF0anJhRURhanUyY0tzejZTd3kzWXc0WUxjODRoTi83QjZzbFpONjZlQmZv?=
 =?utf-8?B?cEFVTk9nbXhQcXRoUFU5OVBiOEh4U3liOHprS1dMV014SVdxaVQ2bkRsMG1U?=
 =?utf-8?B?VE92dFhrOVhiekl4SWRQVUNvU2VvK1RmajZvekJTRWFobmkrZk56R3pZbjNU?=
 =?utf-8?B?RExyVlJ1YllPdXpkM2lFQkJmU29WMTAwTGZrZElUaUVVd1JRREpQd3Z6SkFX?=
 =?utf-8?B?MzRkcFBGL0pPL3NWV3VqWkluc0dNb1huZUF2YjJqMEY3bkdBeXBqMUtTcUhV?=
 =?utf-8?B?UjRJZFpkUWlLdTVIVVk5dnZ5emV6byswWk9YaGlsdUtZZWFqdUpkMFVaTnBt?=
 =?utf-8?B?TmdTK1hXTnVMQVZQS29VODRmbUFtdlNGYXgwQVAydzVpbHFxb21RRlFnaGIr?=
 =?utf-8?B?dUZ6d0F2cWlZQ29GcGVtdG04U2pGTUFhTXJVbWhta1hWbWhwUVdkWnF4VzhI?=
 =?utf-8?B?SlRqaVVaYlVNYTBTTGdlbFY3cUtmOFFDZm5JREdDak1iQzNQc1dDa3VWTFEw?=
 =?utf-8?B?bWF3blp2ZWVTRDZwRjVVbW1CVmpYeGNoWlVrdzlUZXRlelV0VXJkMUFBSUtk?=
 =?utf-8?B?RTRpUVZpY3RjMjgrRzgrNUxDUUZYVllJYUgzVUtWSVdyMDh1azFNTFR5VjNE?=
 =?utf-8?B?WmZ6bW9xVWtIb2hOT21qODEwc1JaNkJWbzJ0S285aU5uQTV6ZEhjb0NRaDFm?=
 =?utf-8?B?TGJXTVBhYlFoUU5uNk5HUnFxaUZXbWFoRGw1V0ZFU3pKMlhGTEt5OCsxV3hz?=
 =?utf-8?B?Zm9HK1hDMTlSYUpJN2ticEpoOHFhWVVVNEpBSGd4VjYwUzlXdlFmejlNVVlq?=
 =?utf-8?B?bGtXbnZFMUIyZ0RtOG40QXVtVmVHZmlRcFhGeDBXdTRvZ2t1d2pKTnZIa082?=
 =?utf-8?B?eUMveUErUVMrbFFCNEVBYWJFVSs5aWQzQ2U0N0RhYmdkbVcrU2pYdEc2TmpR?=
 =?utf-8?B?ZjcxRmVMMlZONnlRUjdsUE1uL0xqQXljQ2JObHd6VDFTZDJWck4rY2FUSWov?=
 =?utf-8?B?ZVdkUWdyb09ERkc2M3g3TTRybWRoS0JlVlI4VG9uaURiSVY5WTJDRnNpa3hB?=
 =?utf-8?Q?cFpENppnLBu6ub4uEgnya58WOiBnbkN/YrYVHQw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1332.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzMzVkxNa0h3dmROS3dtZVE2aVBCMHd2bHZKZjRVS2l6bjkwNkhua2xMa2JC?=
 =?utf-8?B?cnl2RlN3Tjl5Ni9LK0xiTmxHenRqNTBDQ2FyVU9wRzZMejhnWEozTlYwQVBU?=
 =?utf-8?B?RkF5NnlUckdlSStOTklRUWpnZ21TMnNXVjJnQVJ3aWRoK1ZjU21HMGF4MWxU?=
 =?utf-8?B?aFN5Q1k0WlNCNnZuUFltZHZ5WFpPVzFsZjFBelRxa2xndHBFalpIelpYcHNs?=
 =?utf-8?B?WDkyYU9FVE5hMFFpTC9reXRSa01oQ2IyVDhFUkxpTm43Mm55RjVNK0FDeXJw?=
 =?utf-8?B?U1lQZ3lMZEN0MDJSY0hWdzk2WmJWeFllZE9BRXdNMm5lSXYzTTBqeFU0UUVG?=
 =?utf-8?B?UEJJVGlJL0prNXY0bEo0TkI4Lzg0TkxrS2plT3Q3ZmxlTkU3VlQxWWh3aGNr?=
 =?utf-8?B?WmRZcTVVWlY0WnRsTHIvam92Ukx3c3RYY2JjR010TExxbFVFTXNIODd1U0Zk?=
 =?utf-8?B?SDlLUlkrRUJpSEhQM3daa1ZkeDRsZkFLV0tCcGpZTkozUEF2S3NNWG9rb0cy?=
 =?utf-8?B?a2ViQmVZZVVRVy9sQjFQeml0UVFWczBGVHVHYnZaT2ZSUFFuaWNxYXE5T045?=
 =?utf-8?B?OHJlQWpxeWNmaEZDZk5tWGVZcWNjMnFwRGdoYlpXZUNuM3Z3U2lsUWt4aS9S?=
 =?utf-8?B?dEltRm1yNjFyU2MyaldITytvMXViUWc4N2FUWExhRlY0cFVJVkZsWE5Yczdx?=
 =?utf-8?B?dnhVV3BUWG8wUGNRNDU5VWJ0TUcwemZ1SjJWK01xblY3RHBZQUlyRkV4V1M3?=
 =?utf-8?B?b3R6YUJVRmlCbldNcjVPN014Mk96bDVEaDNJNTFIMXd5bXEwWGFLSlRLUkcz?=
 =?utf-8?B?TDI2YmFuK1U3QWpsSHc1SFhFMDhWOGMvd0pUWHcrUGVLSHN1RitQUXd0QWEy?=
 =?utf-8?B?UjQ2YWlmUE5RWTVjYWJZMXVzdjNnbUtXcnZwbXo5NjNVKzlCMStOOEIvS3F0?=
 =?utf-8?B?cDIzdkcrSm9YV2IxZWpZNTRiZHZGYkpxZ3VjVXZybHQxdVhOQWF5b3doOSsw?=
 =?utf-8?B?N0RTNU8xQjZYcGRUcjRER0Z2YlZxWGdmY092d1NxZzcyU0xLaCtHU0hvWHpG?=
 =?utf-8?B?Vmw1REdrdUcvZFJvWC9QbTNtZVlsZEtlZUYyeC8yQ2ZkMHdRTldRZVpLSFlQ?=
 =?utf-8?B?Q3FRbGk0Si9DdThtTnFmVGNwY3ViV0tqcmEvWTNBM2ZPWEphSkFneUtoSlIv?=
 =?utf-8?B?Qkt1Vm1uR1hUK1ZVVjBYc085M3ZDQXdrNTkyY0RVWmM3YXhZQjJaaWt4MS96?=
 =?utf-8?B?RDB5U1BEcGhFbTlCN051eDNaTEM1UC9sZzNGQWpUMDVXNytvWGIwY1pwRVBB?=
 =?utf-8?B?YmIxcFJpV2E1SXFXN29kMENJS0p1a09La2d0dDE3WWFYSzYvUWw3bnU0MjRG?=
 =?utf-8?B?UUt5YTY0cEJIUGcvYVBTaXo2bW56dWoxbTV6V3NlVWRoejYwdW11QUYrTkww?=
 =?utf-8?B?YmpHMTErTlZzbnkrQ29sRWlLQzhYUno5TEhhM3ViM3grNENtM21udFhyUjdU?=
 =?utf-8?B?cmVoVGZPMHd0aEhCU05IZkRWTFVyL3o2c3RWN2hlbU5STGdRNC9tcXJLSUx2?=
 =?utf-8?B?Wmw1TGh1WXl4MzZZVTVoYWg1YzJkMldmY0Y1dHRYSk5RRFZpeldrc0dGcnRl?=
 =?utf-8?B?VVFmOGpCUVg2dEx1SmVrWHZsbjJ3R0Rxa1h0WFZPQW5ieksxKzhaSGRQSTdv?=
 =?utf-8?B?Y1VvR0c3aDR0Z0lqSi9QdkV1VGdVNERodlMvQVIyQWIrZG1vUTQ0ODRoMUhE?=
 =?utf-8?B?dHJ3dFNmK2I4VHhzVHh5VlRHUXAwMVIra0IvOEJ5aXdKdlJMSjl4LzVkMGFr?=
 =?utf-8?B?ZnpTVVFuYkxGVmgrVXF2VVd6M1h4cHBBRUwwQTc5eXlLUkszMHNPWiticUcz?=
 =?utf-8?B?aGNlMHpMTHlIenBXNVl1VEpZUFJZVEUvazZmTTdMd1E0aVdyQVRPZzZjejJI?=
 =?utf-8?B?SS8yVlMxNVVOQytFcDJyUEdmbTQvcjBWeElPK2NiaGN6dDJadHFudHVOV1ZW?=
 =?utf-8?B?Mmd3SXhkbU40djFTS3dBNTd3NXZENVdya3B0ZHFmVnJkNnh5R3NxcWJxeEU2?=
 =?utf-8?B?bVRZdWIybmNYRUNSWDZmWEZROXRhMVYwOFZ3RU5Ra1VRVDV4VS8xdmJySndo?=
 =?utf-8?B?YjQ3ZVh5ZkNPbHBCdkF3L1VNNlRQek55Y1JRN3F4M3I0OFh0N09mSVR0WnE3?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zRephVOuAvBoT5DK+sI2LfPOOJmRyiJ8nTnhjxFRu9tOOff3qNTC5HAo7L41fDhi+dwDV10M1jSbrLM+rSjPHOPxpcfrbwN9BIuHCnrWPqCHmVxbqRltfZP7izKbg6Tg9OYifai/WVY9ZJjSYbL7GZPOXYeucsPLw1MKSe32xLVWLYyl5wwmFbl8OBhCubdeLQur+vnHv36oYVx2O2Ky9CPpgk+w+ZraP9ebd1f3m46P+T6fckTVN/d4Shzcd1OhWIu77aWVWvXsD63oRqA3t1uSDRkUg/TWw47vafxVSf4IU/7I6w78dRwkzWwp0ehecn3gOursIOdPM2HOjrY+JOh7584R44zIxKrF4gw2kIN9DAPZmAo5hRtgY1I/NS4mu3b/I4JvF2Q+xOPPSgIjPmX9Gw8bu/gwUedzUszCd7N2zujShWW+hOjD50LNXn7c0jxmtv9XfdV9LmFNFmeBVV4nnUmSkXWC4R02Al5uL6uDLCRmo8fZFMv0mI3z7ICodVUB1mApLzarOvWgyBpK7T7MMlejWRurCR4le0kHhWtpPUw5qK2jFaWvrAguf/NyTQNLGKeplX6EkH/99lMt+u6u9sTGGMA8qzqt5wEECdefG1sAc1IKF+RInpRwb2CP
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d2fe12-d6c3-40a4-e263-08dd0afd5434
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1332.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 13:55:31.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFpXlfJIQOT7FQvzVSXScd2/XXucDNh5JvSmoXQIFGGUkn6zqALhMcycpJQkTHdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0713
X-Proofpoint-GUID: Cbx9jFm3TIwdkIvunZexqJp4nwK696AH
X-Proofpoint-ORIG-GUID: Cbx9jFm3TIwdkIvunZexqJp4nwK696AH
X-Sony-Outbound-GUID: Cbx9jFm3TIwdkIvunZexqJp4nwK696AH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_06,2024-11-21_01,2024-09-30_01

If virtqueue_prepare() fails, virtqueue_kick() falls back to returning true:

	/**
	 * virtqueue_kick - update after add_buf
	 * @vq: the struct virtqueue
	 *
	 * After one or more virtqueue_add_* calls, invoke this to kick
	 * the other side.
	 *
	 * Caller must ensure we don't call this with other virtqueue
	 * operations at the same time (except where noted).
	 *
	 * Returns false if kick failed, otherwise true.
	 */
	bool virtqueue_kick(struct virtqueue *vq)
	{
		if (virtqueue_kick_prepare(vq))
			return virtqueue_notify(vq);
		return true;
	}

From the comment (and the return values of virtqueue_notify()), I
would've expected that last line to return false.

It probably doesn't matter much; I could only find a few files that care
about the return value, and I assume failures from prepare are *very* rare.

//Snild
