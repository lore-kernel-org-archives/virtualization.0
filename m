Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96E489898;
	Thu, 27 Aug 2026 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854998; cv=fail; b=XdLcFVCYdbF4TjBhp93OM8nT5X52Ei6/m7UqPjKqxzAcsdrEwozlnxmW+UbnALOmTShrB593+MIpm47Jxl3kBll4lqvVJhafbr05QbY3MfJwC68xkIZgft8wpgej0Pz4B6TNsVwwHivUijhXHfhw7TECRwEqRhvLsSDPUpPVfqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854998; c=relaxed/simple;
	bh=FdEk7frQx0hn+3nHHTL/Y//NGhbuOWz5zkqZfhdRlJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CN1J5ek/jkzr0b+c9ut19xN0wa+6ItF+XZSJe3iScW8WBeONMBltqu1adF6WY8mTL0sj8o3NdBEJYYVp0Ie02LgzhfZchZeK2qG6afBdEKHz2WT7q5uo8xRSdvIz9nE6gHs+7RXn0La7tkqJ6WFtWhxJtF9hy81hm2uIAX6BqpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=btf2CsFz; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="btf2CsFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiYMfSlXvBQJEbcyrc+TX6CP+jvzhE4b8K2TcIxnd+NDtagX3SDoQdCBfwreqd5QiSs7zw0mhnutPKXleYI+7rzvhRZ/zWxCIg9lpdt/TPr1XTN4jS+MsU7BS7slUQ4BfzX+Trur80g/DmUy1bAWRTi4+lGDRV7yF4tt2Bq98OV+e5WwPGlqoUpAqQ3qnilmP4SatlJ50B1Panm3dGwmfAb7vYOtHteOFoCAiOIJcPD2+0oSDubgPqTHar30KYeYX9sX+aPkZLi/ZJqAS2ze1Xmrt1CKXW5sWsLhYezp29piJ58szztW+UzQGj53GeDkfQNyAWGvKXsAevLn0XaqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNQg8BaFnyqFpd0L1a9ZkY1AyDwUG32xXiZIE3sNeTw=;
 b=JzUW6NJM706rvmTRUgwKWpMbap8A6eEUt1V1HhOtVkHJemYjynA5voB5WZOJgQznmdLPNx/0HJMrPc2l15jDn/7dFQD8B4qRFOh/joeuAQb9cxmOxFEY0ufZC3iLJ98UB5BhfLJhv6ORVkAKroJcS3qUowYcB6G449yol3le2fX/GuYBIMKWlHyNzWVLiYw44GHsAk2TzPRwt7vmZOMI25CyhMNEpubmKhyG28jElBnoyJU/6xn3yQg/XPTiUcUinPlsGTXhXflVU971JtrmQKqr12fE6Z/mBK8z2XULe+iJ5YP/cUBbqHaMC2N0owHs+NBp2iDpQwGOHt1gs8dpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNQg8BaFnyqFpd0L1a9ZkY1AyDwUG32xXiZIE3sNeTw=;
 b=btf2CsFzDlrS+7wPDcv20t4h2RhIzAaKhKDHLRq9M5moZ+e2MfHMjKuB6iMER0KW9qcartwUUW0N5w6Cxo1Y0iHHExL620Qe+1Bf0fT81zc5fZ2ud9dRA9AeoLjuoQtcQXgmg7VkKpFRSbrMpwPcSHLGSDkJh7kVcxATGp+N8Rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 27 Aug
 2026 18:23:10 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:23:10 +0000
