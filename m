Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FC4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 06:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 613BE6104C;
	Mon, 27 Jun 2022 06:39:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 613BE6104C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RBMXiC1q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1EnJdy6hG7o; Mon, 27 Jun 2022 06:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA8E760D5B;
	Mon, 27 Jun 2022 06:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA8E760D5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D1A9C007A;
	Mon, 27 Jun 2022 06:39:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36B18C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFF8A40977
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:39:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFF8A40977
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RBMXiC1q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hEr0aUDkLamT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A22E40943
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A22E40943
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656311992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7baKcmVh0uhuh+ZmBGa53jqLb2UYPCAjccnnH6jK0k=;
 b=RBMXiC1qYB+yM8w4m4XxcH1W4IekBWfTlqb/GcduNEEXtOwaM1ck51jGi/b7hfLKmSHy0p
 CSAUoZqCmGaGUF5zR7bq7sbVJKfhAPp903bFFStW7OEYHc0L7lcbiw0PIGwhnwjtHY8qOA
 WJB4Q/xuVHbw7h5BVeHbg8IfzGaA+jY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-xrRAC3pPOnuq3OM5g4GohA-1; Mon, 27 Jun 2022 02:39:50 -0400
X-MC-Unique: xrRAC3pPOnuq3OM5g4GohA-1
Received: by mail-wm1-f72.google.com with SMTP id
 6-20020a1c0206000000b003a02cd754d1so3134271wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 23:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U7baKcmVh0uhuh+ZmBGa53jqLb2UYPCAjccnnH6jK0k=;
 b=VMfKqSB+m/Ue3PrPPzIcKgNMEKtRtD5Ju1V5L1hIP+zcbfiywgUFdGAVWW/LDH82Gi
 evh/j/ehOS7v4vMZwDpNZA2p8fXyoFOfMHVj4zpTQ3EHie1Wr9i8CPDFu44FRsO3DBlN
 k1Gy9TApfKpWOflzIt1mAhkt+ovqja/bhd12Oblx5gg0sYXOS/30MRcLfgvC3ru7LWkE
 TrXr9uE3pw1nLaAH6y8N15MqtrVFeqdhFwV9p9T1k3R8MSpLKjzGNfiq4QKdMPRUn58s
 AtNUFekWPctgfZbwuxhAfZU5o1iOdf3Ylr1wfQ5NCSHtiASuK6nJNrdc34Qc1BQmUCBb
 seXw==
X-Gm-Message-State: AJIora+KLd2ylxGi/oJx7/bEH192ZEveGBevDcWLiol/kPiB/xKSxVDP
 5vXP3/Va8wAAvXND6kLFeCVD4XHDLs44mQlULVCUNZnQPjJAOmrBrdaZw/IUtMcxJcsFYOg+Vs+
 F/3dqvbN2UFn1KY4wSbgN8ssil4LFQRhXYj29IzoGwA==
X-Received: by 2002:a1c:7719:0:b0:3a0:31a6:4469 with SMTP id
 t25-20020a1c7719000000b003a031a64469mr13386063wmi.20.1656311988763; 
 Sun, 26 Jun 2022 23:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vfc26YvQIey3qttFGe5qu2ZyIXAHXaFMfl6hGpqk+G+5KirT06gbQyA+crLIwD71j66IUjig==
X-Received: by 2002:a1c:7719:0:b0:3a0:31a6:4469 with SMTP id
 t25-20020a1c7719000000b003a031a64469mr13386024wmi.20.1656311988469; 
 Sun, 26 Jun 2022 23:39:48 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 bg21-20020a05600c3c9500b003a046549a85sm5777975wmb.37.2022.06.26.23.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 23:39:47 -0700 (PDT)
Date: Mon, 27 Jun 2022 02:39:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220627023841-mutt-send-email-mst@kernel.org>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > >
> > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> >
> > What exactly is meant by not breaking uABI?
> > Users are supposed to be prepared for struct size to change ... no?
> 
> Not sure, any doc for this?
> 
> Thanks


Well we have this:

        The drivers SHOULD only map part of configuration structure
        large enough for device operation.  The drivers MUST handle
        an unexpectedly large \field{length}, but MAY check that \field{length}
        is large enough for device operation.



> 
> >
> >
> > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > this patch first.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > --- a/include/uapi/linux/virtio_pci.h
> > > +++ b/include/uapi/linux/virtio_pci.h
> > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > >       __le32 queue_used_hi;           /* read-write */
> > >  };
> > >
> > > +struct virtio_pci_common_cfg_notify {
> > > +     struct virtio_pci_common_cfg cfg;
> > > +
> > > +     __le16 queue_notify_data;       /* read-write */
> > > +     __le16 padding;
> > > +};
> > > +
> > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > >  struct virtio_pci_cfg_cap {
> > >       struct virtio_pci_cap cap;
> > > --
> > > 2.31.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
