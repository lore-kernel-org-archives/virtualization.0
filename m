Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297250B41B
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746523; cv=fail; b=Nyp0dG2IU3Yt+6ASRazrua2dqnU7Fv3tGZvOq+F/18oj5sDFO5KK0DeHHGyxd81sdpKQGgL/jIw3UEfpX+2EsIAFqZpzU33xaVvWlJgDM075DCXvGTBAa1IAv9PMrNEy6Po8bAJzBg0hfqiln5mMP+8KJxXzJjExVdFNY6zoSO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746523; c=relaxed/simple;
	bh=2yH2Sf9Tkl7+cTrtoB96NGFSKh38+u0FIK7EwclaQks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kiqy346MQ3pHbMMvHCp0Tnhnm1FYA7c/8o/Tsaah9eikTDcuju9vwaOYFooUFh9mSZE8ngFdFtTL0lLhIblPV8xyUIOz+4azoT5qx0kRl685U/4gyPdHmmgXhi1cFn5wtMpm0t6NpnTo3o4zoffWrNNVwXGugFF9tFkHktCAWMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NfLcdKyU; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NfLcdKyU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJoQLIx1Tu6B7Z6YAJJbD1gzUSa4y+2K4D+CGAKL9zD6eFr3x0FKiQtUO2Rp76rk+rBsaWA0h6cY0HvVSgnTGu2wPDna5f0doZr590cvxEnNP6kMw34uACRB91vpOC4JUJD5x8GJkdo8bH2eysOuyyfCB+wEy+yArN0eyfW5QkK/rozeD/SCHk/lOQGp5DXNbC2jVRoDXuB7XQ9getUTI2nBiBhjTyKpFVp4NTcrF0M6SQNB+f7TQCIicloj2miku01Gd7oylIm85szzeMldE4+a9eDewg78BHZWye8pX2pNPLuSPI2g4ru0JWP8i+8gb824yt6+vGRRndcl4G6aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pPCfm9RWL4J4x/97y6sGVvkd5DdoP94qa+oXo2cPig=;
 b=Le+bjWwFm6OoG7VM4hq+hDoVJ3Hw3xyQvuPuNZ8443yW8gJKi9WSZ1utNlSAxRObOqR85i4OApnx7H7QeJWwDA4I/WWmuAictTPpG6hON+lwbUcx8oyrvpcYMCm0ZlND9AFalwdJ7G1QOAYGNxrIhy/IebHzjMK23IFPgnMjZ5O+dKUBp4L8zJ61YLka165Vum+pEAsEje3fK2oP5X24rFR06/7KD2GCR7/oXpa8annwwYX05C72jnxscyBGBkCyvIF+wtu3tIjUJO3n46Vo+iFjFsxYiqJuWpQWv+Y7nJ343lysWauvF/Na+UHzDFaNKlRvI7EMccy1ddfvnuW3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pPCfm9RWL4J4x/97y6sGVvkd5DdoP94qa+oXo2cPig=;
 b=NfLcdKyUA3MkX+vCYud1IhC9RwBJfPb0Bx/k9kgQoAL/Cj0KEfP3jMmN0DJjfW50uZAojM8mM5tBVoMpWfeLXCMHTjFey6TNHggWQVkhXNNoD5uWhz9kvIcT5YqA5cC2Z/CeAjtgUVe+AxJBOYT9QmgdfW/WMvXLT5Ykl+oK020=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:48:38 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:48:37 +0000
