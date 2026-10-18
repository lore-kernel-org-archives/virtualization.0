Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE94DD3D5
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359705; cv=none; b=sQSUpBXqE50/BaLgEwXIm75r3MwpIKAf8CLelL1IhiU09UBT8gVIVF64WJWffd5/M3NQlOh0Xrm1svEGKVlFJWfbXzsAThmF4Chf+UrxelCsEJuKNfsre2uBSxQE3dMVfuUhG0nr/RxLsk8lCIn6GtJmPFVr3h45tQkmnF/FTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359705; c=relaxed/simple;
	bh=QpgY1mHMPAh+BF52MMdR/jItFN7LZuBUhKsHUTs7ZxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZVn9y7wvI0G/h/Xh8MFN1X2u/4eJ0wYQDVCKUBXtcfpxYPaTjSVrcuTCRd86iVkNi/MzmaOEVEarAF46aSLFq/VNtrVyrTNLaSJaSw8ZNIOlkAFZ9OQgTWPlqpVACzm97PHWBUvxrOZPvy8Ac7HoExStIpIsFul2NM6fdAcdc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xb+ZqxPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xb+ZqxPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
	b=Xb+ZqxPhr/usk1toAvehLv1gZZASTxtNAqvHzCZVvZwXDAIWXru1KzpJgRiYETgae8Vv8S
	EewowuQQ/Dodds+DgMcNh0UHeOVHq42QToP4kCxxm0VKBfm8mgejm4XyJ+ISeUVVlCVsv3
	15/DCaYTZ1a0m3H8jSewCwZVN1t9yWs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-NTP4U66lPr-tYhURKA1PRA-1; Sun, 18 Oct 2026 21:41:39 +0000
X-MC-Unique: NTP4U66lPr-tYhURKA1PRA-1
X-Mimecast-MFC-AGG-ID: NTP4U66lPr-tYhURKA1PRA_1792359698
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1df6c2937so10214075e9.0
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 14:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359698; x=1792964498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2sM3UmHiQ62epsC/FE3R8schNmhPjjNgAmVVqxJiF8=;
        b=FEMplGF4pVcfYeWRSb9OCb3iebduHljRfjfOtvVor//Nv/hkuIIcqHsvOqy4i30pzu
         rA1Jsynhl/1JnD2fT/8IMPfCxVe87slwr2cL8/oI6KYXycbkeOVZQGPVm6pm4qaa53/8
         htXOmE9Ptocsf8I71niTO8d5SkW5FWZr6uXQ+OWrLzI4bQHo6fkSTEzNzh3HZu64m6Y7
         9xqAWs3boG3UUoO710ZVZ4ik0PWRXufTl0fTZXnc3rfmrVGORfFgagm0tkP9fPqWDPqt
         shubL2s46CLXOrZcxrZTdRXjXo1Oggx+7TKUCXHBA3zRMJ5MB0sZQ1sSPC8mbfsb1mFv
         JFTw==
X-Forwarded-Encrypted: i=1; AKwUvByg1fZG5PPqGJZKdqso16dI5ALKu9cqbok2FmdsujnN7n2b2hz5xRyDeuOquytoz0qlVivngy1pXneraq82tg==@lists.linux.dev
X-Gm-Message-State: AFq9FYId5A/qgYT8KHUbfq9+OhsZTkvzGeloO7+/4kU+160qdcO7/ZZ+
	N4t5nqO/kR0XFO6KZ0pPYaDPPoT2dpyc2bX3TRnN/s1C0L205sso5BUKKiYSGKO1wQRc02sfFAB
	Yo7nQIWqfXIbBJbT2o/75zxBYqpxm7o12H6tIJ2+RGk9ZMAcdbEjNXj6bo8xV8dBbeyVr
X-Gm-Gg: AYBFou15CSnG0oTK3LUUA8mjoymIDZXiFxexxxGtkNxkZE0GtcVBs2eDnWprfTjRFUx
	8/i9GGbLdyAjJgG6y5zgPP/gZVLofWgR6yxJmXo9cbXTOI+wm8j8SRktR8nsrse6ONUhSbnrfwy
	VIgc8T0SHjo3PBmxic0FiZbCL7f9hDj+wf9nbwO4mm0x1ejBM1RZWC7eCGjWrx08dgxyfFO4Iw4
	czgzFjkf89xk3eNsaBf0A/BEu9sMwwrHyui5dhCOOlK2OTJLbtMfwBvNuEPRzr/OGizt4OC8L9u
	PUTe58/wINAKtWH8+XKXYQ85DRFTbqU3V7Bgpp/RSoSKBglwEATkl+0u+h/18RCBtamNlw==
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1d760536cmr116501155e9.13.1792359698230;
        Sun, 18 Oct 2026 14:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8709:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1d760536cmr116500815e9.13.1792359697712;
        Sun, 18 Oct 2026 14:41:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e9423f20sm12734705e9.7.2026.10.18.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:41:37 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174010-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wNryWI3BTdyPrL_i_S7C1ynNgWsvSrIpo8FIrvx4Zoo_1792359698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2026 at 11:11:44AM -1000, Linus Torvalds wrote:
> On Sun, 18 Oct 2026 at 10:34, Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > And __get_user() together with access_ok() is actively wrong and
> > stupid. It's slower, bigger, and more bug-prone than just using
> > "get_user()".
> 
> Btw, if you have *multiple* accesses to the same structure, that was a
> historical reason to use access_ok() with multiple __get_user() calls.
> 
> But it's not a useful pattern today - and hasn't been for years -
> because the real cost is not the access_ok(), but the stac/clac that
> surrounds __get_user() on modern hardware.
> 
> If performance is really crticial, the new "unsafe_get_user()" model
> is the way to go.

Thanks! I'll try to find the time to look into converting vhost to that.
The flood of ai found bugs I am dealing with will abate any day now.
Any... day... now...

> Here's an UNTESTED example patch of how to do a conversion. It
> generates much better code than __get_user() ever did. That patch
> looks good to me, but again: I didn't actually *test* it (and the
> reason this signal.c code has never been updated to the modern pattern
> is that it really doesn't matter for performance - I decided to use it
> as an example not because it matters, but because it's a good example
> code-sequence for the legacy model conversion).
> 
> Somebody should test it.
> 
>                      Linus

>  kernel/signal.c | 56 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index d31ebcb6ed4d..0fd1296e912b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4776,12 +4776,12 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  
>  	if (act) {
>  		old_sigset_t mask;
> -		if (!access_ok(act, sizeof(*act)) ||
> -		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
> -		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
> -		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> -		    __get_user(mask, &act->sa_mask))
> -			return -EFAULT;
> +		scoped_user_read_access(act, Efault) {
> +			unsafe_get_user(new_ka.sa.sa_handler, &act->sa_handler, Efault);
> +			unsafe_get_user(new_ka.sa.sa_restorer, &act->sa_restorer, Efault);
> +			unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
> +			unsafe_get_user(mask, &act->sa_mask, Efault);
> +		}
>  #ifdef __ARCH_HAS_KA_RESTORER
>  		new_ka.ka_restorer = NULL;
>  #endif
> @@ -4791,15 +4791,18 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(oact, sizeof(*oact)) ||
> -		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
> -		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
> -		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> -		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> -			return -EFAULT;
> +		scoped_user_write_access(act, Efault) {
> +			unsafe_put_user(old_ka.sa.sa_handler, &oact->sa_handler, Efault);
> +			unsafe_put_user(old_ka.sa.sa_restorer, &oact->sa_restorer, Efault);
> +			unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
> +			unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
> +		}
>  	}
>  
>  	return ret;
> +
> +Efault:
> +	return -EFAULT;
>  }
>  #endif
>  #ifdef CONFIG_COMPAT_OLD_SIGACTION
> @@ -4813,12 +4816,12 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	compat_uptr_t handler, restorer;
>  
>  	if (act) {
> -		if (!access_ok(act, sizeof(*act)) ||
> -		    __get_user(handler, &act->sa_handler) ||
> -		    __get_user(restorer, &act->sa_restorer) ||
> -		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
> -		    __get_user(mask, &act->sa_mask))
> -			return -EFAULT;
> +		scoped_user_read_access(act, Efault) {
> +			unsafe_get_user(handler, &act->sa_handler, Efault);
> +			unsafe_get_user(restorer, &act->sa_restorer, Efault);
> +			unsafe_get_user(new_ka.sa.sa_flags, &act->sa_flags, Efault);
> +			unsafe_get_user(mask, &act->sa_mask, Efault);
> +		}
>  
>  #ifdef __ARCH_HAS_KA_RESTORER
>  		new_ka.ka_restorer = NULL;
> @@ -4831,16 +4834,17 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>  	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>  
>  	if (!ret && oact) {
> -		if (!access_ok(oact, sizeof(*oact)) ||
> -		    __put_user(ptr_to_compat(old_ka.sa.sa_handler),
> -			       &oact->sa_handler) ||
> -		    __put_user(ptr_to_compat(old_ka.sa.sa_restorer),
> -			       &oact->sa_restorer) ||
> -		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> -		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
> -			return -EFAULT;
> +		scoped_user_write_access(act, Efault) {
> +			unsafe_put_user(ptr_to_compat(old_ka.sa.sa_handler), &oact->sa_handler, Efault);
> +			unsafe_put_user(ptr_to_compat(old_ka.sa.sa_restorer), &oact->sa_restorer, Efault);
> +			unsafe_put_user(old_ka.sa.sa_flags, &oact->sa_flags, Efault);
> +			unsafe_put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask, Efault);
> +		}
>  	}
>  	return ret;
> +
> +Efault:
> +	return -EFAULT;
>  }
>  #endif
>  

