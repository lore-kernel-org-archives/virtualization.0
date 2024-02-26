Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FBDD26A
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Feb 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972281; cv=fail; b=UcDuCT57D1N0QYM21a1QXOsiStDYuXFYiVtdyEuVyIvRnRH66gs+dvYJA9EPipoJ5Mudc9mi4bOQJxa8IxWU3iLbH+fXli5YudINpPTNif1HA9PKJcGYVy12ym3f1mra4r05DoklPZFYtDeoN4nn+5AG17ISSelST1uUISvCsdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972281; c=relaxed/simple;
	bh=vSfMdBgzXW6w8uySPs4xc2j33lhkUJMc0HBk9qZtl5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OCWdeYEFOI4LSiTm4l7zVhJoCcBi/FvCwjsbNUCvvty2IqPrk5zC9wZSCqcly1j/C2BbHvt66qKdpYXxdBPQKK59fimbELnHn2xZl+IMEC2npufGkwTbB4dkj0zxRMla1i7JkW+/1bQu7Hv2Us34+WtcpF3Zxozk5b0yYi0mHhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QhZFNulc; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QhZFNulc"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B86D814B5
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Feb 2024 18:31:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvzQEfNVnCLu
	for <virtualization@lists.linux-foundation.org>;
	Mon, 26 Feb 2024 18:31:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2415::601; helo=nam11-dm6-obe.outbound.protection.outlook.com; envelope-from=shannon.nelson@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D34568128D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D34568128D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QhZFNulc
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f403:2415::601])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D34568128D
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Feb 2024 18:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFAz0ZHOmvzicAmOVEE+FbeutaowyWqFAEWh8zkYgMnyqzt4R6RoUnMl0+dFe7QH7uKff4/rho2HlbR6tu4gxmuHzIIyc5CvR3NQ1eHr3IYzw564v2tQj9zUgdpBV9yW8XJ530deaQ9DeuvzEG9Gad8WsKnwS29Tz6vxh33BslalNIu90tqO2phfn2WKVLnJSOkdf6mv9gUUWGFfNdCaheItWR8IKe3dUZsFzNFh/toQ+9NfFx2Z7YhIP3K0E4LiguVkY7BYO/7sMTu9UEFmqP5YH6ANdonAFtkdi24My98bT00yRJ2z1W1qbxDod/WzzXNQ93kPqTi/oL2z9V/HLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wir98LTrEz7ZaVgvMVWf/9BvpXwIAVGYV6dCCQOoa0s=;
 b=KQLvpUPIXCW82xRVibDzZ3uCdOvUFeaINDWIYkN1IvPUodA7yEZnmsnYCf6NMQBBlJxMnHhde0UvT44ij5RbjRi3Biaz4GME+eXFx4PWTFfcsttqy++vkJ8q9GOXp3oQ/qxXQA6Cy9XdTwAu/dxgD3Ugg9XuFJC50OGtgpOCjtCX8fJn06IsSyOKtC9GWCh6hp7RO0FSYnKspUN8haudfbFOuqIpK/y22DsI3SzFr48O+ifdgthRSTNjwhRCjSvaQfiVFs9kzfpObw/pObdTcmKaLCgi0fRVBFq4MaVvwq0vfHmp0hkBLJPoJQ7TCUgalqe1YqrEQbi5aW0829Eezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wir98LTrEz7ZaVgvMVWf/9BvpXwIAVGYV6dCCQOoa0s=;
 b=QhZFNulcDjQgjjX68i1T6NhEt3cpVUIHgmJTpw8Zi7JWI6yy9jbPj6SYGDB+rcfSnqLVGcvxkJXYDsHfJg6WSjAnpThNXjWoQQBgaEgob7QrpzFCxAhzgNyV7ebM0/26Le7q+KCcCBTMWvsX50FDeiIqVVN3fqgai/JmMJRv/ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Mon, 26 Feb 2024 18:31:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e4b7:89f7:ca60:1b12%5]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 18:31:12 +0000
