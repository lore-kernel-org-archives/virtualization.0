Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021522A7F8
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612377; cv=fail; b=EE4AGvka/eJNWxFmI63AQaVVNPX0zDYejHwcXUCT+XYpZR5tjffVbT7sl46zX01jXlkLzT/Sh9YoIiheEmVZKPEe06I9Ef6Cd1SjNKcx2GS8TnMAWMPHfzZHDeqg/SAhCcA3FtllkdTYjk7TMBVM4s9ALFIQhxx0Y4Pfqy7bWiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612377; c=relaxed/simple;
	bh=OCcFT+bEGzJWv+LuE6HMZwKQBG//njDmLFSsUCjm8aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I8JvSgybSIBqCmJe8ah1eP7Qp7fT7vh1+4FArB63DskytApX9KXX6/GPEpGHJgbLmYytRNsN28QicbSWuZz6SbAi6x9fAfS2LUL8Hv7VQNUQ9ddYZDm4d2I7bpoeIdVqgJUIYLY0x09XStE3gsfpTK1GnCosFo/97q7k94ktBP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KR9OyoaV; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KR9OyoaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOgRaiJJMvyxlALbCjYodcGMNTWIgzc6928U7Xby4YFiLAcp5d3s4HbEqmWqf7AbD4Z6rc5m9Noz8puu8dMRsDFSdyeaWWH7qxNydkmNa2056vBd942Kluaiov6Ua6RgxohQm6PPQ5MsoVV2q7R8FfhAU0Qr5ypcMxyzoTzgOkuveD7vP1zH4GRNWwrhBOg0QMtBAspRnLvI35ntzrUcFEykDFJClpteTLvunq8fkQ4c4hyitZ/AeReVxh79YuzYCvIB1cZqhhcHLFR66j+CIBA4MSfjoyo2oAxMJKDd9AjepVkmqz1JDBShLXSPEKYX4xB/vNuWZxvHfy+GSNR3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7SYltPz2oE7O6rWGDApjEkNWSQoqCGdgxxGwZYWP0w=;
 b=lOvWIGtcfAYZh4+VoWDE5M7ZIRZpwIRvaF0uosrgI3v/BAiZkwfSim/Al+drQtuS1dmX33U/IIDP3+tTbceZlRiRCpQ6YmNDX3dhZ/UstFzDpQ98PEgABQ7SuVg8RUh0Zffai1xizg3zIFce5s5hxe3iXusH8jgdl9MMWdjBGR+CwThOcmOPjWXa9N5kLPWa+ayxJrYUxrzdhhT/b997jERV69upQe0jBS/aitaqAu51iSbgmpjtvky2GJrs8D2DTaFfgr+FgSebNE+mOOf8pfcfeSZTUTZR9yGcp5VGmkrJwZoZl6FuRZkO09H9OO/c4songwLQbG7FTxFObHoaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7SYltPz2oE7O6rWGDApjEkNWSQoqCGdgxxGwZYWP0w=;
 b=KR9OyoaVsjRbGuy2NYLY/RS5PUhSMXJvgfFsvjs9lJKVNY5VEh1254zGxpcLRZrhJIwT+yVi4UqYTwbHWv0vwegnfVlZji9veutGv2KQTt5VKgyzwKSVSOKMra9Z60UblZO3aL4+cxOTVzt40kU42JCh0EKxvmxsT3naEimRHMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 13:12:49 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:12:49 +0000