Message-ID: <9e97bdc4-6940-41a4-ab8a-2150162eb0f8@amd.com>
Date: Thu, 27 Aug 2026 14:23:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo
 guests
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <5921ace1-219d-4947-99d9-13b56e1ec6fa@kernel.org>
 <IA3PR11MB91365F3F771C43C4BA7E61B392AD2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <IA3PR11MB91365F3F771C43C4BA7E61B392AD2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::24) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b931c8-9a7f-4b90-fefe-08df04683f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006|6133799003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	78AWM9u1KucGCD5KX4CE1hMlurJInDX3W/DgGDljPvzO4OkpqeiH+ofrxlagW+PpsFBcrn4w+EcD2FY4Khu8jxfjRZ/h8vi2SuSwHPvZ2xbbYvYKpSUsv5xVxMStCLXLvTntC7RTJ4X8RbWXLU5CYHR2jKD/hGEoPwCJOXvDo0AABmbbspdopM/hltETmem+ZTCsskz16STRv2wsOEQu3+iC6YDKOkjrWSAa74Jm+vjO9/dENYdAljv5xzKW0Cs2/iMATkNRQBFF6izK5cZaoBfTabuHgMjjc4/m4lBesaVUyxw7KYH2JwPczEp8bNa/VmhSu4erkRDGXgRoJSDSt9D0mPSkz8tsc0E/zFPpADDHK9L+Ylk2oU8mUD/4bsEgj7wxL7ikMgoo67tXvAY51MY84vVeKF4ZbW7kbKD+fuf+kP5BgQzdoLmUlFMNJduWUdsfERqjNxwvWoI2T4gFzFp99TNmUbKP9U/MhTaysTU7mL59deC1N8NzuCIcbVUtao+OUuYjcKx7Hwk/bhR+wVdzz/KlL/KrwYMq/Fyc8JN0VwazHCF4tksxg9Hy5riS3Qh5djoYgfzQ5f7/QHj9dUYGXZIq0nLLg3v3GSk+fVovv4FW8qOEfg3z5VkPTic605okBtjEg984v2kbsqwXx1+zLswKJwCLyp81/NfJKtGIQQMh8uEE5c/UhSU0uY6Hx2xwhjHw+GDhmwJn0rBcQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(6133799003)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZvVmJKQzhyQUx0aUxWYTNzcXJzSTZWQTVsRnVtRVFIbFVGcjMrNUprWUtG?=
 =?utf-8?B?MHRlYjl6ajRMTW1lQ21Gd0RwcG1MZXo1OGVJS0RxMXpLZUp5enR4Z2gvMTRI?=
 =?utf-8?B?TmI3Yml3b0hEazJldWNLR2RSYXJLMUJQalRsMGhlQXdrdUdKRTViWkswcFJX?=
 =?utf-8?B?UkdDYUVkaWVVMUZ1WjZZWnNHajNVOFU2NzdRTWF6RWFsQW80NTAyekZ4SHRu?=
 =?utf-8?B?Zy9oMXhyVDhjVkZwandhNGtWYUNzWVRKTXY2OXNnUUVxbHR3Si9MU3ZjY1c5?=
 =?utf-8?B?RWRXdE15dFk4Snc4WGxqNERnVEx5dDNjZWtTeE5vVFVseEZxMzdDYkJTSEJj?=
 =?utf-8?B?OWpKVFlucDh6d3podTNBditTVFppT3A3MkNNeUY1RnZvRU9JMjdNR1Y0TG9s?=
 =?utf-8?B?RC9JS0RwbXpUazJxeHJadS83RzhLSFNJMk9aVGxrdEE2QVRMQ0hmS00yakY2?=
 =?utf-8?B?ZjFzY1ZMbmpXT0J4Q2tRL1pXMUpzL0x2TmdLbE82cnVHRGRxT1dibytqVmVz?=
 =?utf-8?B?Z3l5bGE5dExYajQ5L1RVaU0xOEYxYTh4azdzM09Temk4NEFKV3VWUVYvQ1F2?=
 =?utf-8?B?QWRwWG83SGJ3UlBNMEF2UzBTVVJPY1JTT25QNDR1SzNZa3FEUWZraW1oMzlq?=
 =?utf-8?B?STVYN2Nrc0l2enRndGlHd2h6R25CT29JeUhCQUFaZFhHOWlLc0c4YTBUV2RS?=
 =?utf-8?B?YnExb05vQ3VFWFB4RUZ5OFJNL1pZZm44dzdKMVF4eW5YK0htMDYvcnZ5MldN?=
 =?utf-8?B?VFVPc1RiRDk3SHV5ZmdoWGo0VnJGcHd2bVVsQm1POFhtWWtEU21Pd2hheklG?=
 =?utf-8?B?WERWOUc1NTRuSURoRXBDL2V6S0RGT3BITTNKaVE1NDBuc0FGSjRTNUN5Nmhj?=
 =?utf-8?B?Tmd2bisvRTFrcG1mb0kxSy9KSld4UHViLzNZemtzenMzOC9tVzFYRTZHZ3Zl?=
 =?utf-8?B?UFFyU2NNNHVLc1dSa3Q1Y05HUkpvQ0dBV29uWE4vbkV0WkZJWCtmUEJIWHNL?=
 =?utf-8?B?MG43dkxKYTFwcGtPZ0V4NE9xVjFXV3phWlNWZlh2OC9KZzRsVW5tcllCdFM1?=
 =?utf-8?B?Vk9JNmJRZ2J6U1lmamJDbjdFcDlNNmNxbXRyb201NXhaWkloeWhjc0VZdVM4?=
 =?utf-8?B?MVo3bWVVb3R4ZjArZ3d4a2ROMGFGL3Q0SWRtby8vVE9rNmI2cXNGYkFWWHlk?=
 =?utf-8?B?NnFNMDlENHJ0MnB4MVNBN3VEVy9nQmpVL0dwYzBvM2JTa05sOCtMS1Y4SU96?=
 =?utf-8?B?VnpnRk9pVndoOHd4Z2RxeXJTRTJSSG0wSU1IS1QyZ012VmU2NTYrWnRlUncr?=
 =?utf-8?B?OERKRU12eWhsNmkwTHBJTFQ0NjRoOFZUVTdYRldTanB5RFRDR1JQV0c5SWY4?=
 =?utf-8?B?eHp2eGRnWkZQbll4N2NNQ04rYzVxVWlUd2FrUXE4Q0ExeHVNeG54T2l1VkI2?=
 =?utf-8?B?MHEyUDFsaC9IemFCVHUvU2lCdDROK0ptOXNPa3I2eGdZR2RtejlYSEJ1d2NM?=
 =?utf-8?B?SkJIQVAycUc2ZUswVUprYjQ4MDNBSERjS1RISTV5MWtjZUJrakdCMXZGVTVV?=
 =?utf-8?B?OGtvRUZJWUdodFZaYUVHdDJsbnlnTituQnJIdlA0eUNMcUl6aWhIajVtZjFj?=
 =?utf-8?B?R1ZDUnJHcExoTmZDZHhvSFpMTHpQZGVNalVJbHpCQ0tUZW5pZ2J1YThNUHFU?=
 =?utf-8?B?K05zbVkxM3dSVEtqWE5RMFQzT01YejVNK01Oa2J4UVRsb1hMQnZjcTlEQnJD?=
 =?utf-8?B?QklMWXRMazAxZHhOK1dWQWliSHIva0IwUFNlb0d0NmtLNkg5R1o0WlcrYkMr?=
 =?utf-8?B?TzZQcUp3QjlVTVJFNkpZREY2R09XWTg3Rmh3cExPWC83K2hUL0t5UkFrYlVS?=
 =?utf-8?B?UGQyUXZwNHFORHc2NEs3dGNpZXRsWld6VDBIbFlxeWQ3YldUVWx5azFYdTJ6?=
 =?utf-8?B?Q0Y1NGJhVHZLcnAwcDdaZ3hDUW10K2pOSU43U2RaY2JweGpBY0xoVW9UZVdC?=
 =?utf-8?B?djZTcTgvS3lBVzZhay9DYnBoMjduOFd1ZklCN0hmYVVKWTU1MGFWNk1RcVVn?=
 =?utf-8?B?MlpwTDBVKzU4TFQ2c1p2Yk5IQ0hqZ2tqQWJhMHAxNDM3endEM2pmSEViNU9k?=
 =?utf-8?B?bXpjK0RBc3NxZ1pwemNLN1JnbmczRmdiUmJ4SjVMcm9JRVVNQVBUSzFobXdM?=
 =?utf-8?B?OGl0cndzeXcvSmovS1R5MDVmTmV6ZXZEZ0VISDFOa2ttV2F4dU5sKzF6RmpE?=
 =?utf-8?B?eFRxNjViL2FzM0tJbGltbm1KNmRrbWhkLzIzU3QvWjdUQkxWUk1UbithZURn?=
 =?utf-8?B?V2Q1eVkrMGxTc01UTnpHV21kU0xiZmF2SU05Y25ubFdWL01GQlRqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b931c8-9a7f-4b90-fefe-08df04683f96
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:23:10.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KDdUhVrgh5gJGy+3Vg/E0q2HX9gdIrRieiJRd+LsMmFxmLrFzmBakmKgjEzHOjXwL/PYnvJcnFzaEbhGMsC4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874



