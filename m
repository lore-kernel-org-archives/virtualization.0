Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52130AAB8
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161302; cv=fail; b=hltzshlrzD7roF2YIujE0ov2FgozhiVvRFNR/bJ2D8bgNfMTOLS43znVpW/MKh0kzKIBfAzSrN1d/5M6ez4UG6wIawL3bg+3qbJRMfVp9KMl3VYCxltQeb9feCnAkIVtkMF1Gonu/22Mwyp1Buy3z3hLCc+pvtfabRin8vvcNWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161302; c=relaxed/simple;
	bh=u0epxSjblaimAjGSPCKE3FXD/ajITvCnwO5wdElh8gk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hTPglrkRfa9T0odBHNGmApFnE6z1joAc1R3/qet9F7CAAXchM8S6EaZCgaGv0VPrg6tVscIYD8j0WuwyDy+2G5S1EOiFaDIAObpI9NdF5vmLCl5kOSSJVldX/Gpf6LClTbwZRpO2tVqkit2k4AHnxsqzLHfYgHt4F95kBM6111g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UCankGea; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UCankGea"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQhkcmRMojUGC6zfTX3aFJi5m6Cmg/itC1MRBBqGQxcjIUHg71JN9SEbg3QSn72LhgntsNc2pWm4yt95q5VkpT1RoZjymaAKbgs7DNnKegQ66WdmC9Y6LoKU2LFM60OJ8nf+PzjkHDfErnFr8xZQfGLPvWUeGI/Wj1IaD5ZWlcMTokJlVD5Ux4hK+LEKiSo78I7gQrujEM40Oa68vwNhKpleHxu/GVpZXKCzElG5IF8mF9hEf4+mwmBdk90c5n8y3IWsIejdCBuZLeMgLki2KGOr7xoqnMg4T3UZzGwqvg1mJJrS4HuUVTVMLsl3jVraWwh8A3qv1FfylTvAdgrbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ZWLiP8EiTMz8TLTWOp5C0NtrVQp8SaVv17mIjq+z8=;
 b=OMu3zF6edeQ/ADsUsyD291MJE5cNcaSI02C8Y/Kt2qQzee68oqjBTCjeosNpudkGqcYey86kUV823svajgxloRDApH7q8BZcH3D79u+O5knW823T4QX3+b81ErZzI3zDJBGNpZHpXcR5itF0l+wyK7F0sMsbbAhu/Bf6N3spLAB997yBmqtY8khKNvrkpcNixfM5Itg8ABBO+949yzjzAI+BPkFH/110lkJuj8XcZfp5z2uu807jU9Pknr2eLd9/LDuefp84t1cpqNS4zj4WjAPQQLk2HIUxnVPWEY5jsjH94xVsWkOdCCVJ7zFfWEp9klRunsohPj95yBjsBrZdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ZWLiP8EiTMz8TLTWOp5C0NtrVQp8SaVv17mIjq+z8=;
 b=UCankGeaMQzAvHH9alvjV4mWLojsk6Wy2RReoO2oBx0w3gYIgHOO/Kz23YB/tyD644ladLr+FQ/tKE4OvICkK2FzNMdt94TlejDu4khZr/1PqGodUKuCmdUSVc6Isjrz1PT53idd6K5ZQDSXwDZiCvk0MmcBZW3s9T1bcc2oLK1WIyuhjed+NEOHZtydf6KFcDV4Ij4ulPiJu7kemtHohlxEp6HJlxRXr+BPgGAJ01fxJNw3Mt1mK+fTRZgvc6LpAkSaGyH2p1hwwl7O5R4exmuGx136kt3mkZK6qHAzmSmG8q3vvYvOGybv9Nri80rELlHWBqDyC1Ps3tE/qOBZ5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Mon, 27 Jul
 2026 14:08:11 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:08:11 +0000
Message-ID: <10ef2bf5-9232-4b0a-8a94-d7c84f8a0f0e@nvidia.com>
Date: Mon, 27 Jul 2026 16:08:06 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via
 backend feature
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org
References: <20260511094504.1619893-2-dtatulea@nvidia.com>
 <CAJaqyWc6gA=TU-YMYdttH3_MjBo+644kgmah1XZnvxP58Gxzag@mail.gmail.com>
 <89b04dff-3cc6-4ce7-8909-30552aed653d@nvidia.com>
