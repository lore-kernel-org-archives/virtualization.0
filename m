Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B727C25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 10:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCA1840FEC;
	Wed, 17 Aug 2022 10:54:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CCA1840FEC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S8+n9d3K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZ_5SaqavWTQ; Wed, 17 Aug 2022 10:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C46240A14;
	Wed, 17 Aug 2022 10:54:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C46240A14
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20E56C0033;
	Wed, 17 Aug 2022 10:54:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86BABC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64BA882F6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:54:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64BA882F6C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S8+n9d3K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BiIGHANXhMdD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:54:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 339F681B48
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 339F681B48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660733642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWHtHY6d40uY0Ij4s58yaxGtL5XuSJS0/N+jf5H/pmM=;
 b=S8+n9d3Kax4NRRwTfe9hCHnS0x43t5BvUwNfVbbp8VBEi6ndhK9Y15mKdOCFx+MSZ5+Uwi
 sF3WUmXKrMhtgWLak5q6Pj8lyU8htzgmXEgXfkOBL7qUbaLV4VT5sQoGeQSXzVBTo21pD1
 6iP3wN9tU5lGa6efxaZd/aVjhomF5bc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280-M60TzYzKPxyjxFe8B0UZWw-1; Wed, 17 Aug 2022 06:54:00 -0400
X-MC-Unique: M60TzYzKPxyjxFe8B0UZWw-1
Received: by mail-wr1-f70.google.com with SMTP id
 d11-20020adfc08b000000b002207555c1f6so2278726wrf.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 03:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=gWHtHY6d40uY0Ij4s58yaxGtL5XuSJS0/N+jf5H/pmM=;
 b=ImEU1LGI9cJ9u79CMtuLpK/NgJzhSPngofyl9ORQoCCHsR3kvon7tPeSlpPHpSqys3
 RzR8iGg8Yw3JP4FabWsDEtos5OC/oSviAkoqrir2s0csx56MpLZnA6Q+UpkQWzGirS09
 o1N2jmj5qNMTifJvn02oNggfydTtFn8fh8FiRpI89tSZf6qx2xmlablPlZLiySfza+9o
 EHMz4piojaCdz0MLc0XYQ3683hka5ecHBVVH+gXUrbv6Ys6tZDts751zLghaJC1CniWi
 1kVksnIvv2DL65gQV9D7qCI9M4WE63SaxvoGdDy4Ood0p426A96RV59uagIeZGu4nCJS
 sjgw==
X-Gm-Message-State: ACgBeo3olF/MbxFh+TgCcyHTt7tvrSVgZMhGRor+yJL9kd13s5psMu+1
 VpR1yl10EvJhJ7fX9TKkUu5kcOT8tTxSbXR75KxbkQNkmox/WmtSf4vzoC80UNKBTJf252yRI4y
 7fLlxp/JxW/tm2vs694c0ulHbccTey13mGbx6wuOpWg==
X-Received: by 2002:a05:600c:4e11:b0:3a5:bfd3:a899 with SMTP id
 b17-20020a05600c4e1100b003a5bfd3a899mr1743698wmq.185.1660733639795; 
 Wed, 17 Aug 2022 03:53:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7d/IR607lJwmB2S6Sw1FJB/dSOGJPbcoQRDZgxOs2ObvWS+6e3HgFTFDQjrws5pZac+mb1Cw==
X-Received: by 2002:a05:600c:4e11:b0:3a5:bfd3:a899 with SMTP id
 b17-20020a05600c4e1100b003a5bfd3a899mr1743679wmq.185.1660733639576; 
 Wed, 17 Aug 2022 03:53:59 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 p27-20020a05600c1d9b00b003a35ec4bf4fsm1905896wms.20.2022.08.17.03.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 03:53:59 -0700 (PDT)
Date: Wed, 17 Aug 2022 06:53:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: upstream kernel crashes
Message-ID: <20220817065207-mutt-send-email-mst@kernel.org>
References: <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
 <20220815161423-mutt-send-email-mst@kernel.org>
 <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
 <20220815170444-mutt-send-email-mst@kernel.org>
 <20220817061359.200970-1-dvyukov@google.com>
 <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1660718191.3631961-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 virtualization@lists.linux-foundation.org,
 James.Bottomley@hansenpartnership.com, torvalds@linux-foundation.org,
 edumazet@google.com, linux@roeck-us.net, netdev@vger.kernel.org, c@redhat.com,
 kuba@kernel.org, pabeni@redhat.com, andres@anarazel.de, davem@davemloft.net,
 Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Aug 17, 2022 at 02:36:31PM +0800, Xuan Zhuo wrote:
> On Wed, 17 Aug 2022 08:13:59 +0200, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Mon, 15 Aug 2022 17:32:06 -0400, Michael wrote:
> > > So if you pass the size parameter for a legacy device it will
> > > try to make the ring smaller and that is not legal with
> > > legacy at all. But the driver treats legacy and modern
> > > the same, it allocates a smaller queue anyway.
> > >
> > > Lo and behold, I pass disable-modern=on to qemu and it happily
> > > corrupts memory exactly the same as GCP does.
> >
> > Ouch!
> >
> > I understand that the host does the actual corruption,
> > but could you think of any additional debug checking in the guest
> > that would caught this in future? Potentially only when KASAN
> > is enabled which can verify validity of memory ranges.
> > Some kind of additional layer of sanity checking.
> >
> > This caused a bit of a havoc for syzbot with almost 100 unique
> > crash signatures, so would be useful to catch such issues more
> > reliably in future.
> 
> We can add a check to vring size before calling vp_legacy_set_queue_address().
> Checking the memory range directly is a bit cumbersome.
> 
> Thanks.

With a comment along the lines of

/* Legacy virtio pci has no way to communicate a change in vq size to
 * the hypervisor. If ring sizes don't match hypervisor will happily
 * corrupt memory.
 */


> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2257f1b3d8ae..0673831f45b6 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -146,6 +146,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>                 goto out_del_vq;
>         }
> 
> +       BUG_ON(num != virtqueue_get_vring_size(vq));
> +
>         /* activate the queue */
>         vp_legacy_set_queue_address(&vp_dev->ldev, index, q_pfn);
> 
> 
> >
> > Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
