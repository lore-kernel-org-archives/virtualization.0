Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F63ACF1D
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756665; cv=pass; b=ITkNnQ6guLgHQ4aSfg8/ItY/BtmwGJBdrmkwq6VmHH/e2hrG7TV52Mfd4UnxhGd3p8pMENCrQE0JUkqXDtQ1Y8ONch6csU8B+N+EN0wc+rghoV5PkKCvf54iQs18J90IO6kTfZA5eiClyUnPe4AWo6XZyq9HgshjP48m7gKsmcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756665; c=relaxed/simple;
	bh=LppaDisfJlZ127nmgLD4UTKGlAPRM5raxy5iM4ZnFnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INZu5v87rvQ6IbbvkH7jN9c/g5QwMxQgrjDIKK1FmsUbvS3YffZUyeV9Q61JMeZraLeby3ZSGqgh2tRO70JGWHtGAFfwwheGt720vghZrjgReOM+14jU0DFDNQA5aBHHlNSQblt8+5lxCQn7h5sM8tphrEHpDFKSkPSrznjXGjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=TQMK5nM6; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="TQMK5nM6"
ARC-Seal: i=1; a=rsa-sha256; t=1791756650; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n3jN3Bqouu0nY6sX/sUfVukLaVRnkHKbMehkBXF2gK3uKUMDdDIKKQ1h8hj60JBgfh+aQYSoe3EkpSUivdxmoQa5ZJ27g7xRHEB7nrPWPDtQ5XPrlZdXBX07FZ/corieglk3OdVukCD55ERreomqq9X0bMx4xrciJnELifgBWOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791756650; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ms1Sj4b8K+z26gx8JG2rV9uppLq7GLGS0paorRFW28c=; 
	b=nNuNrcaRRdYieF7LdaaTFhYUViuA4Orv4z/nemMbNB+giO1ty0r5w/EF4KCzLWL/JT2Y5vp6OBw4JDUKgcBqoOUxt3X2nVpMPYNaoAYvC2IGy+ti82oCpjV8FN+gUkMEBmLOFzzTdMtZNeI6s5RDRx1l+ZlPoTvhCNTVQQ9m1qI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791756650;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ms1Sj4b8K+z26gx8JG2rV9uppLq7GLGS0paorRFW28c=;
	b=TQMK5nM6dMDDsnX82yzq7UMhsbNg3Cwa+7Axkdsk7iq31M08MLEbbpPMZ2iXMyUZ
	avnrTNW27eZWP9AOrSE7hHYSVzGu+evlJi7bAJ/A9Zo5AXj/0raa9WZUmQTirAxNAz1
	1xk7TB0Ynv6MSOLTs446wgTEjk1rSP2H3Rudunic=
Received: by smtp.zohomail.com with SMTPS id 1791756648895284.2782609469007;
	Sun, 11 Oct 2026 15:10:48 -0700 (PDT)
Message-ID: <d27374f9-d0ec-4637-a4b4-d5e6ce1922a1@collabora.com>
Date: Mon, 12 Oct 2026 01:10:44 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Dorinda Bassey <dbassey@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: kraxel@redhat.com, airlied@redhat.com, slp@redhat.com, mhrica@redhat.com,
 gurchetansingh@chromium.org, mripard@kernel.org, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
References: <20260930132707.500748-1-dbassey@redhat.com>
 <94f11a7e-7563-4480-8b00-6e3374865669@suse.de>
 <b8064104-99dd-472d-883d-56b362d60371@collabora.com>
 <067c22f6-206a-421f-8837-1f8a88f55299@suse.de>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <067c22f6-206a-421f-8837-1f8a88f55299@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/1/26 16:31, Thomas Zimmermann wrote:
> Hi
> 
> Am 01.10.26 um 12:46 schrieb Dmitry Osipenko:
>> On 9/30/26 18:03, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 30.09.26 um 15:27 schrieb Dorinda Bassey:
>>>> Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
>>>> virtio-gpu primary planes. Without this, glmark2-drm fails at
>>>> startup because it selects ARGB visual configs by default, which
>>>> don't match the XRGB-only plane capabilities. This causes
>>>> drmModeSetCrtc to fail with EINVAL.
>>> But does the host also support ARGB on the primary plane? We usually
>>> don't export formats that are not available in (virtual) hardware.
>>>
>>> Best regards
>>> Thomas
>>>
>>>> The virtio_gpu_translate_format() function already handles
>>>> ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
>>>> so this just exposes the existing capability to userspace.
>>>>
>>>> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>> For primary plane, alpha channel often doesn't matter as primary has
>> fixed z=0 order and a usual alpha blending mode would account only
>> overlay's alpha channel. Many real hw drivers expose alpha-channel
>> formats for primary plane for compatibility with userspace, even though
>> for them the alpha has no meaning for the primary plane.
> 
> We decidedly do not offer formats that are not native to the hardware;
> except for adding XRGB888.
> 
> 
>>
>> QEMU is most popular VMM using virtio-gpu, but there are others. For a
>> stricter compatibility we can translate B8G8R8A8 to X8R8G8B8 for the
>> primary plane in the driver code, but I assume in practice it's very
>> unlike this will be necessary and we can always do it later on if will
>> be needed.
> 
> No in-kernel format conversion please; again except for adding XRGB8888.

Chances are low this may ever become necessary. Confirm glmark2-drm now
works with this change.

Applied to misc-next

-- 
Best regards,
Dmitry
