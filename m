Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E587FC43460
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 00:25:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92715613A9
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 00:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92715613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45C9784601;
	Wed, 14 Apr 2021 00:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZUsD8KKHSkiq; Wed, 14 Apr 2021 00:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF4C8844F9;
	Wed, 14 Apr 2021 00:25:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BECC7C000C;
	Wed, 14 Apr 2021 00:25:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC876C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 00:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9B2C40F00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 00:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Aqg73BSUP_L
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 00:25:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3D8F40EFF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 00:25:31 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id n2so28662395ejy.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 17:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ofSqlHpW6OFplG5zBNJarpd/OG8vwHX3fcGfky7GKO0=;
 b=dxa74v3bbEU8fPB51j4N5OHFA0e4Jood31bfZu3Zyw+E9i26JicVK/KgeU+5fNAg2R
 hSulCM6IKyOz2B4C9YqptpLd7jOX5eMmaIAlICeYa59pPmOuk7INhA4gyDD0NJSvxq+z
 qqqipidRUa3pzJQp+TrJ5mFRD6GkdgzysqvlcDRc3Pn4vLdVH4m7qVAwTzN3mcGc0dfE
 CT43k1TkupQmXY9+uX3i0ovCNDI7or0OG+BqM6b0F9lzL4Py6cwdOcD6/pK8uSEnaI+f
 nSORpiArXm7CR6JxjpHDw/v7FuZkwj8I0Ozaw5P3OoSzsJ2umPB6vuiOrlrkaNmTN9Qd
 DK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ofSqlHpW6OFplG5zBNJarpd/OG8vwHX3fcGfky7GKO0=;
 b=rBD1M3dF3dmjy/1j99Oq9P1RP5acOkIn08o9zfZ8ZhsjARYx78nefBdUI2pKTnpAW3
 sxrSTHcvFzvrMUjrbp/2MH6cUYziVbRJsnNN4Ndclbu0BlhoRQz0Q/hqfXC3IGd3CNL+
 NIr5aznLNk0rV6mMWe7C4Y2rEYJ0odVN0LAvWn9hpFqeMeNv5pTcrIjs8Gvj2jzAL1AF
 4EXO5f6Q1C6DfAveFO0EooWiDh7hM2kWlwtZeRmwK87EIaVB9jUiCZiWfR5T6vNGmo05
 9ZIuN/yxHzXDH6tJ3iVcqk2Qti9jVIcGrBcfJKaN2b8gp+rshyUKhYAZ6rMRSFIczele
 MQRg==
X-Gm-Message-State: AOAM533sMR2tasoWPQ9U0k3oylpbacBiFvbTXC6l3jiHS2+RijhY3EWC
 LmdiPP0nKIpWx+mXH44d3isGxPa2fCRLxQ==
X-Google-Smtp-Source: ABdhPJxn60A7Vwi3KLRlBcj/Bo/ZQ17l+8v6153fwodXPjWj3YzKQ4BsqOS/QRGH4W91NHAli5OJBg==
X-Received: by 2002:a17:906:dc92:: with SMTP id
 cs18mr1124822ejc.27.1618359929274; 
 Tue, 13 Apr 2021 17:25:29 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
 [209.85.128.46])
 by smtp.gmail.com with ESMTPSA id u19sm10741739edy.23.2021.04.13.17.25.27
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 17:25:28 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id k128so9644372wmk.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 17:25:27 -0700 (PDT)
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr230396wmj.183.1618359927443;
 Tue, 13 Apr 2021 17:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-2-mst@redhat.com>
 <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
 <20210413153951-mutt-send-email-mst@kernel.org>
 <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
 <20210413180830-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413180830-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 20:24:48 -0400
X-Gmail-Original-Message-ID: <CA+FuTScdzwb1pi=-ms+QNMboJsqOdNddUdqTznbMzRo7PQ3bFg@mail.gmail.com>
Message-ID: <CA+FuTScdzwb1pi=-ms+QNMboJsqOdNddUdqTznbMzRo7PQ3bFg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

> > >
> > >
> > > but even yours is also fixed I think.
> > >
> > > The common point is that a single spurious interrupt is not a problem.
> > > The problem only exists if there are tons of spurious interrupts with no
> > > real ones. For this to trigger, we keep polling the ring and while we do
> > > device keeps firing interrupts. So just disable interrupts while we
> > > poll.
> >
> > But the main change in this patch is to turn some virtqueue_disable_cb
> > calls into no-ops.
>
> Well this was not the design. This is the main change:
>
>
> @@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>                 vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -               if (!vq->event)
> +               if (vq->event)
> +                       /* TODO: this is a hack. Figure out a cleaner value to write. */
> +                       vring_used_event(&vq->split.vring) = 0x0;
> +               else
>                         vq->split.vring.avail->flags =
>                                 cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_flags_shadow);
>
>
> IIUC previously when event index was enabled (vq->event) virtqueue_disable_cb_split
> was a nop. Now it sets index to 0x0 (which is a hack, but good enough
> for testing I think).

So now tx interrupts will really be suppressed even in event-idx mode.

And what is the purpose of suppressing this operation if
event_triggered, i.e., after an interrupt occurred? You mention " if
using event index with a packed ring, and if being called from a
callback, we actually do disable interrupts which is unnecessary." Can
you elaborate? Also, even if unnecessary, does it matter? The
operation itself seems fairly cheap.

These should probably be two separate patches.

There is also a third case, split ring without event index. That
behaves more like packed ring, I suppose.


> > I don't understand how that helps reduce spurious
> > interrupts, as if anything, it keeps interrupts enabled for longer.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
