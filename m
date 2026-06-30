Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D344192EE
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825463; cv=pass; b=WxfTXtrhPymLSKVWxYc6aXqi8/Bp2f3xnxWpqdJdF5fnB9gmCT4WG/x7vpIIKiuNBB5YxptYZozsh3swIO0sotp5D7FiZ2t6Xh04n+bkUwisu5MTfyy1e/3psR35Xswwp6bHNMIIjt24dVbSb4/aQxYcoTB9VwU+1rCK91z7R7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825463; c=relaxed/simple;
	bh=8hAqR/yS1KwSK/zhAGJ3YKTCWZjVSrIHg2+k6TRSmJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/ADBh8KG7AnmsRrOmKQdeKWJ7bmFlu+goFyQwR55ACUS1cW6jrgOA4Hif6/z1PJMglMALMJelejS7Ew8llamVaOrd1XtfQLtyQgvy+7O1TYgAPJ7aAwseKU/0nwB22NnXyw1g5IknXMZL2hOwDqujdVPizSlR38uMn7K8sPLf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=SoZFKDcP; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="SoZFKDcP"
ARC-Seal: i=1; a=rsa-sha256; t=1782825458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FfUKkEaCXJeFEQNUxbJo3AZ1UNgYjnFvHWqO2RjDUFGEkoj1L10m5n9f5Zh1rs42wGR/YL2KNjuPD9VNC/DiBuK3BTq/QKVzeOFbOFcg6TI6Vao9sccNXENsI6zJcRXq/atYzSQvQTFALmrAuvtlh3FlbQbehuFySZBPoFKpFqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782825458; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l/Gb2r1RUizRn8tgbt0oiaU7MKiOg59aENHKzJck/80=; 
	b=AMz/8tr1qyWeZOnaQWpo6WmLkdI0PhCcuHXVTtfO/SLGbhJ5TaptPMjNu0bJ0VSiKmNbLNVYSpjxnKWcZY7rYh1+OrqrKLXcqv/sV5p/k9rU6venxvskiipDvHhywTFG5Nx2Mhn9Y1Ol0JlSofUxluHmkyLYtNejHyQdGP2ctLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782825458;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l/Gb2r1RUizRn8tgbt0oiaU7MKiOg59aENHKzJck/80=;
	b=SoZFKDcP3STBZcAKh3qM2yEjfpRJmHCFcNOk7/PlRTeh4yJbcq/haBtVU8LVn98y
	TO+qrudh+y9PlHZnDoHsoEDQJZbZ2wVVEUp0+jlq+R2fqLCaMkPZGt1K6PTPMuGeKtq
	UY6MfNe4YK75XMSyQZAlyi1MVxMigaxYskOGUOfI=
Received: by mx.zohomail.com with SMTPS id 1782825456755695.4332253165277;
	Tue, 30 Jun 2026 06:17:36 -0700 (PDT)
Message-ID: <36a2a25f-c73c-491f-b889-5a0c4662bced@collabora.com>
Date: Tue, 30 Jun 2026 16:17:32 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: bound EDID block reads to the response buffer
To: hexlabsecurity@proton.me, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/21/26 05:43, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> virtio_get_edid_block() validates the read offset only against the
> device-supplied resp->size field, never against the fixed-size resp->edid
> array. The EDID block index is driven by the device-supplied extension
> count, so a malicious virtio-gpu backend can advertise a large size
> together with a high block count and read far past the array into adjacent
> kernel memory, which is then surfaced in the parsed EDID (an out-of-bounds
> read / info leak).
> 
> Also reject any read whose end exceeds the size of the edid array.
> Conforming EDID responses stay within the array and are unaffected.
> 
> Fixes: b4b01b4995fb ("drm/virtio: add edid support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..c8b9475a7472 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -897,7 +897,8 @@ static int virtio_get_edid_block(void *data, u8 *buf,
>  	struct virtio_gpu_resp_edid *resp = data;
>  	size_t start = block * EDID_LENGTH;
>  
> -	if (start + len > le32_to_cpu(resp->size))
> +	if (start + len > le32_to_cpu(resp->size) ||
> +	    start + len > sizeof(resp->edid))
>  		return -EINVAL;
>  	memcpy(buf, resp->edid + start, len);
>  	return 0;

Applied to misc-fixes, thanks!

-- 
Best regards,
Dmitry
