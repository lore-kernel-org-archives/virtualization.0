Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545118643
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422365; cv=none; b=fK+7QHr1o/TVGfJuKbDGFIU5y5QabxZ7v4S63HRFCgIQ5HVeuGn/TT9m7SY6K7cDfbrDhwmrnMXd3Vf75bkJ52uVT0edYbL4xa83R2HnA4fT2/rCl0B9EbD0KcjIbfGgA0oumrJwBbyR7BYiPuWRiFitoBNioYW0WwR+3NBNh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422365; c=relaxed/simple;
	bh=5PpxEpUcZXTUsSxmL3KzijXTV7X465dD3PtkiU/Lq6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjYiMyrV5XQOx74SM2H3mjM18xsE0D9/JKa0spvxcQIf+GE+tK9qAHlsrl8boh6hJm1snlr9AIPEnsxmJyEZ/IAEwAC0qnojySdinXg7TSgHDipXbpXgy2AYHmx95bpyoAdkOLmfT2b3+vXMOhiUutfGG6GyWKr/zzpQ/EO1f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZT5AMKot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZT5AMKot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUC5EM5aqKsivpFfSa2Ci5nWACyLQ337fx39KNuMZpE=;
	b=ZT5AMKot5G/8ScynKe5RaVkqJzRHGHgc9JfhIU7HECJM20+dFTGtKIw8sw8k2vNo/ejrpg
	c0uw5IAtRe/UB4mOE5ZUQoSF2GossefeRgFYu3UtN/BpuEkMNKoKa5AHFMS9w41pwzm35Q
	/05B3mnKjxPVFdJou5TnZwr4IqPJfeI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-UaY_hk99PzaNkYMzIO3PdQ-1; Mon, 08 Jul 2024 03:06:00 -0400
X-MC-Unique: UaY_hk99PzaNkYMzIO3PdQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77d98ed6ebso170726866b.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422359; x=1721027159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUC5EM5aqKsivpFfSa2Ci5nWACyLQ337fx39KNuMZpE=;
        b=a3weLrjqqcsJVrz9IarbSON2cLEYxPDVi9CqfRvqN0uLYrdi4oPfCnW85gD//fGj1i
         fAWPYrcRlGXiiihMkVbb/OozqBwu7SlEIUCRnglSr68vVAqG2Eypx/CUYICK1H5QVlBT
         Zk9VgXUYJ2xZotmTpsFxntK4ixjR1FcMlCv2jFVzLRd8OgcWLNhTI0KZwEPQKEIeTRHo
         2xxmT7+4NTEmfSCcEh3pbZFxTIDBHqCBwXvAP+bfuagaxuRFaSRC+OTdGK/E7wVFcO8h
         8qeYIMCJ4srBRnRccCZeet6Q8XEp4yfNSFdGg2A8rQYl3dS80/hozpc9ZlECXVmn3So9
         i/GA==
X-Forwarded-Encrypted: i=1; AJvYcCVF+m8Zr+C/BVFXwleyBz00pf4UEprWLWFPTdFiAEM3At7cSG/IBNYesRwmzeJPyU3RcJw3hJ5Gl8YK7dOP75dH8n4VRU32i5YGHarOkSI=
X-Gm-Message-State: AOJu0YxqN4PBGmuMlMVcB32i0TGhCkElNzfM0JWWw+LpQvWxIOPnU1GE
	kFjGHiMWcNqZNUk3AlY8MaOs0VhZResFHG3P0NYXzkRprzHmnO4SViUx/Nce5LIYpAWazIxa+i1
	0ryZ6fy479zoMiESlpVmbth3OQsdC2jzAH/g0XTT6SnqzPiNql1UinSG3unsJYoB/Q16G76A18W
	Or7MPrueY3gdut2qNM9IhMJmAPhSGiSuKrxiESdqM=
X-Received: by 2002:a17:906:b11:b0:a77:db36:1ccc with SMTP id a640c23a62f3a-a77db361dbcmr512997066b.24.1720422358881;
        Mon, 08 Jul 2024 00:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJS0DZEsXtrYoLqrPVKVwR9KH5Yv072isEfrtxy78mylm1aqwAVich5MZPYa4GI87sCbQHEPN3vwbfGH+5sWU=
X-Received: by 2002:a17:906:b11:b0:a77:db36:1ccc with SMTP id
 a640c23a62f3a-a77db361dbcmr512995966b.24.1720422358470; Mon, 08 Jul 2024
 00:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
In-Reply-To: <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 8 Jul 2024 15:05:21 +0800
Message-ID: <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> >> The vDPA block simulator always allocated a 128 MiB ram-disk, but some
> >> filesystems (e.g. XFS) may require larger minimum sizes (see
> >> https://issues.redhat.com/browse/RHEL-45951).
> >>
> >> So to allow us to test these filesystems, let's add a module parameter
> >> to control the size of the simulated virtio-blk devices.
> >> The value is mapped directly to the `capacity` field of the virtio-blk
> >> configuration space, so it must be expressed in sector numbers of 512
> >> bytes.
> >>
> >> The default value (0x40000) is the same as the previous value, so the
> >> behavior without setting `capacity` remains unchanged.
> >>
> >> Before this patch or with this patch without setting `capacity`:
> >>   $ modprobe vdpa-sim-blk
> >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/128 MiB)
> >>
> >> After this patch:
> >>   $ modprobe vdpa-sim-blk capacity=614400
> >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/300 MiB)
> >>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >
> >What a hack. Cindy was working on adding control over config
> >space, why can't that be used?
>
> If it can be used easily with virtio-blk device too, it will be great.
> @Cindy do you plan to support that changes for a virtio-blk device too?
>
Hi Stefano
I plan to add support to change the vdpa device's configuration after
it is created. In the first step, I want to use the vdpa tool to add
support for changing the MAC address for the network device. the next
step will also add MTU settings etc
here is the link
https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#t

in the device part, the device needs to implement its function of
int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
       const struct vdpa_dev_set_config *config);
the configuration will be passed by struct vdpa_dev_set_config. I'm
not sure if this kind of design is suitable for you? Really thanks and
any comments are welcome
thanks
Cindy


> In the mean time, for the simulator I thought that this change was fine.
> It's just used for testing and debugging...
>
> My main question is how to use that when we have `shared_backend` set to
> true, since we use that setting to test for example live migration. In
> that case, how do we handle the size of the shared ramdisk between
> devices?
>
> Thanks,
> Stefano
>

