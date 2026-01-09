Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1123345724
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947529; cv=none; b=aHLeMYW1oZsDi2eCFRdtna4fialRXfv/GFWiBMArgjtX5X4TmTc5je1D1xzNaK8pOj+1cPwcTENvy5ptvSsRf8nKrJovvOtnCu/W24FoSmFr7RThl/1koA0kvLsux6frVFv32NgGaCgOklQNlgbiK8Wwj8db29bYUzZn/8DEEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947529; c=relaxed/simple;
	bh=TA0YXI5tFPQHixouJ2j1bQdmu7BczvrlyG+W06NZVPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DdNClcl2kMyiXmQpp+nJH+h5EJgxSymXNptfLEIM5cghqmnWqu5H0hFwCwocdpULAD5BjpSvc3+YCgy17ebbi9TSPEqPx+yB3gctTgxX2ipqSoi7QSmR8x9VLmOq50TCwNIvQ8RRXvYYM9m46k4jWhxrHmmORU/vOvl85EYEHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUhz144E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUhz144E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767947527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1ke4ac4E32fG4lShAnBll4if/X5IbvvKQ7SqmHrrYc=;
	b=iUhz144EKplqbvcS3X/uLiOeWVnMQFXLwr3qm6HtWImj9IfA5Yy31E0clNbBD7/Bsl9nG7
	2uV42RC+O8VSPLtBx7pnPmFd1+OJyVVUfq6vs8skb9yE7/RVjyH0FOal+1w3KamH4Q6k+V
	lu+bBJ7p4+I59+YzmAmSGyXdbyevfcU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-9W6Dj2XmNYaMLKsdcl5vvA-1; Fri, 09 Jan 2026 03:32:04 -0500
X-MC-Unique: 9W6Dj2XmNYaMLKsdcl5vvA-1
X-Mimecast-MFC-AGG-ID: 9W6Dj2XmNYaMLKsdcl5vvA_1767947523
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so41279035e9.0
        for <virtualization@lists.linux.dev>; Fri, 09 Jan 2026 00:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947523; x=1768552323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1ke4ac4E32fG4lShAnBll4if/X5IbvvKQ7SqmHrrYc=;
        b=DwwQ4RZXKFoJVd79lXGOaeUpg5xt0GEJW9GEDgKE9LyevOltEM8dQjZA4TZVEmCgvE
         f3yfBtiHbmuajDoqiMfRURuNomFz8Zut/lCmZiFAgyTtsh6pN3XHVTNnqQEdWFWir8pN
         63OnoDmrjTqUAaddwCmfp6PlBx2rJ2e9Ro6OVkNyyFOtsTQyPBJN5Yv0oZ6oQBIokf37
         zaJixGb6tL40S3ntKsvzGUn0kf1soK56koz8QNSH0DwvviB5wg88Pnya1yNW+hg89Gnb
         L14Av14ewI46P9c/feDHFM8cvob3SppS5VX+EPB9a4+Kcnir6y3MwrQBs4iyJu8M/6wb
         dBgg==
X-Forwarded-Encrypted: i=1; AJvYcCX4t849+aVGAuM+tJOYYfeWaViB9UX/SYS/4v1HpR9Awtqp/BfjX9wRsM+H0P/T0rnf6EJJquUNjkq2b+HkyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiNnTjqTuqw4iA1/wk1BvLYpIL3PYXrGYgmEHpMNx46ob4ie0H
	W9vCmHzjMvxwc57CD1T9KtXNeM8/kJ1pOtABEvbVYQjRCncDyBmJPHU2jTO8nrF+eyGnhwL41WK
	or2N1D+Dgfhx8Zqptp2HU1XZC6FPEfvNgrQa8LM6d/zdrQddXej0abfEy3nlHjcfikO3b
X-Gm-Gg: AY/fxX58sJr5vXG+7eKu0iMd90MJBlwIA852PhMXNT88JyBPMeBkDSF4noFKaiUMUhO
	y/kq3g+Pj3qPIF6HxUnTHzIhvJ6dWhvSClfNnSS1xQ/A4e85sBIfTYFPn0qoazXq8xNIgREWpw9
	aaK5bJ5F6b5DSObQ5MRCF0SHllnuMdwgCiJ3vyzRwuH+q8jT2Sc6BGpcB7Xb+G6F1jO/Huy2a8k
	eAWDUi32Y21mjxHoK/hhzrDmqadHCqYprEe17rZcQgd5vv/o0Mn0h/BPtDrdw7n6zCDqyATXIKP
	Ztm0Rs57IV/Wkerh0pBAgPBg/o+LbI0GvqPmHTAeu8j0cfw2pwa5qnmBVmdxKcHoxDfvRBQtKCI
	yrDs+knmSzmZYcIE4k5+CEclJSfp243my1g==
