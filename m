Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C41DF256
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402618; cv=pass; b=npuFJXBVdPsbxoaEPLOmdax3hQFfOlqy8J+idgvoRxRJj3swX11aKTY7olIEEHr0yG2nCpz139RLzpgA8/e2oI83AXpX95g/UhTos5nd09uFrHawq/zA5nV9lBpzx8TTdySULYzA2D11UQF5g94tswfxsxTKaHg3NI1JGVSQclI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402618; c=relaxed/simple;
	bh=Qq2HTZ++dYpSEPUT7vYKOMq8mR51XMcpFp12eoe4OZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdN/tCJKimCgPFBmt9jkMKOW2luxvl55lBzWg5rTXNqPmyMGkyce3QjrzM3lhc1o5ZBkMf3mt0Q387rwfRBgEm1uQ1DIGxzQx93Nm2XbURsMr/stzfltPbzRSNikZbVQ4+0zNX4oJl3qqsYcfVbzunPqNtA4f3uuHy8AVQAh0sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=GXxFU5zQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="GXxFU5zQ"
ARC-Seal: i=1; a=rsa-sha256; t=1760402608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WjHjZlvhZkaITqEV70+HSpwEG1Q91bhyL5SillaPb2Q13G08wYMhs0YN4MaYuazKRGOIRGbOXaxlWBsYPjKG3Uz6szMU9sYZaDlsZhMalojy/LlIM+tJmyddhNuoKcEWSzQG4Q5Q5bGAbXGQwZja5ebK4f+S0AaGX6r96/ADUCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760402608; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ISAPvcSlXdRjd+F19DIRyiYy/UHGa8vU8b6zDAQOYZI=; 
	b=SvXULzrzpVbKh1sQAmNTMEHNTuw+grVYEl+LodP5yJeTPzslJyEHM5/ZwVaNoH6vNIwXIWnd8k8BlxaE0k89QdbHrNxbVMoWQpPSlUrhx/cnR8GXDT8BbY0xQQjxS2J2ApUbiL460Dx3xuj2LlFGv8RoHN4cvhc+y4WJVTDvaNE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760402608;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ISAPvcSlXdRjd+F19DIRyiYy/UHGa8vU8b6zDAQOYZI=;
	b=GXxFU5zQ+u6BVu42A1aVJv7mbUxjbHb9utcwKL1SbgZnXMcnOynd2AQ8UefrBeMu
	N46qPrhf6WEB6Tjgiu6lypLqpWz2budwYIWUYvNd8YxJjy3rn7c/D1jHTy9faVyzNq+
	W0zcoobHgUgcR3QcJgmMhz6a5TvQLdAEdavLQa34=
Received: by mx.zohomail.com with SMTPS id 1760402605792634.3402182021023;
	Mon, 13 Oct 2025 17:43:25 -0700 (PDT)
Message-ID: <504fdb16-1157-42f8-bcee-ad2c45f1e71a@collabora.com>
Date: Tue, 14 Oct 2025 03:43:15 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtgpu: Use vblank timer
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20251008130701.246988-1-tzimmermann@suse.de>
 <IA0PR11MB7185D91EB0CD01FD63D21AA7F8EEA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <9aa83493-e036-4a89-825c-3ed95ab5ae30@collabora.com>
 <IA0PR11MB71857FBEBAD5404D13752092F8EFA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <IA0PR11MB71857FBEBAD5404D13752092F8EFA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/10/25 07:07, Kasireddy, Vivek wrote:
> Hi Dmitry,
> 
>> Subject: Re: [PATCH] drm/virtgpu: Use vblank timer
>>
>> On 10/9/25 06:23, Kasireddy, Vivek wrote:
>>> Hi Thomas,
>>>
>>>> Subject: [PATCH] drm/virtgpu: Use vblank timer
>>>>
>>>> Use a vblank timer to simulate the vblank interrupt. The DRM vblank
>>>> helpers provide an implementation on top of Linux' hrtimer. Virtgpu
>>>> enables and disables the timer as part of the CRTC. The atomic_flush
>>>> callback sets up the event. Like vblank interrupts, the vblank timer
>>>> fires at the rate of the display refresh.
>>>>
>>>> Most userspace limits its page flip rate according to the DRM vblank
>>>> event. Virtgpu's virtual hardware does not provide vblank interrupts, so
>>>> DRM sends each event ASAP. With the fast access times of virtual display
>>>> memory, the event rate is much higher than the display mode's refresh
>>>> rate; creating the next page flip almost immediately. This leads to
>>>> excessive CPU overhead from even small display updates, such as moving
>>>> the mouse pointer.
>>>>
>>>> This problem affects virtgpu and all other virtual displays. See [1] for
>>>> a discussion in the context of hypervdrm.
>>> When running Virtio-gpu with some of the UIs (gtk, spice, etc) in Qemu,
>> the
>>> Guest display updates are synchronized with a timer (or repaint callback
>> in
>>> the case of Gtk) the UI layer provides particularly when blob=true. In other
>>> words, the Guest's atomic commit does not complete until the Host
>> signals
>>> (via a fence) that the update (or flush) is done.
>>>
>>> This is because when blob=true, the Guest's FB is accessed by the Host
>> without
>>> making any copies. So, to avoid tearing, the Guest needs to be prevented
>> from
>>> accessing its FB until the Host is done. Therefore, I think for virtio-gpu, the
>> virtual
>>> vblank timer can only be helpful when blob=false as this is the only case
>> where
>>> Guest's display updates are unbounded (and Host makes a copy of the
>> Guest's FB).
>>>
>>> I am not sure how this would affect virgl use-cases but Dmitry can help
>> explain if
>>> the vblank timer would be useful there or not.
>>
>> The vblank timer should only limit framerate of virtio-gpu, I don't
>> expect it will cause new problems. Do you see tearing using this patch?
> AFAICS, having a vblank timer when blob=true would be redundant and
> will interfere with the synchronization mechanism because the Guest
> compositor would start a new repaint cycle without knowing if it OK to
> reuse the FB it had submitted previously. I have not yet tested this patch
> but I strongly believe it will cause tearing issues particularly when blob=true. 
> 
>>
>> Vblank timer makes a big performance improvement for virtio-gpu KMS,
>> especially for a native context on QEMU. No tearing spotted with it.
> This means that the only remaining case to be tested is blob=true and
> virgl=false. I'll try to test it soon and let you know.

Thanks, likely won't be a problem to disable the timer based on a
use-case with additional driver params if it will cause problems. Please
post your testing results here.

-- 
Best regards,
Dmitry
