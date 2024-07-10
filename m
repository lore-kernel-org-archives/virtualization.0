Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F428683
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580949; cv=none; b=L6N9PTg0AI8AuxulLKLdRABYL7evoppIDpcOONXYlK/GLXxQEoiteYRRYOZl4KYqF6n9+PSKKWi0xGRYheqZ1bN8gSvLB2VklzMcJiIQl+Z1GWch7ZyLZzjmHFOHEkw+ucOM6PBzbodz2VWSqd7/HfqaXTSliNcxx820WlN05nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580949; c=relaxed/simple;
	bh=/MvzhGdw8waONEHA70dA0HzNSDYITuwzxeG8ol/+5kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2ZBJw1nfxz5Ec+AKRh0btVIgOifyFlPEKD7H/MabqmeQNKb7aegyI7+sNQE/Ah+oiEMVjlyvFUT5ZUBhSw0OITj11G8sw78ZddXCLA8qd+RYDe40C/JAgVAmH04MrlKX7727xRkFCm/OVU6okzD/ZhvrM+poUDAWoBfKVX4VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEL/+NFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEL/+NFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720580945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtjUgfBnvEdcnuYkpErjDK0yllYPZKaeYZrSgLDplBQ=;
	b=XEL/+NFQreYKaD7fGEt+iIuZZgsEUNIY0h3uunSnO/WoOut1mmngFqZ9cSxCepfB+pp1Gj
	m6k1oo/VhAUaT773GsZYGu5AFacZU+8NQqtzjc0RJKp+e/isowsJtAK8DVYCVc3ylll6fg
	upoOGF01FMvL/YNGcWsW7v+DZUZT6iU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-AadNMdMcPYu-PJu8k-8qvA-1; Tue, 09 Jul 2024 23:09:03 -0400
X-MC-Unique: AadNMdMcPYu-PJu8k-8qvA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-78296514ec8so264712a12.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 20:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580942; x=1721185742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtjUgfBnvEdcnuYkpErjDK0yllYPZKaeYZrSgLDplBQ=;
        b=OeqHqvZHfPUDlwzXkConWEy5uZoQeaN1v61Uy1QAYlXFwUVpi6sPMhjXZdSUzBDEMq
         KiARBAfM4lJOW1Gxf8F6D0FS7bpxBgnnnEU0TKda69jPr0tVZ8M+qI8jVVDauuUHum7V
         53lF3H5qPUwbB002H+ZLPmLBckVYgIsEBIuDKVyOOvUOeunQ/l/masejSoFTAVIgdtub
         Kdmc4E9K01HejnER9FwfgZzJW4P7XZVN/AibiwuTjK+nWmYLb5OuXMkRAtag7lYhMFsn
         hk6mtH4MldE+kylIF31ROb/I+El29VPQUKFyCqitCEliBk5KU/jXQffngRScso9pf+n6
         XXLA==
X-Forwarded-Encrypted: i=1; AJvYcCWnqNdrmGEF4dXlOFXKJlIl0B+jswQwp3hTv8RFxa7yrZ/9/GZXuLV2EwUMCSK8PloK6ymQFPyd4UJ3woKSGxNVq5IoiQJpnfE7K/eeCTA=
X-Gm-Message-State: AOJu0YzEQuZJFraUH/ScMZHmJZT1XASHJyhnWHQFjAHGPuuv/Urj+FB5
	M+tuE9MqT0025eWim3+i1hGiii1jz2gvq38W0M30YUIuvRxkxGBGE70oQnv8ErHkTfnYzRNEHz/
	MQaxc42zOP5Mj8ok1r4lC24rvXKnx0Denx+fgXz9+NgfH0mdzoBXhcMFG7If8OS+BBHuAmY2xhf
	PAHlXSG+qF0CZCDaZ7Wyz1J/TxsChHwIjy1qtMSZhL2YGNjz4=
X-Received: by 2002:a17:90b:23d6:b0:2c3:2f5a:17d4 with SMTP id 98e67ed59e1d1-2ca3a7afcf8mr5871264a91.4.1720580941677;
        Tue, 09 Jul 2024 20:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKDc/1Dtvd390ol22IDK0nztZPRuQFQegrbwO23fBGP+oSlzmkMroUM5jdeYtFVpiK621EJ8u9fx6xJpJeXac=
