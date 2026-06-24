Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FE3BCD3E;
	Wed, 24 Jun 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311020; cv=fail; b=ffxhQiBDyzVfAMhGzV6LkWypYF6/lHKJwDEyw/ExyQqS2xBsHkZmW6FBkE9E6ODd4BtLY1CUJjHircFv5XHenrj1N7RXcb8vCo2ouM8Wu4Tk8jh3WBEPMmLnL9UbNMB1JoIzNGfsxSiAsHEOm/JqaApWAmSUOzDzkiSv1K6US7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311020; c=relaxed/simple;
	bh=sSJHy08IeXPUlXvX6nOxnJ2RDt5RPf2xYznHUFOzRSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swbu6HZ4h+92YgjTnf6dr+s7KZgD7I1QyN2T6IN6e+QwDu/i8nr47unpsVB7wKFVdL876StnQj7nwgJc9ZV5J60ukyUbbggItZqvBTsUadehc6w93ks5edcPMrnUKMpyn8/kDMtglunQswScUfE74xZHnJTMljqIZZbNocOCqnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a+Slyn1A; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a+Slyn1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El7098Bz3LcKh9v+qW12go1kitYEUejShE1pgjlNPNtPMF3ujM196v9G+FF+Wa7qWdqDwoGuEqc4GXI3upBFK3m7u5H1wWM0b30MOGlFTd0C5juepAp5n8ZpzgGomqWWcPYcZ9uay/U0zeRskE/lk4Cpwia+EHABtmq1/OvGL7pNDVviPIZi7OIjPsCri0mLGC+QGIkt+UG7N+xGkGZQuJlygXYjn5qOEiaV6x0Rzipe4UxYR6dBDqpPJnLIxSmZHkauQKm9azl7FnNVRQrpmRRXawx9eMR4De4ElLnjJFQpm7RHIxRSylass2K63i+AVe0EMzghfMUYKGF+I1sLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz+46/RoVSyvF5KwRSS5OXmsw+HU4OKwc3ca61cqU38=;
 b=Z/AEEoLA7weg3uvarCk3ug+qj3Ips+j2sOXF62jFo9YcXRIfGhlf7N4umj83Haqf7wsXnn8ILqfpjZpQzKgi3pOfI+I61C3UdQfZ5LA1tkOyTqs/EtcMzMiR+4aCWQkAunILUE0rBtZQQBJlryGvEiGdES1bH2rZjD0ZiWqbs1dh2xXys3bTs9SuOwlZdE5eOQ5XBFhoMBde+fzbN68KkcC6ZqS9VenR+XMU29ty1uu1elll32bMWpWUIJbeSWPKKpKTn+1Gnd2Ulu0BABqy72Qk+JDBTQQjIzUepzAIfDkTOmUTs0GeWNT6MdKKiSjbyfaQZjOC6MRDhjk/7PJy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz+46/RoVSyvF5KwRSS5OXmsw+HU4OKwc3ca61cqU38=;
 b=a+Slyn1A4mo6gObGaIx+KDJj+di/MKW0yeMVNpJEzJR7Oqn8renF14hdfIFSvjpTjO+YInLUXjyPJD/66SmUwNndEcOEEarpf6Zd3kEvihZwanHLculbzVhNajTCrQTnSd3Z+W0rV7yc0OaC6Bt28YKUB8L+wCG5oT6h8Wb/j/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 14:23:34 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 14:23:34 +0000
Message-ID: <99b5307e-e892-4d82-9e85-4f664b4d29b9@amd.com>
Date: Wed, 24 Jun 2026 10:23:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFCv2 PATCH 1/6] efi/unaccepted: Support hotplug memory in
 unaccepted bitmap via SRAT