X-Received: by 2002:a05:600c:6306:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47d84b1a03fmr89448195e9.15.1767947523227;
        Fri, 09 Jan 2026 00:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6UfdcL14TZ2jcr19i9LHxmaSNAQniiujlbEAgU47kWYFzOBfa9T43hpeYeByL2mFARRYigA==
X-Received: by 2002:a05:600c:6306:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47d84b1a03fmr89447825e9.15.1767947522743;
        Fri, 09 Jan 2026 00:32:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm196961275e9.1.2026.01.09.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:32:02 -0800 (PST)
Date: Fri, 9 Jan 2026 03:31:59 -0500
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
Message-ID: <20260109033028-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-3-simon.schippers@tu-dortmund.de>
 <20260109021023-mutt-send-email-mst@kernel.org>
 <a0d5d875-9a9c-4bfe-8943-c7b28185c083@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a0d5d875-9a9c-4bfe-8943-c7b28185c083@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O1sohtyxn9C2Pg3ppb2YJr4F2kct46aQa8grwKDvGRs_1767947523
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 08:35:31AM +0100, Simon Schippers wrote:
> On 1/9/26 08:22, Michael S. Tsirkin wrote:
> > On Wed, Jan 07, 2026 at 10:04:41PM +0100, Simon Schippers wrote:
> >> This proposed function checks whether __ptr_ring_zero_tail() was invoked
> >> within the last n calls to __ptr_ring_consume(), which indicates that new
> >> free space was created. Since __ptr_ring_zero_tail() moves the tail to
> >> the head - and no other function modifies either the head or the tail,
> >> aside from the wrap-around case described below - detecting such a
> >> movement is sufficient to detect the invocation of
> >> __ptr_ring_zero_tail().
> >>
> >> The implementation detects this movement by checking whether the tail is
> >> at most n positions behind the head. If this condition holds, the shift
> >> of the tail to its current position must have occurred within the last n
> >> calls to __ptr_ring_consume(), indicating that __ptr_ring_zero_tail() was
> >> invoked and that new free space was created.
> >>
> >> This logic also correctly handles the wrap-around case in which
> >> __ptr_ring_zero_tail() is invoked and the head and the tail are reset
> >> to 0. Since this reset likewise moves the tail to the head, the same
> >> detection logic applies.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  include/linux/ptr_ring.h | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> >> index a5a3fa4916d3..7cdae6d1d400 100644
> >> --- a/include/linux/ptr_ring.h
> >> +++ b/include/linux/ptr_ring.h
> >> @@ -438,6 +438,19 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
> >>  	return ret;
> >>  }
> >>  
> >> +/* Returns true if the consume of the last n elements has created space
> >> + * in the ring buffer (i.e., a new element can be produced).
> >> + *
> >> + * Note: Because of batching, a successful call to __ptr_ring_consume() /
> >> + * __ptr_ring_consume_batched() does not guarantee that the next call to
> >> + * __ptr_ring_produce() will succeed.
> > 
> > 
> > I think the issue is it does not say what is the actual guarantee.
> > 
> > Another issue is that the "Note" really should be more prominent,
> > it really is part of explaining what the functions does.
> > 
> > Hmm. Maybe we should tell it how many entries have been consumed and
> > get back an indication of how much space this created?
> > 
> > fundamentally
> > 	 n - (r->consumer_head - r->consumer_tail)?
> 
> No, that is wrong from my POV.
> 
> It always creates the same amount of space which is the batch size or
> multiple batch sizes (or something less in the wrap-around case). That is
> of course only if __ptr_ring_zero_tail() was executed at least once,
> else it creates zero space.

exactly, and caller does not know, and now he wants to know so
we add an API for him to find out?

I feel the fact it's a binary (batch or 0) is an implementation
detail better hidden from user.



> > 
> > 
> > does the below sound good maybe?
> > 
> > /* Returns the amound of space (number of new elements that can be
> >  * produced) that calls to ptr_ring_consume created.
> >  *
> >  * Getting n entries from calls to ptr_ring_consume() /
> >  * ptr_ring_consume_batched() does *not* guarantee that the next n calls to
> >  * ptr_ring_produce() will succeed.
> >  *
> >  * Use this function after consuming n entries to get a hint about
> >  * how much space was actually created.
> > 
> > 
> > 
> > 
> > 
> >> + */
> >> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r,
> >> +						    int n)
> >> +{
> >> +	return r->consumer_head - r->consumer_tail < n;
> >> +}
> >> +
> >>  /* Cast to structure type and call a function without discarding from FIFO.
> >>   * Function must return a value.
> >>   * Callers must take consumer_lock.
> >> -- 
> >> 2.43.0
> > 

