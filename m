Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A32475C7
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832477; cv=pass; b=l+la9vQubd/Z+0x2MtRFdpbsgp7sgnZ+UtVXz8mVZXGdBmVwWK3FyZ7k5+uXMP2gnB9L12sU3XaugaSwjcwYXncziuguaCOZr+X81VHjY/KEpcxaglO97mXpx1AQQaMewXp3Ks70EfKy2ErciJ9xJxGalhuhLOZvnSRX/9iWdZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832477; c=relaxed/simple;
	bh=gG69vOS4owHfFEYrg95UN90rUdCbB5rpYm9q4EKd7Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JI4MNpiSBQ6QrahKYNKvsGlD+JlPhWHr8stIuPQ49GkePz6gGOBP8E9qCNTXaOZ7DMl2TCcWGOXHNfTnkaAe71bJrWYA8gyk09lllfSqewEz6gcbKISDjGc312cqAj9NxNlX9taCF64AQgd83Xh70O2/Dfe3rBozNzz+PXimiiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=e9rOttoZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="e9rOttoZ"
ARC-Seal: i=1; a=rsa-sha256; t=1761832466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FzYZntJKMkc6jsJ7bjZiUbB791tiHH/p29gqyqDFzb2NwrpXKYwukBnqKR2rsUkjNTTWdR4M2DSGlYzAxjPSkAnc74hRS5hil5LV5ZmgBcnPxAy/o65ONHMqXGnggbOGKxdQrIIZz6fGQADOTBPq0KwHT7v9usm5mSUO9xwW3LE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761832466; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YCCgzhf13qQVgC2HQHI9hDseJtU+Xb2EjrNgBTnf72Q=; 
	b=WhKOTXGT68qMNuLsuWd/u+jpf7XXM6r9CnNWAVhNZ8DnvB/RXCT9GQonOSLH4joB274WAj0C7PHR9R55UA/l+qGITT9ypCLLNhpuB/FjenI/eze4aiA3D4EynjhslT2DaV9ebySWyJqmP4lpcrvLCjieQg4YAKt+K8+XpY9bSy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761832466;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YCCgzhf13qQVgC2HQHI9hDseJtU+Xb2EjrNgBTnf72Q=;
	b=e9rOttoZnV98AsHZGbq8pwV8Pzs0/LkVkfbIzSZFf7hiu7Jzhu0WtEigKkGJ1F88
	NE0nO0soNMNYNHHldpWvjt4PJqLI5i0jevtlX+3n7OelSmsHpLUGT6BMcP9MhVgbNxf
	4RwVR14YIkWNpuKvY7L8frw4EENMgsvCoSuQmmUw=
Received: by mx.zohomail.com with SMTPS id 1761832463981354.8844547118065;
	Thu, 30 Oct 2025 06:54:23 -0700 (PDT)
Message-ID: <b54f8527-5ce3-449a-ac96-6b4686d1b108@collabora.com>
Date: Thu, 30 Oct 2025 16:54:20 +0300
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <IA0PR11MB718584C85B844B3ED6115858F8FAA@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/29/25 08:47, Kasireddy, Vivek wrote:
> I applied this patch and tested 3 different scenarios:
> 1) blob=true + imported buffers
> root@localhost:weston_upstream/weston# ./build/clients/weston-simple-egl -o &
> Using config: r8g8b8a0
> has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
> has EGL_EXT_surface_compression
> 245 frames in 5 seconds: 49.000000 fps
> 236 frames in 5 seconds: 47.200001 fps
> 279 frames in 5 seconds: 55.799999 fps
> 240 frames in 5 seconds: 48.000000 fps
> 244 frames in 5 seconds: 48.799999 fps
> 283 frames in 5 seconds: 56.599998 fps
> 274 frames in 5 seconds: 54.799999 fps
> 
> 2) blob=true
> root@localhost:/weston_upstream/weston# ./build/clients/weston-simple-egl -o &
> Using config: r8g8b8a0
> has EGL_EXT_buffer_age and EGL_EXT_swap_buffers_with_damage
> has EGL_EXT_surface_compression
> 167 frames in 5 seconds: 33.400002 fps
> 208 frames in 5 seconds: 41.599998 fps
> 203 frames in 5 seconds: 40.599998 fps
> 252 frames in 5 seconds: 50.400002 fps
> 180 frames in 5 seconds: 36.000000 fps
> 219 frames in 5 seconds: 43.799999 fps
> 176 frames in 5 seconds: 35.200001 fps
> 220 frames in 5 seconds: 44.000000 fps

Thanks for the testing.

For the second scenario I'm getting better result, it's 55-60fps for me.
Given that this is a SW rendering, curious whether that's because you're
testing on a lower end machine(?)

-- 
Best regards,
Dmitry
