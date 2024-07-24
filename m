Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6B199A2
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787280; cv=none; b=X7uFXih7fSGi78QgF1IohdjKJKx+3V5pv/ZKOuUIsER8rEd063diyDJxOohWgKNN/cXbvl3BwtCcK2vZ83/eVuYO3AoEC1k4GfbtOLJFEPgHUZcecaDX55K0RR22BHj43BTsqBQGzxsly85BdQTd/oZqZnuEWlhSl+UwbngjXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787280; c=relaxed/simple;
	bh=pvLH4gHm4FBYDuFbbBP4fMwtKLA49f5CaaWi0YuUzAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThoFUEOFtvSjLcdkUBKL1HrRvF30hI8WYlAHeexvOlZeGNNxFQThrLMZENe19lNN8YDMrMB0Gr4OuK9WwWJd+fFZ6n4Dbaj+xoBG6Pe+Dj/xfuXQJNN6LU885f273NxZTQ2fUkmu+1NkG/KytrHkBiXJ+l2P2sxFZI4AbdG+W08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXje8Rjd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXje8Rjd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 994004045C
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgOArJdrQ88w for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Jul 2024 02:14:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3F2C84023F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F2C84023F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iXje8Rjd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F2C84023F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehtuLszjv4cOJgMAfliSF/UD4RjIXwvAD86bpdUkiuk=;
	b=iXje8RjdT23IhEbE+q5Xigy5Jvx9oYDvszmbnTwG62P0LaqxYIUOi7HoUc9FcnE+62VPSI
	VyzSUjms0pfUhGLyBnaLhZaUmyctfffq8cIIQx/ImMqhycQQOhteGSNPkz3NW0gChE1EJZ
	R5No93hYJQBiDC0Z/d+Utg0mvNObL8Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-iJ1VXqB2MRa-v1TNMjO70g-1; Tue, 23 Jul 2024 22:12:53 -0400
X-MC-Unique: iJ1VXqB2MRa-v1TNMjO70g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef286cf0e8so32341091fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 19:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787171; x=1722391971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehtuLszjv4cOJgMAfliSF/UD4RjIXwvAD86bpdUkiuk=;
        b=hoDtu8Ru2KIszIPNVh8SOQtfIYUYbxEAxBxa8a9ShNv3VZukiU7sRpYU15dSQ2fGq8
         StjKeZplirZ//wn99DWVWgH740MWlYHnuxuUKa0TybF7lgDCHEBLhyLo7timiDgzSOPj
         fAYp97ILgv/loF9bLG4xcBZ1Ap3u2eAPCNr/DXFYZVR+Q8RwIaQ7BzIAN2e+PtglrtZg
         lQHIeEkWRf2M2rD4mMYUy7qsm0AeiNqVi3HsjPuQMDYCqunFxOwXpRL8kQFdBp+6QwX1
         2beGyefd022xoBQFb7/GUmwHAcmdTCI0TEcv0AkH024YeWfWHsiFRnbRzwLRAafNW3FR
         2ICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPugL7dHyg+4/JghdnVuZjke8+o4GbP5fJtWMUz+b7/pw/8KaTHE1i9n8vdxUTwA0sgfJ3U4rluXww6ZDeSS9xwUX3/S3FAZU/IZml/FK0LsS/x4zQa0phvA==
X-Gm-Message-State: AOJu0Ywos7UCoc5AYcgwZ8InOcP/eBNJ1osdYuKfKCXOhS9mDSmRtdq1
	ew+irXi5yyoISyeoYOHi9qgTA5ouFPm1DX3f5HQ8JxL5VTusB4W6i2zXbtUzwKEyqaHp4yanndP
	b7X50wsTpDy5N55q+TRUc+5lT++yYXSJ2qMbztgCw/9LDuyTy/D4LqJr85H7nSPgDDji6NLL0y/
	xR4zZxRVMvvWSELOyPaLyCPT0UAXzXz1m4F0uhhCqGVw8av44kRKBnVw==
X-Received: by 2002:a2e:2e09:0:b0:2ef:2b45:b71d with SMTP id 38308e7fff4ca-2f02b741b1cmr9587791fa.24.1721787171645;
        Tue, 23 Jul 2024 19:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2haBDetr3B12GRUddIecLnBaa3DkGcUp0iNR3ZPqOWC2HtbRoOF28NQwySlFGXAweIO8RddD9ZSszJMao+28=
X-Received: by 2002:a2e:2e09:0:b0:2ef:2b45:b71d with SMTP id
 38308e7fff4ca-2f02b741b1cmr9587621fa.24.1721787171177; Tue, 23 Jul 2024
 19:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-2-lulu@redhat.com>
 <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
In-Reply-To: <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:14 +0800
Message-ID: <CACLfguUf-HtNqL9ykGGY_XCQadUS7fJR+kn3q7S+cH7aUGmqYg@mail.gmail.com>
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 02:48, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 23, 2024 at 01:39:20PM +0800, Cindy Lu wrote:
> > Add new UAPI to support the mac address from vdpa tool
> > Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> > new MAC address from the vdpa tool and then set it to the device.
> >
> > The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >
> > Here is example:
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "82:4d:e9:5d:d7:e6",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> >
> > root@L1# vdpa -jp dev config show vdpa0
> > {
> >     "config": {
> >         "vdpa0": {
> >             "mac": "00:11:22:33:44:55",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500
> >         }
> >     }
> > }
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |  9 +++++
> >  include/uapi/linux/vdpa.h |  1 +
> >  3 files changed, 94 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 8d391947eb8d..07d61ee62839 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
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
> > +
> > +     if (!vdev->mdev)
> > +             return -EINVAL;
> > +
> > +     down_write(&vdev->cf_lock);
> > +     if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
> > +         nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +             macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err = mdev->ops->dev_set_attr(mdev, vdev,
> > +                                                           &set_config);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                    "device not supported");
> > +                     }
> > +             } else {
> > +                     NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                            "Invalid MAC address");
> > +             }
> > +     }
> > +     up_write(&vdev->cf_lock);
> > +     return err;
> > +}
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
> > +{
> > +     const char *name;
> > +     int err = 0;
> > +     struct device *dev;
> > +     struct vdpa_device *vdev;
> > +     u64 classes;
> > +
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
> > +             NL_SET_ERR_MSG_MOD(
> > +                     info->extack,
> > +                     "Fail to find the specified management device");
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
> > +
> >  static int vdpa_dev_config_dump(struct device *dev, void *data)
> >  {
> >       struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> > @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
> >               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> >               .flags = GENL_ADMIN_PERM,
> >       },
> > +     {
> > +             .cmd = VDPA_CMD_DEV_ATTR_SET,
> > +             .doit = vdpa_nl_cmd_dev_attr_set_doit,
> > +             .flags = GENL_ADMIN_PERM,
> > +     },
> >  };
> >
> >  static struct genl_family vdpa_nl_family __ro_after_init = {
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 7977ca03ac7a..3511156c10db 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
> >   *        @dev: vdpa device to remove
> >   *        Driver need to remove the specified device by calling
> >   *        _vdpa_unregister_device().
> > +  * @dev_set_attr: change a vdpa device's attr after it was create
> > + *        @mdev: parent device to use for device
>
> The indentation looks a bit odd here.
>
>     Andrew
>
sure, Will fix this
thanks
cindy
> ---
> pw-bot: cr
>

