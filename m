Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC2C8D1
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302916; cv=none; b=cStJSXPEwqg5V9GQMHBKAChVOPehxxmtKkcftl4y8sH/Pz+gc9hUsmC8+yIFobP2l53Byv/5tjqTDyEWIp2+xU0NqZ8a2ROPTOBIQYXEYHYWsC9s0I9y0vNbrPBQacEZ3yOLUJalmxEBFBAf0buRUodYQ8r2aQ57MxTqiUTjGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302916; c=relaxed/simple;
	bh=bHLggzBkR32ABTBuDeD5m8BceYVfT11ujqxOCYp94L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7gm39Dtk2jmQzGPx1INy0Raz9PbuBH60iTnzU54AE0OGRy559+DjUVe+pfYXCZ80IgI93mN0aoiwI7fmQJ/xrntaYYn7EjKalatHP0PEdYJgri+knkKeRn51TfoVsVC45NH5sisCn4zDvI8dMQEFuRh90PSZ34hL6fKV0TAP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmwseddq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmwseddq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30662405FA
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJ8btHSIkvwq for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 01:28:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3D7F7405D7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D7F7405D7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fmwseddq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3D7F7405D7
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xktMOVoHugI0lTfnvlwNQ+Q7ARYmOA7NCAixOdxBTU=;
	b=fmwseddqxtKSkH6UFIlGlq3AWkMSotFnu/wVfZIFX75yxpSu4ieQBfBkZw6E+CDQAbKZAW
	d9FM0ZSUtaouS63hlbwtH2br0hJapk74SelNhT/Byc8ukNRk3VQ/lrtpi/zYyvz4OieiNP
	0GJRoZqDLPedVNotaFyXeI0zxqYD1SU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-4iEyAmkcOZy9u6pTut1J0Q-1; Mon, 29 Jul 2024 21:28:28 -0400
X-MC-Unique: 4iEyAmkcOZy9u6pTut1J0Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a745917ef7so1838681a12.2
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 18:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302907; x=1722907707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xktMOVoHugI0lTfnvlwNQ+Q7ARYmOA7NCAixOdxBTU=;
        b=rPlDVZwECRi5c+9lUPfXk6woArT+zirVpgtVkMks23zWXR4m9EW0R6ORBARCKCGFYp
         /+9IKTfLREBZg5kPBJmM+EFBu/JjKHlHGLW5YxIfdjcdlk2EZqYV/oiPThfmB8URm9Wc
         GxnEZjNbF9+0i6YYvaE9/uxBPFv9SrOPxS8ommsY5PHP0np8e6OHpcX2zsds9O25MjmU
         +x8PRwg5fu9Ln3PunPbyZR/k8DR9oM5xF1gIvtHswcJ3RwrstRy7ebLZJAmvKIYW6PyV
         8rdYdgOznA/8X6r4NAWF0kJcHakh5iE/DD+blQKmC+51FjkykakitugGTxVcue88SokC
         ITZw==
X-Forwarded-Encrypted: i=1; AJvYcCWCPrgD82JHJD4oUbfOqoFVuMxoiC4+uYjQCa1FGnm/iqzM9wwDMp8z06O6UUF1NfFiap/ZzvrzoopMvInF5WXuZ6rm/4vZTPuY8yrbLnamKqVP2E2/vBxv3g==
X-Gm-Message-State: AOJu0YzBp+O6dl//wxDzcyxubxLGNSri0A/iqjSgETal/jGmQnQv3lOo
	axEyVYvIM7SD7LZWkSA9VlN3Tzm7t7oCkJp5OLO9HLdHun26BQYC2HAi+EpyHaf0uvho5PAwcP/
	Vnw77+KMYB/uwZ7WUp3X0+pPlHGDqvTAF8hwtg5HXmLSS8ef7GY2L7pAiqwDmyt4exVQ/62wjaM
	YVkF9ALY+ITcWSvpluFYZuYHiNJEFPxhHfvWbKJwv/dyrosZxLVwJFUA==
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id 4fb4d7f45d1cf-5b021d22ba2mr8115647a12.18.1722302907437;
        Mon, 29 Jul 2024 18:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdPTNCvh6T69SK0IJXobLvCIllL/ErzFAg0dOuyEmshyYj0yciGy5k79zWO9SA5PSF4d+cis7D29a6K9GM9s8=
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id
 4fb4d7f45d1cf-5b021d22ba2mr8115635a12.18.1722302906995; Mon, 29 Jul 2024
 18:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-2-lulu@redhat.com>
 <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
In-Reply-To: <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:27:50 +0800
Message-ID: <CACLfguVHKw-ppXeA8DDH0CtvYZ9m8rkk+Jr7ZF9pFfbLr1VRGQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 03:13, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                     struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config =3D {};
> > +     struct vdpa_mgmt_dev *mdev =3D vdev->mdev;
> > +     struct nlattr **nl_attrs =3D info->attrs;
> > +     const u8 *macaddr;
> > +     int err =3D -EINVAL;
> > +
> > +     down_write(&vdev->cf_lock);
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> > +             macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     ether_addr_copy(set_config.net.mac, macaddr);
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
>
> ether_addr_copy() and memcpy()?
>
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err =3D mdev->ops->dev_set_attr(mdev, vde=
v,
> > +                                                           &set_config=
);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                    "device does not s=
upport changing the MAC address");
>
> You would generally return EOPNOTSUPP in this case, not EINVAL.
>
> Also, the device does not support setting attributes. Given the
> generic name, i assume you plan to set other attributes in the future,
> at which point this error message will be wrong.
>
sure=EF=BC=8C will fix this
Thanks
cindy
>         Andrew
>

