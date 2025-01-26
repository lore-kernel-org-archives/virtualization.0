Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496EE80034
	for <virtualization@lists.linux.dev>; Sun, 26 Jan 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737878662; cv=none; b=cS0UvxrCrWaoVxw4yJWtbfe43CNx2+SNSNpxANdbati2WdHH6/kRZgeKlUfrM3FbBtWhCEQJjFD2JlxkPS3Zx30wIJYywsCCIEPcG6R2XnxC6FWO7Rzs1baPb+XvZNgi43M+aeaN6Y7CHCwiABmMODK9hf2JEh793YFyDGupFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737878662; c=relaxed/simple;
	bh=EmEHD1zhsfN64NPKSyz1CabABu7WvztQmGJ1hsT/hEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iJlYx5qZ+LlZHtvGovmcDpttv70IiX88n6lB5uFMsXLQIg5PO0V6XcC7hqKvtvJjkuj9vTmNCDtDwOAZ7B2QTOFILwd74QnmDzhbYLnuues6J6NlCmT1fkJroyxyU2yDf96FoKQIAd3KENfLsZNggB0haR9NP0tltBqWYyvcwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qj9ldWPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj9ldWPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737878659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/eC54RqFvM1K0GxY2qQosRFNAZx56Iy0IiA8zFllf4=;
	b=Qj9ldWPuQ4PfzPKmExkfR3FtNUSo+CxdUQI6wvM0xvppcnKdTKDok76wPIR4W+wVRML6rb
	5RMWtkRxYZtx9I9aqAi4GnJb744UHgkk5wsR/zjuY8tGsvCD0hjkfQhzKZUH4kjYgUlV4T
	vx2yJAqrbVey76ZZTYWsdaN9VlsDKE0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-W4WozijPMT-QIeUpPWTxyQ-1; Sun, 26 Jan 2025 03:04:17 -0500
X-MC-Unique: W4WozijPMT-QIeUpPWTxyQ-1
X-Mimecast-MFC-AGG-ID: W4WozijPMT-QIeUpPWTxyQ
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-218ad674181so90775095ad.1
        for <virtualization@lists.linux.dev>; Sun, 26 Jan 2025 00:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737878657; x=1738483457;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/eC54RqFvM1K0GxY2qQosRFNAZx56Iy0IiA8zFllf4=;
        b=wjrhot5VkPaaCoyLJeH5G+bfWDcJ8xqxRsd2wruYUPQgcBJEoHwVy79G0hUKIyUWvS
         Xz7exzp3fOai2ifAWbCwbe/QHw+6HVYTcpuO3NZWoYFZuCxMplkr4LeUOhnJ/ssc/4zq
         lLsqAFOvgEQfW0z0+l/woUf2p3xhxmWc7or8yq9Xktha1HlYFYQ6i25gytprZJibuSG3
         oTPXMhJBB4OLYeYNluRyOpzEXSp/+EWJhJoMXt3rDYpgokRb0olzJ+aQGX6dvenbWZQP
         Ck7m8syRzPbCNed8QVy7n26xSd0bNCgOvqm7BdkZ7odQAbUPGfecEF4E2T7C5aMpM1K6
         jgeA==
X-Forwarded-Encrypted: i=1; AJvYcCWxnjfXTCus+DRO76GCqRYqJLoz0l2Muap5tgmzSLYRSQ2lsmsx/hrbzL3T+cwVETfJxGzia0ifN7Ma0QPocw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw5hVTvYjyy0UlYVQL4b7obOZ9YYaUH49q8G+kEF3j5FHxpEIl
	jfF0in2gnt2zb8Qs7/6hpEjf2x36WfBKhLoXKys87vbXWY1P5vLr52jvSBbBCA/7MzhfVi2Injd
	Yz/QVPmpxxOsWMyPVSE39Vm9zZSS/QsfsIsD4hG0TuH2uRtMDJTkrQJGMWuxBJ8MdQu0gW4Izsh
	eG0DdFEvmscVV4seeb9au06eQXdiP80+VPA/zmRqI=
