Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FB3FB94
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425601; cv=none; b=mAWuw7Uj48mpM4kgGVyIqgjAKqU7uJqvysC/6mvwEg74uyLWHcaaGzgMrdNYK3x+4ZebR/1NL0mZ6RoFTIq280XWDauCtFMSZhEZHNXv9euHgPpsVXd6JkPF7d5vv/NGKRX1tI/5cmhtegQ0FiEs1aa1p2narX9c2DIbUXA+Ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425601; c=relaxed/simple;
	bh=ypDmDEIJunc+6xP57YDvnppUbdocORL0n8/UmNVySjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9Kq5fXPETmZ2Mfl8d5I0CGW4MaDIalj301KpPMr9qzBId8Yz/cuZIvzww7QphjvCVSGpF2wDlwNdVUTk20fkrOOH6a8DeZ3W8DlrtkBJomERS7QbhC2z6gqob1ZpMG+nfM8n+SnszsZjFqABrMUTIUQhsElJ/ldL6VNpr1QEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDldCTKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDldCTKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720425599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jzZKzgZN5yjTgMZLmwwMWyTGMohkBEx3Wj3DoxAjmE=;
	b=bDldCTKDbiml3/LrnELQEt4LNoeCFQFpx00BAQcq4fkBN7o4my+1ZXCgw9tyOl0FgHyba7
	vagqYmZJZox6CUPp8FGYAEJtofEj1o17bYzpaWwuqiwqDxttfAaG6TNrJorQKQqRjCt0UV
	bZvbZO4hj4LisNU179Vd2rbHzb0CBCA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-j5Rm_XceM-mXq47oIohIsg-1; Mon, 08 Jul 2024 03:59:57 -0400
X-MC-Unique: j5Rm_XceM-mXq47oIohIsg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-48ffe4ab42aso1167738137.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425597; x=1721030397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jzZKzgZN5yjTgMZLmwwMWyTGMohkBEx3Wj3DoxAjmE=;
        b=pFZa4Gduj5a0JHQsE5ljy96jYXlSjMM923bG90B2tbTBnhSn/r8zo/0IOrMG2Qt+x+
         RtQmn1j113f6gkBWrdUNRaJKQ7eJ+5veDTyCWJXhdPr5T+wz8ni0aoe1dki7+2Tb0xC2
         3sV2SvWxjpCxqrPE+umXjvGEOgQ+N80eIgJPgdSnzb3IPOOqe+TlqZSastLlQjCTk5y/
         wgyekkOmGh6QIQhoOomVXYmmMWv/T7X0n/wVOb8+ecNzLT7iFbLqYnKkvIbEvpTfaBkI
         nuo5hL9SvitDWEhMhS9LLpijT5gZ76ZYskOZb81pyAjk2hKtB2oNAc87X1xue6jt0TDQ
         ushA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ee4bbYeS9FUi1AbHg7ThB1xMOnz4ITc6WC92/+wr4OrVOLbymQ1uymrU/Zu19M4MnlbPXNYpi8xFpZR2jiQbUj/WYAo/WM/hY/18QyM=
X-Gm-Message-State: AOJu0YyggQ2ENXItvstjbwtYh9oXxqsUfvB9OzlmeyTUl6sdI88ueuO9
	h7/skWyGXY7J6sKr2RLqYCxtIjkJo2DfLjfpqOmXsUDCdBgtj1cBwisauMSLV7tKCpAtxWX+sa5
	V5IzcgCyE98EXi0xAn0amqQ8C0W1JgCZLZ4d6W2wEqBXakhYVRj81ZTbKnHG0+vjoHT85mD+O2S
	1W2guvV8MNs3E4fIDXQyZAm3ff96rZW5ZOwZol7oE=
X-Received: by 2002:a05:6102:d7:b0:48f:df86:db3 with SMTP id ada2fe7eead31-48fee64f3b0mr11277519137.3.1720425597087;
        Mon, 08 Jul 2024 00:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV8fdac+V6whxgl1p91S7RDh/uQhPFnx4tc0vbRT4tU2Zuap5wcKUpOT9KSKXPDq+v4OlMSYZafBNo2LVtRrY=
