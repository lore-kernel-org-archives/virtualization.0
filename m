Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795588918;
	b=OrIcHm2Kv02snDGmcPCj6FsWRftLY4pB6574PiJt76XR/+/is12l0lMWXz/JrtxAvMn0
	 v/w36gwyT1+ieb6ROqa+6J+K5fIJ8YjDwgINmBtou0V4knsdiFcMkx20iFCCWtEsI4Yr9
	 1r6F6Xh6GrQOTvTFHSL97R0vHxu7sEh+nFhgBSv1bSLgG6ISdQWOKz/ZRfosjv1zcSDFI
	 GiRJkvum6Noei2odJrBfl1mDisW4Pg47TThOU/ZtToVMETqaxVmTvRJtALb/NIz0Ag0Fk
	 b82s6Ws/0VpK+SCOXOsCmYKWSju8LKOyGKZg8IxmRsgZs/dsa3n781rHf/xM0xevI7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588918;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/bvnLbGm4PFx45Bg24tfHX5DxF1IX1WyJtFFLQTuRVQ=;
	b=nR/9QTzQ13ekx78dh5o7REZ25qBEYq3qQBQYtXmEu4KVAK+eypaQoP60s1aqqQS68rlh
	 tNjcVSjIhhuaTU10j1puMfpL8lrj8ZEgfnT4pyk+w16MuPqX+ft9fhUIlOezlNeqYP7J4
	 vkFF4ldYBWpKSaCGCRmRSlgS2xu5qpdiwqr9/bkZqfC8SUcRxul0qJL0jz/kYrvGegU/c
	 fsjrepufFaOHHse0iT0L4LybtfCp3WzbGPCSiK7yjqzqjwKI/4AeoY/O47+V6N23T7mhr
	 0AVsvpSzKzs8ErerHRzQalxh3sgwVZziEoXFwmU1HOxtYUugkzsYh+5T9PxfH+kphpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M30WAhoA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.27
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD797606A31E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 06:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD797606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M30WAhoA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks6GcugBQWdT8W3rj4zfj6BCNqZsvtN7LJZpE5tlg/LllU6cNUhgWNmVOWD13N2nCEw10Okx6DCWNbNVjS4gARPCWwcVuAKg+Rm6p6cZd69rbt9KR8nNjnlHLy73YjMu1M05vIqb/o438B40OYoXx52kwSUhi0uAgz2DE+Uzb10bpqb+jAm74/DN//bysXAHmFNVynXHj4XsziAsaUAwTd7RstcXv1DSeDVjBZ1oHOAjnJDSZL4D1CwEMLR3XLn7lNCBLeAlMl7uA7syo1+HC7Y/5qaylQJnehtpg4EonbwZERvzq/iIPyCoL/AVcEk4n/vY+2SYkWa0kEu2Ou3dxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bvnLbGm4PFx45Bg24tfHX5DxF1IX1WyJtFFLQTuRVQ=;
 b=kB5Ako+sWsKYSlUiYNblAqk8WB/lt6BXKOydyQ9WqhDq/ZlOaRpojD7/mgrhVyfa2L9xh/FARHuInMIYm3Kw69N6btGe2ym16FAxAEQjACfVdLcT9/GiCvr40jeEirVjvAOtMDWvda32cULLWUj56pyVvoDw/ZtHreIKp5O8dEr7Mo02dazJDqtb6Fbt8nVAXcsPluHwSHBecoseZKi+VzuZ24TSdmjOaw7KNbxubnKoAncu1zDLczKIWDhrqkkvtFte74LoOpgFKIHcrGjdJSUPf+cFbDqoqTWeqkA45VpVDIdziChlSpqTF4NwRElVEAnCTQLlukefq1fHWQnWig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bvnLbGm4PFx45Bg24tfHX5DxF1IX1WyJtFFLQTuRVQ=;
 b=M30WAhoAlSVcLLMc2qmr89I3/hNvxBWGl9HbEfunDgXBWVyfk5pJpojRdqe5TORd9zevHVChTLqNeK0M6syiUfrIJB0dL0eWehgvAoQueEEO1nTSJak66fqlU0+eXhwUp5f6VfYOngcl7z7FwasDX6lQef8pqwZKleBoGeg4Hxo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 06:41:53 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 06:41:53 +0000
