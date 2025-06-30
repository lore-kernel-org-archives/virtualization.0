Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB201A073F
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751254639; cv=none; b=vEYDpwv4oWD+e5FaSgAxf2w5psU1LUmLjEKKxjYhHZv7wTgy9IdG7BIPjC/1tINGUIQXJPImZZJ01rqkGSA+lRCy2Rfc+cHMBnsIBkEws2uXXqhkgTk9Iifjp/CKFOXylshR5z/fqdKfX9/Dk7whpYJcS9byGsbSmriMTuKnsn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751254639; c=relaxed/simple;
	bh=nHAXEaVkqOjEIQ+g+zG5hflRIdiMhOy/cbZJ03K4CfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mngb77joDdad8K7VINVTfciDcGh8lHSVH1ZQ0Q5agDVQEcueywkWvUQBK/AurOLmV9eEPsaOeqckDHXdwIle0sdDc6H80+Ipx4muuQ9dpg7DUE2EyCZCcmsh73YHv++hF06RYcjxqPxaF3nC0wjXh6kytUGv5esJw3w+r9GMWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYGg0tQK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYGg0tQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751254634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkwpDUZl+sZWek7ZXNsWkAYIEZO6e0RDLuiHFNjssRY=;
	b=RYGg0tQKTjIvfobg5dm0HXExJlDjuj+fKEfubu5GPgEfSt/KFmUKCYCffOBEetM9htAPtb
	1xaQSUTCbzdZLVLJ/im3smtEV49pqQPIUEphwGDa4rlQE12WbCkPbpKZNQgCdG/JmZz9Ia
	eA5cMA4SvOwGArjR13HK/Me/+CEdXms=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-pZJElnq_NTakvvazVTRy9Q-1; Sun, 29 Jun 2025 23:37:12 -0400
X-MC-Unique: pZJElnq_NTakvvazVTRy9Q-1
X-Mimecast-MFC-AGG-ID: pZJElnq_NTakvvazVTRy9Q_1751254630
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31cc625817so4179764a12.0
        for <virtualization@lists.linux.dev>; Sun, 29 Jun 2025 20:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751254630; x=1751859430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkwpDUZl+sZWek7ZXNsWkAYIEZO6e0RDLuiHFNjssRY=;
        b=tmQS7AHcv5ErEFXn7v4AlhD0OkDgl9hvCd8p3KE2+gcLEnAALJfcqKAaL0cpkyKrP4
         aszK50q7czJpIgSlkEFA1djGtK3zGDQyKDFW1YE1UNZ2dAtcJopScsOdnpfTZrIwDYrL
         lEWNdZ279gwsaup0UQHPw0X1knhQmsIkQhL0svbGognDNNaMM28eztnI+99JXPSE0UwZ
         qrL8vUdfiQzS3pP5224etYDBzD0eQ4ZYeLfsHDRbXh/gQZfbGNPHrAe/LA4ZuK4a+919
         UOtPqSl4ZHlmC3qziy25ihijLGskK0z2hOjmqBV/cWsn/ErXPCyNv0ZCACKysTc6NeCY
         6E1A==
X-Forwarded-Encrypted: i=1; AJvYcCXpb9JOEIlayDpLEDS/XKI+HYCg4N4ivNcsui4Mf+G6QpRkgLMCtWHoF1FcokdwXnMh7mEOtxuf6o61+ul99A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO+dEGCHPfMRMgbHfDHXQfObV9tSNM4JbC6fFpOSPzf0I1i7Cp
	EL9MnfX8D6RO51ya8hRwfCjJvPnxSmg4iPLq1+QYdQBdhc/OQq5emfHxCEyK9LaHgeu7UK3MToJ
	mnG4XJaeHhO6zPUOfeQ6mJZ/107wXlxFEHgrFVNbulqGASdvr6i1ac5DL4enkTDJ/wk1kiWGh6R
	cvLW0VEMSIEh6X/BLrt9Tpi3z82q/7TnZ01GYn+lF63m4=
X-Gm-Gg: ASbGncv8yKoyskoE4Sq379z5ttXIjyu1IYTgLLl0eT5l+CeaE3QezMKmz5MLsRLir30
	YoD3dxaRfwf6cPUxSr5mMoV2ZicbUAU+geY1Jzxn0lx9kRxB8ICtVhTBqx4WoqOXG7izj/44w5F
	gM53s9
X-Received: by 2002:a17:90b:380f:b0:313:f995:91cc with SMTP id 98e67ed59e1d1-316d69a9ebamr23854603a91.2.1751254630219;
        Sun, 29 Jun 2025 20:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC/PxeY2zPgmoqHLa5NYsPNWTtefEChjOO7AtX/7ybsjX+NZLbIw2wSOZC+yvf746Z7vQ9ZeDBKqdlVvccnBo=
X-Received: by 2002:a17:90b:380f:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-316d69a9ebamr23854562a91.2.1751254629758; Sun, 29 Jun 2025
 20:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250626021445.49068-1-jasowang@redhat.com> <20250626021445.49068-2-jasowang@redhat.com>
 <20250627174825.667e1e5f@kernel.org>
In-Reply-To: <20250627174825.667e1e5f@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Jun 2025 11:36:56 +0800
X-Gm-Features: Ac12FXwSsmp5J2RbQVOjDCPt8sIK9w2DQyUQ567Xil-xT9G4D8CIR57TUiVmXz8
Message-ID: <CACGkMEu6r66Jg3--eOCyMdd1WqKeP9Jvfv+DFmWk07oTJUKZyQ@mail.gmail.com>
Subject: Re: [PATCH V2 net-next 2/2] vhost-net: reduce one userspace copy when
 building XDP buff
To: Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, mst@redhat.com, 
	eperezma@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Willem de Bruijn <willemb@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H79UrhUE5sUgnvx6CBtHmAtmsv_YVjSaRHZqsXGkewQ_1751254630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 8:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Jun 2025 10:14:45 +0800 Jason Wang wrote:
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -690,13 +690,13 @@ static int vhost_net_build_xdp(struct vhost_net_v=
irtqueue *nvq,
> >       if (unlikely(!buf))
> >               return -ENOMEM;
> >
> > -     copied =3D copy_from_iter(buf, sock_hlen, from);
> > -     if (copied !=3D sock_hlen) {
> > +     copied =3D copy_from_iter(buf + pad - sock_hlen, len, from);
> > +     if (copied !=3D len) {
> >               ret =3D -EFAULT;
> >               goto err;
> >       }
> >
> > -     gso =3D buf;
> > +     gso =3D buf + pad - sock_hlen;
> >
> >       if (!sock_hlen)
> >               memset(buf, 0, pad);
> > @@ -715,12 +715,8 @@ static int vhost_net_build_xdp(struct vhost_net_vi=
rtqueue *nvq,
> >               }
> >       }
> >
> > -     len -=3D sock_hlen;
>
> we used to adjust @len here, now we don't..
>
> > -     copied =3D copy_from_iter(buf + pad, len, from);
> > -     if (copied !=3D len) {
> > -             ret =3D -EFAULT;
> > -             goto err;
> > -     }
> > +     /* pad contains sock_hlen */
> > +     memcpy(buf, buf + pad - sock_hlen, sock_hlen);
> >
> >       xdp_init_buff(xdp, buflen, NULL);
> >       xdp_prepare_buff(xdp, buf, pad, len, true);
>
> .. yet we still use len as the packet size here.

Exactly, it should be len - sock_hlen here.

Thanks

> --
> pw-bot: cr
>