Content-Language: en-US
In-Reply-To: <89b04dff-3cc6-4ce7-8909-30552aed653d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f5ff3d-8047-4122-3841-08deebe87de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CT3F0QGvF3aDUgHTyCMd9OUVwbLntOH9b2XhvUQwqRz51UssLIgqOmIEGPg9W7hzfLOcOrq5u8Guh2gtsBnrM7PEkmbbcXW7vb7TepQusBFBnX04E/N9JEUj61o/KaNiAfq7RRLA98/IxytCqN6ybtlRFeJtwJqvkg/QLkluiz0gf20cHO16VWKbgYrADBdGPASsxadKfKFS6JPj5PjHfjXhYFXotDLCkrB+QzDOZctvpjAP+YhR4giECEgslqbAFy6Yq0cks9fPDSsP2/U9iopThgU67mm3rfEfIvtlhTtc2dEuPsPm9GIUr6j3NeNoY2XiIMvlEybsCjmlH2+neZI6TePnOxeBMT1lPqZkJoM/Z/EeH5aK5CoFp5yNt64oxOrKmvTgpGTNg0CdLmoNMJ6N5SR8H0SU+HF4YMBR0S+Xqe85apw6DKir/nXzcaHUG3rqK4FByI2u7UMYmPV7jTk/MtRk0lvyFlcTA7WrD+KipSPbr4erWS1LMatUOyPVhbrE359t57VU3SPmNW81s4KqPkijW7O0yVlfi2CE7uublZdpAkok/PPCe3AU2qUWVX/SLRptwchtVQ0vLEFPEiQMRlGo09bpwvEW90+ZOmyEA381ghXtYnGJty19clp8RAJlhRO7HHqM0xSFkNzD5kmtyqvuXUrS9VuRlykWaAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDZ0Nnd1VWJGZ2RWUW9iQndwWG55cW00c3l6dm91VkhCNGFGNmtsS3JadjFQ?=
 =?utf-8?B?V3hOL3R6L1RsTUZLcjBvZGVRbWVJbzJ1bGR1QkdRak5FN2FOeUY1V3dxNlhG?=
 =?utf-8?B?NTNoa1locW9nL1ZVbXdaSklrUHVwR0kxNEIyRUM1Ymw3RW14QzVqbDBXeHR2?=
 =?utf-8?B?RWdDbEtubXorNEZnaTZ0QllIS3JDTytZYnFWbkRXekd3QTZFZWxZTHNaUTN2?=
 =?utf-8?B?T0wzUmpxWTVvZnJoZ2hDdFBDck5KNThHWmpNVHIzb1cxRXNKOTNnYSsxamJU?=
 =?utf-8?B?bE9nV1hQMzQ0aW5XcEZqdUJ0OVJlWnJSMHJMbW1ST3IxS0J4TTlWYTE0RkxH?=
 =?utf-8?B?ZVUvak5OSGZpZlNieHlIVEhnZ1N1ZmhtNXpoaHlVbEtIcEhZeEt4NThXMVd6?=
 =?utf-8?B?YVV3L3RGSUY4TkdlQ0kwcVNlZVQyV3FmaTlLNVR2WGljWG9xK2NYNExieU1L?=
 =?utf-8?B?QWdRSmpCQytFbXc0Rjc2OHZDcGVwejBJKzFZaGxFRis5UE9jOHprRVNTOGRF?=
 =?utf-8?B?Q21QT2I1emZhWEwrNWM5dXM5anpqL3BKb3RYRklXWnhPV2QrLzJwelp6ekU2?=
 =?utf-8?B?WjBBV1QxV1F3K29NcnVDaDdRTHlqaVdWbWlLbW8zUG5qVEtneFZRd0d3OFV4?=
 =?utf-8?B?OXE4ZWpIS2t1UkxUdkswUTNhNHRyVGRvY04vTG8rK3dLdEhtMWdHd3RlM2sr?=
 =?utf-8?B?ZmNsVFg4S0xhUWNNNEN2THdYR0JNSlNFYVhtUXNXOCsvRTc0aUNJdDlrRDdj?=
 =?utf-8?B?Mis2MWZJNDQxSlhibUltMWYyaU1Wd3NZT0dyN0VIZkIvSTZ4RWRvQlpHZVhQ?=
 =?utf-8?B?OFpScUhTNjRENzNBSy9aMzFTVjNuVTBsU0hzTE5GejVsUGtMMkRUL2xEQi9H?=
 =?utf-8?B?MXR1VUhRanArTG14dUIyQ2hGdGtzWU12NFRoQTV4U2VLZGlqbW1tUld5UkpV?=
 =?utf-8?B?UTBTSjh1eUp0RHBpVWJvMDhCbWF3U1dka1hEQ1NOdmtpc0ZSKzJYQTZaNmFs?=
 =?utf-8?B?L3NPSU0zbUZyb2o3Z3Jtdi9Kb2h0Q3hzZjhpZ1NkUUlCdXRYRXlhaTd5SUhV?=
 =?utf-8?B?SkZDYmFQWFVjUUROL2N3Qi85OThWV1liNkRJRVlyZ2piNXJxQXVxTGNHamFM?=
 =?utf-8?B?dmgrakg2VkN1OWZBbm01cStGRzFiT210dHkzcHhnbTVTK3lCbXZ1MXF6VFBC?=
 =?utf-8?B?ejdEbk42SGlvSzhIOUdxUW1jNEZZNEJPK041MmtuYjNTRkRCajVaQ1pXMGNm?=
 =?utf-8?B?emYvelNrRko2ZTV3ZXpHd3ExNE9PbndHZ3NzK1RudDNDUTZhYVM3YVBzL3pR?=
 =?utf-8?B?OVlsNzdQdktmYVo2WnNxK2xyYVRxSEoxclJoc0paMEJZQVJpdXNQZ1RLY0Nu?=
 =?utf-8?B?dldHZ0hLOFdBam1BVTMxdml0R25tTE1lUkE3SEtpSGtoWkQzcXZoUFRYSEVI?=
 =?utf-8?B?dGl6WUpOVlZHbkg3bmJDMUpxYWVLUU1HSldCVUovZ1ZIS0NkZVJnVUFSWUY0?=
 =?utf-8?B?V283QzQrZ08xbGdzUHpFdTVOL1kxK1RTQTgxbk1TUkFzT2YyNzlhczl1eWQ5?=
 =?utf-8?B?WS9OQVluSWV2R3RsMTBySnJGaGh6NERtVmw1V0ZDTElYaW1adXhtQlFaallL?=
 =?utf-8?B?QW5STng3RElVbFFtL0ZMZVF5dGhadFZjYURDN25BdXRzQkVENnUwSlpVRGpa?=
 =?utf-8?B?ajNNM094Qmw2TlJFVmFhSjBVdHppZU9OQnVqNitWendqQ0dGeVNKTncxV1pk?=
 =?utf-8?B?d2pydG40TnkxbzVyaWo3UW9WL3BVRU0zdW1mcjl1eHR4Y1lNZXJxUzhjYzVr?=
 =?utf-8?B?ZG9wZXJZdXFQM2VjNFBSREdCeGNzOVdkakxUQ2ZqQ2xTWVRXOFJ4NGluMDg2?=
 =?utf-8?B?OTNLWXB3YnhpSzFDM3htcWlSU2hSWDBwcXFPejlERlJyc1dwN0VSZElnRUN2?=
 =?utf-8?B?VndHMFZaS1FYZklJU3JFYW5GbTRsYmlnWnF4Y1cxalJXZ2lBeUd6QWRnc3Uz?=
 =?utf-8?B?TDF1cThLajd1OGg0NEd3M08vMkU3aDJHamEyeW9TUXR0bzhDcktuWm9UNUt4?=
 =?utf-8?B?SVdCVUN3M2xhM3dkazFWWS8zVTUzZkxuYnFSb3hWZTdlUzUwc09EdW9uTHdC?=
 =?utf-8?B?LzdOT0lidnJJOXAwcjRObjV1eElORWdNRjhrdEtCKzY2dzNraVJVdFpPUjRj?=
 =?utf-8?B?aFRSZGtwdnNidGc4VHpYQWlNdXB2N3ZGMzFWR0hPR3l4RldPb3ZFQjNLTHhw?=
 =?utf-8?B?dFREbVpHN0VWUU10NStiS2oyNS84Vkw3WjQ1dVVVTzFiRGE0SisrWVR4cWkr?=
 =?utf-8?B?dEpGcjk0bmo0T3l6eEVhcVE1R2UrS0VjMURzdHZzcFB4RlQyRzNMdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f5ff3d-8047-4122-3841-08deebe87de0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:08:11.2487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM8ePsfRfmPuRatccXMMKb3vhVPrciF6CP4IInshL7qiDgn9QV3n4qnM9Usmel3oqrOw6vyRGRHKXiCzs6CyOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF



