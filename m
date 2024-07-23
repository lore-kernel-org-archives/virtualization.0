Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0F13D529
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714494; cv=none; b=Y52I3PPbW63+aPepIAnWFJ9t7szU6zkirdmltfvI7YZpXBZOsBBbSyWpZPwpKypoKoTFJ2JTfYUB7po2OPrLCGFNSoYo+o0Sh4Mp4lp7P+VEC46PStwOvV8qnsw8dS0nXb9vjurAs7WRmiHEVtj+bk+HlR5fq4H29ZN+qxYtfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714494; c=relaxed/simple;
	bh=0QhUiB9QPy0L3gVOVOqvoBO7aidT3a89V+Jj6mDtr2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdXw0Yc0s2CqFFvSi4Dcxirvn2UOrcCz1ZN9BuwfpIUpNeu+NBjDrc/bUXrW0W6TUX4OxWYOpmVit8vnrsj7B9insHOy4eGrguM05FkpbdQd/KsJLEKDi4cLFou80CkBPyO27HH5RFKAvXSvbC4OLiKrKiIzuBX1itirUBkMMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQPnDFeI; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQPnDFeI"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8849640042
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9FcpPNkzULX for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 06:01:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 443BB400D7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 443BB400D7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iQPnDFeI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 443BB400D7
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 06:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721714489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFUGGCd0Ti7ajjqk9V9q2SgIV68PyjzZBB05K4vzgXI=;
	b=iQPnDFeIaIgqjjwCocDWhML5iAs7+esO/4jHM+bz9IXX3WRdFtyyUHJHkx6lxVf/1EO6nK
	DA+JRQ2sIQLPWWLHs8gANw9I580/SkbkiaF03PeyTjioPMQpLHbP5ycDhi5oblyd9gKlpv
	KV0CI6d7RsOOCbWjbYQ0zGX+SowtSAE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-QC1yHA6LMKmGNEPr7xXRPQ-1; Tue, 23 Jul 2024 02:01:27 -0400
X-MC-Unique: QC1yHA6LMKmGNEPr7xXRPQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70d1d51f3e9so2483782b3a.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 23:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714486; x=1722319286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFUGGCd0Ti7ajjqk9V9q2SgIV68PyjzZBB05K4vzgXI=;
        b=w/POlFkKBNdHNg3lAwpwHoDwiWY9EzlLHL50lZbgwIrWW45ZaWcPMBzccs6C1JHpHx
         a1GhO11z7C9Tug5/8RPKPEtQ4zMSaLwmnU6DHkua/7MwjwpITHy2K8ETBteLPc5JbdsN
         n++ca2pS0YzEKcbufJaPvbBqX0lqNa5n1vvKohmimtG/uHRZ3f8ouyEpAnIEL29hE2YD
         xE+S2QCVRWfMhMS8a9qisjdbSooX77Z1OsD3HPIyE8u9BiptI6xwQeZMS/Jrc/2DdcI5
         C3wjC5ibSNXnnAifX3Dth+onJsgQynQ/zQ2JeiqQAuOAPzEp2SKeMNvsAp6Y8vFg+dCr
         pbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwCcdnFu5xN0dx+4wBt6Ar6rvbY/iA3DI51LK3BUi4HKYG0deNtxbgdgXgygZHHMu5LIOeX18Xb/QOioh0d4GRJby2Ma472qLeNbqJho336O2rr4TlkiP9YQ==
X-Gm-Message-State: AOJu0Yxw7h1UtbPOAStSk0CvvoYGdhvFHgD4saVpNnqBbS14arjSd0uW
	AaOmIHV/tAXF4cowEbyv1bwVs21tgBOYVlvzfJsPdpQhhNSUvJ3cqAPI1yvoNGQfXjChjm4qVtK
	VC2xBQVXUskCM2GawWbTXJULOZK7HvT4n1nZLQbFhxjl5LPQY8hyFAlPjKvtsrSwmKyH9sZN/Mj
	Jmrw2jTpmGp4uZMZXIiaNE7P82oYWY973PfqUK9tbdLuDAiLClik7CKg==
X-Received: by 2002:a05:6a20:748c:b0:1c2:74b4:a05d with SMTP id adf61e73a8af0-1c4228c17c9mr14693854637.23.1721714485924;
        Mon, 22 Jul 2024 23:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbYKlnLDWuDPqyKiWo0elei3K5WRnvIvnuckGXshR2QiKbTbh3jj82vCLFGmScBe6bfH0HlrebBeiWK/cbDmo=
X-Received: by 2002:a05:6a20:748c:b0:1c2:74b4:a05d with SMTP id
 adf61e73a8af0-1c4228c17c9mr14693817637.23.1721714485296; Mon, 22 Jul 2024
 23:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <20240723054047.1059994-2-lulu@redhat.com>
