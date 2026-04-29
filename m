Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CB374728
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457726; cv=none; b=dLWTSfHHfYaAUjTf2YWvPi0eOqBQGEXeNBrtpnj6FAlpjIy//0ayynkLL1PdQjJaxkzk9dXyDFrx8ZnGWDAYt2alHQ+Ky0Ah5XMT2oQ1Tl9CaS1k78eVPxu7YIR7nTkqtv22YjuDha7rBXkgidr8OymfdC7ConhPKhh7cfMpfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457726; c=relaxed/simple;
	bh=hQug3qkwF07/UwbNYXE2gQIGd7kBMCi2EgqyXQ+NWKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5+AUHFHqj81X9WDx2lJbR4lFe4eIrfgghkFhoyFTDkbXhADzaxmiDNXtR8Z3tKIgaC4VA2RCfskYBNtmrXvh5mg9n8WVl3cflNLXwKRAeoVgfUbalxrZ8AnGp0ZBB3PP0xqvGoRcQG+1CoFtnu3n7u4YmPhRmoFuX/PPFO5ysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kX0/Nff3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kX0/Nff3"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SIjArW2519527
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 03:15:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ly8JAFvIw75h5tYXkVpwyGwZpL0+gkqQbMxNXD6jLUY=; b=kX0/Nff3iVch
	xvLKyaXFI4CdPx/BZom54wnHCQLL56keHS+vRQXeJnb8NRRAjyb2tk19UKjkRg/K
	eFu8yrKmg3nux7wJkEGSXyHlsyziMeYkgyfLc2eX4eYCNxTq6uoONVU2iIN8GU8/
	hIv9Y+iVJooSxr/jlAiuPz9SckHVNeIyeU8QkRO3FPTrJIsVF4b5hr43EeQZYwCU
	mwVSVhGgjWeD1desHOxSWbybytc3WEvUh3x2KGoS/PVuCtMxE6O4RqsQupBZbV//
	nV+Mt5gcDtVfXJaL5Njl6xr5nCMpDvPdOYGWPQZUCrgiK9eTA6b2KbLY4mvogRxW
	Y/wp9O8qjg==
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dsf8hnmpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 03:15:23 -0700 (PDT)
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so135264405e9.3
        for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 03:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457722; x=1778062522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ly8JAFvIw75h5tYXkVpwyGwZpL0+gkqQbMxNXD6jLUY=;
        b=YrQft4b1X4M3wCXumN7osbKjwKV3QAn8yH3uh14T4BMETpuVXFxJwkuBkAda7NTLtG
         mUYJHGqqiLGkv6U2lg7y8pTndVnJ8F9NuxN0OjlvpH+ysD8QDT0fFtZuxfHMQDk1uMdX
         0jeac1E1K8y5yhKyGs9HkJOG9rlWhUD5ojq+JXFdrkPu2sLvzl4yDMYBWmoybnQZk+zv
         sHgWWEljnk3u4eZKIlPAlpM7453cLNJ89+dFPISUkwubr/2j88iXiq6juMHqwFpj2ZAn
         hd4RnnZaiOnE4nyBxVxiXkvLa3D6ewKF2cnr208626maMubjaHLuV05ZXgJDU5XdCWip
         B23w==
X-Forwarded-Encrypted: i=1; AFNElJ/x7gnxEdplUw+kimqxCIIe4IckvrwcNTBBSvtAcTvaw7xQ+3L5ao1czalstRchcP8sujxkn6JABU+HDK0EvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJwyCWAp+eWRxRqi0R488s6x55Zvgq8oRxZOg6CsPZDeZ3HnIY
	djiessCri36flOEL/EOGpLATeCRv1MdiHybiVccYcAoEe/DbAWgUohDW/gfkpY7UfRnDRQddk/b
	RbbMEOudXYiMh7yYk5yNrkvDm16ZjjJ3uumCRUeGdZ2O01Sy+NqTZMTM11/9pjCT2wRs=
