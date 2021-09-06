Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B1C433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 06:37:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DD160F9E
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 06:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90DD160F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D28C40240;
	Mon,  6 Sep 2021 06:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id McOXn1gwQ458; Mon,  6 Sep 2021 06:37:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 554CE401BC;
	Mon,  6 Sep 2021 06:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E8A2C0010;
	Mon,  6 Sep 2021 06:37:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24F7BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 06:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AB61403FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 06:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nH7Kz-XV8X1f
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 06:37:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54864403DE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 06:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630910232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwUBcFLW2DErKP8nW3thbj1Bfk3yLnGU+eP2iS4eEBM=;
 b=QYuNd++ezwA7PDK5HSG93hEuQh38D/s6/4PFw1kzIQd2Eyu9DRjrBvwdXSp+OalBFUJLQv
 yRwz9+VERtrL0nmhfDm4FY1hc4UZlVPIiz2ymRme0uQF19lAYxYde2IIl5qilE11BCtqXC
 Ly7hqDqu8Q1udtZb/vOBITSj2XpHJJA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-fJJEy2-QMHW9mN_NYP8TWg-1; Mon, 06 Sep 2021 02:37:10 -0400
X-MC-Unique: fJJEy2-QMHW9mN_NYP8TWg-1
Received: by mail-wm1-f71.google.com with SMTP id
 p5-20020a7bcc85000000b002e7563efc4cso2845531wma.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 23:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NwUBcFLW2DErKP8nW3thbj1Bfk3yLnGU+eP2iS4eEBM=;
 b=LtbrZTN9j5WVRFW1RXAovdWYCGBFrRGYkR3JmR7CgcGWxsU53h1uS160fc6G4DbTkC
 Oj8WL4LAL3ocb5QGGKUQXYwsHPWeOIScVB0ZuhlhbsH4rgJMXMIgwX9H+TXTmzKdy8Lg
 Mw/qwsb10+y0zfj6VNwm6iPIE7BvFr9LY4SfrncoQpwP9CAaXhZoamDUdEbT4tgVzlV8
 5eSlGnJRXcR9DYJ6WBIQgx6z0FE5mCzLjTHqOFExvHNvcWnrsYWwYwHPeIe3fhsxMaRr
 WHe82VYZXrIoG8V02S7yObpxehciAm73Ejjkt6vcsYFKO3Nrq5k5AF9M/BpgUGPq+gXB
 wJyw==
X-Gm-Message-State: AOAM533IPDZ2o0cInFj395fZTPCNYaKRHDEHbbfNmACitJ37qVrWMpm6
 AMhrALfdTXip8ELVeMvjKzDNILuPny5H12mWaVRPTjzzDNgEPEsai3BzqpKUhY9z4Kmq8sSkenL
 SsZ8JmNb2Mb0TxAvxTW6zy+P2g9S27kyzba7CRsiApg==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr9990677wmf.132.1630910229711; 
 Sun, 05 Sep 2021 23:37:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRCwrPqlTT9EQxN6i2JahNEijC2yzlB8bw+tqErn2HIqi0obsj9A8iduK7E+CvdT1s7MMNSQ==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr9990653wmf.132.1630910229544; 
 Sun, 05 Sep 2021 23:37:09 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id g1sm8586151wrb.27.2021.09.05.23.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 23:37:08 -0700 (PDT)
Date: Mon, 6 Sep 2021 02:37:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v13 05/13] vdpa: Add reset callback in vdpa_config_ops
Message-ID: <20210906023131-mutt-send-email-mst@kernel.org>
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-6-xieyongji@bytedance.com>
 <20210906015524-mutt-send-email-mst@kernel.org>
 <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3v4ZVnh7DGe_RtAOx4Vvau0km=HWyCM=KzKhD+ahYKafQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 joro@8bytes.org, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, John Garry <john.garry@huawei.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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

On Mon, Sep 06, 2021 at 02:09:25PM +0800, Yongji Xie wrote:
> On Mon, Sep 6, 2021 at 1:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 06:36:26PM +0800, Xie Yongji wrote:
> > > This adds a new callback to support device specific reset
> > > behavior. The vdpa bus driver will call the reset function
> > > instead of setting status to zero during resetting.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> >
> > This does gloss over a significant change though:
> >
> >
> > > ---
> > > @@ -348,12 +352,12 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
> > >       return vdev->dma_dev;
> > >  }
> > >
> > > -static inline void vdpa_reset(struct vdpa_device *vdev)
> > > +static inline int vdpa_reset(struct vdpa_device *vdev)
> > >  {
> > >       const struct vdpa_config_ops *ops = vdev->config;
> > >
> > >       vdev->features_valid = false;
> > > -     ops->set_status(vdev, 0);
> > > +     return ops->reset(vdev);
> > >  }
> > >
> > >  static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> >
> >
> > Unfortunately this breaks virtio_vdpa:
> >
> >
> > static void virtio_vdpa_reset(struct virtio_device *vdev)
> > {
> >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> >
> >         vdpa_reset(vdpa);
> > }
> >
> >
> > and there's no easy way to fix this, kernel can't recover
> > from a reset failure e.g. during driver unbind.
> >
> 
> Yes, but it should be safe with the protection of software IOTLB even
> if the reset() fails during driver unbind.
> 
> Thanks,
> Yongji

Hmm. I don't see it.
What exactly will happen? What prevents device from poking at
memory after reset? Note that dma unmap in e.g. del_vqs happens
too late.  And what about e.g. interrupts?
E.g. we have this:

        /* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
        vblk->vdev = NULL;

and this is no longer true at this point.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
