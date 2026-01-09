Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217E2367CF
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943373; cv=none; b=L+CUkzb9E4UvJZrri3RB9tTzWQ244tnoXVFlYnNJPapuiBUS/LLtMXTuVSpFTCY9hUc3kN60RvuuZcFdFUVk0/Jsl4VMjQeQfkrdRS02np+ijgNzfeWVkMMFNeknYHMNygfF1i/+or268dwQXIgcdo8wh9lh6KhJrjvZCvczqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943373; c=relaxed/simple;
	bh=j1W235feRg0KN6FKcAZabBql8JsWIHtShwbmzD/a/pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o/5iM+tDn0Tsv97qxuewDrB46OFXJrxwS5pARZbiWZm9V4Z6LaY6t6nvSh1lDv/3frLt6yxCHmG8ngDJucBQ4Ctg83T1NSZp0DPlCmTI2+gxug2u8iDgs6DCiPsNpj+K87j6rAbOKre68CLotK0R5OPBoXRxxAK8HMvz8pK3xJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkTsScec; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkTsScec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767943371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCNBeC55dwFkYuH90UgwaJbtMoG2cmT0emKakpEw6rI=;
	b=HkTsScecNrU4rDOTOJh4+cCvnfs80CEvfyKuqFZqjojaXHbFZXNPSB4C7u1e5wLQgiYQrv
	Tm+xG6nJMaZp/VuJT/q8ZccWl/r/lhQu3Sx7i/pqUNQinebg2Rg3KJpkxlKIR96ZIH7AdT
	lT3Vlm/JoM9XyiwRuDlve9ZBIqOfJME=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-wF4Zv4g9NYCmo72_8wnXEA-1; Fri, 09 Jan 2026 02:22:49 -0500
X-MC-Unique: wF4Zv4g9NYCmo72_8wnXEA-1
X-Mimecast-MFC-AGG-ID: wF4Zv4g9NYCmo72_8wnXEA_1767943368
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f5dso34454315e9.2
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 23:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767943368; x=1768548168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCNBeC55dwFkYuH90UgwaJbtMoG2cmT0emKakpEw6rI=;
        b=fRdpTJMBbqZyjMCf1P6Gc3KMK4z+zl741c8H6cU5Mcu38yANzFTGKaBKAzg/YXfvO9
         Tyl4WY5xwsvTD2cbjIpGoXldiapvanAdpF5RvgDC7YokVPFcxr9fV2flEg/J/rpdiPxG
         rx/dB78I9RX3XgVNLwIo0zY1hAf0jJ5NCwRTmomuQPKvova/8XzPEEt+aLvPCRbXpHAp
         PzRjxwhHeMcihI/8hvPFs5LTMifWFdpvqZuJ6IfF0uPUXeskTIk9F8s3NpvRA5IT1whM
         v83rYl3BR9NTcNNvfsgG+OMf2Ie9s3W4WG1jX55TOdkMNne+1ILUtPFw+drGUB396Vvc
         zQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJXJhxzBjEOMuPn7kMq8V6nUYmQ1F86S7/SdNioSesC7m6iRByyahui/utlnZGezEHcdv4dYA9NiS2sTR4HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2hJxG5VE8+pbaeM8BRByZ48nBObMmbV5W/IqU4E3mrmustypf
	zBMs7TFKN4glQTPPc6ryY4PYq0MPJM6zMi7wXR6uEgL3yjAuFWrGwk3QuCqhPbQfhu1KJilf8OK
	tDbd2kygtyFj/ToZmbrbvvU/SFItng44ITfwzDnlxxAwBvYNk9etEe5bde1qGW4MZ6uap
X-Gm-Gg: AY/fxX5W6DOh0w47pKTRuLYSmHCuU3IywWIz1oX3nx5guUX43rynniYyu2JysbB5IZL
	922h61RMZeMGq8Sqww+TnKu6+EGyzkb6rsT17XOGFAiWsyEBZrrCXKx8IKFQoIVFv3mHP1Wt++4
	Ws9+OvvlFs1UGMPf5k1oLYlOcW8KXRN02MXy/9hRUD1titPML/owaEoErM4ytcJ/xzDanwqqqY3
	TsvGHtK/ptj6Xzk5nSzO5P/bIgdviAK0er0tPYHZu/vyoOHwedTwFe/RZPqGQVLlYOrT466a1dE
	Ydr1GHEnE9hVwhp8jjtxOoxCKf9pQqFyyH6egBLr5XHJO2hSZdqAHbt6EwdmlakkzEotilNQstY
	kIEbXUiS1Osau+CkkyvUze1aTH9BxOQrS6Q==
X-Received: by 2002:a05:6000:4201:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-432c3798349mr11114915f8f.41.1767943368367;
        Thu, 08 Jan 2026 23:22:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHdWMIJxf4esvBI4hULstTggLuOtGp39Tkn3cxYuG9NjEAkGwtcZDffJ90hcLBXgcBNIrf8w==
X-Received: by 2002:a05:6000:4201:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-432c3798349mr11114886f8f.41.1767943367815;
        Thu, 08 Jan 2026 23:22:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa84sm20705982f8f.2.2026.01.08.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 23:22:47 -0800 (PST)
Date: Fri, 9 Jan 2026 02:22:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 2/9] ptr_ring: add helper to detect newly
 freed space on consume
Message-ID: <20260109021023-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hkqj13nxgUEkePtGlK1pIEV8zUeTGkAcEluj8rHRMGM_1767943368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2026 at 10:04:41PM +0100, Simon Schippers wrote:
> This proposed function checks whether __ptr_ring_zero_tail() was invoked
> within the last n calls to __ptr_ring_consume(), which indicates that new
> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> the head - and no other function modifies either the head or the tail,
> aside from the wrap-around case described below - detecting such a
> movement is sufficient to detect the invocation of
> __ptr_ring_zero_tail().
> 
> The implementation detects this movement by checking whether the tail is
> at most n positions behind the head. If this condition holds, the shift
> of the tail to its current position must have occurred within the last n
> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() was
> invoked and that new free space was created.
> 
> This logic also correctly handles the wrap-around case in which
> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> to 0. Since this reset likewise moves the tail to the head, the same
> detection logic applies.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index a5a3fa4916d3..7cdae6d1d400 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  	return ret;
>  }
>  
> +/* Returns true if the consume of the last n elements has created space
> + * in the ring buffer (i.e., a new element can be produced).
> + *
> + * Note: Because of batching, a successful call to __ptr_ring_consume() /
> + * __ptr_ring_consume_batched() does not guarantee that the next call to
> + * __ptr_ring_produce() will succeed.


I think the issue is it does not say what is the actual guarantee.

Another issue is that the "Note" really should be more prominent,
it really is part of explaining what the functions does.

Hmm. Maybe we should tell it how many entries have been consumed and
get back an indication of how much space this created?

fundamentally
	 n - (r->consumer_head - r->consumer_tail)?


does the below sound good maybe?

/* Returns the amound of space (number of new elements that can be
 * produced) that calls to ptr_ring_consume created.
 *
 * Getting n entries from calls to ptr_ring_consume() /
 * ptr_ring_consume_batched() does *not* guarantee that the next n calls to
 * ptr_ring_produce() will succeed.
 *
 * Use this function after consuming n entries to get a hint about
 * how much space was actually created.





> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r,
> +						    int n)
> +{
> +	return r->consumer_head - r->consumer_tail < n;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FIFO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> -- 
> 2.43.0

