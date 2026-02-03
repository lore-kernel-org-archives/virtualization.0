Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2D312808
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114931; cv=none; b=IAXpVGnMZ86r1JWNliddl/s1l+2Xmguu6LguR8L8E+36ssJnZLvbp8NlEbpm8OfzqC+BupYsvVym/cOfzZ03BJGD53Q2jlndP+BGYBQQ35qf5+rekvfa9VUoIxreHYNnFYN7eMUn/WsTMyQ+KvinhCIhlR38CEKtDLAYr5DR1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114931; c=relaxed/simple;
	bh=S4nCe9RdyPpAtp7Mp2ZNE6h69mNCvah2U45wBSCykJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hx7oq2vpyFbLU2f+ASLPJkLpJJ2T3O+3RWpl3/lOw1oqwNau5SeU2QiX+QgRZGS1sGLmVhLRZEBp75QJFk+YheSAeFoZwVq0Riu05Ag/h2aO2ZbQWHun3mNX6pc8TOth2iRXANy4isy+2Yn0B+OiWyMSK6ERH+MWfw1Gq/bGdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2sywt62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2sywt62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770114928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dG/1ixmI6/hveTX8LWUk7DTwV/HbziRIWxtK3JNwm8w=;
	b=D2sywt62Emq0ZlGiVTC0DR9DoHHAYXGUOFweRqOduc5dLaFRpFA60TKi0+xAKDiyjtuDsj
	tFSbYOOpxj8T6KG9K/O9quhSiPprl8um+XhBIbB/nEMqMA9up+XW6hgPLEk8HLYg5206OU
	HVA+6qOSYwX2RLgoSajWMihvBNrrSG4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-vZvBye4rM12W7MKo1fQSzA-1; Tue, 03 Feb 2026 05:35:25 -0500
X-MC-Unique: vZvBye4rM12W7MKo1fQSzA-1
X-Mimecast-MFC-AGG-ID: vZvBye4rM12W7MKo1fQSzA_1770114924
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8861544696so585302866b.3
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 02:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114924; x=1770719724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG/1ixmI6/hveTX8LWUk7DTwV/HbziRIWxtK3JNwm8w=;
        b=rASzKMEs48YOqmpR03aGP8ABimPRm3G37014dIDNpnWYNqxlRIsUd0kLd09bxYJvZS
         6JZuPtIlwUI+XB4bkjvPn3asUNKIuxrG8ECbbZ8V1Kg2wXBvp5XdBULWYULSnbD/6C3o
         UgK20xwwY+kNfp9k8oH1tzR6MT0TVTBAavve7lvIK9xXlyYAbuPGEJUIs1J0VlRkxBt2
         0RTOAV8urNQCOrDpdyPdoyfhjpPjqpzjM043wO9TXHslabTN6rtw9ffmmURwoSAiDuKF
         a3F25tIKd6ka9p89PMcBzXbQlVv0SYDp7wU90AwBw2zBsAGufXsH5sMGnbqRwm2FJK6O
         SGZA==
X-Forwarded-Encrypted: i=1; AJvYcCWw7tiyLS7mzTcB9AQYqVtZ4Sk5UPFoO8/uPGyknj0+9JL5nmM947obeo05utRUrXE2I0mr35KSssaiLM5qfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfs0FvEhwpuhvc9kpPAk5MbCaV2mmOe3gAQSJgQ7uciWEQetcK
	mAAGdGWbXfby/5sG/oVXyeqwSRnO4s2Kb/Ecf/I4aBTUq04Wfs+KCnLAsLl1Ss0c+XZI7qEBhXE
	EqC7GGmH0y8U87OE9I4p+qCzIQqDTYs48j22YnH6MrtAqvGeZ8PqQoyOS/EZ7gm06gj1R
X-Gm-Gg: AZuq6aIgAprhwyOLaOaeN8cB5swwbN517tVn5cNMUMi4KmFvT4qBrVSMh+c097mVida
	irCz/Fo7Su7wusMjYwhD31Mh3eSSWt1OHYBmGDXYdpBL/A/AVv69LkSheiKoZ9pKt3re5d4Nl4Y
	zaoGEFpvLutWr6+N3i6K4rod3IpYOuE4IclLI5W/sdyFinUWf7IO6cxLmm8S6BW23yTkGkKMACT
	mffQ+T1nVhPTMIOp/9CPT0wugXuLawIGLckINAT/FLuOo0/De3GtGLxBUVmE+HheMmYGf4B3PZC
	jdzp/GZT33hbgx3fc3Om+3H587V8xCZnIOUYIaXPeHf06MoyeRm8EsoJGFYtk7BqTDw5AIrc4jW
	qhoJE52KYPlL0Q2yXmeqELPouIVE4XRXvNg==
X-Received: by 2002:a17:907:c09:b0:b87:2780:1b1e with SMTP id a640c23a62f3a-b8dff6680aemr922343866b.41.1770114924258;
        Tue, 03 Feb 2026 02:35:24 -0800 (PST)
X-Received: by 2002:a17:907:c09:b0:b87:2780:1b1e with SMTP id a640c23a62f3a-b8dff6680aemr922341966b.41.1770114923761;
        Tue, 03 Feb 2026 02:35:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8decc368fbsm814985666b.6.2026.02.03.02.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:35:23 -0800 (PST)
Date: Tue, 3 Feb 2026 05:35:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260203053142-mutt-send-email-mst@kernel.org>
References: <20260202095940.1358613-1-arnd@kernel.org>
 <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
 <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com>
 <20260202114412-mutt-send-email-mst@kernel.org>
 <34d3ce77-84b2-476c-a678-e092831041ae@app.fastmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <34d3ce77-84b2-476c-a678-e092831041ae@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u4LSv-nmNaU-014TkL7x-z3wlzgaoXYmnUhKArJNbrU_1770114924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2026 at 11:54:17PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 2, 2026, at 17:45, Michael S. Tsirkin wrote:
> > On Mon, Feb 02, 2026 at 12:59:03PM +0100, Arnd Bergmann wrote:
> >
> > I think .compat_ioctl would be cleaner frankly. Just look at
> > all the ifdefery. And who knows what broken-ness userspace
> > comes up with with this approach. Better use the standard approach.
> 
> Sent now.
> 
> I'm not sure it's much better because there is quite a bit of
> code duplication, and reducing that would be a larger rework.

yes but on the flip side, we can put it all inside ifdef CONFIG_COMPAT
(which this code did not do, but should IMHO).

> It may be best to hold off on patch 2 for the coming merge window
> since the compat ioctl code has apparently always been broken for
> x86 here.

And it needs testing.

> I hope we can at least get patch 1/2 merged along with the
> new code though, otherwise it would get a lot harder to sort
> it out properly, with the v2 struct members overlapping the
> old padding fields.
> 
>      Arnd

Along with it or no, surely before the release.
Given 32 on 64 with this apparently has been broken forever,
I will merge this just based on even you did not bother testing compat, I am
inclined to say I am merging this but not rebasing because
of this.

Oh and we got lucky this didn't leak kernel stack info.

Eugenio, note for the future: please help make sure UAPI
structs do not have hidden padding.

-- 
MST

