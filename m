Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FE146584
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115761; cv=pass; b=CUbjNTGNKGa5cvsQMmWuJUprQzSvcwvRUtSnKnssqzM86JNF8+Ahw9STHbTdo/RYAkCCP+6q/NcWbZEUKmWutpCUkO6Lb/7HcTatT0lS1ugWwqQHx+prVChylonDt2+ON7wBpSMUh1wkW+9Y02EV6MjPatdF4amecXaYK/k0Who=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115761; c=relaxed/simple;
	bh=UVR2SrPn7TfiyI2n+o13LgTQHFTc9rIQLreQ/h9YWr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0b+jotlBImXFcjy5NcAmSIdUDxJo39EM4Onlyn3C/340I9WmzMAhQiF4gZL4G3f/2Ky+kUHrxZSf5Qd9AVVvhWtX4z8xzNjDGAUQ/C+EcHaUMzBYq2H0+ytR7yqnkEMHwydFLPH5I7oKvBMROpBM+JCYAoeBkLlc1aheVeRQrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Sc/xyviu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Sc/xyviu"
ARC-Seal: i=1; a=rsa-sha256; t=1723115751; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NmoWDyJHJvOIY3I9aFGH4B4qHLIdTkCYMAC0kf2ZbaPDJmyvEmtp7uXUneWPjKblrBu4zQ5wgb1HXnX/W8ZbTLEyjFfDVKHaRifGNnMWpzLmrorBRTixf+GsdhM488ffNUhIMAAbQDYUvbviIBh435Lpt0abRcDDywpEtm2XyLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723115751; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r6rU7KtJozi23kp1co+hrLn3/E9giDDQH5pgqpu/Kbk=; 
	b=JjMyn9cc0sqhwUMzRIB9d+iuSO+8OvqM+7uDdDKW89kMWgQ3GDjpmSPNuV1tS1Xcm2LH2re+gmGYcwJV3JvCWEcvXAsLNc0X+ttaGbnfYGqCdDZPrAM8wla1vz8OeAI6YxMAbaBOPHOs1bn9s0/trYvoXeqIxDal7cp2+tWwxGM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723115751;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=r6rU7KtJozi23kp1co+hrLn3/E9giDDQH5pgqpu/Kbk=;
	b=Sc/xyviub8Rihuny+btlNpBFekCiHMcZwhM3MuRYZVYvSIfUvpl7hvkDnpdiNzvP
	6aSo9Leg/D61BS75VTiGdm7hdMEyLrxBljJf5oIPiP2lzWz1ZAy5//EeulQU1FSY6wR
	gh8KiPiwKDAbh+E5Zy7W8vjtGcewgkEr9JqKsSq0=
Received: by mx.zohomail.com with SMTPS id 1723115749738452.2823392389888;
	Thu, 8 Aug 2024 04:15:49 -0700 (PDT)
Message-ID: <46a5ec89-be9b-4342-820d-019b595fa379@collabora.com>
Date: Thu, 8 Aug 2024 14:15:45 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Rob Clark <robdclark@gmail.com>
Cc: Sergio Lopez <slp@redhat.com>, gurchetansingh@chromium.org,
 tzimmermann@suse.de, mripard@kernel.org, olvaffe@gmail.com,
 kraxel@redhat.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 airlied@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20240723114914.53677-1-slp@redhat.com>
 <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
 <CAF6AEGvwrYiN6nMSsRAdc3qq+qQGWEvdW_3+xJh6y2iAyW6rkw@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGvwrYiN6nMSsRAdc3qq+qQGWEvdW_3+xJh6y2iAyW6rkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/5/24 19:24, Rob Clark wrote:
> On Wed, Jul 24, 2024 at 12:00 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 7/23/24 14:49, Sergio Lopez wrote:
>>> There's an incresing number of machines supporting multiple page sizes
>>> and on these machines the host and a guest can be running, each one,
>>> with a different page size.
>>>
>>> For what pertains to virtio-gpu, this is not a problem if the page size
>>> of the guest happens to be bigger or equal than the host, but will
>>> potentially lead to failures in memory allocations and/or mappings
>>> otherwise.
>>
>> Please describe concrete problem you're trying to solve. Guest memory
>> allocation consists of guest pages, I don't see how knowledge of host
>> page size helps anything in userspace.
>>
>> I suspect you want this for host blobs, but then it should be
>> virtio_gpu_vram_create() that should use max(host_page_sz,
>> guest_page_size), AFAICT. It's kernel who is responsible for memory
>> management, userspace can't be trusted for doing that.
> 
> fwiw virtgpu native context would require this as well, mesa would
> need to know the host page size to correctly align GPU VA allocations
> (which must be a multiple of the host page size).
> 
> So a-b for adding this and exposing it to userspace.

In general, GPU page size has no connection to the CPU page size. It
happens that MSM driver uses same page size for both GPU and CPU. Likely
you could configure a different GPU page size if you wanted. dGPUs would
often use 64k pages.

-- 
Best regards,
Dmitry

