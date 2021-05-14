Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E967DC43460
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 12:47:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF0861453
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 12:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF0861453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59694842D9;
	Fri, 14 May 2021 12:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDbRs8ZDwv38; Fri, 14 May 2021 12:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4B1783CCB;
	Fri, 14 May 2021 12:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3F56C000E;
	Fri, 14 May 2021 12:47:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53953C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D08640162
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FNBefPj-4eZv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:47:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23A784010C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:47:39 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id lz27so3156587ejb.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HymSORogEmezZKPe6k3z0mroHhthunf7PpEqJRP7zL0=;
 b=RPD+OijAMQuR6wAEY8XZWKOyKaKIUHXEXC24Y14snxgXcRxs1Cl72ncd2DBXx4XinR
 ayXLuwrj3dktgKhaaDh3tpOshdrGc7ZZtOGgbeI7H537PacWsjZXww/0RLG/oyUXoWF6
 SBDZuAaiUsBIsRr1dX+niAlfwpwiaTzOEjjFYdVu4YhHrO7+mLq0ZLjb34b3ZfLF2Rzo
 s9GXEl0ip7tELQ6tzSZOUS0r7p6ic5wlzVJfGeC7z2d2PKM0heIDk91OiBUnLQrKXj9O
 XFDfLD8fGG5i1S5jZ5Nwgj++KgpLzqbvTXD8y7Eyi09kOVSwViEA4CfCzD1fA2kT/3o8
 hE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HymSORogEmezZKPe6k3z0mroHhthunf7PpEqJRP7zL0=;
 b=CB3HTxkYf/nUoX4KsppuN8PPYSiBCarpAxtDyGc1s02ue6OEWbz+rXyyHZC/5VjvHH
 yUqgI5j2SLTGvzH1Jo4k5erRuoALsEMkg69xjJD0AJvESWCpFiXbaqZWcE7UTJqZGy5V
 UKta+ghpYnTydphDga+SIAgyFDQuV3D42H0WpnHZvKWK8O1TBwGnFPtZ4H3pIR7QhYSG
 NlKwMdJGNCxpRDrFeEXEF5w+wDZAnJBCJU30PkgUYeOge8dKLXicrfr8QXgI+hgUPmGY
 ChUMwWArCVN4wTY4q19zatERXCrNUJ1C9UDGbFSUA560z/+eWyxo97Quo7blVdrkx73E
 LDIg==
X-Gm-Message-State: AOAM533nKbGfaK/0Sh0NjUy/VeCGz2ps0Z5vdjx1gJX2wUHa2yV5uUbH
 ILL+y8tK/u6kWjxL+4LZFYQC5bKN6tecpA==
X-Google-Smtp-Source: ABdhPJxcA6aCxrAgh+3totTTwBTo+/8aeJRvSLV3hDKA87UP/muKghpw8d44CUsql2vMviFhjNUZOw==
X-Received: by 2002:a17:907:3e99:: with SMTP id
 hs25mr50601186ejc.518.1620996456871; 
 Fri, 14 May 2021 05:47:36 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com.
 [209.85.221.46])
 by smtp.gmail.com with ESMTPSA id u6sm3611877ejn.14.2021.05.14.05.47.36
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 05:47:36 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id m9so29948580wrx.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 05:47:36 -0700 (PDT)
X-Received: by 2002:a05:6000:52:: with SMTP id
 k18mr379123wrx.419.1620996455651; 
 Fri, 14 May 2021 05:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <CA+FuTSewRRBMkbdKzKoQv+E749jgcO9rgB4DsDTCJG2OcRQH5Q@mail.gmail.com>
 <CACGkMEszcyhb+QXCuOeJcgDCDrLHVMQ6n6Z-1f2=DN+7+dKA=Q@mail.gmail.com>
In-Reply-To: <CACGkMEszcyhb+QXCuOeJcgDCDrLHVMQ6n6Z-1f2=DN+7+dKA=Q@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 14 May 2021 08:46:59 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdAeeu+TuWNwg2KAWoEo35oUuUssgWhvwotXM4XkPPPMg@mail.gmail.com>
Message-ID: <CA+FuTSdAeeu+TuWNwg2KAWoEo35oUuUssgWhvwotXM4XkPPPMg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp
 and tx-time
