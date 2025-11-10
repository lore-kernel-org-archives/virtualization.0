Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6962E6CBB
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760409; cv=none; b=IcDHpDr4m/wae6PLiDXKyoJTg1SGWFfSlaGP6oFh5lNGch3tqdpAwkj/hGg06RZtOoy/E0MHpM2eS8L3p4h9RdTEZeGm4upnZ+/sxiWnu3CJywQ92Y0i5ZJXmAlGQSWUtgdoLNmuDj4FSkoMp+IPdozLPltQpfX3lm3eCBPl4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760409; c=relaxed/simple;
	bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB0DW7Exib4h83R2oqb9Lz5pd9BT+Ax0AECQ1PJFBKH9f6MGDVCj5ytOvdN76BPQQyLJetyjI0xDDOj/NAf9cfFAErrxRat8gs9PKGSktlnMbdtN87mRz5GKlneeIzmoPC0ew1AyS65fJNgV/X0Up6VDluAlio5BapW84fJ+z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L69a+lIe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L69a+lIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762760406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
	b=L69a+lIe1cvtuNtiT+FHL5UBnKGrad9fIIfTK4xjY8rfmxGQJUz3N6q5IdaNuTvxUTsR87
	ci0D+3HNfnxvoGfFJm1RyR5GWWNLIq8Zlac1oBhOMsWafLXKTtQ9GE46cam3GRo/Wl6KKq
	IIxNs+Ql3dX5bwTxHq6LC/vtM7JVqHg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-l727PMNUNRWKJlp_ajI4yg-1; Mon, 10 Nov 2025 02:40:03 -0500
X-MC-Unique: l727PMNUNRWKJlp_ajI4yg-1
X-Mimecast-MFC-AGG-ID: l727PMNUNRWKJlp_ajI4yg_1762760402
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso3162604a91.3
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 23:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762760402; x=1763365202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXUsL3pd42Tuep6RruSB+1iDVpue0OZhhCe98VFS0mU=;
        b=Cwbx8V8Ab34UrvNjUQE3oB7dt73WTau5Ys6gZMwqx/Yp+YsGTlm0fgHcCyHAMufXL3
         b+Yi8odtjuforDH6VGWz+XhHc3bTkY0jcG1IvIU1utSKK3BqmFBLRddk9slekUtHjeJH
         /inKqg11H3Q5e+Wg2wkjgPh64o5x7nQcpILyA8IqSlKIIBNF/shnBPiIQKg/iCzBhP8+
         kO4QsG0l5aatNwvv2W0jgBR9Ij/tLsu9cWQrcRTXlu3q3wEe3cyGTU06yfvOELwAspIc
         eJIrbDzzftsOgm1lHjfvA5LP0s/arBQMEVr5g5GU5QHLPi/RXMesVpnqZTFsA01C66IE
         zs/w==
X-Forwarded-Encrypted: i=1; AJvYcCVqZSiL9F2PXa8n0fFdEaTTxm1Bk498NV69yPIyZMi7/Ul9j7goQ3EcKRVSZsAlhxG0jYpKHW/gJI/xjWhR8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU2lyZe0fBSy7ApaCV4szReNWb0yEyQ4Os9KPJD0NkIAxNoEWd
	y3jabmPxIcMtspkbLw5nfMLC8HvuI0+L1mJgMFbk6myoLxPE5o/aHvXEaPHlcnJvAdjw0Zqx8UZ
	ZkWXVMtFNYRmc9zhMaC6vPPi1ENsFVFzArvRee+w/+ULmp+sBJsy0MyS9QHn9b44RfgS5P/1IN6
	1th1CRLP1dvf0bQJbupEXDxvg+vLtJimy13Faw8L7J+Bo=
X-Gm-Gg: ASbGnctrkjhVoMWjwq1uUDUd2Ep7G2eYxmoNJ4a8UUf0ZrB4CEIfpoQpmbZAAGibEPY
	eOZHGyGuH0BZkamd3q35g8tc6MPpvIq8Pxwl131jcsgMEcLmFDw8bw9iUPPEifYGWIonOq5orXr
	mLmUWmLy8b8Of48l073I2EYzolYp5kGyVOxv8mB6SKlqKXsTIQ3+hz
X-Received: by 2002:a17:90b:3b84:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-3436cd0f021mr8151403a91.33.1762760402367;
        Sun, 09 Nov 2025 23:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpZv4/GqlxGQNFyCLng8oTk+dP+M0w4ibTMZFdafThizDamPVmq0k7Ru5Fk/gcw2HySNAQRTdsddDt/AZwDuM=
X-Received: by 2002:a17:90b:3b84:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-3436cd0f021mr8151372a91.33.1762760401914; Sun, 09 Nov 2025
 23:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com> <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org> <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
 <20251110022550-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251110022550-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Nov 2025 15:39:50 +0800
X-Gm-Features: AWmQ_blnEJl7cPeCvJMqReQfNUsbW7dyqVeRIgseANe1h5mGpbCdQEhT5aHtNXY
Message-ID: <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A63IMDDXQrZ4IwsxlJ-lxBQmHZyToYp1OKIglQ-3VSY_1762760402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> > On Mon, Nov 10, 2025 at 5:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > > On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header=
 length
> > > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDR=
LEN
> > > > > feature in virtio-net.
> > > > >
> > > > > This feature requires virtio-net to set hdr_len to the actual hea=
der
> > > > > length of the packet when transmitting, the number of
> > > > > bytes from the start of the packet to the beginning of the
> > > > > transport-layer payload.
> > > > >
> > > > > However, in practice, hdr_len was being set using skb_headlen(skb=
),
> > > > > which is clearly incorrect. This commit fixes that issue.
> > > >
> > > > I still think it would be more safe to check the feature
> > >
> > > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> > >
> >
> > Yes.
> >
> > Thanks
>
> Seems more conservative for sure, though an extra mode to maintain isn't
> great. Hmm?

Considering it's not a lot of code, it might be worth it to reduce the risk=
.

But I'm fine if you think we can go with this patch.

Thanks

>
> --
> MST
>

