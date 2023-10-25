Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548D9C0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 10:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFF474F3A3;
	Wed, 25 Oct 2023 10:17:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFF474F3A3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g3ytxZ2t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3yAE8nyHO6Qz; Wed, 25 Oct 2023 10:17:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE3CA4F39B;
	Wed, 25 Oct 2023 10:17:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE3CA4F39B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9273CC0071;
	Wed, 25 Oct 2023 10:17:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A499C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA76981E0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA76981E0B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g3ytxZ2t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rq8Fk_FBrAwD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:17:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C20D81F19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C20D81F19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698229035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1Z37gyYhD30KSgPl1icjkAgT5bUw998hrc/g210+j4=;
 b=g3ytxZ2teNfRFvdRaRdHEQowd6GYH3gjs0ZfDSlnaDy56D5vylT6SIxrRXqW1G3bLN6shC
 gE6A6oFBYP7XXemsTBD7WywjwwjsehCzl3ho8HPS8+t5c/2ArD+LSTuSC6/5R9YZP2FZnK
 qESJ/CScwtWYLYVP19UFmNg6yIcgzUY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-xLyEPXS_N_eYQVCbTlJMhA-1; Wed, 25 Oct 2023 06:17:13 -0400
X-MC-Unique: xLyEPXS_N_eYQVCbTlJMhA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5079c865541so5465111e87.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 03:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698229032; x=1698833832;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1Z37gyYhD30KSgPl1icjkAgT5bUw998hrc/g210+j4=;
 b=TXKQ5+irgXkxMcmSF5ATfMQZrhj/M7DPxWHa4gVlIykkkY4BOnisDyNtFGjrozjmz8
 qdErJmuvth2AkSUYJxvSndU9cBEOkZCtrxb/OsGx7pTKMmyVpS2NaILDXDLNrGs+fDBs
 bQN4AVPgQ+KbQ+DmRD0DUYJDA8QkEiifJ6sUexcoCv84BfabM3omnybHVmce9RyDkO9u
 hYgm7Wb3HLluWsc2E5WfAGBAvoZF57RKz+B4Uto9YwcmxMGdHh/9I9tpdcYPvUb4elRq
 dHY0Y6knB3L5ec8lg1rUK/Yy9aCqGKsDK5siuKHyzNmAsojt72YiwY7FnkcuwwVnwJHt
 eqKA==
X-Gm-Message-State: AOJu0Yw9fhHLHGBbCbcC47NDk8Hrz8ABCED2qpBuZEkNo0S3s5BOvVNq
 gasJPMvCd7Rd8dwxJ0y58OHZsMj9IYeP4u2EzfQ72aUZT5oTxngRSLRWB4IdbjVb9ilHetitSlE
 XdisBW11ZnGQNIWzBQ7PlofYBaUIp9007ClBkQGnT9A==
X-Received: by 2002:a05:6512:39cc:b0:503:5cd:998b with SMTP id
 k12-20020a05651239cc00b0050305cd998bmr12161022lfu.28.1698229032131; 
 Wed, 25 Oct 2023 03:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3nM0DRplL5E/Z3XA9rrQCGnMdOPJphKl2/V+ViXuzOoEnMDMtkPlYoTz7TdGMHqFFyI6mCw==
X-Received: by 2002:a05:6512:39cc:b0:503:5cd:998b with SMTP id
 k12-20020a05651239cc00b0050305cd998bmr12160996lfu.28.1698229031717; 
 Wed, 25 Oct 2023 03:17:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c499100b0040772138bb7sm18802951wmp.2.2023.10.25.03.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 03:17:11 -0700 (PDT)
Date: Wed, 25 Oct 2023 06:17:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 6/9] virtio-pci: Introduce APIs to execute legacy
 IO admin commands
Message-ID: <20231025060501-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-7-yishaih@nvidia.com>
 <20231024165210-mutt-send-email-mst@kernel.org>
 <5a83e6c1-1d32-4edb-a01c-3660ab74d875@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <5a83e6c1-1d32-4edb-a01c-3660ab74d875@nvidia.com>
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

On Wed, Oct 25, 2023 at 12:18:32PM +0300, Yishai Hadas wrote:
> On 25/10/2023 0:01, Michael S. Tsirkin wrote:
> =

>     On Tue, Oct 17, 2023 at 04:42:14PM +0300, Yishai Hadas wrote:
> =

>         Introduce APIs to execute legacy IO admin commands.
> =

>         It includes: list_query/use, io_legacy_read/write,
>         io_legacy_notify_info.
> =

>         Those APIs will be used by the next patches from this series.
> =

