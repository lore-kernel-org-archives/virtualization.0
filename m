Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EDEC4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 21:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22B298378C;
	Wed, 12 Oct 2022 21:21:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22B298378C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=V3DVoHb5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3sVd3sH8pUh; Wed, 12 Oct 2022 21:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DB1A83DF2;
	Wed, 12 Oct 2022 21:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DB1A83DF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 699C6C0033;
	Wed, 12 Oct 2022 21:21:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E416EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDF5540286
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:21:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDF5540286
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=V3DVoHb5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fj0BUeKiAG9Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:21:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90C6E402A1
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90C6E402A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 21:21:08 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id e20so21432612ybh.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z0TAOYt0oGnHXJ4fG69wmNa3O+s6LMKwU4I9dfo998I=;
 b=V3DVoHb5ufzu84HidBu2j0BgBqiAgtazjj3AjNENKnEWbeYGfOT2Ah2saWsavoUO5Y
 zIvlbnOt6JsKcyi/cxPPnpY2ViF1/IqJo/fXJHwOpqsrXkFUn9tomyezTAwgM2N1B4Aq
 E6PMyHyexVeZQKs0xz5JNcXtAnXFd7CC4ptSFJ90hKbxnpzwCBUaL+5TA8fXp14u1xYi
 vzBkhoHOxmgMwHXqy8OZsudHs8mUgKnF/zsPz19WDYFadUPh5bbzC2/828qHNVPMhEtf
 yJaWr+x3XhGud9xA+cohP52IO7Hbw9rf18wRAccrCE9CJ8eOnSdDhisqgt6A0upuPdKR
 je5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0TAOYt0oGnHXJ4fG69wmNa3O+s6LMKwU4I9dfo998I=;
 b=y9q7BuP/fTyxG8LPQp0q5iOBYsxkrkwI6u6mlGe6CGMpvBwoch8L6FzN4sO6drBivB
 pGAI9nYqkC0VNInqQzDEc3AnRtXpIKTOP1QXKsMy8+D72hT+/+suJGbqmvEO7LXWI2/6
 7DMcldMr8REbzDRCqm+hgdAJFxhBHnFF6GBJyxV4sz7TqDe0CRWQbshCw9CyNecbyDTW
 T58UxLFaCS+5piL4OdmznITIRNRz4Mt3pmYFKBCP0gi5PPiK5ioHIoqWFoKmg37TBi1h
 USN3Xr42A+CkDBthN+MT6AfhLxHbAk3rBLVV3QAPEq020Zf0RG7JrM5niEP+VV2vzS1o
 YFUw==
X-Gm-Message-State: ACrzQf0fyroctV3dem62fhZqWNUKbqGSYSVe0kBMgKANvM9R0oTN0+UH
 9VqDCHO+SWhkUNdHfDUXpj+i9NOKCoNQm7EpoODH
X-Google-Smtp-Source: AMsMyM7eyLb9K0YF56ittS2zxLXFUvVZAswMPgOYhyGxjy9DEdKooIfPez7+UXVuu43fktEwFiCixf8jlqoSXKDC/9Y=
X-Received: by 2002:a25:495:0:b0:6bf:bdc5:3736 with SMTP id
 143-20020a250495000000b006bfbdc53736mr24916261ybe.578.1665609667445; Wed, 12
 Oct 2022 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
 <20221012010143-mutt-send-email-mst@kernel.org>
 <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
 <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
In-Reply-To: <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
Date: Wed, 12 Oct 2022 16:20:56 -0500
Message-ID: <CAErSpo6azrPRAAkENVzXJOTWHCi1PLa8DHJMVKKj_cun8b+K1A@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
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
From: Bjorn Helgaas via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 12, 2022 at 5:01 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 10/12/2022 11:42 AM, Max Gurtovoy wrote:
> >
> > On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
> >> On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
> >>> This is instead of re-writing the same logic in virtio driver.
> >>>
> >>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> >> Dropped this as it caused build failures:
> >>
> >> https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com
> >
> > maybe you can re-run it with:
> >
> > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > index 8e98d24917cc..b383326a20e2 100644
> > --- a/drivers/virtio/Makefile
> > +++ b/drivers/virtio/Makefile
> > @@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
> >  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> >  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
> >  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> > -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> > -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> >  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
> >  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> >  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
> >  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
> >  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> > +
> > +virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o
> > virtio_pci_common.o
> > +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
> >
>
> Now I saw that CONFIG_PCI_IOV is not set in the error log so the bellow
> should fix it:
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 060af91bafcd..c519220e8ff8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2228,7 +2228,10 @@ static inline int pci_sriov_set_totalvfs(struct
> pci_dev *dev, u16 numvfs)
>   { return 0; }
>   static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>   { return 0; }
> -#define pci_sriov_configure_simple     NULL
> +static inline int pci_sriov_configure_simple(struct pci_dev *dev, int
> nr_virtfn)
> +{
> +       return -ENOSYS;
> +}
>   static inline resource_size_t pci_iov_resource_size(struct pci_dev
> *dev, int resno)
>   { return 0; }
>   static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool
> probe) { }
>
> Bjorn,
>
> WDYT about the above ?
>
> should I send it to the pci subsystem list ?

Yes.  I don't apply things that haven't appeared on linux-pci@vger.kernel.org.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
