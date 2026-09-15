Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E854A99AE
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506948; cv=none; b=twAJ/4cn0zQLDBCXJQqsLD4Px8y5cXB/K5PknV9GeqhrlqcVUt/QE+DVxDsEZUwg1OhFpdTywZVlGt/l8PJhIodmDzY4r9EWftQRDu9g/N3gJitdcAek8+uiIxHWFu6V8lBKdlf0ktO59m8hfsvCTp5NjH2M4NbfwV2qlhdhTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506948; c=relaxed/simple;
	bh=cB2vOu8SCkke832JTEkB7KTN21438Mvph7EGHh8hGh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj12v546Bl7Xp6G+HYLUyQz39fHE2HKIeYAHftkGVPSWDmXuoGxTWKnasiv20F5kRdk5ojx8fnc/Oc9jV/T7KM05YEU3cElf0fKYfFuvrSaO+2iRd3oki5ZQP1TUIQb7+suzkP66cCFXaHjgsj9LjlFZ2Sxtvo/ajrLrxlIp8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=DUW8aNf2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ps7OgllX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="DUW8aNf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ps7OgllX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 52317EC07D8;
	Tue, 15 Sep 2026 17:15:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 15 Sep 2026 17:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789506944; x=1789593344; bh=C97HYBalGs
	NCZXhkZbNbxgbXvtevHKoKbIlgLMz3x2E=; b=DUW8aNf2UWhr5Xl7IXYV5bv8Eo
	ifHVde9p2lndgdTS7AvF2c8NTuOKHzLDDPpNt9JJiu3IKXmQ3VbJ+VDpauoVpVQV
	Gb2dsvyB0JvUwxAu2TDTzfv3ln7uDS7MUtIynQBsJcWeNtZj+ozLh+sd1LT9JFAc
	fa6tgJiyeGx8Y9Uj9XNr4Fy91RM6uJ7vl0L/FxN2gXGKmVzdv0mtZtD4Mty4w8Df
	jKPcD9WxhClHlElRMpPDsArsXiXdhMrbWeMh6FSZK8rtXTW0q7yV9YrKnnFQYm6s
	1bjB4J/KKPXfEmWLteIwu1AHB4xaf18FpExxMow3rLxeI/MHoTYtowmbmnVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789506944; x=
	1789593344; bh=C97HYBalGsNCZXhkZbNbxgbXvtevHKoKbIlgLMz3x2E=; b=P
	s7OgllXhwyIHyQfXr7a5Ib8gESIfrwRm/IDgL8p4d8V2FuWt5SbOJyR2wKXkdnlP
	3rB7abvWC0OwLeGqGuNbIRlmmu3pB5IwbgzsJKyLfd/iLW8Iq1ob5N2L2tL8c1nn
	dmjyFk7+HXSFYcX09oAMmzlkKqPzuCiqK21xgzPz15bBU01ZhO8LlkF415hGqxk2
	L/9nIt8mZh/gHwPpTiuzC6CeO1tshYWL5ItLb0xUeJ0cQkmyJJQAxgaE+vvZzyUz
	xE9eLzzoUSzkJ3l1CJRLiJyajBDQf/Knjfh3wK5I8ZmzSymlXbsJvSLNbdThCTu+
	UOgPSRZNMzT5kGcir4Uuw==
X-ME-Sender: <xms:f7WpagoZFbQiVF9QMQHHBQ7XwsS8ekjLAWNSSE2N-FfSxZBcbjasKQ>
    <xme:f7WpanFbVHT9lvwsKJ89Vq-9CD83h9Us3RYy-6UknY0or0btjWdQ2tqll2HZIFQSc
    y2O7_WSCnOukc3mL5xckmSkY9RAe0kKarmhKTdoaQArVKWclR5->
