Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24820B34
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085788; cv=none; b=NMi9dpq2t2u30mm96t3zbIrRHbT8XzAVFwFoQ4rvhDbnQQo2LZKlxqpP5UzU8MU8CTittvPPH9swWs5NqgQhDZRiknEzvFfsjAiwEvGwhSy+nNFMOU7hIUJHqyiNfXtW7fl+X2f2PHghfWkdVMW85sx3o50zpkOyKOxrG9OWKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085788; c=relaxed/simple;
	bh=mx81azu7WGqDtDaPoKpPXOlm5ztzVujTkyngWrhVR+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tca2uBctxMd1y7Fk/pcFO4NUh56emMjWLj+WoN58plyZdEWaow850ughBvBxO7Ave9Npat7S3mI70R0pwwvhMWjupWHCevoJwkykltBOfDes/2PlIPkUC3HR3tTPyDQsSNlVrdJrEub+BoeL23OBYaAOzHpmmKmHM2CG1smM3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTDvmFLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTDvmFLu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713085785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDn9p0oKJIowoxHQ+QZq8N5Xvgpd2J6FJtOvcnaAQTg=;
	b=cTDvmFLucsv6BAwvVTWGcaWjPl7jBhSdEmsipvS2uuXlIf5lYiHgBWwHQn8kQwdS3DUZLo
	SQkvspX7IXon7VqjeWXnL5pnImbG6VzQReMQY+IBpiHBe39OzwHNZyr0jzc0vwThgr5yf9
	MTw+tbfvH/1ZYV27eOfeMcnrmiFOgGA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-bvhSA0JMPSmYXrhTmse_zw-1; Sun, 14 Apr 2024 05:09:43 -0400
X-MC-Unique: bvhSA0JMPSmYXrhTmse_zw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d86005189eso18297671fa.1
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 02:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713085782; x=1713690582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDn9p0oKJIowoxHQ+QZq8N5Xvgpd2J6FJtOvcnaAQTg=;
        b=B76zbxkrHV2roKNGn5ZsPVMhNskW/Og4dNe6GH28RQ8XVTC953I/b6MA1X+voJBz0N
         xVjfkK50TLRBTdTX/a/Exo3s2WEgctvhySRzj3nGCQZhekBxRzedNnig6WCm3CbHWBlq
         pHUlJdf+mn7iFWlVcgObHtTqPiSFxBJb6gmoK02BFR2VSHK/y1zGPHutvjXTDFkQMrkR
         QV+I4eb/LhH/kBRuVDO11ElPzX41tHCXq2MAqVR5KMaOWa4arMB37c9237LTUND0q3CW
         PpiicspxW362NsMr1hSjA+xOFqg0r2EFYrmRieducMhg5ZfrhSrFv9cpkyy57V8H2Oeq
         QX9A==
X-Forwarded-Encrypted: i=1; AJvYcCWD/jGQ8UdMYX2iz1/LRN2oH8CgEk2/OkWEOjO3s4n+Mrya7JDTzoeqsYoX1F3qgyDxjvFpM8xG9VgAo/e/Q3jMqcad3U8VsCfdNo8Kf1Q=
X-Gm-Message-State: AOJu0YxAztha5MFMnGtol/6kn8UQqx25aElddPHUQpr7zU/80f38UNaf
	AxqgPmtb3KEui59NDPjs46tJPSeipGSYmXcD1GHgJJfYPZF9G+93peWDAwXA3+qHgxBbToYLzU0
	f6kPdOAW2pPNk313uQoNA7vWK1jfz9zR64Xe2ELeLj5FB5xFfSr5ZGHb5izlAOmJ0
X-Received: by 2002:a2e:3509:0:b0:2d9:ecc1:6d56 with SMTP id z9-20020a2e3509000000b002d9ecc16d56mr4549907ljz.11.1713085782021;
        Sun, 14 Apr 2024 02:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnvXuyxDizZiI5lyVmq1CswBaXk7vrRoCt8wmpz3FQXQtnkzsP0CH3Qy864TeyyCiCUv5HDg==
X-Received: by 2002:a2e:3509:0:b0:2d9:ecc1:6d56 with SMTP id z9-20020a2e3509000000b002d9ecc16d56mr4549901ljz.11.1713085781463;
        Sun, 14 Apr 2024 02:09:41 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c4d0200b0041668053ca9sm10311768wmp.0.2024.04.14.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:09:40 -0700 (PDT)
Date: Sun, 14 Apr 2024 05:09:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240414050922-mutt-send-email-mst@kernel.org>
References: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
 <20240414043334-mutt-send-email-mst@kernel.org>
 <a7eceabf-12cb-41ff-8e2b-f3b21d789c17@wanadoo.fr>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a7eceabf-12cb-41ff-8e2b-f3b21d789c17@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Apr 14, 2024 at 10:59:06AM +0200, Christophe JAILLET wrote:
> Le 14/04/2024 à 10:35, Michael S. Tsirkin a écrit :
> > On Mon, Jan 15, 2024 at 09:35:50PM +0100, Christophe JAILLET wrote:
> > > ida_alloc() and ida_free() should be preferred to the deprecated
> > > ida_simple_get() and ida_simple_remove().
> > > 
> > > Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of
> > 
> > What's buInputt? But?
> 
> Yes, sorry. It is "but".
> 
> Let me know if I should send a v2, or if it can be fixed when it is applied.
> 
> CJ

Yes it's easier if you do. Thanks!

> > 
> > > ida_alloc_max() is inclusive. So a -1 has been added when needed.
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > 
> > Jason, wanna ack?
> > 
> > > ---
> > >   drivers/vhost/vdpa.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index bc4a51e4638b..849b9d2dd51f 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -1534,7 +1534,7 @@ static void vhost_vdpa_release_dev(struct device *device)
> > >   	struct vhost_vdpa *v =
> > >   	       container_of(device, struct vhost_vdpa, dev);
> > > -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
> > > +	ida_free(&vhost_vdpa_ida, v->minor);
> > >   	kfree(v->vqs);
> > >   	kfree(v);
> > >   }
> > > @@ -1557,8 +1557,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
> > >   	if (!v)
> > >   		return -ENOMEM;
> > > -	minor = ida_simple_get(&vhost_vdpa_ida, 0,
> > > -			       VHOST_VDPA_DEV_MAX, GFP_KERNEL);
> > > +	minor = ida_alloc_max(&vhost_vdpa_ida, VHOST_VDPA_DEV_MAX - 1,
> > > +			      GFP_KERNEL);
> > >   	if (minor < 0) {
> > >   		kfree(v);
> > >   		return minor;
> > > -- 
> > > 2.43.0
> > 
> > 
> > 