>         Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>         ---
>          drivers/virtio/virtio_pci_common.c |  11 ++
>          drivers/virtio/virtio_pci_common.h |   2 +
>          drivers/virtio/virtio_pci_modern.c | 206 +++++++++++++++++++++++=
++++++
>          include/linux/virtio_pci_admin.h   |  18 +++
>          4 files changed, 237 insertions(+)
>          create mode 100644 include/linux/virtio_pci_admin.h
> =

>         diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/=
virtio_pci_common.c
>         index 6b4766d5abe6..212d68401d2c 100644
>         --- a/drivers/virtio/virtio_pci_common.c
>         +++ b/drivers/virtio/virtio_pci_common.c
>         @@ -645,6 +645,17 @@ static struct pci_driver virtio_pci_driver =
=3D {
>                 .sriov_configure =3D virtio_pci_sriov_configure,
>          };
> =

>         +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *p=
dev)
>         +{
>         +       struct virtio_pci_device *pf_vp_dev;
>         +
>         +       pf_vp_dev =3D pci_iov_get_pf_drvdata(pdev, &virtio_pci_dr=
iver);
>         +       if (IS_ERR(pf_vp_dev))
>         +               return NULL;
>         +
>         +       return &pf_vp_dev->vdev;
>         +}
>         +
>          module_pci_driver(virtio_pci_driver);
> =

>          MODULE_AUTHOR("Anthony Liguori <aliguori@us.ibm.com>");
>         diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/=
virtio_pci_common.h
>         index a21b9ba01a60..2785e61ed668 100644
>         --- a/drivers/virtio/virtio_pci_common.h
>         +++ b/drivers/virtio/virtio_pci_common.h
>         @@ -155,4 +155,6 @@ static inline void virtio_pci_legacy_remove(s=
truct virtio_pci_device *vp_dev)
>          int virtio_pci_modern_probe(struct virtio_pci_device *);
>          void virtio_pci_modern_remove(struct virtio_pci_device *);
> =

>         +struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *p=
dev);
>         +
>          #endif
>         diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/=
virtio_pci_modern.c
>         index cc159a8e6c70..00b65e20b2f5 100644
>         --- a/drivers/virtio/virtio_pci_modern.c
>         +++ b/drivers/virtio/virtio_pci_modern.c
>         @@ -719,6 +719,212 @@ static void vp_modern_destroy_avq(struct vi=
rtio_device *vdev)
>                 vp_dev->del_vq(&vp_dev->admin_vq.info);
>          }
> =

>         +/*
>         + * virtio_pci_admin_list_query - Provides to driver list of comm=
ands
>         + * supported for the PCI VF.
>         + * @dev: VF pci_dev
>         + * @buf: buffer to hold the returned list
>         + * @buf_size: size of the given buffer
>         + *
>         + * Returns 0 on success, or negative on failure.
>         + */
>         +int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, i=
nt buf_size)
>         +{
>         +       struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf=
_dev(pdev);
>         +       struct virtio_admin_cmd cmd =3D {};
>         +       struct scatterlist result_sg;
>         +
>         +       if (!virtio_dev)
>         +               return -ENODEV;
>         +
>         +       sg_init_one(&result_sg, buf, buf_size);
>         +       cmd.opcode =3D cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
>         +       cmd.group_type =3D cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SR=
IOV);
>         +       cmd.result_sg =3D &result_sg;
>         +
>         +       return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>         +}
>         +EXPORT_SYMBOL_GPL(virtio_pci_admin_list_query);
>         +
>         +/*
>         + * virtio_pci_admin_list_use - Provides to device list of comman=
ds
>         + * used for the PCI VF.
>         + * @dev: VF pci_dev
>         + * @buf: buffer which holds the list
>         + * @buf_size: size of the given buffer
>         + *
>         + * Returns 0 on success, or negative on failure.
>         + */
>         +int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int=
 buf_size)
>         +{
>         +       struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf=
_dev(pdev);
>         +       struct virtio_admin_cmd cmd =3D {};
>         +       struct scatterlist data_sg;
>         +
>         +       if (!virtio_dev)
>         +               return -ENODEV;
>         +
>         +       sg_init_one(&data_sg, buf, buf_size);
>         +       cmd.opcode =3D cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
>         +       cmd.group_type =3D cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SR=
IOV);
>         +       cmd.data_sg =3D &data_sg;
>         +
>         +       return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>         +}
>         +EXPORT_SYMBOL_GPL(virtio_pci_admin_list_use);
> =

>     list commands are actually for a group, not for the VF.
> =

> The VF was given to let the function gets the PF from it.
> =

> For now, the only existing 'group_type' in the spec is SRIOV, this is why=
 we
> hard-coded it internally to match the VF PCI.
> =

