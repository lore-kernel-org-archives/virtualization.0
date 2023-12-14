Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AAF433C1
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvbgRHrt"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B0DF83D01
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 18:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B0DF83D01
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvbgRHrt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRqp1YHqW9DQ
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 18:31:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E22483CEA
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 18:31:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E22483CEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702578683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iO9Z5bH3UoawNv41qnNm90edN2DQtPwUydpbqgWOOQg=;
	b=JvbgRHrt9tXA80jTsVzLGRcupWQtb7uT/pHY60XHtaP2DPRjVjhg+iSoUg6xyPuZgzepM9
	LZxFrD71bPtp1geHLogrVJ5ryz+ma8olUyyaZpBjTPYEAaVgLLjpc8WhkeiajMEQAdoXc7
	ZwoaORDobP16Pd0RB2o0yUr2/qHE9KU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-FzxcuFlaPjKf3whHGvuexw-1; Thu, 14 Dec 2023 13:31:22 -0500
X-MC-Unique: FzxcuFlaPjKf3whHGvuexw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d9a541b720aso9006332276.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578681; x=1703183481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO9Z5bH3UoawNv41qnNm90edN2DQtPwUydpbqgWOOQg=;
        b=iozJDPqJpxtsU3/uVGJ6VaZMDB5ZEwYF/53Dkve3hnb1YGgMCoPIgHVEGavgqLlm4I
         fraAMm3dMryRuOb2ePtvvJt+s+lKk7yZTwS0KC1+IRJlOMomj+Zu4IK5OxJ5qzCijJKW
         Wby3S73jbA73Yuwawvk660plxdB95yLCep0g53OcMXGKAm8fIbVOlIh6aYTcUmuIjdFJ
         FgHX/M6FpdKaW5/kNwXOxyXLDXGIgmkiwhYxaMK+X7celLNfq7VOOYh5M157PM0W2XZ6
         zmrZ13Ti1OxrdsfJIF1QHRVHHpQ7MSKpjdIG6Hx3IzHEpLPxRUsH/6+ODDNmwJpai/t3
         I1Mw==
X-Gm-Message-State: AOJu0YzL3Rlnb/RCDOIXV9FzESssrG5stiH1Om/tWBrdSsAexW6Zx0dG
	sskwU4u8AgIR951zqwjqSj1PD7M3ghXwnhmOoH7ACjCuYwK1FagIBY1OKdlQOWavjOuJqHW+ivI
	A8f0Zf+WnBKraWSQUmvi9oNeSb/UKD0jL4t0wtR9f2WVH/OzJc8NAW/bmyg==
X-Received: by 2002:a5b:683:0:b0:dbc:c0bf:3484 with SMTP id j3-20020a5b0683000000b00dbcc0bf3484mr3086001ybq.96.1702578681326;
        Thu, 14 Dec 2023 10:31:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERAJfkzeOqw68wFJBpzHz7S6oso9Uir2zMFtVFe79pxYdFBmx6eqBTVqGzZ0NwkOrMyG1o4V0VpfQKL5CXxME=
X-Received: by 2002:a5b:683:0:b0:dbc:c0bf:3484 with SMTP id
 j3-20020a5b0683000000b00dbcc0bf3484mr3085985ybq.96.1702578680983; Thu, 14 Dec
 2023 10:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231205104609.876194-1-dtatulea@nvidia.com> <20231205104609.876194-5-dtatulea@nvidia.com>
 <CAJaqyWeEY9LNTE8QEnJgLhgS7HiXr5gJEwwPBrC3RRBsAE4_7Q@mail.gmail.com>
 <27312106-07b9-4719-970c-b8e1aed7c4eb@oracle.com> <075cf7d1ada0ee4ee30d46b993a1fe21acfe9d92.camel@nvidia.com>
 <20231214084526-mutt-send-email-mst@kernel.org> <9a6465a3d6c8fde63643fbbdde60d5dd84b921d4.camel@nvidia.com>
