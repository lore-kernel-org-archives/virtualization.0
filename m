Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1DC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 23:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83135821AC;
	Mon, 30 Oct 2023 23:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83135821AC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hpoNvwaX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNR-kZNIwoOO; Mon, 30 Oct 2023 23:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0DC781F61;
	Mon, 30 Oct 2023 23:30:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0DC781F61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92561C0071;
	Mon, 30 Oct 2023 23:30:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D10CAC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98A2B8219B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98A2B8219B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AjvTYNOxxFE4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:30:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97D6C8217F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 23:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97D6C8217F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698708648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRvzCP5v+vCa5V8gkjAmVzBD6PvXRbnm4WTXIRTATIs=;
 b=hpoNvwaX98C6GmS4BF5F/pbdJefQOL8akmkw3HaozTzwWZoeEcyJjY45ocqUDllqGRlzQ7
 w7jjJpvN60StP/hScpuYOCVqW1Xu2jb+y/r1VqG2baxdbNXClkDBaakGpHW7ijhKcIL3Ms
 6HeJBuDTx5FLwCdeessPvPebo4Jcj+Y=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-W-wCf-4yOWuU1ZOGfS3VfQ-1; Mon, 30 Oct 2023 19:30:27 -0400
X-MC-Unique: W-wCf-4yOWuU1ZOGfS3VfQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5b99999614bso989820a12.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 16:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698708626; x=1699313426;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uRvzCP5v+vCa5V8gkjAmVzBD6PvXRbnm4WTXIRTATIs=;
 b=LNa3SawSlIfpzyPnzM4l/8C++nhiK0DiLnifDH0gptOuHufk6d0Tson+0Qr1D7DIu2
 7RZq26nJmL6vE/y9+w4PN4/9ue97vEgunYiWwnq5KyheyxA4iItLepAOX6SuHaVToeEo
 0XIvJ4cr54aan+O4qJK/7hfovVRA6TI0RH1oLkZLLLcpXAixICZypuCwL7z1he2cqPaV
 D4u9kqXnWUBHBgaksI178UVEQFMyekYLKJgU6BApX6qwT+MYyFc0rNZaXg4zEY/lkiaP
 ptUw/jyUZ1isL9UjoyVbCAQQUBSkjFT+Ns8xmhBM5NyxZY29tSh7+HgElT/FBACLxRf1
 4Jsg==
X-Gm-Message-State: AOJu0Yzqh5m3bmC2AbY/TeIBOebj+YDUPR9EV7gDVnO7NuhFZnOrq8/C
 hLW96CgUK3cmeZUMR2/u1yO2fwOvAJvVFmS/yNzWxusEDbREl4g7QXq56Mf04HT78Xwf01HxXcm
 TXT5WQ5ergvl0ZnVFr5W01YJwF0AXAcofs2ubtKUhhg==
X-Received: by 2002:a05:6a20:7aa7:b0:180:de1d:b93e with SMTP id
 u39-20020a056a207aa700b00180de1db93emr1004744pzh.28.1698708626187; 
 Mon, 30 Oct 2023 16:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsyQY2FR+nrJRYkcGbF92lyOCd/oNKEiPa6M1r7mJZv2Cfk0Q+P8eru6uiHM6p/3PJ7tw9Sw==
X-Received: by 2002:a05:6a20:7aa7:b0:180:de1d:b93e with SMTP id
 u39-20020a056a207aa700b00180de1db93emr1004723pzh.28.1698708625843; 
 Mon, 30 Oct 2023 16:30:25 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 e23-20020aa78c57000000b00690fe1c928csm60842pfd.147.2023.10.30.16.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 16:30:25 -0700 (PDT)
Date: Mon, 30 Oct 2023 19:30:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin
 commands
Message-ID: <20231030192904-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-6-yishaih@nvidia.com>
 <20231029160750-mutt-send-email-mst@kernel.org>
 <bb8df2c8-74b5-4666-beda-550248a88890@nvidia.com>
 <20231030115541-mutt-send-email-mst@kernel.org>
 <4e95d66c-c382-4612-8d4b-7ff2b0acd3fb@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <4e95d66c-c382-4612-8d4b-7ff2b0acd3fb@nvidia.com>
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