Message-ID: <b73c74b8-ce4f-4d95-960c-5be462cacf75@amd.com>
Date: Mon, 26 Feb 2024 10:31:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/pds: fixes for VF vdpa flr-aer handling
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 drivers@pensando.io
References: <20240220011050.30913-1-shannon.nelson@amd.com>
 <CACGkMEu5WskbWu3Qte7aXyYKG53D3u8exeQESBFzJvtUS9NZyw@mail.gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <CACGkMEu5WskbWu3Qte7aXyYKG53D3u8exeQESBFzJvtUS9NZyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: e71184b7-78c5-4e9b-63db-08dc36f91be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AQvIfmVLsuUvkRQh7zKs7xOcj69rdKfJ33hEeOUAbVHhoD/nJAFN6oIz3UXEea3vcDPhWAmgSfVrJuJ4cEY3c0VLsLVrVi8b66oLjD1BzUWETuydGg6P14XEv1mR/zFnr2WDAcEQ7q0lBf7e4ek/P4y8P7PK6G6TycAU+EG5SpEpvYEWwb1MH+xbhkalNEozNx3Hm6f8siNdTrGlJ9Vn6FJnNhxbzaEaDmjj+1R326OeHEN3k2Kz9Y+jG99lHHQfJ+vUYsUD6883rrxQMkAeiUiUjr+ePgyU+Ui2pjxe0UO4806S7vnoFMIuRk5zOrb4seMeP17bQrMSVA+tO8Do7VocZD4hOuoT9Ih8HLzV+Re/9MRHHZWgSfoGq5fYVsIECi0HbYMQCe2MfMpBeHvKBjeFv5Fx2WMPXg8UWW3hyJG/qE6efUWaCCZWkcmbOvr1e+WAyqfH6A9i4RPfgs2gwtibx96nqT4ICXIVyVXuTpRVqqjqq0bIRUueXYNRl9cNsbeC084Fw1Tv/hexkuc1N51wNt3goTI/hAxim/00dzk5pZcXxrWz9eN9mXRkpA7OoEjGABWx493GNMzakAGbUpcIz0B4V1T4GBEjR1/nMNHvsHdTd3cGWgHUi/3ueTcgyRJv4Pj+7+OcKYvL2Y/DiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay96bk8vclUxMDdZVjArMDVrUlpCM2dGOTNYaFRoNWdaaytQeENFdW9uaVVy?=
 =?utf-8?B?NzBuKzBwcUNxODNvL3cxV3dzMjRYdTZDRmQ1UEdFNDRaVWdtMzhuZHNuNFhT?=
 =?utf-8?B?ZDJxUUpyK1lHR1FXRG16Q1BaZ1pTdEQ0NjNTUU5ONTRLRU9VbUROZTFkT01C?=
 =?utf-8?B?cVRTR1R3YVNRdVErTEMyL1pCL2kvYkxvNmJQYzF3aUtrWVVlTnFxenpmWVdu?=
 =?utf-8?B?YkZsOEhaUGxoTktNb1BYRFRIKzZGVitaUVNFSE11cDhSbXdsSlkrUlhVUWFR?=
 =?utf-8?B?dXg2TktMT3liR1B2b3ppL1hkRE9WOTNsSHpzQnFCcUFnazVXOTFNcExtZzB3?=
 =?utf-8?B?cTF6c3FxSDlUU1d5MlRXUWpoU3dLQVlRd2FEQmRuQjVwaDh1SUJMYUhka3Rx?=
 =?utf-8?B?UlBsbFIwbmR1QTN6a3g3dTc3cWlnbzJFelh4YlpvUUg1cC82TmEyYzFjU1Vi?=
 =?utf-8?B?TXRSTTM1UFBTWVY0Wll0Rno3dmRKT1plbGVvY1dTbldpM3p4VjYyYnJ2T1ph?=
 =?utf-8?B?aE8reXRyOFpvcjB3aGFSZjYvYUV1OFc1OExLcE92TU9iVzNIK2RncGpIWUpl?=
 =?utf-8?B?NU5vdFNOd0dzdWdleXdscnFIK3VTak9VWkhrelR4eXdIaEUzOU55dk9EMmR4?=
 =?utf-8?B?Q0Y5dCtjUUg5Q0l2R2o5b2EzUExza2tueEwxS2MvMU5ob2dXM3NnN3MySis4?=
 =?utf-8?B?ZU1KUmxvOGpiV2dGNW1Cd3p1TFRPalBEeUV1bnBpMGRWUnloTEcvUUlReTZk?=
 =?utf-8?B?WlhMTkdiV0w3c1ZtdG13aU8zTWtMejdsaEdJMjFlVzdZRkU5RkUvb0kvMnRW?=
 =?utf-8?B?cWZBRitIMXFSUVJiTHFOR3g4dFJoOFZTU2RwaUFzaSs1aU05a3VzdlJ0RmVT?=
 =?utf-8?B?MTJxTW5FenJpU2JlcmgrdzJ0bVZ1b0dSaCt0U1ZqMG1EYUNsWm1LZ2wyRTB3?=
 =?utf-8?B?Sm01UEMwNlNiMzFkaVZXNkM0QndORGFhTUpuU1k2cVo2UzdOS3c3ZVJZOUhE?=
 =?utf-8?B?Q3l2dWR1SWV6K29DY1Nqbm14blBEcTRkYWxzczBRM1pnak82WmlLZVFCa1Ft?=
 =?utf-8?B?TzQxUTc1Ykl1c1diTTBVclFuM0RJTUFPcng0cEh5emg5eTN3R2VEcVhZRnpB?=
 =?utf-8?B?MXhrUmpUWlJPb1B4aDBvWWJEck1KYlFxakh2SVcxK2dzK212L1lsZjRWVUdU?=
 =?utf-8?B?cUNLdHdTZXZETngxMzh2QkUxUjBIQkVHa04rK0RBOWltZElPMVlOOEYwaHRx?=
 =?utf-8?B?REFNTlNSU3JqdFBpbEZmZWJzTTFoM3NjemZmcDdJWTZHZnZURTA3bkY0dk52?=
 =?utf-8?B?bzBVNzUzWTFIU1RtVkt4VFp2Qkt4d2xLY2Y4VDNHTktzL0MrRVJYdG52cjlX?=
 =?utf-8?B?Q015M3o0aWc5SlhnTGV0b0N6bE1CVGhIWXdPOTdVQTZWaHZidi93ZnhFdmww?=
 =?utf-8?B?ZE5SWFZKeStWTU9XUS9qV2NvRy84RmE2ZVhpZ29UZUZWMGhOR0RXeTgyNVpZ?=
 =?utf-8?B?VmovSmI4UUtraE55VE1SRmMraG9LRjluRVdFUnRxMXJ2ZGpQb1ljVk5mN0E1?=
 =?utf-8?B?dmhndGxSbnF5NDJUcFJvb1JrcC9mcURteVhHZFcvZGJmYndVaDVkWGp3S0Jr?=
 =?utf-8?B?NDcweWFYcE5qNmg0TVljYjhrVCt1SkY4eWNic3BPZHFMSUVjWXFuaHRML1Zs?=
 =?utf-8?B?MmFIZjVEeWp0cGV1alYwMllqOHNNYkNTaXpQOVVZWUhzNUpKMTRPTy8xSFdW?=
 =?utf-8?B?YktNVmM0ZGNZYjcvOXgwa3dBTU9Nbksrc1UyZnRNSEFBZjlXbXFQMmFZU2Ny?=
 =?utf-8?B?ZUpnUm9jNGxHczA0WURwc3hYc1N4TEZoSXRLYWZtU1NSdm1VUGdPWC9XSk50?=
 =?utf-8?B?NmZKZ2R3cmpkRS91WFgyU3ZFWmp0eElhUWtiRDlpWEY1VXRQM1FKbjFjdTcv?=
 =?utf-8?B?R3hEekE4elNpbUExVlJiWFdIYWZhbVkrN1BxNVVHQk4wK0RKU3l0TktITk51?=
 =?utf-8?B?dnc5SXBseGVsYURHbzc5Qy9oUkcxek5YQUNyOUN5Sk9Ea0lWVTVjYmhVTjFG?=
 =?utf-8?B?WmpZSHFETjdsdG80QnVSbXRwcW1oWUZUSnVTWEhhcnM3Z1hlNlVVdzlRaGhT?=
 =?utf-8?Q?naN6ItuUcUlLluRc6ZDumnlAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71184b7-78c5-4e9b-63db-08dc36f91be6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 18:31:12.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvNUsMfDrgSRa6i5kPmyO22tDInUmm1dITr1VxN6nm5VHGm6/5ZyKjoRNeMhkNca6q3RCnfmmTzQKRScJZ2Qqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

