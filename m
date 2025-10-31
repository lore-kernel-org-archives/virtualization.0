Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3841348463
	for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913281; cv=none; b=LWo99GCzlFwUupLv81Mp09Y2etV3RvHcV+o1VofPUP8QeqThRuYeE0QwGGo1PtV3rCW+79g/isBE/KDQ1zhbjHDi43h81xZmrXJerSYtDMiX/C4GVmXGyv1CGeBUM/M3zeBj4xVXNPr3J5g/gcFQXwYHQxYYXYicqQybCHYHC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913281; c=relaxed/simple;
	bh=dNEsyz9/fjHmgiXJALdzGhqysk9Jy/a3WOK15fNNKck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwTGCCU5Wsqe0GVLjze2TpLx+V7HZ5LefAs/cGLSCtNGW1oET57Cdx/avZbbYe8Spa6qyhKcNp5OQxUsP9AiOscBQxJEay1EEgkHApabFJfWxY7pBCH06tlD0D4+G8Onyxd22klgRD4EuUUuRHamCzfywwrXc+4vYg08+vxDa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/u77MOE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/u77MOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761913278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUwKOyluTKFUudeOxZ3owrromDAOtIhl6Ta/vPwuydw=;
	b=h/u77MOE2Ay3CkjzFNJd6fwKCLcKEjA8OQ7kHaJHw9XK4YgRHssBIi5a0rOvDYvMFH08gD
	i/Oyxq0xDg4RHr+hTLMQBqCbGJUlW7bIat4nMFsGRV7irSsRKrlbNfNSqId/WjtCAZ9e1d
	yC9vvDE8QoZIjuYwb5Oad9ESOyA0QA4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-NlODOVRWOJ2WWOyx_HMTQw-1; Fri, 31 Oct 2025 08:21:15 -0400
X-MC-Unique: NlODOVRWOJ2WWOyx_HMTQw-1
X-Mimecast-MFC-AGG-ID: NlODOVRWOJ2WWOyx_HMTQw_1761913274
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-63e0b49cd15so2570016a12.0
        for <virtualization@lists.linux.dev>; Fri, 31 Oct 2025 05:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913274; x=1762518074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUwKOyluTKFUudeOxZ3owrromDAOtIhl6Ta/vPwuydw=;
        b=geUqdF8F8pXqAAR1sEF+hpb2p2wxNgQe2zDYYtm9IIBJnHCg6bZrkMh/wRDH/WMbAZ
         ZrTPXMnDco2GK3gOdp4+Oy1s1FlpIqixmrEok4AZwPH+nPdW3bF9kJo8WriVGhx6U1Id
         88rxZejT6/dG5eM70K+vjcKmkUZ47YzX2DwDHYjv8J0Uqt3+OZbZhUNbL1HIr7TYDofg
         +k9P7RwU6D3QL8/0ZzMLgHrOWFUnbjx8VyaCcWBUKISDb0X+r4Q8iYgTBN+hSmYzhoyX
         bLLArPIHzRzOwrFJ2l0EQir0hYdBLUFLvIRWGyTOkOdrKxwvWxty2a6amYYAEsMOUfC4
         Uc1w==
X-Forwarded-Encrypted: i=1; AJvYcCWUexNnYt2G1Vhpgdidh0g2DN8OUu0fznMGtFImrmXbcx/rwL8AKN4/K4R+TMw5/OwtZZ6W8f/eUPOkQmsezg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMY9LULX5E5XIn1R0q9dibdwWWU2IdtlsL74Lx5Im5V7yU5AIj
	3h9HEOsH0u+onIC98A781nYyFJCMf9IEREPfB1FumKw/qtN/FZ4pHavRMbKzHiSDhEa3sLCo6O7
	IqmRk0JxB61kOQnxjO0PFFtc3x0gKN+ljIaTkYmjUI6kuSgRD3Vja2L87tYzv+frYZ5/0OZdWmO
	WSZcIWRYDbOnle9BYG0JVv6yHe5WvXys29mfomleE724k=
