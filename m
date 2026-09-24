Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D7386C21
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242423; cv=fail; b=bkKGzWYHyKijOIdzT49n1md2aBKjbOMjy5N/nORX9zJfZ+eLcu9ucQdHX66RAdr9GUTl8zKuQiLKRWICXo20qzooCnif1MV4J1TZSisS9N5/LsA5IfPHAv4OFwEnjbVifQhVvzkB4W70CCTqbyhj2txlwwvNn63B20+1gzH7T2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242423; c=relaxed/simple;
	bh=MPY21J/gDcgOnLtF6YjdYL4/MiVzJTsYmu36oo6LB6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrcLiGxiBkV/DMoE8zl5NRKTpIubrt4jeu6iJ3NkK46x3azj/NDUPMuPKFW1SHYoK6buzR2zIBBNR+n3VOQNmEfe8eNCJh+0yHkja6BNKPVnTwE9IL+XsLXUEvNVON6SAujlu1Y5tf2eGnYqcnCLANQAOHScQLJW2etds04e65I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eePlhzt1; arc=fail smtp.client-ip=40.93.196.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eePlhzt1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXUqmoBmqCnyIJrFgMxTcuqPmZROdy7v7tcGmm4F/V0haDtBpK0dwiZrT3nI3Fzw7iRsKsd7OR2wxb4u4cVc2YUDK4lA59NcK8rx4U8xH9Wciv0ZtBqj1WG28mSSgcnid2dPpAtbIgjAD16OPq5MVVRLSk8mLALbdUuqT1eE7xPX5C4IYDWGlOoTdRQC5zbEhd/Mv6MeSWCaVTcem1DcDc4xJendPXZlfrWt0BHvcU2UJ9UvwRksbX9YCU9IVuqg/BqQ1dgOiT98vJh7j9Hft3Kv5QYomF+S8jMJq3+Jz7z6QyiTbqVRhyZF6IGQVWz9V+9L6bPnjPVsFmexkoTy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXQPfMUg+SdUIFFBM1exZDDx6eVj5aOZlkA1vmGOynw=;
 b=uyHMxDbLxIhR5sEpHB2vYtr87To4Cv+OfD/uejArZfJvq2E0KVIKFr/3DIxruFD/vTxlvj6SGguppNqUY7M0SemgZ+zEsVEyYDqEYsuRkvokp6JixXht3U2JIx6vAneV6nB9aA3m8U8E4Ze0wIe3VBwRXgUanVV0jOXSCHimJbAJ7V4EIijhB/11oogL2PqNwwjukFyWXKqfzPe7kn0oQNEbkTcdmHmQrJ8eBxzL2RDTUMTAuG4cTd5BuRf78D19T6VwcaKEEZ6pemNNs/eq9iCcNxmzo/63gpnBS2+LXKVnOpY4Qr2kbXdYntyWxo//ticRI7kPemUMrU39RRWFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXQPfMUg+SdUIFFBM1exZDDx6eVj5aOZlkA1vmGOynw=;
 b=eePlhzt1TU+JPVOPLPwbaWnWn1gyrW5UHNzqqBztAQNtTRbCsPhkU5aD2iv90k1MV50lwygDsYIguxYa0+hMCcqGmcV4Ddkzk3c5sHPObzySt0oFY76Xm2c9MwKtzaqmttq3gqkpe6Xd0T7VO6p2eQlGZDbD8jzdNCURs7o1ifA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:33:38 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 09:33:38 +0000
