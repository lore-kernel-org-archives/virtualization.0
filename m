Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2CCCA473
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 07:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBF7F409BB;
	Mon, 27 Jun 2022 07:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBF7F409BB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C7ttxDhF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eya-uD-wPFtA; Mon, 27 Jun 2022 07:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 14F1840948;
	Mon, 27 Jun 2022 07:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14F1840948
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8759C0039;
	Mon, 27 Jun 2022 07:58:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2806BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0297D82F92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:58:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0297D82F92
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C7ttxDhF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpeIDL5KtmzX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:58:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01F6B82F6C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01F6B82F6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656316692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gR36iGOYPRI7XA3wSmeHv9qI5C/E+Rq80TLdrN+txO0=;
 b=C7ttxDhFu9D1WNQgJBoQgtayXbJONFghhNeTPD2Hzv4XcsffMOr2ladR+Z01wcr7PnlEhK
 rXVNjveDFR387D8vebOR8DROc6IxFyLhRY7Z8DLfMUthRM8XX5PxnaE7tk5lINMYSaCJGg
 8TF0wYlHByrkfs6ydoPTO9Hwnkqdg24=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-HfPLeMm4OBenCfZntIfYOw-1; Mon, 27 Jun 2022 03:58:09 -0400
X-MC-Unique: HfPLeMm4OBenCfZntIfYOw-1
Received: by mail-wr1-f69.google.com with SMTP id
 j14-20020adfa54e000000b0021b8c8204easo963808wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gR36iGOYPRI7XA3wSmeHv9qI5C/E+Rq80TLdrN+txO0=;
 b=e+mN7/NMWKH/u6OU+DH25TVIl0n6vKS295kiRdAFz5jd4QJZ6X+h/zNDVS5+616sIY
 vVb6lShizjtmdyFLa3j1nnFLli2A8qWvK4t0PiWPGfUx86B9A/6/u8McEozXuyYmjru1
 z/ZJIMGxBBeNqvT5ckFoJ33eMhT889xfrkHCsc8eyxP1Vlj7O8qZeV0UrCcOXxXl6CRt
 onrM/2BQfv977mxKaSTxKfZXD2GK5SunEPCeNGdF6iKC6BpHz3e7+OkMwQz1koGG/2ec
 zLVXalfUHWl1VQx8b9A5OEUaEeMLOFMgZ6Qziu9qaVYy1ZetiliHClnOGqcdzb61iFgR
 IRKw==
X-Gm-Message-State: AJIora/2rd+zoOFEeD0re56+eRSWaW+rWSWCtCJJDWKbpWaDB5SjXwTA
 ZlImvU25P3n4QV2ej/9ggZteBn98Z9K0mJbmnJY6i8fhRvl0Ba8d/4tsfAlzB6l9lpANrEviNS4
 7tjIHwgoA57Nrnhz7Kp1UHQpg+IhDRyQCD/t+7pPSmw==
X-Received: by 2002:a5d:6d8b:0:b0:21b:9804:1959 with SMTP id
 l11-20020a5d6d8b000000b0021b98041959mr10779912wrs.605.1656316688454; 
 Mon, 27 Jun 2022 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u006yfHOEqWpSmwDiypaX+nb3Ki7jpntJhsVXGDo34rsHtagr1loLXbMMVyBM9VityuTjV+A==
X-Received: by 2002:a5d:6d8b:0:b0:21b:9804:1959 with SMTP id
 l11-20020a5d6d8b000000b0021b98041959mr10779871wrs.605.1656316688168; 
 Mon, 27 Jun 2022 00:58:08 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 l13-20020a5d674d000000b0021bbdc3375fsm6171009wrw.68.2022.06.27.00.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 00:58:07 -0700 (PDT)
Date: Mon, 27 Jun 2022 03:57:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220627034733-mutt-send-email-mst@kernel.org>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > >
> > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > >
> > > > What exactly is meant by not breaking uABI?
> > > > Users are supposed to be prepared for struct size to change ... no?
> > >
> > > Not sure, any doc for this?
> > >
> > > Thanks
> >
> >
> > Well we have this:
> >
> >         The drivers SHOULD only map part of configuration structure
> >         large enough for device operation.  The drivers MUST handle
> >         an unexpectedly large \field{length}, but MAY check that \field{length}
> >         is large enough for device operation.
> 
> Yes, but that's the device/driver interface. What's done here is the
> userspace/kernel.
> 
> Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> 
> Thanks

Hmm I guess there's risk... but then how are we going to maintain this
going forward?  Add a new struct on any change? Can we at least
prevent this going forward somehow?


> >
> >
> >
> > >
> > > >
> > > >
> > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > this patch first.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > >       __le32 queue_used_hi;           /* read-write */
> > > > >  };
> > > > >
> > > > > +struct virtio_pci_common_cfg_notify {
> > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > +
> > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > +     __le16 padding;
> > > > > +};
> > > > > +
> > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > >  struct virtio_pci_cfg_cap {
> > > > >       struct virtio_pci_cap cap;
> > > > > --
> > > > > 2.31.0
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