X-Gm-Gg: ASbGncsK5e/ODb00n4bL/DfFxHMlnBrySSqc2EMZGKwvna6B6nkKg5nC6bWAbyCHU/F
	UG/1thOQf3YcjSvWnlgvSEjiwIgHkwbKZ1yLswiFMzpqBIWEqkQiYtaOhzu4pzkKA
X-Received: by 2002:a05:6a21:158d:b0:1e1:a449:ff71 with SMTP id adf61e73a8af0-1eb6968a845mr21791129637.1.1737878656563;
        Sun, 26 Jan 2025 00:04:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQPmUWpkIvATEslfzV7Si6dQ5DCKuZzcMT2tS50nLTQbAUEv9A6x09wBrrKHebRblZnuNbf1FcN8imDYYAl/M=
X-Received: by 2002:a05:6a21:158d:b0:1e1:a449:ff71 with SMTP id
 adf61e73a8af0-1eb6968a845mr21791090637.1.1737878656048; Sun, 26 Jan 2025
 00:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121191047.269844-1-jdamato@fastly.com> <20250121191047.269844-3-jdamato@fastly.com>
 <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2> <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2> <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
 <Z5P10c-gbVmXZne2@LQ3V64L9R2>
In-Reply-To: <Z5P10c-gbVmXZne2@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 26 Jan 2025 16:04:02 +0800
X-Gm-Features: AWEUYZn0pFYWiwuO7DM8AlLXMKubWaWMScL_rJqH8CltUwKyuuhU9ZUlqE80pYk
Message-ID: <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, 
	gerhard@engleder-embedded.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s49TxcAw6HuTwWmDzSoT0iR9TvYIQZD3bL7oPOYDcQY_1737878657
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 4:19=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Fri, Jan 24, 2025 at 09:14:54AM +0800, Jason Wang wrote:
> > On Thu, Jan 23, 2025 at 10:47=E2=80=AFAM Joe Damato <jdamato@fastly.com=
> wrote:
> > >
> > > On Thu, Jan 23, 2025 at 10:40:43AM +0800, Jason Wang wrote:
> > > > On Thu, Jan 23, 2025 at 1:41=E2=80=AFAM Joe Damato <jdamato@fastly.=
com> wrote:
> > > > >
> > > > > On Wed, Jan 22, 2025 at 02:12:46PM +0800, Jason Wang wrote:
> > > > > > On Wed, Jan 22, 2025 at 3:11=E2=80=AFAM Joe Damato <jdamato@fas=
tly.com> wrote:
> > > > > > >
> > > > > > > Slight refactor to prepare the code for NAPI to queue mapping=
. No
> > > > > > > functional changes.
> > > > > > >
> > > > > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > > > > Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > > > > > > Tested-by: Lei Yang <leiyang@redhat.com>
> > > > > > > ---
> > > > > > >  v2:
> > > > > > >    - Previously patch 1 in the v1.
> > > > > > >    - Added Reviewed-by and Tested-by tags to commit message. =
No
> > > > > > >      functional changes.
> > > > > > >
> > > > > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index 7646ddd9bef7..cff18c66b54a 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqu=
eue *rvq)
> > > > > > >         virtqueue_napi_schedule(&rq->napi, rvq);
> > > > > > >  }
> > > > > > >
> > > > > > > -static void virtnet_napi_enable(struct virtqueue *vq, struct=
 napi_struct *napi)