To: Jason Wang <jasowang@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

On Fri, May 14, 2021 at 3:12 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, May 14, 2021 at 6:50 AM Willem de Bruijn <willemb@google.com> wrote:
> >
> > On Mon, Feb 8, 2021 at 1:56 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > RFCv2 for four new features to the virtio network device:
> > >
> > > 1. pass tx flow state to host, for routing + telemetry
> > > 2. pass rx tstamp to guest, for better RTT estimation
> > > 3. pass tx tstamp to guest, idem
> > > 3. pass tx delivery time to host, for accurate pacing
> > >
> > > All would introduce an extension to the virtio spec.
> > > Concurrently with code review I will write ballots to
> > > https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> > >
> > > These changes are to the driver side. Evaluation additionally requires
> > > achanges to qemu and at least one back-end. I implemented preliminary
> > > support in Linux vhost-net. Both patches available through github at
> > >
> > > https://github.com/wdebruij/linux/tree/virtio-net-txhash-2
> > > https://github.com/wdebruij/qemu/tree/virtio-net-txhash-2
> > >
> > > Changes RFC -> RFCv2
> > >   - add transmit timestamp patch
> > >   - see individual patches for other changes
> > >
> > > Willem de Bruijn (4):
> > >   virtio-net: support transmit hash report
> > >   virtio-net: support receive timestamp
> > >   virtio-net: support transmit timestamp
> > >   virtio-net: support future packet transmit time
> >
> > Seeing Yuri's patchset adding new features reminded me that I did not
> > follow-up on this patch series on the list.
> >
> > The patches themselves are mostly in good shape. The last tx tstamp
> > issue can be resolved.
> >
> > But the device implementation I target only supports legacy mode.
> > Below conversation that we had in one of the patches makes clear that
> > supporting this in legacy is not feasible. Nor is upgrading that
> > device in the short term. Until there is a device implementation that
> > implements these offloads, these features are a dead letter. Not moving
> > forward for now.
> >
> > Somewhat related: is there a plan for when we run out of 64 feature bits?
>
> A quick thought: we need add (or reserve) a new feature bit to
> indicate that we need more bits, and have transport specific
> implementation of those extra bits negotiation. E.g for PCI, we can
> introduce new fields in the capability.

Thanks Jason. Yes, that makes sense to me.

The difference from 32 to 64 bit between virtio_pci_legacy.c and
virtio_pci_modern.c is a good example:

  static u64 vp_get_features(struct virtio_device *vdev)
  {
        struct virtio_pci_device *vp_dev = to_vp_device(vdev);

        /* When someone needs more than 32 feature bits, we'll need to
         * steal a bit to indicate that the rest are somewhere else. */
        return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
 }

  u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
  {
        struct virtio_pci_common_cfg __iomem *cfg = mdev->common;

        u64 features;

        vp_iowrite32(0, &cfg->device_feature_select);
        features = vp_ioread32(&cfg->device_feature);
        vp_iowrite32(1, &cfg->device_feature_select);
        features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);

        return features;
  }

device_feature_select is a 32-bit field, of which only values 0 and 1
are defined so far, per the virtio 1.1 spec:

"
device_feature_select
The driver uses this to select which feature bits device_feature
shows. Value 0x0 selects Feature Bits 0 to 31, 0x1 selects Feature
Bits 32 to 63, etc.
"

That leaves plenty of room for expansion, at least for pci devices.

>
> >
> > > > > Actually, would it be possible to make new features available on
> > > > > legacy devices? There is nothing in the features bits precluding it.
> > > >
> > > > I think it won't be possible: you are using feature bit 55,
> > > > legacy devices have up to 32 feature bits. And of course the
> > > > header looks a bit differently for legacy, you would have to add special
> > > > code to handle that when mergeable buffers are off.
> > >
> > > I think I can make the latter work. I did start without a dependency
> > > on the v1 header initially.
> > >
> > > Feature bit array length I had not considered. Good point. Need to
> > > think about that. It would be very appealing if in particular the
> > > tx-hash feature could work in legacy mode.
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
