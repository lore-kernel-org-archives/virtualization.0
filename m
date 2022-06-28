Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE954C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 06:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7696640496;
	Tue, 28 Jun 2022 06:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7696640496
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X/I80pmw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Wfz98raGulD; Tue, 28 Jun 2022 06:10:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B92FC4037C;
	Tue, 28 Jun 2022 06:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B92FC4037C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A62EC0039;
	Tue, 28 Jun 2022 06:10:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A38DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FE304157C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FE304157C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X/I80pmw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IlFBMNqUiIa3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:10:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78AF44154F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78AF44154F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656396642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BYYScMGsiH8wtlqiDVPv0n7noXIHSehxA8t2s/lQEB0=;
 b=X/I80pmwYwWFXrPS2buxcSFzFdM8RnYLrLC0pbvwQnCmE/md+moKxf1FBNCD6rEb6OzOfG
 6LeGKZK0vHifRzL3c6zeNEOQVkCtO25mnoeecQtQOR7boSzejY1VrQZ6rYcjboA8qtvdk7
 CX0k740K5rEh41tFSHdJ8eHOLhydnj4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-7bQPTuHGOdqpNNKNBmio1w-1; Tue, 28 Jun 2022 02:10:39 -0400
X-MC-Unique: 7bQPTuHGOdqpNNKNBmio1w-1
Received: by mail-wr1-f69.google.com with SMTP id
 n5-20020adf8b05000000b00219ece7272bso1477379wra.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BYYScMGsiH8wtlqiDVPv0n7noXIHSehxA8t2s/lQEB0=;
 b=Po6pwCczj6Ad+bJyNIjchgsEym0zpOFBkIhOW5/KkVdnaxdUdLyTK2XrRY+cDFyI2X
 oT/J4M7hYJvRC8cALLf5yt5MiFXmEBYg7YecXuDF1ax/xe/xkLN6R/5t3DLbrbwQl2qT
 XFdo6WRUHcr8pEphNpuFGZ7wAPaGV23suzv2gaF1668rYvQbNB2SlYNQhNb594HQw3pe
 g5/fqQYGzWseWcQgFzBNZ+t16H5rPofdgZkS7205dywMh9LTndi5uR77NYUCiIt4YfHq
 8+4AAj7whkxEa4gcSWx/NZiSHK4kycLLwY5ZI7eG9rGv4x+OkVVjbm4SPRvCC7l24Lrl
 SALQ==
X-Gm-Message-State: AJIora95slHHqHS3Ti5n11oVZv8NGwmy2ebMb5XP6BM0knQU//7V19po
 ZLHuKrmwoCiMhiMVk9bywaxuzYzPqDD7/NnNR2pxpDd94R+y+kX6fltyXGd4IgIGStrdl16NK3e
 OmW/amqeX3EvepCt2qIfOYTPgDRsXQ7c26/fpRmq/VA==
X-Received: by 2002:a7b:c14c:0:b0:3a0:4abb:a921 with SMTP id
 z12-20020a7bc14c000000b003a04abba921mr9359289wmi.100.1656396637791; 
 Mon, 27 Jun 2022 23:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uYPpsc/vNcF8V81k2UPKWJOcoGV0c9Iyt5goPxWMxuimwfAbhL9YzgAF/m6F7YVT4+iKyThg==
X-Received: by 2002:a7b:c14c:0:b0:3a0:4abb:a921 with SMTP id
 z12-20020a7bc14c000000b003a04abba921mr9359258wmi.100.1656396637509; 
 Mon, 27 Jun 2022 23:10:37 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 q12-20020a5d61cc000000b0021cf31e1f7csm4556375wrv.102.2022.06.27.23.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 23:10:37 -0700 (PDT)