To: Kiryl Shutsemau <kas@kernel.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: marcandre.lureau@redhat.com, david@kernel.org,
 rick.p.edgecombe@intel.com, pbonzini@redhat.com, mst@redhat.com,
 peterx@redhat.com, chenyi.qiang@intel.com, elena.reshetova@intel.com,
 michael.roth@amd.com, ackerleytng@google.com, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, virtualization@lists.linux.dev, x86@kernel.org,
 yilun.xu@intel.com, xiaoyao.li@intel.com, chao.p.peng@intel.com
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <20260623101739.79695-2-zhenzhong.duan@intel.com>
 <ajvLaBs62bDoxC3W@thinkstation>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <ajvLaBs62bDoxC3W@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::9) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 7403ff75-4e57-40c1-1e72-08ded1fc2c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|4143699003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VWxAI8iGir+nHlw/JOugUVEC1nACOQW+GqRlYAfCNUpPE0ssZOnvPKCauTqRCHJwB46WbLqPT+ns5wBUiPHbefqPw5q1SS7UwIhmXyzdLd7sQfCWF7sbftMByAORC37ua6CRxF5jaBKnu1bTN2upsheGYH6L36OLbcDMQ31cei6dLP79TwHO96QDyVnz9W7d2OePdZgfDlzgWyFHfzWx6u6T4Xee2uC/KrnwzehkPvpYuYev5lQwBHKR/Pt/gTtfeNU72SKzH+NYT0RdhyEbnOefkp5r7VlMM9cRRY90CI1g6nf/Pmy0AKoOHtwDDlz59TNHfavwyAt6C98sLbLTZIeanzdz5CpWAXiBZz8JQ6n+hdCFClBp88SqAUSfsnb6Q6jHdHM0gvh2iSQY8tqxFz2rEDWRXGFBxGtaTZXWxB8v3bHJsOmRT2sGNE24Nox1KLNQZB1rIi9f1gckloOL+ZDerJ7UbcaY1KuAN3LYCxCCM3rLiXVcVek/R0+WuasxlkZaLmNCupW1N8S1P+AIvS5UjQn8T6EH5c/7VsRovhcGjIAb8Hz7fpAzQc1/FvaczGvc5eEC8LB1qv5nY+ChlUCpe76PHrp826KilRxa4D6YShAWx0tiNXzww9jO7Oth7F7x/706Yp/h+8Vn2RtalxtdfZxz/g5GgL0etbNvlb4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(4143699003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1d4N2luYWpnWmF2VUZGWnUyL1hjN3F4eHc0NG0xbGJVam5lSW4zcGtEYmd5?=
 =?utf-8?B?VS9Ya3R1Tk1xMHZ2TFpnbGJDdExzZ25rSjlEUGNkV2xDK1p3SE1CV3BrdFlU?=
 =?utf-8?B?Y3ZqZ3pzSko0Q0tPVmtmTVhqRW0vYjFoSWVYbXAvR2RJdXhzMnZUWTZMZHFB?=
 =?utf-8?B?eHBqOUpCaDg3Zmk1TEg2NUU2ZGo4RDRDUzIrdXZ4WDVNWUVDUWIvbEVsRW1P?=
 =?utf-8?B?Q3p5SGJnZ3RRZHVuSjVlME1aSU84dVlUc3hsVFdZajZBaXRBRXcxTXFWa2tl?=
 =?utf-8?B?RmJvRnBKdVBqeWExUVUwRWFwY3NvTTRwV3hJVFppdCtUK2g3YlAwUWEreklz?=
 =?utf-8?B?NTdoSDhwMmtWN2FDdlhGZFNURXZ5T1lDUUNWZGJmRWQ5VjdmS0pwYkpWcnh1?=
 =?utf-8?B?TFlJMzZhSXh5cXJTeUNMMUxNVlpENzkvd1p5Y0J2OXg2dE0yRDhBWXMxUlEx?=
 =?utf-8?B?N3ZMZWY4RGtwVGlFUnRhdUN3VFJuZ2dKN2ZzUlM3dTRWaFE3L2VVR1ZwdDJ2?=
 =?utf-8?B?dGxOSHl2WnE5N0tBTEVVM1c4aHpJNnZKc2xjMk9kTmUzTEpaM3BQUGlVUUpS?=
 =?utf-8?B?VEJOeFVVcVFSVXJYL0lOTVUwaEM1dTBlYnl5UldJb0tnLzd2bkR3R2UrYVE1?=
 =?utf-8?B?a21FRHZVbjMzcTlLNFRaL0hwT1VidTZDYVVENWFtRlFTT20wT2F5NnNoTkpu?=
 =?utf-8?B?RjJudnNsSkhHRXNmdHZCQXVDaEgrZ0lsYXZLWW9SdXZLblM4YURKSmlScC9k?=
 =?utf-8?B?Zmp0UVVWVjdjUmw0dUxCNldPZEFSSjNUbXVkKy9pa3Ara2F2N2hSaUdRRnht?=
 =?utf-8?B?TGhBYkFKNFVKVVBIbXJCb2RLV3ltQkJaU0xIcURVOUdXT0lnOG4yUmlrcFR5?=
 =?utf-8?B?Zy92U0ZwQlRQZ05wcmpXT2wya3hGSThZTm5DVDlHbXZRa29mVUkxYjNBb3dQ?=
 =?utf-8?B?RVNFWGZsUkhta3hVU0tlckZ1Sk9kRWdJU3UvMGtkeHJ5Ui9rSUI5aVVTd0wv?=
 =?utf-8?B?NndMVXdKQzBTTTJVVS9sSDNraXJtUWx4cXk4THBFWlV0bW55dmViUTExMUpP?=
 =?utf-8?B?RnNpWTZKY0ZmZk4xdkhkR05INDBLU0JpcGd4dUJtd3lOVkM5cEgwM0lBWDY5?=
 =?utf-8?B?bmtsS0k5cm1CTkRoQ3pOSXpFaEhoMVM2NGhuY25jc05pNGF2d2I0UFZmWlV2?=
 =?utf-8?B?RGlHMVVKMU9kcnUzam5tTlFFSjluNjA4UzdFcnJnbW9EV2VPOXJKRlo4UFJN?=
 =?utf-8?B?RG8va2RrVnZ6UTEzNVhEM1lSSmtENTNuekZURERlMi9sWDFLVHhuK0VFZ2Rk?=
 =?utf-8?B?OHlJWEZLV2RveVJ5bjZWSlh2aXA1NFlPRzFZTTRCNVpTQkdDc0JTNURqUFIy?=
 =?utf-8?B?RGJDN09TRjV3ZHdrcFFwdWx3RXFXUkY5eVJVV1J0eDVGYmlyVFJoRGNTcDFB?=
 =?utf-8?B?SkNuNE1hdUwxVnFEZkw4RHpQRDY0cHZDOER4M3o3OG4xdm5CTWRPMHZoT0po?=
 =?utf-8?B?NnE4TWsyTVNGb0d4ZnFpMGgySkFGRngwZUhWbTNOelZ6dXJqMG84VlRweHNo?=
 =?utf-8?B?S3o5WG5mRGFLOTlWN3B2Qm9yT3pFVGd0MmVzR3MzWHVaZkZxQjdNbEdWSkph?=
 =?utf-8?B?amQyaE1tWFFybGVsV3Fmd0pDNHR3RDdvem9rMVprRWlJSVVZbWpQUUxBUkhI?=
 =?utf-8?B?ZGtJZTcrVlFNUWhBRXlxWXd1MEtRdWorSVVKUlltZzBwbmFMTWVMMGt1NXE0?=
 =?utf-8?B?S3U3d0ZKVERhM3pDRk55aUlSSENOeXhqSDdoSllkMXhHb29tUEwzZ0hmbGtu?=
 =?utf-8?B?VERzVUNrMElWUzJqZGIxYkFGQkhwZmxDOFBrRGQvbWlkYm82T1laa0Y5ZUVl?=
 =?utf-8?B?NEdhVU11c2lwNUY3MTVKNCtKam9wTmRPd0NTNktULzBJWkRmUUcxcEh3cWxE?=
 =?utf-8?B?RjNOVGp2UVVPcUtiSlFhT1Q4VXd2c3pUZTV2MzZkMEloNmJoZDhxeE9jclNk?=
 =?utf-8?B?UmVqMVlmNEcwaG1nU0tLeEgySmN2Qm94eXFLeW95S3doUmpzTDZUODVjY25x?=
 =?utf-8?B?ZEw4V3FoaHhhbkZ1eHVRN3FQTXVpRjhpOUYrRENpN2NXZ0hqVERWY3V1aU5W?=
 =?utf-8?B?QTVoelhtS3Z2N3FYRGNwcC9kTy8wM1RVa0FUZGNRejFqdlBSb3g4K0ZzOTBz?=
 =?utf-8?B?alB5QXVHT1ZmN3hGd1Y2di9TcytMbkxDQnp2SVpZN0ZsOXdBaExCdXgvaFVE?=
 =?utf-8?B?b0tZVGZVNnJtZm43YWVDcDFVWlNRMGxjcUtHdllXNjMvZTNRb255bjh1bHRt?=
 =?utf-8?Q?Ndfv5gpb3AJQUy6+WA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7403ff75-4e57-40c1-1e72-08ded1fc2c7c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:23:34.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRwi2CYEFOPKXnc+kNvWYqPkSopLeGUWUVAIESXaUwDENor9dosUUfHKGpFs0xQzrsuqHiqkpLu/N1H/eQjOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346



On 6/24/26 8:25 AM, Kiryl Shutsemau wrote:
> On Tue, Jun 23, 2026 at 06:17:32AM -0400, Zhenzhong Duan wrote:
>> Currently, allocate_unaccepted_bitmap() only scans the initial EFI
>> boot memory map. This misses hotpluggable ranges described in the
>> ACPI SRAT. Without early tracking, hotplug pages are accessed without
>> acceptance and this triggers guest crash.
>>
>> Introduce a lightweight ACPI SRAT parser to scan these regions early.
>> If a region has both ACPI_SRAT_MEM_ENABLED and ACPI_SRAT_MEM_HOT_PLUGGABLE
>> flags, expand the tracking boundaries. This avoids pulling in the full
>> ACPI subsystem while ensuring the bitmap covers both static memory and
>> hotplug memory.
> 
> Ugh.. Parsing SRAT there is ugly. I would rather avoid it.
> 

I agree. Parsing it here means SRAT gets parsed twice, which doesn't make much
sense.

> Do I understand correctly that we don't have a way represent pluggable,
> but not present memory in EFI memory map?
> 
> IIUC, EFI_MEMORY_HOT_PLUGGABLE is actually present, but unpluggable
> memory.
> 

Right. And repurposing EFI_MEMORY_HOT_PLUGGABLE (plus updating the spec) would
likely make this messier: by its current definition it describes cold-plugged
pages that may be removed, not pages that may be hot-added later.

> Maybe it would be better just allocate bitmap upto maxmem?
> 
> And fix EFI spec to add pluggable-but-not-present attribute.
> 

I am currently working with the UEFI community around two proposals for a spec
change:
1. Add a new attribute, as Kiryl suggested, or
2. Add a generic new hotplug memory type that represents all the memory that
   could be added later.

In either case, we could then precisely allocate the bitmap by parsing the
region with the attribute/type.

I prefer (1), but I have RFC proposals, code-first edk2 changes, and the Linux
plumbing ready for both approaches, and plan to post them in the following week
after ironing out a few kinks.

Thanks,
--Pratik
