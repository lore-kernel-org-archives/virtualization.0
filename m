Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F59351C27
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323309; cv=none; b=r/P6q1VXVBEza8TwHstKDN1Aku7tnE+VYVOVn0dwpPopmzSwbC7oYruvSv/xSOxxzZkOBFXtl2YNg03BV1TwWP0aa0F2yOWm65y2m85fbd/dHnndTRGVtGepufopGCOOmoVdx5SDTGCjZ2Bmml6fCZ5tBiMu8woYBPDTI43xZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323309; c=relaxed/simple;
	bh=hGyOVcucJQ+6emh9f4kMcpR+qKcT8eW/N7Sl3bHKnnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XKsSkOV6lmBEhNTVy011Dxsv5DLoe44eDeya5cAIpt1v9yMh9nbcsN8le8kQA8fBGqD0ue5QDtYJIn2ZhAgG4w6ZXeGJztrbMKy0ajdtMUpTPogC446g4lTPd37jEqqVmdjMmLnAoia3yXVtpvD/pnLMDO1XGW+/6qLEuiVV7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ae0zuOn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae0zuOn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAjqsvp3FTb2qvy1Zip4J9H1NlgvRXsWkj7RxsCfbGM=;
	b=Ae0zuOn9X6HS1VP/RB8PgmKLxb49FgBQlirbh3QfEqs2BIPUuzpHQI4zAVRl5kQLvawuR1
	rpOfdK5s6y/CE99e4vqDudDFu8YTKCL6/Aydq30H53EoZ5qzD3MwL16A4WpkI3lshMjAv+
	hpJunzZtqFWxOfPrXL9AQ1NO6sJ/D4U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-FAobjM_VMA-lIUK5MFhIhA-1; Thu, 12 Mar 2026 09:48:25 -0400
X-MC-Unique: FAobjM_VMA-lIUK5MFhIhA-1
X-Mimecast-MFC-AGG-ID: FAobjM_VMA-lIUK5MFhIhA_1773323302
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852ccff333so8212975e9.2
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323302; x=1773928102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAjqsvp3FTb2qvy1Zip4J9H1NlgvRXsWkj7RxsCfbGM=;
        b=klgtqBUAlPeNO/aZuQWIEtl4/jnzgJZRsIoqjvjRadLbVUC+TCdc2qP0hzo+o+eC+j
         vFwXoI523xtIGL8gwpVWpQ+r4M/xhLUHGBdJz+0hWnunGwe8PzQa0zyIrum3kEmZYvVY
         XnesSFuvUPJvMx/cv+QOjU3PYYRAV0F2Vj5t7f0f6FdSmab9CPJXs3XxW1wve0qNyZcS
         +1qkK7dHNoHzW5BtVPTkgxxbz8EqxN0C/Bx2VOJlML5S5jgnhuM9XrDDvildaczBDjiS
         ZKegCFv/SRiPljMf7P9BBB2VeR6ptujDqcPblnTN4Bj3TKVD/1LlAP338NSWv32++NWY
         Y7jg==
X-Forwarded-Encrypted: i=1; AJvYcCV/m37P2Oe9EpRIB3QvLsR7hRsDOyK9pSLO/0U2I4OlD+NCpr1SdGGfs1v7hcetlN7ZDKb63JvQFwm46NkwSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAMSKuW1hYWYNzq6AmeBegucZI578L14N1rJ17rzsjoZiEbSN4
	jRWJifYXsE4/gpppMqlhugLfPs3Ra7s3bESwweEv7/O2oUXWk/pDWQXHeErlwrsLtdRm7Q8fdJa
	6CqWJce+8rEdhD6ByXxYjukZaWb8TTCSmRD3erfm3h1IWyPPL/1ep9OIXvBt6glNeYwG4
X-Gm-Gg: ATEYQzzqr9Rmemwk8cwZ68gS4WtF3ENWiSnRHu2V0xAxxTN9AsM0Y94w/KEm07OO6om
	sU7KQ0tgvbF9RGDNrXHm4P1p34VBc1FaSdJhOqQo2n2sc0BMXDaGCad7Xd/4X9K2sNceWXt0qGM
	IFulEPifxuzpSh9zhp9EmvlWQjcF+iE1yNuJJbWR2LEcTXILCo4FL5yzGJLsJ8WHtNe0muWQ6dM
	pLYaRJK3ffKnlop9BnYQ2usmDibThwABlHbY2JAlDoeiL1hWmuZhhSIPfly/HnQ5lOh63rpmNUL
	SZ71eUktwomQapjDuDpoFLGtrOxt23pf5oTpN9b7fmSmtwU0DqfgVoZsctnCKBAdLT+w3B4N6gz
	hyt8u8pXU7MQUNE0TRWM/ky8Tove+iJX26PCAtBrtTEJJ5g==
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4854b111768mr107604855e9.27.1773323301779;
        Thu, 12 Mar 2026 06:48:21 -0700 (PDT)
X-Received: by 2002:a05:600c:46d3:b0:485:35ba:1d8a with SMTP id 5b1f17b1804b1-4854b111768mr107604245e9.27.1773323301167;
        Thu, 12 Mar 2026 06:48:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm326209285e9.11.2026.03.12.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:48:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:48:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
Message-ID: <20260312094447-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
 <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lkON0-fEnYAymus4eUpEo-wlGzIRpydzjTaS1_JG5Zk_1773323302
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Mar 12, 2026 at 02:17:16PM +0100, Eric Dumazet wrote:
> On Thu, Mar 12, 2026 at 2:06 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > This patch moves the check for available free space for a new entry into
> > a separate function. As a result, __ptr_ring_produce() remains logically
> > unchanged, while the new helper allows callers to determine in advance
> > whether subsequent __ptr_ring_produce() calls will succeed. This
> > information can, for example, be used to temporarily stop producing until
> > __ptr_ring_peek() indicates that space is available again.
> >
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  include/linux/ptr_ring.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > index 534531807d95..a5a3fa4916d3 100644
> > --- a/include/linux/ptr_ring.h
> > +++ b/include/linux/ptr_ring.h
> > @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
> >         return ret;
> >  }
> >
> > +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> > +{
> > +       if (unlikely(!r->size) || r->queue[r->producer])
> 
> I think this should be
> 
>        if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
> 
> And of course:
> 
> @@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
>  static inline bool __ptr_ring_empty(struct ptr_ring *r)
>  {
>         if (likely(r->size))
> -               return !r->queue[READ_ONCE(r->consumer_head)];
> +               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
>         return true;
>  }


I don't understand why it's necessary. consumer_head etc are
all lock protected.

queue itself is not but we are only checking it for NULL -
it is fine if compiler reads it in many chunks and not all
at once.

> @@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
> ptr_ring *r, int consumer_head)
>          * besides the first one until we write out all entries.
>          */
>         while (likely(head > r->consumer_tail))
> -               r->queue[--head] = NULL;
> +               WRITE_ONCE(r->queue[--head], NULL);
> 
>         r->consumer_tail = consumer_head;
>  }
> 
> 
> Presumably we should fix this in net tree first.


Maybe this one yes but I am not sure at all - KCSAN is happy.


-- 
MST

