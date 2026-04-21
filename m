Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273F2D97B8
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793604; cv=none; b=RKDAvevwX3bs1q4vV3ZD8ZrVRJ7PmF7SphvWEqyuSFibdMXARjRmbQIoNvPzRLDzGzKy+TR6PM/T33bQM3QFn4aFzP+mQ+YWsFy0st52yv5oF5h9NJIYOxUAmJcTNGNqBpXj7cbmn3CNzYELkrOTv+rOv7pa0bV6As+s9kbt4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793604; c=relaxed/simple;
	bh=8vGdUImmVndSByYxSgCmRaPsbh+IZA/1RgMErXMR+l0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bs8xA0OZjhvT/Nva/ssdxzMOSjioBqUAIXI0cy54T6liVvWHX2EaaPm3qEvf6aZLH/3l4u5Sd1n8PP4SHrQNFBYNwLqarvqbweyhxTVoJaCbMEDCljmk42CwLem0Dz+RhDXU0PYDeWBIraOZ5m33XclSBuKKISzGbhsmnoIt73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GmPfULKj; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GmPfULKj"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KL2eKf3289781
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 10:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zp70A21mqS9OtIIFTeWLYnfSrJjIB0JKsjmb1qYZRO4=; b=GmPfULKjUvwt
	PY56+BlSmwG67QGE+ZkNqZy4a0MhnMPTHDGfXKb+7o7rle/OGnvbS8eYQrQTQCRB
	br4F2TKCzChLfZDWENXQl7DoYI5SQwq+OXUcWT8t4h3C7Mj5c1r52KmY19Bn8DNx
	I1GfZSO8LoZOtexFq8VPachCbnMwxol2xbr/57g1ycVdxTxQEurevOiYFQRWV7k3
	iYVUd4pqivyq8iug7ZLAGy6xHXX+8W8Lo5BIBCTgnn1WD6/1H3ihC8wzBBuKlkE8
	Rfe4/XKeFXTtYw+fbmtYEwo4u2XwGp/ND329n+i14lEau5pIaJuie8gVQPboNhmL
	tC2xfkMlYQ==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm7251x69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 10:46:42 -0700 (PDT)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso37723295e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 10:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793601; x=1777398401;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp70A21mqS9OtIIFTeWLYnfSrJjIB0JKsjmb1qYZRO4=;
        b=mUP1Z71IGNt5o7IKoQy9SBKR3qetPLF4oj3RTZW5NjD/2CLy8OH8IMTwi/Ndo+UjTV
         xyAoBJZcQWqS3qno4tt1wI3i3K+sEjvPYD6sBIbEVSDJRVLCMDgImEJXu7c23tY3hkEC
         mnQfEYeN9RhYGMBywGyUyPh5Ehle1M6x5buMe+oqkkjjT2RELc6Up8GCWf/r6m0vnrgI
         DXqKfDt1lcRAn6+Wt7DBGDzJKakeMXXgPFpJmrtayv1Fo8xzCZKOT7zdwPpbTu7++kmW
         Jq6d1p3LdHzPTP0niWUSDSV01SQxiSKg+HkcylzBPXefg9kVXcHPX3tQtPAJcFPIOlLG
         SVFg==
X-Forwarded-Encrypted: i=1; AFNElJ8IDuxM+PNuV1SREj6tNdjV6Gp8bzIAlfcUC/+PsW0ybgBLlGnlZpZqtPzi06vTW/Jc5Yd8i4OsQzq+qpuxLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgMbisfQC9CYoWXRUC41+tP4UZQBzG0oJphq8pYAtUD1OmnWQA
	o9JLNVGBbPMybrMHH4EX96N9Q2h8S+jfImI16Imu99xccUogdw9UpWUb3pOTm8HyTVvu/6asl24
	IA6ooew1+H22romKqFCY7i6hLbT4cam4C5NPOUCEXgKxRPEL865rKdeX1D9klj29WdwU=
X-Gm-Gg: AeBDieu+WD9CtdrnrtFdi1sDqxW87h4s/41zxBHUFEvWjtD/caMXFY9Te6lDFGDiZVO
	dry309W4VQBqmIQKRoarZXr0f5xUjQoBiyOhL7Asg+gsokOXJ5gs4/OTn9d2cnQ+jgjziMb6q5X
	b7oEkcT9NKeOBW6fqGK6dOP8XODrQm46I0EIqs5gQ5+dGlLVRTUdvWSvOFPIu1ILWLGJqnn3MDk
	dlgUt1B5Bo5CG0cgusutWVNMnvm9x/yVZbll+B2OtnWmpnIooYSp2pY3D9gmgJXcDQD/PtWWIIF
	waoh0em4F+Zmhfl9637YdeoshEScWttCYkcDwqUMORuZgVrrh5V0NmRiWIJcakm8PYxJbXH5kFH
	FxR0KzSve9xQNLIxJCtQJ24uF7oZ5u8cwibqWYki6OWdBZcMuMs+DmEds+uLFbds1g0EMzm5hcJ
	VavuqfCMQt5+EVPeylyQvnq+EThnsZt7zdSFCLdPn7DFbTdnKR26MCy4K6XWA11TKOAjUtcZw5M
	D5HD5Rw4LrPf0OzmWjBWr2zfx0mXuQ4ew==
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr279278575e9.21.1776793601165;
        Tue, 21 Apr 2026 10:46:41 -0700 (PDT)
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr279278265e9.21.1776793600637;
        Tue, 21 Apr 2026 10:46:40 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf7besm135201705e9.34.2026.04.21.10.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:46:40 -0700 (PDT)