On Mon, Oct 30, 2023 at 06:06:45PM +0200, Yishai Hadas wrote:
> On 30/10/2023 17:57, Michael S. Tsirkin wrote:
> > On Mon, Oct 30, 2023 at 05:27:50PM +0200, Yishai Hadas wrote:
> > > On 29/10/2023 22:17, Michael S. Tsirkin wrote:
> > > > On Sun, Oct 29, 2023 at 05:59:48PM +0200, Yishai Hadas wrote:
> > > > > Initialize the supported admin commands upon activating the admin=
 queue.
> > > > > =

> > > > > The supported commands are saved as part of the admin queue conte=
xt, it
> > > > > will be used by the next patches from this series.
> > > > > =

> > > > > Note:
> > > > > As we don't want to let upper layers to execute admin commands be=
fore
> > > > > that this initialization step was completed, we set ref count to =
1 only
> > > > > post of that flow and use a non ref counted version command for t=
his
> > > > > internal flow.
> > > > > =

> > > > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > > > ---
> > > > >    drivers/virtio/virtio_pci_common.h |  1 +
> > > > >    drivers/virtio/virtio_pci_modern.c | 77 ++++++++++++++++++++++=
+++++++-
> > > > >    2 files changed, 77 insertions(+), 1 deletion(-)
> > > > > =

> > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/=
virtio_pci_common.h
> > > > > index a21b9ba01a60..9e07e556a51a 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > @@ -46,6 +46,7 @@ struct virtio_pci_admin_vq {
> > > > >    	struct virtio_pci_vq_info info;
> > > > >    	struct completion flush_done;
> > > > >    	refcount_t refcount;
> > > > > +	u64 supported_cmds;
> > > > >    	/* Name of the admin queue: avq.$index. */
> > > > >    	char name[10];
> > > > >    	u16 vq_index;
> > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/=
virtio_pci_modern.c
> > > > > index ccd7a4d9f57f..25e27aa79cab 100644
> > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > @@ -19,6 +19,9 @@
> > > > >    #define VIRTIO_RING_NO_LEGACY
> > > > >    #include "virtio_pci_common.h"
> > > > > +static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> > > > > +				    struct virtio_admin_cmd *cmd);
> > > > > +
> > > > I don't much like forward declarations. Just order functions sensib=
ly
> > > > and they will not be needed.
> > > OK, will be part of V3.
> > > =