Date: Tue, 28 Jun 2022 02:10:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220628020832-mutt-send-email-mst@kernel.org>
References: <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
 <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
 <20220627074723-mutt-send-email-mst@kernel.org>
 <CACGkMEv0zdgG6SAaxRwkpObEFX_KRB1ovezNiHX+QXsYhE=qaQ@mail.gmail.com>
 <20220628014309-mutt-send-email-mst@kernel.org>
 <CACGkMEuzrmVsM5Xa3N_9n0-XOqyMAz65AON8oxkgmjnXb_bAFg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuzrmVsM5Xa3N_9n0-XOqyMAz65AON8oxkgmjnXb_bAFg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Jun 28, 2022 at 02:07:28PM +0800, Jason Wang wrote:
> On Tue, Jun 28, 2022 at 1:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 11:50:37AM +0800, Jason Wang wrote:
> > > On Mon, Jun 27, 2022 at 7:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> > > > > On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > > > > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > > > > > >
> > > > > > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > > > > > >
> > > > > > > > > > What exactly is meant by not breaking uABI?
> > > > > > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > > > > > >
> > > > > > > > > Not sure, any doc for this?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > >
> > > > > > > > Well we have this:
> > > > > > > >
> > > > > > > >         The drivers SHOULD only map part of configuration structure
> > > > > > > >         large enough for device operation.  The drivers MUST handle
> > > > > > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > > > > > >         is large enough for device operation.
> > > > > > >
> > > > > > > Yes, but that's the device/driver interface. What's done here is the
> > > > > > > userspace/kernel.
> > > > > > >
> > > > > > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Hmm I guess there's risk... but then how are we going to maintain this
> > > > > > going forward?  Add a new struct on any change?
> > > > >
> > > > > This is the way we have used it for the past 5 or more years. I don't
> > > > > see why this must be handled in the vq reset feature.
> > > > >
> > > > > >Can we at least
> > > > > > prevent this going forward somehow?
> > > > >
> > > > > Like have some padding?
> > > > >
> > > > > Thanks
> > > >
> > > > Maybe - this is what QEMU does ...
> > >
> > > Do you want this to be addressed in this series (it's already very huge anyhow)?
> > >
> > > Thanks
> >
> > Let's come up with a solution at least. QEMU does not seem to need the struct.
> 
> If we want to implement it in Qemu we need that:
> 
> https://github.com/fengidri/qemu/commit/39b79335cb55144d11a3b01f93d46cc73342c6bb
> 
> > Let's just put
> > it in virtio_pci_modern.h for now then?
> 
> Does this mean userspace needs to define the struct by their own
> instead of depending on the uapi in the future?
> 
> Thanks


$ git grep 'struct virtio_pci_common_cfg'
include/standard-headers/linux/virtio_pci.h:struct virtio_pci_common_cfg {
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, device_feature));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, device_feature));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, guest_feature));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                       offsetof(struct virtio_pci_common_cfg, guest_feature));
tests/qtest/libqos/virtio-pci-modern.c:                         offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                          offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_select),
tests/qtest/libqos/virtio-pci-modern.c:                         offsetof(struct virtio_pci_common_cfg, queue_size));
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_desc_lo),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_desc_hi),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_avail_lo),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_avail_hi),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_used_lo),
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_used_hi),
tests/qtest/libqos/virtio-pci-modern.c:                               offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_enable), 1);
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, msix_config), entry);
tests/qtest/libqos/virtio-pci-modern.c:                           offsetof(struct virtio_pci_common_cfg,
tests/qtest/libqos/virtio-pci-modern.c:                   offsetof(struct virtio_pci_common_cfg, queue_msix_vector),
tests/qtest/libqos/virtio-pci-modern.c:                           offsetof(struct virtio_pci_common_cfg,


The only user of the struct is libqos and it just wants
the offsets so can use macros just as well.


> >
> > > >
> > > > > >
> > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > > > > > this patch first.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > > > > > +
> > > > > > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > > > > > +     __le16 padding;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > > > > > >       struct virtio_pci_cap cap;
> > > > > > > > > > > --
> > > > > > > > > > > 2.31.0
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