X-Gm-Gg: ASbGnct5jETuXfD9r6yRHbPpWer8fLZQRQWlT0HzcLF84ptmy4aiA6bp7GsHwI3yNYD
	XMn0wlp+n5HcIEu/H4IdHBMTKpPrM6HZdXwRB4GHaDeORhYWUN8C5s38NtQDS2d9th+YR3br308
	iw61DNrhmtrMmMS0uPtaHbEig4hdo6CHTHRDkjpE2dIPmpM29SHZStKg==
X-Received: by 2002:a05:6402:268e:b0:63e:2d46:cc5d with SMTP id 4fb4d7f45d1cf-64076f71156mr2639091a12.7.1761913274264;
        Fri, 31 Oct 2025 05:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Fg/d8n1FygAt9C8iITIr/MFTt7Px6ZvAbp5bcXhaAojwuNapTMQWGvKPz3qAk5AhCrGGK2uxWoEXbc58yYM=
X-Received: by 2002:a05:6402:268e:b0:63e:2d46:cc5d with SMTP id
 4fb4d7f45d1cf-64076f71156mr2639055a12.7.1761913273764; Fri, 31 Oct 2025
 05:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <27327622.1r3eYUQgxm@fedora.fritz.box> <aPdU93e2RQy5MHQr@fedora>
 <28156189.1r3eYUQgxm@fedora.fritz.box> <aPeHbKES6yHkh5Rj@fedora>
