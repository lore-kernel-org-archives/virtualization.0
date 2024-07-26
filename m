Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4617BB11
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999825; cv=none; b=GyCbsKVzsgPqo4YzeDD5qgmT7pR5s9ItrwLMUVjODY/J8atZEPz6OM2h/c1sXDw50e1XOKG2NSoEzeTZiAcg5jG1CRhiZyrotzZ/L5R+3R0GX3f9fIl1sI7+Xb4Js/utRWxlIO/oZN08ucGoGWCiBseVCWUsPowXq/wXwGWT/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999825; c=relaxed/simple;
	bh=E8TJ6MRlezfed8oV6XYbKMbJ33WOOqUbYyIaqIuvt2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Bj290W57SxVQrZ6+QwplZsvGRuEt1d7UtTY8qhoAOPdVp5N+E+2q/VhMLSw6NONO4qsKfoqx0QwZkzTGBRs12EW9aIqjbDMZrByRVhCEak13pUpQEjLIcfLm0W9tNrfCZ+zknElcxB8PTioigwVTtoV4YIxG4JDMz4fJkw/ZicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYdNR8F3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYdNR8F3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D40060AD5
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1q2QwLS5MxKA for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Jul 2024 13:17:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6DF026061E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DF026061E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYdNR8F3
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DF026061E
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vllFnlg84B30xrdVTJ9/E1KQIK8lYuMk6An3oA0P1n0=;
	b=DYdNR8F3b568Txj9Nymkbc89Jt3CNT6oTAz0zBBpAxRkadv4nS2pLYEhMrNS+/xNls/dGe
	L0vblZEbElju0tUT33MKaUxAM+tB5f4AHClGsissy/XU1DTo+4CPi6Mky5c65I5shyh0Ti
	WQ4ekX3GYbTswu0OSq8VbG4q9OfFCVo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-WVWCW0EKNX-9-hVmo_dl0w-1; Fri, 26 Jul 2024 09:17:00 -0400
X-MC-Unique: WVWCW0EKNX-9-hVmo_dl0w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a7a999275f8so80731266b.1
        for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999819; x=1722604619;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vllFnlg84B30xrdVTJ9/E1KQIK8lYuMk6An3oA0P1n0=;
        b=sSEquzojcaq7Kr7HeSSPRdrwsLmoVbL+aJHQ1EWdUerCdtgp2CqM2/mv+A/slT9kU4
         4Rs8BXcgtTL7z5lJBBex27o6p+ImQDd0Xc1JvPoKRCvJsyT/nrRR2R6I5pHoAqtHXXa2
         DHChOQEPpFcDUX6Km9IVDoFNF6/8K59uKOqJARCHsv9PZ/arUBcJXUttgzaXZUH3p1Rh
         tOaBbWxotxgnIFysMRNAjat31FeNgufCjUrelkQjzLyAepFHFVR6zXeDwLtBhP+QsX63
         R6vE+KNEh4nh4kY++oBqZH2wNhlDMKUL8DhCnnh9F/UAzQgnHpdIvD4U/uHbsvilvcD9
         y4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUg7PmFG0ZNqdB88qZZiXnmsbhC08v+FMvHvYTvJp/IOoT3/3onTqCpmybhziJkrmpCcei7DFrKNk2EhOB20gvMOBLxZtPQnnbHcDK4I9d2Dg9adYlofYO3g==
X-Gm-Message-State: AOJu0YzxNQuVwuJu0oj14VrYRFDb87a1Hdu7gEfR96TKBMPgb6bBSBgf
	72n6gKCTB6lOq8N0o7YRUeU1bmn2DRFPlEciNO2hdgbzkwcJt44rjPUCweLH9F+xq1GIAQf174G
	O1DlR+DSLZD0O/+n+sq5vBhBn0TdC1GWZjg0MhOYXO8xoj001Ylbbxo275geqlpuXLGRRGvkUhF
	9nXasya9xECOgTmc1D5iy4daMaTdd+dgGxjfj4G83FNURdctTrkVh3Qg==
X-Received: by 2002:a50:ab18:0:b0:5a2:6142:24c1 with SMTP id 4fb4d7f45d1cf-5ac6203a20amr5122262a12.5.1721999818731;
        Fri, 26 Jul 2024 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNMLKfBY9RgUZNbuxfkLr4bAwXidi3+wYsQGX8RjCIa2lMVc2O1E44vHMrqEn2jQlboMjIf0XHetK/IL3iMXI=
X-Received: by 2002:a50:ab18:0:b0:5a2:6142:24c1 with SMTP id
 4fb4d7f45d1cf-5ac6203a20amr5122229a12.5.1721999818239; Fri, 26 Jul 2024
 06:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <20240725013217.1124704-2-lulu@redhat.com>
 <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
In-Reply-To: <ZqKLd9ZIJ4l5tAL8@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:16:20 +0800
Message-ID: <CACLfguUBQ7p8M+aUT5EjKmaBP2tNF6B3_AEhPTqC-66MD0CYcg@mail.gmail.com>
Subject: Re: [PATH v6 1/3] vdpa: support set mac address from vdpa tool
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:29, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:02AM +0800, Cindy Lu wrote:
> [...]
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 8d391947eb8d..532cf3b52b26 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1361,6 +1361,81 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
> >       return err;
> >  }
> >
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                     struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config = {};
> > +     const u8 *macaddr;
> > +     struct vdpa_mgmt_dev *mdev = vdev->mdev;
> > +     struct nlattr **nl_attrs = info->attrs;
> > +     int err = -EINVAL;
>
> Nit: IIRC networking code prefers reverse-xmas tree style and
> macaddr above needs to be moved.
>
will fix  this
thanks
Cindy

Cindy
> > +     down_write(&vdev->cf_lock);
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +             macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     ether_addr_copy(set_config.net.mac, macaddr);
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err = mdev->ops->dev_set_attr(mdev, vdev,
> > +                                                           &set_config);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(
> > +                                     info->extack,
> > +                                     "device does not support changing the MAC address");
> > +                     }
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                            "Invalid MAC address");
> > +             }
> > +     }
> > +     up_write(&vdev->cf_lock);
> > +     return err;
> > +}
>
> Nit: other code in this file has line breaks separating functions.
> Probably good to add one here?
>
>
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
>
> Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
> because it seems like the alignment might be off?
>
> > +{
> > +     const char *name;
> > +     int err = 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +     u64 classes;
>
> Nit: Same as above; I believe networking code is supposed to follow
> reverse xmas tree order so these variables should be rearranged.
>
> > +     if (!info->attrs[VDPA_ATTR_DEV_NAME])
> > +             return -EINVAL;
> > +
> > +     name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > +
> > +     down_write(&vdpa_dev_lock);
> > +     dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> > +     if (!dev) {
> > +             NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> > +             err = -ENODEV;
> > +             goto dev_err;
> > +     }
> > +     vdev = container_of(dev, struct vdpa_device, dev);
> > +     if (!vdev->mdev) {
> > +             NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> > +             err = -EINVAL;
> > +             goto mdev_err;
> > +     }
> > +     classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> > +     if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> > +             err = vdpa_dev_net_device_attr_set(vdev, info);
> > +     } else {
> > +             NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
> > +                                    name);
> > +     }
> > +
> > +mdev_err:
> > +     put_device(dev);
> > +dev_err:
> > +     up_write(&vdpa_dev_lock);
> > +     return err;
> > +}
>
> [...]
>