Message-ID: <38a483e3-fc0c-44f9-be08-eef3851bf38a@amd.com>
Date: Thu, 24 Sep 2026 17:33:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-5-honghuan@amd.com>
 <73afcd33-14a0-4c26-8cfd-1737e46463c9@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <73afcd33-14a0-4c26-8cfd-1737e46463c9@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5919fd-83b4-4aec-0c70-08df1a1ee9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	htQru202/K6Vvsjn3Msex2ABBsZX/GfvydIMjLi1Pnr6H5Bo5QttkXbQroAkR84CVW7guBFcsIYgUqS3qqFLdNHe0GnATUep1q72Rfe8lHpMhRxBM/wptDXCgzpXSZvz5P1bjcskJ23LW9G97BUTyw8rKGVylX4h9ls6XGo6BU2xikLZQs4nEMkilmyevRXJfVxbRSSGukHuFSYIxHDDL/1PlS6MWmKewl6rZdAYkJ0xwQeHWnUsBCi3pHQNIZ92EVoe1MqVGj6xS+EdRHUhOjRHBoQO8k2MaMxF8syGv+7kgbOHExi8IWvQYOn3p5W1/vRKs1Halq/tE8BlAll9CdHutn2hLM3e+LndRhX+bVh1ZS5psjNpi37UXGZiCEfhFXzpJZttpWMFEwYnEXWM0u3Bhpzwat+ELCMRg5Fn0EcigUOCYAWRsxIxFZKPcIJHwBfotZPIgiEkfF1Y7tzqe5LSp2jgcTkpORugbQDVYFDV1aNJtcU90kyNgXLv4EeE8fCjLDpZgNZtg1Wu/t8ohgNQkklHTEr3xSMhws8bxDMu7W38BW/8bKxEg3APCgM6MOlf9i/ogXVOSP+I1FFf/xmz6Sw8LVEh1c5omHdUgVo8j/z/xXgG/X1VFMHXXSrI6kEkD2EHNJc8GYuq37hXB5EO0pDgCxOYItiskzflfNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bllNbDRkT0ZJQzZlSjFldGtnRzBna1lSblZtZ1lLNFgzaWpDSnpjSkxpRm1R?=
 =?utf-8?B?dCtjTW9PYWJwZHRaT2tTT2FvQ2k5YlgxdHRYVHRDNmZIYk9UQzY4MWFWWFVU?=
 =?utf-8?B?T2N2bVpKRzRNQnpORkdlWU0zWEdaay9SRVQ4YUJMaXl6RG5pUVNCZWpJTnlZ?=
 =?utf-8?B?ZWsyZjc2d24yZERraVhzaXdCZjFlTytRd2FBWC9mK3NqUitGOGtMV2VWaFJr?=
 =?utf-8?B?cVBIaDh2dGdHSGJSUzlVaWVXY2JtaDUrTFBTQWIvMkxoZkZuZ2w0T3Mvc3FN?=
 =?utf-8?B?dXJIUlJRLy8xV0tGaSt3b3lONFZKU0JlNDdFZW9aNTA0aFJxbE5CYmVidXVT?=
 =?utf-8?B?Nlp5SjJyNHFvVkh6SThvOHhlNjh0VDRPeWdIdHl4WG0wNGtKRG5rRGxFZTZ1?=
 =?utf-8?B?TXBqdVhqZWIxYWltU0gyNzRQNXovWk02bUV0VjlWRFZOV3EvbkM0QVdPeTEr?=
 =?utf-8?B?OUhEZVpQU0p6cFROY2hDdlFOMkNtTWpTTnZJNitIT1NycEplUnFsWEFaVEJn?=
 =?utf-8?B?SWMvaXc1RFNUb3J5enEyZXp1UE9aQUkzSHRIUlY1cG1IazNlNXJuSUJZN0x5?=
 =?utf-8?B?amZJNUp1RnMyTlhGc280a3ZpK0lMc24vUys2bHZ6M1hOOFdYTmVVYkhLMjBy?=
 =?utf-8?B?YzRGSytSTnk2SW4vMmw0QjRUalZmMXRXT1hmZ2NiOWJrUXFtVmt0M0RGK0ww?=
 =?utf-8?B?ZXl1UEk0cWx2SUdkQVc5Ynpob2xUcUlYcFREN0o4ZWtQY29uMVFDMGRqZHA4?=
 =?utf-8?B?TENOT2QzMHFCa2d3OGk5VGpVcUppRklKT0ZLblZCeDZVVUVJU2Jkem9pMTdH?=
 =?utf-8?B?OXk5YThVRzNIQnUrNldRUkpaTzFYZ0M0UUY3eEU0VHhtemFyOXNtUUVWVHFl?=
 =?utf-8?B?U0VmZVhOc3JPNExDN1VrcjFKVlhZLzBsemZOd2ZJbFZ6dHF1eWdTekpMSmJV?=
 =?utf-8?B?SnB6cGo4RGhjV1VTd3hUd1ZSNmJRTjJLWnNpdUUzeGlubzFBRHc0TWpJRjZJ?=
 =?utf-8?B?SExsMFZYQm1VNHNQUWlRY1lPUCt0aGRCdEpUWkp4V3BXNUdiNWROa0lJTm9C?=
 =?utf-8?B?Q3FGNERMR1BSc2hLNm4wSVo1WlpwYUtZUGpLSFNvYlpzY3pTL0hCcjVnWko2?=
 =?utf-8?B?STQxQTlnM1FzS3ZYbGE4Z0lMbHJEaG52SnVReXFCYzU1MWEyQ3VHemZlTTdh?=
 =?utf-8?B?ODBxdit1eHBvVEx3UWJNamlDYXRMMmppaDM3ZHQzQmxQczd3VDJVa3FUeHRV?=
 =?utf-8?B?d2tBRkpsQWU0eVAwT0kySTJYdFRlOE9teW1iRmFsSmFmNUxWYkZCQUpndzNL?=
 =?utf-8?B?SjRNcTRqQ0U3SjEreTJOWm9QVCtiVWFQdWVGUFI0a0JpUHdieFJHYTdnZXdV?=
 =?utf-8?B?U0RWKzV2dDRkZWtvWmFadFRYZDFnWG9uRG9kVlpXbnFnalFDamxMam9BTkpX?=
 =?utf-8?B?NXpyekd1NDR6QWV6d25mb2d2RjIrT3NLYzZEZXBBSitXcWJzc2pSWFEvOW1k?=
 =?utf-8?B?SGpyN2wxSkc4NlY1Z1Yza01oT1ZPZVArY2ovZTF4NitIc2Q2c3JISXVqUjEv?=
 =?utf-8?B?VXJ0TGxySW9YTzRBa2ttT2U4VExiczB2ZFBHL3NQclBxYS9BM0l5YTFYTnNT?=
 =?utf-8?B?aDVtaXBkekVhaWVzUi9CZkhGS2J1SzBDMXRlN1VOeU1BNVpVY3dhNDdQMEhV?=
 =?utf-8?B?L2xYMjFJa2NEYmZmS2did2VhWG9JU1lqM250d0RRazA4ZUM1NWtDK3Bmb1ZV?=
 =?utf-8?B?elFTT01jOG1NVUVjMURWL3hhZGg3QkVlOW1oT2ZTQk9pcmh4RmE3NkJFS01X?=
 =?utf-8?B?TlBzUjE4QzlqcUtDNjZYMlZSS1l4akxhVDBWWGUyNHZsc2xIQWhiQlBnRnhH?=
 =?utf-8?B?c09aYVhZN0d1VHRickxrVndFY0g2c0wzR2lKVlBCSWE1NFcxK3ZCM1lHZXda?=
 =?utf-8?B?TzRobXozZDNrNjF2NmVCWmdzV1A1d001enlMKzQxVjNTbEU5L2hoUHpUd1Vx?=
 =?utf-8?B?ZWtLMW84QVVKeSs0VGlxcEdGS1I3emxGTmVJQS9HOWZBK2J6SXNydnhPb3ZM?=
 =?utf-8?B?bWplRmZ6YmVCVU1xUWNmdS9yL3BXZWJQQzFWMDJpRm9NMTRNOU1nQXIwZ3BU?=
 =?utf-8?B?REFON250ZC80NDRObWFPZGVFcU9GOUJEWWRwcW0zSzVSblZDMEE0bUx4Mi9x?=
 =?utf-8?B?ZzhuVldnaXRhcHhUdWd2OEg0WlR0TU9PYi9EOGtRTlFKcHdlbXA4RlZua3hx?=
 =?utf-8?B?VXRkMTZRdTFtU3pSemMyR3dTaEl1ZTlJUjV2UjFIM1RGdUZnMHlTSmxaYWhD?=
 =?utf-8?Q?Clv9sd5gk5ZXI/Co2Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5919fd-83b4-4aec-0c70-08df1a1ee9a6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:33:38.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiqN0OkeHBD4oo+otJnfwXB9NSa6IwqTw/OHT/Kk2wwu5nw0OQckLO45qMv3Xe5zVJzn6aYekP3IjGZ29uCcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002