On 29.06.26 11:39, Dragos Tatulea wrote:
> 
> 
> On 21.05.26 10:26, Eugenio Perez Martin wrote:
>> On Mon, May 11, 2026 at 11:46 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>> The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
>>> once DRIVER_OK is set. That is too strict for devices which can safely
>>> handle this during live migration flows.
>>>
>>> Bring back this behavior under a new vhost backend feature flag. The
>>> feature is supported by mlx5 and vdpa_sim devices.
>>>
>>> Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is set")
>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> Acked-by: Eugenio Pérez <eperezma@redhat.com>
>>
>>> ---
>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  3 ++-
>>>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  3 ++-
>>>  drivers/vhost/vdpa.c              | 13 +++++++++++--
>>>  include/uapi/linux/vhost_types.h  |  4 ++++
>>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index ad0d5fbbbca8..f89177957c76 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2906,7 +2906,8 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
>>>
>>>  static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
>>>  {
>>> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
>>> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
>>> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>>>  }
>>>
>>>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> index 8cb1cc2ea139..253c7fb35ea0 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>> @@ -428,7 +428,8 @@ static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
>>>
>>>  static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
>>>  {
>>> -       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
>>> +       return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
>>> +              BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
>>>  }
>>>
>>>  static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index 692564b1bcbb..67b3f49fa709 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -682,7 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>>                         return -EFAULT;
>>>                 if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
>>>                         return -EINVAL;
>>> -               if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
>>> +               if ((ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK) &&
>>> +                   !vhost_backend_has_feature(vq, VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK))
>>>                         return -EBUSY;
>>>                 if (!ops->set_group_asid)
>>>                         return -EOPNOTSUPP;
>>> @@ -791,7 +792,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>>>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>>>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
>>> -                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
>>> +                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
>>> +                                BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)))
>>>                         return -EOPNOTSUPP;
>>>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>>>                      !vhost_vdpa_can_suspend(v))
>>> @@ -805,6 +807,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>>                 if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
>>>                      !vhost_vdpa_has_desc_group(v))
>>>                         return -EOPNOTSUPP;
>>
>> Ouch to me here. By reading the errno manual:
>>
>> Nit: By reading errno(3):
>> ENOTSUP - Operation not supported (POSIX.1-2001).
>> EOPNOTSUPP - Operation not supported on socket (POSIX.1-2001).
>>
>> I picked the wrong constant even if they share the same errno value
>> (by the same page of the manual). MST, is it worth changing it?
>>
>>> +               if (features & BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)) {
>>> +                       if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)))
>>> +                               return -EINVAL;
>>> +                       if (!(vhost_vdpa_get_backend_features(v) &
>>> +                               BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)))
>>> +                               return -EOPNOTSUPP;
>>> +               }
>>>                 if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &&
>>>                      !vhost_vdpa_has_persistent_map(v))
>>>                         return -EOPNOTSUPP;
>>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>>> index 1c39cc5f5a31..ec1ff8a2e260 100644
>>> --- a/include/uapi/linux/vhost_types.h
>>> +++ b/include/uapi/linux/vhost_types.h
>>> @@ -197,5 +197,9 @@ struct vhost_vdpa_iova_range {
>>>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>>>  /* IOTLB don't flush memory mapping across device reset */
>>>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
>>> +/* Device supports changing the group ASID after DRIVER_OK.
>>> + * Requires VHOST_BACKEND_F_IOTLB_ASID.
>>> + */
>>> +#define VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK  0x9
>>>
>>>  #endif
>>> --
>>> 2.54.0
>>>
>>
> 
> Gentle ping. Is this patch missing anything?
> 
One more ping.

Thanks,
Dragos