On 8/27/26 4:18 AM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: David Hildenbrand (Arm) <david@kernel.org>
>> Subject: Re: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo
>> guests
>>
>> On 6/23/26 12:17, Zhenzhong Duan wrote:
>>> This RFCv2 series implements comprehensive support for virtio-mem and ACPI
>>> DIMM memory hotplug/unplug in Intel TDX confidential computing guests.
>>> It explores the start-private memory approach utilizing the native
>>> TDG.MEM.PAGE.RELEASE API.
>>>
>>> We are seeking feedback from Kiryl on the CoCo guest implementation, MM
>>> experts on DIMM & virio-mem memory hotplug integration and broader
>>> virtio/CoCo community input on the overall approach. We are not seeking
>>> x86 maintainer review at this stage.
>>>
>>> == Changes from RFC v1 ==
>>>
>>> - Eliminated callback infrastructure: Dropped plug callback and replaced
>>>   unplug callback with platform-level unaccept function into core MM
>>>   hotplug and virtio-mem subsystems.
>>> - Added comprehensive bitmap tracking: Introduced a "plugged" bitmap
>>>   alongside the unaccepted bitmap to track populated hotplug memory
>>>   states to support load_unaligned_zeropad().
>>> - Enhanced SRAT parsing: Extended the EFI stub to parse ACPI SRAT tables
>>>   early, ensuring hotpluggable ranges are tracked from initial boot.
>>>
>>> For more introduction about the background or other efforts in community,
>>> please check the RFCv1 cover letter [1].
>>>
>>> == Technical Approach ==
>>>
>>> - Early SRAT Integration: A lightweight EFI stub parser scans ACPI SRAT
>>>   tables to identify hotpluggable ranges and adjust bitmap boundaries
>>>   early, avoiding the overhead of the full ACPI subsystem.
>>> - Comprehensive Bitmap Tracking: Introduces a "plugged" bitmap right
>>>   after the unaccepted bitmap. Both static and hotplugged memory are
>>>   tracked, allowing the guest to map which ranges are populated by the
>>>   VMM. This prevents acceptance beyond plugged memory boundaries due to
>>>   load_unaligned_zeropad() operations.
>>> - Platform Extensibility: Exposes generic CoCo memory interfaces. Other
>>>   confidential platforms (like AMD SEV-SNP) can easily adopt this by
>>>   hooking their specific mechanisms into arch_unaccept_memory().
>>> - Hotplug & Guest Control: Integrates platform-level unaccept logic
>>>   into ACPI hotplug and virtio-mem handlers. Uses TDG.MEM.PAGE.RELEASE
>>>   for TDX to explicitly set memory to the "unaccepted" state during
>>>   unplug, removing host hole-punching dependencies.
>>> - Kexec Handover: Leverages existing EFI mechanisms to seamlessly hand
>>>   over both the extended unaccepted bitmap and the new plugged bitmap
>>>   across kexec boundaries.
>>>
>>> == Testing ==
>>>
>>> - dimm and virtio-mem memory hotplug/unplug
>>> - lazy and eager accept
>>> - kexec/kdump with hotplugged memory
>>>
>>> This is tested with Marc-André Lureau's newest qemu series [2]
>>
>> What's the status of this?
> 
> Marc's QEMU series is merged.
> For this series, following feedback from Kirill and Pratik, the preferred approach
> is updating the UEFI spec for hotplug memory ranges rather than parsing SRAT
> at the EFI stage. Pratik is already pushing this forward, I am currently waiting on
> his RFCs. If he hasn't taken over the entire implementation, I can rebase my
> remaining patches on top of his work.
> 
> Hi Pratik, have you sent your UEFI RFC out yet? Just wanted to make sure
> I didn't miss your thread.
> 

Yes, the RFC has been out for a bit: https://github.com/tianocore/edk2/pull/12811

The general feedback I've received is that folks are wary of adding yet another
attribute to support hotplug memory (beyond EFI_MEMORY_SP and
EFI_MEMORY_HOT_PLUGGABLE), and that they're waiting for more community input
before moving forward.

In hindsight, I should probably have pinged here as well since folks on this
thread are more adept to review.

Thanks,
--Pratik 