In-Reply-To: <aPeHbKES6yHkh5Rj@fedora>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Fri, 31 Oct 2025 13:21:02 +0100
X-Gm-Features: AWmQ_bmWfyMfD1zverJ1ufhNFgKPX2AvwLjdAsskFXlhQ-Z7R9j1OZE63m7EKMI
Message-ID: <CAHYGQ0x9ZDZ9R3s_X7irXkQ0dCGbe7CQa_-zOcf19-QqDrapRw@mail.gmail.com>
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Harald Mommer <harald.mommer@opensynergy.com>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, development@redaril.me
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xq6Fvgj9vKCrZ_LwEZmAC2vblYdr2OWF7KCVISImGkY_1761913274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:15=E2=80=AFPM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> On Tue, Oct 21, 2025 at 02:08:35PM +0200, Francesco Valla wrote:
> > On Tuesday, 21 October 2025 at 11:40:07 Matias Ezequiel Vara Larsen <mv=
aralar@redhat.com> wrote:
> > > On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> > > > On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen =
<mvaralar@redhat.com> wrote:
> > > > > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > > > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara La=
rsen <mvaralar@redhat.com> wrote:
> > > > > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wro=
te:
> > > > > > > > Hello Mikhail, Harald,
> > > > > > > >
> > > > > > > > hoping there will be a v6 of this patch soon, a few comment=
s:
> > > > > > > >
> > > > > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuch=
ea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > > > >
> > > > > > > > [...]
> > > > > > > > > +
> > > > > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq=
)
> > > > > > > > > +{
> > > > > > > > > +       struct virtio_can_priv *can_priv =3D vq->vdev->pr=
iv;
> > > > > > > > > +       struct net_device *dev =3D can_priv->dev;
> > > > > > > > > +       struct virtio_can_tx *can_tx_msg;
> > > > > > > > > +       struct net_device_stats *stats;
> > > > > > > > > +       unsigned long flags;
> > > > > > > > > +       unsigned int len;
> > > > > > > > > +       u8 result;
> > > > > > > > > +
> > > > > > > > > +       stats =3D &dev->stats;
> > > > > > > > > +
> > > > > > > > > +       /* Protect list and virtio queue operations */
> > > > > > > > > +       spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > > > > +
> > > > > > > > > +       can_tx_msg =3D virtqueue_get_buf(vq, &len);
> > > > > > > > > +       if (!can_tx_msg) {
> > > > > > > > > +               spin_unlock_irqrestore(&can_priv->tx_lock=
, flags);
> > > > > > > > > +               return 0; /* No more data */
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       if (unlikely(len < sizeof(struct virtio_can_tx_in=
))) {
> > > > > > > > > +               netdev_err(dev, "TX ACK: Device sent no r=
esult code\n");
> > > > > > > > > +               result =3D VIRTIO_CAN_RESULT_NOT_OK; /* K=
eep things going */
> > > > > > > > > +       } else {
> > > > > > > > > +               result =3D can_tx_msg->tx_in.result;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > > > > +               /* Here also frames with result !=3D VIRT=
IO_CAN_RESULT_OK are
> > > > > > > > > +                * echoed. Intentional to bring a waiting=
 process in an upper
> > > > > > > > > +                * layer to an end.
> > > > > > > > > +                * TODO: Any better means to indicate a p=
roblem here?
> > > > > > > > > +                */
> > > > > > > > > +               if (result !=3D VIRTIO_CAN_RESULT_OK)
> > > > > > > > > +                       netdev_warn(dev, "TX ACK: Result =
=3D %u\n", result);
> > > > > > > >
> > > > > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be=
 better?
> > > > > > > >
> > > > > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indica=
ted during
> > > > > > > a problem in the rx path and this is the tx path. I think the=
 comment
> > > > > > > refers to improving the way the driver informs this error to =
the user
> > > > > > > but I may be wrong.
> > > > > > >
> > > > > >
> > > > > > Since we have no detail of what went wrong here, I suggested
> > > > > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled=
 with a
> > > > > > controller error with id CAN_ERR_CRTL; however, a different err=
or might be
> > > > > > more appropriate.
> > > > > >
> > > > > > For sure, at least in my experience, having a warn printed to k=
msg is *not*
> > > > > > enough, as the application sending the message(s) would not be =
able to detect
> > > > > > the error.
> > > > > >
> > > > > >
> > > > > > > > For sure, counting the known errors as valid tx_packets and=
 tx_bytes
> > > > > > > > is misleading.
> > > > > > > >
> > > > > > >
> > > > > > > I'll remove the counters below.
> > > > > > >
> > > > > >
> > > > > > We don't really know what's wrong here - the packet might have =
been sent and
> > > > > > and then not ACK'ed, as well as any other error condition (as i=
t happens in the
> > > > > > reference implementation from the original authors [1]). Echoin=
g the packet
> > > > > > only "to bring a waiting process in an upper layer to an end" a=
nd incrementing
> > > > > > counters feels wrong, but maybe someone more expert than me can=
 advise better
> > > > > > here.
> > > > > >
> > > > > >
> > > > >
> > > > > I agree. IIUC, in case there has been a problem during transmissi=
on, I
> > > > > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC packag=
e with
> > > > > netif_rx() and 2) use can_free_echo_skb() and increment the tx_er=
ror
> > > > > stats. Is this correct?
> > > > >
> > > > > Matias
> > > > >
> > > > >
> > > >
> > > > That's my understanding too! stats->tx_dropped should be the right =
value to
> > > > increment (see for example [1]).
> > > >
> > > > [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can=
/ctucanfd/ctucanfd_base.c#L1035
> > > >
> > >
> > > I think the counter to increment would be stats->tx_errors in this ca=
se ...
> > >
> >
> > I don't fully agree. tx_errors is for CAN frames that got transmitted b=
ut then
> > lead to an error (e.g.: no ACK), while here we might be dealing with fr=
ames
> > that didn't even manage to reach the transmission queue [1].
> >
> Let's use tx_dropped then, I honestly do not have an strong opinion
> about it. We can change that later if we are not happy.
>
> Matias

Just sent v6 in https://lore.kernel.org/all/aQJRnX7OpFRY%2F1+H@fedora/

Matias

