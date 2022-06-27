Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BE9CCA483
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 11:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CA1A60B58;
	Mon, 27 Jun 2022 11:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CA1A60B58
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeIcQ6e3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWSwBvqoCEAc; Mon, 27 Jun 2022 11:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F0E76600C6;
	Mon, 27 Jun 2022 11:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0E76600C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6F07C0039;
	Mon, 27 Jun 2022 11:53:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8EFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 11:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ACB5409F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 11:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1ACB5409F9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FeIcQ6e3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FQi6Dm6gPgnc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 11:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE833409C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE833409C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656330814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4iA+zJThegEvaay5X9bkB6r2mlx5a4ueL2JEW4gqMI=;
 b=FeIcQ6e3yng56d8qz4G1TEH7FOaa21sxSkkHSwZRFcwQoyZDYGGFGk7IFi83nRaVUDsawO
 mHlmCSM5MmfdvfNq67xjo7rCZqKe0k6eGCzA+GEA8TiPA+hmqfCH/lyAHbDWzkXdtWrG1b
 XegJPHGGm8nzABbCuz9nZ03O+Am/Zkc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-RYiMPgucOq-4X73oUjbcJw-1; Mon, 27 Jun 2022 07:53:31 -0400
X-MC-Unique: RYiMPgucOq-4X73oUjbcJw-1
Received: by mail-wm1-f69.google.com with SMTP id
 p6-20020a05600c358600b003a0483b3c2eso2125634wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 04:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R4iA+zJThegEvaay5X9bkB6r2mlx5a4ueL2JEW4gqMI=;
 b=XIMIYhonkGbhu2LE7gonWYrBYDDn0MAsU0uhaqle1AIuH0M5TX/x1fENK/SsPhnzJc
 jogqPLi+iKNUzFoCszvc2VKqFP7JmIp1ryHbG3lZNNvdw8H/0SupicpS5JKBJukMpOvR
 JZFF5JIf3XMebVMhYwx+93xlHjzqOQi7FG9jhB/GDzAc+F8eBU0TXHiBisReFw9r+xOg
 EWnKBNY+hrJGAF9gM1LldrtQiR+qXL8NPuOramFv+U2VUD8UHRko7KoULKhVO9QTquFf
 z7C+obTpFURKmHJYPTtgW04jKP1hwxg+8iVwUBWD8kOURRw1mccxMp8hpJXhmEE1qa4K
 Nh0Q==
X-Gm-Message-State: AJIora8K9SH9OVGLTuLFmjXANzkP2oAWXzkpE4qqiNYvHQdex+oGmL+0
 o85ynYZ+5fgbBdWmj9hofOZKraHmbODgOPH7blzx5s7p1z6MmfbwPPg0U2o5m/gh8UWcJibcltF
 g0vuE5PTC2Xn/xOaHa//AcpMt9M4YeUvTguLps5g6DA==
X-Received: by 2002:a1c:7c18:0:b0:3a0:39b1:3403 with SMTP id
 x24-20020a1c7c18000000b003a039b13403mr21172900wmc.84.1656330810173; 
 Mon, 27 Jun 2022 04:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umV07YHfv9l89u85pmjMFPA0YWmqYXm7VuXyf0J+ISW9dEoHO5P2MBiXRfYI/0CpLN0ZOgWg==
X-Received: by 2002:a1c:7c18:0:b0:3a0:39b1:3403 with SMTP id
 x24-20020a1c7c18000000b003a039b13403mr21172868wmc.84.1656330809951; 
 Mon, 27 Jun 2022 04:53:29 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05600c349300b0039db500714fsm13454861wmq.6.2022.06.27.04.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 04:53:29 -0700 (PDT)
Date: Mon, 27 Jun 2022 07:53:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220627074723-mutt-send-email-mst@kernel.org>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
 <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
 <20220627034733-mutt-send-email-mst@kernel.org>
 <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtpjUBaUML=fEs5hR66rzNTBhBXOmfpzyXV1F-6BqvsGg@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 04:14:20PM +0800, Jason Wang wrote:
> On Mon, Jun 27, 2022 at 3:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 03:45:30PM +0800, Jason Wang wrote:
> > > On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > > > > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > > > > >
> > > > > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > > > > >
> > > > > > What exactly is meant by not breaking uABI?
> > > > > > Users are supposed to be prepared for struct size to change ... no?
> > > > >
> > > > > Not sure, any doc for this?
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > Well we have this:
> > > >
> > > >         The drivers SHOULD only map part of configuration structure
> > > >         large enough for device operation.  The drivers MUST handle
> > > >         an unexpectedly large \field{length}, but MAY check that \field{length}
> > > >         is large enough for device operation.
> > >
> > > Yes, but that's the device/driver interface. What's done here is the
> > > userspace/kernel.
> > >
> > > Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?
> > >
> > > Thanks
> >
> > Hmm I guess there's risk... but then how are we going to maintain this
> > going forward?  Add a new struct on any change?
> 
> This is the way we have used it for the past 5 or more years. I don't
> see why this must be handled in the vq reset feature.
> 
> >Can we at least
> > prevent this going forward somehow?
> 
> Like have some padding?
> 
> Thanks

Maybe - this is what QEMU does ...

> >
> >
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > > > > this patch first.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > > > > >  1 file changed, 7 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > > > > --- a/include/uapi/linux/virtio_pci.h
> > > > > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > > > > >       __le32 queue_used_hi;           /* read-write */
> > > > > > >  };
> > > > > > >
> > > > > > > +struct virtio_pci_common_cfg_notify {
> > > > > > > +     struct virtio_pci_common_cfg cfg;
> > > > > > > +
> > > > > > > +     __le16 queue_notify_data;       /* read-write */
> > > > > > > +     __le16 padding;
> > > > > > > +};
> > > > > > > +
> > > > > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > > > > >  struct virtio_pci_cfg_cap {
> > > > > > >       struct virtio_pci_cap cap;
> > > > > > > --
> > > > > > > 2.31.0
> > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
