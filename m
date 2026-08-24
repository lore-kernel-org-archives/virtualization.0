Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362031A7264
	for <virtualization@lists.linux.dev>; Mon, 24 Aug 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573797; cv=none; b=a/fS8FJBtB1ImMs43y4cTHK66ipmzQy3Q306RWYHhhpsxWMwmnnsGf5NTay6WCY6N6bb/oDPIhsnDEk2MbuLxEAc0lApcLavp3BGn80eauVcmoTG2ogXcnRsjxDSFghgq8KRioVNvrOJOMunr3zVgUaOlmURqxapxi0Wm/ofJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573797; c=relaxed/simple;
	bh=HY4/hY4GCajGPhuTzoCwJqa6n5dUUJ+IAciAHIaCMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPukdUi1QxjhOSa3nmXRpQkxt+eg0ZhMsph8j321lgmIfJuE1vjJKjkgAqFQ9F1WIOfKpa+lHRqrnig00O/DBNFtO4vxy2fb23EvzHtGAEOsBSS2zh9MxXVydUGiwpzrPP4sJF1sGI085W+NshI8Rw5k2j0rLja1oF/3cnEbK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWodaLME; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWodaLME"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4998e0916faso20452125e9.2
        for <virtualization@lists.linux.dev>; Mon, 24 Aug 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787573794; x=1788178594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUVSX1eeyklzM5HaiS0BAggEVkmh4XRpRi/E/jeaeS4=;
        b=DWodaLMEcyJQylNvn83uRxH+ebCm4uAAsZR8Ka8heBUgoRunZQBIJARNYhlwGuPQMe
         vvceIx/XqMQEqbthn2Lh61NGCrCyhl4edai85haLyjqsDH8NT65KN6lF/g8TX5UaDeRp
         CULzqqSJZAyG8idm6Jrt6OXcxtbRzH4hQLjXl7Lzp62rzZE5GZYIDevX397isHaiK1TK
         TuRx5iw8Z1fp+NjLfMNhqu4fOPyvPRzy1Fa16yY7XwsltQXQyS046z+SuMkj5csDiV0S
         Mk88YSWqI6vKonTCj2wDEdbeAto2VHvUa12dBQ1FM6Xh22S+gx3JhovVuyAAGuuGFHh4
         MssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787573794; x=1788178594;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUVSX1eeyklzM5HaiS0BAggEVkmh4XRpRi/E/jeaeS4=;
        b=odnlwRIkPanggtHmEeG2RJXm422L3YHhXWsMr8+fy1OQyZ/8/4u1fkb/1fyvduuARS
         Qx/LklCQCG9gvkjqM2HagTtJpaoRW/GNUJb5IbLMRsCgfgzzeVJv3fH1e63WH9Dg8GrN
         FoXVswZD2uaccrefLTnnBE1WO7urZmtI8IMbw68/R6mCayPrrSy+qVXhoOnDpu4Ce4+b
         9L39h6TpR5W+T4nqoG7BRzOmua0pT6llQW38hIqIesnS1wtcJ2uYe30A80HCGIgptsyl
         XyUCrrlVn/OT3A7AFPz444OyrZ5reeQG4matl55MHvxapfXni/cJF0VGlFDT9YAkf9fh
         WDpw==
X-Forwarded-Encrypted: i=1; AHgh+Rr31XxQyEiXBxrMDCMuMXtxVirTqA1fj3E/bKfajm7qkxV005wSlZCzBvBNG3Z8+8d2WoLVe1gkbPMuJ8YYnw==@lists.linux.dev
X-Gm-Message-State: AFuF++kAeDajHFke/eRG699T4cKx3t4e9hz0gAtLDbqOI0h/qZelauVl
	0oP9u9jw53IqJPqcpbvtSBSbJohd7ta/JG64/8GLfvIqSHjjELspsHkQ
