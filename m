Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3310AC43334
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 05:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A977E82B51;
	Tue, 28 Jun 2022 05:46:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A977E82B51
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EErgBec7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjQ5i2Uk15yd; Tue, 28 Jun 2022 05:46:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BC8482B97;
	Tue, 28 Jun 2022 05:46:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BC8482B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5B8AC0039;
	Tue, 28 Jun 2022 05:46:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36F24C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE82D40496
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:46:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE82D40496
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EErgBec7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K8ziPZemPylV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:46:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CD04401A4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CD04401A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656395164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7XDCFUsIiO1RHnxPVoHQ+XTC5yX5gOLEJx5jlzpdwhw=;
 b=EErgBec7sb39rXHBpogjOn256OPm5sPhGTr9J4X2lq9hK21GXt7L+jchfm1CEE5FyUiHdi
 sNkS6G6bGuCwwtwbhLWXYnTa8zpbHlDkNkiSvGo4lf1TDkkKjcHsF3mGpX1k5F4u0WWWHd
 WbuP3KBCIqC4Tq9IkUtAdq6vsgzDNE0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-J-j4CVNJNImuPZvJ0kAkXg-1; Tue, 28 Jun 2022 01:46:00 -0400
X-MC-Unique: J-j4CVNJNImuPZvJ0kAkXg-1
Received: by mail-wm1-f69.google.com with SMTP id
 az40-20020a05600c602800b003a048edf007so2239012wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 22:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7XDCFUsIiO1RHnxPVoHQ+XTC5yX5gOLEJx5jlzpdwhw=;
 b=JGdnHdxfSmkP1QxORKe+w6eQosUvaE0kwOIEaTvm7/hqCObRFrfzLSc6A3GPebEhlV
 dwN7o+TqbARY6QOWgG3a6cCFhZbhp2hmH0DcsxmXy4ZBlud9poM7PF0whapvEtlOuTmS
 LZqWhpI5XCWj+evqbeSD9u7kA5GDZxu6VafLT0Hx2e2tN1v8So3Ru2rmtkXKyIZNvrjd
 jjbwlgeGALRaFciINd2+uo1hTqzELJq/JeM3W0UeY4B7vjpnWyBUDxX7OTqkvNeN7Ae8
 aE9ISO100VJOAAl3RvfQ7h6hfCr15SqkqRs0Lqer9wl91J8nyaUZifb3AfUZqGYjNuna
 jW7g==
X-Gm-Message-State: AJIora+47sbgYPgDsTt5Ru+pnI1m1uwEpJVvPIOsvmaPO23DDiIAxHJp
 4Z82eo9+CsT0uMQXeXOzqB3Fjw8qFVwGK2kc+a6NlBTIrwbKRYDn4A9HYhF1t4Mjh50gPxl/HtY
 UAbftdaDYSGvIC1WG2WcZ91xDR59mmrdcysLUDF2HcQ==
X-Received: by 2002:a05:600c:21ca:b0:3a0:48e6:60cb with SMTP id
 x10-20020a05600c21ca00b003a048e660cbmr12064687wmj.195.1656395159307; 
 Mon, 27 Jun 2022 22:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1kNy6ksKWTPEZ6IXDwV0UKlQdlBRLnRI/epxlGzaTFb6xBerM5hZUzFha89n6poU/6PoMPw==
X-Received: by 2002:a05:600c:21ca:b0:3a0:48e6:60cb with SMTP id
 x10-20020a05600c21ca00b003a048e660cbmr12064664wmj.195.1656395159084; 
 Mon, 27 Jun 2022 22:45:59 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c024700b003a03e63e428sm15257206wmj.36.2022.06.27.22.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 22:45:58 -0700 (PDT)
Date: Tue, 28 Jun 2022 01:45:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220628014309-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEv0zdgG6SAaxRwkpObEFX_KRB1ovezNiHX+QXsYhE=qaQ@mail.gmail.com>
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

On Tue, Jun 28, 2022 at 11:50:37AM +0800, Jason Wang wrote:
> On Mon, Jun 27, 2022 at 7:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> > > On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > > > >
> > > > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > > > >
> > > > > > > > What exactly is meant by not breaking uABI?
> > > > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > > > >
> > > > > > > Not sure, any doc for this?
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > Well we have this:
> > > > > >
> > > > > >         The drivers SHOULD only map part of configuration structure
> > > > > >         large enough for device operation.  The drivers MUST handle
> > > > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > > > >         is large enough for device operation.
> > > > >
> > > > > Yes, but that's the device/driver interface. What's done here is the
> > > > > userspace/kernel.
> > > > >
> > > > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > > > >
> > > > > Thanks
> > > >
> > > > Hmm I guess there's risk... but then how are we going to maintain this
> > > > going forward?  Add a new struct on any change?
> > >
> > > This is the way we have used it for the past 5 or more years. I don't
> > > see why this must be handled in the vq reset feature.
> > >
> > > >Can we at least
> > > > prevent this going forward somehow?
> > >
> > > Like have some padding?
> > >
> > > Thanks
> >
> > Maybe - this is what QEMU does ...
> 
> Do you want this to be addressed in this series (it's already very huge anyhow)?
> 
> Thanks

Let's come up with a solution at least. QEMU does not seem to need the struct. Let's just put
it in virtio_pci_modern.h for now then?

> >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > > > this patch first.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > > > >  1 file changed, 7 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > > > +
> > > > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > > > +     __le16 padding;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > > > >       struct virtio_pci_cap cap;
> > > > > > > > > --
> > > > > > > > > 2.31.0
> > > > > > > >
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
