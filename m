Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC3EC43334
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 08:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FC24402D0;
	Mon, 27 Jun 2022 08:14:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FC24402D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EyZZHRmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frNfh7XHOSku; Mon, 27 Jun 2022 08:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9261240BC7;
	Mon, 27 Jun 2022 08:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9261240BC7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F457C0032;
	Mon, 27 Jun 2022 08:14:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8201C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8266440BC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:14:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8266440BC7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hUeXy_AoNjx0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:14:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 601DF402D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 601DF402D0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656317675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pajM9hI9fI/87uBaTeYfHZ+TkaK2uNfPmDfKI6EwRtM=;
 b=EyZZHRmoVJ+rehBBd3oEfBipAtm9T5wlssvDIk1u1sv/gm/Rh1wOari7YQyZeRBvCseanR
 Qf1J3k5Lt2xsXd/89FTE13s9BMbu6ji049gm20KXV9n8sq95QA81MFDzSWpjd5snxK0aDV
 CJ6pZMNJ+1VjUNpo4iIpeANxM/bDA3E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-dkgkYoicOWCcCYZpM7osog-1; Mon, 27 Jun 2022 04:14:33 -0400
X-MC-Unique: dkgkYoicOWCcCYZpM7osog-1
Received: by mail-lf1-f69.google.com with SMTP id
 b2-20020a0565120b8200b00477a4532448so4370740lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 01:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pajM9hI9fI/87uBaTeYfHZ+TkaK2uNfPmDfKI6EwRtM=;
 b=T3glCOcGvbLH+pgFae0icDXJ2krCa3mDkH5t0SSk53knBp3VRrJotSp7hSMrDyivVK
 QbB+pPW6YF4+hzzod8BnOa3p7D8+3Zf2ItIm0qCJgrm4+K/BufmXkhUKNoZ19EiLYsEV
 /uzqh+BT4c9PI6I8J6J1kcxuSPaylrflCbasmZ01o4QGlAOcCAsEK0lH4GeHcfo71Qk5
 MGWzIncESwBZS3dgYNrjGrxJKMY/klRFDRVyGJ0+KybYiUnrwf6Jx+ObfA7545zfqcZR
 2Ui3EPAZLj2eaRU5I12Zo/l59ALcZBmoIGeNI43KzFHm7UdLTkHsc2BJR1/2ZKIqeQz/
 cdGA==
X-Gm-Message-State: AJIora/+NTeqKTKJhykmrl7nLILiEAjckQFIhP25lFbkOmv+ogbCHiVQ
 t0uygeDoOv9N3RCCKisxyhlEoJ3RJ1XCpbkRVvdAZtB1Fl8ZiMbsq+yVXGmHBav03vNzrP56alq
 xGT2j8EZI88O7jDJ583gpwd4LLB0NmRF5i7McFm2u7CkhrBnZeKlFQai3LQ==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr7309019lfa.124.1656317672102; 
 Mon, 27 Jun 2022 01:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stSWl4OiPqPtvMuSHVstpPhV2ncpnK2QP/uZDvpStVqiSUc6+7r6HgRqJbkG0p8fApLKYURBWKalbv9dZOpEk=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr7309001lfa.124.1656317671894; Mon, 27
 Jun 2022 01:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627034733-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jun 2022 16:14:20 +0800
Message-ID: <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > >
> > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > >
> > > > > What exactly is meant by not breaking uABI?
> > > > > Users are supposed to be prepared for struct size to change ... no?
> > > >
> > > > Not sure, any doc for this?
> > > >
> > > > Thanks
> > >
> > >
> > > Well we have this:
> > >
> > >         The drivers SHOULD only map part of configuration structure
> > >         large enough for device operation.  The drivers MUST handle
> > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > >         is large enough for device operation.
> >
> > Yes, but that's the device/driver interface. What's done here is the
> > userspace/kernel.
> >
> > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> >
> > Thanks
>
> Hmm I guess there's risk... but then how are we going to maintain this
> going forward?  Add a new struct on any change?

This is the way we have used it for the past 5 or more years. I don't
see why this must be handled in the vq reset feature.

>Can we at least
> prevent this going forward somehow?

Like have some padding?

Thanks

>
>
> > >
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > this patch first.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > >  1 file changed, 7 insertions(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > >  };
> > > > > >
> > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > +
> > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > +     __le16 padding;
> > > > > > +};
> > > > > > +
> > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > >  struct virtio_pci_cfg_cap {
> > > > > >       struct virtio_pci_cap cap;
> > > > > > --
> > > > > > 2.31.0
> > > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
