Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D81C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 06:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4293760C0F;
	Tue, 28 Jun 2022 06:07:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4293760C0F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzdF+Mj2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Msj2byX_y_HV; Tue, 28 Jun 2022 06:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C10F260B71;
	Tue, 28 Jun 2022 06:07:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C10F260B71
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A83DBC0032;
	Tue, 28 Jun 2022 06:07:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A38AC007F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E86A4027A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E86A4027A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZzdF+Mj2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R96hj0k9tmRe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 180B5401A4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 180B5401A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656396462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUT1KDRsQCbghYqw5mAjvKAipnK8+qvq4+LEkef6mwI=;
 b=ZzdF+Mj2IqxdWF7wK88Rh5M2tdRUJlOUg2DckowUKqwboD5hiMOU+xdbT/pLIQxSbp9d6j
 x+8RjCMPT43nQaqwdHGV+32jzxePVc3vHQZWofbU/Eiv3HZCq96cKzt1emhGN4WzsTVcPu
 YLM1l6OFFGAw9SPrqhtOnAqcdsNamQg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-zu_3QQKmM4-MK0KyPehrJg-1; Tue, 28 Jun 2022 02:07:41 -0400
X-MC-Unique: zu_3QQKmM4-MK0KyPehrJg-1
Received: by mail-lj1-f197.google.com with SMTP id
 be13-20020a05651c170d00b0025a917675dcso1346197ljb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KUT1KDRsQCbghYqw5mAjvKAipnK8+qvq4+LEkef6mwI=;
 b=eXWx0p7XldhWSzkrUWYtB61NDEeQMXoLGRy2yOdZEzLf8bZ6CxQ63o2pZVwftYFsED
 3gyWSVcy9+aPuNXWoymLMi3B037vyqdzwhd/WuLw0zRqSD0E9WbsnQNf2tzrdEwzJiaN
 crNhtq3JmIQMn2NDnPb1CdQqkageVoZXdWm/km4WYbK7dOqCdLVbvu6PV/BREOH1qdUn
 /373nfjdjiquX8ojz3/PmoZFJS7Tbdnyv95OB0oBUB24E/tpwfOj6RrOPXEDyd80SIiK
 Bd9DK7jidLtbp6kIAytVZJ9+GLRiz5pnlO+A+DOvX2CXrew8dSMezUzywRsM6NOHZ+xh
 c23A==
X-Gm-Message-State: AJIora8nwul5q/Uctaoa0UMfqDTtYrnDGhw2vY4yFKpYsmm4jQaU9RmW
 th1MA+Sc0a60NAimhwRJYNKQcwcdaqWSqJxZxs0PkR+sGfZkvDXrDsGDp8A8sTlgcRSqqVhiRCD
 6UakXLdaHnMsN12vqCJJouJoWGH/T8FpAPnQvmoiry9Kc8NP1kU/jsxB7PQ==
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr8315115ljq.251.1656396460035; 
 Mon, 27 Jun 2022 23:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uv1ZBawh+P9oWSPBH26qPWCIYjS9uNve6lqad17cW1vkQvItG6ZzBL6RQ0GxzhIXXq3N271R2bfg7ykwVXyRw=
X-Received: by 2002:a05:651c:895:b0:250:c5ec:bc89 with SMTP id
 d21-20020a05651c089500b00250c5ecbc89mr8315105ljq.251.1656396459820; Mon, 27
 Jun 2022 23:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
 <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
 <20220627074723-mutt-send-email-mst@kernel.org>
 <CACGkMEv0zdgG6SAaxRwkpObEFX_KRB1ovezNiHX+QXsYhE=qaQ@mail.gmail.com>
 <20220628014309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220628014309-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Jun 2022 14:07:28 +0800
Message-ID: <CACGkMEuzrmVsM5Xa3N_9n0-XOqyMAz65AON8oxkgmjnXb_bAFg@mail.gmail.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Tue, Jun 28, 2022 at 1:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 11:50:37AM +0800, Jason Wang wrote:
> > On Mon, Jun 27, 2022 at 7:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> > > > On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > > > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > > > > >
> > > > > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > > > > >
> > > > > > > > > What exactly is meant by not breaking uABI?
> > > > > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > > > > >
> > > > > > > > Not sure, any doc for this?
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > Well we have this:
> > > > > > >
> > > > > > >         The drivers SHOULD only map part of configuration structure
> > > > > > >         large enough for device operation.  The drivers MUST handle
> > > > > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > > > > >         is large enough for device operation.
> > > > > >
> > > > > > Yes, but that's the device/driver interface. What's done here is the
> > > > > > userspace/kernel.
> > > > > >
> > > > > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Hmm I guess there's risk... but then how are we going to maintain this
> > > > > going forward?  Add a new struct on any change?
> > > >
> > > > This is the way we have used it for the past 5 or more years. I don't
> > > > see why this must be handled in the vq reset feature.
> > > >
> > > > >Can we at least
> > > > > prevent this going forward somehow?
> > > >
> > > > Like have some padding?
> > > >
> > > > Thanks
> > >
> > > Maybe - this is what QEMU does ...
> >
> > Do you want this to be addressed in this series (it's already very huge anyhow)?
> >
> > Thanks
>
> Let's come up with a solution at least. QEMU does not seem to need the struct.

If we want to implement it in Qemu we need that:

https://github.com/fengidri/qemu/commit/39b79335cb55144d11a3b01f93d46cc73342c6bb

> Let's just put
> it in virtio_pci_modern.h for now then?

Does this mean userspace needs to define the struct by their own
instead of depending on the uapi in the future?

Thanks

>
> > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > > > > this patch first.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > > > > +
> > > > > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > > > > +     __le16 padding;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > > > > >       struct virtio_pci_cap cap;
> > > > > > > > > > --
> > > > > > > > > > 2.31.0
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
