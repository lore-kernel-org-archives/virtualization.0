Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E791311C22
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429795; cv=pass; b=DClaGW+4TAdg7ur5UohGbClAknZMBFhZMFxqNHzTlzyAhjlkXt4V7dpStNc6Q5oOnEyx6NM2EVLrQ3o/RlAYQ4TbPzIe3wHUmCg3+E5exZEWzRCdvZ7MADPZR960g5hbYmEinIP/lEt+vWJd9yffVAaliPAa1WKP931px0hi4EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429795; c=relaxed/simple;
	bh=5Ser3stbkupy6/Z0RvQeh3Mtvz/fCwoEUTCb0jcAI9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhqZpePB22fQQ/MxspjlTQfHpsGMwH5lOf5aU6Ia5ZoPsWHdOWPq/tp20XM7yHryC9Ww8oAOKYOROVLKhR2yPY9ImQvNhntg8VbTrEmV1gh8lGUnehezGRJD50EwuYSErcy83Oc9GR5Am7/4fFPR6Bh0tyMNWlZRtDIfrTskbPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=IP4PK/Mu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="IP4PK/Mu"
ARC-Seal: i=1; a=rsa-sha256; t=1762429783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LBIlOkmAGSMaOASfKGCSwBszFbVVFXvpF+f5U0pzl6se0l7NneBjMmNNgNfzc7pI2JC3g+UwTcgP0G8s8kYs7QFGoceTlLFiWkovGIuWF7q7jCSUChf6RpS5PdUYZBatQKzg908tcBGAg+HvcYaPxy8RjVYJppqudFwVGvMN/Mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762429783; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YS0odAJlYs3nwthgsgETOFm3m1ktGy7FZRcxlQcQzqs=; 
	b=hmLB8wEBvdI9FuHYfRygO8lgJr8/qs+JcgNr2XtjVbZtIPCJ1VLe7qEBCf6X8XBOMZCaBuaE70RtXrrws7Kg7hjodajKyP/pRSz3kPG4jyYDSR/2DhsOFKvybDuuoysaBIzbGH3CdMJBHisHjrfh6ClFK1OV/fsM/Pn5QVIzaOk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762429783;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YS0odAJlYs3nwthgsgETOFm3m1ktGy7FZRcxlQcQzqs=;
	b=IP4PK/Muzid9wFqHcFkpJ68fg/yz1+l1H6oiI7hLZ3xCH+r8jquLTaYVYruaeqVr
	1XUjwxi/QRP/Q209SBJ1wozn3rXSCdZi0j858QEc74dot2GywqwDL+TEKKC9JKQGwlm
	nLVhg9EXW1SSizyzgBMYR3/CZ5fy53b1FXWY9dH8=
Received: by mx.zohomail.com with SMTPS id 1762429780339211.15393394280704;
	Thu, 6 Nov 2025 03:49:40 -0800 (PST)
Message-ID: <f99e94e2-2357-4645-8d6e-2d234d7d2e12@collabora.com>
Date: Thu, 6 Nov 2025 14:49:35 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/virtgpu: Make vblank event dependent on the
 external sync
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <20251027095550.110562-1-tzimmermann@suse.de>
 <1e4a29e7-bf98-4193-962a-66fd251e2c72@collabora.com>
 <IA0PR11MB718584C85B844B3ED6115858F8FAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <b54f8527-5ce3-449a-ac96-6b4686d1b108@collabora.com>
 <CH3PR11MB7177B04D32239354CD6A609EF8F8A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CH3PR11MB7177B04D32239354CD6A609EF8F8A@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/31/25 08:04, Kasireddy, Vivek wrote:
> Hi Dmitry,
> 
>> Subject: Re: [PATCH v4] drm/virtgpu: Make vblank event dependent on the
>> external sync
>>
>> On 10/29/25 08:47, Kasireddy, Vivek wrote:
>>> I applied this patch and tested 3 different scenarios:
>>> 1) blob=true + imported buffers
>>> root@localhost:weston_upstream/weston# ./build/clients/weston-simple-
>> egl -o &
>>> Using config: r8g8b8a0
>>> has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
>>> has EGL_EXT_surface_compression
>>> 245 frames in 5 seconds: 49.000000 fps
>>> 236 frames in 5 seconds: 47.200001 fps
>>> 279 frames in 5 seconds: 55.799999 fps
>>> 240 frames in 5 seconds: 48.000000 fps
>>> 244 frames in 5 seconds: 48.799999 fps
>>> 283 frames in 5 seconds: 56.599998 fps
>>> 274 frames in 5 seconds: 54.799999 fps
>>>
>>> 2) blob=true
>>> root@localhost:/weston_upstream/weston# ./build/clients/weston-simple-
>> egl -o &
>>> Using config: r8g8b8a0
>>> has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
>>> has EGL_EXT_surface_compression
>>> 167 frames in 5 seconds: 33.400002 fps
>>> 208 frames in 5 seconds: 41.599998 fps
>>> 203 frames in 5 seconds: 40.599998 fps
>>> 252 frames in 5 seconds: 50.400002 fps
>>> 180 frames in 5 seconds: 36.000000 fps
>>> 219 frames in 5 seconds: 43.799999 fps
>>> 176 frames in 5 seconds: 35.200001 fps
>>> 220 frames in 5 seconds: 44.000000 fps
>>
>> Thanks for the testing.
>>
>> For the second scenario I'm getting better result, it's 55-60fps for me.
>> Given that this is a SW rendering, curious whether that's because you're
>> testing on a lower end machine(?)
> I am testing with a dGPU (B60) on the Host where I am running Gnome Xorg
> but I am running Gnome Wayland in the Guest. What compositors are you
> running on the Host and Guest? Kwin? Also, could you please share your
> Qemu launch parameters as well so that we can try to figure out the reason
> for the performance discrepancy?

Did further testing on older IvyBridge machine and getting comparable
result to yours on it.

I'm using exactly same QEMU setup as you do with nothing special in the
cmdline. Tested with both KDE and Gnome on host.

On IvyBridge getting:

- 46-55fps jittery with GTK display + blob + vblank_timer
- 46-55fps jittery with GTK display + blob + vblank_timer +
vblank_mode=1 to disable vsync on host
- constant 60fps with GTK display without blob + vblank_timer
- constant 60fps with GTK display + blob without vblank_timer
- constant 60fps with SDL display + blob + vblank_timer

So, discrepancy of the results is directly tied to CPU performance + GTK
oddity when SW+blob rendering is used on guest.

Why SDL performs much better than GTK I don't know.

-- 
Best regards,
Dmitry
