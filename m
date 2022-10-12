Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA3C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 23:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E59C260C01;
	Wed, 12 Oct 2022 23:19:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E59C260C01
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eHtnVeP0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhAulsxnQXrn; Wed, 12 Oct 2022 23:19:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 70B3B61092;
	Wed, 12 Oct 2022 23:19:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70B3B61092
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5A4C0033;
	Wed, 12 Oct 2022 23:19:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 511F9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 23:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1125B61092
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 23:19:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1125B61092
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0hSSEv81hK5f
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 23:19:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E507260C01
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E507260C01
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 23:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665616749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yE7HqDJx889u7pqiqqMRvQDmULGHmUZUd5wFAOQCgDQ=;
 b=eHtnVeP0Lp9KY88BCLdguRLjx/8mncGbjzPecuQFxlhuY1U2d6KVIYyXTNHdVilotoa2Ju
 B8jcU/oWAhKWpziwUBQaZspIf9ArzXVsYU+Yy+gyI+O4Io6bQvYlhWpM25+zJz4PaBOXdt
 DZI9IB6Q8uxVcRzIrkxS/02e0x5knMA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-CjaSB5bXMJWpIGklaQib0Q-1; Wed, 12 Oct 2022 19:19:08 -0400
X-MC-Unique: CjaSB5bXMJWpIGklaQib0Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 c3-20020a7bc843000000b003b486fc6a40so150226wml.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 16:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yE7HqDJx889u7pqiqqMRvQDmULGHmUZUd5wFAOQCgDQ=;
 b=FR7RXOF/afUWTYRFZFLfb1RgCSWKadhuz2NJZ9b+er6iy1SFvwADJhbhDT+cP0lIyk
 WCPH4Ud61d1czsjjNjy32Uc2wcbEtDeaHta1gJR5UPPrFJhxtj2bFH2MmaL6YGXr/Gye
 oTJcNAXtSZPcwoQ2rsTcFm3IRvGq76RR5HOYl3skQhWwa+yysv7lwMUhirHbk7pe6PKt
 UUHZt+SW6KtTWje0D3OdgvtiIISWEgOv/S5YyZYNfhhxR3UsXeCaNNzvPZsrp2xPmNcS
 8Len5qGjKw4Ss+hfcneAUamu9/zOLGA5CDb0zBElrkeXA4X/DyFC3QwW/Hd4UOOtJxm/
 UeLg==
X-Gm-Message-State: ACrzQf3ncJ2FKXqMmAoo/ZK6kqSxs9zZMxMtj1oii6sS6Z7iMqmEufWE
 615UavGzSVKUMBgGqaiWDxIyrV42eqOZEfI98h3gTpZMIVVXn3RjmZWydEKfkBoehPB6j7NJIpt
 MiTXOpFgPQTj+6g5faIeqS03g5ZubPnfJyNH+0ExKAg==
X-Received: by 2002:a5d:6c62:0:b0:230:5aa7:6771 with SMTP id
 r2-20020a5d6c62000000b002305aa76771mr11333442wrz.158.1665616747365; 
 Wed, 12 Oct 2022 16:19:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7vBRuzDCDKjNuIq0n56gKUJ0aB/KWwPJBoNzMEaALW7TAv8G88bOXEAz6aahT5r9Chk4OIsA==
X-Received: by 2002:a5d:6c62:0:b0:230:5aa7:6771 with SMTP id
 r2-20020a5d6c62000000b002305aa76771mr11333434wrz.158.1665616747112; 
 Wed, 12 Oct 2022 16:19:07 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 b8-20020a056000054800b0022ae401e9e0sm695188wrf.78.2022.10.12.16.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 16:19:06 -0700 (PDT)
Date: Wed, 12 Oct 2022 19:19:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Message-ID: <20221012191159-mutt-send-email-mst@kernel.org>
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
 <20221012010143-mutt-send-email-mst@kernel.org>
 <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
 <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
 <CAErSpo6azrPRAAkENVzXJOTWHCi1PLa8DHJMVKKj_cun8b+K1A@mail.gmail.com>
 <63b02394-d932-a385-9267-515c71bb65ee@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <63b02394-d932-a385-9267-515c71bb65ee@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-block@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Thu, Oct 13, 2022 at 02:01:04AM +0300, Max Gurtovoy wrote:
> 
> On 10/13/2022 12:20 AM, Bjorn Helgaas wrote:
> > On Wed, Oct 12, 2022 at 5:01 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> > > 
> > > On 10/12/2022 11:42 AM, Max Gurtovoy wrote:
> > > > On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
> > > > > On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
> > > > > > This is instead of re-writing the same logic in virtio driver.
> > > > > > 
> > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Dropped this as it caused build failures:
> > > > > 
> > > > > https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com
> > > > maybe you can re-run it with:
> > > > 
> > > > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > > > index 8e98d24917cc..b383326a20e2 100644
> > > > --- a/drivers/virtio/Makefile
> > > > +++ b/drivers/virtio/Makefile
> > > > @@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> > > >   obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> > > >   obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> > > >   obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> > > > -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> > > > -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> > > >   obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
> > > >   obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> > > >   obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
> > > >   obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
> > > >   obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> > > > +
> > > > +virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o
> > > > virtio_pci_common.o
> > > > +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> > > > 
> > > Now I saw that CONFIG_PCI_IOV is not set in the error log so the bellow
> > > should fix it:
> > > 
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 060af91bafcd..c519220e8ff8 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -2228,7 +2228,10 @@ static inline int pci_sriov_set_totalvfs(struct
> > > pci_dev *dev, u16 numvfs)
> > >    { return 0; }
> > >    static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
> > >    { return 0; }
> > > -#define pci_sriov_configure_simple     NULL
> > > +static inline int pci_sriov_configure_simple(struct pci_dev *dev, int
> > > nr_virtfn)
> > > +{
> > > +       return -ENOSYS;
> > > +}
> > >    static inline resource_size_t pci_iov_resource_size(struct pci_dev
> > > *dev, int resno)
> > >    { return 0; }
> > >    static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool
> > > probe) { }
> > > 
> > > Bjorn,
> > > 
> > > WDYT about the above ?
> > > 
> > > should I send it to the pci subsystem list ?
> > Yes.  I don't apply things that haven't appeared on linux-pci@vger.kernel.org.
> 
> Sure.
> 
> MST,
> 
> can you confirm the above fixes the build errors before I sent the v2 ?

Max, please just use the lkp test, it's not hard.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
