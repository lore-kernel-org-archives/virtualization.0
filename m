Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378431DF960
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Oct 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204292; cv=fail; b=ohSAcuiAxU3kZTmLNT1J9PLBfpoQh1K95CUi3ASLfx9gF5dfdSN1nNbf+mKBZOgOOhgdSbLR+d8qWAuvw9JGRrAL1WkRsZESD++fCKPt1nbFZySj8N+FRfPvXaszdkQTPiFuG7PiUIw0wGReVzZltOfdkDlx1K19MmGpV0l+0vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204292; c=relaxed/simple;
	bh=APKFu304N+6KMjFbyPdGhxfqPewqNUZ61sR2vEk5lY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1aa+2yGvVlnhwcmaU8+u+8UZ0hQlOej54qnsGtYuD2kB7eMpr1KoZJwXWSO62YkJBMwiTvZ9ccSBXRV1v1GJB+vaU/Y2ChT1n9j4/rW+b6KpdmeFpJ1UuIwDG/TvGCGGN654qEQbdosSO+knu4y4I89DChjLOBau7n2qVpwvlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TUvifGzm; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TUvifGzm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3CC680CC9
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Oct 2024 12:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.104
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_RYaJ1FMnPH for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Oct 2024 12:18:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2009::62f; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=feliu@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B48A880B7B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B48A880B7B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TUvifGzm
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2009::62f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B48A880B7B
	for <virtualization@lists.linux-foundation.org>; Tue, 29 Oct 2024 12:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhhXqV15uQwSn90RAn3B1kypp3YZRnuuOqtWS4Hb3cjvGGlRUKslNzG9D9soJA5marYqFLx6S6OMwkIYH24VmMwEQUR9KXu98YMQP48LKobqPWxzRWwpEcCAxWEAU8TTJAlVxRXh2y/vuH7yZmmnZR02BYIGCGUvJsm3m4/nh3Q4l2q1nR19E67B+zjXqPq0ZeDqvd5HikBirWpS3a11I6Jg1XZJXvdpXG3GOOPSLETn6k7pMlD6SN/sMDV3F56r9EqFUhM+dinILxV96Y2PPDFEkdmifX0CzfwQObXLk+SNXr4pcbBLl/uA9zOfTCdT4P80KhAYsPNzDnYzCC53LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itsUWrUugE4tmeY2AQGBCG/S28wcykQT7I9vL8FGt4U=;
 b=LZJgFgupiJKrUAETkU+ziFHS2+S1JhD4C1xkMFKPqCg6SSAZlw3EOuvAiLPwEwoxRTpH7LjyCVJ1wRDhAcVp8qZfAVPBLScxJitTaKJtU8rGV/3pct0415X1neLl0rKdbjUStddwD/P9AKVwLClBLfk+zRHOoRLKSLJC8dT6tK86C77aUNh6pChSo4Q/VQU1auIOPn7xaOIkpEv/PzY/YrX2PJ6fTW4YT7u3zAmzATNvoVCLVZkI1WlagNdXe4PSrsuNXlc9TEt/tDChhIsUN/yH84SUMOiX4tJzYup4H0s51hYlmvXCAgIFwxFlf2aueMDu60+g1vay5mHga9lR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itsUWrUugE4tmeY2AQGBCG/S28wcykQT7I9vL8FGt4U=;
 b=TUvifGzmLERitnMXmMRpp0I1Qk6r3CEr13wbSLKiVZYg4M0oN5Bqaw0v22ew5i1l1B/8cNstiD80xxsBRh7AQ6UjqOWm3GlydX14+0ta0DsFZuOMcS4vPeFtMNCvdJzRNxBYv0+9SqGAHnu9ERL49qgQTrfhcw9wH/kNH5kPTcbX2fc+MC9JJkSPCZ69BEfI1sAfgooFkoCOu0dmdw4vjYbZn57qg+8zULslJgvfKgQh/H3fOhud64Hl8l8q46/atts5ehsSno3EvNuccuuhg1fboYidBjVZrxhcosBN4V2mOxHkbW3mI74UEboKKd5UjoH7jNJXiM+69Bx+TfSICw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 12:18:03 +0000