> Alternatively,
> We can change the API to get the PF and 'group_type' from the caller to b=
etter
> match future usage.
> However, this will require to export the virtio_pci_vf_get_pf_dev() API o=
utside
> virtio-pci.
> =

> Do you prefer to change to the latter option ?

No, there are several points I wanted to make but this
was not one of them.

First, for query, I was trying to suggest changing the comment.
Something like:
         + * virtio_pci_admin_list_query - Provides to driver list of comma=
nds
         + * supported for the group including the given member device.
         + * @dev: member pci device.
	=



Second, I don't think using buf/size  like this is necessary.
For now we have a small number of commands just work with u64.


Third, while list could be an OK API, the use API does not
really work. If you call use with one set of parameters for
one VF and another for another then they conflict do they not?

So you need virtio core to do the list/use dance for you,
save the list of commands on the PF (which again is just u64 for now)
and vfio or vdpa or whatnot will just query that.
I hope I'm being clear.



> =

> =

> =

>         +
>         +/*
>         + * virtio_pci_admin_legacy_io_write - Write legacy registers of =
a member device
>         + * @dev: VF pci_dev
>         + * @opcode: op code of the io write command
> =

>     opcode is actually either VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
>     or VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE correct?
> =

>     So please just add 2 APIs for this so users don't need to care.
>     Could be wrappers around these two things.
> =

> =

> OK.
> =

> We'll export the below 2 APIs [1] which internally will call
> virtio_pci_admin_legacy_io_write() with the proper op code hard-coded.
> =

> [1]virtio_pci_admin_legacy_device_io_write()
> =A0=A0=A0=A0 virtio_pci_admin_legacy_common_io_write()
> =

> Yishai
>

Makes sense.
 =

> =

> =

>         + * @offset: starting byte offset within the registers to write to
>         + * @size: size of the data to write
>         + * @buf: buffer which holds the data
>         + *
>         + * Returns 0 on success, or negative on failure.
>         + */
>         +int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 o=
pcode,
>         +                                    u8 offset, u8 size, u8 *buf)
>         +{
>         +       struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf=
_dev(pdev);
>         +       struct virtio_admin_cmd_legacy_wr_data *data;
>         +       struct virtio_admin_cmd cmd =3D {};
>         +       struct scatterlist data_sg;
>         +       int vf_id;
>         +       int ret;
>         +
>         +       if (!virtio_dev)
>         +               return -ENODEV;
>         +
>         +       vf_id =3D pci_iov_vf_id(pdev);
>         +       if (vf_id < 0)
>         +               return vf_id;
>         +
>         +       data =3D kzalloc(sizeof(*data) + size, GFP_KERNEL);
>         +       if (!data)
>         +               return -ENOMEM;
>         +
>         +       data->offset =3D offset;
>         +       memcpy(data->registers, buf, size);
>         +       sg_init_one(&data_sg, data, sizeof(*data) + size);
>         +       cmd.opcode =3D cpu_to_le16(opcode);
>         +       cmd.group_type =3D cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SR=
IOV);
>         +       cmd.group_member_id =3D cpu_to_le64(vf_id + 1);
>         +       cmd.data_sg =3D &data_sg;
>         +       ret =3D vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>         +
>         +       kfree(data);
>         +       return ret;
>         +}
>         +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_write);
>         +
>         +/*
>         + * virtio_pci_admin_legacy_io_read - Read legacy registers of a =
member device
>         + * @dev: VF pci_dev
>         + * @opcode: op code of the io read command
>         + * @offset: starting byte offset within the registers to read fr=
om
>         + * @size: size of the data to be read
>         + * @buf: buffer to hold the returned data
>         + *
>         + * Returns 0 on success, or negative on failure.
>         + */
>         +int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 op=
code,
>         +                                   u8 offset, u8 size, u8 *buf)
>         +{
>         +       struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf=
_dev(pdev);
>         +       struct virtio_admin_cmd_legacy_rd_data *data;
>         +       struct scatterlist data_sg, result_sg;
>         +       struct virtio_admin_cmd cmd =3D {};
>         +       int vf_id;
>         +       int ret;
>         +
>         +       if (!virtio_dev)
>         +               return -ENODEV;
>         +
>         +       vf_id =3D pci_iov_vf_id(pdev);
>         +       if (vf_id < 0)
>         +               return vf_id;
>         +
>         +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>         +       if (!data)
>         +               return -ENOMEM;
>         +
>         +       data->offset =3D offset;
>         +       sg_init_one(&data_sg, data, sizeof(*data));
>         +       sg_init_one(&result_sg, buf, size);
>         +       cmd.opcode =3D cpu_to_le16(opcode);
>         +       cmd.group_type =3D cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SR=
IOV);
>         +       cmd.group_member_id =3D cpu_to_le64(vf_id + 1);
>         +       cmd.data_sg =3D &data_sg;
>         +       cmd.result_sg =3D &result_sg;
>         +       ret =3D vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>         +
>         +       kfree(data);
>         +       return ret;
>         +}
>         +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_read);
>         +
>         +/*
>         + * virtio_pci_admin_legacy_io_notify_info - Read the queue notif=
ication
>         + * information for legacy interface
>         + * @dev: VF pci_dev
>         + * @req_bar_flags: requested bar flags
>         + * @bar: on output the BAR number of the member device
>         + * @bar_offset: on output the offset within bar
>         + *
>         + * Returns 0 on success, or negative on failure.
>         + */
>         +int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
>         +                                          u8 req_bar_flags, u8 *=
bar,
>         +                                          u64 *bar_offset)
>         +{
>         +       struct virtio_device *virtio_dev =3D virtio_pci_vf_get_pf=
_dev(pdev);
>         +       struct virtio_admin_cmd_notify_info_result *result;
>         +       struct virtio_admin_cmd cmd =3D {};
>         +       struct scatterlist result_sg;
>         +       int vf_id;
>         +       int ret;
>         +
>         +       if (!virtio_dev)
>         +               return -ENODEV;
>         +
>         +       vf_id =3D pci_iov_vf_id(pdev);
>         +       if (vf_id < 0)
>         +               return vf_id;
>         +
>         +       result =3D kzalloc(sizeof(*result), GFP_KERNEL);
>         +       if (!result)
>         +               return -ENOMEM;
>         +
>         +       sg_init_one(&result_sg, result, sizeof(*result));
>         +       cmd.opcode =3D cpu_to_le16(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY=
_INFO);
>         +       cmd.group_type =3D cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SR=
IOV);
>         +       cmd.group_member_id =3D cpu_to_le64(vf_id + 1);
>         +       cmd.result_sg =3D &result_sg;
>         +       ret =3D vp_modern_admin_cmd_exec(virtio_dev, &cmd);
>         +       if (!ret) {
>         +               struct virtio_admin_cmd_notify_info_data *entry;
>         +               int i;
>         +
>         +               ret =3D -ENOENT;
>         +               for (i =3D 0; i < VIRTIO_ADMIN_CMD_MAX_NOTIFY_INF=
O; i++) {
>         +                       entry =3D &result->entries[i];
>         +                       if (entry->flags =3D=3D VIRTIO_ADMIN_CMD_=
NOTIFY_INFO_FLAGS_END)
>         +                               break;
>         +                       if (entry->flags !=3D req_bar_flags)
>         +                               continue;
>         +                       *bar =3D entry->bar;
>         +                       *bar_offset =3D le64_to_cpu(entry->offset=
);
>         +                       ret =3D 0;
>         +                       break;
>         +               }
>         +       }
>         +
>         +       kfree(result);
>         +       return ret;
>         +}
>         +EXPORT_SYMBOL_GPL(virtio_pci_admin_legacy_io_notify_info);
>         +
>          static const struct virtio_config_ops virtio_pci_config_nodev_op=
s =3D {
>                 .get            =3D NULL,
>                 .set            =3D NULL,
>         diff --git a/include/linux/virtio_pci_admin.h b/include/linux/vir=
tio_pci_admin.h
>         new file mode 100644
>         index 000000000000..cb916a4bc1b1
>         --- /dev/null
>         +++ b/include/linux/virtio_pci_admin.h
>         @@ -0,0 +1,18 @@
>         +/* SPDX-License-Identifier: GPL-2.0 */
>         +#ifndef _LINUX_VIRTIO_PCI_ADMIN_H
>         +#define _LINUX_VIRTIO_PCI_ADMIN_H
>         +
>         +#include <linux/types.h>
>         +#include <linux/pci.h>
>         +
>         +int virtio_pci_admin_list_use(struct pci_dev *pdev, u8 *buf, int=
 buf_size);
>         +int virtio_pci_admin_list_query(struct pci_dev *pdev, u8 *buf, i=
nt buf_size);
>         +int virtio_pci_admin_legacy_io_write(struct pci_dev *pdev, u16 o=
pcode,
>         +                                    u8 offset, u8 size, u8 *buf);
>         +int virtio_pci_admin_legacy_io_read(struct pci_dev *pdev, u16 op=
code,
>         +                                   u8 offset, u8 size, u8 *buf);
>         +int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
>         +                                          u8 req_bar_flags, u8 *=
bar,
>         +                                          u64 *bar_offset);
>         +
>         +#endif /* _LINUX_VIRTIO_PCI_ADMIN_H */
>         --
>         2.27.0
> =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
