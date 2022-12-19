Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB94C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 07:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C7F60B15;
	Mon, 19 Dec 2022 07:40:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18C7F60B15
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkH3RAeE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PM59eQfuvAQY; Mon, 19 Dec 2022 07:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93900605E0;
	Mon, 19 Dec 2022 07:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93900605E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69657C0032;
	Mon, 19 Dec 2022 07:39:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E25E4C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACB3740124
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACB3740124
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkH3RAeE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QhDtBIe9-l0O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F21D1400F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F21D1400F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671435593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w11vatQNVAnUlnMv1dmIAsVTD8BgrqYdlE5ppWAhfcU=;
 b=QkH3RAeEHOefS3aX62LvTskihBDnOvtaFHGOzWxOQE+Hb7RhCWo8maUkSecVaL/9d8+ck3
 zkSqbZjpwpmvQAVc9rMdcwg2K09EtgEewsa5ElR3VuDg0Wi+cLqHYWe32kF27w8LS8NOph
 hlHbY3nCrElmQEJx750AiYIWKXMKUn0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-hV6TfKfAMma7djSGMnUiug-1; Mon, 19 Dec 2022 02:39:52 -0500
X-MC-Unique: hV6TfKfAMma7djSGMnUiug-1
Received: by mail-qk1-f200.google.com with SMTP id
 h13-20020a05620a244d00b006fb713618b8so6835932qkn.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Dec 2022 23:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w11vatQNVAnUlnMv1dmIAsVTD8BgrqYdlE5ppWAhfcU=;
 b=kSSEwGil8xIz46nKTT/Y8jJ3Cb0n4+GDI03OCtswssSk55f73dD2tihDpps7Bj1l/y
 hsAmW8GmdujfPoReMREgv44x2tQqjabNGgTXTLVnuLe/TtB1FAC9LxEhonb9JiwZKBVl
 KDH+dYJMZqOpabgqcPOIEAAFm18smQMy/m1GJ4O0EZl1qISmNNGvjbWUoOcN1zNKFuWX
 CKdNj4VWuL2I2j88Ae1z2KfOzaoZhBJn68qFvWKHJyQrCw0iQM+4TfZ1qPTYZPE00xhU
 eEgpfp7GcVeuxOhf55kedpgNc4adq+QyOudnBKV9a0rFxN2pPtnoPg9mUyqNdR31hGnE
 5lcA==
X-Gm-Message-State: ANoB5pkn2OKMh6Ti8i6iZLSiI0IjZ1zhoehjxCE5W/bGKGoSuzk53oLW
 YPfr9T9Zo64w2a3yTaYZ6y+LakZY7cZcFaUhKeyN7qPqavxgpk88WTFYMfTKC1b6zPxQJ8/e7k1
 Yn/XW2uwouTn7jmYSLiHoQ6OaaBw8rZlcXa8uAaps0w==
X-Received: by 2002:ac8:5544:0:b0:3a8:b88:c1 with SMTP id
 o4-20020ac85544000000b003a80b8800c1mr51790081qtr.66.1671435591906; 
 Sun, 18 Dec 2022 23:39:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+jlbEi9Hng1kQBhZFIW+Ck6EaPnOm37evbb26ZWZOc9ge1j5bCv1B5OdL+PMwpgyh21WQcw==
X-Received: by 2002:ac8:5544:0:b0:3a8:b88:c1 with SMTP id
 o4-20020ac85544000000b003a80b8800c1mr51790067qtr.66.1671435591645; 
 Sun, 18 Dec 2022 23:39:51 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 cj23-20020a05622a259700b003a7f597dc60sm5645751qtb.72.2022.12.18.23.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Dec 2022 23:39:51 -0800 (PST)
Date: Mon, 19 Dec 2022 02:39:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
Message-ID: <20221219023900-mutt-send-email-mst@kernel.org>
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Andrey Smetanin <asmetanin@yandex-team.ru>, yc-core@yandex-team.ru
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

On Thu, Dec 01, 2022 at 05:01:58PM +0800, Jason Wang wrote:
> On Wed, Nov 23, 2022 at 6:24 PM Andrey Smetanin
> <asmetanin@yandex-team.ru> wrote:
> >
> > Fix possible virtqueue used buffers leak and corresponding stuck
> > in case of temporary -EIO from sendmsg() which is produced by
> > tun driver while backend device is not up.
> >
> > In case of no-retriable error and zcopy do not revert upend_idx
> > to pass packet data (that is update used_idx in corresponding
> > vhost_zerocopy_signal_used()) as if packet data has been
> > transferred successfully.
> 
> Should we mark head.len as VHOST_DMA_DONE_LEN in this case?
> 
> Thanks

Any response here?


> >
> > Signed-off-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> > ---
> >  drivers/vhost/net.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 20265393aee7..93e9166039b9 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -934,13 +934,16 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> >
> >                 err = sock->ops->sendmsg(sock, &msg, len);
> >                 if (unlikely(err < 0)) {
> > +                       bool retry = err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS;
> > +
> >                         if (zcopy_used) {
> >                                 if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
> >                                         vhost_net_ubuf_put(ubufs);
> > -                               nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> > -                                       % UIO_MAXIOV;
> > +                               if (retry)
> > +                                       nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> > +                                               % UIO_MAXIOV;
> >                         }
> > -                       if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> > +                       if (retry) {
> >                                 vhost_discard_vq_desc(vq, 1);
> >                                 vhost_net_enable_vq(net, vq);
> >                                 break;
> > --
> > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