Received: from BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::547e:4121:7ab1:9065]) by BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::547e:4121:7ab1:9065%7]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 12:18:03 +0000
Message-ID: <39714b40-28d4-91d8-774e-9c8d91461d28@nvidia.com>
Date: Tue, 29 Oct 2024 08:17:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio_pci: Fix admin vq cleanup by using correct info
 pointer
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Parav Pandit <parav@nvidia.com>
References: <20241024135406.81388-1-feliu@nvidia.com>
From: Feng Liu <feliu@nvidia.com>
In-Reply-To: <20241024135406.81388-1-feliu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::29) To BL1PR12MB5825.namprd12.prod.outlook.com
 (2603:10b6:208:394::20)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5825:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f3bb09-683d-43f2-a299-08dcf813bc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmFHdWlKMjVVdFRuVjY1OTBiQk8wWlRBWDlseW9vNXk0Rno0TGZqN0M5bWZC?=
 =?utf-8?B?UGRkSDhydlAwSjloa3JkYmJWMkxmck53bjJ6RHlLWEp3K2hRbFFkMEJqUk56?=
 =?utf-8?B?Nk9JUkt3N3BDZlAwKytQOGxBQiszVHBabThZQjdmWkZ5Z0I3RXBMNjl6S1lH?=
 =?utf-8?B?SVJPbjZZOGZCZ2ZaeGxtQy9Fb1VNaGFVU1hrZ1VHYndjRGNSdXNiam1FNzVT?=
 =?utf-8?B?aDkxeFVhS0xsaERhUE9nYnNZMmIrNDkwUEZDY0NTcFJibXhiMkw0anByTDND?=
 =?utf-8?B?NDVVcldST0dScmp1SHF0cWl5NERZRUplTU0vemg1KzdicVltdzc4dTE0T3B5?=
 =?utf-8?B?a3FRSTc2RTh2akFPbVNVNGVxcU5qNEZjampITHhRU1pMZEs0b29VbVlvTWY5?=
 =?utf-8?B?QStrZjI5R1d2MldZM0tqZmZHTUFHYkRCSHZER29hVUlwaWNaM2FsUFpOS3VX?=
 =?utf-8?B?UGY4TGFnUVBZRHplbitzeGxTQUp2aWZoSk42MWY3enR0cm1KamRWeVlLQ3dk?=
 =?utf-8?B?V2taSUJOQVRFaVBmZTV1ZHVXbGs3WjJ1Zno2ZllrQkNHUFhqbm9ZUFI1cjI5?=
 =?utf-8?B?c29RblJGalpOU3pSUHVpNytTVGJjb29EVVJuRmY2L1lXa2k5a3B0eHg3UWZu?=
 =?utf-8?B?bXl5enlLYXlZRDFPaXZjRDBXeGFGUlV3YWRuUkFja1VDZmVwMTdxUERwNkcr?=
 =?utf-8?B?aFBFZEJEWVdFSG53NEdCb1hwUDdXdGUrQVJ3VGYrUS9sL2Q0dXZ3MHlLdmIx?=
 =?utf-8?B?LzZoOVhjYUg1RWVBSmhaWkNUZG1XeHJPRjNIZitFY09XcCtNdVV2cjJQMGtQ?=
 =?utf-8?B?V0Y5Rm5EMDFiMmQwZUdlRDJUVjhmUTkzeEhsVmUySHc3a2lCRUd6VG1qOTJ0?=
 =?utf-8?B?Wk5teEZwK3lraVBhMS9kUklJbERyYlVTYmhYcEgxTmFRSTlRVkpPMDAxZGxq?=
 =?utf-8?B?UUplbjFHQ1V0N2YrUnljNE1lRk9ZUDZsL1EwMFltOVVHQzZiM0V0WENYQ0hQ?=
 =?utf-8?B?NW9MdGNJZG5OUVB2dkhDTnZETVExZUJqUHo1R3UyR1lPaGxOekVobVNzSG1L?=
 =?utf-8?B?VGNydkpCNi9yc3RsQmhERzBlM0x2eVpKU1VwQWthSEhVc2hueks4dVpUMzZz?=
 =?utf-8?B?M0JUbFl2U0dTc2lycXA3YW1rZ25SR21OcVEybkg4Mko5eXJFM0ZVYTY3Lzhu?=
 =?utf-8?B?dlFPbmxZN1N2RTFRY1hVdFVSS2p5QUlnbWFEaDJlVVZqdXkrQWp1Z3dwMStI?=
 =?utf-8?B?RldoOSthb05KUmpLUEZEbnFDeERaT0R1eGlVeHNSOVNvRnRpRmlrZUNza253?=
 =?utf-8?B?cUNzTnFOOERoWlpHQlZ2NXplcGFXU2dDUlVyRCtDNTRvRE5rcWhVckVVL1Rz?=
 =?utf-8?B?c0pPVWRJb2F6dzJrK09jSkh0VkY5ZHZGNTJVK3cycFZ6TjFMT0lwTDRLZ3lK?=
 =?utf-8?B?MXdqdXh2cGV6M2xURFRmN05TR0NHS2ZJVlEzcU9FS1dQWHBKVHo2cDcwWStr?=
 =?utf-8?B?UnYwUGswcXdYNlNhYVVVc1g5TG9KbWxXL3psVEVmcnF2bWR0c3hxdm1Rc3RC?=
 =?utf-8?B?eWNkSzZJdFg1eFgyRlZHclJLVlFiaXVXYzh3RW5pczFGVVdxMFk2emFUTGFK?=
 =?utf-8?B?VEJDR0tRT0lVRC9MbWx1K1h0ejZxTlhrL2tKRFY4em1MQUVZQ3BsOVJxeXBD?=
 =?utf-8?B?NHRhR1JOY0QyOVd5V24wOEYvVW9xbGhSTCtlcFJUL1VzZVBBcHh5M2hRMXdy?=
 =?utf-8?Q?Gw8NjDqB5RauTjE5ro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5825.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTg3MkxDWiswNzFiUzgyZlpqRTY5ODBTcTBTZXZHTXUvV3RjVTBrbWpNamFK?=
 =?utf-8?B?UXRHZGoyM2xLbjAyQjNCTGRDNDY5eVc0a0dJbEhpYU56Z2hkOE10ZFh5T1Ar?=
 =?utf-8?B?L2QrL09IVXlxd1Rzek8yMFZPa0NEWE9ybHRVdldTT3B3ZDRTK0xkUHVBNExM?=
 =?utf-8?B?Q2tTcHlXNlR2czN5YnhzT21ORnZlVkZEOEk5OXpGblFMbHdhNnF2LzFLRkV6?=
 =?utf-8?B?ZW5HYmRXOHRmcFNBN0lsczRDcHJ5SGtZYzVIMERpSFp6b3VyWTlBN01vYllS?=
 =?utf-8?B?N1J6R1BPYjZ3T0NtcFhBajdYUUM1YlRWdkc2WE5SNEw1dk9HVWdJaERDelQw?=
 =?utf-8?B?UWFqRWV0YmpFbmNUa3dXQWZ3b1B0VnZjK0xkUXF5MjFQaXRFOHE5ZWFZVVdB?=
 =?utf-8?B?QlNTYVg4NFRLWU94ejlFUWRKUEd3aUg0bFBWUTRxVHhhQ3d4YkhmelJwVkl4?=
 =?utf-8?B?MXF4RVRjUEFhQ1VmYWZJYzdXemU3YXhhTG9FVXljZHZEY0Y5aEtnb0JDMERq?=
 =?utf-8?B?bmNCQUt1b1NpbFRiVXpqd0xMLzYrK281bC8yaGdwTmpXNTBYcWlMeWx4U0NC?=
 =?utf-8?B?aVJOcnBNQ01TK0pDeVF2bXR1ZHFtbm02S01VWHlBdDhIaWl5enFGOGtzK3RL?=
 =?utf-8?B?U2tDME5zMWEzcjJOZGdCcmFNdk95RzRpQVJ6azVmUEsySlUzVHVrKytYSlE1?=
 =?utf-8?B?QVYwNjdlTzh0Q1doZXR3WHR5dEpoaTF0S0pMV2FWTUtpQzZsMkljMGlPUHRQ?=
 =?utf-8?B?ZjVuTHFqUC9zM2tmczZaUFZLNGI5TldTSjAwVys2aWlVeDlHbFlGTldqNWdT?=
 =?utf-8?B?bnQxZ0FoTG5Zd0pkbnVXQmpMLzdWdnAxQzA0YjUxaWVBZTJnNVBZbGxTZ1Br?=
 =?utf-8?B?bUJMQllSczVzV3Q1ZWRCTmZpN0p4L2NnR0JoTWppc1hQR1gwSkRuSk1aaWMr?=
 =?utf-8?B?bDNFWnAxMnNQVlg1aU5JU0xJUDk5ZENWREdhOWdUbFJVS3lOd2V2VEpEdWhu?=
 =?utf-8?B?bFU0aHFPWVJwNnpQQk5nSGdnai9UcjFYUEZtN3NzTExLV1EvVkNjVjFMNktN?=
 =?utf-8?B?TEdoeDMvR0pKOUh6Z1VKWXNRdFEzQmxhaGVySUtkS0d5K2lTWFNDV2lsOUU5?=
 =?utf-8?B?VndWdDltVVNPYkVXUWJXTnNmZmFrbGQzeFlWd2JyVXVmRTBYNTJrYWxXbUk3?=
 =?utf-8?B?TEFIaFMzckU0YXgzS2FOL1Z0LzRTaEpTcU1yUDJIOTNEZytPVVR0VGtnQmR0?=
 =?utf-8?B?L3NEWG9BWlBQSVZkNEZFSkxWNmZxVmsyVzZjaU1XZVozM1E0QSt0Z1hXUTZP?=
 =?utf-8?B?U3VDeWVCRW41N3JVVkhZRzZLTXpIWS9MZ0Rlc3cxWnZOZ1Y1azZKSTExYWJy?=
 =?utf-8?B?aFV4V0MrVEIwdmdWbnFRbjAvaVNzNXV1a1c2b243ckhoYlRaWm9LNCszRVdi?=
 =?utf-8?B?NFVDdDZiY1RGOVdFZW50VG9OaTUvUHpqVkNVbkZEUjArY1hlalRudStMS1Qv?=
 =?utf-8?B?SzFJZFp2Nlg0aU5CVUFzVHhGekNVYkgzYWdvZ1JnektnaUdSclBjT1Rwbitl?=
 =?utf-8?B?M0ttSElmbjZ2ZytEbkd5ODJYT04wMGNrVkpnSml1alRNcW5xdmI2MW5TRXZk?=
 =?utf-8?B?KytvZDNubDk0dHRsR0k2ek9JTG1nTWk3ZkZYOENBNGVRcFZ6eUhOcUx1SldS?=
 =?utf-8?B?U01GdWRTME1QT2Z3ZlFvVkI0UWFkVmJZZU9wbXVqM1RYbTBiMDlveURYUHM5?=
 =?utf-8?B?WjV2eFF3MEYwN3VxL0pscnFoQkQ1aU1EV1UwZjdLM2I2RkZNNGtjaVhFVjBk?=
 =?utf-8?B?dkxoY0Zmczd0aTRpTHVEcnQ0Y1dpUnZONXNUWXFDZVJMWHcxd01HMjdVbXdO?=
 =?utf-8?B?eThva2g0SlV5bzllckQzTjZxOXJ2S1VSczlVaTdSNFVFL3JuNFBOMUlXRW5K?=
 =?utf-8?B?WjBYdlFCVE9uSTZ3RU1kc0pZMk51eEdCazJTTURLNmhXTXpVTlZjVS9Majh3?=
 =?utf-8?B?aXVNQmQzNWMyclVKVlBKVzNsUlYycTAydjhkdlNxZXdFR0FNMzZESXROcWxh?=
 =?utf-8?B?ODRYRHNpQnFxNHJaV3hscFBrN3ZkUjlHczNkNUg3cUx4ZUUycWFETks1eFRW?=
 =?utf-8?Q?d31C4J078MP3v7+NsgEQRow8C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f3bb09-683d-43f2-a299-08dcf813bc6a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5825.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 12:18:03.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7zoOYa4LVyaYzu7yJ/rZdXJz6i0sNdp2ibdLqsUfwUQeWpfe+X2tq28znastlWPIsNSKHpC+qoJpvc3k301Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409

