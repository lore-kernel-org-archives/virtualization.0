Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321823ABA9
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596488; cv=none; b=Ivh2s0G7wFBFV5FCOIZVC/PtmyG6mBJIUq6oE2iLif+B3CIldU5XGkVIRnAamM/vrC3P9l2VM4WyArh9ndA980ICcKGuek5cs1g8WHwV9wC6rYKkgzC+I9RDV+9k4ftRli6hBKv2BrOSbAlmnB3nYHTH3yv8/WD8/uDSZQxnTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596488; c=relaxed/simple;
	bh=DIMHnVfDXB1z87w9DSCt0QqFUkafjlD58pI3jDxUdKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pqmjmQKUN+zG1q+P9s9AqWp3TZKnNcT0xzFSvFYpNDDuwL2aZSAdCWyHX0WI2moAqkdoYyXazev24j/+B++ZmvazYl+sk2mmejUSQutvBr3KnYuVFBSJPtVg0Pb0dKMXhcHMjmsOqYRwtEzeJVuAE/aDs5QPqlt7pUX68hGOgBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVl8HRJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVl8HRJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769596485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6ko7Ld3Ll9plNmeAWA79rDhRWMcWQUQkhGqrz2ITcY=;
	b=OVl8HRJ1jA0FhqGDVp4liZK5fdp7LooO4uhumCU18hbIh3+3nZ5wY5tOsly0TSd3GKq88n
	BDDZ5kPJPOgJ269Ck0/LsaXQA5im7MgYMrAjlShv/LHnhiqNuXOkPfS5ZaoHOS2nayiWGq
	xVqoKcyHWs+4itKpHz1xhTAuhUHTegg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-JU2Da4QaOwyBXc033LZhlg-1; Wed, 28 Jan 2026 05:34:44 -0500
X-MC-Unique: JU2Da4QaOwyBXc033LZhlg-1
X-Mimecast-MFC-AGG-ID: JU2Da4QaOwyBXc033LZhlg_1769596483
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801e3aab32so32973505e9.3
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 02:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596483; x=1770201283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6ko7Ld3Ll9plNmeAWA79rDhRWMcWQUQkhGqrz2ITcY=;
        b=Zw+vUoNaO+En7UVM2vwxsTpTDrMH7U2xqNTf9AcasyL3qUJctmqpUEQ1UAeA0h5kDV
         t9gcC3wO6yC/KhM3wqLLBpaUxcPEnBcwqzOdqlXMa3LnsKcBiaAkKCXHVzgiO/i4WfjL
         fex7Ff33v+WsFwc2dgbpK1jpMBckoBFaSY5tAdjAoou2oCH2gurNenjfrVLMoBTv6KZu
         0na8OsRgjasPBQT9nlNSAAhd5NuAeV7CvXdTvwRFoEssrofFjnNfILhW/BZfjm9RgyA2
         mji0hHPucr4ihB94tzXsshQUa5aO5A9TFr9rFpnUCkyFQC8JdIBQdIsOjoJvr04Te8xs
         Forg==
X-Forwarded-Encrypted: i=1; AJvYcCUxebfk3idghqjduuyWTlmEE5OqKWYopBZUb+5g7wNL/2UHWT8DmA6GiAOp/H1Anr3VHSKGV64MCBrNJF3Zaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq7bypVs36+ciijzq5GkU+8s0Crr38QuAIFyIB5tHvld/uBQzf
	DnPzytvWilhuMfw9kFgWtQ0Kv/fZeBSyrg0btg9uA/02XNxhCp9dk0N3gW9ZVS2EbqOLoVn3avJ
	WOvZg3scStJOFA45WGP5ZH7emNFEr2z/TmsOSuCKInnQpj1qiUWKmlY/em4JZ9M6irMkMTqXqkb
	mZ
