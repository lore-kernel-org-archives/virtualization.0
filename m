Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187A560F23
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 187A560F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEAFB82ADD;
	Wed, 13 Oct 2021 12:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJGGnoCf1lvZ; Wed, 13 Oct 2021 12:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84C2082993;
	Wed, 13 Oct 2021 12:18:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E944C0023;
	Wed, 13 Oct 2021 12:18:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C824C000F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68C7C608B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oqji7rOcrgZI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A5036081B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634127483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8uA+gFhUzMMrb5D5fxARTwQwcT+AEfWKWkQ0ooGMKj8=;
 b=gcZphIhv1SUibhOpSsOSgz4m0cbJvHyEtd0kwtKyNGk7PlE0SU+JPX+FUmjzkGHkvuPJuI
 RYeShTXWeJ1jx+SFek2K1Tc6X4vwuEpu4Q3Rv6491+05hOgYMfee2etkukNn00qGLGJeMY
 ljgHBxDZGBTUGlUD8++dZn6sdjVlaG0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-cQfLATT_Mam5N9mjPA6qoA-1; Wed, 13 Oct 2021 08:18:02 -0400
X-MC-Unique: cQfLATT_Mam5N9mjPA6qoA-1
Received: by mail-wr1-f70.google.com with SMTP id
 p12-20020adfc38c000000b00160d6a7e293so1795132wrf.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uA+gFhUzMMrb5D5fxARTwQwcT+AEfWKWkQ0ooGMKj8=;
 b=TRe46Zzy/tHYnkODs22GWkzUC1c0D5WSPBBlsukOKcg6HODZ9240ibj8UEgi7MaXVK
 jC7PuzkGeDrnWd6a+OCzVJcoECP+c13mHMxTVmeUimh+TgY47E1oimXSd9BaOckjwiZl
 U7JYFNuw/hYqc0WSqOHlKp2So11aEomXjfCVphyMorMermH2Pe1sv0jPl9+rbe/pHRXt
 mvUttci03Xmi+o+YO8v9Qyh2pcqr3ZPM0pKJxjqq6f9o9/ICRpTcn53ixKcTb0qhOcLc
 5o+xVm6lS2z2mdruX5M0c/jce9RAq20uqzc+uEYpRYAw9o5YbUDa/F5T+ntiex3oImQr
 fQ/A==
X-Gm-Message-State: AOAM531P01xCC7pLYkNxg6NunmG1OusJkX7mQcMVFbIgvTHzJ//CrIdh
 u/VgIGxGDQ4Qv5xgAPyvZTLhr0SnRSfOf0JT/dthS+lSpTf0l4FI/Xa/e0ur36KszVXgVodGwkd
 2XgrhVf7WqBmzAlqSrXy07apXf2zYHZGW9Nsv4NLI1g==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr12535242wmj.38.1634127481372; 
 Wed, 13 Oct 2021 05:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFEzPqFQ+1qHznC4euH1QtbfXrvr/+t46tCqHwjpC6aqk2B2gJ30j5Cm2I+Hz0oA4zGN44UQ==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr12535146wmj.38.1634127481076; 
 Wed, 13 Oct 2021 05:18:01 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id z1sm4104369wrt.94.2021.10.13.05.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:00 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:17:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
Message-ID: <20211013081632-mutt-send-email-mst@kernel.org>
References: <20211013105226.20225-1-mst@redhat.com>
 <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: nvdimm@lists.linux.dev, v9fs-developer@lists.sourceforge.net,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Viresh Kumar <vireshk@kernel.org>,
 linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 Will Deacon <will@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org,
 Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Takashi Iwai <tiwai@suse.com>,
 Kalle Valo <kvalo@codeaurora.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, virtualization@lists.linux-foundation.org,
 Jeff Dike <jdike@addtoit.com>, Vivek Goyal <vgoyal@redhat.com>,
 Ohad Ben-Cohen <ohad@wizery.com>, Johan Hedberg <johan.hedberg@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 Eric Van Hensbergen <ericvh@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>, Jaroslav Kysela <perex@perex.cz>,
 Cristian Marussi <cristian.marussi@arm.com>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-gpio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 "David S. Miller" <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>
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

On Wed, Oct 13, 2021 at 01:03:46PM +0200, David Hildenbrand wrote:
> On 13.10.21 12:55, Michael S. Tsirkin wrote:
> > This will enable cleanups down the road.
> > The idea is to disable cbs, then add "flush_queued_cbs" callback
> > as a parameter, this way drivers can flush any work
> > queued after callbacks have been disabled.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   arch/um/drivers/virt-pci.c                 | 2 +-
> >   drivers/block/virtio_blk.c                 | 4 ++--
> >   drivers/bluetooth/virtio_bt.c              | 2 +-
> >   drivers/char/hw_random/virtio-rng.c        | 2 +-
> >   drivers/char/virtio_console.c              | 4 ++--
> >   drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
> >   drivers/firmware/arm_scmi/virtio.c         | 2 +-
> >   drivers/gpio/gpio-virtio.c                 | 2 +-
> >   drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
> >   drivers/i2c/busses/i2c-virtio.c            | 2 +-
> >   drivers/iommu/virtio-iommu.c               | 2 +-
> >   drivers/net/caif/caif_virtio.c             | 2 +-
> >   drivers/net/virtio_net.c                   | 4 ++--
> >   drivers/net/wireless/mac80211_hwsim.c      | 2 +-
> >   drivers/nvdimm/virtio_pmem.c               | 2 +-
> >   drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
> >   drivers/scsi/virtio_scsi.c                 | 2 +-
> >   drivers/virtio/virtio.c                    | 5 +++++
> >   drivers/virtio/virtio_balloon.c            | 2 +-
> >   drivers/virtio/virtio_input.c              | 2 +-
> >   drivers/virtio/virtio_mem.c                | 2 +-
> >   fs/fuse/virtio_fs.c                        | 4 ++--
> >   include/linux/virtio.h                     | 1 +
> >   net/9p/trans_virtio.c                      | 2 +-
> >   net/vmw_vsock/virtio_transport.c           | 4 ++--
> >   sound/virtio/virtio_card.c                 | 4 ++--
> >   26 files changed, 39 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> > index c08066633023..22c4d87c9c15 100644
> > --- a/arch/um/drivers/virt-pci.c
> > +++ b/arch/um/drivers/virt-pci.c
> > @@ -616,7 +616,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
> >   	int i;
> >           /* Stop all virtqueues */
> > -        vdev->config->reset(vdev);
> > +        virtio_reset_device(vdev);
> >           vdev->config->del_vqs(vdev);
> 
> Nit: virtio_device_reset()?
> 
> Because I see:
> 
> int virtio_device_freeze(struct virtio_device *dev);
> int virtio_device_restore(struct virtio_device *dev);
> void virtio_device_ready(struct virtio_device *dev)
> 
> But well, there is:
> void virtio_break_device(struct virtio_device *dev);

Exactly. I don't know what's best, so I opted for plain english :)


> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
