Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795357547;
	b=lQaRUAT+7XZU8J/Qf/47xgQc6DUrE+8iWVihuIE70ZIbJHUMWORCF6Vawp584l8lsN2U
	 cNg5rTnQ0U6CgE9zsi9aazA1+p8/TT1kJSlx8P7v74dSlP9lDY7/f0CdEP29vDmOTuZZ/
	 +vn29Ajj91xRfWJyngRXmOhsUOgcLTPEXT0bsYKnJwjg91fL7kQT8rQcnQ+pbjGOseBKc
	 Q46qmnIC0F15/Hl4nxBBddVv7Hs1J309o+3AVbDa2Tm/DyfbLoSxLYayPce/CuOfIIDF8
	 jFncUYQIhaGnpG0RakFG4gTStMw2t62jPFpJWO91lDgF9u+qJ7NNZG7Dz4mHfCLzlXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795357547;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=LW2QjvXtN8ArARJ6Dwfn7ixNOLbHAf2rUk+OEdDzONU=;
	b=DIb6qS63MSPvnu6VeNKeiZsD8XFn7Yw5m4IgR5KubwpgURIoC/KpATh5MSNXULYUKVYp
	 fYvCljG7mErqRXasGGiBMEQKxlcEWYA/z/HEP4aMdHYewC1TF4oehZ48Wgke55Lv9z/fE
	 UZVGzyvsJ35YojoZfOiypng2YisdwrhpiM8gKjjyn7Rq7ZasFYxnzPQoAX8Ell8AKnMAH
	 KMpOeFcoQp7CyNBSV6PwRWnOCCqT5FNYSF8JxH7TR1J0Kc276V8Uo6wk1HeFR6hZ3TZ+E
	 iMr+GaV6va452IuA/WPip/6MEWQ/rSQTrh8LIvTG3Lb4WwR0AwTc6F0fzesHtO7fP5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ds1gaNjL;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7F606A32A
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C7F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ds1gaNjL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795357545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW2QjvXtN8ArARJ6Dwfn7ixNOLbHAf2rUk+OEdDzONU=;
	b=Ds1gaNjLhb5WHwmCArop9JDrDXaIzZaDCP1OgcxsXrfRPeCRS7tpwQh6iepWN2+K7FlEfe
	E2QgMckn9Ttq9qGTkrJOeLboENGuHKYbjDKKCkoAG28mpbnjdgPiMdz/TcQXCrtNmEawKj
	KnaN/vzkRN6K6vnjkAFSkZzZLJ9OyIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-8Wf0eAUcPkGM0JATPltVsw-1; Sun, 22 Nov 2026 14:25:43 +0000
X-MC-Unique: 8Wf0eAUcPkGM0JATPltVsw-1
X-Mimecast-MFC-AGG-ID: 8Wf0eAUcPkGM0JATPltVsw_1795357542
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a4654add56so16017255e9.2
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 06:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795357542; x=1795962342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LW2QjvXtN8ArARJ6Dwfn7ixNOLbHAf2rUk+OEdDzONU=;
        b=Thur7EvZSMfu3d8tbzf2XQBc5O8QeJJIOvII42PKRneKiOEPTd/zwO1hEaS+/F3vbl
         A+mFEaRoKm7zqkkuwI5EXYAlR0o40AWZxXDKtSSMMlgZYVuT9STbdTqdkUL137YCC8dk
         j4CNIr9Vxc0G2ZnYKxANX9/RHDzyKeA8dui/28iawC14BYuH5PKi+nV0Wat0pnxes0NF
         XTWMUnCzqcjeO9c32kP0flwZJCGj0OQeJ0E2XoBt+HMNtr16EbSP0flBHQhOV2xVPsDI
         sE6fHAoU/sP9eLoDCV1Is3ThQiYYswRUBjizu6sPFByqYEc/+z3ziM80L1TnCg9V0esz
         JVEw==
X-Forwarded-Encrypted: i=1; AL+hErFX6w0vgLkw+jBYs0rQArhcfSEjlyBbynk8pNzfgzic/9ngr3xoEC/2UFkdGUJe1KvT5nKlr8WoOoaRT/ymoA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+5rQI7lYYlurEFw6ZpSnflkYizAHuRn65Cop4OsneZ41OGwwWC
	v//gNQCfPQWZbjyHI2bZZBoNwmU+fGS3/L9Gt7QTmc+m6j3hRaokZnsPhvw+VKjljjVJIJP8f5V
	hhaQL/z5VlH2t1hFfEEfW/6nuGrarCYV9qP+xtEGV02eSlxhAtl9K1ZnEmXCjVO9PeysW
