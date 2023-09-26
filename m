Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82557E7E622
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 11:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E91A6147F;
	Tue, 26 Sep 2023 11:25:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E91A6147F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOIV+NLt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmrSZZhaUEU2; Tue, 26 Sep 2023 11:25:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DE0160C19;
	Tue, 26 Sep 2023 11:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DE0160C19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15246C0071;
	Tue, 26 Sep 2023 11:25:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 662E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3408A81208
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3408A81208
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOIV+NLt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3LO7eITA6qOR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:25:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBA8381206
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBA8381206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695727524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkvKpRNFb5MSdbKhJllaoFWTbeB2crbS+rAr6CEJ+5c=;
 b=fOIV+NLtWNMYCrK12deTrDb8nklGmecnKwefno8NqNHESgwtjh6sVIishcRTC/vJZfflco
 5mQWLJtgPaP6thFbtSKjxvQGfO2MEIBXioRY4ng9S0JHLHr/jtdt6TJBpE8UqpmQRtkx5C
 8FvLvt7e1HMAA1mHcPDEC7x0LPM04m4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-jCLxab85OHaqw__lW1vDHQ-1; Tue, 26 Sep 2023 07:25:23 -0400
X-MC-Unique: jCLxab85OHaqw__lW1vDHQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50daa85e940so6522886a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695727522; x=1696332322;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkvKpRNFb5MSdbKhJllaoFWTbeB2crbS+rAr6CEJ+5c=;
 b=QMD/bjK2v2ib5DLzpylEU1crhTLXty6I/ogjMu9lktyhdXPXWK9+zxyF9sVlG0rp+v
 E6l8bOtFqp3KztdIpRqYSZYAXzqBm6XfLpo/bV70waK68sYILUwjm+aUEPKJY9wGaGT/
 QePbiWD2jB4Iuc77t6SmSdNQ75xCrhxjdiWGfhuZyt3/sD0d/spmiMA7cxUZ/31B6SVn
 oD18+6oem703pGjh5glJjD4SNoJQayp0jIckjz/bLEMnyZUkxhyWVhgjAIoBoA0ZQOne
 jf7RpkUmjO0nSYIJZUWmGHbp3UfE2qZVssrFn6kzoZ6koAIHBfgiZV70peDYwDoSWCpv
 1Akg==
X-Gm-Message-State: AOJu0Ywm5D7SFfCuATrQGxHo3FsH9oj0rYWtkJYGK2txaanZLRj+O8+M
 BxMPLEL4Z57Vk4wNUqWi9MM3nPm1YhKpbpOm526BrxWjXr/uI2lgB7Dd9tF4eEyXSrtG2xU1uxO
 sesB4optc0M4byq5yJgVTJhrceTxiIq3aOuKH9pNhCQ==
X-Received: by 2002:aa7:c318:0:b0:525:442b:6068 with SMTP id
 l24-20020aa7c318000000b00525442b6068mr8634578edq.13.1695727522384; 
 Tue, 26 Sep 2023 04:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErvxkNDMNbAqiOng2Q8bY58/9dyu2SOFFD+IouyH79BUcSfofinAcZozjpsSx40Ysi+rMqZA==
X-Received: by 2002:aa7:c318:0:b0:525:442b:6068 with SMTP id
 l24-20020aa7c318000000b00525442b6068mr8634570edq.13.1695727522001; 
 Tue, 26 Sep 2023 04:25:22 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 h9-20020aa7c609000000b00532c1dfe8ecsm6559167edq.66.2023.09.26.04.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 04:25:21 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:25:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20230926071350-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230921162621-mutt-send-email-mst@kernel.org>
 <cf657792-c21a-4ef7-737d-402239ce557d@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <cf657792-c21a-4ef7-737d-402239ce557d@nvidia.com>
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

On Tue, Sep 26, 2023 at 01:51:13PM +0300, Yishai Hadas wrote:
> On 21/09/2023 23:34, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 03:40:39PM +0300, Yishai Hadas wrote:
> > > Expose admin commands over the virtio device, to be used by the
> > > vfio-virtio driver in the next patches.
> > > =

> > > It includes: list query/use, legacy write/read, read notify_info.
> > > =

> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
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
> > in/out seem all wrong here. In virtio terminology, in means from
> > device to driver, out means from driver to device.
> I referred here to in/out from vfio POV who prepares the command.
> =

> However, I can replace it to follow the virtio terminology as you suggest=
ed
> if this more makes sense.
> =

> Please see also my coming answer on your suggestion to put all of this in
> the virtio layer.
> =

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
> > =

> > what is _lr short for?
> =

> This was an acronym to legacy_read.
> =

> The actual command is according to the given opcode which can be one among
> LEGACY_COMMON_CFG_READ, LEGACY_DEV_CFG_READ.
> =

> I can rename it to '_legacy_read' (i.e. virtiovf_issue_legacy_read_cmd) to
> be clearer.
> =

> > =

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
> > weird. why + 1?
> =

> This follows the virtio spec in that area.
> =

> "When sending commands with the SR-IOV group type, the driver specify a
> value for group_member_id
> between 1 and NumVFs inclusive."

Ah, I get it. Pls add a comment.

> The 'virtvdev->vf_id' was set upon vfio/virtio driver initialization by
> pci_iov_vf_id() which its first index is 0.
> =

> > > +	cmd.data_sg =3D &in_sg;
> > > +	ret =3D virtio_admin_cmd_exec(virtio_dev, &cmd);
> > > +
> > > +	kfree(in);
> > > +	return ret;
> > > +}
> > How do you know it's safe to send this command, in particular at
> > this time? This seems to be doing zero checks, and zero synchronization
> > with the PF driver.
> > =

> The virtiovf_cmd_lr_read()/other gets a virtio VF and it gets its PF by
> calling virtio_pci_vf_get_pf_dev().
> =

> The VF can't gone by 'disable sriov' as it's owned/used by vfio.
> =

> The PF can't gone by rmmod/modprobe -r of virtio, as of the 'module in
> use'/dependencies between VFIO to VIRTIO.
> =

> The below check [1] was done only from a clean code perspective, which mi=
ght
> theoretically fail in case the given VF doesn't use a virtio driver.
> =

> [1] if (!virtio_dev)
> =A0=A0 =A0=A0=A0=A0 return -ENOTCONN;
> =

> So, it looks safe as is.

Can the device can be unbound from module right after you did the check?
What about suspend - can this be called while suspend is in progress?


More importantly, virtio can decide to reset the device for its
own internal reasons (e.g. to recover from an error).
We used to do it when attaching XDP, and we can start doing it again.
That's one of the reasons why I want all this code under virtio, so we'll r=
emember.


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
> > and what is lq short for?
> =

> To be more explicit, I may replace to virtiovf_cmd_legacy_notify_info() to
> follow the spec opcode.
> =

> Yishai
> =

> > =

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
