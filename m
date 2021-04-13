Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C16BC433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:28:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD0D6124B
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD0D6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9035402B1;
	Tue, 13 Apr 2021 14:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zk7deulwZVMw; Tue, 13 Apr 2021 14:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8373240105;
	Tue, 13 Apr 2021 14:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 591E3C000C;
	Tue, 13 Apr 2021 14:28:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 666C1C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47876405D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BDkVKw5jpAPW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:27:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 434884055D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:27:59 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id h10so19620625edt.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xyev31+WcNN02Wrv0KFEbnCXwG8/Z0iBfRYSMrxwfZs=;
 b=NL3dNcPgyuxWknocdzGBe7ZQtcdfnP1EudVrACIWJGBWtdqzTYGK2eTwksx9JbNcdF
 i/VLZZlHdHuiddQ/SLhZHZTCuWK3uq7/1Ip59/EGQN6k5wChlcIeTPwpiNSheE27vrTV
 ovbpfdRUGOwctkXGpwJP+8flGeGko6u8aeNcUIg/CP+XEIXtrQbywo9QyRwOmc6JOxYL
 uypwKi6l7mI2lTW0o+IqVKSLHYyQ/GAS7V4CbZKKZB7QWWcO8YikpW4Huj29NR0zt1OP
 YHTOlcEoFHg1GfhqXYaPMQWyiugzTmtSxcVEHU2Eo6uwN5VsEBHPBMrFu9WlQ8lGSr6G
 F8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xyev31+WcNN02Wrv0KFEbnCXwG8/Z0iBfRYSMrxwfZs=;
 b=m3rBTerXU4tmgOB5ikno4J8ogfgSWKEfNNRk9Jm/xJJrr2M6w19mBzXoxNSUe2uTZ2
 taI2CzFFzfuzaeWlyoqgstF/OOQysRXFM0ZkaMoK81tiUORuA6M8kz6N/LfFUR6WOxwq
 wLDmJYLXjX2Z5Ey3VY6CL+PyGcNx0U0cR9SdPvgwBrSSQ8+YvCL63wBgBTnPR6pyiMux
 U4dpGwAXUAiIlcrOhe1vL5hkVzIxe6WZ2kl+LtofkMI6v38STZJto+LJh9xfuXB0+eC0
 mi2t6C68AZUJqARMZ5KqGwMYFmEs2g9M8AUnKscH22YNRB4xnaNfBHRp1fn10YVJVh6f
 hakQ==
X-Gm-Message-State: AOAM5313vvGYrjHA1u/+pJnfNjq6XzeZBMvELyzQfF+bDk5bu07OlZnQ
 Eq0MtBmLRTk9iRSTKYeJ6/umeZl+nHSoHw==
X-Google-Smtp-Source: ABdhPJyvNLGw3PNZUiID9wPXqG0m0GtahU4Z1UaBpptOr5jD8bVITspb17SoVAOV++4D9+DvqVnuow==
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr26226285eds.286.1618324077034; 
 Tue, 13 Apr 2021 07:27:57 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com.
 [209.85.221.52])
 by smtp.gmail.com with ESMTPSA id u24sm9259310edt.85.2021.04.13.07.27.55
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 07:27:56 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h4so7649151wrt.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:27:55 -0700 (PDT)
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr37881708wrj.50.1618324075500; 
 Tue, 13 Apr 2021 07:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20170424174930.82623-1-willemdebruijn.kernel@gmail.com>
 <20170424174930.82623-6-willemdebruijn.kernel@gmail.com>
 <20210413010354-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413010354-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 10:27:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSe_iy=vDze=MSca1iRJX+WR=PjG-HoFZ2GBpFaCxE33Fg@mail.gmail.com>
Message-ID: <CA+FuTSe_iy=vDze=MSca1iRJX+WR=PjG-HoFZ2GBpFaCxE33Fg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] virtio-net: keep tx interrupts disabled
 unless kick
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
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

On Tue, Apr 13, 2021 at 1:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Apr 24, 2017 at 01:49:30PM -0400, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Tx napi mode increases the rate of transmit interrupts. Suppress some
> > by masking interrupts while more packets are expected. The interrupts
> > will be reenabled before the last packet is sent.
> >
> > This optimization reduces the througput drop with tx napi for
> > unidirectional flows such as UDP_STREAM that do not benefit from
> > cleaning tx completions in the the receive napi handler.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/virtio_net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9dd978f34c1f..003143835766 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1200,6 +1200,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >       /* Free up any pending old buffers before queueing new ones. */
> >       free_old_xmit_skbs(sq);
> >
> > +     if (use_napi && kick)
> > +             virtqueue_enable_cb_delayed(sq->vq);
> > +
> >       /* timestamp packet in software */
> >       skb_tx_timestamp(skb);
>
>
> I have been poking at this code today and I noticed that is
> actually does enable cb where the commit log says masking interrupts.
> I think the reason is that with even index previously disable cb
> actually did nothing while virtqueue_enable_cb_delayed pushed
> the event index out some more.
> And this likely explains why it does not work well for packed,
> where virtqueue_enable_cb_delayed is same as virtqueue_enable_cb.
>
> Right? Or did I miss something?

This was definitely based on the split queue with event index handling.

When you say does not work well for packed, you mean that with packed
mode we see the consequences of the race condition when accessing vq
without holding __netif_tx_lock, in a way that I did not notice with
split queue with event index, right?

Thanks for looking into this and proposing fixes for this issue and the
known other spurious tx interrupt issue.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