X-Gm-Gg: AZFdTZcqE/ACiicQ2H6rf5pR+TjYPdedFRPwhryDV0/Qm6rUi4438sqnu1lm48uthRx
	paweGp7yA/yIDByShvCemfsv8Ub7s3LDxAEEQUu83zy0b1gFiG9yRGVY81z7mtFFO2ZY3lMiCZu
	nVJ5ZaL6QMmJtb8t4lL+kHKE7Cr4AbWL9W1S4wqgozq00w9iNol0CFiEHMZX39vxiBbRMOquG1p
	wHP6h7M7r5sIvJsv0raAJMtxmtwopZ4hzh8036g6g1Z8U4+BbhAp9fEEEHb+5RxgOIXHxUVu/YF
	FRDomalw9OKPzM3EPTqHIiDi1Ly636ir5sgV9iskdCS8FgY+C7hw9FVNiBJvDxd7Jf8b4LHX2gx
	j142sXKDxIrcdhc/te+glb9IY2i8AUQLN7Ta5WnXn
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr184853475e9.34.1795357542257;
        Sun, 22 Nov 2026 06:25:42 -0800 (PST)
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr184852965e9.34.1795357541679;
        Sun, 22 Nov 2026 06:25:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1524:9e00:c39b:a740:e7:3fcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm271466675e9.15.2026.11.22.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:25:40 -0800 (PST)
Date: Sun, 22 Nov 2026 09:25:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Message-ID: <20261122092235-mutt-send-email-mst@kernel.org>
References: <20261122120919.1718445-1-hengyul@cs.unc.edu>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261122120919.1718445-1-hengyul@cs.unc.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _UhqIPsqGXKV83XlGsRgjuwXGeci8Bn3wE7A18BRq0c_1795357542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 22, 2026 at 07:09:19AM -0500, Hengyu Liang wrote:
> Commit 333c515d1896 ("vhost-net: allow configuring extended features")
> added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
> words from user space and checks that every word above the supported
> ones is zero, one word at a time in a loop.
> 
> However, the loop has no upper bound and no scheduling point. As of now,
> a caller can pass a count of U64_MAX and a pointer into a large
> zero-filled mapping. The ioctl then stays in the kernel for as long as
> the mapping is readable, and a fatal signal is not handled until it
> ends. On a v6.18 debug kernel booted with preempt=none, two such calls
> from a non-root user, each on a 4 GiB mapping, froze a 2-CPU VM for
> 56 s with soft lockup reports.
> 
> Interfaces that take an extensible structure from user space limit it
> to one page (openat2, clone3, sched_setattr).
> 
> On a KASAN kernel with a 1 GiB mapping: before commit 333c515d1896
> ("vhost-net: allow configuring extended features"), the ioctl does not
> exist and the call fails with EPERM at once. After that commit, it
> fails with EFAULT after 26.0 s. With this patch, it fails with E2BIG at
> once. A reproducer is available on request.
> 
> This patch will reject counts above one page of words (512 on a 4 KiB
> page, or 32768 feature bits; 128 are defined today) before the walk
> starts.
> 
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Cc: stable@vger.kernel.org # v6.17+
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> I found this while comparing the behavior of different kernel versions.
> I used an LLM to analyze the problem and to draft the patch and this
> message, and I analyzed the result myself.
> 
> Tested on the vhost tree at 44293796526f with KASAN and lockdep: counts
> of 0, 2, 3 and 512 words still succeed, a nonzero word above the
> supported ones still gives EOPNOTSUPP, and VHOST_GET_FEATURES_ARRAY is
> unchanged.
>  drivers/vhost/net.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 631855064b3d..22e06b44d2ed 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1795,6 +1795,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  	case VHOST_SET_FEATURES_ARRAY:
>  		if (copy_from_user(&count, featurep, sizeof(count)))
>  			return -EFAULT;
> +		if (count > PAGE_SIZE / sizeof(u64))
> +			return -E2BIG;
>  
>  		virtio_features_zero(all_features);
>  		argp += sizeof(u64);

????
this is followed by:

                virtio_features_zero(all_features);
                argp += sizeof(u64);
                copied = min(count, (u64)VIRTIO_FEATURES_U64S);
                if (copy_from_user(all_features, argp, copied * sizeof(u64)))
                        return -EFAULT;

copies at most 8 bytes.


did you test that this patch actually helps anything?


> base-commit: 44293796526f4343639f87b2acc53811c78b5d54
> -- 
> 2.53.0

