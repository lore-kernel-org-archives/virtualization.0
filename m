Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC222BAE2
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878086; cv=none; b=b9hgMTIqgMlGtYl3bOGal0CA03/I/2vLRCX0OcaF7XqeNlpGEz2ihHw29qiT1asceW8efm17uaEkMQNYrzCxm+9zc8ZfQoL6nPwxQWC1QxZz2dZqrZ3Rv9exl/wRgS+F5WmGvQ9BpIs9k+wP0Q9L4cmxqRZ9pyda9oZi6/L3hqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878086; c=relaxed/simple;
	bh=HGm0KaCx6Ocn89BBrxwTLQ1xEL4JSLMm6bIBgMNgJ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oFeAie90DSieGlmvaFLVUlGo8JewDHr+2gSBhczRrGBrf41/pdKfbiXnBj7sMre7Cl6vs389NR+hkWqx1c9mAOesvxsXt1zLqo9uePMz+zbUgKO2W2AsX5ZFrUobYu0Q9Ggj/2vLgSgsJZGyMiK2+fBcFLN17wJVrvexAF+vJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj1NtBgQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj1NtBgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OM+7J1opjcbTZ+C5oJ7KgbF91tiHQCONXrfeXXVf1Fw=;
	b=hj1NtBgQYn4phE8pfp5Jhb+NF3Q2cL7dDgI+O3V7cIMrx1Wm33/9Xgk5ziGrThgZ7bPR+S
	AvL/mirYEiySl/CYBn2m+iizLJdpEqRMtNHu2CAGT96XcdgConewtjANot7lxrOKF3rRXz
	1zeoYla6sJ8zoPuJjN1M7S3/52yPLYw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-wJR_0LgQNGiypkR_2SwEiw-1; Thu, 20 Jun 2024 06:08:02 -0400
X-MC-Unique: wJR_0LgQNGiypkR_2SwEiw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6f99aca0f8so26443866b.1
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 03:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878081; x=1719482881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM+7J1opjcbTZ+C5oJ7KgbF91tiHQCONXrfeXXVf1Fw=;
        b=Z0hzFYY5lSaFWEDfO3qSf9QtJLhYy9RWs3O8ZdflG1RKhxjTHsEIJEdy1rAh5NWlzq
         9StDdvk1Zy3qsHHibwUagqnPQdhT2gfxBL2WzAr+lV/vGV+m+NdMsqQuMZqjyX5fPtXu
         pg/bkKYGfyRkQNvrJXSYxwE+ifsGIPWLWplL4UJ4gTEF/KmO4R0FBGDZYbaFFOH4Aw22
         NkPk9cVZqXmctMI/MV36Ue8O/IdMHv49wDjIkVJ8TKN6hDLToExWEOyXEZxn2EU5Ziox
         CfHYTwtFKD+bowLR0bKV2DJLMvR2mHADZXJkk/Vngb9h42YsW+KdtjgIdRm9a5ZY95y8
         x27Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTiGwfD+Vsj8CiGJVVe04vssdoNy1Pqa3kdfKqN69KlfUfW8P8y/aGFmtB7ly0GNTUxSEiyBVsCLPQsz30mvRgo0fdqBIBPgSJGzwy+1o=
X-Gm-Message-State: AOJu0YyVcOdTg98Lf+vu+rVOAB2uOakZRn38SR8QrOfo4TMeRUsLbdCp
	Ju9Z7YK6JdfiAotgl4IeS4/X8DUPJIsQ7KzxwE5xWZja8T07OKS1ks8BDiRGLjr7Vsv08p3b/R7
	B550sIfZLDWKNk4VtBJCRBTyXs+jhtHj5kik+eLt1tPKfmPyUmcgP+KRw4W1XS4/NHE0FsKY/Fh
	8=
X-Received: by 2002:a17:906:1110:b0:a6f:33d6:2d49 with SMTP id a640c23a62f3a-a6fab778cd0mr300635966b.52.1718878080502;
        Thu, 20 Jun 2024 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3e8fcFZAghGeQWHpopPDQVv6dADSyyjOPeZThEN3Lgab4EApEF461j8jahg4x6lDxY+2dhg==
X-Received: by 2002:a17:906:1110:b0:a6f:33d6:2d49 with SMTP id a640c23a62f3a-a6fab778cd0mr300627066b.52.1718878078040;
        Thu, 20 Jun 2024 03:07:58 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c86esm749414366b.219.2024.06.20.03.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:07:57 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:07:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240620060522-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <20240620034602-mutt-send-email-mst@kernel.org>
 <1718876302.539031-8-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1718876302.539031-8-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 05:38:22PM +0800, Heng Qi wrote:
> On Thu, 20 Jun 2024 04:32:15 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >  
> > > > >  	/* Parameters for control virtqueue, if any */
> > > > >  	if (vi->has_cvq) {
> > > > > -		callbacks[total_vqs - 1] = NULL;
> > > > > +		callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > >  		names[total_vqs - 1] = "control";
> > > > >  	}
> > > > >  
> > > > 
> > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > this will cause irq sharing between VQs which will degrade
> > > > performance significantly.
> > > > 
> > > > So no, you can not just do it unconditionally.
> > > > 
> > > > The correct fix probably requires virtio core/API extensions.
> > > 
> > > If the introduction of cvq irq causes interrupts to become shared, then
> > > ctrlq need to fall back to polling mode and keep the status quo.
> > > 
> > > Thanks.
> > 
> > I don't see that in the code.
> > 
> > I guess we'll need more info in find vqs about what can and what can't share irqs?
> 
> I mean we should add fallback code, for example if allocating interrupt for ctrlq
> fails, we should clear the callback of ctrlq.

I have no idea how you plan to do that. interrupts are allocated in
virtio core, callbacks enabled in drivers.

> > Sharing between ctrl vq and config irq can also be an option.
> > 
> 
> Not sure if this violates the spec. In the spec, used buffer notification and
> configuration change notification are clearly defined - ctrlq is a virtqueue
> and used buffer notification should be used.
> 
> Thanks.

It is up to driver to choose which msix vector will trigger.
Nothing says same vector can't be reused.
Whether devices made assumptions based on current driver
behaviour is another matter.


> > 
> > 
> > 
> > > > 
> > > > -- 
> > > > MST
> > > > 
> > 
> > 