Message-ID: <6f36d088-9366-48fa-b67a-659eabbd1c42@amd.com>
Date: Fri, 18 Sep 2026 23:48:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-3-honghuan@amd.com>
 <a08fc58b-c67a-4a96-a967-7280c8f9e965@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <a08fc58b-c67a-4a96-a967-7280c8f9e965@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4PR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:370::14) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a06a0d-0bec-4ee6-04ae-08df159c4df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	XITswcXts4eoL7b4RlCfQR5yIGb/8W75jDnMUywYFy0hQZdjK2zwVGMo2/MTxtja42xO0sCN3UhIdCAyrbEGW3pt9ohgd0PkXJvGzWuuee396Sws49UmyuizsLn7H/jjGnUaZeiHmt9Ux1p5VgODuoDRRHibM+x/HW3u3MKiJb0lJ/Xid2qOzh/RHxD80S69Kpvph/sFn+DzqCuXaHJMKw0VpJrQfMu/JeT+ixVFKSr7dbpPBArxJ5z4L9QRQ9XOZNy88qxeRcuU5ZnF0Qni4YoIPmd5zczWUHNe9Ad81rxQ1XOdoUQigOz3jh64BzIxKYDnkERyZrBX9WJvbQ3FIcrLG/i644kYWQd5TSgocGVjHCbB5fO+D5BFdKxiwJ4nd9IiVqvjcXugHurnIiTogE8UKalEVLFVdEpWReu8jOYke4jFEsm3gaqlK8S89rImDUhKKI1IIWLfL3agV40Y/zJewZHdsUeJXF4C7fxQO9gEVO7qvEZqBhvwvxqfJ1kZGbFUwcpNw9Vgd7stgJIvuMr7nPMcmtAaohiLRnW9dWmAhJ68iLmKoRFrRGQRp8BZuZfUvaSFmTtoKE6aAI16QD4zcW/jK6HelN3JCZQO3TICutzwpsFf0u65YzBTnOSFrS1lDOFxfq98z4BsaATD5b0IY2DCjLRe+qIu2o/UVmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2RXN1IrcE1iMkJkL2tMeEtLeE5lWHhzL0lEUVpuRElqVzRpcmloenRzTzEz?=
 =?utf-8?B?VTJMZVNNd0lHZnZtd1RXNXFIdk5JQnFVQkZ5dkhpcUpPbGJPcHc5MEE5eFFU?=
 =?utf-8?B?UWd1TjlxM0VIQ004cVhLOXpuNkhGb2tiRVgrUDUvSURnZnl5YTlQL0d3MzdG?=
 =?utf-8?B?V2tIOTBZU3htajJyN3ZleStiaTZaZkg2K3JpUHROUXJPcjV5MWJyR0kyRmFK?=
 =?utf-8?B?bHhmR1gvZERjb2NtL1NQYkFzZU0yMWk3cWU3bXArYUlxQVlaUkNBeFA4Mkpv?=
 =?utf-8?B?MVg1V0lZRWR4c0xTT1lDUWVKWWNUUTZzaWRSVDZwMTY0Z2szMDljSExPNEM4?=
 =?utf-8?B?V3VtendQWjFoVUpQSmRzV2FZQUZQSjdSbHA4TkRuWlp4VlpyUUsxNHIxVVh2?=
 =?utf-8?B?S29IYm5IWHlPR1VZRFIzMHN6MU9Ic0NRRmwxbHphZ1BmazRsV25NaENpeDVI?=
 =?utf-8?B?T0x3Z0hTMzF6Z2hQOHlrNzlHMkl2eFZEZHNFaXh6MWVWaWo5TGZheTFsQWxI?=
 =?utf-8?B?TDdCQTFRd3dIb1B3Mmt5VEI2NFcyYTFjK3VNSmhQd2FYc0w3TXE3WHA5ZmVG?=
 =?utf-8?B?MUhsdVpjUVdrcTIvVVNBbWVVckVUTHppUFFCajkrL0tXTFZKVEkxTlVIbERI?=
 =?utf-8?B?bTA5YWkrVEtBNDVZc2VWSmczNng0b0FTV1I4MURjSHhSb3VUdkloRXlySlB2?=
 =?utf-8?B?NTdjbVpGQWcxcHhBajZYMDQvcjZWYTNjUk44bXBoc2QyOFdFZFFtZWJZUWxC?=
 =?utf-8?B?NitYRXFsZnpIRFk5TlhGdFZWN21jWWVlaTVicWV3WERhNVA0VDBGRVgvbEdI?=
 =?utf-8?B?d1pGUmxlTzdvTXMyRllZQVlCNGNEblJ4UU1uRnJ3WWdVN3padXdkV0s2Vjkw?=
 =?utf-8?B?LytxME1XajJ1QXZQLzZqS0ZVOVk5SEJBUC85RW1vN3dvOS90aGIrd01GVW1P?=
 =?utf-8?B?QUhIckJaTm1ubEFsWmdrMmZjZ1YxMGNHVnE2NDdQbUlOL3VxajlabW5sRzNK?=
 =?utf-8?B?WmpiTzRybVZwVElpYmdSaGRNZ3VaOEtqNW9zZ1BRU0JXZUhFR3FnVUV5VzV6?=
 =?utf-8?B?dnJZOGRYd1lQRXgrQURlL0ZuWkdDUzdhaThwNDBvTE1UQmYwZVVUR1NEZmtW?=
 =?utf-8?B?blEvQ2RLak9NWmRUd1ZYRE50TlNrUFdZMk1jSzQ4ME5OWE4xNEgvYWFBY1dE?=
 =?utf-8?B?RGpwT0tNZG90VWlvRWxlaTdUd3Q1VXpmUlY5RXY5azhhU1BMdmNBeTJZT3ZC?=
 =?utf-8?B?cHp5bEpWZnJCUXVNREN3UXpxZXAwTC9OYUQzUkNseEpaekU3UFd1a295TVpG?=
 =?utf-8?B?VnhnWHBxbDFZVWdOeXg1WEt2cU15VlhrNVA0TVJub0Nid083YmRuT05nQ3ha?=
 =?utf-8?B?UCtrZnM1Y2ZWR1V5bDhEd2RKWEhTZHVJYXVtNlhCamZJUU1pZStFNjNxUlpn?=
 =?utf-8?B?WjZndk1uUlJqeGFWNjdCcmZ6aUhueFBjZVBZYXZjcGpqVEpmKzFtZ1JlaVhW?=
 =?utf-8?B?bHFJK0poS0p2VUJacWRYdHRNNjJ0KzFNc0RQQVVNMGxhVkluc25qQ2Jpakcw?=
 =?utf-8?B?UlhVL3FtMmlHb1poWGcyRWZpcVBtM2diN1FlU1c4ZDlHRVdFdDdEaTNsVjNQ?=
 =?utf-8?B?YzV2U3FoTEZwaFFKZkhaLzA5WmYrRXE0Y1B4enRNMm5rL2lxQjhaeHd2ZlY5?=
 =?utf-8?B?UVVMOVdGejFBZnUvaEd2bGNNNkdpaG9oWmphSE5rOUkxRGh6amtHdGVXWFdY?=
 =?utf-8?B?UDJHeE5kejRRRmVRVE5raUQ0VWZtN00wQkZ6Sk85a1F3dXVTWEJwMGFTMjFM?=
 =?utf-8?B?UjJucUl1Q3ZYUWcyN2hCSWFZbUtrNEZpOGZCM05IeGk3SEJlWHhqVTYxMWFW?=
 =?utf-8?B?L0RSdFNGemtJS1NHaWU4eFhseHlLZmxzTFBJY09OY1I2MG9Nbi90bnpvajJJ?=
 =?utf-8?B?anliYkZiUzR6QUxSdzJNUGJCZkV4SDh6SlYzaXBWUEZ2ZERVaEplOHIxSUxa?=
 =?utf-8?B?K0RuQTc1aGlObTB6VnUvWGhPditrNlR2dGZsSXZjcktFa25LNkhWNW9GR0Rh?=
 =?utf-8?B?RDA5L2RpL2F1bkhMdmZNQkZIK3Z5UlJCYmZYbnNpcU1pdlN3clNpWUw2Wnd6?=
 =?utf-8?B?L1lWVHVpNCthc2FvaHZLYkMxVXNKMlVhaGVwUE5xRHBzN0FiUWovRnoxMjhX?=
 =?utf-8?B?S09SU3dGNHBha2gzNU4rUDhrZERKY1hVQjg3ZUtJOGIvMUJIRlNtMStjZmI0?=
 =?utf-8?B?eisydmlPME9RUFVBeG1ZZnQ2WWt5NnZmVk41UTRjZGlSbUZVZ0dMN04xM3g4?=
 =?utf-8?B?emZzSGEvUjJHTlJLQWk1S3ZrR3V5K2g2VnhpRjUwVGlvMzZ1OFFDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a06a0d-0bec-4ee6-04ae-08df159c4df6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:48:37.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l/kfLAba3lWSvgY85K8uwbIh/LxrTadzWhD4a1N4+YgBPis9lmN5ihhr1RxaT6NZnUxTY24rNKkrf9dV2YPcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145