In-Reply-To: <9a6465a3d6c8fde63643fbbdde60d5dd84b921d4.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Dec 2023 19:30:44 +0100
Message-ID: <CAJaqyWfF9eVehQ+wutMDdwYToMq=G1+War_7wANmnyuONj=18g@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/8] vdpa/mlx5: Mark vq addrs for modification in
 hw vq
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	"leon@kernel.org" <leon@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 4:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, 2023-12-14 at 08:45 -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 14, 2023 at 01:39:55PM +0000, Dragos Tatulea wrote:
> > > On Tue, 2023-12-12 at 15:44 -0800, Si-Wei Liu wrote:
> > > >
> > > > On 12/12/2023 11:21 AM, Eugenio Perez Martin wrote:
> > > > > On Tue, Dec 5, 2023 at 11:46=E2=80=AFAM Dragos Tatulea <dtatulea@=
nvidia.com> wrote:
> > > > > > Addresses get set by .set_vq_address. hw vq addresses will be u=
pdated on
> > > > > > next modify_virtqueue.
> > > > > >
> > > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > I'm kind of ok with this patch and the next one about state, but =
I
> > > > > didn't ack them in the previous series.
> > > > >
> > > > > My main concern is that it is not valid to change the vq address =
after
> > > > > DRIVER_OK in VirtIO, which vDPA follows. Only memory maps are ok =
to
> > > > > change at this moment. I'm not sure about vq state in vDPA, but v=
host
> > > > > forbids changing it with an active backend.
> > > > >
> > > > > Suspend is not defined in VirtIO at this moment though, so maybe =
it is
> > > > > ok to decide that all of these parameters may change during suspe=
nd.
> > > > > Maybe the best thing is to protect this with a vDPA feature flag.
> > > > I think protect with vDPA feature flag could work, while on the oth=
er
> > > > hand vDPA means vendor specific optimization is possible around sus=
pend
> > > > and resume (in case it helps performance), which doesn't have to be
> > > > backed by virtio spec. Same applies to vhost user backend features,
> > > > variations there were not backed by spec either. Of course, we shou=
ld
> > > > try best to make the default behavior backward compatible with
> > > > virtio-based backend, but that circles back to no suspend definitio=
n in
> > > > the current virtio spec, for which I hope we don't cease developmen=
t on
> > > > vDPA indefinitely. After all, the virtio based vdap backend can wel=
l
> > > > define its own feature flag to describe (minor difference in) the
> > > > suspend behavior based on the later spec once it is formed in futur=
e.
> > > >
> > > So what is the way forward here? From what I understand the options a=
re:
> > >
> > > 1) Add a vdpa feature flag for changing device properties while suspe=
nded.
> > >
> > > 2) Drop these 2 patches from the series for now. Not sure if this mak=
es sense as
> > > this. But then Si-Wei's qemu device suspend/resume poc [0] that exerc=
ises this
> > > code won't work anymore. This means the series would be less well tes=
ted.
> > >
> > > Are there other possible options? What do you think?
> > >
> > > [0] https://github.com/siwliu-kernel/qemu/tree/svq-resume-wip
> >
> > I am fine with either of these.
> >
> How about allowing the change only under the following conditions:
>   vhost_vdpa_can_suspend && vhost_vdpa_can_resume &&
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is set
>
> ?

I think the best option by far is 1, as there is no hint in the
combination of these 3 indicating that you can change device
properties in the suspended state.

>
> Thanks,
> Dragos
>
> > > Thanks,
> > > Dragos
> > >
> > > > Regards,
> > > > -Siwei
> > > >
> > > >
> > > >
> > > > >
> > > > > Jason, what do you think?
> > > > >
> > > > > Thanks!
> > > > >
> > > > > > ---
> > > > > >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 9 +++++++++
> > > > > >   include/linux/mlx5/mlx5_ifc_vdpa.h | 1 +
> > > > > >   2 files changed, 10 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/m=
lx5/net/mlx5_vnet.c
> > > > > > index f8f088cced50..80e066de0866 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -1209,6 +1209,7 @@ static int modify_virtqueue(struct mlx5_v=
dpa_net *ndev,
> > > > > >          bool state_change =3D false;
> > > > > >          void *obj_context;
> > > > > >          void *cmd_hdr;
> > > > > > +       void *vq_ctx;
> > > > > >          void *in;
> > > > > >          int err;
> > > > > >
> > > > > > @@ -1230,6 +1231,7 @@ static int modify_virtqueue(struct mlx5_v=
dpa_net *ndev,
> > > > > >          MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->m=
vdev.res.uid);
> > > > > >
> > > > > >          obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q_in, i=
n, obj_context);
> > > > > > +       vq_ctx =3D MLX5_ADDR_OF(virtio_net_q_object, obj_contex=
t, virtio_q_context);
> > > > > >
> > > > > >          if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STAT=
E) {
> > > > > >                  if (!is_valid_state_change(mvq->fw_state, stat=
e, is_resumable(ndev))) {
> > > > > > @@ -1241,6 +1243,12 @@ static int modify_virtqueue(struct mlx5_=
vdpa_net *ndev,
> > > > > >                  state_change =3D true;
> > > > > >          }
> > > > > >
> > > > > > +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTI=
O_Q_ADDRS) {
> > > > > > +               MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->de=
sc_addr);
> > > > > > +               MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->de=
vice_addr);
> > > > > > +               MLX5_SET64(virtio_q, vq_ctx, available_addr, mv=
q->driver_addr);
> > > > > > +       }
> > > > > > +
> > > > > >          MLX5_SET64(virtio_net_q_object, obj_context, modify_fi=
eld_select, mvq->modified_fields);
> > > > > >          err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out=
, sizeof(out));
> > > > > >          if (err)
> > > > > > @@ -2202,6 +2210,7 @@ static int mlx5_vdpa_set_vq_address(struc=
t vdpa_device *vdev, u16 idx, u64 desc_
> > > > > >          mvq->desc_addr =3D desc_area;
> > > > > >          mvq->device_addr =3D device_area;
> > > > > >          mvq->driver_addr =3D driver_area;
> > > > > > +       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_VIRTIO=
_Q_ADDRS;
> > > > > >          return 0;
> > > > > >   }
> > > > > >
> > > > > > diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux=
/mlx5/mlx5_ifc_vdpa.h
> > > > > > index b86d51a855f6..9594ac405740 100644
> > > > > > --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > > +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> > > > > > @@ -145,6 +145,7 @@ enum {
> > > > > >          MLX5_VIRTQ_MODIFY_MASK_STATE                    =3D (u=
64)1 << 0,
> > > > > >          MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =3D (u=
64)1 << 3,
> > > > > >          MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =3D (u=
64)1 << 4,
> > > > > > +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           =3D (u6=
4)1 << 6,
> > > > > >          MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u=
64)1 << 14,
> > > > > >   };
> > > > > >
> > > > > > --
> > > > > > 2.42.0
> > > > > >
> > > >
> > >
> >
>

