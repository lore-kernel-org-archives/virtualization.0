Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFD4A5EC2
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791636632; cv=pass; b=DSJqbsShIN8FsuMvJMXARGx9nq5u6PHuEL7R5ZAE4vSYwlvK5rISMUh92v2j5WU1XOqTFa4A97+C54XDKkTe+laVk2egU8bQnlQpB76BLb7SgDB33e0ArUpN7jirAbyMFVFBiuix5H6/H6p0NUCqTTV5o6tf0VDbOLN/+QHUV9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791636632; c=relaxed/simple;
	bh=zP7F/Its1FNZOAqlzmlsspmgGnIYO3Bic6ctF6oSjvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W49phMMxbqPeV7gM+/vkcdciL4rbdoSZb5hHTIupUyfsrZPA8tebniuMHyXEHR3D14BhBjRbeomxRNME/I2cElCXG3vvNKLRR7Ro4byQrNRIc9k7mpBwGML50rg3wTAI6UoJ5ZOAdc6OX4jjo933qS9LbDw8MkmAP993EdpYNM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=SPKzYnuU; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="SPKzYnuU"
ARC-Seal: i=1; a=rsa-sha256; t=1791636624; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kb79XL3eSKL6NToXXg8/CkHKMaGjG3sOCBiAXR5SFK1DeFZzksVA7afFxMNqbVg+xsYfO6e0OTImRwlH8ukLW2zE3PpOKjV/eSe/VxvFKOd8VujbsqcDUE4wnyC1FJ1d9QXKdkClMGXsD3er+ix2VzPTISkfeYp07JQps4tZjVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791636624; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l83IEo3ISu2R02CLPLfemXne08wuHdJ38evmRsiKWwQ=; 
	b=Z+39C/Eppzs51SFNZnfUnegkBEhhuYZ7IbvbE5dmyrcBpenknv/8ehifL6EMMSx0QSnjRUpOVz/Jjlq+ZbsGp/i8aSZc53HvfIOu2POM9p6RA0rwvNWndIT/AvWxmz4MziQ9Wve7aRFO1ALHnKxZ5aSlQoPAM7/OyYL1BdJL+fM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791636624;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l83IEo3ISu2R02CLPLfemXne08wuHdJ38evmRsiKWwQ=;
	b=SPKzYnuU8ceh2WMllfPaacirzxOM+NzE9UQUud9RwWLzkOs3FJ6LdWGcbLD2sRoc
	hJ8vVyDrGE4sqEGm1+fU7EtK+a/NFN/Q3Tkuau4tz1Jes/eapIms8ZiFydg4afkwI22
	BjWIL239pE96miXkx8s4rXIQn5UgMeRdBS1AR2ys=
Received: by smtp.zohomail.com with SMTPS id 1791636622325778.3920049729552;
	Sat, 10 Oct 2026 05:50:22 -0700 (PDT)
Message-ID: <efd5fa89-e888-469a-ac80-e6e605f9a015@collabora.com>
Date: Sat, 10 Oct 2026 15:50:16 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: "Huang, Honglei" <honghuan@amd.com>
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <dfa2f117-1094-40b9-9445-ab2bbf62ff2e@collabora.com>
 <7c32c182-5b49-4dc0-9c97-a4238743f28c@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <7c32c182-5b49-4dc0-9c97-a4238743f28c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/10/26 10:37, Huang, Honglei wrote:
> 
> 
> On 10/10/2026 2:53 AM, Dmitry Osipenko wrote:
>> 24.09.2026 12:55, Honglei Huang пишет:
>>> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>>> +                  struct drm_file *file,
>>> +                  struct virtio_gpu_object_params *params,
>>> +                  struct virtio_gpu_object **bo_ptr)
>>> +{
>>> +    struct virtio_gpu_object_userptr *userptr;
>>> +    struct virtio_gpu_mem_entry *ents = NULL;
>>> +    struct sg_table *sgt;
>>> +    struct mm_struct *mm;
>>> +    unsigned long lock_limit;
>>> +    unsigned long start;
>>> +    unsigned long end;
>>> +    s64 new_pinned;
>>> +    unsigned int nents;
>>> +    int ret;
>>> +
>>> +    *bo_ptr = NULL;
>>> +
>>> +    if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
>>> +        params->userptr != (unsigned long)params->userptr)
>>> +        return -EINVAL;
>>> +
>>> +    start = params->userptr;
>>> +    if (!IS_ALIGNED(start, PAGE_SIZE) ||
>>> +        check_add_overflow(start, (unsigned long)params->size, &end))
>>> +        return -EINVAL;
>>
>> There is new vgdev->blob_alignment defining host page size as it may
>> differ from guest's page. Will be good to validate both.
>>
> 
> Will add blob_alignment check in next version, thanks for the review.
Missed that verify_blob() already should be validating the userptr
blob_alignment. The patches look good.

BTW, previously the extra AMD KFD patches were needed on host kernel,
did they land upstream?

-- 
Best regards,
Dmitry
