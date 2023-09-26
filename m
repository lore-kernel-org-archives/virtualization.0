Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8279BE7E628
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 11:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFF78400EF;
	Tue, 26 Sep 2023 11:41:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFF78400EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FELqfdto
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N_EQO-B3JVKf; Tue, 26 Sep 2023 11:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23195417F4;
	Tue, 26 Sep 2023 11:41:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23195417F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB5EDC0071;
	Tue, 26 Sep 2023 11:41:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4A01C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E0DD41E8D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:41:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E0DD41E8D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FELqfdto
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kvuy1f0kRFev
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:41:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2391841E8B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2391841E8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695728512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5uVRN9fbL8/Flok1FuoN0J/7W7m6F3z9a1UNNRaQbI=;
 b=FELqfdton6VRbH56JScv0kodPXT/Bqp+W3h9o9IMl8CEnd5BBJxlRECH2083xvLsRpu2TG
 2CeCwtXcuTE3V49iqXQKfVohi9v68TrjZFE+jEQy7zq5za8N/uubFHOW8ihtZe7LGBpNS8
 I58Wr2sva3q7cYMYmZUaChjC9tCMisc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-f_pkY0XzNjK2nWiq2gvUeA-1; Tue, 26 Sep 2023 07:41:50 -0400
X-MC-Unique: f_pkY0XzNjK2nWiq2gvUeA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-53342507b32so17036674a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728509; x=1696333309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5uVRN9fbL8/Flok1FuoN0J/7W7m6F3z9a1UNNRaQbI=;
 b=xBlbSpyJ4IDbzl8DrQPmSA50TKWfOwoLO378PijDs/xyzzoTZsCD8CbMgfIrZ22TlK
 uly5lseE60cfjZ+6usm8JYKfzOWAph+HAim8OmOiKULOZpVo7mqhnQUSOHWjl6w8v07O
 wnz9ivevzZMS1nDUuiE0LNzcOgsYymGx6V5afQU3ubJJVR4UZwSBhEGojaSALRkmimND
 PSN0pX+hGZtJCUgmoJsiLKDA22BF7XaHqTnebU50W2/pAnYl1kX27Xemzdyrj2cl6lBq
 wQZbktr2U/P6Nl+ivjqXzxy4bhnQY8wjlweDNZrgG1hSFCqhWU+76lmucumkP21O/u35
 4RBw==
X-Gm-Message-State: AOJu0YxhE5lz4m9nO3YhbOeSJFWN4b2HbFvM1HR6KIGSdzODXmF4bWLE
 L481aJzOw1NYnOC/j0KLqj+rEQIwJXgf7+RZYOXrBPU53fggQFAhkpRvZ7dgsWIDFZuPAY9viPQ
 SCBY9TXQpd80PHpvGhy+4tl2QouOPtAR3ImD6ATkHsA==
X-Received: by 2002:a05:6402:f20:b0:533:dcb1:5ab4 with SMTP id
 i32-20020a0564020f2000b00533dcb15ab4mr4532293eda.18.1695728509413; 
 Tue, 26 Sep 2023 04:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJCHvtseDaon1zR6tOHK16yWriGxj8hEFZiYSeh+knAYyLm/Z9bPDsztUhZ7ji1Boy38jZyg==
X-Received: by 2002:a05:6402:f20:b0:533:dcb1:5ab4 with SMTP id
 i32-20020a0564020f2000b00533dcb15ab4mr4532260eda.18.1695728508973; 
 Tue, 26 Sep 2023 04:41:48 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 c2-20020aa7c982000000b0053132e5ea61sm6647832edt.30.2023.09.26.04.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 04:41:48 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:41:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20230926072538-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230922055336-mutt-send-email-mst@kernel.org>
 <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Sep 26, 2023 at 02:14:01PM +0300, Yishai Hadas wrote:
> On 22/09/2023 12:54, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 03:40:39PM +0300, Yishai Hadas wrote:
> > > Expose admin commands over the virtio device, to be used by the
> > > vfio-virtio driver in the next patches.
> > > =

