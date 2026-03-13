Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5F332907
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403608; cv=none; b=V6WsTEOC5crNr/2oxzvlIZ95xijOJ1fCxj0Al1u4OMDCVmSgxmqsx7F97/6DerRmPpIZ1oRezk6IEVbxYH8SiY9gexMWhh4OLMdhFQo75m3gz8zJibbcEflCEYDbFwuH5m8gL5wXScgJ37jy8HswpJwsciN2zmIWSS9TsnDCS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403608; c=relaxed/simple;
	bh=wOJF9PADpLMdeYA8UeTV97nkSaYwDHF+GFF9hpnOpJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MxAkEFvJ2/rhOCFMBugsHs9PYGtU3K3DM/yTml7RKF7aD3G6GOJ715sT6AkuGSMVo2H469t96EL4e0oR2vTPruqAIyKY+MSME/JdzCncs1q3/EDF0dopslAkeVzFP1TXhvm/0/j5HyUYyQKq59DJmoVMg4F4MpGQsrcIYrY2xgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDE2UHA7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDE2UHA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773403605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq5HK1/jLHMAoEi3YRT5LDWCu6Y1xHBbOLaOaWUJPeo=;
	b=BDE2UHA7szVN3/hEdFJLDG4fDZe9YqfTKRjIIfHmE8rr7tTJ/KffEDskCJpvS/nmizzqgT
	ysjC4+9msx2gW+bRzq4jFpuhr91078s7aqo6Zggc7q5JqXhJA2eJl1aVPM6DxzKV4F9QqS
	Bo8NB5Sj+JjBq7jetiFapcuBHoACAZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-wj6s25fSNZGox3qR4gf7ig-1; Fri, 13 Mar 2026 08:06:44 -0400
X-MC-Unique: wj6s25fSNZGox3qR4gf7ig-1
X-Mimecast-MFC-AGG-ID: wj6s25fSNZGox3qR4gf7ig_1773403603
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439b8bc43aeso1721305f8f.1
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 05:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773403603; x=1774008403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq5HK1/jLHMAoEi3YRT5LDWCu6Y1xHBbOLaOaWUJPeo=;
        b=a5gSTvcpZLXBr3MuiU1QoSnZ7hGyc/XIE/hAE5+MxX/VPTP7qLgzoK4oTnj+bLi4j6
         zrc1EN4SGql5K27hcD7ZuPsHvnx736vyI3WjAgOpGztoPKK1ZpOl6O/hVkncJRW3wxhe
         KBWNyUhcu5i/fPxYFrtRP7Cbd04W5E8xH/qPEgDQ+K+i0uMB8GwAfnSMQFS1yz0m/gb4
         JTQJQMbeHHZrBzvwJS0qBId1MlmMAQ9kW3UBnDgCmACyXSqgxlGevZCd8YFsW6Zrir5O
         Pnf+Rh8zA4tmX6Z5xf+Nx1OQ+O2HiwrkWO26Hbx+Ponfv02Bn19BR6C6IK7XuaZbk1sA
         CAaA==
X-Forwarded-Encrypted: i=1; AJvYcCX7NC189WwA/aarGraEeq2ogDKLBgZa8gYWxdxDpzeLQ8P1lfZFxoZQiztOyo90z4VCjex3g/XUj8Gw5SyL5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuLEpdHPndvq1JH+itCAlV1kxumnqiMctrgdgJc0eAasmgpNj2
	9DlZlpbFmWvZg7VkC//GpA4eOakkqSWrWD5Wjt+qp0X5N5tKtQ+7m8v4gonxYHfWh2IJxrgRp1/
	miuarJ0tb0t7QN5JjNowM3Ovry0BNbp+03r7SEDfPOe7erXT+barr5NCHR8SrabtXLNU4
X-Gm-Gg: ATEYQzzNYENbhTq8CFYKYS/qP5uNjw34dMma5ggpq/QP4oE9NqnTq3h7EomZJ4HYga9
	HOWKBAu5lQGcz39SujyD2UePDPheQNYduDEUndJlE1jTvKFFE0V+io33oD2cJJ6/S9eCgxv6hye
	/oleamXQKON4L+h9SZhxmo2VvIvdh3dBxTyllbcphx5FwIGIugVQ9H+MGqe5blUrTsERSqEc1Oq
	q0dNcSDuOWL7bODsBQOsttARKreQE8FX2bhUX7RAB8hDO51vGxMmD0n8lgmqQBKQieaDbmFTRPa
	ypZJfgfnUIgf1Qf/SoQxJdw/otWMByueSbfp65PtmrWLgKc3Kds4SK/oUAfdNg9WbzXzWbCduKx
	fc7b5yFEXAFd9ICgrch0m7R2UE+GIqb7v83j0v4U56edc2Q==
