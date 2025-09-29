Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE87286438
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138151; cv=none; b=JdQICiWdQfp5KRZ9I+w606QB24p6+fH0neDep99OJthOAYwoe9vEh3V3wJT38YwfpLR68HDjkzH/Btzi2ZGnWYi8PmJ2Nd7OcCzS3BRwUBFGuT9DZYnvP7MYU5NndmAisG3OzMfwCcGn1+WFC6IZhHgiNu6hyxpmCLXPUsKUe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138151; c=relaxed/simple;
	bh=IqqohkwK/wDAZXsbcwVBOyqyCpj2UXCieQ+qc0MMaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dzbWXPOau+ImGV1Yeumy1k1Mc0L9eZ5Y7e442qzZQ2vG36h4AjyqYVvqRAnZI9oFDan2S4g7n99bhYHhDvAbnSdtPloT4lSYjbjEKwm/D2+y0nqg2XOpjNy5tjr3Lpq/dgPUegcVcqi/nU9IETWgyy085aA1/d+YF+20kx2cH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5RxZwG6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5RxZwG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759138148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fWDea0/6VzbimOx+St7tLaVKMNcgYjUWpmfVi5MNpI=;
	b=Y5RxZwG6ELspg7zJzr58qwK+T5HriannA6+9jxDt1KvyS+kBXRh5PQBGYZATDVjvCHbhAG
	Ds1lOY+o0+EW3rRSkB9euTW6rpTqcD6e7yGMYXgPM9+HE8LMviy6tJYGN6svmbB2f5W57E
	JeNIjWKRAH+Co3VBxcmFhNKOmBwuu/I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-3Xap-_TSPa2eCE2D2RRWeA-1; Mon, 29 Sep 2025 05:29:07 -0400
X-MC-Unique: 3Xap-_TSPa2eCE2D2RRWeA-1
X-Mimecast-MFC-AGG-ID: 3Xap-_TSPa2eCE2D2RRWeA_1759138146
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e997eb7232so1894406f8f.3
        for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 02:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138146; x=1759742946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fWDea0/6VzbimOx+St7tLaVKMNcgYjUWpmfVi5MNpI=;
        b=p7G5IOfhQ1ZJcyMaGbnAJm0OPSzR29dwUSSlcnDBuuhKGK7iYMe1fOofa4SpKuoVpe
         LkrAmjV6pcf66m5Z5tfp7/iVxvVIzYzPFBuZM19lHW0AhvGvMUeOkh3b8Y498DcBbKTS
         yCeIimFUqPJg2/AtiIGeNB2meujqpR5To5UBE+Xo6FGJhlTIWq/lDSXGfB84lDe85L7B
         aPFQjgbtJFUL0R0pcAfYhhMzCnfnMDOHzlq8L5QQQeiX3uoaBKWNOrLOqVA8TeW+tSGB
         JyjfFeuPnoW4BYpRMowxRb0POMRb6ew0flwp76zvmYfVBJ2ejF92AK9KwmiGCkiHEWRo
         AJEg==
X-Forwarded-Encrypted: i=1; AJvYcCUNX+dQYaAjtAEEBd5dY1SAErSYhF0Q23sMliFmqoEJYaHpv8qLDjw5qWUeIZYMFs0anM1LOnB3K1H3W++ltg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE0MiI43iaExS4STdS68Cbh7moL3prjTUDFGVCJeVKA3+wgbNf
	5amPxAD6+wiE/r1pVowSOHddfahHsw/OKhaUj84/ooS5q5+vYE4PhTskDLo3puZqlYJty/nmtBi
	1ScS3z34jmBhZiXPm18EpTzSPtWzcCyev9X3sbu7yYV+CHEUzXs5g2Y8Ra0qutWxJ7y1x
X-Gm-Gg: ASbGnctD56M9nBKM/qBClVTLUHkd/KhVytIlWJMIVQklZRQKYzzUDv7+yJDw/BIAfAw
	WLl2nshP0E7nkKaZNY9Uqw9lSZ1nKx9GRTl6S7GoCFa6s7jf2pCf5mEKRIqZuaUguKJoeG311fF
	H2Yr+gJA+o62BAw7clryZ2iLUBsaHvOB2xtqJSyG23WKvCxuB77Yu5BnSMBfz/s+LVmWa/4SN/F
	nrceshieLFGEyjurrsYQGfhWr4+fCJO1uxiwTMgf8lb0qPgQEZku9x/8T06r9GvfBNJAPFmNIKT
	2HNUuUOy1ZqpAWwPTWJzQRSEsjQIzJ+zRA==
X-Received: by 2002:a5d:530f:0:b0:407:4928:ac93 with SMTP id ffacd0b85a97d-413591d79bamr7817174f8f.42.1759138146139;
        Mon, 29 Sep 2025 02:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYA0WmzP6WoEMlbJwT4yGMKxIBdSduVZ9RrZfxmTRyvknf7O/p1G5x1BNEYVHkuc7D1lGyMg==
X-Received: by 2002:a5d:530f:0:b0:407:4928:ac93 with SMTP id ffacd0b85a97d-413591d79bamr7817161f8f.42.1759138145763;
        Mon, 29 Sep 2025 02:29:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5707c1e7sm5111115e9.21.2025.09.29.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:29:05 -0700 (PDT)
Date: Mon, 29 Sep 2025 05:29:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250929052852-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org>
 <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
 <20250929035510-mutt-send-email-mst@kernel.org>
 <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uxFyrlbItfLJXVrn80DmVfpVEkEPmMt8HKpDGbuSPhM_1759138146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 29, 2025 at 10:52:45AM +0200, Eugenio Perez Martin wrote:
> On Mon, Sep 29, 2025 at 9:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> > > On Fri, Sep 26, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> > > > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > > > >       dev->device_features = config->features;
> > > > >       dev->device_id = config->device_id;
> > > > >       dev->vendor_id = config->vendor_id;
> > > > > +     dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
> > > >
> > > > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> > > >
> > >
> > > The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> > > intuitive to put:
> > > dev->api_version == VDUSE_API_VERSION
> > >
> > > But I'm ok with the change if you want.
> >
> > Confused. You mean "more intuitive"?
> >
> 
> Ok think I misread your comment,
> 
> I find
> 
> (dev->api_version < 1) ? ...
> 
> more intuitive than
> 
> (dev->api_version == VDUSE_API_VERSION) ? ...
> 
> But now I think you meant
> 
> (dev->api_version < VDUSE_API_VERSION_1) ? ...
> 
> Is that right?

That's right.