> > > It includes: list query/use, legacy write/read, read notify_info.
> > > =

> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > =

> > This stuff is pure virtio spec. I think it should live under
> > drivers/virtio, too.
> =

> The motivation to put it in the vfio layer was from the below main reason=
s:
> =

> 1) Having it inside virtio may require to export a symbol/function per
> command.
> =

> =A0=A0 This will end up today by 5 and in the future (e.g. live migration=
) with
> much more exported symbols.
>
> =A0=A0 With current code we export only 2 generic symbols
> virtio_pci_vf_get_pf_dev(), virtio_admin_cmd_exec() which may fit for any
> further extension.

Except, there's no reasonable way for virtio to know what is done with
the device then. You are not using just 2 symbols at all, instead you
are using the rich vq API which was explicitly designed for the driver
running the device being responsible for serializing accesses. Which is
actually loaded and running. And I *think* your use won't conflict ATM
mostly by luck. Witness the hack in patch 01 as exhibit 1 - nothing
at all even hints at the fact that the reason for the complicated
dance is because another driver pokes at some of the vqs.


> 2) For now there is no logic in this vfio layer, however, in the future we
> may have some DMA/other logic that should better fit to the caller/client
> layer (i.e. vfio).

You are poking at the device without any locks etc. Maybe it looks like
no logic to you but it does not look like that from where I stand.

> By the way, this follows what was done already between vfio/mlx5 to
> mlx5_core modules where mlx5_core exposes generic APIs to execute a comma=
nd
> and to get the a PF from a given mlx5 VF.

This is up to mlx5 maintainers. In particular they only need to worry
that their patches work with specific hardware which they likely have.
virtio has to work with multiple vendors - hardware and software -
and exposing a low level API that I can't test on my laptop
is not at all my ideal.

> This way, we can enable further commands to be added/extended
> easily/cleanly.