X-Received: by 2002:a05:6000:2087:b0:439:ad2d:99f8 with SMTP id ffacd0b85a97d-43a04db0a4dmr5715559f8f.30.1773403603138;
        Fri, 13 Mar 2026 05:06:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2087:b0:439:ad2d:99f8 with SMTP id ffacd0b85a97d-43a04db0a4dmr5715452f8f.30.1773403602538;
        Fri, 13 Mar 2026 05:06:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe228986sm14429080f8f.35.2026.03.13.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 05:06:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20260313080611-mutt-send-email-mst@kernel.org>
References: <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
 <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org>
 <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
 <20251109164528-mutt-send-email-mst@kernel.org>
 <CAJaqyWdwF5UM+rS7EB9gG5VJMPW0MvwtkNWXdDAkdurFO3zHRg@mail.gmail.com>
 <CAJaqyWcCF0bzwMhQk6L=LPvc=S7yHoWB7xZ+MmPWwhi4kqGEfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcCF0bzwMhQk6L=LPvc=S7yHoWB7xZ+MmPWwhi4kqGEfA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vFmwXLQ-3rXk1J_ttz4ys0_RH_t5i97lQVokqDZwDx8_1773403603
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 13, 2026 at 12:32:18PM +0100, Eugenio Perez Martin wrote:
> On Fri, Mar 13, 2026 at 12:31 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Sun, Nov 9, 2025 at 10:47 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wrote:
> > > > On Tue, Oct 28, 2025 at 3:57 PM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 28, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > > > > > On Tue, Oct 28, 2025 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > > > > > > > On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > > > > > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > > > > > > > >
> > > > > > > > > > > IIUC the workflow:
> > > > > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > > > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > >
> > > > > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > > > > > > > > > so it potentially uses the second rx queue. But, by the standard:
> > > > > > > > > > >
> > > > > > > > > > > The device MUST NOT queue packets on receive queues greater than
> > > > > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > > > > > > > > > command in a used buffer.
> > > > > > > > > > >
> > > > > > > > > > > So the driver does not expect rx buffers on that queue at all. From
> > > > > > > > > > > the driver's POV, the device is invalid, and it could mark it as
> > > > > > > > > > > broken.
> > > > > > > > > >
> > > > > > > > > > ok intresting. Note that if userspace processes vqs it should process
> > > > > > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > > > > > vacation, let me ponder this a bit.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Sure.
> > > > > > > >
> > > > > > > > So let me ask you this, how are you going to handle device reset?
> > > > > > > > Same issue, it seems to me.
> > > > > > > >
> > > > > > >
> > > > > > > Well my proposal is to mark it as broken so it needs to be reset
> > > > > > > manually.
> > > > > >
> > > > > >
> > > > > > Heh but guest assumes after reset device does not poke at guest
> > > > > > memory, and will free up and reuse that memory.
> > > > > > If userspace still pokes at it -> plus plus ungood.
> > > > > >
> > > > >
> > > > > I don't get this part. Once the device is reset, the device should not
> > > > > poke at guest memory (unless it is malicious or similar). Why would it
> > > > > do it?
> > > >
> > > > Friendly ping.
> > >
> > >
> > >
> > > OK I thought about it a bunch. A lot of net drivers actually
> > > just queue ethtool commands and finish them asynchronously.
> > > Thinkably virtio could expose an API on whether it is safe to
> > > wait for buffers to be used. virtio-net would then either
> > > send commands directly or do the asynchronous thing.
> > > Hmm?
> > >
> >
> > I think it's the best solution too, yes. The series [1] implements for
> > set_rx_mode. We can do it for all the CVQ commands and then whitelist
> > them in VDUSE code. Am I missing something? Does anyone foresee any
> > command that will not be possible to convert?
> >
> 
> Adding the [1] link...
> 
> [1] https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyyappan@gmail.com/

what's the status of that one?