On 9/19/2026 10:28 PM, Akihiko Odaki wrote:
> On 2026/09/18 18:59, Honglei Huang wrote:
>> Integrate userptr into the blob resource creation ioctl.
>>
>> - A non-zero userptr selects virtio_gpu_userptr_create()
>> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
>> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>>    advertised VIRTIO_GPU_F_BLOB_READONLY
>> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
>>   drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
>>   3 files changed, 37 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/ 
>> drm/virtio/virtgpu_debugfs.c
>> index 3a68a16b58..b8b9b40584 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
>> @@ -55,6 +55,7 @@ static int virtio_gpu_features(struct seq_file *m, 
>> void *data)
>>                   vgdev->has_resource_assign_uuid);
>>       virtio_gpu_add_bool(m, "blob resources", vgdev->has_resource_blob);
>> +    virtio_gpu_add_bool(m, "blob readonly", vgdev->has_blob_readonly);
>>       virtio_gpu_add_bool(m, "context init", vgdev->has_context_init);
>>       virtio_gpu_add_int(m, "cap sets", vgdev->num_capsets);
>>       virtio_gpu_add_int(m, "scanouts", vgdev->num_scanouts);
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/ 
>> virtio/virtgpu_ioctl.c
>> index 3d8e4ccdb7..3dc058e50e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -36,7 +36,10 @@
>>   #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>>                       VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
>> -                    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
>> +                    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
>> +                    VIRTGPU_BLOB_FLAG_USE_READONLY)
>> +
>> +#define VIRTGPU_BLOB_HINT_MASK DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING
>>   /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
>>   static void virtio_gpu_create_context_locked(struct 
>> virtio_gpu_device *vgdev,
>> @@ -122,6 +125,12 @@ static int virtio_gpu_getparam_ioctl(struct 
>> drm_device *dev, void *data,
>>               return -ENOENT;
>>           value = vgdev->blob_alignment;
>>           break;
>> +    case VIRTGPU_PARAM_USERPTR:
>> +        value = 1;
>> +        break;
>> +    case VIRTGPU_PARAM_BLOB_READONLY:
>> +        value = vgdev->has_blob_readonly ? 1 : 0;
>> +        break;
>>       default:
>>           return -EINVAL;
>>       }
>> @@ -453,11 +462,23 @@ static int verify_blob(struct virtio_gpu_device 
>> *vgdev,
>>       if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
>>           return -EINVAL;
>> +    if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
>> +        return -EINVAL;
>> +
>>       if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
>>           if (!vgdev->has_resource_assign_uuid)
>>               return -EINVAL;
>>       }
>> +    if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_READONLY) {
>> +        if (!vgdev->has_blob_readonly)
>> +            return -EINVAL;
>> +    }
>> +
>> +    if (rc_blob->userptr &&
>> +        rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
>> +        return -EINVAL;
>> +
>>       switch (rc_blob->blob_mem) {
>>       case VIRTGPU_BLOB_MEM_GUEST:
>>           *guest_blob = true;
>> @@ -495,6 +516,7 @@ static int verify_blob(struct virtio_gpu_device 
>> *vgdev,
>>       params->blob = true;
>>       params->blob_flags = rc_blob->blob_flags;
>>       params->blob_hints = rc_blob->blob_hints;
>> +    params->userptr = rc_blob->userptr;
>>       if (vgdev->has_blob_alignment &&
>>           !IS_ALIGNED(params->size, vgdev->blob_alignment))
>> @@ -518,9 +540,10 @@ static int 
>> virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
>>       struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
>>       struct drm_virtgpu_resource_create_blob *rc_blob = data;
>> -    if (verify_blob(vgdev, vfpriv, &params, rc_blob,
>> -            &guest_blob, &host3d_blob))
>> -        return -EINVAL;
>> +    ret = verify_blob(vgdev, vfpriv, &params, rc_blob,
>> +              &guest_blob, &host3d_blob);
>> +    if (ret)
>> +        return ret;
>>       if (vgdev->has_virgl_3d)
>>           virtio_gpu_create_context(dev, file);
>> @@ -538,7 +561,9 @@ static int 
>> virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
>>                         vfpriv->ctx_id, NULL, NULL);
>>       }
>> -    if (guest_blob)
>> +    if (guest_blob && params.userptr)
>> +        ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);
>> +    else if (guest_blob)
>>           ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
>>       else if (!guest_blob && host3d_blob)
>>           ret = virtio_gpu_vram_create(vgdev, &params, &bo);
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/ 
>> virtio/virtgpu_kms.c
>> index 1d4d3bf46a..06c2bded49 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -249,15 +249,19 @@ int virtio_gpu_init(struct virtio_device *vdev, 
>> struct drm_device *dev)
>>           vgdev->blob_alignment = blob_alignment;
>>       }
>> +    if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_READONLY))
> 
> This hits BUG(). It queries queries VIRTIO_GPU_F_BLOB_READONLY, but the 
> feature is absent from the driver’s features[]. virtio_has_feature() 
> validates device-specific queries through 
> virtio_check_driver_offered_feature(), which executes BUG() for an 
> unregistered feature. This affects ordinary probe regardless of host 
> support.
> 
> Please add the feature to the array and ensure that the patch is 
> properly tested before submission.