Message-ID: <baa471a6-502d-41ac-9ef3-cbac35a103e0@amd.com>
Date: Wed, 25 Nov 2026 14:41:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/4] drm/virtio: userptr blobs for native-context
 compute
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20261106082625.812860-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::8)
 To CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 140777bc-b809-4a6f-dbc6-08df4abf30b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|261102130727099003|18002099003|22082099003|6133799003|261009221727099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|261021121427099003|261021123027099003|261021133027099003|261021130227099003|261021135927099003|261022075727099003|261022113327099003|261022105027099003|261026140227099003|261102123227099003|261026135527099003|261022115727099003|261026130827099003|261026121527099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZaCmBL8A8mYC+qq/Ho1TuRt8NFir1Cex6l7T2fREKhkec5mS5LI0eBprGhGxj16IjSK0EieE7nWG6ePKxscg3lmpGPddCMnaEr8U+xTLaRX/EvNv/EGatwrbUrYvhYqeHp3qeOazSw9YkdPG52ZRbik0mfwJe9Jv0l05BinZknM3hlBEx09JRnBl7xrJPYYf6fOeYkxNbMQxEAwmzKdV6bzjZLnJsvOVg25nj6jyVbqs4p/G0refGiHP0CWsUbPvbhFuFEjTqnRz6I5uk798YWawMLagxdHITeY5U/Wq0SIFdVtNAakSqY5v+7RB7Ir+L8grglfzXKRlgqFhH5NhT/GPyKrybIgXhdOrqB9+2loC417HMU6+d/RWXm2a/ZWIUKEskG/IhejFw8vt5Vv5L2YF2Mq0Pw7Mo+SrkfmkDajdg8HyZXKkOsD2ZiJ02bzRUEM75pP6JUpTHrujzeSAoTIcdYaPSDQ7fenR8zD3FcB8pY4t+/PM13d4j2lwrVdGfjQLyHPgX+IWJMxu78RdjW/cLdSa5epqyJZlbl+/uNZ0UmUFvwC0zbtSEYOe2V12/mTOlNbeiuFcLDqK7b45kOu6ZFyyBWMxaAGV7MAGenmmTowR4kahKbDfV3Q6Ih3g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261102130727099003)(18002099003)(22082099003)(6133799003)(261009221727099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(261021121427099003)(261021123027099003)(261021133027099003)(261021130227099003)(261021135927099003)(261022075727099003)(261022113327099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026135527099003)(261022115727099003)(261026130827099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDNIZXZUSWtXZll6ejlZWlNJQU1LZjZldVFIYjZwOXpaRHBvWUorSDlNZkJJ?=
 =?utf-8?B?VHdRZnJZRVRLcnZ2RmNTdWxZaFhVblh3WWU4WjNOL1dHUDY3bXRlNDNPUU4z?=
 =?utf-8?B?elp0OGFzblNLR1NtZDA3eWM3NEF4bXArWkVsbzllbkh2dXQyem41aGFvWUdn?=
 =?utf-8?B?U1E5bFJPbzhwOVRPMlNkR0NoZ2tZUXZxMWxDSWtBUVZMaENaMlZlMER6UWpF?=
 =?utf-8?B?T01vYXFrZWZVV2RrMWZuN2lQU3dYMG5jd05iSm10S1hVTmNJYzQ4Q3pYRzJD?=
 =?utf-8?B?SWFlelhRNzZoVzArazFpWjhDbkVoVGNRUjBoS2pza3l1eGpFalZIZXV2cHhL?=
 =?utf-8?B?UFAvVEJqWEowTjlXR1IwU2hsdjV2ZWNlRVBHYitjMlhwODB4N2lUT0QrZlh5?=
 =?utf-8?B?MHRQV3FseFZiZmZJM0lPUXB3bHdnbjZyZUtpOTE5RVBXYXJmWlFZSTExUGRa?=
 =?utf-8?B?dWlsZFRNZUhoRzFVWVYyNW9pbEppUkw2N1BlejZ5RjRsOEk3WE04UGVyckxN?=
 =?utf-8?B?OUxWQzFhdlM1TEFKc2t4cHpIMFZwU1FFTWphU05OVi80dTQ4QmEvY2RpcUNL?=
 =?utf-8?B?NFpZL3hMMURnSXpEYk9MdTdZY2UxNGVkcUNaUXJidkRUTnh5T0trUE1vU29Q?=
 =?utf-8?B?VFpvUmh3U1Y2VXJ5SHdxRGhwZjF4aCtOR3JrMlMzLzlmak8rbGlGWE40bnhq?=
 =?utf-8?B?RXR4U3VZbjJzWXc1N2I5bGlpSmlUM3Job211TlpsZW1wL0pnMENDcWs1cTZ4?=
 =?utf-8?B?MkFIZXdxWXkzNDBJNjUzWnZOZkVtdWppMmxvaHpoeW8zY0w2L0Z0bEs1UVM5?=
 =?utf-8?B?aE5icUdrYUJRWEZRdFlTaVRGQjduQTlGZUE0ZkxHdktKNWlpRlUvVlkrbm9t?=
 =?utf-8?B?d3BEV0t6SnlVTDJJQlFJQnd3VFJaK2pUbkk1NHpkMTZCb25tVUdjODFTazQx?=
 =?utf-8?B?SndCM0pqWHFQK0p4aVcydlNycFBxeEh2UWFHSmdDZUlSOE96cVRndDgxZUFl?=
 =?utf-8?B?cHRVb0RXZ0I0VmpnUWI0T2orcmVxSjlTVEF6WTRCL1VFU205alRFNEFVQzRi?=
 =?utf-8?B?Ti9NU0dsRHV1b0QxZUtPVjlNRFBVNzZhY09GcTYwa1d0MURGSDJSSktQRVM4?=
 =?utf-8?B?aTVjWjlzWGQzNUdKWXFXYTJ5K1NQL0htQ2JZbS9NcTY3NkJOTy8zL05veFNj?=
 =?utf-8?B?VGV3Vi80ZUV0S0NuZVljendGOXlWNktrZXBnZWRIQ0JUNDA3b0lybmZrTW5E?=
 =?utf-8?B?REZJYldmR01pZmFuK25rM0VBY1JFRFBXNklzYjRkU3RvYVp3VEM3WUkwQWsw?=
 =?utf-8?B?aTJzckxhaWNxQWUwT1puRUI4aTlwOVZWNS9kc1pNQ3JaWDA1L1pGM2EwdDk5?=
 =?utf-8?B?Ykl4MWtmSm9WaXM1NUZSdGdsa0ludUoxRW5VS29HWUlTNnh4RUZPdXpFS29S?=
 =?utf-8?B?NHFneFk2cXMyNWdrbVFucGNaYTkzWXNtNkRmdW43THZ1R3U4dTZMN2U0VEkx?=
 =?utf-8?B?Y2VQeVpIMlUzZ3VlNGd2blQvODNVUnJ0d0dvTmp4RTRzL1VlVTU0RTByWU02?=
 =?utf-8?B?QXhUMGdod0NRQURXT3E0bTVGK1p0b0RDVXVVM1htb3VNOWN1WHEvNTkvdmNG?=
 =?utf-8?B?byt5VjY0cVNDK2lsU0NvcE11cldNKzFSOG1uZEJhRlRlQ3QxYm0xWXlKbHdN?=
 =?utf-8?B?Q2dkUysxelZ1SitpMmNrTkUzelRQaW9yUlNGMDNpekY3NFBET3FqQ3NNejlL?=
 =?utf-8?B?dUNRWkttd1lHWDdzK1JzdC90T2RSNUlpYzl5VXNUV3BzRlNtYXNpZHVDdG53?=
 =?utf-8?B?V0VrVUJtTDhBOXRxcmxNd1BUbmd0cm13dzc0S1VGMkJ5N0lJbXFqL25Fbm5E?=
 =?utf-8?B?dExNK3IyUlh6VEwvL2FtdkNPSzUzSFp3NkJMMUs1QllDQVk5QTlFSVV3MmVr?=
 =?utf-8?B?UXlsenpyWENBeUttWVNHT2xKUjloaFdySHRINld3RnZKK0xCT0tDaXRTM1FT?=
 =?utf-8?B?OHk0NHkzZUMzSGRuSFNVNHpkQ3g5d1VpZUx0cS9tbkJVMVcxeUlUcExFMnRz?=
 =?utf-8?B?anpiNWZYbGZoRnltcFpzTUJLNVJrL0V2L2Jhb0dQdlJBUDQzaHBzSDFSQTZY?=
 =?utf-8?B?VENEUWRmdUErOTd1R0ZrS2ZCcEQyWG5tSEFScERDUnE3RFMyYWVHQlpkejR3?=
 =?utf-8?B?ZXJrbEVMejBMSUZ0azgrUWNIVElvZHZWWUlmOU5Wa1NMUmtVS0Y2QitNaWxE?=
 =?utf-8?B?NnFrM1BUZ29xSFgzU1NqZUxTMjJtVFE4VXVYdk9QZUg5QjEvT0lQMytvUldl?=
 =?utf-8?Q?V9GZc1y4YuPsEOIfBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140777bc-b809-4a6f-dbc6-08df4abf30b1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:41:52.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIdJP00lXOg0zOvFuwfrfS3GNWeNIcfYg6Tuf1rSx15E48e6iX77djURRCuEnp93lRXFFZ2KFUwdH/VsoZUyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081



On 11/6/2026 4:26 PM, Honglei Huang wrote:
> This series adds virtio-gpu userptr support for ROCm native compute
> contexts. The guest kernel pins an existing userspace mapping with
> FOLL_LONGTERM and exposes it to the host as ordinary CREATE_BLOB
> backing entries, avoiding a second shmem allocation and memcpy.
> 
> A non-zero userptr field selects that path. Probe
> VIRTGPU_PARAM_USERPTR before using the field so an older guest kernel
> rejects the request instead of silently creating a shmem blob.
> 
> See overall detail in virglrenderer pr [1]

Hi all，

Any review comments on this series? includes code for the kernel, QEMU, 
and other components.

Open to any review.

Regards,
Honglei

> 
> Patches overview:
> 1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
> 2. Extend DRM/virtio UAPI with userptr, PARAM_USERPTR,
>     USE_READONLY, and F_BLOB_READONLY
> 3. Implement core userptr functionality with page management
> 4. Wire blob ioctl creation to userptr objects and probe the
>     readonly feature
> 
> V10 changes:
> - Require DMA_ATTR_REQUIRE_COHERENT on create and restore mappings.
> - Use drm_gem_object_put() after UUID assignment or handle creation
>    failure.
> - Drop the new_pinned < 0 check.
> - Validate the userptr address against the host's blob_alignment in
>    verify_blob().
> 
> V9 changes:
> - Marked series RFC pending a virtio-gpu spec update for
>    F_BLOB_READONLY / BLOB_FLAG_USE_READONLY (Odaki)
> - Moved VIRTIO_GPU_CAPSET_ROCM/VIRTGPU_DRM_CAPSET_ROCM from ID 8 to
>    10 to avoid the gfxstream/rutabaga_gfx 7-9 collision (Odaki)
> - Added the missing VIRTGPU_DRM_CAPSET_ROCM alias (Odaki, sashiko-bot)
> - Dropped the kernel/guest-internal wire-flag comment from the UAPI
>    header and reworded "Guest VA" to "address" in the userptr field
>    comment (Odaki)
> - Fixed a BUG() on every virtio-gpu probe: VIRTIO_GPU_F_BLOB_READONLY
>    was queried with virtio_has_feature() but never added to the
>    driver's features[] array (Odaki)
> - Removed the dead TRANSFER_TO_HOST userptr DMA-sync branches added
>    to virtgpu_vq.c; verify_blob() already rejects VIRTGPU_BLOB_MEM_GUEST
>    for that ioctl, so the branches were unreachable (Odaki)
> - Documented the DMA mapping and bounce buffer behavior of
>    virtio_gpu_userptr_restore() and dropped the zero-copy claim from
>    the commit title and message (Odaki)
> 
> V8 changes:
> - Drop guest-only USERPTR ioctl flags; a non-zero userptr field
>    selects the path
> - Add VIRTGPU_PARAM_USERPTR so older kernels do not silently
>    ignore the new field
> - Request GPU-readonly backing with virtio wire flag USE_READONLY
> - Accept USE_READONLY and omit FOLL_WRITE only if the host
>    advertised VIRTIO_GPU_F_BLOB_READONLY
> - Restore userptr blobs after hibernation without the shmem path
> 
> V7 changes:
> - Mask guest-only DRM flags out of CREATE_BLOB wire blob_flags
> - Clear userptr->pages after pin failure to avoid double-free
> - DMA-map userptr SG only when virtio_gpu_use_dma_api() is required
> - Use DMA_TO_DEVICE for readonly blobs
> - Sync userptr SG for the device on TRANSFER_TO_HOST
> - Mark writable pages dirty when unpinning
> - Reject USERPTR unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
> - Disallow PRIME export of userptr objects
> - Note that CAPSET_ROCM uses ID 8 because ID 7 is taken by VIRCL
> 
> V6 changes:
> - Rebase onto drm-misc-next
> - Keep USE_USERPTR / USERPTR_RDONLY as guest-only DRM flags; drop the
>    virtio wire-header patch (5 patches down to 4)
> - Fix userptr lifetime, DMA mapping, memlock accounting, alignment
>    checks, and PRIME SG export
> - Updated corresponding cover letter and commit messages
> 
> V5 changes:
>      - Add VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY definition to patch 2
>      - Dropped unused VIRTIO_GPU_F_RESOURCE_USERPTR feature bit in patch 2
>      - Included VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY in
>        VIRTGPU_BLOB_FLAG_USE_MASK in patch 5
>      - Add check for userptr feature in patch 5 before creating userptr blob resource
>      - Updated corresponding cover letter and commit messages
> 
> V4 changes:
>      - Renamed VIRTIO_GPU_CAPSET_HSAKMT to VIRTIO_GPU_CAPSET_ROCM
>      - Remove userptr feature probing cause it can reuse the guest
>        blob resource code path, reduce patch count from 6 to 5
>      - Updated corresponding commit messages
>      - Consolidated userptr feature detection in final patch
>      - Update corresponding cover letter content
> 
> V3 changes:
>      - Split into focused patches for easier review
>      - Removed complex interval tree userptr management
>      - Simplified resource creation without deduplication
>      - Added VIRTGPU_PARAM_RESOURCE_USERPTR for feature detection
>      - Improved UAPI documentation and error handling
>      - Removed MMU notifier dependencies for simplicity
>      - Fixed resource lifecycle management issues
> 
> V2: - Split add HSAKMT context and blob userptr resource to two patches.
>      - Remove MMU notifier related patches, cause use not moveable user space
>        memory with MMU notifier is not a good idea.
>      - Remove HSAKMT context check when create context, let all the context
>        support the userptr feature.
>      - Remove MMU notifier related content in cover letter.
>      - Add more comments  for patch 6 in cover letter.
> 
> [1]: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1708
> 
> Honglei Huang (4):
>    drm/virtio: add VIRTIO_GPU_CAPSET_ROCM capability
>    drm/virtio: add userptr blob resource to the UAPI
>    drm/virtio: implement userptr resource support
>    drm/virtio: wire blob ioctl creation to userptr objects
> 
>   drivers/gpu/drm/virtio/Makefile          |   3 +-
>   drivers/gpu/drm/virtio/virtgpu_debugfs.c |   1 +
>   drivers/gpu/drm/virtio/virtgpu_drv.c     |   1 +
>   drivers/gpu/drm/virtio/virtgpu_drv.h     |  42 +++
>   drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  49 +++-
>   drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 +-
>   drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
>   drivers/gpu/drm/virtio/virtgpu_userptr.c | 350 +++++++++++++++++++++++
>   include/uapi/drm/virtgpu_drm.h           |  11 +
>   include/uapi/linux/virtio_gpu.h          |   6 +
>   10 files changed, 480 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c
> 
> 
> base-commit: 1ecab8b0bad393750c60cc3819ce9c256595463c