X-ME-Received: <xmr:f7Wpal5xRWUZL2cps2E4vamZQ6dgPGRdgDcl09-uo10ynv0cC4E55jP6vtWFhV-bOm6caYSQ0_DDlL2fpuON8TWavddswA2l6A>
X-ME-Proxy-Cause: dmFkZTFaZBlKXrQ3RAdCqzhwYVRj9tUqA33278D0sbjZjCo5mHBj8KO3wGudGXYUi5j8gb
    3UM5JjJTBnou2L2pvhuLlqPRFX2ELepnvCv9OpDEX+aIW+baWI1Akf6Bn+HNCOKwBMope2
    qX70AQ/pOgrQXBHONaEujRHOUVUkk5C3MHngtUjnltCMlBnv2ESbH9WDQdbyjOBXXFg8/B
    04ae3X1RO32NTPvlLVp6jo0nctrfIrHbAMmWui/ldCvB5bxgMDdHjTTO4N51/XHxuEaHwt
    llvFneQrcJo3b4eKBGpf/7RhIrxh9+72WS7zK0e5CbLDDmUtGTejfqcOEKFlcgl3csMLj/
    W/bKWTLNXgYLRa0oz2eKq/rvlb94E+mMiTCJ4gZAjD8cCEsNeKhBKVPKn2oabbLnYdPBHS
    JnVMxdX3/VZ+9q9HBhAniFVQhtDan1+OxUBz5uCW9bZvb5YC3AFLm/4R16PCl1G2XmNcqX
    6SHDh3Q/sjzjcDBXvmigAEHu6G+efbAf2Ey378sH/9AJkwCewCYcClR3TKAa0sr0ygPzkm
    G4Qes8A7hKYBOioCpZinOGyfqmyC22B0oHTT3E6mJiWG1rRrcS6oGEG6fL03O7FS6L7wsj
    d913k9WD2tvq9jyzBvQmU9G7E/Ly9TEthA8sD3VoXLBEoJ709k2O0Jomytxw
X-ME-Proxy: <xmx:f7Wpavef3wAXeJXh4HzSaOPq2yJPi8NNkQ6XQh9pzmk-hL7LtmgnRQ>
    <xmx:f7Wpag4_SWYW2yE6mBpqXRObDJJerkdZZdPtKiK4f_ujVtsUO5q8_Q>
    <xmx:f7Wpak9uM9FnTTec0SVyqo4CynVvmolpDkqi4OfOeH4smnsf2NKm2w>
    <xmx:f7WpaqHJ8tYP6qrn0D3OV0z5Q16R7liGTKCjR1BECJdyhEXJ47bsMg>
    <xmx:gLWpanm871F2Os2jLU2qGEd4w1XtcgwvVEFJb31IrDKMY6dtL7eTc7GP>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 17:15:41 -0400 (EDT)
Message-ID: <579d804b-d548-4c8d-8350-e1e181a612ae@invisiblethingslab.com>
Date: Tue, 15 Sep 2026 18:15:38 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "drm/virtio: Allow importing prime buffers when
 3D is enabled"
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Yiwei Zhang <zzyiwei@gmail.com>
References: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <20260911144204.2089401-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/26 11:42 AM, Dmitry Osipenko wrote:
> Guest userspace may import udmabuf to vrend. Vrend doesn't support guest
> blobs, and thus, further 3d operations with the imported blob are failing.
> Typical scenario of the problem shown with mouse cursor RGBA image imported
> into virtio-gpu, which previously was rejected by virtio-gpu driver.
> Revert enabling guest blobs importing into vrend to fix the regression.
>
> Link: https://gitlab.freedesktop.org/virgl/virglrenderer/-/work_items/674
> Fixes: df4dc947c46b ("drm/virtio: Allow importing prime buffers when 3D is enabled")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 149e6bcb5878..ebf471044d06 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -349,7 +349,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
>   		}
>   	}
>   
> -	if (!vgdev->has_resource_blob)
> +	if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
>   		return drm_gem_prime_import(dev, buf);
>   
>   	bo = kzalloc_obj(*bo);

Oops, right, didn't think the back-compat issues all the way through on 
that one..

Reviewed-by: Val Packett <val@invisiblethingslab.com>


BTW, to clarify wrt the original use case this was intended for— I got 
it all working, but it adds new feature flags:

https://lore.kernel.org/virtio-comment/20260903021442.423274-1-val@invisiblethingslab.com/

So I'll "unlock" this again in new patches but not unconditionally of 
course. Rather, gated on the new F_CREATE_GUEST_HANDLE flag which would 
indicate that the device backend *does* support creating guest blobs 
with host handles (dmabufs).


Thanks,
~val