In-Reply-To: <20240723054047.1059994-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Jul 2024 14:01:13 +0800
Message-ID: <CACGkMEuoYAkAxhZrZfyWpMV__eimDvNCWYogidC6qMpOVBh0aw@mail.gmail.com>
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> new MAC address from the vdpa tool and then set it to the device.
>
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
> Here is example:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
>
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  9 +++++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 94 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8d391947eb8d..07d61ee62839 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct =
sk_buff *skb, struct genl_info
>         return err;
>  }
>
> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +                                       struct genl_info *info)
> +{
> +       struct vdpa_dev_set_config set_config =3D {};
> +       const u8 *macaddr;
> +       struct vdpa_mgmt_dev *mdev =3D vdev->mdev;
> +       struct nlattr **nl_attrs =3D info->attrs;
> +       int err =3D -EINVAL;
> +
> +       if (!vdev->mdev)
> +               return -EINVAL;

It looks like the caller has already done this check?

> +
> +       down_write(&vdev->cf_lock);
> +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&

This is not a virtio feature, so I don't get why we need to check
VIRTIO_NET_F_MAC.

> +           nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +               set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> +               macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> +
> +               if (is_valid_ether_addr(macaddr)) {
> +                       memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +                       if (mdev->ops->dev_set_attr) {
> +                               err =3D mdev->ops->dev_set_attr(mdev, vde=
v,
> +                                                             &set_config=
);
> +                       } else {
> +                               NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +                                                      "device not suppor=
ted");

"Device does not support setting mac address" ?

> +                       }
> +               } else {
> +                       NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +                                              "Invalid MAC address");
> +               }
> +       }
> +       up_write(&vdev->cf_lock);
> +       return err;
> +}
> +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> +                                        struct genl_info *info)
> +{
> +       const char *name;
> +       int err =3D 0;
> +       struct device *dev;
> +       struct vdpa_device *vdev;
> +       u64 classes;
> +
> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +               return -EINVAL;
> +
> +       name =3D nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +
> +       down_write(&vdpa_dev_lock);
> +       dev =3D bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> +       if (!dev) {
> +               NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +               err =3D -ENODEV;
> +               goto dev_err;
> +       }
> +       vdev =3D container_of(dev, struct vdpa_device, dev);
> +       if (!vdev->mdev) {
> +               NL_SET_ERR_MSG_MOD(
> +                       info->extack,
> +                       "Fail to find the specified management device");
> +               err =3D -EINVAL;
> +               goto mdev_err;
> +       }
> +       classes =3D vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> +       if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> +               err =3D vdpa_dev_net_device_attr_set(vdev, info);
> +       } else {
> +               NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not suppo=
rted",
> +                                      name);
> +       }
> +
> +mdev_err:
> +       put_device(dev);
> +dev_err:
> +       up_write(&vdpa_dev_lock);
> +       return err;
> +}
> +
>  static int vdpa_dev_config_dump(struct device *dev, void *data)
>  {
>         struct vdpa_device *vdev =3D container_of(dev, struct vdpa_device=
, dev);
> @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] =3D {
>                 .doit =3D vdpa_nl_cmd_dev_stats_get_doit,
>                 .flags =3D GENL_ADMIN_PERM,
>         },
> +       {
> +               .cmd =3D VDPA_CMD_DEV_ATTR_SET,
> +               .doit =3D vdpa_nl_cmd_dev_attr_set_doit,
> +               .flags =3D GENL_ADMIN_PERM,
> +       },
>  };
>
>  static struct genl_family vdpa_nl_family __ro_after_init =3D {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7977ca03ac7a..3511156c10db 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 s=
tatus);
>   *          @dev: vdpa device to remove
>   *          Driver need to remove the specified device by calling
>   *          _vdpa_unregister_device().
> +  * @dev_set_attr: change a vdpa device's attr after it was create
> + *          @mdev: parent device to use for device
> + *          @dev: vdpa device structure
> + *          @config:Attributes to be set for the device.
> + *          The driver needs to check the mask of the structure and then=
 set
> + *          the related information to the vdpa device. The driver must =
return 0
> + *          if set successfully.
>   */
>  struct vdpa_mgmtdev_ops {
>         int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>                        const struct vdpa_dev_set_config *config);
>         void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *d=
ev);
> +       int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_devic=
e *dev,
> +                           const struct vdpa_dev_set_config *config);
>  };
>
>  /**
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 842bf1201ac4..71edf2c70cc3 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -19,6 +19,7 @@ enum vdpa_command {
>         VDPA_CMD_DEV_GET,               /* can dump */
>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
>         VDPA_CMD_DEV_VSTATS_GET,
> +       VDPA_CMD_DEV_ATTR_SET,
>  };
>
>  enum vdpa_attr {
> --
> 2.45.0
>

Thanks

