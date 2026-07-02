Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2273033F8
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965020; cv=none; b=Gf70Qb85L9RvMoFAnLvaTgmObI6O461A7ymRhnDPROptecCYoiwStYCcrrP+3zqlRnwfGjPk1Zjk6beaItyjk5PbO29DwbgpNv7YobxJyr49KiBuh+wPnUiMJvv9/wsMxijAIrJn/GP2jkEeYXpEtSc6WC5eEZVil4DoAtl3/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965020; c=relaxed/simple;
	bh=Tkvv/zdSmt+g6XEEVdG2makQ5P51TMRJmaRm1Qrs2EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j+EjoaM2I9+TJYjduqRJTrcx1frRNPl9lob7nzFjJpxtvtjo8JKGUSIZcASQKlu6PTzN3j3pOh5fmYHmV2vqvVYATk0KED+G0oEIaK8gsWVAljStOkAmt/4z9aABAluGIWblFDBqcFtTvZlXS5d/i2SdUWQCQKr+a0o3+uQjjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cL811s0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL811s0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782965017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kuaTEjeYBWxwOkgYoO9Z5VTdSu33mHKEAQ6hsmDBY08=;
	b=cL811s0FmW1iHDS93q1EbLuGFO+dRcNPA1e0NqrNRBNaDbLZuOnAAG8GDQE6Mzc7MkeFxt
	Es8Vn0q30xWL2S0OFrLO7dAyskQT9S5Q8D3tBEGkfpB9hZ2+V+NXv4e6PJAo1U6wXwBjv9
	KnZ3OI5nZYp8ClHUcfXJAf1lBrzCsz4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-L7F6K1z4Pbm4R3zhIoz1ZA-1; Thu, 02 Jul 2026 00:03:35 -0400
X-MC-Unique: L7F6K1z4Pbm4R3zhIoz1ZA-1
X-Mimecast-MFC-AGG-ID: L7F6K1z4Pbm4R3zhIoz1ZA_1782965015
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493c526df6bso2967585e9.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 21:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782965014; x=1783569814;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuaTEjeYBWxwOkgYoO9Z5VTdSu33mHKEAQ6hsmDBY08=;
        b=NKeAluEo1X/9b65vSMsawhH5bwae3E/Ex0Lp6Nyw147uQ6m18y+WaJLCeHThZvKCTg
         0H2zIubX67bii2j8YIp5HtqfFKAPF29VwFOwKn+43CqtkuG3ONJPZRW/WX2JBD2o3zSE
         A8jl4m5PzCPh5iRTjlqOBBBkBHixQe4Z7LUsnIbl6pOP/i0SACGGcsx+Q4QzJhmz3x2/
         Lct1TSGHQSDE8JOIXhp+reWrlRUKzs6zOA5BuO/TQd2f8l2kG/bt63lyJj45yDcOYsU6
         S5iEw0ihi1lTzwMm3KBa5GPGHNnAQddI1/qr0VIdaCpq4LurVXpHqR/R7lLS24E/3rUt
         3y8w==
X-Forwarded-Encrypted: i=1; AFNElJ+JMEJ3megAwxNjikjOlPtFBHBe/i79u9j10eTBdAMvikmBqpFNi2SVHSOmGpde9bs+njMVwCRmo8DFvZr7Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwESipi2dIwh+XDgSDktwzGcJvD3t1Fl9nPDcma7jcknbxhHiv5
	DpKHgFRAV1q+Ki74ze+iVfeT6ZsQXADsNVoApSuzlW2EwGx7jRXaJnNHulCGuIKALfEXIDaAIzI
	4m36Ca6xgDKtEPnknCf7DjFHhAwnC4pNxDIwNbE5PrQKTy7iMKiZDKK8mPmG7Q7I/tXjW
X-Gm-Gg: AfdE7cl9E42iU/gIxjzgDeH5SeQwIeoBzI7tvLYldcQWIIDLLG/C8zSoSpniSIyfl6C
	ILeiv3j0Meqql2KDGS6kRMCMNed7dGRD+1IZpAIxTFaeToH2ae9uJix3Yxl0q+ICOY+i+TUMVX9
	bFUbJnpuWt4wW4Aj7PNPaLshxzacPit0QJqVeJv6L/CoD5OTpdROCiibXNgZcCnROwelrMaH1yI
	bJXmjMwEsKskk+Z1qkkopZEXjBe3UTpuGW3T30uw9QTt9V2GepuJcZaENyS8gJ8mqghFOWRGx/N
	bbN+kCu+oJiBslgmnoYTHKIMHAHahjBnQmXF6MT7iB2AYmMp13k0XRervbqb9TbtveG0gObGMtx
	sm0N8Ay8so1oRgsa+OCPjIU0BdzzvG7FN
X-Received: by 2002:a05:600c:60a:b0:492:68bc:3237 with SMTP id 5b1f17b1804b1-493c3cf8cc5mr31230655e9.32.1782965014443;
        Wed, 01 Jul 2026 21:03:34 -0700 (PDT)
X-Received: by 2002:a05:600c:60a:b0:492:68bc:3237 with SMTP id 5b1f17b1804b1-493c3cf8cc5mr31230455e9.32.1782965013999;
        Wed, 01 Jul 2026 21:03:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63b6f8csm11868245e9.11.2026.07.01.21.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:03:32 -0700 (PDT)
Date: Thu, 2 Jul 2026 00:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: Sergio Lopez <slp@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
Message-ID: <20260702000144-mutt-send-email-mst@kernel.org>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com>
 <akT1XEW766c7Imst@mbp.qyliss.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <akT1XEW766c7Imst@mbp.qyliss.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e0xQKJVbAfwX6nfR_gO82YilN3RSYHCCKsJlt-I6iIc_1782965015
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 01:10:30PM +0200, Alyssa Ross wrote:
> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
> > If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
> > aligned to blob_alignment. Validate this in verify_blob() so that
> > invalid requests are rejected early.
> >
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> 
> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
> crosvm bug, so hopefully it can be taken care of there.
> 
> https://issuetracker.google.com/issues/529852979

Move fast and beak things, then it takes a wile to fix them)
Do you understand who uses it maybe? Maybe if there's a PR
for both sides it will be handled faster.

> > ---
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > index c33c057365f8..d0c4edf1eaf4 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
> >  	params->size = rc_blob->size;
> >  	params->blob = true;
> >  	params->blob_flags = rc_blob->blob_flags;
> > +
> > +	if (vgdev->has_blob_alignment &&
> > +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
> > +		return -EINVAL;
> > +
> >  	return 0;
> >  }
> >
> > --
> > 2.53.0
> >