On 9/18/2026 8:12 PM, Akihiko Odaki wrote:
> On 2026/09/18 18:59, Honglei Huang wrote:
>> Add a userptr address field so userspace can request a blob backed
>> by an existing process mapping. A non-zero userptr selects that
>> path; probe VIRTGPU_PARAM_USERPTR before using the field.
>>
>> GPU-readonly backing is requested with the virtio CREATE_BLOB wire
>> flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
>> VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
>> resource. The guest pins without FOLL_WRITE only when the device
>> advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   include/uapi/drm/virtgpu_drm.h  | 13 +++++++++++++
>>   include/uapi/linux/virtio_gpu.h |  6 ++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/ 
>> virtgpu_drm.h
>> index 95587e12ae..80f73b3276 100644
>> --- a/include/uapi/drm/virtgpu_drm.h
>> +++ b/include/uapi/drm/virtgpu_drm.h
>> @@ -99,6 +99,8 @@ struct drm_virtgpu_execbuffer {
>>   #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported 
>> capability set ids */
>>   #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug 
>> name from userspace */
>>   #define VIRTGPU_PARAM_BLOB_ALIGNMENT 9 /* Device alignment 
>> requirements for blobs */
>> +#define VIRTGPU_PARAM_USERPTR 10 /* CREATE_BLOB userptr field is 
>> supported */
>> +#define VIRTGPU_PARAM_BLOB_READONLY 11 /* 
>> VIRTGPU_BLOB_FLAG_USE_READONLY is honored */
>>   struct drm_virtgpu_getparam {
>>       __u64 param;
>> @@ -186,6 +188,10 @@ struct drm_virtgpu_resource_create_blob {
>>   #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>>   #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>>   #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>> +/* Wire flag: device MUST NOT write. Guest pins without FOLL_WRITE.
>> + * Rejected unless VIRTGPU_PARAM_BLOB_READONLY is 1.
>> + */
> 
> According to Documentation/process/coding-style.rst, the preferred style 
> for long (multi-line) comments is:
> 
>      /*
>       * This is the preferred style for multi-line
>       * comments in the Linux kernel source code.
>       * Please use it consistently.
>       *
>       * Description:  A column of asterisks on the left side,
>       * with beginning and ending almost-blank lines.
>       */
> 
> So please avoid putting text on the same line as the opening /*.
> 
> Furthermore, because this is a UAPI header (defining the interface 
> between userspace and the kernel, rather than the guest and the host), 
> it should use terminology appropriate for userspace. Kernel-internal 
> implementation details like FOLL_WRITE and terms like "guest" shouldn't 
> be mentioned here.
> 
> That being said, I don't think this comment is necessary in the first 
> place. Anyone who needs to know the exact behavior will look at the 
> virtio specification. I recommend just dropping the comment entirely.
> 

Thanks for the review, will remove this comment here.

>> +#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
>>       /* zero is invalid blob_mem */
>>       __u32 blob_mem;
>>       __u32 blob_flags;
>> @@ -205,6 +211,13 @@ struct drm_virtgpu_resource_create_blob {
>>   #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
>>       __u32 blob_hints;
>>       __u32 pad2;
>> +
>> +    /*
>> +     * Guest VA to pin as blob backing. Non-zero selects the userptr
>> +     * path and is valid only with VIRTGPU_BLOB_MEM_GUEST. Must be 0
>> +     * otherwise. Probe VIRTGPU_PARAM_USERPTR before using this field.
>> +     */
> 
> This comment is useful since it discusses UAPI specifics. However, 
> please avoid the term "Guest VA". Since guest userspace has no concept 
> of a "host" or "PA" (physical address), simply saying "address" is 
> sufficient and more concise.

Got it, will modify the comment in next version.

Regards,
Honglei

> 
> Regards,
> Akihiko Odaki
> 
>> +    __u64 userptr;
>>   };
>>   #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/ 
>> virtio_gpu.h
>> index 3d4dfadc9d..33f5332e59 100644
>> --- a/include/uapi/linux/virtio_gpu.h
>> +++ b/include/uapi/linux/virtio_gpu.h
>> @@ -72,6 +72,10 @@
>>    * must be aligned to that value.
>>    */
>>   #define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
>> +/*
>> + * VIRTIO_GPU_BLOB_FLAG_USE_READONLY
>> + */
>> +#define VIRTIO_GPU_F_BLOB_READONLY       6
>>   enum virtio_gpu_ctrl_type {
>>       VIRTIO_GPU_UNDEFINED = 0,
>> @@ -415,6 +419,8 @@ struct virtio_gpu_resource_create_blob {
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>> +/* Device MUST NOT write. Driver may pin read-only guest pages. */
>> +#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
>>       /* zero is invalid blob mem */
>>       __le32 blob_mem;
>>       __le32 blob_flags;
> 

