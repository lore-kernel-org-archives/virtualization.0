Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19517B420
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000020; cv=none; b=HhvcKvCdMghJB/qjUPiQn+BaJ64BEh02lFVjBoHslkInjCh2lRuC3072eAcBuum+/ju9pvKK3BL+ySWNOhUDAqf2yX+ZgEhTnOld466wChJoN+yQOhEjUQ5vAkhONzVGik4lskfP4IGLaiOC28jyd2xoKAYo1976sya+UpJhp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000020; c=relaxed/simple;
	bh=okBVGW+4Ldc/gYbopPMTEK9G1vsz0TiBtRfOBBB3ybs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OZwd0fe7H3mkI7435XjjRjQ2HsoOgAjLtzmtR/scVvZLn6NYIJD5RMSmUBdF33NIxpDX9/vjipJAmK+PNxII2Ds6S2kquP9w3pkvYyErGvGyxhUet1hT+W8/hgIXSU54ERtmlAr+gFmyr0SZMlrshuHX7+TYw3iDq1cOrgH3vYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj+YOvKs; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj+YOvKs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B06A405AD
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9FTptu19NHs8 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Jul 2024 13:20:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 121EB404A0
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 121EB404A0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cj+YOvKs
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 121EB404A0
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhcUQuVGN/p5AORVU51L+UH99nfvjtvJ6aAvMYY+bH4=;
	b=Cj+YOvKsEswWgXgZvxPyBlja/kemqiCvWyn3m1GMsnOR0PGfUFmZMw0etier9or2WJcvQo
	KhT5MVJKr6uVnsdJTcflavApsNmictHXXVhSHP00ov5fHQ5lb9W2ZrKM/aHgIRYQljQViQ
	wau9Pymd0g1qAeHUUHZ5nb4ZNP2VElI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-0_sLhbuzPHyCXIAVddq-iA-1; Fri, 26 Jul 2024 09:20:15 -0400
X-MC-Unique: 0_sLhbuzPHyCXIAVddq-iA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a25d0755f3so1864809a12.2
        for <virtualization@lists.linux-foundation.org>; Fri, 26 Jul 2024 06:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000013; x=1722604813;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhcUQuVGN/p5AORVU51L+UH99nfvjtvJ6aAvMYY+bH4=;
        b=FVsGGq5ZwIRtHctJJaytVyl66zrThpOAuc2Llwo+e9cNQF3vfZMUGAbIrkoZhmJ7iW
         Cs3hbKpqakJgs6cZrrecnBxYoq8PvC0JHG9qPLtZhlYE0a84QLBHiRf/DnDNZGfcxAER
         M4/rHg8Pr3qRzOIdiJAFKJ4O9ImCmRO8SPEux0xoyd/m1TRsrtSBJczKkUcRYKseqkyM
         BMa4Kx8/F0oFk6us91MnuQdi8ev/X5zMwhXejVyzn5V1NffJSzg9AaGricmBXZd6/7p5
         1LP/SzWMZ9JLd0B9Lbn7E4R1gtrdJx0VGFPBWoGdiBwZ/htis1gZmw7q6gycNX+xR6u8
         Qzkw==
X-Forwarded-Encrypted: i=1; AJvYcCW4q3ezRtDS07nQ2J+luMLbyHAeR4PMGKPKrM2j6cQ3wPzuaEIM1ROOLh8VsMuyimbvHax2cUbTj7u145s/38+fwt5C1e6Cx6K2n2YNFH1NTB1Lfsc6d/Maow==
X-Gm-Message-State: AOJu0YxSaFZsTNEMWToGnHCm2/yKGz7LyIGNxfQEwwtxz88Rkg3xksHp
	icYk45eUnVy6nvCNHDl8aIU2bq+r8+sqci01gLKAkQDgaNZbYbHbc3YxvIK8lfx2WuNQipYq40O
	2tssIkqbhJopty6/QfG0NzJHcoXhavUfsjCVOwZQZHUx/xUJWHcy5cciXPVshYfZOpNduepfL9J
	LTrhFteT3EljF9+i1iT5cEe3WaaEZ2zmNe17aGtEWREyJu7zruB4kEng==
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id 4fb4d7f45d1cf-5ac27750881mr3153320a12.0.1722000013059;
        Fri, 26 Jul 2024 06:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtB78u5qVHemteUb/n5/CBlV2qDcx0mVsZ+2chC9WujC4lrXXqlD2osHIxxTvD60+aLUAhJOP6uvrm/JcF0xc=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5ac27750881mr3153306a12.0.1722000012559; Fri, 26 Jul 2024
 06:20:12 -0700 (PDT)
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
Date: Fri, 26 Jul 2024 21:19:34 +0800
Message-ID: <CACLfguU1pBgRLQwUXXX70ROhy41KvFuHd_08_t-YXS75hsafzg@mail.gmail.com>
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
cindy
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
sure will change this
thanks
Cindy
>
> > +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> > +                                      struct genl_info *info)
>
> Nit: Does the above pass ./scripts/checkpatch.pl --strict ? I am asking
> because it seems like the alignment might be off?
>
I tried this, but there doesn't seem to have warning. I'll double-check this.
Thanks
cindy
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
will fix  this

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

