Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F32F99B8
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457872; cv=none; b=unqaZsInTqB8vGqmWdfJCvGV+MgZSJkb6iuR+idcnnWbOwEY9gm+k+tlwGgKZ4IoZzAoxE/5GyUbAdX5KURw8ZnWbRuU7Z27aKuvQ2whAajaWy8YxLPvcE3yrpUEk5TT6JEyrHWqbjBc9FlroUK8GM1pV0CxikAcr5eT2ynV91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457872; c=relaxed/simple;
	bh=Hvppf1MWyfS3as7jeN/6m10Lw5zLo3BkYizAxj3louc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn5xC6pFDwgIA3yC9AIZ1MUThZQje3UXseYk9fP/6cEnpMAZ31hg5wHR4QN1ktm13GasroaSCs6f/5qjXY1rvpdTtqR+gkdXIVJGDOrQ+BpNzeOuotToTtBMmMcjjdNYdqXY2ziQ97venU7mWBflK/X50IPCqLma/o1yB6Wf4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VhYl5xqX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VhYl5xqX"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SIkFP51121286
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 03:17:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7yJqq3a04kcSDFbt2GTsDnPI5s5xDilbsLSAdvfilyw=; b=VhYl5xqXuBK4
	elmpHl+yTYS2osrmlQFZy0ISq5MRcXpkz5wMjmPejblNLYk7nUaoHgYbfUa9gLjc
	kuvjfatsN60mkJZfx6EirnJcNcYYTpPz8nmSLnRhGJPMXKQ85tYOqGF8qd4gFrFA
	hTTwILf1Z/HDbw5Ahl+ry6ERfnskTDLQbLoWkaR5IAjl9rG8js+o5gOCD8Reo1Xt
	ps20tdFxtKCIqE9axe1gvdu+UuQKrJCE4fepXLNidhg6conlzjs6BtuFlfuW8QYS
	QAggP2BEO8f7Q+YGoR4MokTb3AHa1aiiVezyYQkPKGZV11J9IbYxQtuS82EBRQes
	N40r2nmyfw==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drua3gyqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 03:17:49 -0700 (PDT)
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so7071052f8f.1
        for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 03:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457868; x=1778062668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhqacqCsOEkZm6rZuptvAn6IpvZgDy/PZABzqjx+5ns=;
        b=UhJkpGRnRYVrFwbOL3upeX6QLlZbH4e7i2d81hhIxzS1CBhQGTaHk/qhfBgJyVOqwu
         aHFeVhexxl4NPuyc7+Tfi/wAo1RinUVSAvAhBrSExiFHd2KKdn51er0ePmVcdQPT5ExV
         eGtmWrmgrNGIBmTB0eFf47C1UKnoQoV0AyRuFr2TJNsEgavdarub7mgT4resXLE3kVU9
         +kIyxRkn2X9rb21SRTmsdK3VpuXnbnaP5uNIJ0tYNFNh81H5NJaR3v09HKFt/3k4aKuI
         rUMcFv5lNBVD6ymUr40eLV/WWDRS//yATW2X2M+x16Uh2QsNttd2XDs7hZgi/ZO4NbsM
         VFTw==
X-Forwarded-Encrypted: i=1; AFNElJ8oCMbhlmsyzKTthR8yj9E/TalwmsbYes/ErVl4QfcS9LfB+OyPdaI193G1idSfRgllwkeERsR9C0z0QEC1Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQJn5IS/MQbuLPSd1OkZZDHzE4173G7rTQzolKOjrTltBdRy6x
	n//PVL6BfKnQ8Db529FZOEex3MUjH6V4tenb/EQR8Sphm4NV3szt/IoQHNju8ZWniIGa3k/AmHP
	30M22AVMe7Y15UEQFxvRhqpGWaoeEOznHy5HhR35AH3XMbr5aSLyFaw/Q7JNwahXFIlM=
X-Gm-Gg: AeBDietYwogum0VScG1PmSabZ4UPopS3rhHmRab3oZIwnExlRmLcJWyLMwtVA/OCNZJ
	jE60A1GZe4hXN3L0Ev6p14lUiNHWrBGOxBjnNjFTwHCG2ix4ToSHOUq88KEgLKAHqB4LfkCsFwm
	oLbQlqSIakQn1h/G7iSL95A3dFwgG8yoipN1XZUp/NFFNtYFmu7QP0K5r/BefGMpZKWzb08e7a/
	aFquZMJxsewtU5VSkuCUfbo5oGyALcpQT9o6+agvr3F9QH71m9Nk/vGX31CVGXN1PCxu6bIe6dc
	Vkg9L5RnUU1FPIRlPCOptXNPEfrvofkG6dT6ua52lNFM9/5mPTsxL+2bynRgcclOlFQ19+ieuyi
	BrHjo48ZFitogjmcEqu/CkSyZeGBvdUjw1oSp1KLghN3n8/kNKeWTW5JDEuVJbNqtKBvPF1rYnw
	==
