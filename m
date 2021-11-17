Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24934C433EF
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 06:00:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AFD613D3
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 06:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8AFD613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77F324053F;
	Wed, 17 Nov 2021 06:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QNKQqBfXSAPK; Wed, 17 Nov 2021 06:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B40D140139;
	Wed, 17 Nov 2021 06:00:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 971E0C001E;
	Wed, 17 Nov 2021 06:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3F5EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4B99405A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXHx4le7TvNW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:00:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C400405C1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 06:00:03 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id bk14so4004807oib.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 22:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kSGc4ZU3kMNV4pDWr3dTCqenmyUswpL++6XUnwpYb58=;
 b=7c7d9HtTbjMh1xMFTx5QGxIrdsXn1JI9YRElbu+ZqHFJsqK2AF17sH/DWoIcAvgO1L
 FUKjZ6HlMNIsRREeVQH86AcW1VL8HH3mT/9F8Fw09xBw1/cNGqBKlV01Zk9PYpIITM/n
 1PA5O0SPFyvEnx44UPrNPp2GJyX9kB7wvCzdxZpz/V8DwrCAhaa9ixkAWLRYejYpPfoO
 hxxvH37k+OMXfLmA5IKJV5bqUhY2ZXlEQsj0KUYy2nxapOOtl3keoGl6u+6R+amyebt4
 UAdiaraI25ZMwqbwnNvzH+IG/64wWtPcPfRSUuMuePLek4E3SJ+i2cmlWrgQP6M5Hxd1
 bjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kSGc4ZU3kMNV4pDWr3dTCqenmyUswpL++6XUnwpYb58=;
 b=XoThggEt/kw/93SrN4IEvIdWQTJ83lf6X3eWLqEY6LcPK0qVIkbuIHRxpsgsdEkD9y
 VKM/0LIsWdiqNHzLz2ehaPknhT+2sTrD3lhyJxAQ1mvQssfbEqhMRptS2JKoNG7RjvgY
 BoB0rfm9Rr3OcUBOQJAoiITadjjfadQ9o9XUpnd4E/EuQ5cg9lj9hSJC7isBzVsLoNyS
 KQ/h6eUTuw78nwulwWTRKkxEvv52zsH9DSnRkqspvDs0dCuVuQZMBA4Ene1LHRpIzES2
 HMHkFrn3NqvxJlomMWgTBU51TiluAtjVdqcYqYyG882Pl/2IE+xiGc0mRyY1K2nAO0v2
 G+hA==
X-Gm-Message-State: AOAM532jfcXFyuA7a5WTnFdxru2SirSbxmkGs163/vxFxwVUTEsuYONg
 61b9dHXY7zpjmzdRe9fQaTLKLNASksVljUqZapgMbA==
X-Google-Smtp-Source: ABdhPJyY/WqLFoKyV7MDHc0Omfxi30xLTaWZemyxDXwUFuCZxXL/MS1QKFZhNHj9aUUnq4wuTADld82ehMllqGmhACk=
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr11417825oiy.169.1637128802620; 
 Tue, 16 Nov 2021 22:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20211031045959.143001-1-andrew@daynix.com>
 <20211031045959.143001-3-andrew@daynix.com>
 <20211101044051-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211101044051-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Wed, 17 Nov 2021 08:00:00 +0200
Message-ID: <CABcq3pGuM6tD3P+zfBE6SZ3y7uxV5wYUZZ6GVqRsydtHkeTM2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] drivers/net/virtio_net: Changed mergeable buffer
 length calculation.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Yan Vugenfirer <yan@daynix.com>, kuba@kernel.org, davem@davemloft.net
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

On Mon, Nov 1, 2021 at 10:44 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Oct 31, 2021 at 06:59:57AM +0200, Andrew Melnychenko wrote:
> > Now minimal virtual header length is may include the entire v1 header
> > if the hash report were populated.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>
> subject isn't really descriptive. changed it how?
>
> And I couldn't really decypher what this log entry means either.
>

I'll change it in the next patch.
So, I've tried to ensure that the v1 header with the hash report will
be available if required in new patches.

> > ---
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b72b21ac8ebd..abca2e93355d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -393,7 +393,9 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >       hdr_p = p;
> >
> >       hdr_len = vi->hdr_len;
> > -     if (vi->mergeable_rx_bufs)
> > +     if (vi->has_rss_hash_report)
> > +             hdr_padded_len = sizeof(struct virtio_net_hdr_v1_hash);
> > +     else if (vi->mergeable_rx_bufs)
> >               hdr_padded_len = sizeof(*hdr);
> >       else
> >               hdr_padded_len = sizeof(struct padded_vnet_hdr);
> > @@ -1252,7 +1254,7 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
> >                                         struct ewma_pkt_len *avg_pkt_len,
> >                                         unsigned int room)
> >  {
> > -     const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> > +     const size_t hdr_len = ((struct virtnet_info *)(rq->vq->vdev->priv))->hdr_len;
> >       unsigned int len;
> >
> >       if (room)
>
> Is this pointer chasing the best we can do?

I'll change that.

>
> > @@ -2817,7 +2819,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
> >   */
> >  static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqueue *vq)
> >  {
> > -     const unsigned int hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> > +     const unsigned int hdr_len = vi->hdr_len;
> >       unsigned int rq_size = virtqueue_get_vring_size(vq);
> >       unsigned int packet_len = vi->big_packets ? IP_MAX_MTU : vi->dev->max_mtu;
> >       unsigned int buf_len = hdr_len + ETH_HLEN + VLAN_HLEN + packet_len;
> > --
> > 2.33.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