X-Gm-Gg: AZuq6aKJzDvfIg4qAtFW5pWk0ywclJhyOG96s/8LHHMLCGo/Xee5hM5EDLJJEehp79a
	1pgVqgHcHaTEMDjgwxkYMUJTs+Vtk3V0b1AWpJ2N+b9D3EO0qI3bZMVrUpZkaBGB5rLaqJWnoF/
	kaP/YhAipxoaY9xQyTThrqnzHkW9kJgLkQP9Ooo9YVbjebfTas4ciCgmzC43tUCh4VHaShKIdx5
	xJDIjC+Z2O5HUqws71H1khYjrkBJ0fX1QjM50lc2ovhS9yKcXq2fuIKGw5FKVFCuYKFrpQD+5KK
	tlA0i9ayPE1hVBL+rjV0td4ShMLGJ8esBtqrnSLppX/QcyE41r3EPyQhNdga+J4jYVpFFxB9rqI
	9QDkYpokczQANHjeaN/UpF+1UXBJqaH1WbA==
X-Received: by 2002:a05:600c:8b63:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-48069c5fad8mr69793925e9.31.1769596482792;
        Wed, 28 Jan 2026 02:34:42 -0800 (PST)
X-Received: by 2002:a05:600c:8b63:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-48069c5fad8mr69793595e9.31.1769596482380;
        Wed, 28 Jan 2026 02:34:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806e0f6dacsm18275365e9.0.2026.01.28.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:34:41 -0800 (PST)
Date: Wed, 28 Jan 2026 05:34:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
Message-ID: <20260128053356-mutt-send-email-mst@kernel.org>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
 <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
 <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
 <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
 <9004e3b6-fbd0-42a8-b722-bf6d25833dd7@wdc.com>
 <87ee6ad5-7c58-4e40-92fe-57305ce2b00a@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87ee6ad5-7c58-4e40-92fe-57305ce2b00a@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vGmrGi9KAZc093-lTiZsEScSvU6KOu3DH-Ph-KaQk6s_1769596483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 11:30:20AM +0100, Alexander Graf wrote:
> 
> On 28.01.26 10:13, Johannes Thumshirn wrote:
> > On 1/28/26 10:03 AM, Alexander Graf wrote:
> > > On 28.01.26 09:47, Johannes Thumshirn wrote:
> > > > On 1/27/26 5:30 PM, Alexander Graf wrote:
> > > > > This patches the split vring format, but does not touch the packed one.
> > > > > What happens if you run the same test with the packed format? You can do
> > > > > so by passing "packed=on" as argument to your -device parameter.
> > > > This opened up a whole new can of worms... :(
> > > That's what I expected :).
> > > 
> > > How do other DMA based devices handle this? Is the real problem that
> > > virtio by default does not use the DMA API and so it confuses generic
> > > KCSAN logic that would otherwise track DMA regions as "can be modified
> > > by DMA at any time"?
> > > 
> > > If that is the case, maybe what we really want is to force enable use of
> > > the DMA API when KCSAN is active. Does something like the (whitespace
> > > broken) patch below work?
> > > 
> > > Alex
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index ddab68959671..b1dd790ce622 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -284,6 +284,13 @@ static bool vring_use_map_api(const struct
> > > virtio_device *vdev)
> > >         if (xen_domain())
> > >             return true;
> > > 
> > > +    /*
> > > +     * KCSAN needs to track who can modify memory. DMA API gets
> > > +     * us that, so always use it.
> > > +     */
> > > +    if (IS_ENABLED(CONFIG_KCSAN))
> > > +        return true;
> > > +
> > >         return false;
> > >     }
> > 
> > Unfortunately this doesn't get us any further (I'd love though, it looks
> > way cleaner!)
> > 
> > I still see the KCSAN messages even on boot.
> 
> 
> Ah, looks like the important bit for KCSAN is not the mapping mechanism,
> it's the actual compiler annotation for the read. So these virtio ring reads
> should all be annotated as READ_ONCE() to make sure KCSAN knows the read
> itself is atomic.
> 
> Alex
> 

so then:

       return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
                       READ_ONCE(vq->split.vring.used->idx));


?




> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