> > > > >    static u64 vp_get_features(struct virtio_device *vdev)
> > > > >    {
> > > > >    	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> > > > > @@ -59,6 +62,42 @@ vp_modern_avq_set_abort(struct virtio_pci_admi=
n_vq *admin_vq, bool abort)
> > > > >    	WRITE_ONCE(admin_vq->abort, abort);
> > > > >    }
> > > > > +static void virtio_pci_admin_init_cmd_list(struct virtio_device =
*virtio_dev)
> > > > > +{
> > > > > +	struct virtio_pci_device *vp_dev =3D to_vp_device(virtio_dev);
> > > > > +	struct virtio_admin_cmd cmd =3D {};
> > > > > +	struct scatterlist result_sg;
> > > > > +	struct scatterlist data_sg;
> > > > > +	__le64 *data;
> > > > > +	int ret;
> > > > > +
> > > > > +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> > > > > +	if (!data)
> > > > > +		return;
> > > > > +
> > > > > +	sg_init_one(&result_sg, data, sizeof(*data));
> > > > > +	cmd.opcode =3D cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
> > > > > +	cmd.group_type =3D cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> > > > > +	cmd.result_sg =3D &result_sg;
> > > > > +
> > > > > +	ret =3D vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> > > > > +	if (ret)
> > > > > +		goto end;
> > > > > +
> > > > > +	sg_init_one(&data_sg, data, sizeof(*data));
> > > > > +	cmd.opcode =3D cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
> > > > > +	cmd.data_sg =3D &data_sg;
> > > > > +	cmd.result_sg =3D NULL;
> > > > > +
> > > > > +	ret =3D vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> > > > > +	if (ret)
> > > > > +		goto end;
> > > > > +
> > > > > +	vp_dev->admin_vq.supported_cmds =3D le64_to_cpu(*data);
> > > > > +end:
> > > > > +	kfree(data);
> > > > > +}
> > > > > +
> > > > >    static void vp_modern_avq_activate(struct virtio_device *vdev)
> > > > >    {
> > > > >    	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> > > > > @@ -67,6 +106,7 @@ static void vp_modern_avq_activate(struct virt=
io_device *vdev)
> > > > >    	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> > > > >    		return;
> > > > > +	virtio_pci_admin_init_cmd_list(vdev);
> > > > >    	init_completion(&admin_vq->flush_done);
> > > > >    	refcount_set(&admin_vq->refcount, 1);
> > > > >    	vp_modern_avq_set_abort(admin_vq, false);
> > > > > @@ -562,6 +602,35 @@ static bool vp_get_shm_region(struct virtio_=
device *vdev,
> > > > >    	return true;
> > > > >    }
> > > > > +static int __virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq=
 *admin_vq,
> > > > > +				    struct scatterlist **sgs,
> > > > > +				    unsigned int out_num,
> > > > > +				    unsigned int in_num,
> > > > > +				    void *data,
> > > > > +				    gfp_t gfp)
> > > > > +{
> > > > > +	struct virtqueue *vq;
> > > > > +	int ret, len;
> > > > > +
> > > > > +	vq =3D admin_vq->info.vq;
> > > > > +
> > > > > +	ret =3D virtqueue_add_sgs(vq, sgs, out_num, in_num, data, gfp);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	if (unlikely(!virtqueue_kick(vq)))
> > > > > +		return -EIO;
> > > > > +
> > > > > +	while (!virtqueue_get_buf(vq, &len) &&
> > > > > +	       !virtqueue_is_broken(vq))
> > > > > +		cpu_relax();
> > > > > +
> > > > > +	if (virtqueue_is_broken(vq))
> > > > > +		return -EIO;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > This is tolerable I guess but it might pin the CPU for a long time.
> > > > The difficulty is handling suprize removal well which we currently
> > > > don't do with interrupts. I would say it's ok as is but add
> > > > a TODO comments along the lines of /* TODO: use interrupts once the=
se virtqueue_is_broken */
> > > I assume that you asked for adding the below comment before the while=
 loop:
> > > /* TODO use interrupts to reduce cpu cycles in the future */
> > > =

> > > Right ?
> > > =

> > > Yishai
> > Well I wrote what I meant. in the future is redundant - everyone knows
> > we can't change the past.
> =

> I agree, no need for 'in the future'.
> =

> However, in your suggestion you mentioned=A0 "once these virtqueue_is_bro=
ken".
> =

> What does that mean in current polling mode ?
> =

> Yishai

Maye better: /* TODO: use vq callback once it supports virtqueue_is_broken =
*/

> > =

> > > > >    static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq=
 *admin_vq,
> > > > >    				    struct scatterlist **sgs,
> > > > >    				    unsigned int out_num,
> > > > > @@ -653,7 +722,13 @@ static int vp_modern_admin_cmd_exec(struct v=
irtio_device *vdev,
> > > > >    		in_num++;
> > > > >    	}
> > > > > -	ret =3D virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> > > > > +	if (cmd->opcode =3D=3D VIRTIO_ADMIN_CMD_LIST_QUERY ||
> > > > > +	    cmd->opcode =3D=3D VIRTIO_ADMIN_CMD_LIST_USE)
> > > > > +		ret =3D __virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> > > > > +				       out_num, in_num,
> > > > > +				       sgs, GFP_KERNEL);
> > > > > +	else
> > > > > +		ret =3D virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> > > > >    				       out_num, in_num,
> > > > >    				       sgs, GFP_KERNEL);
> > > > >    	if (ret) {
> > > > > -- =

> > > > > 2.27.0
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
