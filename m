Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776877F02
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etb+LAKh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AFCA60D76
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 16:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AFCA60D76
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=etb+LAKh
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lVOK2QtAX6pe
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 16:13:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77D2760D53
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 16:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77D2760D53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702397633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uuy6fJEq9VcrZk+5OcRbC+0CsDirfz4cGt+s4ZDOS6A=;
	b=etb+LAKhqTdwR/9AOqnAJgvDKNDPF62JkyPosYFage8YsBigtQGbuUZeXHWeT1QuEprRTo
	khPTG7mSx1Qw4SfsTbmAW2bnUbpd8JSrQTmRg5vFokgox6YOG4pLx/vM6iLY06vZOJLGRQ
	bjGd7NOVqKeQ8/tnwL+NdH1xfY6H76Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-fYTvhykwNgOfA3ZFu-M-3A-1; Tue, 12 Dec 2023 11:13:51 -0500
X-MC-Unique: fYTvhykwNgOfA3ZFu-M-3A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c3307ccf4so33572955e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397630; x=1703002430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuy6fJEq9VcrZk+5OcRbC+0CsDirfz4cGt+s4ZDOS6A=;
        b=RH7gaTTfd5HET1dIiIwC8bR6acuNyjmYtYWthpGYlsjz4YiLGVJQoXlBPTuGsa8ANn
         oDTNKhgCfrN2LxpxPr/B20qenWwi0gUFxl8vQ27T3dgMbUEUstei4DHzxvK9lk0WxuKv
         GGbbZCsd4hVP1pD7ui/Yo8bqTEB/3U1GN0Ffxb39feXdqbAxoMZ/iLDtvzy1dAgk/nnz
         ibulySCqwN3+KuGPBGfjaZrIUVoynnQ6DzIO4I/KkiBMbS+qJeeQlxgXt8MsRyDCfqFA
         apBJusgiJl8XwRI3bzpsMoA5FgsjhD+E8nPZWSc+7JVg6q8mwemjwHqksfs/BaPmXHEB
         0rug==
X-Gm-Message-State: AOJu0Yz4W41kWLB6mjKHQ5eNaDj6/MQoVZGYTp3NKYHpFdFX7wC4huQo
	DIEXXdz39ucjbdsetPNH7B9xvMlrTA2SlXGcbLuyvydYNTnCgKZl4rTOP6AE2E2lWjgfkk+CF1S
	wbcZ8rsqnhb6WL5TZecC0Pc4az+nEx7FXJCYKxR7WxQ==
X-Received: by 2002:a05:600c:861b:b0:40b:5e59:c557 with SMTP id ha27-20020a05600c861b00b0040b5e59c557mr3364970wmb.129.1702397630179;
        Tue, 12 Dec 2023 08:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfUc4xfhTLTS5rbpUv86c4E0o2kWCp80gyTVZYIY86ryUM/Xq1XffDjqEM45VPyAYPelpzqg==
X-Received: by 2002:a05:600c:861b:b0:40b:5e59:c557 with SMTP id ha27-20020a05600c861b00b0040b5e59c557mr3364962wmb.129.1702397629813;
        Tue, 12 Dec 2023 08:13:49 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b0033340937da6sm11036564wro.95.2023.12.12.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:13:49 -0800 (PST)
Date: Tue, 12 Dec 2023 11:13:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: David Stevens <stevensd@chromium.org>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Message-ID: <20231212111323-mutt-send-email-mst@kernel.org>
References: <20231208070754.3132339-1-stevensd@chromium.org>
 <20231211113710-mutt-send-email-mst@kernel.org>
 <CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=uUnOonDczWzqaucsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=uUnOonDczWzqaucsw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 12, 2023 at 11:01:53AM +0800, Jason Wang wrote:
> On Tue, Dec 12, 2023 at 12:37 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Dec 08, 2023 at 04:07:54PM +0900, David Stevens wrote:
> > > If a virtio_pci_device supports native PCI power management and has the
> > > No_Soft_Reset bit set, then skip resetting and reinitializing the device
> > > when suspending and restoring the device. This allows system-wide low
> > > power states like s2idle to be used in systems with stateful virtio
> > > devices that can't simply be re-initialized (e.g. virtio-fs).
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> >
> > tagged, thanks!
> > I'm still debating with myself whether we can classify this
> > as a bugfix ... better not risk it I guess.
> 
> It might be suitable if there's a hypervisor that advertises
> no_soft_reset (but it seems Qemu doesn't).
> 
> Thanks

Yea... so a bugfix but no rush to merge it I think.

> >
> > > ---
> > > v1 -> v2:
> > >  - Check the No_Soft_Reset bit
> > >
> > >  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
> > >  1 file changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index c2524a7207cf..3a95ecaf12dc 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
> > >       return virtio_device_restore(&vp_dev->vdev);
> > >  }
> > >
> > > +static bool vp_supports_pm_no_reset(struct device *dev)
> > > +{
> > > +     struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +     u16 pmcsr;
> > > +
> > > +     if (!pci_dev->pm_cap)
> > > +             return false;
> > > +
> > > +     pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > +     if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > > +             dev_err(dev, "Unable to query pmcsr");
> > > +             return false;
> > > +     }
> > > +
> > > +     return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > > +}
> > > +
> > > +static int virtio_pci_suspend(struct device *dev)
> > > +{
> > > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > > +}
> > > +
> > > +static int virtio_pci_resume(struct device *dev)
> > > +{
> > > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> > > +}
> > > +
> > >  static const struct dev_pm_ops virtio_pci_pm_ops = {
> > > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> > > +     .suspend = virtio_pci_suspend,
> > > +     .resume = virtio_pci_resume,
> > > +     .freeze = virtio_pci_freeze,
> > > +     .thaw = virtio_pci_restore,
> > > +     .poweroff = virtio_pci_freeze,
> > > +     .restore = virtio_pci_restore,
> > >  };
> > >  #endif
> > >
> > > --
> > > 2.43.0.472.g3155946c3a-goog
> >

