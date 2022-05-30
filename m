Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53413C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 03:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3CD740C05;
	Mon, 30 May 2022 03:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2fXHs2B8A6gL; Mon, 30 May 2022 03:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66FC74000B;
	Mon, 30 May 2022 03:48:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F985C0032;
	Mon, 30 May 2022 03:48:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9799BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 828FC415AD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLXEVk9wUbAW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:48:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F0C8415AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 03:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653882503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmGS+JorM6DychXTopYG3ZDAjK7UxTCFM8Tie0jNFQA=;
 b=coLTib89G0z2U2YcThCUnhrH6CeKyjEYS/Ly7BNhazaEV+oC2AE5oYcwOVAme/oG/iSZ9k
 TPiWaNoP1R0rvYLWMP55937vw0ojxlZjQpcMb83tq++BalZSwLKrhcNKbeMpimPQX99wzM
 6ha/8a1i/9ouvqGuuK5BTyw4oe+R9bI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-iX5p1MFNM5yQiHrgblPmgw-1; Sun, 29 May 2022 23:48:21 -0400
X-MC-Unique: iX5p1MFNM5yQiHrgblPmgw-1
Received: by mail-lf1-f71.google.com with SMTP id
 o17-20020ac24c51000000b004785386772bso4664065lfk.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 May 2022 20:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FmGS+JorM6DychXTopYG3ZDAjK7UxTCFM8Tie0jNFQA=;
 b=yb6VoFeJhHkJrzYnRlmeHoYM/zz8FFnZTWPibPZyW49HuTctQl6hr7HTaJg0ktwQuu
 9tQV9m8F40BTTECgKyuB3mCCO11Z2koKO8PU+jPNAC1t/HOV6kV85BGguP3Hl+v7YUs+
 b4PfBo1sJ8ZXBHslFsA2+45ZUoG8kjBk+RyRcf/5d1nAsmu0Uehn63qAXD2qf9lJyhGB
 1NtVxi6yNbW46IkeAfWmUmO9JIZxO602MRmSNuYXsIJAjNk+kp16IAR+svpImh43geKm
 7Hh0iEe1y5Bgz7xck+or0spvrhs2fUceS9yw431yJeNGzPAsqfGBMepccX0ApkJSNnfW
 LCJA==
X-Gm-Message-State: AOAM530iAdu/1mLsoWb5lzag36y+kkSnM/7fiUCJDLH/IzJWZYCvmbSD
 8ApQw70+gAq+dJtDxMpMtrt+ZTrhwcDAD1lNbTHtC4FYbwsZKvBAS5QoWozjR6bFDP6g6SdijSD
 ztPIfKdroS5zeiR/3KD6rDflf4NW/oW8AvHmTwyF+COG5yOIRMjaFMblW6A==
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr30777805ljf.243.1653882500193; 
 Sun, 29 May 2022 20:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybmkowLkDNeOswXv7BzZ6+71C1oQB0CScKxGz3UP85HZsXfBflYJu2iC9B1ybQW9EKdBuBcy9WDtQBSdSav6s=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr30777785ljf.243.1653882499911; Sun, 29
 May 2022 20:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
 <20220527064118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220527064118-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 May 2022 11:48:08 +0800
Message-ID: <CACGkMEvoFapNoqsqq59iH+z_qx1swecjnbbPs7=nN4bn6XdbtA@mail.gmail.com>
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Cindy Lu <lulu@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Fri, May 27, 2022 at 6:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> At a minimum, I don't see why it's part of the series. Host can always
> crash the guest if it wants to ...

Probably not with some recent technology. In those cases, a fault will
be generated if the hypervisor tries to access the memory that is
private to the guest.

> The point of BUG_ON is device or driver is already corrupted so we
> should not try to drive it.  If you still want this in pls come up with
> a better commit log explaining the why.

A question here, should we always use BUG_ON for the buggy/malicious hypervisor?

The interrupt hardening logic in this series tries to make guest
survive, so did this patch.

>
> On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
> > We used to use BUG_ON() in virtio_device_ready() to detect illegal
>
> not really, BUG_ON just crashes the kernel.  we detect by checking
> status.

We need a kind of notification otherwise there's no way for the user
to know about this expected value.

>
> > status value, this seems sub-optimal since the value is under the
> > control of the device. Switch to use WARN_ON() instead.
>
> some people use crash on warn so ...

Yes, but the policy is under the control of the user.

>
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> > ---
> >  include/linux/virtio_config.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index d4edfd7d91bb..9a36051ceb76 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -255,7 +255,7 @@ void virtio_device_ready(struct virtio_device *dev)
> >  {
> >       unsigned status = dev->config->get_status(dev);
> >
> > -     BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +     WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >
>
> we lose debuggability as guest will try to continue.
> if we are doing this let us print a helpful message and dump a lot of
> state right here.

I'm ok with dropping this patch from the series. And revisit it in the future.

Thanks

>
> >       /*
> >        * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