X-Received: by 2002:a05:6000:2083:b0:439:c661:3245 with SMTP id ffacd0b85a97d-4464b2acac8mr12680057f8f.34.1777457868151;
        Wed, 29 Apr 2026 03:17:48 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:439:c661:3245 with SMTP id ffacd0b85a97d-4464b2acac8mr12679996f8f.34.1777457867712;
        Wed, 29 Apr 2026 03:17:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:18:b9f9:127f:ecc1? ([2620:10d:c092:500::4:fbdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca64ffsm5099429f8f.37.2026.04.29.03.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:17:46 -0700 (PDT)
Message-ID: <393f65a8-75c3-401c-b983-5814e1bfcba2@meta.com>
Date: Wed, 29 Apr 2026 11:17:43 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with checks for resource/map
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-3-mattev@meta.com> <20260426110517.GB440345@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260426110517.GB440345@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: EtnAQ8gWBPiTepwdhbNoZJIBhn28h7_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwNCBTYWx0ZWRfX2Dp6ITsSBfG+
 7KaHLC/eO6+30Be8gFJ8ufYMIQZ60JFLe+doMbbyViF/dRD+DBTv29wCeyNe1FaswJ3TSXIBF+z
 B/Z3aDERWwfnSM9xtgxDK8WbH+UBe1t5tx8SyDsVCPlrPn4ywbncwkSgiLbEhyKC3l8hXl63WMQ
 1TgnQ7AL+4lT7Prk/uUipL7hZCB+4mYRbi0lOP7eUnTFBleAJwIbOZxPLUtCA9nipyLckeutTcg
 iaCSxIq6TnE1n3BVJEMl2YSWxFONBC8pQAvZeaTOsPHODWbrGK6Av9xFjmE0sBaZmu6qRPStMzQ
 hKEoBLDGg1Qw6KQkFxVV6oxoEmBt323NZkxCe79ZQ7JY2QFKeABp8TWd3oab4hR4GKWnr7vAWP4
 9w8puDXdwT/H6qG9tm+sHViMT3gQROyJpt2tcL2/fzjZvnOHLHPNRH9aixBco23pYPpF6n/9bDK
 1/Ctbp02Wbam92jfHrg==
X-Proofpoint-ORIG-GUID: EtnAQ8gWBPiTepwdhbNoZJIBhn28h7_n
X-Authority-Analysis: v=2.4 cv=UYphjqSN c=1 sm=1 tr=0 ts=69f1dacd cx=c_pps
 a=pX1sPZUoWPGeQgUnKQNIgA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8 a=iaFi8TtKhGdbX_SpOFsA:9
 a=QEXdDO2ut3YA:10 a=XGGHjNwGSpTZ5T66x7Ix:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01

Hi Leon,

On 26/04/2026 12:05, Leon Romanovsky wrote:
> >=20
> On Thu, Apr 23, 2026 at 11:25:08AM -0700, Matt Evans wrote:
>> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
>> resource request and iomap for the BARs was performed early, and
>> vfio_pci_core_setup_barmap() now just checks those actions succeeded.
>>
>> There were two types of callers:
>>   - Those that need the iomap, because they'll access the BAR
>>   - Those that need the resource, because they'll map/export it
>>
>> This replaces vfio_pci_core_setup_barmap() with two helpers,
>> vfio_pci_core_check_barmap_valid() and vfio_pci_core_check_bar_rsrc(),
>> to make it clear which behaviour is required in each caller.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/nvgrace-gpu/main.c |  8 +++-----
>>   drivers/vfio/pci/vfio_pci_core.c    |  5 ++---
>>   drivers/vfio/pci/vfio_pci_rdwr.c    | 22 ++--------------------
>>   drivers/vfio/pci/virtio/legacy_io.c |  4 ++--
>>   include/linux/vfio_pci_core.h       | 23 ++++++++++++++++++++++-
>>   5 files changed, 31 insertions(+), 31 deletions(-)
>=20
> <...>
>=20
>> +/* Returns 0 if vdev->barmap[bar] can be accessed, otherwise errno */
>> +static inline int
>> +vfio_pci_core_check_barmap_valid(struct vfio_pci_core_device *vdev, int=
 bar)
>> +{
>> +	if (bar < 0 || bar >=3D PCI_STD_NUM_BARS)
>> +		return -EINVAL;
>> +	if (vdev->barmap[bar] =3D=3D 0)
>=20
> I understand this line was copied from an earlier implementation, but
> barmap[bar] is a pointer, and it is set to NULL when it is released.
>=20
>   if (!dev->barmap[bar])
>     return -ENOMEM;

Absolutely.  Fixed in upcoming v3, thank you,


Matt

>=20
> Thanks
>=20
>> +		return -ENOMEM;
>> +	return 0;
>> +}
>> +
>> +/* Returns 0 if BAR has a valid resource reserved for use, otherwise er=
rno */
>> +static inline int vfio_pci_core_check_bar_rsrc(struct vfio_pci_core_dev=
ice *vdev,
>> +					       int bar)
>> +{
>> +	if (bar < 0 || bar >=3D PCI_STD_NUM_BARS)
>> +		return -EINVAL;
>> +	if (!vdev->have_bar_resource[bar])
>> +		return -EBUSY;
>> +	return 0;
>> +}
>> +
>>   static inline bool is_aligned_for_order(struct vm_area_struct *vma,
>>   					unsigned long addr,
>>   					unsigned long pfn,
>> --=20
>> 2.47.3
>>