X-Received: by 2002:a05:6102:d7:b0:48f:df86:db3 with SMTP id
 ada2fe7eead31-48fee64f3b0mr11277502137.3.1720425596652; Mon, 08 Jul 2024
 00:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705112821.144819-1-sgarzare@redhat.com> <20240705073017-mutt-send-email-mst@kernel.org>
 <25fehn7xgvqyqgd6zcscsjazzfhktyjrazffyrtbp2oibnhkey@ggobdyv4zxkf> <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
In-Reply-To: <CACLfguWtcdTM-+GjiXWC-s=d-bvkUedHbCimzsfvYXWJ-=3iDQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:59:34 +0800
Message-ID: <CACGkMEurseUpMKaiLpJEkcT9U_tmqm4yqp3OgR--6XnAY=C9WQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add `capacity` module parameter
To: Cindy Lu <lulu@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:06=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Fri, 5 Jul 2024 at 20:42, Stefano Garzarella <sgarzare@redhat.com> wro=
te:
> >
> > On Fri, Jul 05, 2024 at 07:30:51AM GMT, Michael S. Tsirkin wrote:
> > >On Fri, Jul 05, 2024 at 01:28:21PM +0200, Stefano Garzarella wrote:
> > >> The vDPA block simulator always allocated a 128 MiB ram-disk, but so=
me
> > >> filesystems (e.g. XFS) may require larger minimum sizes (see
> > >> https://issues.redhat.com/browse/RHEL-45951).
> > >>
> > >> So to allow us to test these filesystems, let's add a module paramet=
er
> > >> to control the size of the simulated virtio-blk devices.
> > >> The value is mapped directly to the `capacity` field of the virtio-b=
lk
> > >> configuration space, so it must be expressed in sector numbers of 51=
2
> > >> bytes.
> > >>
> > >> The default value (0x40000) is the same as the previous value, so th=
e
> > >> behavior without setting `capacity` remains unchanged.
> > >>
> > >> Before this patch or with this patch without setting `capacity`:
> > >>   $ modprobe vdpa-sim-blk
> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> > >>   virtio_blk virtio6: [vdb] 262144 512-byte logical blocks (134 MB/1=
28 MiB)
> > >>
> > >> After this patch:
> > >>   $ modprobe vdpa-sim-blk capacity=3D614400
> > >>   $ vdpa dev add mgmtdev vdpasim_blk name blk0
> > >>   virtio_blk virtio6: 1/0/0 default/read/poll queues
> > >>   virtio_blk virtio6: [vdb] 614400 512-byte logical blocks (315 MB/3=
00 MiB)
> > >>
> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > >What a hack. Cindy was working on adding control over config
> > >space, why can't that be used?
> >
> > If it can be used easily with virtio-blk device too, it will be great.
> > @Cindy do you plan to support that changes for a virtio-blk device too?
> >
> Hi Stefano
> I plan to add support to change the vdpa device's configuration after
> it is created.

I think for Stefano's case, we can just implement it via provisioning
parameters?

Thanks

> In the first step, I want to use the vdpa tool to add
> support for changing the MAC address for the network device. the next
> step will also add MTU settings etc
> here is the link
> https://lore.kernel.org/all/20240708064820.88955-1-lulu@redhat.com/T/#t
>
> in the device part, the device needs to implement its function of
> int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
>        const struct vdpa_dev_set_config *config);
> the configuration will be passed by struct vdpa_dev_set_config. I'm
> not sure if this kind of design is suitable for you? Really thanks and
> any comments are welcome
> thanks
> Cindy
>
>
> > In the mean time, for the simulator I thought that this change was fine=
.
> > It's just used for testing and debugging...
> >
> > My main question is how to use that when we have `shared_backend` set t=
o
> > true, since we use that setting to test for example live migration. In
> > that case, how do we handle the size of the shared ramdisk between
> > devices?
> >
> > Thanks,
> > Stefano
> >
>