X-Gm-Gg: AR+sD126Avkz3tO0gDhCXZ83UGyUgc8YmaSoQ69buFlwG9/OVDatPT7aJifYF/jv1Yt
	ED7MfHkFAZas7hsVFoiAxTtu48o0tjwz6FBcy3f+f6f2N974t1AzmqoCano8oxTwF7tfxbfys/Z
	k090swiiocwJYwfjbnvRz0MTkyMWb+CfXCcwtQ/jFB+vchMTmEDezN+tfX35yprhed6DKPuaKfE
	FwtNBLQY2DrMINO5pWqYUq3fiGFJO+/VKTy1RpKVRtp+iXRityQEhln76MIHOgBqJnohnDY28fO
	6M33K510MFgl2AKenel+SPNR5W54+V0BEBkXevbBJHuZXeYRmfV9XCbjRbSMuPMOUVtVms/3ZjE
	0L+qXJuklHnUn094uHZWYCF7Ws4N6cgv0g5CqHgMq11TvnXeNtEngPXUFXlbXvt0x3n+clUVSkt
	GCE86GJ+5fT5PQ6TErdpuqcR46SSt8dKWIXBDCU4qASmL0wjU4bJ2v8lzmCu80AlqFCwUmmltg7
	ZD6r1UTwyqFGOB2HA4WO1nfWw==
X-Received: by 2002:a05:600c:198c:b0:499:87f3:a2a3 with SMTP id 5b1f17b1804b1-499c19e6763mr198896505e9.15.1787573794238;
        Mon, 24 Aug 2026 05:16:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b95dsm87898475e9.11.2026.08.24.05.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:16:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:16:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rongguang Wei <clementwei90@163.com>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, Rongguang Wei
 <weirongguang@kylinos.cn>
Subject: Re: [PATCH net v1] vsock: validate buffer min/max size in
 setsockopt
Message-ID: <20260824131632.2d325c42@pumpkin>
In-Reply-To: <20260824091257.136269-1-clementwei90@163.com>
References: <20260824091257.136269-1-clementwei90@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Aug 2026 17:12:57 +0800
Rongguang Wei <clementwei90@163.com> wrote:

> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> SO_VM_SOCKETS_BUFFER_MIN_SIZE and SO_VM_SOCKETS_BUFFER_MAX_SIZE
> do not cross-validate against each other, allowing userspace to
> set buffer_min_size > buffer_max_size.
> When min > max, buffer_size is silently clamped to an incorrect
> value. For example, setting min=512KB then max=128 results in
> buffer_size=128 despite the user requesting much larger buffers
> via SO_VM_SOCKETS_BUFFER_SIZE.
> 
> Reproduced with a test program:
> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE,
> 	   512 * 1024, sizeof(int));
> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> 	   128, sizeof(int));
> // User asked for 1MB but got 128 bytes silently
> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> 	   1024 * 1024, sizeof(int));
> 
> After that use getsockopt to get the buffer_size = 128 and
> buffer_min_size = 524288, buffer_max_size = 128.
> The buffer_min_size > buffer_max_size and the kernel accepted
> contradictory values without error.
> 
> Add value check to fix this issue. Return -EINVAL to userspace
> when setting MAX_SIZE to a value smaller than the current MIN_SIZE
> or setting MIN_SIZE to a value larger than the current MAX_SIZE.

That is going to break userspace that sets the minimum before the maximum
when the new minimum is larger than the old maximum.

David

> 
> Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  net/vmw_vsock/af_vsock.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index a33b2a2d381d..5faa30ee8745 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2050,12 +2050,20 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  
>  	case SO_VM_SOCKETS_BUFFER_MAX_SIZE:
>  		COPY_IN(val);
> +		if (val < vsk->buffer_min_size) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  		vsk->buffer_max_size = val;
>  		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
>  		break;
>  
>  	case SO_VM_SOCKETS_BUFFER_MIN_SIZE:
>  		COPY_IN(val);
> +		if (val > vsk->buffer_max_size) {
> +			err = -EINVAL;
> +			goto exit;
> +		}
>  		vsk->buffer_min_size = val;
>  		vsock_update_buffer_size(vsk, transport, vsk->buffer_size);
>  		break;

