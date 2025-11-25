Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41C21FF5F
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091143; cv=none; b=QzIWMhmRsa0bsqYjW+qAQvfWKIk5/AvEMWjTrP0jCpykcUI3FYmvpmnoevPKMjCz/1BTF+8TWw/4EnYuXA5RmPkC4jyFPh+LZFSMMa6ahBdJ6z1CVnd3VTYROeWo81joYyebCXbbtFYCh4UK2HPKKqacHYWsPjEuzvuc/BPEHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091143; c=relaxed/simple;
	bh=ZPhuaik0VAApbpX38pTQnqYDsCZCeVuWDwCiA5Naac0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J+gvubToVM11yxhazEU9nc0/qWPQIeqiJaZsiJsQT02oXOSuKVJMluZqy8nqxbvQXrfjRFY/895MoMtdQyKbR27xxLcBH7jbt7/EZu/ywHx/P/Z9STFjfjNpFIBxVYg4m6fehkXyJ7FycdS4km04MxFFKV6iqZyG/dTgaOP2xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhLHZvb7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhLHZvb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764091139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTDXgrG1WH/0PGWngFbUewy7r2hDyrl7ob2LIaTylyw=;
	b=BhLHZvb7jOeixfrtVhmtDrcjLP9ebr2NrniJVF0R3Co9O+A/ERgZHCt3WKqbrxjB4ObXA3
	3hgV+Z9B+nm4BdUe7cjsYe2CiRr/MUgw2n+1gWMzn2VFjReb7qo3JtR7FpO4IXTr/Q/CbB
	buU+kJlhvO0mdGqHZTlZ6FExeoCqg/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6bnwG-DXN4CmN-LWPhHljQ-1; Tue, 25 Nov 2025 12:18:58 -0500
X-MC-Unique: 6bnwG-DXN4CmN-LWPhHljQ-1
X-Mimecast-MFC-AGG-ID: 6bnwG-DXN4CmN-LWPhHljQ_1764091136
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3155274eso2603898f8f.0
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 09:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764091135; x=1764695935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTDXgrG1WH/0PGWngFbUewy7r2hDyrl7ob2LIaTylyw=;
        b=c7HoAcfF7DW1nDusS15ylroxcXGdU2YIPko2sS8Q4fKcmsrbqhNP6sVB6KSl6rObSh
         7e2CkWYjjRsy4lfDjCn2SqDPrONxmvuYOmwTbKY/rfft4MXBrVkPi78BcRKBKbjuELhn
         +TLhPahdB+95zNR2+xGUExfAA+dTlT2mmZ2sOdYbDMr75zaCixwvOFbGhd9NY91JV7qO
         1Pi1l/5VQGD70XaO612e+jr0puLPj+u5ZmB3gTHjXddm4cdAdBh+qUVxEaswdANh7NVS
         m006u7xmD4+1Xg9EqVcso8ingBEVNFkKv2yU5ujbnTG4WiBz9L/rCGR49LpQDhcgHd0V
         nU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXdyowg3NXJFwUaCb7jmbUFVm0GSE90C2wdbxHf0O3VyecjikNfb9PBfVDeGCyIy1or6tjgS59pJDI+I8ajkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE1Vhz9ltcmM74RUuccySLip2npvslQb6Jk4cwo7I5tD05ZQQD
	pUsKO4KWv/j0uB5CpXq6RxnFTjlRhZfGVtsOC6LfLu0UdYy3HV29JXTxkIXVJQzyot9c0370oKq
	4YI0A0btw3LrYSC7lOL+Pv3SRNF+3StqG9x3yt5CuyB0ngsMtz38+sPnrm3lsmrT+WHQW
X-Gm-Gg: ASbGncvOV5QjXArSI41SRmPx83Kn6Coc8+JbyV2W7o5k5ttOBhXE7nj6PI5HeXf6nuf
	LeiFsiiURWDSMGvWjpCP80N3IRHOKHuZgS/x9FblmYZ1Tazw3yy0OlvTgmKDaOXIjGboK1yHW1H
	o69Exk870p1mbxNecxYWUOWjndaQmJgZlOWp590EKiZRDht7XlDxxJjyKSTzwjgyXODnWySY/7x
	c6RQrT3o+eYbJwnb7xucBWbJ2ZGsbOPu2V0TxmUXXL6oFVzShttBbCp3HzzAKmecJSZPQLe162d
	ORiheOG4BY11CpAD7AWfxcD0wIwDl3GPS93Ia8M20V0R6MM5T3HilLkhc27f2DU414ZDBy+xvbv
	/7/4suBAV553XNI4=
