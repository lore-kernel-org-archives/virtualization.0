Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7641847
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgFA9xdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701960943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFUwTkwUasQAuYCMcpY6aWYFjKBTvsfILYuExDUI9Xs=;
	b=ZgFA9xdlWHPnEk5XYQDa8MYHZ+XRcfgcEZLb+QCHm3wqJpxasAvxauSgqj3OUq/A27fWhB
	EdbENiYaaSid76FsuWL4yxbLKIjgcyI79Qn4W9Yr6FySDjBAJ1EUwEt63fLFehXG0J9WyM
	TXHJVT2KcGeNN/zDPKW6f5aEGCvbh4k=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-g-gIzopkMYWUatMSo1-wxA-1; Thu, 07 Dec 2023 09:55:38 -0500
X-MC-Unique: g-gIzopkMYWUatMSo1-wxA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7c57dae81c5so269895241.0
        for <virtualization@lists.linux.dev>; Thu, 07 Dec 2023 06:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960937; x=1702565737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFUwTkwUasQAuYCMcpY6aWYFjKBTvsfILYuExDUI9Xs=;
        b=WEtJxak1LGxJfuvbsTYohyOHzGVvW1NWxgeVP9Zzy8Me3WXQ9Fab5frGXBM69y0i/S
         TINO9Thi/xP8Riw5tyicKZHs+g1RnbT5yg2BkCAZVePCHQx4fyMKRoHLEKcJ5b2iE/7p
         LmqZXzqOYiiYDPeU908huCEpp+bALXH9vCFEBxXrdDNcsywPQeA/EdpQ5D3fVtRrPLnq
         cY/t+1TyfVmIwzV6m9B1OLOG+5+6IsJYmg8ynRRUK/Twiev0GE8eP+jtXTseFEiEQ9ff
         d5gWGuwY94GiCwn6oU1ZUowFsJ3Vkjzp5cKgeVUMOpO2Vac0jBdvEcQzdJocyRfuNKYq
         3dEA==
X-Gm-Message-State: AOJu0Yyp1J9wAkqfAoVSDaeR6Ruk4YfgdXujFUYkyxAuODotR3WQRfub
	rY/Iq3EJXTXX6Zr9PVsTAodbGg5CyZv1Mtk1hf9MPu3GWetULhmg8EAGZ6e1X8ubKEcA/vaLF2Q
	EUOFLnYoDjVn4nNB2oO9WfASXnCpLLkszi7TmntmKDU8=
X-Received: by 2002:a67:fb0e:0:b0:464:7c84:f2ce with SMTP id d14-20020a67fb0e000000b004647c84f2cemr2428519vsr.33.1701960937522;
        Thu, 07 Dec 2023 06:55:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExPh5/hFE8CE6pwdTcln4SPXa7YsxLmil/VdfPW34AuIerYiD738D5CYb9gwkY7cCXF4lnoAE2qa1q+zUlTFA=
X-Received: by 2002:a67:fb0e:0:b0:464:7c84:f2ce with SMTP id
 d14-20020a67fb0e000000b004647c84f2cemr2428507vsr.33.1701960937193; Thu, 07
 Dec 2023 06:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <20231207145159.GB2147383@fedora>
In-Reply-To: <20231207145159.GB2147383@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 7 Dec 2023 15:55:17 +0100
Message-ID: <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>, Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 3:52=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> > virtio-blk is generally used in cloud computing scenarios, where the
> > performance of virtual disks is very important. The mq-deadline schedul=
er
> > has a big performance drop compared to none with single queue. In my te=
sts,
> > mq-deadline 4k readread iops were 270k compared to 450k for none. So he=
re
> > the default scheduler of virtio-blk is set to "none".
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> >  drivers/block/virtio_blk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems similar to commit f8b12e513b95 ("virtio_blk: revert
> QUEUE_FLAG_VIRT addition") where changing the default sounded good in
> theory but exposed existing users to performance regressions. [...]
> I don't want to be overly conservative. The virtio_blk driver has
> undergone changes in this regard from the legacy block layer to blk-mq
> (without an I/O scheduler) to blk-mq (mq-deadline).

IIRC there were also regressions in both virtio-blk and virtio-scsi
when switching from the legacy block layer to blk-mq. So perhaps I
*am* a bit more conservative, but based on past experience, this patch
seems not to be a great idea for practical use cases.

Paolo

> Performance changed
> at each step and that wasn't a showstopper, so I think we could default
> to 'none' without a lot of damage. Let's just get more data.
>
> Stefan
>
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index d53d6aa8ee69..5183ec8e00be 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vd=
ev)
> >       vblk->tag_set.ops =3D &virtio_mq_ops;
> >       vblk->tag_set.queue_depth =3D queue_depth;
> >       vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> > -     vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> > +     vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED=
_BY_DEFAULT;
> >       vblk->tag_set.cmd_size =3D
> >               sizeof(struct virtblk_req) +
> >               sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> > --
> > 2.42.0
> >