> > > > > > > +static void virtnet_napi_do_enable(struct virtqueue *vq,
> > > > > > > +                                  struct napi_struct *napi)
> > > > > > >  {
> > > > > > >         napi_enable(napi);
> > > > > >
> > > > > > Nit: it might be better to not have this helper to avoid a misu=
se of
> > > > > > this function directly.
> > > > >
> > > > > Sorry, I'm probably missing something here.
> > > > >
> > > > > Both virtnet_napi_enable and virtnet_napi_tx_enable need the logi=
c
> > > > > in virtnet_napi_do_enable.
> > > > >
> > > > > Are you suggesting that I remove virtnet_napi_do_enable and repea=
t
> > > > > the block of code in there twice (in virtnet_napi_enable and
> > > > > virtnet_napi_tx_enable)?
> > > >
> > > > I think I miss something here, it looks like virtnet_napi_tx_enable=
()
> > > > calls virtnet_napi_do_enable() directly.
> > > >
> > > > I would like to know why we don't call netif_queue_set_napi() for T=
X NAPI here?
> > >
> > > Please see both the cover letter and the commit message of the next
> > > commit which addresses this question.
> > >
> > > TX-only NAPIs do not have NAPI IDs so there is nothing to map.
> >
> > Interesting, but I have more questions
> >
> > 1) why need a driver to know the NAPI implementation like this?
>
> I'm not sure I understand the question, but I'll try to give an
> answer and please let me know if you have another question.
>
> Mapping the NAPI IDs to queue IDs is useful for applications that
> use epoll based busy polling (which relies on the NAPI ID, see also
> SO_INCOMING_NAPI_ID and [1]), IRQ suspension [2], and generally
> per-NAPI configuration [3].
>
> Without this code added to the driver, the user application can get
> the NAPI ID of an incoming connection, but has no way to know which
> queue (or NIC) that NAPI ID is associated with or to set per-NAPI
> configuration settings.
>
> [1]: https://lore.kernel.org/all/20240213061652.6342-1-jdamato@fastly.com=
/
> [2]: https://lore.kernel.org/netdev/20241109050245.191288-5-jdamato@fastl=
y.com/T/
> [3]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.c=
om/

Yes, exactly. Sorry for being unclear, what I want to ask is actually:

1) TX NAPI doesn't have a NAPI ID, this seems more like a NAPI
implementation details which should be hidden from the driver.
2) If 1 is true, in the netif_queue_set_napi(), should it be better to
add and check for whether or not NAPI has an ID and return early if it
doesn't have one
3) Then driver doesn't need to know NAPI implementation details like
NAPI stuffs?

>
> > 2) does NAPI know (or why it needs to know) whether or not it's a TX
> > or not? I only see the following code in napi_hash_add():
>
> Note that I did not write the original implementation of NAPI IDs or
> epoll-based busy poll, so I can only comment on what I know :)
>
> I don't know why TX-only NAPIs do not have NAPI IDs. My guess is
> that in the original implementation, the code was designed only for
> RX busy polling, so TX-only NAPIs were not assigned NAPI IDs.
>
> Perhaps in the future, TX-only NAPIs will be assigned NAPI IDs, but
> currently they do not have NAPI IDs.

Jakub, could you please help to clarify this part?

>
> > static void napi_hash_add(struct napi_struct *napi)
> > {
> >         unsigned long flags;
> >
> >         if (test_bit(NAPI_STATE_NO_BUSY_POLL, &napi->state))
> >                 return;
> >
> > ...
> >
> >         __napi_hash_add_with_id(napi, napi_gen_id);
> >
> >         spin_unlock_irqrestore(&napi_hash_lock, flags);
> > }
> >
> > It seems it only matters with NAPI_STATE_NO_BUSY_POLL.
> >
> > And if NAPI knows everything, should it be better to just do the
> > linking in napi_enable/disable() instead of letting each driver do it
> > by itself?
>
> It would be nice if this were possible, I agree. Perhaps in the
> future some work could be done to make this possible.
>
> I believe that this is not currently possible because the NAPI does
> not know which queue ID it is associated with. That mapping of which
> queue is associated with which NAPI is established in patch 3
> (please see the commit message of patch 3 to see an example of the
> output).
>
> The driver knows both the queue ID and the NAPI for that queue, so
> the mapping can be established only by the driver.
>
> Let me know if that helps.

Yes, definitely.

Let's see Jakub's comment.

Thanks

>
> - Joe
>

