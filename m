Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981310793
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNEZV5oQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBA1C61554
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 05:38:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBA1C61554
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jNEZV5oQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id unUc8OtFvAWE
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 05:38:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 332D960BE1
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 05:38:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 332D960BE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701927495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ai5DO0Cfp1PPj3ZIKS8MLYPNItsHlLLpOuCGM9mTYs=;
	b=jNEZV5oQyf7RREP5Aji7RLLMbjAhBMml2guVD9zD0JSXBT3Y4KKc6HwWVzQ9PEQfDJYAVk
	Tqud4GcKyHIA7rL+G79QTpQ/fo0V8k77NdeiSL8hZzmwQP94f1KWCsR7DcV42Z/wAjhkGK
	MNXShNJA1olI/Wd9Ez3JXHc2ZEnD8y8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-J8nRJOocP0WUvPKm1NoYDQ-1; Thu, 07 Dec 2023 00:38:12 -0500
X-MC-Unique: J8nRJOocP0WUvPKm1NoYDQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1af03481bso442478a12.1
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 21:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927491; x=1702532291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ai5DO0Cfp1PPj3ZIKS8MLYPNItsHlLLpOuCGM9mTYs=;
        b=Z/gj2KAh//dRSFSd6TUFJYt78/7RJF9JKAF6hvcVK11DWzj6S2U20P3yhAv1PWkTv/
         e53oWpFMBe9b4/H/f6YrF0FBhu2CAflr1JPErYvFr+TeAoZd53GY8Z63kregUciEb8So
         a4G8LV1NgPjBAMx2fCW2CIRFj6C8myYjjC2m71P7UsPz2rQqsUc39NBetsATlB7ilw4r
         zlBq/MkAKbafuiCNhNnmVJ9XZid4A3DwSiUiKw8kqIykAarOnjVegtBGNrj7wcQi2wAQ
         X29+LW7OeqioWoRPZ9SmI2QBNdbYSxDiRYhpfFB9G9AqMZoAFW8iAZSuHcxGb1fw89Sw
         W6Jg==
X-Gm-Message-State: AOJu0YwjC1PcwhxqdLPZLMn4qYCbV2iyF7p3fMn02VTcgyXkMmszlzgN
	oTxvwvCtOezbtkDGnZ3u/dN6oMvUdCEglJ6UKfbEocExizVtvGFhItFYjWwLkiUWLacfsMIyMfn
	eF11BXoqq1cwVK61EIkFHVtuQvqJJ27FxU40oFKvBiJ2FmcbeW7d3OwUzTA==
X-Received: by 2002:a05:6a20:8423:b0:18f:97c:b9f9 with SMTP id c35-20020a056a20842300b0018f097cb9f9mr1767121pzd.83.1701927491685;
        Wed, 06 Dec 2023 21:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUOVdyjWCrXeQybvQLQpGXRzr1iNy4eVpkwvtiyRNkNgsHZSfU/ptEuy4nAM7TyDUYuSdXgYQo8BZF6lW/uk4=
X-Received: by 2002:a05:6a20:8423:b0:18f:97c:b9f9 with SMTP id
 c35-20020a056a20842300b0018f097cb9f9mr1767113pzd.83.1701927491370; Wed, 06
 Dec 2023 21:38:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com>
 <20231204072331.73776-2-xuanzhuo@linux.alibaba.com> <CACGkMEtGob7VDCgmGoLxR0FpAngKVx8iAVWcQ1v3gCFzeMg_hw@mail.gmail.com>
 <1701847237.4624786-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1701847237.4624786-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:38:00 +0800
Message-ID: <CACGkMEs72FF9PR6LzcdUn=3JAu0H23Z8SaPJyjEbxOEkW60N8w@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:46=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Tue, 5 Dec 2023 15:12:03 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Mon, Dec 4, 2023 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > get buf from virtio core for premapped mode.
> > >
> > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > have many desc. Every desc dma address need to be unmap. So here we
> > > introduce a new helper to collect the dma address of the buffer from
> > > the virtio core.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 157 +++++++++++++++++++++++----------=
--
> > >  include/linux/virtio.h       |  16 ++++
> > >  2 files changed, 121 insertions(+), 52 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 51d8f3299c10..103d181f05bb 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -362,6 +362,26 @@ static struct device *vring_dma_dev(const struct=
 vring_virtqueue *vq)
> > >         return vq->dma_dev;
> > >  }
> > >
> > > +static void collect_dma_info(const struct vring_virtqueue *vq,
> >
> > Not a native speaker, but it looks to me like "get_dma_info" is better =
here.
>
> get_dma_info?
>
> This function collect the dma info to the dma array.
> Not to the dirver. So do you also think "get_dma_info" is better?

Not sure, it's not a must, you know I'm not a native speaker.

>
> >
> > > +                            struct virtio_dma_head *dma,
> > > +                            dma_addr_t addr, unsigned int length)
> > > +{
> > > +       if (WARN_ON_ONCE(!dma))
> > > +               return;
> >
> > So all the callers did:
> >
> > if (!vq->do_unmap)
> >     collect_dma_info()
> >
> > It's a strong hint that we should move the vq->do_unmap inside
> > collect_dma_info()?
>
> No,
> vq->do_unmap affects the logic of caller.
>
> Such as:
>
>         if (!vq->do_unmap) {
>                 collect_dma_info(vq, dma, le64_to_cpu(desc->addr), le32_t=
o_cpu(desc->len));
>                 return;
>         }
>
> So we should move it to this function.

I'm not sure I get here, but we can let collect_dma_info() return
boolean anyhow.

Thanks