Message-ID: <e44ba83a-bbfb-4c80-aaee-ab16026c666b@meta.com>
Date: Tue, 21 Apr 2026 18:46:38 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a DMABUF
Content-Language: en-GB
From: Matt Evans <mattev@meta.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>
Cc: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum
 <skolothumtho@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
        Kees Cook <kees@kernel.org>, Zhi Wang <zhiw@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <20260415181423.1008458-1-mattev@meta.com>
 <20260416164406.7fb3bb0b@shazbot.org>
 <BN9PR11MB52768421EA5D79C469B899C18C202@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3fd01aa0-955d-44e3-aa4a-1918f9c42bb0@meta.com>
In-Reply-To: <3fd01aa0-955d-44e3-aa4a-1918f9c42bb0@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iVSfFo1UtsHgpgOW8pTf9xgfzX-qOWWD
X-Authority-Analysis: v=2.4 cv=HLnz0Itv c=1 sm=1 tr=0 ts=69e7b802 cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8
 a=ydsvmwYgiboQMSsmNQ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Ng9YvVcppn9CIdWre3nD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NiBTYWx0ZWRfX6VT6Ync9UEMH
 QWO3mMYrQAOoQ/IRQ8Wpzt8sLP1i9KVu47xxjyZ7uI05OY1JeLkZjge0nt6AjtYikfZi0oBEOd9
 IUgBsYXb120N82NmBk13MNEzXx2MU60UMDgmobwItSqEUOkv4wQUwnBKnU2nWMLYNF5Jmq8zEuj
 6rpsWcuxuxLbfVRpI0I+/2R6VU+7UcDtx89l8bzgIwPthLC2zokiZZXYIbYGW08mWJ8V0pAGMp5
 bVJt8dmXCtgF1wmpmNfh/s5IOEaJAhmd4n8hNzLfj8YDuVwj2zx5P1b0idCdfeSj0T0I4V/lC1A
 muUSuhlHsfSA3nfw8e5QnDkVU4U4igwVdDs93klCCR7mdFQSv1hTr9BD5L8/adD4CZzyZ3qnvMV
 oNrho+19TTkWtk6z+glGJmBz5ai9YgO9hyK/mjbUFenb0YAXErhXfEazBvPe1uzgu+REDBWFBxz
 gCO/NN7O/2oa5yLMkUw==
X-Proofpoint-GUID: iVSfFo1UtsHgpgOW8pTf9xgfzX-qOWWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Hi,

On 17/04/2026 20:11, Matt Evans wrote:
> Hi Kevin, Alex,
> 
> On 17/04/2026 06:16, Tian, Kevin wrote:
>>
>>> From: Alex Williamson <alex@shazbot.org>
>>> Sent: Friday, April 17, 2026 6:44 AM
>>>
>>> On Wed, 15 Apr 2026 11:14:22 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>
>>>> A DMABUF exports access to BAR resources which need to be requested
>>>> before the DMABUF is handed out.  Usually the resources are requested
>>>> when setting up the barmap when the VFIO device fd is mmap()ed, but
>>>> there's no guarantee that's done before a DMABUF is created.
>>>>
>>>> Set up the barmap (and so request resources) in the DMABUF-creation
>>>> path.
>>>>
>>>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO
>>> regions")
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> index 4ccaf3531e02..fefe7cf4256b 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> @@ -272,6 +272,15 @@ int vfio_pci_core_feature_dma_buf(struct
>>> vfio_pci_core_device *vdev, u32 flags,
>>>>           goto err_free_priv;
>>>>       }
>>>>
>>>> +    /*
>>>> +     * See comment in vfio_pci_core_mmap(); ensure PCI regions
>>>> +     * were requested before returning DMABUFs that reference
>>>> +     * them.  Barmap setup does this:
>>>> +     */
>>>> +    ret = vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
>>>> +    if (ret)
>>>> +        goto err_free_phys;
>>>> +
>>>>       priv->vdev = vdev;
>>>>       priv->nr_ranges = get_dma_buf.nr_ranges;
>>>>       priv->size = length;
>>>
>>> Wouldn't this get a lot easier if we just setup all the barmaps in
>>> vfio_pci_core_enable(), conditional on pci_resource_len() just like we
>>> use to filter in REGION_INFO?
>>>
>>> I don't recall if there's some reason we've avoid this so far, maybe
>>> others can shout it out if they do.
>>
>> I don't remember too. probably just because it's not a wide requirement
>> then was made in this on-demand approach...
>>
>>>
>>> We already tear them all down in vfio_pci_core_disable().  It would be
>>> a small patch to add that, which we would mark as Fixes:, then a small
>>> follow-up on top of that that removes any then redundant or unnecessary
>>> callers (all of them).  Thoughts?  Thanks,
>>>
>>
>> Agree. then the next patch fixing the racing conditions is also not 
>> required.
> 
> Oh, if we can do it earlier it's all much cleaner, agreed.  I'd naively 
> thought there was a reason it was done lazily.  One benefit is truly 
> huge TB-scale BARs don't get ioremap()ed until actually used by 
> userspace.  I can't think of a good usage example that relies on open 
> performance.
> 
> If you say fine, then great:  Ignore these, and I'll post a new pair of 
> patches doing that (...with a cover letter this time).

New series posted:

https://lore.kernel.org/kvm/20260421174143.3883579-1-mattev@meta.com/

(Titles/semantics very different, so didn't send as a v2 of this.)


Matt
