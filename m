Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBB2ED869
	for <virtualization@lists.linux-foundation.org>; Wed,  1 Oct 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325218; cv=none; b=Ohc/9wcu0dOK14e1enQdGNUXX77w5NiKwj8M31i5OxG7iJMGRYN6MalKM4rBSj48jyQaRSk9PQossxNNEggr6hiBPB2cwhQV+1MbAS88BK5P+YXL19qKwCyY7+RASwS5VHkv28YxLCWPUokEitSHEyXRRuyA76a0E9MDhH963fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325218; c=relaxed/simple;
	bh=LRAABFgju+Gmfg2mIZ1aoTIFvUWnxmu7159ky6Bh6ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjaVpCGDdwA0IuNr7CLlR/edXxqf5h0QVdjLqIqD6qMOqzi2U+JvL+peE60MfKN0AX+Wef9WlKvlgVv6qdLd2GUUxAjvVF7OJDuCUQIkM4NwSVOxxuMZCv1oiLJ6d2RASOU+VR7bL/YqPHvOpGBRwB+wlu748q0ALmGsh4dBVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKZGFhkS; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKZGFhkS"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8467941089
	for <virtualization@lists.linux-foundation.org>; Wed,  1 Oct 2025 13:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPPmWIsU3lT6 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Oct 2025 13:26:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7D11E41076
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D11E41076
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKZGFhkS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D11E41076
	for <virtualization@lists.linux-foundation.org>; Wed,  1 Oct 2025 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759325214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAGW8ES38PbYiupm2nBaulPze8EVKivbblcAWTv+vpY=;
	b=dKZGFhkSFJHQUGeMZk0xI7YosLWLi5IkFJxl0gtyycA1RFSZiDJhDS7nCmBZRmjJNJdiVL
	ZGZdBZEeTTi1x99HB+93kbSJmFqbCElyxx6Yblg4uuJLuDx7lW0kf8bmSnyO5LRJYXAx3k
	YU6blGWwvNk71U2IBAIvSuylFofJTYE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-5pqbPo8vN_uKBL1NaDBgUg-1; Wed, 01 Oct 2025 09:26:51 -0400
X-MC-Unique: 5pqbPo8vN_uKBL1NaDBgUg-1
X-Mimecast-MFC-AGG-ID: 5pqbPo8vN_uKBL1NaDBgUg_1759325210
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-746b28ff4c5so74042857b3.3
        for <virtualization@lists.linux-foundation.org>; Wed, 01 Oct 2025 06:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325210; x=1759930010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAGW8ES38PbYiupm2nBaulPze8EVKivbblcAWTv+vpY=;
        b=BWyod/lSr9DJfBWHjPy/FzVltxyDo4p7Oij+ET0POA+Nb4fU5lVS5FeFOzU+xM5jSv
         aRVWo2y0RhKfz8D+lO/mIq9LqK88TpU4npHfQYNG7zwFnVflZRjphNwRC1yFHphVV55g
         CMXJEyO5ph/vQUtQwqMoOF2MEixG0amZuhZ960MmOBZ7vn9aZWg2mrH7kVSf/P7cy6W8
         XECVwHDXaYTqY7kHERjMUzFOudamf8wP3E8x1ZBkv+lCODYhE53VI+3LhMse+6QXlqHs
         ruWwUxSL+XWms+Sne79vokzLiOEls692tJpdweurMAWyS4nL5A6c8nfje5BDCalVeux+
         S8mA==
X-Forwarded-Encrypted: i=1; AJvYcCWRpaPPvH9aXgsvqmuKuTzO2dEkjnJiLUSuISLC4kfNcFoGqoqdLTWCQdvOcoex5tussiyO6oZTAEmpg+xNbw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxolV1K+BPyRmHlGFztYAMrYKuVzF+RXpdgdWpfRKxA60GxjW1W
	nqcXgomnL1zrT+I3haPYzm52XDhP/jtlgWfEbVZflZHJgWjmkuqCllJVPkDIEe9irrSTw0HmmFo
	EETusWHWu62p7h1qW0oN7ypD4H2SeWzp5YQwq4UO8nuwUpIEENCCVMPMBAqmVwLPRV/1mVaW4ih
	YUx/gtJPujGkuWODQptoevEEE92L8aojJ1biiMfM5mbV8FE2n3uWbLA7auNg==
X-Gm-Gg: ASbGncujE0HAWK+KlMkDx3Bp2I6pAyHD/bN8FhP8XrbnydCOwpzqBhqkWg0Tl3jZ6Wr
	dbsV60nClMRXm9Ruy+khnCiIDRiP+BrNCwWs+F+C/Qim6969e2XjDHdb36X5XSH+ApuW4DWlFkn
	16kZkafscd8Pm/b0GaUzBIsJGd0EsSIvGr65fB979sH+w+ZVFYXpD1soIOrtNt0jAT+H1IX6L6r
	VSxccEOWXZPtw==
