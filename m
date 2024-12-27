Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8591F3D37
	for <virtualization@lists.linux.dev>; Fri, 27 Dec 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307066; cv=none; b=PZXwU1oMuLqoTaAH6trJ2vnYs4W44uJOAkyuJijt0XjPhDSLxlhUF+vuc4N4N7EDuT1pw0EujHRNMHju4Jq8jwxIbPP3ig3DO7cNyDfigaC5C/4x37Dr1xtvj7uDRf/V75/Ti6u5xSgpwaMGU8Sdl4yfy1kydAoSowE+fJQf7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307066; c=relaxed/simple;
	bh=4zzYeNm0G4x5an1ENK8T8ax8KmpB59TZG1+p2SFmR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DKSizE9mT22UYUHSriXcFfm/GsxQt7Ghr1xefbWLB1ui3w6nc9rNl32v7wcPXiJ9hohrlxx+bjCDd3DkzEcBF0rsnX6XbAiAvX1CviSJnPaax8iKSubP2R3lFnLBYn5FC8s89/WzS6rqmfeHtABLgD+ErSSa6oDWhJ8ilbfSPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRzyLXVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRzyLXVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735307062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkRABZZKzYakdwICymJuZ/C6pfybaqvIa9Xu1kFl1Eo=;
	b=DRzyLXVm9nHJ1cWKWQ3XH+Nkvoo1BsvpzNFGfmGzAdeNtCcVvI5V/6auBefCkDVERWvmpb
	KrYe0St3udSRaOLoLOtRHhiee8AvjTvs4BTtfL3B4Cp4t6Ad9dsv7V1yKfWcXBGoEBMEV6
	r0oBd26GvU+sSK3WSZc48lH8aWlVvGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-m_MTezafNFm-8Da5nXI8Lw-1; Fri, 27 Dec 2024 08:44:21 -0500
X-MC-Unique: m_MTezafNFm-8Da5nXI8Lw-1
X-Mimecast-MFC-AGG-ID: m_MTezafNFm-8Da5nXI8Lw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361f371908so53770075e9.0
        for <virtualization@lists.linux.dev>; Fri, 27 Dec 2024 05:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735307060; x=1735911860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkRABZZKzYakdwICymJuZ/C6pfybaqvIa9Xu1kFl1Eo=;
        b=NJxF6lPe6XucMm3eIEa6O3WOGBlZwtZIKhSqAWWciZRkVPkdo07XO8IYkCVbtOCTOd
         JAOGReM1ka9U3TPmqgpDOoWqbWvZblMQLCsICspmAMyUpD+xy7GIraR/zDZuMJ5QI2aU
         fRT6QC3E5Rm4DRfnEs39Kze0I6Op4YUaD0glZKV/+NsbHn1BxfXHFyahEheHWjESDAZo
         ZivJT85+M0mZz6sn24W4EnQqHrvSRigfRB3xu3lciTG95jhhXDY/FoU/WN+SGWeCXt/X
         7CkKm3o2OVVQUBBTVCVVRZs645krJnNn9IQrN0DgVjY98dy0wb4lLFnVE5AyMYJds2BI
         EtSg==
X-Forwarded-Encrypted: i=1; AJvYcCVaZsIQ7cqHiFaP3Rt+pbYdnFKC/1wctGdP3ZaIbUtRCJAcJxOmqIMGSQjuPvBz88b58PBoHrdVk3rXIpmlJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0wTfWc8rvQ4GQRa9/7wdWgynywTyc2jQ2rj+Ef+9/KPBSCVRN
	mUQdYK4UhyVb5BfqBsPc+xc20wyACr76PCN+tt+XtoQf8dKNnXb0e1fasJ1P+VGBGKU1xiGHRAD
	nxZkK8n12c5+LAX1U66VidRfnU6QsnPk5WG43ARJRkCnie+ePKHxYtZaKWvKOeFXL
X-Gm-Gg: ASbGncstSfg7xzuExR4JhcrkNQhBvzneMj30g8FnxDXO9v0J9S5bB3IqZzJ1aakT4lZ
	9xKqLaVqXjm5TcM6OmXDHe96StjpkP8eho6ODdF7LZk/WhxnGgjK6wPpUzL9t/4/KvymGYsZC6J
	Njmy0qEtp25cq/rlN8E9sOoIufIFVac20lNBU2A7vIRQEsE2YAm8AUDJ2BSdYFPOYxBNpjM9dt3
	vIY/MaAczC8ezj2AIDbQ2Zh5JC7NqdhI1eF3abOhkUE7STfrF0=
X-Received: by 2002:a05:600c:350c:b0:434:a5d1:9905 with SMTP id 5b1f17b1804b1-43668b78641mr208446325e9.26.1735307059835;
        Fri, 27 Dec 2024 05:44:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMBCH5XUAoqBvte6a9jZzUG4oYDe/byrgsu79u/bNlDM1cNL3Mq9Ew3V/u/ELxCrULVT1bWQ==
