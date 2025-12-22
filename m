Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9C3161A1
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392762; cv=none; b=CQNgay1i2FZNKDkEhmg5U4PVcoZeK8SGUnnS7f/VH76ijU2PGGAag2cvIGoI4HEojSkLo6dtIlrUup9B3QCIalNY3N/GBikqXIZKSB2e3ie/Rps54VVOPMVL6n/nbkdfQtEfTAgCYZsHb6wf9RaJWxCQmXIsSeySXtdMtqg2AgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392762; c=relaxed/simple;
	bh=auSg26CfZlSSNZjKfr7BRpVNy+ZYjFMpxMGU641YRCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cKSBLFA13uPfiZkQLfYZXHYkctt/cdDjomVzGO6wIsCs/2DmUCA6fTmRbyf3KwpcFvgV3JdQhvX2a7eYfNVjzUDkNQKBcXVj8bKkQ6W/u10i1velR2iIbdwwzqkjL8CtrOf7UQLh0SLcJy8dY1zeMpV9WaZk+wkwuEQ/RtwCf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Se2KeJ0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Se2KeJ0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766392759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8RM3/o6FB83AIG5gcDlEP7+b/8hOvjggWFz+DBBFz0=;
	b=Se2KeJ0KlEOMYkVHEcgNzY4ctmMDAkq5NQFnR6xxzIxlckdkfAczt1NaZRSUqEQwWg5lPh
	Y3Zhl5hIhuoVcxltbl5T9FCbIJMIhVxRFVX8Mbv7L8mrsfl6Pq0VtTjWz9m7c0++9VCaV+
	gWaugJxcdd8csCflEBh1yijcsS0p9fU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ofZN9poAOaSZH8f-zugfKw-1; Mon, 22 Dec 2025 03:39:17 -0500
X-MC-Unique: ofZN9poAOaSZH8f-zugfKw-1
X-Mimecast-MFC-AGG-ID: ofZN9poAOaSZH8f-zugfKw_1766392756
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso2029472f8f.2
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 00:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766392756; x=1766997556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8RM3/o6FB83AIG5gcDlEP7+b/8hOvjggWFz+DBBFz0=;
        b=XBAHAV8LtrP0jNKyN0j+u71a6/0yFcIfHpfDaTUxP8pntGRG6WPGt+iCWmY05pvw/b
         OM9m1tLJHxiRpAkVuooojgzVsWhXo3U5HTExzQZ9ndF+hypVZvVYUix4j9HtDhN/rTVw
         cXXOVcdT2ZVNQ80sG4w9jJCdtI23HPQeCJm2+tqYAta8dVpDRZNjEkLE0aE65Tdtsnlz
         wRPvfeXdVx0CxvvP/6waIeSUpPdpxtHL1hqD6g+8HlyTSh0VoWLMJmIlCCEDBnJoPhg/
         d1rA9w3Q8bOPYSPC2EiVuc8Aund+/PNHx+eMhOtsSaZ+oyMxKX98LBOJ2n0f9wlp+Hlb
         1YJw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQc93XncHIHY0HYuqoqtHSwR+i5YljiEI0fRlNsJH49lfqUOHAeKBaT3y855mTco0XgeK+/OdeBeozMVa/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJr60ywINCURSf8pP6QY4GktEfb/PSsGcZ8m9Lj/rN3iLlI47h
	R/rhM8dYF9ldp/t6yRnCIpzlyA++L2pKj2fx2a5YmE2SI4TD38RcjnKUyUck9pU2jyjPBnjw7tB
	IAl6UeWQMUwPkDlJCQyzEvc2m5K9cTFusKQP44mHWf16bG2uMhnRu/q/Z8ZXPpjds+kv/
X-Gm-Gg: AY/fxX5uC98XMH5JD1/MApGmFRpta5YRoaPVyMnmAd3iMSvTMzLYtobLaZHmmgliGta
	ei39SKzR+B2PcTeagwgTEJJxt/E14eHPfpp1fdfuaSJYTMW4juQA7f1juuUQCkJV1vaSqHLo2+w
	wFiAiICefuR6A1iJY4MUd9eQdPuPzRh00AWgB6200vnx6gOPoXWJg0inWq0T7C/os8dJZ/2dSH9
	PMMx0kKqXhNWM1jAoiuQdwLU00ehKjKM3NYmYhpfP8ShuMJ1UVTPW0ClMZfykUhkWcYleW1FZ58
	LFwhYk3b5HG3q2HgGpnWefUQ1c8EAt2F3ikkpONQMQ4WpNyUY1WFzuDMwZnN1wZaN9Enl7+GxpP
	NSTiFcdrr5IWV4lj/4a0PUlKHovMfcPdUkA==
X-Received: by 2002:a05:6000:2890:b0:431:808:2d60 with SMTP id ffacd0b85a97d-4324e4c23a1mr13773027f8f.12.1766392756247;
        Mon, 22 Dec 2025 00:39:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6FHBNL3fzb6KVVsr/bjJemsrbUHJXfzvwJ73EdVuGDT3KdKweVrjghaZ5OFlDaxm+wufJqg==
X-Received: by 2002:a05:6000:2890:b0:431:808:2d60 with SMTP id ffacd0b85a97d-4324e4c23a1mr13772986f8f.12.1766392755718;
        Mon, 22 Dec 2025 00:39:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm19528873f8f.2.2025.12.22.00.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 00:39:15 -0800 (PST)
Date: Mon, 22 Dec 2025 03:39:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Message-ID: <20251222033807-mutt-send-email-mst@kernel.org>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7_GBK8hplO1qN2e2ynCfL2qaF_l1GLYrUCDojUY_FRo_1766392756
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 22, 2025 at 09:00:33AM +0100, Thomas Weiﬂschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
> 
> On Linux 'unsigned long' works as a replacement for 'uintptr_t' and does
> not depend on libc.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>


are you fixing other uses of uintptr_t ?

> ---
>  include/uapi/linux/virtio_ring.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index f8c20d3de8da..3c478582a3c2 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -31,9 +31,6 @@
>   * SUCH DAMAGE.
>   *
>   * Copyright Rusty Russell IBM Corporation 2007. */
> -#ifndef __KERNEL__
> -#include <stdint.h>
> -#endif
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  
> @@ -202,7 +199,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  	vr->num = num;
>  	vr->desc = p;
>  	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> +	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
>  		+ align-1) & ~(align - 1));
>  }
>  
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-uapi-virtio-d208b915ca1d
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

