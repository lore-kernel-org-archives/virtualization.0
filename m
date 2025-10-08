Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990F28FFF6
	for <virtualization@lists.linux.dev>; Wed,  8 Oct 2025 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941740; cv=pass; b=e2Ofm7FhSZqc2gkwpJ5dzqRQ26Tkl8Jh+8WMVOMIzG2MyITzaiigPb/Tk5cYzISwDisQG7lTxJSpeND3uyhFjBuNeGY3QJEeCUbeEDdoXJ8934yFIXYyVJTtczuJVQ7Jf/+236Sq7Bg8xwozkXDAJWI+Ut8nor+9OAYHhExjgN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941740; c=relaxed/simple;
	bh=0QT5fiTbw70T32jKYB7lonb4ou6wvPYn5efgWlrrEIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozGMPfjHkv7OeTiwjU+L2vpM923TrZJtchFoA+iP2xAOCsvgTNk93Xpycd0ePt/KGmybr6NZwsM907o9fVujrxpKpHZnRIroptz9ETiEpIz/ADd3F8w4otdGzNSyyapI50FRpr8rtVbXnAUZBu98A9iRe3ksSr2043J/otfAqYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=FfAbmqg7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="FfAbmqg7"
ARC-Seal: i=1; a=rsa-sha256; t=1759941723; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SAEerhnyRtCTvkcy9M0Re6Pd7eGgMaWRbOxJJNgSzikl5BHVBD9HsOYTswe0oKTS52ckyV4YQjJ5uMZ9p9fu1L+Xuq0JRxaBce5D0aKj66kFrZcziXMhTzNqkCyLL1ixRtUOJzlKa8VA2UTxSho/mVfaiNmFsg7iBSHcvcwq4d0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759941723; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T4+9Egmgtw2ntKsYRRssTR5erKK1MvF0GFC1tVxfSlA=; 
	b=dK32XGfn84a2H1cvey36yefSyYWuc8yrZ1Lm+vTQqtqRr1AgX8sBtgfgU9Ifhgg6Bw0kBKU4qRcSWUPzlRoJz35mRCY7mZEf72/2BO2Y7JQxS4rXejP57GpsPds+ciMHn6dJnwTnWqMgeBVxcitlC6yH7HrtgBWXdut0I0ofGD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759941723;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T4+9Egmgtw2ntKsYRRssTR5erKK1MvF0GFC1tVxfSlA=;
	b=FfAbmqg7IPznFvTP1MznSffSxMedDpP42tycNT3F7ZeMrPOhMVL5pL64PMoYEJ0l
	3KXwwCushI/HY/b0UdFS2+FSMnEhgAU0oz8NdFgU6zDumkanGc7z9GuLz08MQR+bLQL
	knivijmWxOt8nig/Yak6iI5M1Pd4Y4rt8O0jlLTk=
Received: by mx.zohomail.com with SMTPS id 1759941718659770.561042562623;
	Wed, 8 Oct 2025 09:41:58 -0700 (PDT)
Message-ID: <bee245fa-f9c0-4f69-a373-d03da98c6e6d@collabora.com>
Date: Wed, 8 Oct 2025 19:41:49 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtgpu: Use vblank timer
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20251008130701.246988-1-tzimmermann@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20251008130701.246988-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/25 16:06, Thomas Zimmermann wrote:
> Use a vblank timer to simulate the vblank interrupt. The DRM vblank
> helpers provide an implementation on top of Linux' hrtimer. Virtgpu
> enables and disables the timer as part of the CRTC. The atomic_flush
> callback sets up the event. Like vblank interrupts, the vblank timer
> fires at the rate of the display refresh.
> 
> Most userspace limits its page flip rate according to the DRM vblank
> event. Virtgpu's virtual hardware does not provide vblank interrupts, so
> DRM sends each event ASAP. With the fast access times of virtual display
> memory, the event rate is much higher than the display mode's refresh
> rate; creating the next page flip almost immediately. This leads to
> excessive CPU overhead from even small display updates, such as moving
> the mouse pointer.
> 
> This problem affects virtgpu and all other virtual displays. See [1] for
> a discussion in the context of hypervdrm.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://lore.kernel.org/dri-devel/SN6PR02MB415702B00D6D52B0EE962C98D46CA@SN6PR02MB4157.namprd02.prod.outlook.com/ # [1]
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 29 ++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)

This makes KDE Plasma boot splash animation play at a normal 60fps pace
with virtio-gpu and virgl instead of 1000fps. Thanks for fixing this.
Didn't expect vblank wasn't working properly. Will apply soon.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
