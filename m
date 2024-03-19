Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373B2747F
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851759; cv=none; b=l4VvTNgNAhMODGyFoN6nJHvopikygS9jvfaCvv8/0pPILPpkzKZdYnmTPPJSvY7rTcn2zAwM7GF4/xGepchaXRkJKrTHmc+1jTUA+qzIkjLhIugokF8/+L58wE0ykH3b2p2JwSnJvMAIxIRK8pHL1cF9sncqP23eK6AKjquYqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851759; c=relaxed/simple;
	bh=poxZUtAvZovg6vpbH87hGkrtbvLh0+Y9dlgb9YTRlMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Os4g7k9Y1vuyXVpoiST3bZiPWlS4Kpb+7ZKpibzgLBxIgFtH2nqrNLkU/L0ueeAJXbIELdGqztVZWSjXt/mB+6tjOQz1GHPSW+iyFcmwQepILll9vRXLsHuDQtQ9eSC8Fg/CGihonb5lJmF3cvCxU+pLgFOlPY2oP4vBUqNrNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7uv72ge; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7uv72ge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710851756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P078vT7kxwm1KvjEEZF7oc/hTKC7NKQ6e2jYtHfGS7s=;
	b=a7uv72gedHHH77YgPTYM7Tix6dfVB7fkxnDGp+tZecSuhZHeZ96dVKrJQTaYtbd//G3AON
	ygQv+jcSyml8+eKqu0XlhD4x87OT0yltgcilJyuPm8m4rimqD/U1c+FrbQiRMWbIPYdLGW
	59PTpZePb8qGZ6GUKS0DtloAE5yY8LY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-I0l3GSSuOr29T8ZE5XEWTw-1; Tue, 19 Mar 2024 08:35:55 -0400
X-MC-Unique: I0l3GSSuOr29T8ZE5XEWTw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e40126031so37580605e9.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 05:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710851754; x=1711456554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P078vT7kxwm1KvjEEZF7oc/hTKC7NKQ6e2jYtHfGS7s=;
        b=lEKiVraz4oA7udt7cFTklOMobnswDl5N0TzEWdLXFOHmmpUw3ByNsqwZTPriKOxYwu
         0kUl92cCdNx+cHoxvsuVN/y6H6LJQfIenF/aefry2aOK/NW3+cIuY+pQypIXlLD5nss5
         DdyF2epwpCcE1kxm/Hn2044vsowKjmKL3Y2Y8fen2zfXkNNIVE+/CdhwsyL09pubwJNX
         NzJsKCKxxx29wvfAGheynEYW/vBfJOJRKGRlguFAl6haByqzXEXm3iL5kjcw9sWajuPy
         UteUzoYg7sXYKLLOIH7E4vTZ6H3YnfSpoItjdKYFDIOI3eAdeJyYfWZ2ADtQm5ks9hZP
         kr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDSc+5bEFTmTzc3cTKBYBITk3ZZDSX4HcsuNnyhFXKY8OZU3D6TZqhnCWtT0PcW/7MrnNyby9pmfUv8/WK5YeWNX34nWP64bIGbv7AaxM=
X-Gm-Message-State: AOJu0YzCJPL/t+CVUwWCKm2tlx6nArz2GFjNlVRy+pn/LNDk7XAePTVz
	RZui6vKADyoFH3ORkn/pxkK4EcRiuPWCtEc0AAcA8HCnr1q71hqGa3M5eQySZiugHaRNPj6BOvN
	ZWbZSMiqd2SficMWD6BjIU4d6e2dyXrPNdi2gmLAE7MS7GpbbeYOEo3/1w5/IBZLa
X-Received: by 2002:a05:600c:68c8:b0:413:2a10:8a29 with SMTP id jd8-20020a05600c68c800b004132a108a29mr8625059wmb.13.1710851754053;
        Tue, 19 Mar 2024 05:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjmUkzIVEgrxkuxs0hKAEP1YZyioYEnXwSIcrOKqZ6BusYo9P84csTk4RIfa3cVBvQvM0IXQ==
X-Received: by 2002:a05:600c:68c8:b0:413:2a10:8a29 with SMTP id jd8-20020a05600c68c800b004132a108a29mr8625035wmb.13.1710851753558;
        Tue, 19 Mar 2024 05:35:53 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b00413e6af1bd5sm17979513wmb.47.2024.03.19.05.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 05:35:52 -0700 (PDT)
Date: Tue, 19 Mar 2024 08:35:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: apply maintainer role of Intel vDPA driver
Message-ID: <20240319083521-mutt-send-email-mst@kernel.org>
References: <20240227144519.555554-1-lingshan.zhu@intel.com>
 <09fbc96c-9083-4280-b64e-e5159279b4ce@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <09fbc96c-9083-4280-b64e-e5159279b4ce@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My bad I messed up my tree. I think this is ok to merge
after the window closes, will do.

On Mon, Mar 04, 2024 at 01:50:18PM +0800, Zhu, Lingshan wrote:
> Gentle Ping
> 
> Thanks
> Zhu Lingshan
> 
> On 2/27/2024 10:45 PM, Zhu Lingshan wrote:
> > This commit applies maintainer role of Intel vDPA
> > driver for myself.
> > 
> > I am the author of this driver and have been contributing to
> > it for long time, I would like to help this solution evolve
> > in future.
> > 
> > This driver is still under virito maintenance.
> > 
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> >   MAINTAINERS | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2ecaaec6a6bf..128ec843eb19 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10365,8 +10365,10 @@ F:	include/net/nl802154.h
> >   F:	net/ieee802154/
> >   F:	net/mac802154/
> > -IFCVF VIRTIO DATA PATH ACCELERATOR
> > -R:	Zhu Lingshan <lingshan.zhu@intel.com>
> > +Intel VIRTIO DATA PATH ACCELERATOR
> > +M:	Zhu Lingshan <lingshan.zhu@intel.com>
> > +L:	virtualization@lists.linux.dev
> > +S:	Supported
> >   F:	drivers/vdpa/ifcvf/
> >   IFE PROTOCOL