X-Received: by 2002:a05:600c:350c:b0:434:a5d1:9905 with SMTP id 5b1f17b1804b1-43668b78641mr208446135e9.26.1735307059443;
        Fri, 27 Dec 2024 05:44:19 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ef:ad82:417b:4826:408d:ef87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4d7sm265112715e9.34.2024.12.27.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 05:44:18 -0800 (PST)
Date: Fri, 27 Dec 2024 08:44:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Message-ID: <20241227084256-mutt-send-email-mst@kernel.org>
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
 <20241106035029-mutt-send-email-mst@kernel.org>
 <CACGkMEt0spn59oLyoCwcJDdLeYUEibePF7gppxdVX1YvmAr72Q@mail.gmail.com>
 <20241226064215-mutt-send-email-mst@kernel.org>
 <CACGkMEug-83KTBQjJBEKuYsVY86-mCSMpuGgj-BfcL=m2VFfvA@mail.gmail.com>
 <cd4a2384-33e9-4efd-915a-dd6fee752638@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cd4a2384-33e9-4efd-915a-dd6fee752638@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1rjqdg1QXmxTz7tH5WdOSjZEkvVo4D8FggdrrZpsDw0_1735307060
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 27, 2024 at 01:34:10PM +0900, Akihiko Odaki wrote:
> On 2024/12/27 10:29, Jason Wang wrote:
> > 
> > 
> > On Thu, Dec 26, 2024 at 7:54 PM Michael S. Tsirkin <mst@redhat.com
> > <mailto:mst@redhat.com>> wrote:
> > 
> >     On Mon, Nov 11, 2024 at 09:27:45AM +0800, Jason Wang wrote:
> >      > On Wed, Nov 6, 2024 at 4:54 PM Michael S. Tsirkin <mst@redhat.com
> >     <mailto:mst@redhat.com>> wrote:
> >      > >
> >      > > On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> >      > > > The specification says the device MUST set num_buffers to 1 if
> >      > > > VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> >      > > >
> >      > > > Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> >      > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>
> >      > >
> >      > > True, this is out of spec. But, qemu is also out of spec :(
> >      > >
> >      > > Given how many years this was out there, I wonder whether
> >      > > we should just fix the spec, instead of changing now.
> >      > >
> >      > > Jason, what's your take?
> >      >
> >      > Fixing the spec (if you mean release the requirement) seems to be
> >     less risky.
> >      >
> >      > Thanks
> > 
> >     I looked at the latest spec patch.
> >     Issue is, if we relax the requirement in the spec,
> >     it just might break some drivers.
> > 
> >     Something I did not realize at the time.
> > 
> >     Also, vhost just leaves it uninitialized so there really is no chance
> >     some driver using vhost looks at it and assumes 0.
> > >
> > So it also has no chance to assume it for anything specific value.
> 
> Theoretically, there could be a driver written according to the
> specification and tested with other device implementations that set
> num_buffers to one.
> 
> Practically, I will be surprised if there is such a driver in reality.
> 
> But I also see few reasons to relax the device requirement now; if we used
> to say it should be set to one and there is no better alternative value, why
> don't stick to one?
> 
> I sent v2 for the virtio-spec change that retains the device requirement so
> please tell me what you think about it:
> https://lore.kernel.org/virtio-comment/20241227-reserved-v2-1-de9f9b0a808d@daynix.com/T/#u
> 
> > 
> > 
> >     There is another thing out of spec with vhost at the moment:
> >     it is actually leaving this field in the buffer
> >     uninitialized. Which is out of spec, length supplied by device
> >     must be initialized by device.
> > 
> > 
> > What do you mean by "length" here?
> > 
> > 
> > 
> >     We generally just ask everyone to follow spec.
> > 
> > 
> > Spec can't cover all the behaviour, so there would be some leftovers.
> > 
> >        So now I'm inclined to fix
> >     it, and make a corresponding qemu change.
> > 
> > 
> >     Now, about how to fix it - besides a risk to non-VM workloads, I dislike
> >     doing an extra copy to user into buffer. So maybe we should add an ioctl
> >     to teach tun to set num bufs to 1.
> >     This way userspace has control.
> > 
> > 
> > I'm not sure I will get here. TUN has no knowledge of the mergeable
> > buffers if I understand it correctly.
> 
> I rather want QEMU and other vhost_net users automatically fixed instead of
> opting-in the fix.

qemu can be automatic. kernel I am not sure.

> The extra copy overhead can be almost eliminated if we initialize the field
> in TUN/TAP; they already writes other part of the header so we can simply
> add two bytes there. But I wonder if it's worthwhile.

Try?

> Regards,
> Akihiko Odaki