On 2/25/2024 9:19 PM, Jason Wang wrote:
> On Tue, Feb 20, 2024 at 9:11 AM Shannon Nelson <shannon.nelson@amd.com> wrote:
>>
>> This addresses a couple of things found while testing the FLR and AER
>> handling with the VFs.
>>   - release irqs before calling vp_modern_remove()
>>   - make sure we have a valid struct pointer before using it to release irqs
>>   - make sure the FW is alive before trying to add a new device
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/vdpa/pds/aux_drv.c  |  2 +-
>>   drivers/vdpa/pds/vdpa_dev.c | 20 +++++++++++++++++---
>>   drivers/vdpa/pds/vdpa_dev.h |  1 +
>>   3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vdpa/pds/aux_drv.c b/drivers/vdpa/pds/aux_drv.c
>> index 186e9ee22eb1..f57330cf9024 100644
>> --- a/drivers/vdpa/pds/aux_drv.c
>> +++ b/drivers/vdpa/pds/aux_drv.c
>> @@ -93,8 +93,8 @@ static void pds_vdpa_remove(struct auxiliary_device *aux_dev)
>>          struct device *dev = &aux_dev->dev;
>>
>>          vdpa_mgmtdev_unregister(&vdpa_aux->vdpa_mdev);
>> +       pds_vdpa_release_irqs(vdpa_aux->pdsv);
>>          vp_modern_remove(&vdpa_aux->vd_mdev);
>> -       pci_free_irq_vectors(vdpa_aux->padev->vf_pdev);
>>
>>          pds_vdpa_debugfs_del_vdpadev(vdpa_aux);
>>          kfree(vdpa_aux);
>> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
>> index 25c0fe5ec3d5..301d95e08596 100644
>> --- a/drivers/vdpa/pds/vdpa_dev.c
>> +++ b/drivers/vdpa/pds/vdpa_dev.c
>> @@ -426,12 +426,18 @@ static int pds_vdpa_request_irqs(struct pds_vdpa_device *pdsv)
>>          return err;
>>   }
>>
>> -static void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
>> +void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv)
>>   {
>> -       struct pci_dev *pdev = pdsv->vdpa_aux->padev->vf_pdev;
>> -       struct pds_vdpa_aux *vdpa_aux = pdsv->vdpa_aux;
>> +       struct pds_vdpa_aux *vdpa_aux;
>> +       struct pci_dev *pdev;
>>          int qid;
>>
>> +       if (!pdsv)
>> +               return;
>> +
>> +       pdev = pdsv->vdpa_aux->padev->vf_pdev;
>> +       vdpa_aux = pdsv->vdpa_aux;
>> +
>>          if (!vdpa_aux->nintrs)
>>                  return;
>>
>> @@ -612,6 +618,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          struct device *dma_dev;
>>          struct pci_dev *pdev;
>>          struct device *dev;
>> +       u8 status;
>>          int err;
>>          int i;
>>
>> @@ -638,6 +645,13 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          dma_dev = &pdev->dev;
>>          pdsv->vdpa_dev.dma_dev = dma_dev;
>>
>> +       status = pds_vdpa_get_status(&pdsv->vdpa_dev);
>> +       if (status == 0xff) {
>> +               dev_err(dev, "Broken PCI - status %#x\n", status);
>> +               err = -ENXIO;
>> +               goto err_unmap;
>> +       }
> 
> This seems a violation of the virtio spec.
> 
> Note that spec has a DEVICE_NEEDS_RESET(64) or do we have a vendor
> specific way to detect this instead?
> 
> Thanks

I think that we need a virtio device before we can say the device needs 
a reset, but there's no device here yet.

In this case, we haven't even been able to set up the device because, 
for whatever reason, the PCI connection is broken and we can't talk to 
the actual hardware that supports that device.  Here we are throwing an 
error on the device creation before we can figure out any status for the 
device itself and there's no place to set a DEVICE_NEEDS_RESET flag.

sln

> 
>> +
>>          pdsv->supported_features = mgmt->supported_features;
>>
>>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>> diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
>> index d984ba24a7da..84bdb45871ff 100644
>> --- a/drivers/vdpa/pds/vdpa_dev.h
>> +++ b/drivers/vdpa/pds/vdpa_dev.h
>> @@ -46,5 +46,6 @@ struct pds_vdpa_device {
>>
>>   #define PDS_VDPA_PACKED_INVERT_IDX     0x8000
>>
>> +void pds_vdpa_release_irqs(struct pds_vdpa_device *pdsv);
>>   int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux);
>>   #endif /* _VDPA_DEV_H_ */
>> --
>> 2.17.1
>>
> 