X-Gm-Gg: AeBDiet09LgaXBXGQSVRrwBk6yKsZDWK2xBgXvNylpwyvIj1Ko8x/Mzjgt25ukRIr2b
	T9Gzk1wVCwvyYUgTFOTRXhhFpzjers2/URfg+29MYi2Zv8RnoiXnwekprz+BzlN64aXE9trUN0u
	/eLxV01T1y8Jryxhenq/EzZh58AxugDzmkxX0YM+5CYDv50ARUa4LNZOnVJXtyG2ddkDuLb+Yu6
	8y9yF4vkqboDL/BJGh0/C65JRn/Kk8+AG3kIpUAZX6q9sepH0hRUq9X0Fz1uXEkV/ILwKxZ1Lz8
	grB4K2ceKAo9sqlN24cCGvfOKPTaxMrty8v+oHiwHnUX37Ji7Ektx0rMd8LLj2nk+q45UOSYKT1
	5IYDtqNyQiTCP+k9WK/5F327qwkQ8F5WAaMXTe18qAldTqYexzbdDHtTCx6ON8wr5FzFo+K5cFw
	==
X-Received: by 2002:a05:600c:3e19:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a77b12a61mr119916265e9.14.1777457722326;
        Wed, 29 Apr 2026 03:15:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3e19:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a77b12a61mr119914095e9.14.1777457721719;
        Wed, 29 Apr 2026 03:15:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:18:b9f9:127f:ecc1? ([2620:10d:c092:500::4:fbdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca5fe6sm5126538f8f.32.2026.04.29.03.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:15:20 -0700 (PDT)
Message-ID: <bac93215-c781-42ef-b5e4-3d5d71dc5503@meta.com>
Date: Wed, 29 Apr 2026 11:15:17 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] vfio/pci: Set up bar resources and maps in
 vfio_pci_core_enable()
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-2-mattev@meta.com>
 <20260423153053.6833135e@shazbot.org>
 <729d6593-f88b-42bf-b3a0-8c364d9ca5b4@meta.com>
 <20260424112007.592fd6c0@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424112007.592fd6c0@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9PylleFZy0IqofaBaY44h0y8pDiilnxm
X-Proofpoint-GUID: 9PylleFZy0IqofaBaY44h0y8pDiilnxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwMyBTYWx0ZWRfXxzf2vmBY9pL3
 hsisVfVuPQXut41183pC0V+JUN0vQR6RfmebEzzryrV8psBvJYYH0HpuLKkHe/sRqEzS02YRbBQ
 OiVNp0RyTi0kNzdDcZflaL4KWj8HaM1oyvgR/hZB7BhFCQrtiRFNuuU5HdNNt3/DoYZ0/c+nEUr
 UGGpEaNAxuaTpbnvj+b7jcqB6jNu1OJSIu7h/VKwrg+W38P7nqR7VR3ny2WFL60ysD7zGLW2H+w
 TbGHmTD3N94to6TfxPVVF10dFn4XNlCfJAonZ8er/TYtmQBWBN8DO58d0gI32C2nyHAfDKdjV0U
 x3PscZ/YFwQRRIwhkJeLPfREIEaF8gPRXi+U2WEzh/gG3VMJjEKqtlGfox8JFO6DY1OgenBRyLl
 816MXg5zbT3R5ziFO7oSHs7hTNn3e5ZieXyu/T8lmeihBOqNtIaI3I6VZ8uNVWXU41IOuLHa/t5
 +fbT8Oe/O6vPz4EtbRQ==
X-Authority-Analysis: v=2.4 cv=EPQ2FVZC c=1 sm=1 tr=0 ts=69f1da3b cx=c_pps
 a=Q4jRaax7EcWM5fECTC1wcQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=OKIG4whRnQEbbrv9YZ8A:9
 a=QEXdDO2ut3YA:10 a=nJq5_VNI1X7IEIKzvdHs:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01

Hi Alex,

On 24/04/2026 18:20, Alex Williamson wrote:
> 
> On Fri, 24 Apr 2026 16:15:06 +0100
> Matt Evans <mattev@meta.com> wrote:
>> On 23/04/2026 22:30, Alex Williamson wrote:
>>> On Thu, 23 Apr 2026 11:25:07 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>> +
>>>> +		if (pci_resource_len(pdev, i) == 0)
>>>> +			continue;
>>>> +
>>>> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>>>> +		if (ret) {
>>>> +			pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
>>>> +			continue;
>>>> +		}
>>>> +		vdev->have_bar_resource[bar] = true;
>>>> +
>>>> +		io = pci_iomap(pdev, bar, 0);
>>>> +		if (io)
>>>> +			vdev->barmap[bar] = io;
>>>> +		else
>>>> +			pci_warn(vdev->pdev, "Failed to iomap region %d\n", bar);
>>>> +	}
>>>> +}
>>>
>>> I see you making the point in the cover letter about the resource
>>> request vs the iomap resource, but we currently handle these together.
>>> If either fails, setup barmap fails and the path returns error.  I
>>> don't see any justification for now allowing the request resource to
>>> succeed but the iomap fails.
>>
>> The primary effect was to let consumers see -EBUSY for a resource
>> reservation failure or -ENOMEM for an iomap failure (whether through
>> this patch's vfio_pci_core_setup_barmap() or the next patch's helpers),
>> and that keeps the error signatures identical.
>>
>> A weak secondary effect was that a BAR that gets resource but fails for
>> whatever reason to iomap it can still be used by most clients (assuming
>> the general usage is to mmap).  The system's pretty sick if this is the
>> case, so as I say it's weak.
> 
> Right, I don't see that's really a necessary add at this point.  In
> fact while we expect users to access through the mmap when available,
> we don't actually have a way to specify that mmap works w/o read/write,
> which is effectively what this proposes is a valid state.
> 
>>
>> OK, if you prefer the combined approach and don't feel the subsequent
>> single-semantic check helpers (need mapping, need resource) are clearer
>> to read then I'll recombine them, though:
>>
>>    - If vfio_pci_core_map_bars() just sets barmap[n] iff both resource
>> acquisition and iomap succeed, then a later check can only return one
>> error from either cause.  I'll go with -ENOMEM unless you prefer -EBUSY.
>>    Using something else can again make userspace see previously-unseen
>> error values.
>>
>>    - IMHO vfio_pci_core_setup_barmap() should still be renamed (in a 2nd
>> patch) since it doesn't do any setting up anymore.  Cosmetic, but
>> cleaner to parse when the callers use vfio_pci_core_check_barmap_valid() no?
> 
> I'm not sure how important it is to preserve the identical errno, but
> we can actually do that too.  Make the enable time "setup" function
> store the ERR_PTR in the barmap and change the current callers from
> "setup" to "get-iomap", where get-iomap is a __must_check return that
> callers test against IS_ERR_OR_NULL().

I like that!  (My mental model of ERR_PTR was one of function return 
values and must admit it didn't occur to me to stash one longer-term in 
barmap.)

> Or maybe better, collapse NULL into -ENODEV so callers only test
> IS_ERR().
> 
> There's even one user in vfio_pci_bar_rw() where this provides a minor
> simplification.  Likely the others are just wrapping the get-iomap call
> in the ERR/NULL test to get the equivalent behavior.  Thoughts?  Thanks,

Just implemented a vfio_pci_core_get_iomap() and I think it's a lot 
nicer.  I also prefer the helper returning the BAR map pointer rather 
than the open-coded vdev->barmap[]s.  I've moved the helper [back] to a 
header, since the additional index checks will then fold out at compile 
time in some cases.

Thanks much for the suggestion, posting a v3 shortly.


Matt