Hi,

Any comments?

Thanks
Feng

On 2024-10-24 a.m.9:54, Feng Liu wrote:
> vp_modern_avq_cleanup() and vp_del_vqs() clean up admin vq
> resources by virtio_pci_vq_info pointer. The info pointer of admin
> vq is stored in vp_dev->admin_vq.info instead of vp_dev->vqs[].
> Using the info pointer from vp_dev->vqs[] for admin vq causes a
> kernel NULL pointer dereference bug.
> In vp_modern_avq_cleanup() and vp_del_vqs(), get the info pointer
> from vp_dev->admin_vq.info for admin vq to clean up the resources.
> Also make info ptr as argument of vp_del_vq() to be symmetric with
> vp_setup_vq().
> 
> vp_reset calls vp_modern_avq_cleanup, and causes the Call Trace:
> ==================================================================
> BUG: kernel NULL pointer dereference, address:0000000000000000
> ...
> CPU: 49 UID: 0 PID: 4439 Comm: modprobe Not tainted 6.11.0-rc5 #1
> RIP: 0010:vp_reset+0x57/0x90 [virtio_pci]
> Call Trace:
>   <TASK>
> ...
>   ? vp_reset+0x57/0x90 [virtio_pci]
>   ? vp_reset+0x38/0x90 [virtio_pci]
>   virtio_reset_device+0x1d/0x30
>   remove_vq_common+0x1c/0x1a0 [virtio_net]
>   virtnet_remove+0xa1/0xc0 [virtio_net]
>   virtio_dev_remove+0x46/0xa0
> ...
>   virtio_pci_driver_exit+0x14/0x810 [virtio_pci]
> ==================================================================
> 
> Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>   drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
>   drivers/virtio/virtio_pci_common.h |  1 +
>   drivers/virtio/virtio_pci_modern.c | 12 +-----------
>   3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c44d8ba00c02..88074451dd61 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -24,6 +24,16 @@ MODULE_PARM_DESC(force_legacy,
>   		 "Force legacy mode for transitional virtio 1 devices");
>   #endif
>   
> +bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> +		return false;
> +
> +	return index == vp_dev->admin_vq.vq_index;
> +}
> +
>   /* wait for pending irq handlers */
>   void vp_synchronize_vectors(struct virtio_device *vdev)
>   {
> @@ -234,10 +244,9 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
>   	return vq;
>   }
>   
> -static void vp_del_vq(struct virtqueue *vq)
> +static void vp_del_vq(struct virtqueue *vq, struct virtio_pci_vq_info *info)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> -	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
>   	unsigned long flags;
>   
>   	/*
> @@ -258,13 +267,16 @@ static void vp_del_vq(struct virtqueue *vq)
>   void vp_del_vqs(struct virtio_device *vdev)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_vq_info *info;
>   	struct virtqueue *vq, *n;
>   	int i;
>   
>   	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> -		if (vp_dev->per_vq_vectors) {
> -			int v = vp_dev->vqs[vq->index]->msix_vector;
> +		info = vp_is_avq(vdev, vq->index) ? vp_dev->admin_vq.info :
> +						    vp_dev->vqs[vq->index];
>   
> +		if (vp_dev->per_vq_vectors) {
> +			int v = info->msix_vector;
>   			if (v != VIRTIO_MSI_NO_VECTOR &&
>   			    !vp_is_slow_path_vector(v)) {
>   				int irq = pci_irq_vector(vp_dev->pci_dev, v);
> @@ -273,7 +285,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>   				free_irq(irq, vq);
>   			}
>   		}
> -		vp_del_vq(vq);
> +		vp_del_vq(vq, info);
>   	}
>   	vp_dev->per_vq_vectors = false;
>   
> @@ -354,7 +366,7 @@ vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
>   			  vring_interrupt, 0,
>   			  vp_dev->msix_names[msix_vec], vq);
>   	if (err) {
> -		vp_del_vq(vq);
> +		vp_del_vq(vq, *p_info);
>   		return ERR_PTR(err);
>   	}
>   
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 1d9c49947f52..8beecf23ec85 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -178,6 +178,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
>   #define VIRTIO_ADMIN_CMD_BITMAP 0
>   #endif
>   
> +bool vp_is_avq(struct virtio_device *vdev, unsigned int index);
>   void vp_modern_avq_done(struct virtqueue *vq);
>   int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>   			     struct virtio_admin_cmd *cmd);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9193c30d640a..4fbcbc7a9ae1 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -43,16 +43,6 @@ static int vp_avq_index(struct virtio_device *vdev, u16 *index, u16 *num)
>   	return 0;
>   }
>   
> -static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
> -{
> -	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -
> -	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> -		return false;
> -
> -	return index == vp_dev->admin_vq.vq_index;
> -}
> -
>   void vp_modern_avq_done(struct virtqueue *vq)
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> @@ -245,7 +235,7 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>   	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>   		return;
>   
> -	vq = vp_dev->vqs[vp_dev->admin_vq.vq_index]->vq;
> +	vq = vp_dev->admin_vq.info->vq;
>   	if (!vq)
>   		return;
>   