Something for vfio maintainer to consider in case it was
assumed that it's just this one weird thing
but otherwise it's all generic vfio. It's not going to stop there,
will it? The duplication of functionality with vdpa will continue :(


I am much more interested in adding reusable functionality that
everyone benefits from than in vfio poking at the device in its
own weird ways that only benefit specific hardware.


> See for example here [1, 2].
> =

> [1] https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/vfio/pci/mlx=
5/cmd.c#L210
> =

> [2] https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/vfio/pci/mlx=
5/cmd.c#L683
> =

> Yishai



> > =

> > > ---
> > >   drivers/vfio/pci/virtio/cmd.c | 146 +++++++++++++++++++++++++++++++=
+++
> > >   drivers/vfio/pci/virtio/cmd.h |  27 +++++++
> > >   2 files changed, 173 insertions(+)
> > >   create mode 100644 drivers/vfio/pci/virtio/cmd.c
> > >   create mode 100644 drivers/vfio/pci/virtio/cmd.h
> > > =

> > > diff --git a/drivers/vfio/pci/virtio/cmd.c b/drivers/vfio/pci/virtio/=
cmd.c
> > > new file mode 100644
> > > index 000000000000..f068239cdbb0
> > > --- /dev/null
> > > +++ b/drivers/vfio/pci/virtio/cmd.c
> > > @@ -0,0 +1,146 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > +/*
> > > + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights r=
eserved
> > > + */
> > > +
> > > +#include "cmd.h"
> > > +
> > > +int virtiovf_cmd_list_query(struct pci_dev *pdev, u8 *buf, int buf_s=
ize)
> > > +{
> > > +	struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf_dev(pdev);
> > > +	struct scatterlist out_sg;
> > > +	struct virtio_admin_cmd cmd =3D {};
> > > +
> > > +	if (!virtio_dev)
> > > +		return -ENOTCONN;
> > > +
> > > +	sg_init_one(&out_sg, buf, buf_size);
> > > +	cmd.opcode =3D VIRTIO_ADMIN_CMD_LIST_QUERY;
> > > +	cmd.group_type =3D VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> > > +	cmd.result_sg =3D &out_sg;
> > > +
> > > +	return virtio_admin_cmd_exec(virtio_dev, &cmd);
> > > +}
> > > +
> > > +int virtiovf_cmd_list_use(struct pci_dev *pdev, u8 *buf, int buf_siz=
e)
> > > +{
> > > +	struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf_dev(pdev);
> > > +	struct scatterlist in_sg;
> > > +	struct virtio_admin_cmd cmd =3D {};
> > > +
> > > +	if (!virtio_dev)
> > > +		return -ENOTCONN;
> > > +
> > > +	sg_init_one(&in_sg, buf, buf_size);
> > > +	cmd.opcode =3D VIRTIO_ADMIN_CMD_LIST_USE;
> > > +	cmd.group_type =3D VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> > > +	cmd.data_sg =3D &in_sg;
> > > +
> > > +	return virtio_admin_cmd_exec(virtio_dev, &cmd);
> > > +}
> > > +
> > > +int virtiovf_cmd_lr_write(struct virtiovf_pci_core_device *virtvdev,=
 u16 opcode,
> > > +			  u8 offset, u8 size, u8 *buf)
> > > +{
> > > +	struct virtio_device *virtio_dev =3D
> > > +		virtio_pci_vf_get_pf_dev(virtvdev->core_device.pdev);
> > > +	struct virtio_admin_cmd_data_lr_write *in;
> > > +	struct scatterlist in_sg;
> > > +	struct virtio_admin_cmd cmd =3D {};
> > > +	int ret;
> > > +
> > > +	if (!virtio_dev)
> > > +		return -ENOTCONN;
> > > +
> > > +	in =3D kzalloc(sizeof(*in) + size, GFP_KERNEL);
> > > +	if (!in)
> > > +		return -ENOMEM;
> > > +
> > > +	in->offset =3D offset;
> > > +	memcpy(in->registers, buf, size);
> > > +	sg_init_one(&in_sg, in, sizeof(*in) + size);
> > > +	cmd.opcode =3D opcode;
> > > +	cmd.group_type =3D VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> > > +	cmd.group_member_id =3D virtvdev->vf_id + 1;
> > > +	cmd.data_sg =3D &in_sg;
> > > +	ret =3D virtio_admin_cmd_exec(virtio_dev, &cmd);
> > > +
> > > +	kfree(in);
> > > +	return ret;
> > > +}
> > > +
> > > +int virtiovf_cmd_lr_read(struct virtiovf_pci_core_device *virtvdev, =
u16 opcode,
> > > +			 u8 offset, u8 size, u8 *buf)
> > > +{
> > > +	struct virtio_device *virtio_dev =3D
> > > +		virtio_pci_vf_get_pf_dev(virtvdev->core_device.pdev);
> > > +	struct virtio_admin_cmd_data_lr_read *in;
> > > +	struct scatterlist in_sg, out_sg;
> > > +	struct virtio_admin_cmd cmd =3D {};
> > > +	int ret;
> > > +
> > > +	if (!virtio_dev)
> > > +		return -ENOTCONN;
> > > +
> > > +	in =3D kzalloc(sizeof(*in), GFP_KERNEL);
> > > +	if (!in)
> > > +		return -ENOMEM;
> > > +
> > > +	in->offset =3D offset;
> > > +	sg_init_one(&in_sg, in, sizeof(*in));
> > > +	sg_init_one(&out_sg, buf, size);
> > > +	cmd.opcode =3D opcode;
> > > +	cmd.group_type =3D VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> > > +	cmd.data_sg =3D &in_sg;
> > > +	cmd.result_sg =3D &out_sg;
> > > +	cmd.group_member_id =3D virtvdev->vf_id + 1;
> > > +	ret =3D virtio_admin_cmd_exec(virtio_dev, &cmd);
> > > +
> > > +	kfree(in);
> > > +	return ret;
> > > +}
> > > +
> > > +int virtiovf_cmd_lq_read_notify(struct virtiovf_pci_core_device *vir=
tvdev,
> > > +				u8 req_bar_flags, u8 *bar, u64 *bar_offset)
> > > +{
> > > +	struct virtio_device *virtio_dev =3D
> > > +		virtio_pci_vf_get_pf_dev(virtvdev->core_device.pdev);
> > > +	struct virtio_admin_cmd_notify_info_result *out;
> > > +	struct scatterlist out_sg;
> > > +	struct virtio_admin_cmd cmd =3D {};
> > > +	int ret;
> > > +
> > > +	if (!virtio_dev)
> > > +		return -ENOTCONN;
> > > +
> > > +	out =3D kzalloc(sizeof(*out), GFP_KERNEL);
> > > +	if (!out)
> > > +		return -ENOMEM;
> > > +
> > > +	sg_init_one(&out_sg, out, sizeof(*out));
> > > +	cmd.opcode =3D VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO;
> > > +	cmd.group_type =3D VIRTIO_ADMIN_GROUP_TYPE_SRIOV;
> > > +	cmd.result_sg =3D &out_sg;
> > > +	cmd.group_member_id =3D virtvdev->vf_id + 1;
> > > +	ret =3D virtio_admin_cmd_exec(virtio_dev, &cmd);
> > > +	if (!ret) {
> > > +		struct virtio_admin_cmd_notify_info_data *entry;
> > > +		int i;
> > > +
> > > +		ret =3D -ENOENT;
> > > +		for (i =3D 0; i < VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO; i++) {
> > > +			entry =3D &out->entries[i];
> > > +			if (entry->flags =3D=3D VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_END)
> > > +				break;
> > > +			if (entry->flags !=3D req_bar_flags)
> > > +				continue;
> > > +			*bar =3D entry->bar;
> > > +			*bar_offset =3D le64_to_cpu(entry->offset);
> > > +			ret =3D 0;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	kfree(out);
> > > +	return ret;
> > > +}
> > > diff --git a/drivers/vfio/pci/virtio/cmd.h b/drivers/vfio/pci/virtio/=
cmd.h
> > > new file mode 100644
> > > index 000000000000..c2a3645f4b90
> > > --- /dev/null
> > > +++ b/drivers/vfio/pci/virtio/cmd.h
> > > @@ -0,0 +1,27 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > +/*
> > > + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights r=
eserved.
> > > + */
> > > +
> > > +#ifndef VIRTIO_VFIO_CMD_H
> > > +#define VIRTIO_VFIO_CMD_H
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/virtio.h>
> > > +#include <linux/vfio_pci_core.h>
> > > +#include <linux/virtio_pci.h>
> > > +
> > > +struct virtiovf_pci_core_device {
> > > +	struct vfio_pci_core_device core_device;
> > > +	int vf_id;
> > > +};
> > > +
> > > +int virtiovf_cmd_list_query(struct pci_dev *pdev, u8 *buf, int buf_s=
ize);
> > > +int virtiovf_cmd_list_use(struct pci_dev *pdev, u8 *buf, int buf_siz=
e);
> > > +int virtiovf_cmd_lr_write(struct virtiovf_pci_core_device *virtvdev,=
 u16 opcode,
> > > +			  u8 offset, u8 size, u8 *buf);
> > > +int virtiovf_cmd_lr_read(struct virtiovf_pci_core_device *virtvdev, =
u16 opcode,
> > > +			 u8 offset, u8 size, u8 *buf);
> > > +int virtiovf_cmd_lq_read_notify(struct virtiovf_pci_core_device *vir=
tvdev,
> > > +				u8 req_bar_flags, u8 *bar, u64 *bar_offset);
> > > +#endif /* VIRTIO_VFIO_CMD_H */
> > > -- =

> > > 2.27.0
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