Message-ID: <c2f26b4f-e42c-f152-c33d-4c0dd8d68da6@amd.com>
Date: Mon, 10 Mar 2025 08:12:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
To: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>
Cc: kevinloughlin@google.com, bcm-kernel-feedback-list@broadcom.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, ye.li@broadcom.com, bo.gan@broadcom.com,
 vamsi-krishna.brahmajosyula@broadcom.com, alexey.makhalov@broadcom.com,
 vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
 <20250310102607.GDZ86-P3VFA-x2iy4l@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250310102607.GDZ86-P3VFA-x2iy4l@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0446.namprd03.prod.outlook.com
 (2603:10b6:610:10e::35) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: de90922e-918d-4227-abc3-08dd5fd541ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnUwNHpNMXYzN2tuSjNoQis5R040akdMc1ByeTlLcFdyOXE4MFlDNm1kMXpo?=
 =?utf-8?B?N2xJcDk4UXBKSTJobHVJYUVQb1NxMjVFa09CTHZBYVM3dndkRGlUZGVWakIv?=
 =?utf-8?B?eXY0TGV0aWQ0bzlKcVBmM0h0UDdCekpCQUNuQytMTjBJaUNrMlBJM2xNVGl1?=
 =?utf-8?B?bmVTUzluNVUvbXQ0TGVxT3lZZnJod1AxNzFibVFPeEF3ZCswbXEyZlJDdXhZ?=
 =?utf-8?B?TE51eW5vQ2Q2QVV4RDRCU3VYYUF4MEwvY25jRWpvTWE2NnZaNjBJMWp2WlFy?=
 =?utf-8?B?ZFZsdGQ0RzNXclVLMldzSm9jUUlzc1drbDVzelJwRENwa2U4M1NlVmtjRURC?=
 =?utf-8?B?ZFdSSDNMMXBZNk1LZ3NwN25jaHI3dXl4WVh2SjFlTmExWXJCL3hndzQyYUFG?=
 =?utf-8?B?YTg2NWNuMXVUTDV2dWlMNnhZSFVCdFpicXJtdkEydkZvbXlPV1NSM1JIbW00?=
 =?utf-8?B?RXpUS1F5b1d3enBsZTk3WjBUTmljdHRxNy80anNTN1pRQko2cGZOZitvU0VO?=
 =?utf-8?B?Vis4MkI3dnZkbXN6dFovb205ejlMVVNkQWg4Z3hWSWptTFJ4dlVFTlAxRTF4?=
 =?utf-8?B?cUZwalloaHlpaFBhalMzd2lLcHJZR2xmcndFdkxKYXEwZ3FtUzhEWTJ0YjNw?=
 =?utf-8?B?RzZva29OeTBDUkt3K25uaFFjSlZrSE1BbmhGYlhjaGkvVTdkRFlEL2l5V0R5?=
 =?utf-8?B?OG1yL2ZUTjAyNTVFTUVFcGw0TFd5OWFrSmVOLy9NWjB6SUp5blF0ekhVYkNZ?=
 =?utf-8?B?dkN3NFlnbmNJWERCVkxMVXBoN05MY0RjdXJxRDl3aHN4dU9lOGhVVUFVSHdO?=
 =?utf-8?B?ZUpOcHZHNUpTSGtabEY2bEQ3WVQ2RVpPb3lBWGRUZWRyUkNrdmh2MWNpNG92?=
 =?utf-8?B?TmNKUzJ3UEFyanI3MlVEOGU0R0dFVzVmWHIrb3kreGZwdzdlRno3WjVGZGRC?=
 =?utf-8?B?aHIxbTFjVTJaRjkwRzJFdERHOFlwMkVaZWIwNEN5eUJBdHY5cUM4ZmJXVTNq?=
 =?utf-8?B?bDN5RnU1S1pEemh3TmJkYzJxcDVMLys2dytBVVBkM293VlR1UjMzQWcwNnlB?=
 =?utf-8?B?SzFucnhIMHZHaU4xQzVYYkRMMFYxTm0vNnIwRzdpME1PWGVqTVhTdHZPUEdB?=
 =?utf-8?B?NVkxWFh0bStsUCtQNXdHMFdoNXRpbDZiT0Z1WCszNGRaOHNZajJsTWNnWTB2?=
 =?utf-8?B?R3RlZi9kcVZVcXByMnpwZlZITE9LOU5va2dNRE1vY1pQb2tSdHlNb0w5Qmwv?=
 =?utf-8?B?R0UxK0o2QXVYRGVVdWRvZnoyR2VGdU1wTFplU2dNbS9seW5nQ2lDVGVjSTJk?=
 =?utf-8?B?eXhGM3B3SWxrdDcxcWN4enQxbnZOZkhydFFldmNTaXM4SGlTaEJHUHFMbnAr?=
 =?utf-8?B?bEk5aHJ0QllGU01KbFM1SndMOEVlRFpNLzFRd1kyYUlBQ1JxZlBydWZXOWRs?=
 =?utf-8?B?bll3a29aa1pRL3pFcnZQYWpEeHFBZ3JqL1JPSlZic2VYL0FrR1RTZHZvWUo1?=
 =?utf-8?B?S09aS3pMVlZ0aFZ6UGx6enlvbG1RdDMzSk5rQU9HWjY2Qm1qWmNON0hiUnpx?=
 =?utf-8?B?WUQyKytWQ0tTZHRaRXZHNlpySnA0ZHowRFlnbXJwS0JqNHNERkx6YzJBbDgr?=
 =?utf-8?B?M3BlNkNQUGVJY0Rlcm1zODJGNmswS2NCcG9NNUFVbWRwMmRpQjkrK3AvMC8v?=
 =?utf-8?B?NW4zRDNBZjh2ZzJFbGJ3cUduSGxidFF2c2hlNlI2Si9pcTlkY1QvWWNFcktU?=
 =?utf-8?B?T0dsV21aYkYxQWtad3M5MjljQnV5SEE4WE95SWRDa01pOHJ3K2FydjZqQnJ1?=
 =?utf-8?B?QmhJMTBHVlhOMEk1aWJKRS9VUEtFSDNNRm5Td3daK3dsL2VkcXZKSnFLQURx?=
 =?utf-8?Q?i0fP1HcDlLUOj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVpTkhuSCtLYS83K0xVQ1dHSmdzUTkrdUJqV0t6bVVPbXhpcTA2dGFPQTFD?=
 =?utf-8?B?akZROWdqQmdvS0VSZFArNW9NY2V6NDc4TDVGSkt0ZHU2eWtGVzFTeHU3VEta?=
 =?utf-8?B?UUdVUzRIMkNNSzcvZkFVY0cvS0pRb0VWMkNTZlhsaXUwM3g5ZzRSSzRZYllm?=
 =?utf-8?B?RGhha3VqUHhKQzJjbVVLR3o5WnRISTFUekp3ejBlREJPazJMVHExbllyQmND?=
 =?utf-8?B?OVJ3cTZ4VnIvREFEWmlPZWNDVi9acHhzdk1XbHFMSEZNdlBuclZLVlN0QThn?=
 =?utf-8?B?a2xNRFEvQUJuaWQxMWJIYjdaRTgvRGxtOWxTbExidURIRU5oNEROdHhTTzNm?=
 =?utf-8?B?Zi9EZHhEcDVzVUc1VkMvWFg1Vnh1UUg3VDd4MVhybVR3Um16ZU5OZG82aktG?=
 =?utf-8?B?WjAzamhmZnBMWGJXMUQxSzcvTjk2OHQ3azFhbGVDU2twbE8vYzFHNTdxNFBY?=
 =?utf-8?B?T1F3SStKVGJWc3ZQNGZXdDF2RjlTUXRLZUlEek5YWEszRDU1am1IaW54ajlr?=
 =?utf-8?B?ZXlWdXZldTJzWm9zaWZleE1iN1M0L1NERTk3d1dDS1VJOEptRGpJZmd3OHNY?=
 =?utf-8?B?M29ad2QycnhxTHB3RG1GYUNrakVoSzRQb3U3aWJjbDU0TVB3R2pjeUM1SGE2?=
 =?utf-8?B?N0IwTEpyYXBjdXlzemhxSm04WG10ZVNBMnZTZjRSVTU3eUZta3VpOEJYNHlL?=
 =?utf-8?B?K0dXQ2hVK0Y2MVJKOGFnNGtsTVorY3BGMVpwNElQbHlleElCWlVqZE5LeHRh?=
 =?utf-8?B?c2hOa2xPUnRhVXBQaGN0TFZhVDRpT3VxSkpvTXU3TzhYeC9JZDRwUmFuTXFB?=
 =?utf-8?B?OTVoKzBRbGNmRzkrempBSE9CSEhObTdtNVRWZEd3b2tMRDkwMTRRdE1IRnJR?=
 =?utf-8?B?TjU1TVRtWjNiNXpYdCtIWTJ5cDdwZ0xIanRoSkZVbk9Bd21TNTFOOGI5SVIw?=
 =?utf-8?B?UC95cnlQSHY4WXk1WVpzMU9NOE1yZ0V3cU9sWWc4Q3p4aFZjaUFuT0EwUk5x?=
 =?utf-8?B?NDh3NmF6SjJWaFg4R2cwSVc5cE9XVjRoSmViWmlOOFliSk5tdVIrTzdBcjkv?=
 =?utf-8?B?K3piOUtQQVNqWW1Rb01pNjgzM0k0OVR4eHZMYmhjMFRJME9DRDc0ZmQwRVVo?=
 =?utf-8?B?Y01lQ0QrN05IV1QxUTcrNFE3UkJtZk9VK0xIczFXQk1mdWp6LzBnejBOVnNJ?=
 =?utf-8?B?ZktzU0RPV05manBwTjRwaHdWRS9BdkVuZDB6djRNNG1CSG5VaUVMOExlQWhM?=
 =?utf-8?B?MzBUeWQvVmxjbHBNeHJrM1pMQ0pULzE5bDUvRkg3NU1oWjFxa21FYkhnVkRo?=
 =?utf-8?B?ZWl3YzFzVVlHclJYdmIwOU5FM0V2WUtBbVJxNUlhSnUzemE4OUNkMGV4L05X?=
 =?utf-8?B?M3FkNUlQTE8xZFZQRk43a0wyQm9kV3E5WDZhVDhTSnBmWWNWaERyMTdYVnFE?=
 =?utf-8?B?L0FoMHpOdUh4TXNGYU5XMnh6WkdoK21oUmlxU1lhWjJlL0tTSG1DTTZnR2cv?=
 =?utf-8?B?U2c4N253bVpwWHhmM3dHTzV1WjBWc05UVml6YkMwbnJaMC9VUk8zLzZlL3dH?=
 =?utf-8?B?VlhGQjVQRC9Ub0xJZVdGeEZGQmFiemtJUmpwWnVuNm1IV242RUpmOCtjYWh3?=
 =?utf-8?B?ek1IZ1dYSlIyWTNNRVNOUnFXWVFxOTFSWkxOdGhRLytvbjJJbWlZblJNQlc4?=
 =?utf-8?B?THNZQitibENEazRibzdrWnJ4ODl5R0FTN3R2UnZiRmdvWUlqRzVETFlrRTRF?=
 =?utf-8?B?VTRkeXB2cW1kUHY5MW5Wb0hoSXY3VitkL3RManZQY1BzMXNscmtZeTA3a1Vi?=
 =?utf-8?B?b3YwOWZ5TGFjdjUzU1B3aldBUVdyZzN1UFYxR2JZWUdGeVNxQ2p1dU82aVR5?=
 =?utf-8?B?SHI5ZGErZW16QmlDMEw5Z200VWFxRi83MnlzZHQxYmdCMk9Fckx2OW8yaGU2?=
 =?utf-8?B?MC9YTHQ3MkdxOXNIRGtVNEU0dDFLSXVKVGxXNGVJTlVDYWdDYXZ3SHVKZWt3?=
 =?utf-8?B?b0FkZDFPODdHK3VPNFNXcFlaZ3hzT1RUQ2VWVHdUeG53K1RRcDlpdGhQNHdN?=
 =?utf-8?B?L2dmVjdkWis0ZEtNS29aUHZWekY2SGRXdmw4OERuRWtlS3hGN2xPaFJzUkIw?=
 =?utf-8?Q?UDyfGNimEoDU+7dmrXm+iv3Mt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de90922e-918d-4227-abc3-08dd5fd541ab
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 13:12:49.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nI9rc3Hypm1HcxbjIjTNFZhstQPcdZhuMUD3S4mdcGZ8vIWsanFEP2ehdq/M6cTpqMROxHWo94q2R0TsBgE0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

