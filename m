Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE1272E56
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791055; cv=none; b=a463FKFz+oi0f57aHc6GEnSTuZ6ekUsvg5Z/i01Eo9xoHE+jcJ4trayFQ7P/hrsNRWOFeT1ruiN4HGAdot5TpJ0HiH2gGcNLS0zIgdrRZ0ax2wBerSPCWzJxLWPRjsMk6W99v3DI6qcwuh0XeWZjLAxVQAzsrOACeXwQ4U+SSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791055; c=relaxed/simple;
	bh=yWwqc79ICtjxfNEwAhdveBII+kI6tv7V46J5xGUbxqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TF5hXY/cuQG0SfiAFDEL2tXf6nUW81xyEcmeOOA9lYDqzllRMGU574c8s8+zG92poBWVVqWi6VkOEW82Pa+UJTWbLr/3OdJdlF1NDkBJ6aMmN3qoMYnSCXwUptOJzmiQyt3zdT4iL4QRqb96QCkRrVsmAD0Tn3Mwg6Cv7Raq2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWgnCEPm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWgnCEPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762791051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcHc3rh06YWG1Go43rMQsJeOtpbumA9Fnt4ZDm9Fg9Q=;
	b=EWgnCEPmrLHoDP8+s8JWioZEogvHO8lMQujTWIwx128kpIMIHK/RDVU+3PdZ03gt5/s2Nd
	N4auRo8E2LCQyWiRkZVGcY/rsf+Ig6lxCQPy2UD/WE+5mjBmFH34oq3H0F2J7cFM42JDSC
	KAYBX43ettHPKOY35da3REicUgnKU8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-R6EkkL23M6yqbR6PDigDDw-1; Mon, 10 Nov 2025 11:10:49 -0500
X-MC-Unique: R6EkkL23M6yqbR6PDigDDw-1
X-Mimecast-MFC-AGG-ID: R6EkkL23M6yqbR6PDigDDw_1762791047
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so31083125e9.1
        for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 08:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791047; x=1763395847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcHc3rh06YWG1Go43rMQsJeOtpbumA9Fnt4ZDm9Fg9Q=;
        b=k5yUDku/VPGRljoTNreK1vaeGiRwjgfBzSH/8ju4787wtFG66MjG851uYCP2H0myI+
         ebXjLKihj/wQ1NtWTFnB71XgLZ3IKPq3gCurMEkwixtyWPp7VT82Ybhhweuz44LIra1H
         yQWudx+UwYYivj5EKN9+pl5PffKk8QkaYHGWHN6tp88CfF0ZkpmPgWKe65acasUC2VXg
         aWNlCBs1hCwhR63JlSmM9sZun9I6vaeTMQhaLJMWcAh2M76RWCAaUq2vyto7PXCaIsXF
         iJgQVrjr45Ls//188rzZbSorJWVAFQqlurcNPDQ8OqHpY071vzb9L9nNlAP78vUA64af
         HB7w==
X-Forwarded-Encrypted: i=1; AJvYcCVYmA/MegExVBv+EViIRCEMshNmZNhTgLomIc5y7PbpnfwgQrGsXT8QVxrFd389fPoBA13Pv5+3cNXnbIS6bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgQyJVP86cHlZCvtCiH3soPTq2rrvV6cgpWF2LITDRo8bvGIUU
	QLUkyg6i8cj2pSiHrwak3O4BPEni72RtKyMOwZYqxZGtgqnrVzuJbzMA4IYrC72Wx1xdjN1caV3
	/OiCLePgkbJLRBCjY4DVAEh3jfKDQUeMN3yfz1o+kaQNKeE0Q/zIAVTpRi0L4rBltcp6X
X-Gm-Gg: ASbGnctEOYqZ6cpZp6wprkMo1qp65nXyrjafD5wDO6+9pvFDTZrRYw72aKIys50QeXs
	6XDQBkZLjxnXvwczwK6PVHW7/4MNlYSVdqIUMTJSnXLq58dbROLdY4crbZwfjZBcuaHLXNnyKvm
	5DGEWzW2s6bZVbZ/IJ2Oc4IvPNpxpPtg2zqt/vVwwEGxT/Xb7i1jCQb7sTBwgItpp8rJs6PYYj0
	m4zS6nl59U4iIC33B4z6brRl9+jCI0BIlujjHfKowFLLbATpLDqr+vh1dYmasEa1+CyTA0ccMKW
	HQ/ElmvstRreBnhjqz+54fjmiiPPwIsjteQ4A+OXTIqvSNxDmwL+mghCK+1MwusJY5k=
X-Received: by 2002:a05:600c:46ce:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47773288bbfmr90576175e9.31.1762791047363;
        Mon, 10 Nov 2025 08:10:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlSd9E64YfjmEcCoLlPhCD+mhQhwPyWeJ7FNhdbF5w48th7xgvNaehDUYwbRr0JRyKdDFjYQ==
X-Received: by 2002:a05:600c:46ce:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-47773288bbfmr90575765e9.31.1762791046799;
        Mon, 10 Nov 2025 08:10:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bccd41bsm208552935e9.2.2025.11.10.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:10:46 -0800 (PST)
Date: Mon, 10 Nov 2025 11:10:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251110110751-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org>
 <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
 <20251110022550-mutt-send-email-mst@kernel.org>
 <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WA0zUrrO-RCgBTWPQ9awgvy6fZnuzvua4GbR4RWOLPE_1762791047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 10, 2025 at 03:39:50PM +0800, Jason Wang wrote:
> On Mon, Nov 10, 2025 at 3:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> > > On Mon, Nov 10, 2025 at 5:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > > > On Wed, Oct 29, 2025 at 11:09 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >
> > > > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > > > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > > > > feature in virtio-net.
> > > > > >
> > > > > > This feature requires virtio-net to set hdr_len to the actual header
> > > > > > length of the packet when transmitting, the number of
> > > > > > bytes from the start of the packet to the beginning of the
> > > > > > transport-layer payload.
> > > > > >
> > > > > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > > > > which is clearly incorrect. This commit fixes that issue.
> > > > >
> > > > > I still think it would be more safe to check the feature
> > > >
> > > > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> > > >
> > >
> > > Yes.
> > >
> > > Thanks
> >
> > Seems more conservative for sure, though an extra mode to maintain isn't
> > great. Hmm?
> 
> Considering it's not a lot of code, it might be worth it to reduce the risk.
> 
> But I'm fine if you think we can go with this patch.
> 
> Thanks

hard to say what does "not a lot of code" mean here.
but generally if VIRTIO_NET_F_GUEST_HDRLEN is not set
just doing a quick skb_headlen and not poking at
the transport things sounds like a win.

I'd like to at least see the patch along the lines you propose,
and we will judge if it's too much mess to support.


> >
> > --
> > MST
> >