X-Received: by 2002:a17:90b:23d6:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2ca3a7afcf8mr5871237a91.4.1720580941065; Tue, 09 Jul 2024
 20:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf>
 <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
 <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
 <3f5d33l4c73nudppajvhnjhpdpvft5yolm7vdraikany2tfdjz@i62d45j4ucs5>
 <CACGkMEuqiAx-a0sPJf0Xpvmr=5wbzbuOr0-w+9ZcwQMTWFU1rw@mail.gmail.com> <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
In-Reply-To: <xuruyrbkago7w7tjbvqmfvjoqy665srurqozbenfayagfxl72y@wqy56jenfo2u>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:08:48 +0800
Message-ID: <CACGkMEtB1maGywWRPNHgVGJog+rbowXvKG0nEDXPn_9-VB0Azw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:41=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Jul 09, 2024 at 10:56:16AM GMT, Jason Wang wrote:
> >On Mon, Jul 8, 2024 at 4:15=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> Hi Cindy, Jason,
> >>
> >> On Mon, Jul 08, 2024 at 03:59:34PM GMT, Jason Wang wrote:
> >> >On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> wro=
te:
> >> >>
> >> >> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.co=
m> wrote:
> >> >> >
> >> >> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> >> >> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wro=
te:
> >> >> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, =
but some
> >> >> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
> >> >> > >> https://issues.redhat.com/browse/RHEL-45951).
> >> >> > >>
> >> >> > >> So to allow us to test these filesystems, let's add a module p=
arameter
> >> >> > >> to control the size of the simulated virtio-blk devices.
> >> >> > >> The value is mapped directly to the `capacity` field of the vi=
rtio-blk
> >> >> > >> configuration space, so it must be expressed in sector numbers=
 of 512
> >> >> > >> bytes.
> >> >> > >>
> >> >> > >> The default value (0x40000) is the same as the previous value,=
 so the
> >> >> > >> behavior without setting `capacity` remains unchanged.
> >> >> > >>
> >> >> > >> Before this patch or with this patch without setting `capacity=
`:
> >> >> > >>   $ modprobe vdpa-sim-blk
> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> >> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (13=
4 MB/128 MiB)
> >> >> > >>
> >> >> > >> After this patch:
> >> >> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> >> >> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> >> >> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> >> >> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (31=
5 MB/300 MiB)
> >> >> > >>
> >> >> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> > >
> >> >> > >What a hack. Cindy was working on adding control over config
> >> >> > >space, why can't that be used?
> >> >> >
> >> >> > If it can be used easily with virtio-blk device too, it will be g=
reat.
> >> >> > @Cindy do you plan to support that changes for a virtio-blk devic=
e too?
> >> >> >
> >> >> Hi Stefano
> >> >> I plan to add support to change the vdpa device's configuration aft=
er
> >> >> it is created.
> >> >
> >> >I think for Stefano's case, we can just implement it via provisioning
> >> >parameters?
> >>
> >> Yep, I think we don't need to change it after creation, but specifying
> >> while creating should be enough.
> >>
> >> So, IIUC we can already do it, implementing something similar to
> >> vdpasim_net_setup_config() to call during vdpasim_blk_dev_add(), right=
?
> >
> >Right.
> >
> >>
> >> What about when we have `shared_backend` set to true for the
> >> vdpa_sim_blk.ko? In this case the backend is supposed to be shared
> >> between all the devices to test live migration.
> >
> >This seems to be another topic.
>
> Yep, but really related. I think we need to handle that case when
> supporting the `capacity` setting.

Ok, so if I was not wrong, the goal is to test migration.

>
> >
> >>
> >> Maybe we can just change the size of the shared ramdisk to be reflecte=
d
> >> to all devices.
> >>
> >> Suggestions?
> >
> >Could we specify the path to tmpfs or others during provisioning
> >instead?  It seems more general (but more work).
>
> Then it would almost become a real device, no longer just a simulator.
> It's enough work, though, as you said, but at that point we'd just have
> to specify the backend file to use for the device.
>
> In that case what API would we need to use to allow the user to set the
> backend file?

Yes, I think we can allow some vendor specific provisioning parameters.

But not sure it's an overkill for the use case here. If others are
happy with the shared_backed. I'm fine.

Thanks

>
> Thanks,
> Stefano
>

