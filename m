Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB82C11FC
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490875; cv=none; b=Uh5UA2sSm5tUc5zxIfsvIEGZXoOJvltFQMskhY1U2nk5uSiJno2qLzFVPxNeUY+Z7cif6N3hflDeAYqCQongtioXNanvMp1XO0YoOSzEBd8c5CZO/+BzRusL0RpgHzMu4DTQNt49k7MZM+z8jnnh/iFLMwqH+oaPu6nPU95zb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490875; c=relaxed/simple;
	bh=2eRQFz6lTYzuVrxi3sraTdoTI5Gov5pFUQwZMiCSUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Tjzft47FLLQWLAdebGOMrAhNI5fRv76faW/2W1RxbidVJ8sQA1YpPjfiDklkpv9HUPqZPozaKoSAmc4LzAITVO7R3hVQgyrcINQSI/3it1hzPadHvptSATsYgxU/CO9LxTvANQoPH3MBHxqFk3iWdjWnxr2DNUblQjuhX+yZWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rqz96YZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqz96YZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KqMplkScTYjn/2difwf3vbnDC8sEidYGpK87XWS4RY=;
	b=Rqz96YZXUPJ1csNq31jUX5dHbnPEf+aXuJnDqjZnBfnzp46pbUoOD+npyNjN6pkH3IaZA+
	ybjfXok1WLEb7s/nM6gLjdMngYtkyQhCOmsWFnotsf2Ds11Oxrb3DK+R6l5tNnu9G221mU
	TnV2i60UzwtE+zNxyD1ucHru48Vy0k0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-j3vw31kqPaC-RDelOw7nlg-1; Sun, 21 Sep 2025 17:41:10 -0400
X-MC-Unique: j3vw31kqPaC-RDelOw7nlg-1
X-Mimecast-MFC-AGG-ID: j3vw31kqPaC-RDelOw7nlg_1758490869
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso21884315e9.0
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 14:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490869; x=1759095669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KqMplkScTYjn/2difwf3vbnDC8sEidYGpK87XWS4RY=;
        b=OMfF3iRbm04XbrBBlU+rXPdJ99HD3LfKaJdUllnEJ7eI7AvPRiOFDf8WcLObAMp52n
         fKKHoFDFyNh2snus8vXcRnMH4oE8XKw5F+3Sj6mPCkKQ9/f0ngKYrHrluFfv7XV5dY00
         AjfpfkkiC9mJ+t8RYFK2SbD+v/eciJGiAAI8DIctMX5AfBCni7QIcwx3xMAOrXr19Ann
         qzhgMp3dfQyHCss4i1SBF0GlZRibPFJbF3zgzzNGAYoPzHmtaIcynQQeyvsAfc7oWPbw
         Yi2LN1JqQew8QVWV08NIbZFngAuLQbeJRn1w7qlz8bSzmZz4Ji68sMY9vHamXwZOihkX
         AXCw==
X-Forwarded-Encrypted: i=1; AJvYcCWMs1UoPQ83/cXIdEUVUgbMoLDR/VLvLw0mUr/MqpiAcaeZEWoGQrQavYLiEqhO/lsUfpcsDjWZXGy3pZMiVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrfT5ikiTWguAbJxmGv3PJnayqd4l6MdP9u+hur+QodITkUHK9
	ALvcks5woGiL+29HTlqxhfmcF0nF7EQwtyv7XHaYPHvZUh+OTLTOzcel0A7f3Wx8HKkZk7Zz4sN
	aph9l15MI1HuXDBdAx7bdQ3KTkiZxBjN7RO2TG+SNhmaiCVeXzsADzktStCXjSsk5ch9y
X-Gm-Gg: ASbGncs8u+N7ylb/lklPJEFib7ecIxcBEHShU4DS+qfHtz1LTwVtBnW2lwJHuAtsepH
	/WfPPNzcytwmQrasYODY/0RFhayuwA6RJKjVdRH6D7TlBSN1p0RMOOM7KqcRc14DZSgnz/0bW1N
	K5iF8KmXGP9EWAdrNPvv+7E0u5yNGdYHgQ5vNdQlEAZdnC43eXZxhBj4GNL9nRQHtchbCqQ6nI3
	BfdrdfMUacJL17ijSMcoQJyucXv2q2KtecfH/a21BmCOi1vAi0pMdgeWpu0kTTHcJHeZMQfUGmG
	9TP9U3gPBMiGTOvZxnwW3zuD1Z1cKZu7ofA=
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-467eed8f915mr93974085e9.12.1758490869206;
        Sun, 21 Sep 2025 14:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3ONLO0TqDIpbwZ8tdp1Uhm0ZVS1N782aV32rBmMI81RJxSBnbtQKfoquKrW3T2JV+taGEw==
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-467eed8f915mr93973945e9.12.1758490868782;
        Sun, 21 Sep 2025 14:41:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d42bee6sm221283755e9.15.2025.09.21.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:41:08 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:41:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250921174041-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
 <20250921165746-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250921165746-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qEiOOlOTtQ2zeoyDWjA8gI6jByHaAdS49XrZwq_J0Vo_1758490869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 21, 2025 at 04:59:36PM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > 
> > The return value of copy_from_iter and copy_to_iter can't be negative,
> > check whether the copied lengths are equal.
> > 
> > Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Well I don't see a fix for copy_to_iter here.
> 
> 
>                 ret = copy_to_iter(src, translated, &iter);
>                 if (ret < 0)
>                         return ret;
> 

to clarify, pls send an additional patch to copy that one.

> 
> 
> 
> > ---
> >  drivers/vhost/vringh.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9f27c3f6091b..0c8a17cbb22e 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
> >  		struct iov_iter iter;
> >  		u64 translated;
> >  		int ret;
> > +		size_t size;
> >  
> >  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
> >  				      len - total_translated, &translated,
> > @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
> >  				      translated);
> >  		}
> >  
> > -		ret = copy_from_iter(dst, translated, &iter);
> > -		if (ret < 0)
> > -			return ret;
> > +		size = copy_from_iter(dst, translated, &iter);
> > +		if (size != translated)
> > +			return -EFAULT;
> >  
> >  		src += translated;
> >  		dst += translated;
> > -- 
> > 2.33.0
> > 
> > 

