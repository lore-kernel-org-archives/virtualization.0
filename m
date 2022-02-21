Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B5AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 01:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5ECB60ADE;
	Mon, 21 Feb 2022 01:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rp19zj0YBi6t; Mon, 21 Feb 2022 01:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55DAA60B65;
	Mon, 21 Feb 2022 01:36:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18811C0021;
	Mon, 21 Feb 2022 01:36:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ECBEC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 01:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 825A3408C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 01:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZ0MUskGk9xm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 01:36:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 548A1408BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645407393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yxnCxwKqNf8UVFdWPaHbJsaZW0i6n80KLKJ9p0uwO1g=;
 b=ZszMm5l5QEwCs6vWRjUHSFs6MJ0NgAHJM3pne2n4Zqygxe4auie5TvCyhBteXLkdI+5SG8
 PD9N49ClPb8B0EcemL5etJ9DLq2GwO9l8JlUU4UwDj74aML3W54SkqQaUcbxZAe/7DqbyD
 QDBMCvM3WLcCDEycAkCyzDLwXkVivUM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-YQiSkzl9Np60WfsBy6WagA-1; Sun, 20 Feb 2022 20:36:32 -0500
X-MC-Unique: YQiSkzl9Np60WfsBy6WagA-1
Received: by mail-lj1-f200.google.com with SMTP id
 x8-20020a2ea7c8000000b00246215e0fc3so3314631ljp.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 17:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yxnCxwKqNf8UVFdWPaHbJsaZW0i6n80KLKJ9p0uwO1g=;
 b=5rfhCBNIWdGPXk9P3v4hJjHzVNBnmlCihsv/u+jiqjC5jzcyH9tw7A6i8RY8POVxfb
 X2V1V4edl6SVN4JYTm+43Qq9NKeOYRdkEzcACoxnAKyL0fiK9Y2OclWSxi2vIM1PaYh2
 Ic6lwJD5vPTFR7EbHdHeqriCfmWpIlpvClFeJxl3unTxbUgcr616H9KeBGSyLSm52JWB
 YdmRJNy7aStprpc11YmQt+JHI29YTNbY2tfVbDCPyrnHZQvoDWjN0WIBRTTXE275ZrwD
 JZZhp5HXSIc9qXtsv6l8GqAHCHtOy59Io86Z28o11mavtLvP8rniSAPbcGllQEleooj5
 bk4w==
X-Gm-Message-State: AOAM533P2SOc0Wvhd1enmPNH9L0a9SfKN/jKdNvtRa+skBVPht0st+PP
 MTuhazjVyPON0PAcvWzHc9Vl4YFitqaiShrurxTdkTI2KWk+a9DaF9kv7Sn0UVvI60h66lixAtt
 Z4umDc5zy/rExwJpIyaFQC8uMDBNiOaK+UIsXacWG+DMpMKPkwI0NRD+rEg==
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr12771014lji.420.1645407390807; 
 Sun, 20 Feb 2022 17:36:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGeDL/sWSVAlchobOdI9odbustbUKSgMKZ4Oib9qAmOLs5VoYGQSFIp07iJGkgs/5DDNYNyPlaZm6dzfVK2+M=
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr12771006lji.420.1645407390588; Sun, 20
 Feb 2022 17:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <20220218041948-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220218041948-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Feb 2022 09:36:19 +0800
Message-ID: <CACGkMEsgKJxakz5hSumJxzvf1tndqSS3ATLCDpFfU+5X0_5zXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Feb 18, 2022 at 5:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 18, 2022 at 04:55:23PM +0800, Xuan Zhuo wrote:
> > On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > virtqueue_add().
> > > >
> > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > >
> > > I'd suggest rename this feature as "unmanaged DMA".
> >
> > OK
>
> IIUC when you say "dma is completed" you really mean "memory is mapped
> for dma". What is special is that virtio suddenly gets s/g that is
> already mapped for DMA, not in the way DMA (direct memory access) itself
> happens. right? Pls document as such.
> And this is why I'd call this flag "mapped" or "premapped", not
> "predma". "unmanaged" is also ok, though it's a bit vague wrt what
> exactly is managed.
> I'll defer to Jason on this.  Jason what do you prefer?

I think "premapped" should be fine.

Thanks

>
> > >
> > > >
> > > > Record this predma information in extra->flags, which can be skipped when
> > > > executing dma unmap.
> > >
> > > Question still, can we use per-virtqueue flag instead of per
> > > descriptor flag? If my memory is correct, the answer is yes in the
> > > discussion for the previous version.
> > >
> >
> > Yes.
> >
> > per-virtqueue? I guess it should be per-submit.
> >
> > This patch set only adds a flag to desc_extra[head].flags, so that we can know
> > if we need to unmap dma when we detach.
> >
> > Thanks.
> >
> > > Thanks
> > >
> > > >
> > > > v1:
> > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > >       of them are not supported to be PREDMA
> > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > >       together with the next time AF_XDP supports virtio dma
> > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > >       indirect desc
> > > >
> > > > Xuan Zhuo (6):
> > > >   virtio: rename vring_unmap_state_packed() to
> > > >     vring_unmap_extra_packed()
> > > >   virtio: remove flags check for unmap split indirect desc
> > > >   virtio: remove flags check for unmap packed indirect desc
> > > >   virtio: virtqueue_add() support predma
> > > >   virtio: split: virtqueue_add_split() support dma address
> > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > >
> > > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > > >
> > > > --
> > > > 2.31.0
> > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
