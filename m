Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE3C433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 04:13:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCD960E74
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 04:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBCD960E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C90F40502;
	Wed, 15 Sep 2021 04:13:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pqs2DlMk9S2t; Wed, 15 Sep 2021 04:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3E5140500;
	Wed, 15 Sep 2021 04:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A31DDC0011;
	Wed, 15 Sep 2021 04:13:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 901FAC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78C7281DA3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:13:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YaqqzDBAjrun
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6749281DA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 04:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631679226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d19fLDG4beOySnbCfA/cKsV5qbQPUjpoNltxe78U9v8=;
 b=HTPnluTe4qZo6zUkdWs2cfsvl81azI2RyZ2mS4qh3gKF6oyrNjKxbkXa69hGyio1ywHRtd
 0Tm8ewTGCOhue2uIvKTSczUMqoE6FphasiwWAaRFY2KKqZ0ytykXrYJJjLb5pb83QiBDZZ
 qAbOVx+oBfl5sjjf+sRd8hBL/23aYDs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-riHKxUFSMO-Y_-F_sq2PUw-1; Wed, 15 Sep 2021 00:13:44 -0400
X-MC-Unique: riHKxUFSMO-Y_-F_sq2PUw-1
Received: by mail-lf1-f70.google.com with SMTP id
 c15-20020a056512238f00b003f1de3c67e2so552865lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 21:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d19fLDG4beOySnbCfA/cKsV5qbQPUjpoNltxe78U9v8=;
 b=Q7etHeZLkNWAk/li0NxMtmB1j5rk9d9lsYjUE3T10LB2yZ0qlWbACbZFIOx7+iCZg0
 XFfKoACrL4RKmclIOghucZtLG+QsAY5pqDauVCiemj8MiwPocPeYl6eTfc92H9KUA6rk
 mN+RFC+9eoVqiX4bJhLVjtxuUzHuRBaTAe7RTQHU6nzdwpxloL8G+A7B2gZUtdkW/jsL
 8NmhULxTdhN8VAZeHUUk8A/oedv5TcuW6m32Gmfke74fuWUYucsqa11zywRTZf0U3Qqu
 rM1kEO/ggfS5ZVlVZSWn2DaBoHd/k2awn1kM54xLpQ4ZuM/yL2qj3jYG4NPLb+2+dI3f
 OqHg==
X-Gm-Message-State: AOAM531V9dn2FC1TDjzlxhfnusdcsZxFHGk0EVasB7Bweb+aLpCyqZOg
 0wglfBt2HgzxdUvdLrFUqJuBqeiCxYUc9X0Mpzi7Mh5HLIy+Ds7opKqbgu5V90DPIAe3xUgwYqI
 LMJBR1oc+ayLjwUUFdR3ji8sZ2R12oESVUbBaNKrdICMDWtOnRs2uXzUcxQ==
X-Received: by 2002:a05:6512:2254:: with SMTP id
 i20mr15700901lfu.348.1631679223028; 
 Tue, 14 Sep 2021 21:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBw9gq+5PY6XT+fBNtGPRoojC5lqwvf9Lr40qBes9yI/bINDnAG/kASzfgo9/sbTC157W/tOnUYsL+zSmrDxs=
X-Received: by 2002:a05:6512:2254:: with SMTP id
 i20mr15700895lfu.348.1631679222837; 
 Tue, 14 Sep 2021 21:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
 <CACGkMEu9udAQ63_1Xx6kNo=OR5Mgkk5fnS5or6E98-vjTpoUkw@mail.gmail.com>
 <20210915033102.GB18793@L-PF27918B-1352.localdomain>
In-Reply-To: <20210915033102.GB18793@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Sep 2021 12:13:31 +0800
Message-ID: <CACGkMEuAtTJLbPJeJ2-6W605zrTXAkLm2Q86g6pQepStwxoO1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vp_vdpa: add vq irq offloading support
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Sep 15, 2021 at 11:31 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:16:03AM +0800, Jason Wang wrote:
> > On Tue, Sep 14, 2021 at 8:25 PM Wu Zongyong
> > <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This patch implements the get_vq_irq() callback for virtio pci devices
> > > to allow irq offloading.
> > >
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > (btw, I think I've acked this but it seems lost).
> Yes, but this patch is a little different with the previous one.

I see, then it's better to mention this after "---" like

---
change since v1:
- xyz
---

or in the cover letter.

>
> And should I not send the patch again if one of the previous version
> patch series have been acked by someone?

No, you need to resend the whole series.

Thanks

> It's the first time for me to
> send patches to kernel community.
> >
> > Thanks
> >
> > > ---
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 5bcd00246d2e..e3ff7875e123 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -76,6 +76,17 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> > >         return vp_modern_get_status(mdev);
> > >  }
> > >
> > > +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +       int irq = vp_vdpa->vring[idx].irq;
> > > +
> > > +       if (irq == VIRTIO_MSI_NO_VECTOR)
> > > +               return -EINVAL;
> > > +
> > > +       return irq;
> > > +}
> > > +
> > >  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
> > >  {
> > >         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> > > @@ -427,6 +438,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
> > >         .get_config     = vp_vdpa_get_config,
> > >         .set_config     = vp_vdpa_set_config,
> > >         .set_config_cb  = vp_vdpa_set_config_cb,
> > > +       .get_vq_irq     = vp_vdpa_get_vq_irq,
> > >  };
> > >
> > >  static void vp_vdpa_free_irq_vectors(void *data)
> > > --
> > > 2.31.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
