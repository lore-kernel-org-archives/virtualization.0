Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8536F419
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617798; cv=fail; b=TWMeC/frQ0JqmIYsNOfbGheuq1ah5sxEd2gHfVp0hOVqMuLvEYOGSTi1lIqfyQa6VfrbfLiMbxbQemRRPIuBCPLBMNv5P4DKwo07eyNVlK8Mv8BStUioAys7PmMfuwuPK1pqA9MFA4ZEJK+SrL76Eyik7dUKE38gVkoZfjSTPOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617798; c=relaxed/simple;
	bh=Cuc2of1MgMf3Bp0xeC/K6tHnse31yCR1NjWzCD8OBR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kBQHPJubstjsSVpMwxXd7Ws7hvTUWv60JVdl4bSkVKs4fJ2nb+3+w7zGeKKjtWegyiK3cslDvZEMbPaOfvedRln0g83ZeebSKcooHj9NjD61iJqjb5JLPc7alHOPJCqo0g7y2iaKDu94zMFMhvejsZchxOrEibogQNJPp4mmJzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2QZuiSnz; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2QZuiSnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+psvXNHbhHji5V8amCltzUYCDPEuf5Xcko7UBvD5OrDP0ggGA8BTLwM/bRB/7fShXi6ulvhlcqyRuVpWhD54C7YjTeBALooBNVJhDimi1gV4K+4azTGcFETdQWpdddjxLsJaTIpqU2SPH1i0AQoPUBHgA0wJXRDV5Nc+nrtgxGThagxk5yH/rL+M3k2lwOF0+BBPj+GMfWLzZtrUGIh3B7V6CXW0vHy7vaO+EoYQdlBep425WQuWKiFQKGVvHzaMIsgmLXzTykwJiDqVConxrIKHAalaDID4G0K3+qPIgN/kCIbzxqavJAkPzKXQA2IbZSECrFCiuPpH1ZejMvdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYz9r8PmsOwxzyPyrjquMnAjad0LJaf3uyKSiBQn1Yc=;
 b=BeG41VlB+4a1xwQ2I4C3B1oP6XWkhWlA75laBfLe0rLxtb4Ss9xKirqtm9a720U++pFOECNCChPOyqCkA0iPIDKSxf+yx0SKYrZuTAlgMvACbu21h4K2kAtlC/VxEIeD4eNpQ05ChX0eIX/6j+xYpWTi4CvOPgAxnMCMoXqbfLvRmdetYvjp2JuoGdWgc9+/SUOYcou7j7iXt8060gM/TBD5Mh8IX2ASK7/zPEUNQPqmuIrKRWfYunG8t1PmzqUE04Y3TIZ/MtrpxyhW0OzcG9F+/zx5lDO5/puhh7cfKkITBuvcPlVhZHFZygne0H04qhE153chPP/9lLQ43yeI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYz9r8PmsOwxzyPyrjquMnAjad0LJaf3uyKSiBQn1Yc=;
 b=2QZuiSnzzgfXhyIDicFeha9up3FQ60iy1qiQl2/j/Kz8mdHn6G7WRiXO9gdM6OpJjAKfqj2hl4RBn44+mEAeTRHRvJMB314UhEPQU6q/veA0VursZa8StEE3D/ioOmcIk+15RFbCwZtzFVeK68SyXJ6I1rB8tC6GZFgRnvbm0lE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 07:36:32 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0496.010; Sat, 10 Oct 2026
 07:36:32 +0000
