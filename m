Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C637B40E
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171090; cv=pass; b=bXP8rh9HSBhKugvIG+jUhnBMlXBINoSNKL0e27uBo4ampsG8xaso4eOqQwR3DSwWTwdUlCFYkwGQ5tU3sCFf0lTqiM7XVgNfO+3xFe+FeX0dGKhfxarpTYcUEYZ7LOQfxScdXua3T0yUn7/7uOb9KQ5gveAQxwfL/PBuPToXrIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171090; c=relaxed/simple;
	bh=cyA63C0QdAt60tI4HZLm1qliC3315mlZspaNYx/Pi2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b403bftpgQUUntzXXpA+AYPap8/dXAx2T/KiS7SH3qaWuVXfrsPrzy05Eqaue++FWVNCpBggXjFGb3b4Ba/p8RPTD4in5Tr9lLcgwDuQxeyAwBcAuyF3Y2LG07ilAJBP7UWdaeYddu4ES2IlkOWZohSWwb6FQwk3O8HyN50c4iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=gjF6uBQ5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="gjF6uBQ5"
ARC-Seal: i=1; a=rsa-sha256; t=1779171079; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SilEMS0pdTChLtGm7/kRxHg5VGzxyEUktILVSvGs+rNaU1BHYf9uaJ3Cjtkx3bd7VBiOXAApk1bXjmCL3qg24/SceIUbmbEbBrRoJB/G2GCkN6uHoOdyTqbJ5ezx/B2vp86FmYomIMmbPbC3/jZnxrbvLP91aRd4NrGgHKsA1tE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779171079; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Udy+Yfd+IRC01uknwv1MHH0Qn+eI2NgC+/yldasEmO8=; 
	b=A2l9lv7Rljm4UBzzHHPXssaEggNNVLzT0inULM4nFC0VhFC0Vlj+KOPLnYWPRFGRlLAXJ6hrunMLaGPYxiczHvfjCHXOz4tXjw2CmIKmYnDGZQjUtQYzwvzD7J1uH6I8AdU3wv6F7dQJuc8g1jTd2Ouj8RBn2T0G0zTLyq1bnWY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779171079;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Udy+Yfd+IRC01uknwv1MHH0Qn+eI2NgC+/yldasEmO8=;
	b=gjF6uBQ5XJqxvMEGOsgd7jWjWKtnzv57x1vQd8Iz9GSlKB9XXQgKUBM0d9ZLhOw3
	QKiSMS3+j1yQs6LNYLuPkp8RdQp8P012A3PJslSl2vx9ZDKdZ0CynN4QEbhdY7IweDF
	2KyD2ueVwDD0z5sy5eAmD/xKUqVhRDoNa0z8B1Lc=
Received: by mx.zohomail.com with SMTPS id 1779171077316643.3782271148908;
	Mon, 18 May 2026 23:11:17 -0700 (PDT)
Message-ID: <70e966d1-ca74-4f5c-8527-9e34ffe19095@collabora.com>
Date: Tue, 19 May 2026 09:11:11 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <18b095f06dafb7a0.57d57ad28d13539f.2240916b4a5459e2@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <18b095f06dafb7a0.57d57ad28d13539f.2240916b4a5459e2@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/18/26 09:45, Ryosuke Yasuoka wrote:
>> It may be acceptable to have wait_event_timeout() in a loop, printing
>> warnings about unresponsive host.
> I considered this approach, but it does not solve the recovery problem
> described above. The guest would still be stuck in the loop with no way
> to remove the device or shut down gracefully.

Could `system_state != SYSTEM_RUNNING` be checked in the wait loop? This
may allow to handle system shutdown, aborting the timed out wait in the
special case.

Userspace may also get stuck in a zombie state. For that, code should
use wait_event_interruptible(). But driver has code unprepared to be
interrupted, it all needs to be reworked first [1].

Similarly, for unbind there could a driver flag that the wait loop will
check and handle specially.

WDYT?

[1]
https://lore.kernel.org/dri-devel/20260515084030.21986-1-kartikey406@gmail.com/

-- 
Best regards,
Dmitry
