Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C81AB358
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630841; cv=none; b=U5oUkPgi/k+d/QbAakP0AuF6TwkdPYCd1jEnBQr4iSvmfMfv4uKoyPPIJTOX26qVj14Do0J9bjWdthKbMAR6k+3iW41N3kHARez2OL8bK1g3ZKd4kGGsROasjIKqSpo1A5ITY55xKkyvuL/zbGxzZtcueC3yJXUbUT3XYWo//pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630841; c=relaxed/simple;
	bh=BVnGMwoCZw7PxuD/QNYyTuQeJ5mFD9HFP2ibNF1eTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mF0ujqnySPczSnScESc7v73JLUnOUDh3ghrQ4eMuTmoT2xCqPByZHShaFxjH8XFL0tp/E4MxndE9ZfMHbUjzSChjwJQy2l6+1S56vL9d74s5AIkij4ZWkstioVc6z2UdPRnNQnvOPI8deqAtJ1Nr3YhZ4+A869olWeiUfROymmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7Kj3gp0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7Kj3gp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q84CXo0wUI7hBoP/Wd2wSAm0e9Fj0ilpl/ZCzDP0aQQ=;
	b=U7Kj3gp0Jp3abvx21lz2vY+fQFCPnx1EpPSXTvC4p3Uyjkw77tSsbafl0IbjHw1H8X/IWo
	C7Sr/JJZA766QwClKdoLZ4JTBAzLc41lhXTKiIXwM/BfhsJA5VKjNQBkizbN2bWtYYNVkK
	1ZvayVHTlCQDvyEGB/l3/f2Qa6eDXjc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-EGuEJjtPNe-05OnPAkL6vQ-1; Mon, 17 Jun 2024 09:27:18 -0400
X-MC-Unique: EGuEJjtPNe-05OnPAkL6vQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52b998cb52eso2965348e87.3
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 06:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630834; x=1719235634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q84CXo0wUI7hBoP/Wd2wSAm0e9Fj0ilpl/ZCzDP0aQQ=;
        b=FSk1urYLbXpf7HKkiKWxdWtsbxCs0NxyO1vfCv+UqneJPEuYCC3h87Niay0HUnCsvx
         mOZH3Zx0bY0KcWL6Ps+82H5vCaMnjhbBWWe/CH/JfQkl/V3vsb4dRHQjSQzFqUXZrtnO
         oxbv9kVwPHJW1Wi/xbsjKdweducjw52S0/aB20T4tbNCem3JkerYfgjtK0D8oxfMsXyw
         ZPfuKnaWWyPWfsTnVEWNUiwXyZjtxLkwTHLgV/g+R9EnsDsitAarbIaKOwxLRcvN0+vn
         3sIzM427osIH5AFzjkYUiHKr+WL/I+gEpyluC6Xl4C7CNia70JERzYXR6qaUXiy4MsKk
         06bg==
X-Forwarded-Encrypted: i=1; AJvYcCUkJEntoOvGir2+KqubNtN9M2DRUMNTNiQY8fa5Ab9A/ihErQk3WuDiamf5TVmLXQiH1GjM88z2QYvx478C/0usbU37kQ5yQcbZwwBnxzQ=
X-Gm-Message-State: AOJu0YxfA/09U9x8Q9QqEd93AL3gi+eASgCcPTQc4qux7YhFKe1yBBfR
	gK3Sswd447S0faeczNgavshus7dRADBCzvSLk9rAiL8lq9XjAHbzkAUFDdcLdURMFUJToX+wi14
	4NbFN9gh/K8biuXsA2JANYS/SqdEAiit8k64nrc4V6VQyjzsjl+lCiJNXYXrJfX0u
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ca6e64378mr6296640e87.17.1718630833652;
        Mon, 17 Jun 2024 06:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpnKGZZT8Zk3aPPgtEsPpln7bsKIoo+bG+Ridg0DdcuVdy5+34CRZh9UkBKQn9c7obciZzKg==
X-Received: by 2002:a05:6512:20c6:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ca6e64378mr6296612e87.17.1718630833121;
        Mon, 17 Jun 2024 06:27:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509348esm11832788f8f.17.2024.06.17.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:27:12 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:27:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vringh: add MODULE_DESCRIPTION()
Message-ID: <20240617092653-mutt-send-email-mst@kernel.org>
References: <20240516-md-vringh-v1-1-31bf37779a5a@quicinc.com>
 <7da04855-13a1-49f9-9336-424a9b6c6ad8@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7da04855-13a1-49f9-9336-424a9b6c6ad8@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2024 at 02:50:11PM -0700, Jeff Johnson wrote:
> On 5/16/2024 6:57 PM, Jeff Johnson wrote:
> > Fix the allmodconfig 'make w=1' issue:
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
> > 
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >  drivers/vhost/vringh.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 7b8fd977f71c..73e153f9b449 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1614,4 +1614,5 @@ EXPORT_SYMBOL(vringh_need_notify_iotlb);
> >  
> >  #endif
> >  
> > +MODULE_DESCRIPTION("host side of a virtio ring");
> >  MODULE_LICENSE("GPL");
> > 
> > ---
> > base-commit: 7f094f0e3866f83ca705519b1e8f5a7d6ecce232
> > change-id: 20240516-md-vringh-c43803ae0ba4
> > 
> 
> Just following up to see if anything else is needed to pick this up.

I tagged this, will be in the next pull.

Thanks!