On 3/10/25 05:26, Borislav Petkov wrote:
> On Thu, Dec 19, 2024 at 11:44:00AM +0000, Ajay Kaher wrote:
>> For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
>> In this case, mpparse_find_mptable() has to be called to parse MP
>> tables which contains boot information.
>>
>> Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
>> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
>> Signed-off-by: Ye Li <ye.li@broadcom.com>
>> Tested-by: Ye Li <ye.li@broadcom.com>
> 
> That SOB chain is wrong. Ye's SOB means, he's sending the patch but that
> doesn't look like it.
> 
>> ---
>>  arch/x86/kernel/cpu/vmware.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>> index 00189cd..3e2594d 100644
>> --- a/arch/x86/kernel/cpu/vmware.c
>> +++ b/arch/x86/kernel/cpu/vmware.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/export.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/cpu.h>
>> +#include <linux/efi.h>
>>  #include <linux/reboot.h>
>>  #include <linux/static_call.h>
>>  #include <asm/div64.h>
>> @@ -35,6 +36,8 @@
>>  #include <asm/apic.h>
>>  #include <asm/vmware.h>
>>  #include <asm/svm.h>
>> +#include <asm/mem_encrypt.h>
>> +#include <asm/efi.h>
>>  
>>  #undef pr_fmt
>>  #define pr_fmt(fmt)	"vmware: " fmt
>> @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
>>  		pr_warn("Failed to get TSC freq from the hypervisor\n");
>>  	}
>>  
>> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> 
> cpu_feature_enabled(X86_FEATURE_SEV_SNP)

I think this should really be cc_platform_has(CC_ATTR_GUEST_SEV_SNP).

Thanks,
Tom

> 
>> +	    !efi_enabled(EFI_BOOT))
>> +		x86_init.mpparse.find_mptable = mpparse_find_mptable;
>> +
>>  	vmware_paravirt_ops_setup();
>>  
>>  #ifdef CONFIG_X86_IO_APIC
>> -- 
> 
