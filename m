Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE91DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 07:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F0582D14;
	Mon, 27 Jun 2022 07:45:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62F0582D14
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvbzazEh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GT4j8jg67lBA; Mon, 27 Jun 2022 07:45:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDEDD82D12;
	Mon, 27 Jun 2022 07:45:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDEDD82D12
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6986C0032;
	Mon, 27 Jun 2022 07:45:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5919C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B20226104C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B20226104C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvbzazEh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fKj0xjmW1FOC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:45:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABD9F60D4C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABD9F60D4C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656315944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DJ8lTv8mNQFqfIpLLTdJ5wTzmtewiqdkMpwZ7L0k0po=;
 b=CvbzazEhsnrxYlxxmqXKq/wjdpjt4q5JJ31r+UR+Ij8/avZTeFuFOdeNX48Nv4Xn6IDWrN
 SHSE1HW0dgpkA9BVDWgLHCxZZiPe367TXVSyHAPXs3mJlc8BtGzamdkLRoZe9vtIsSaiaa
 L3yhwunItgVpG8j5fcrHpaCNKGtcnFw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-w-tTwB-gM7mdRy94rXGnfQ-1; Mon, 27 Jun 2022 03:45:42 -0400
X-MC-Unique: w-tTwB-gM7mdRy94rXGnfQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 e10-20020a19674a000000b0047f8d95f43cso4342379lfj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 00:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DJ8lTv8mNQFqfIpLLTdJ5wTzmtewiqdkMpwZ7L0k0po=;
 b=j4KroxvX1tT8NkZVKdSyQMawDSzby/8dEhesZxBPKNmDqg22e+hIF+Hzt2jT+bBuD9
 RxxhH3jsVTr8LiG88UxwtfBl4a2YuBBlVBjpa0K5GPWgD+QR/+OHxKKdBpEG9esabp5j
 yHFbUmsQmpbdwTNHT5H3/hD85nlroxOhagecvT90K3Uin63MK0wDNeAapcx7oY09RvzR
 mcTGF0/BE6zKu/k+PuC9dtpUZz1XXoqN0PFGisw8wT1XCyDYiz1CLdXYh1A9D6HyRV21
 YmOtX0Fr9NdUD17+Ir/+7Y6Ux9IwpQBr9yT2m4zna1KAvMytNXJmKhDRO/+ciEj2W1Ky
 9D1Q==
X-Gm-Message-State: AJIora/xcgb+ZZPZ8aIZlqiCI3zcJLmNfu6AID5BFFrjLgPe41AVG2XZ
 2d7p1FFPdsVRnD4W61xb0SVfkzEm/7QfEByylOf6lL+b5vSnCVvO5QX5VuI0AMTTfM8VpFFhYiF
 RjgeZBDyjPLEf0tr3g3oBFz903v+6q6NsuMCTgeh4xOjI0+lBJbktlU21aQ==
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr6113588ljb.323.1656315941392; 
 Mon, 27 Jun 2022 00:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vViYYUTuYJvHrB7a6J1t+RbESIVnJ/fW5l8pDtbVNhAjJvWLMAazge0YptM+fayabkTwGDETijvn1jNEjsB7g=
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr6113578ljb.323.1656315941180; Mon, 27
 Jun 2022 00:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
 <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com>
 <20220627023841-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627023841-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jun 2022 15:45:30 +0800
Message-ID: <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > >
> > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > >
> > > What exactly is meant by not breaking uABI?
> > > Users are supposed to be prepared for struct size to change ... no?
> >
> > Not sure, any doc for this?
> >
> > Thanks
>
>
> Well we have this:
>
>         The drivers SHOULD only map part of configuration structure
>         large enough for device operation.  The drivers MUST handle
>         an unexpectedly large \field{length}, but MAY check that \field{length}
>         is large enough for device operation.

Yes, but that's the device/driver interface. What's done here is the
userspace/kernel.

Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?

Thanks

>
>
>
> >
> > >
> > >
> > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > this patch first.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > --- a/include/uapi/linux/virtio_pci.h
> > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > >       __le32 queue_used_hi;           /* read-write */
> > > >  };
> > > >
> > > > +struct virtio_pci_common_cfg_notify {
> > > > +     struct virtio_pci_common_cfg cfg;
> > > > +
> > > > +     __le16 queue_notify_data;       /* read-write */
> > > > +     __le16 padding;
> > > > +};
> > > > +
> > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > >  struct virtio_pci_cfg_cap {
> > > >       struct virtio_pci_cap cap;
> > > > --
> > > > 2.31.0
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