X-Received: by 2002:a05:690e:6c9:b0:632:5ba8:1bb5 with SMTP id 956f58d0204a3-63b6feb4b67mr4100194d50.21.1759325210542;
        Wed, 01 Oct 2025 06:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjTH4h+j2839M7DNr9+hAJ3uUMbZ1V4wuh3pcYeTCYK0fJoA5+HVVG3RIGqkpS2Pxx1r5NCBQgCQ1kpF78m/o=
X-Received: by 2002:a05:690e:6c9:b0:632:5ba8:1bb5 with SMTP id
 956f58d0204a3-63b6feb4b67mr4100160d50.21.1759325210126; Wed, 01 Oct 2025
 06:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com> <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 1 Oct 2025 15:26:13 +0200
X-Gm-Features: AS18NWD7c8XCB1fbsTkpnchn6hG3Qu77blglfP_z2PBQTYo6EuZC3om7_PG_A7g
Message-ID: <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
Subject: Re: [PATCH RESENT v4 4/6] vdpa: validate device feature provisioning
 against supported class
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GO5A6KTTd9KEtjQauDjkeHxLSSKZPD6r1lAsvOG27GM_1759325210
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 7, 2023 at 12:15=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Today when device features are explicitly provisioned, the features
> user supplied may contain device class specific features that are
> not supported by the parent management device. On the other hand,
> when parent management device supports more than one class, the
> device features to provision may be ambiguous if none of the class
> specific attributes is provided at the same time. Validate these
> cases and prompt appropriate user errors accordingly.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1eba978..8da5120 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_bu=
ff *msg, const struct vdpa_mg
>         return 0;
>  }
>
> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
> +                                   unsigned int *nclasses)
> +{
> +       u64 supported_classes =3D 0;
> +       unsigned int n =3D 0;
> +
> +       for (int i =3D 0; mdev->id_table[i].device; i++) {
> +               if (mdev->id_table[i].device > 63)
> +                       continue;
> +               supported_classes |=3D BIT_ULL(mdev->id_table[i].device);
> +               n++;
> +       }
> +       if (nclasses)
> +               *nclasses =3D n;
> +
> +       return supported_classes;
> +}
> +
>  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk=
_buff *msg,
>                              u32 portid, u32 seq, int flags)
>  {
> -       u64 supported_classes =3D 0;
>         void *hdr;
> -       int i =3D 0;
>         int err;
>
>         hdr =3D genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDP=
A_CMD_MGMTDEV_NEW);
> @@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_=
dev *mdev, struct sk_buff *m
>         if (err)
>                 goto msg_err;
>
> -       while (mdev->id_table[i].device) {
> -               if (mdev->id_table[i].device <=3D 63)
> -                       supported_classes |=3D BIT_ULL(mdev->id_table[i].=
device);
> -               i++;
> -       }
> -
>         if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> -                             supported_classes, VDPA_ATTR_UNSPEC)) {
> +                             vdpa_mgmtdev_get_classes(mdev, NULL),
> +                             VDPA_ATTR_UNSPEC)) {
>                 err =3D -EMSGSIZE;
>                 goto msg_err;
>         }
> @@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_b=
uff *skb, struct genl_info *i
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     |=
 \
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>
> +/*
> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_=
START
> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
> + * all 64bit features. If the features are extended beyond 64 bits, or n=
ew
> + * "holes" are reserved for other type of features than per-device, this
> + * macro would have to be updated.
> + */
> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
> +                             ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
> +
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl=
_info *info)
>  {
>         struct vdpa_dev_set_config config =3D {};
>         struct nlattr **nl_attrs =3D info->attrs;
>         struct vdpa_mgmt_dev *mdev;
> +       unsigned int ncls =3D 0;
>         const u8 *macaddr;
>         const char *name;
> +       u64 classes;
>         int err =3D 0;
>
>         if (!info->attrs[VDPA_ATTR_DEV_NAME])
> @@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_bu=
ff *skb, struct genl_info *i
>                 goto err;
>         }
>
> +       classes =3D vdpa_mgmtdev_get_classes(mdev, &ncls);
> +       if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
> +           !(classes & BIT_ULL(VIRTIO_ID_NET))) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "Network class attributes provided on =
unsupported management device");
> +               err =3D -EINVAL;
> +               goto err;
> +       }
> +       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> +           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> +           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> +           config.device_features & VIRTIO_DEVICE_F_MASK) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "Management device supports multi-clas=
s while device features specified are ambiguous");
> +               err =3D -EINVAL;
> +               goto err;
> +       }


Hi! I need to question this last if() :). What's the point of error
when we specify features device-specific, from net or blk?

In the VDUSE case both blk and net are supported. I want to use
device_features to limit the net features that the VDUSE device
exports.

Also, why is this limited to only net devices? does this part:

classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1

Means that it is ok to specify more than one class as long as the set
does not contain net?

> +
>         err =3D mdev->ops->dev_add(mdev, name, &config);
>  err:
>         up_write(&vdpa_dev_lock);
> --
> 1.8.3.1
>

