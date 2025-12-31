Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E92E22BA
	for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215335; cv=none; b=cAARC75lAs+hcciz/UI0eu0GWTRU12fmuAszMZEzURM0IqH5jBc32dL1Ng7oi9o94SvocSd7oQVsed7//qLCHtJemejXdIwgvpboDFvqF4OxR3SjBiyvwnVp9pcJ+TCL2sDBHSOYccHetD4vbFPltp295j2qpLAqabT6gfeUqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215335; c=relaxed/simple;
	bh=NEavsbS+MYgvZbyUEA0n5b+NpFHMUAVVeVoqvcJ/Xe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RAArpykyHqkpvsyx0Z4CPY4wjhN+0JcHPZmhcAmfBrUUMBZ3ZcQbCEXZA6St2eawuu+7uKVV2YnKdm1AbGFa5b/dlISVIy1J8CaGo1OVckyFmeAdRdb0quzbJneNxbv4ZPp658/Ay2ut9VUXHx/72ZquC1wHY9u1vSZHRAO7okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eN7Irdwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eN7Irdwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767215332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=607vL4Qm5Hi1Y96elBHDWEflyHPmZnMU1mQjlKs0Qjg=;
	b=eN7IrdwpVL1qUMgVrESrN5eOmh8xZaRTnyMw+ZQZm/HgFc+SNuAVhE9bXTYpzd51Lmqxi3
	VBTDbqwHovyXIRsb0Id+l06HRMKMFoo4GFrhVtr3XXqhrZ9fz35fAWyFnlrKAdE6S51SU/
	JitP4ntA2ffub34XFuY/wu5xD7RwHlw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-1LgT5_7jP-C2F6iiUOaeAg-1; Wed, 31 Dec 2025 16:08:49 -0500
X-MC-Unique: 1LgT5_7jP-C2F6iiUOaeAg-1
X-Mimecast-MFC-AGG-ID: 1LgT5_7jP-C2F6iiUOaeAg_1767215328
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325ddc5babso4418599f8f.0
        for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 13:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767215328; x=1767820128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=607vL4Qm5Hi1Y96elBHDWEflyHPmZnMU1mQjlKs0Qjg=;
        b=Ga4qOYnGeIOS1rOzDv+LPYWv87Bhu1bCuB5360wstSGu4/zh9QwgUgqG1D9+Cqv9If
         5KxBeCpbzvuzWvLX7OuP7ztO87c/3vwcXMAekPJVH0BanrEgvK2SAW3Gfb5zx3NJJS/G
         kc+UVtWt47auW6cA5TgOAjCZ7WAi896EuIg0Ib7K5r/SpTXrw2acE7GtSzwJv9OIMxzP
         0U3DVFQMawpMpW2tt4x+zgvMvFEG8EL5xdaVwn4LFiYjHYf5ckNttoOYPX8X4kO1yseb
         tO8ewmJz2r57DklW8QlyOMPhzHWk5lN2+ykYv4fMOG95AC0CBodspxs3ClGcfic9LzNK
         6MNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+5pqQmbOq8mkLuTBFf0j9g80eW0QQFoq0WlFIyaR+tzsY3bDzBHOm2RIGBU5fwnGZKZaGN4w29FFv1ivP9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr2s1h+V/0P9bY6lPVeNB7+0UHEiemBtyYzsTAaogloo+MCk2j
	Mcy7pzfZ759/CiSPjpxwpp/zogVRgNLFgQWYi5HxuTzvTSsIcZlRzsfg4/UJ7+njTlA1S1kFBxN
	cmlzlxVIphUYgSQK4DOuiqSlPY93XqLi2ZGoq/txKM7iuoKHsjMLetQPOoK/BJh+hIgy6
X-Gm-Gg: AY/fxX4JsTkcqfeDBooAUup5f56+3AA7+zd2NH381tb6sYOhOpUbOpgve6qMuHV9IC6
	mwLGVIVXfanPcwAisknt2lOAwmUYg355ktLOKHVQ2+RiijkirN6iPzxQrDFndr4q4ILTjIPG9iC
	QkwKZ9gAW+kADD8viJcsP+TXy2CSVEZnyY4g9HAGncOYg+tNj8TwSC8HIRgdB942ibhoLFvbMap
	fPkngTJM1TwGlF31X6i1iko3bCR0hHXnRlh13kYLTZgbT8U4NQkTBxwEGOM3LS4OmaijVKASpC1
	UngZTB328W0VtkgbltGA41i4FzRaL8C0tGlBpWekm/loiOpChYw8X+afm3VhvZwl9462nJEF4zs
	=
X-Received: by 2002:a05:6000:178a:b0:431:c2:c636 with SMTP id ffacd0b85a97d-4324e4ccf5cmr53000687f8f.24.1767215328064;
        Wed, 31 Dec 2025 13:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjZGHdmylBd9EpV00RHddE+SBBivtlR/NvaDmcBP16RKKvt2R5hlqHedlqvszkmMez70DHew==
X-Received: by 2002:a05:6000:178a:b0:431:c2:c636 with SMTP id ffacd0b85a97d-4324e4ccf5cmr53000668f8f.24.1767215327679;
        Wed, 31 Dec 2025 13:08:47 -0800 (PST)
Received: from fedora ([37.168.2.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm75349141f8f.15.2025.12.31.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:08:47 -0800 (PST)
Date: Wed, 31 Dec 2025 22:08:34 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aVWQ0laxIdp3fx+p@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aVLq1ibPcPHk-7Qv@bywater>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5IdX84IVP8eJXyD6_LAZU17-5rd0tTO-8UQVACxC2ek_1767215328
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2025 at 09:55:50PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> On Mon, Dec 29, 2025 at 07:53:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > While stress testing this, I noticed that flooding the virtio-can
> > > interface with packets leads to an hang of the interface itself.
> > > I am seeing this issuing, at host side:
> > > 
> > > 	while true; do cansend can0 123#00; done
> > > 
> > > with:
> > > 
> > >  - QEMU: the tip of the master branch plus [2]
> > >  - vhost-device: the tip of the main branch
> > > 
> > > and the following QEMU invocation:
> > > 
> > > qemu-system-x86_64 -serial mon:stdio \
> > >     -m 2G -smp 2 \
> > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > >     -append "loglevel=7 console=ttyS0" \
> > >     -machine memory-backend=pc.ram \
> > >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> > >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> > >     -device vhost-user-can-pci,chardev=can0
> > > 
> > > 
> > > Restarting the interface (i.e.: ip link set down and the up) does not
> > > fix the situation.
> > > 
> > > I'll try to do some more testing during the next days.
> > 
> > I tried this and I could not reproduce it. [2] requires a minimal change
> > to apply, i.e., qdev-properties.h has changed to /core. I'll send a v2
> > for that. I used latest vhost-device-can. I run `candump can0` in the
> > guest and `while true; do cangen vcan0; done` in the host. Am I missing
> > something?
> 
> With the plain 'cangen' you are not really flooding the interface, since
> you are only sending a random CAN frame every 200ms. The only way I can
> reproduce this behaviour in a consistent manner is running from the host:
> 
>     while true; do cansend vcan0 134#00; done
> 
> which seems to generate the maximum amount of traffic.
> 
You were right. I could reproduce it. After a while, I stop to get packets
in the guest. I'll investigate.

Thanks. 