Really thanks for the point out, we did test in previous version patch,
but for passing AI review I have to added the VIRTIO_GPU_F_BLOB_READONLY 
before send out, the AI review are so many, to address it I made many 
changes, resulted in this issue being overlooked. And I have tested the 
V9, the guest boot is OK, basic function is ok.

And due to the changing for virtio gpu, many other components need to be 
changed, need some times to give qemu/virglrender... code. We have a
lot of parallel tasks here. But I will keep changing code until you are 
satisfied.

Regards,
Honglei


> 
> Regards,
> Akihiko Odaki
> 
>> +        vgdev->has_blob_readonly = true;
>> +
>>       DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
>>            vgdev->has_virgl_3d    ? '+' : '-',
>>            vgdev->has_edid        ? '+' : '-',
>>            vgdev->has_resource_blob ? '+' : '-',
>>            vgdev->has_host_visible ? '+' : '-');
>> -    DRM_INFO("features: %ccontext_init %cblob_alignment\n",
>> +    DRM_INFO("features: %ccontext_init %cblob_alignment 
>> %cblob_readonly\n",
>>            vgdev->has_context_init ? '+' : '-',
>> -         vgdev->has_blob_alignment ? '+' : '-');
>> +         vgdev->has_blob_alignment ? '+' : '-',
>> +         vgdev->has_blob_readonly ? '+' : '-');
>>       ret = virtio_gpu_find_vqs(vgdev);
>>       if (ret) {
> 