Message-ID: <16241811-671c-4962-aa3c-ac8f3ffb4f2c@amd.com>
Date: Sat, 10 Oct 2026 15:36:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <69e33ec9-a0bc-4d02-b20d-9c0c03236a42@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <69e33ec9-a0bc-4d02-b20d-9c0c03236a42@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0057.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::8)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: d72145b7-6fbb-4d4b-6e6b-08df26a1348d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|261009220027099003|261009223027099003|261009223327099003|261009221227099003|4143699003|261009221727099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nvzxsQpaFWKzsoMk6zMxOgDII7N8G97k0ehiYX4hUsCp3cKKKl0vCj0M0eSrS7vEbGBMqI+UOmTOeZ3qb+/H4q9QD+JV6JSq170ju12a1lAWHeRfGPLb3a6vK6UsmVC2Io4lm9h4ase7Fli/rFTAuD/Xsbkz4WfnzMpYpkc1uipml+g2i6Dq64JQQRAod5nH/phFeaBZKA2cMjPqSEQRM0Rq2OD1Q4uY5mI+21Ca0/LwQP0JVzeWmfhCESDYhwBdbfIX33bjSSr3nQ4Htaa70LB1bkDroYH1BKhXSv5kpQBu1cXu/gBJ4FOXMZGAR5c84ijOZfQmP9wRpN7qFx+yQzk6+rWm2QrCifZ+lzkbyg8oh9aUglCTYU4PVTLRu7vSsJ8jWPtNqUv77PdIzh9joagiqtM3R+lz4m/WBhSFq/kDp7FMNIxyuKUEkgky6RZv9U1oPS3vShg5LArILKEJfRSnwur3hSx/n2PQBMeAGuHtE52AYBrSU55TIdq4ydJd7yTuusSxnSa8TkPqSNm9HeD2OJIC3lmaHQaSfVJHZ5TFGAxicEnzSWhq2HZcw4W3wdxaYykrCpvGdqzKytOe23WCqpXbO8jGkd+x2RB7O2kj6PNJdA6eD/6sxKOT3YeEj0t+j+ApbnzDyrLtVwtOh2vCcRPJeg8CPQuq5wBpBPE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221227099003)(4143699003)(261009221727099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVmblRqRTFqVkI3V0ZuUzVHYjYxVjJ4MS83a0V0VW9xbk0yeVU3MnVSRE50?=
 =?utf-8?B?Nmk3M0hzZlRraVN1cTZTVDFFeEt5aXQyeGROYUQvVERFajdhbkRvOW90UUYw?=
 =?utf-8?B?MU0ydFA0bmdtb1d2NXBQRFYzOWdFVk9ZM0VaRFNuYUhtYzBZb0dkalpsd21P?=
 =?utf-8?B?OTB6UzI2dE5WZ0JSMFlSMzVxT2VNK3p3OEEzbWswSHRITk1mbkVrZ2w5ZG9U?=
 =?utf-8?B?UGdTZ0NqMEd3ZU1RV2xwbTg5RkVkdzh1bVlaQXNCZTMxSGpRbGNicmRpQmVV?=
 =?utf-8?B?eUZLbGwzYXFtWlYxRFIwV1ZscldUUjA5RWYvNllzZHVCV1J0c2VmcUk0MTI5?=
 =?utf-8?B?ZmExQ2x3cGxJZ2NHYlIxWjB5ZHdwbk1WREF4UWhkZ3FGUFZhOEwrMjhMUVhM?=
 =?utf-8?B?czkxZzRlR3ExMHNqbjBUUlFUclQ5bW5SZlQ1cS9MWjJCVDBpbWQ2MmdMRWR4?=
 =?utf-8?B?Vythb3NpL2ZZQ0UvK1RlOVJ5VmhmQlhXZlJ3ZmVNQXAxQ3VJdXo3amlsMWFI?=
 =?utf-8?B?bHdKSUg1MmVoLzVVSDJWcUd0U1RaalVLcGR0M1REb1RKOXZMQ2ZsQ0VTYTBy?=
 =?utf-8?B?TjBwa256OEpGODJ0Q2Q1YWxURThVa2crYU5ZWk9lTG5mQ0prZ1Zqcng4MmVL?=
 =?utf-8?B?SWo3eFBVOW1GNTd3Tkc1ekFxcHFXZi9zZStyYWNERUl5WkxMdWpweFI2SnBJ?=
 =?utf-8?B?ZnBVMHdNdWY3ekY5dlhZSXI0ZW9PTnNndzViRGxOem85YTYxb3J6TDlaRmk5?=
 =?utf-8?B?TmcrYXBjdkVJbmlGQWRQL2pwTzRINzhybkdJT29VNmlmdUtrejh5ZnJYSVlY?=
 =?utf-8?B?cVBwZExUV29rdHFoK2ZZVkd4U1pDWWpsS0I0d1R5QUtyemhUcGttTUd2TmFz?=
 =?utf-8?B?a2JTV09ZTkVybkJBU0s0bG1LZDFMR3BIbW9EU2NJQkd3SzVLaWFsbUFSNjNL?=
 =?utf-8?B?Mk84aWlHcTZkekVGWDhDTVJBcCt3eWtmVjE1TG5KQW1aRjV1M2xiS1JpVC9Q?=
 =?utf-8?B?cGliSlpHdXFYRlo1RUFiMmxpcVRDWldwNkF0MHhLTXlEZ3NWVWhSQlhDWWJa?=
 =?utf-8?B?elJSakJNS0pIcHQ4QUZoR2NYQ1prZmxMMDhUTElFdm9ZR2hvK21kdjhUa3ZQ?=
 =?utf-8?B?SDlUNWhOVGVlQXRCd0gxSmZWU3JtRDJMQUxkSFpVOHlwalNhaXl4SFgxTWNI?=
 =?utf-8?B?K2szWDhSbWRubkNEOE43dmJ4SDFlNTh5N0xiT2FUOW5tWkEzZjF5SmNRdk5K?=
 =?utf-8?B?TldMeWJoYlVtZUZXYTYxVVczemF3Y1pEUE1GcjJqQ3ZOTHVtL0kyelhjWnB5?=
 =?utf-8?B?eUtmYjdrUmExZ2tWQXZXdFZVZDhhV1JzUjNWL2FLWlZ6ZUE4WnRpT01sVlNX?=
 =?utf-8?B?TlphQ0F2YTRuSjV3SUd5YjltR3huN3BsVGJ6R0o4T3EvQXdNZWJRM3FRc2hK?=
 =?utf-8?B?Mi9ERWg2THo5Y2lleWZPRkx2eXRjWFJzTk9sRnFDdEhXT0dtd2pna2pFVk9O?=
 =?utf-8?B?QlVXNGw0c0FlZkpNbWsrRnErY2ZTc1ZiNGRNb3IrVFQ1TUZOWWJVZGtCZGcy?=
 =?utf-8?B?MitoWDJCT0dabm5ha1BLdEkzK29taUw3ZTJtSUxaQVVPSThaZzY5Qm9RWlJG?=
 =?utf-8?B?VzVaR3hEeTlDK0doLy8reGFDT01lajlvaDJTY1czSGIxdEVHdzNBSkFmNkpw?=
 =?utf-8?B?a0lWNEs4MFFZN3JxeHlPdWJMVzVMcEIyQS9HcDQ0RTI4N3RVbXhxVXBtQ0ln?=
 =?utf-8?B?cm1WQjhhTVNFNkNTNVdvWVdiUitTUEhmQzlxY0VNbm5HY083VWlmZTMrUUUx?=
 =?utf-8?B?Y09FajVqKzF0a1FycW1ic0grSjhlMExFR0JxSHZDbHpEN3pKOEVtRWp1R25T?=
 =?utf-8?B?VTVTOUdSUDN6SHhPbXR3c2xXNFY4amRDUUxWdllRSjJ0UTNrQTVKbjlBNHpY?=
 =?utf-8?B?U1hUZFZGdEc4d2Z6L251Wkd1TU44eEQxd1g4NkVpdkd4RmI5WFZpVERsTGZM?=
 =?utf-8?B?d2tlbXlOSTBTY3pEQmRuSUNJbVFDWWlrQTQ0RnAvTWkrU2syZVBYNDZPVi9P?=
 =?utf-8?B?cU01YmxjeE82VDcyQ1h5SXpTY3I2ZUMyL3M2QTZqYzZPeFpvdnVTeWtXbk9U?=
 =?utf-8?B?dk1ucFJPNXIwVVlGZWxTaGs1MXk3cFIvNkdZdmxGSVZFeEtxTk9tOGhtN0Nq?=
 =?utf-8?B?VGlYNVU1TWNaZFljQU41dEg5L0d0UGhJSlErLzFiSXRHcWV3MTdmT3VYNEZD?=
 =?utf-8?B?VjlNWHBYR2xQNzdhYjlnRkRsSHp5RVYxdjFmQzRBREtMMzdyRXRWZ0R6MC8z?=
 =?utf-8?B?Z2dDL3dTdXZJSmkwcDhCSVNQdHFmUUNtdS9xSjRub3RnYXVMai9jQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72145b7-6fbb-4d4b-6e6b-08df26a1348d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 07:36:32.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzQUwkCnhyWsVAB28FIwMSAHUKM1rs+WLEjNNWD+2vhOP+hWufD2LBy42ecHpBrYvWrwX1Tn8lIffeq3U1xNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042



On 10/10/2026 2:32 AM, Dmitry Osipenko wrote:
> 24.09.2026 12:55, Honglei Huang пишет:
>> +static struct dma_buf *
>> +virtio_gpu_userptr_prime_export(struct drm_gem_object *obj, int flags)
>> +{
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
>> +	.open = virtio_gpu_gem_object_open,
>> +	.close = virtio_gpu_gem_object_close,
>> +	.free = virtio_gpu_userptr_free,
>> +	.export = virtio_gpu_userptr_prime_export,
>> +};
> 
> Is virtio_gpu_userptr_prime_export() optional?
> 
Yes it is optional, but if not set this callback then .export will 
fallback to  drm_gem_prime_export, userptr can not support the export
feature, to prevent silent failure, an explicit registration method is 
used here to ensure it is not supported.

Regards,
Honglei