X-Received: by 2002:a05:6000:1863:b0:42b:4267:83c2 with SMTP id ffacd0b85a97d-42cc1cbd18dmr16972093f8f.16.1764091135222;
        Tue, 25 Nov 2025 09:18:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDwBcpmQPbHfHTQwxxY5Q+qsOpgYiD3CvZ3WNNO7Ii75RTIrUMAIH9/jzA1J2eiQuQn7dHrw==
X-Received: by 2002:a05:6000:1863:b0:42b:4267:83c2 with SMTP id ffacd0b85a97d-42cc1cbd18dmr16972058f8f.16.1764091134693;
        Tue, 25 Nov 2025 09:18:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm34039004f8f.21.2025.11.25.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:18:54 -0800 (PST)
Date: Tue, 25 Nov 2025 12:18:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 2/8] ptr_ring: add helper to check if consume
 created space
Message-ID: <20251125120122-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
 <20251125095650-mutt-send-email-mst@kernel.org>
 <ce371d19-e69a-4d8e-a9a0-f3e20439a094@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ce371d19-e69a-4d8e-a9a0-f3e20439a094@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0dc00zN7Va_YHM2uCwFl4A7IA1mht9KEP76h3iskenA_1764091136
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 05:12:35PM +0100, Simon Schippers wrote:
> On 11/25/25 16:01, Michael S. Tsirkin wrote:
> > On Thu, Nov 20, 2025 at 04:29:07PM +0100, Simon Schippers wrote:
> >> Add __ptr_ring_consume_created_space() to check whether the previous
> >> __ptr_ring_consume() call successfully consumed an element and created
> >> space in the ring buffer. This enables callers to conditionally notify
> >> producers when space becomes available.
> >>
> >> The function is only valid immediately after a single consume operation
> >> and should not be used after calling __ptr_ring_consume_batched().
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Co-developed by: Jon Kohler <jon@nutanix.com>
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  include/linux/ptr_ring.h | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> >> index da141cc8b075..76d6840b45a3 100644
> >> --- a/include/linux/ptr_ring.h
> >> +++ b/include/linux/ptr_ring.h
> >> @@ -453,6 +453,23 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
> >>  	return ret;
> >>  }
> >>  
> >> +/*
> >> + * Check if the previous consume operation created space
> > 
> > space?
> > 
> > what does this mean?
> > 
> >> + *
> >> + * Returns true if the last call to __ptr_ring_consume() has created
> >> + * space in the ring buffer (i.e., an element was consumed).
> >> + *
> >> + * Note: This function is only valid immediately after a single call to
> >> + * __ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
> >> + * been made, this check must be performed after each call individually.
> >> + * Likewise, do not use this function after calling
> >> + * __ptr_ring_consume_batched().
> > 
> > API-wise, it is a really weird function.  So is 
> > 
> > {
> > 	p = __ptr_ring_consume
> > 
> > 	return !!p
> > }
> > 
> > guaranteed to be equivalent to 
> > 
> > {
> > 	p = __ptr_ring_consume
> > 
> > 	return !!__ptr_ring_consume_created_space
> > }
> 
> I am a bit confused. You were the one recommending this function to me,
> see [1].
> 
> Maybe the comments need rework here, but the function should be fine.
> 
> Thanks
> 
> [1] Link: https://lore.kernel.org/netdev/20250922221553.47802-1-simon.schippers@tu-dortmund.de/T/#mb722e8ae4ceb5df24f74305c6145561883d4e987


I see, (an element was consumed) part confused, instead of clarifying.
That is not the question - it was consumed.



Let me try:

Returns true if the last call to __ptr_ring_consume() has created
space in the ring buffer (i.e., a new element can be produced).


Note: Because of batching, a successful call to __ptr_ring_consume
does not guarantee that the next call to __ptr_ring_produce
will succeed.

Note2: This function is only valid immediately after a single call to
__ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
been made, and you want to know whether any of them created space,
it is not enough to call this after the last __ptr_ring_consume -
instead, this check must be performed after each call individually.
Likewise, do not use this function after calling
__ptr_ring_consume_batched().




> > 
> > 
> > 
> >> + */
> >> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r)
> >> +{
> >> +	return r->consumer_tail >= r->consumer_head;
> >> +}
> >> +
> >>  /* Cast to structure type and call a function without discarding from FIFO.
> >>   * Function must return a value.
> >>   * Callers must take consumer_lock.
> >> -- 
> >> 2.43.0
> > 

