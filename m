Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C128AC433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 15:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 306A7404F8;
	Tue, 11 Jan 2022 15:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yWPgxfSvmN-x; Tue, 11 Jan 2022 15:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 484974012F;
	Tue, 11 Jan 2022 15:31:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B8E1C0030;
	Tue, 11 Jan 2022 15:31:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1A0C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46AA760B79
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63PuhLM1pLFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:31:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F14360625
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641915105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQMGMPEa7YZsLoUU3f9F5eNy5qiY5CwGVcDVlJqsops=;
 b=KbERCNyFKWiGurDfRsZVVP6JAfK0KRGM0L8I3mH7fUn5UZsIb/Q2A7WQZhD8fMq8stEmpQ
 gl9MbngBNZiaq+SmxkYGYJ/HmbLHMdHifn0i2rZ87bCG482hJ/i1qX5vLfNM9XmiFb0XlZ
 VLEn9tw7ekeqoBso5x2qiI2Zd60SRyU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-Wkd0Rz1BNoaH-dpDFn-tOQ-1; Tue, 11 Jan 2022 10:31:43 -0500
X-MC-Unique: Wkd0Rz1BNoaH-dpDFn-tOQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 az9-20020a05600c600900b0034692565ca8so1716002wmb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 07:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=aQMGMPEa7YZsLoUU3f9F5eNy5qiY5CwGVcDVlJqsops=;
 b=fDRYCM+Y3aZtEnX5B4rESHg5YpB8s/ff+WmBVFMteQtZ/CUplZdNTLlJJ4utlcqBE/
 Gj6k8LcdyoTeVazlRwZ2JWydaMir4WPBpuZMlD/H77uuM+yaprQUaQIGHZYrYXW8Q2Tn
 JaPaDvsunCOS2hPx5oUO3USB9rDg7ygMZrnQMnrcDRnyW3pajLwNOOcBBVixI8C24ctv
 1gNC3erSgE1O0d8rhCzkBU2Ze09Zeh3t8ONKOFNTcHFer+tuaFdcpKYmL5YpAhZV76p3
 MIU7KKIVLsb9nduZm9kiiX6qdB6rHEQRx/zgW8ics9scpR/0qTX396qm/UXZ++MBfqXi
 KtiQ==
X-Gm-Message-State: AOAM531pAbkjYbM7B0PdvkHLWTodCaLfq8GR0kq1VSPU0cKwlAHbdeHh
 ncn7TV3IijF0gGPMaw7mGH6YSYFbfDMki2ReMTIj6oWPJcbashKiJyc8/67yeWswQAbFPLsNSk9
 ltqRXyxrKgWkTkZ+SqpNC4DrqgFZlVeynsNG9+B5gOw==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr4362551wrn.147.1641915101869; 
 Tue, 11 Jan 2022 07:31:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKoL61zibh1oE3bHs8QiVu4i8ZXGEAHtdKPLI73bueW23SPIdx7Ehs1Y6bPhAANGU8VPbWCg==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr4362525wrn.147.1641915101526; 
 Tue, 11 Jan 2022 07:31:41 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id g12sm11065298wrd.71.2022.01.11.07.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 07:31:40 -0800 (PST)
Date: Tue, 11 Jan 2022 10:31:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v7 07/14] vdpa/mlx5: Support configuring max data virtqueue
Message-ID: <20220111102631-mutt-send-email-mst@kernel.org>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-8-elic@nvidia.com>
 <99150f0c-6814-a0cc-8640-aa8014af6ed0@oracle.com>
 <3205e802-a982-fbe2-511e-f5c28fc19b36@oracle.com>
 <20220109141023.GB70879@mtl-vdi-166.wap.labs.mlnx>
 <94048dc7-defa-2c7b-9350-540e8b9df227@oracle.com>
 <20220111073416.GB149570@mtl-vdi-166.wap.labs.mlnx>
 <06604e36-2ec3-95cd-ea1d-70516127bc58@oracle.com>
 <20220111152154.GA165838@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20220111152154.GA165838@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Tue, Jan 11, 2022 at 05:21:54PM +0200, Eli Cohen wrote:
> On Tue, Jan 11, 2022 at 12:52:29AM -0800, Si-Wei Liu wrote:
> > =

> > =

> > On 1/10/2022 11:34 PM, Eli Cohen wrote:
> > > On Mon, Jan 10, 2022 at 05:00:34PM -0800, Si-Wei Liu wrote:
> > > > =

> > > > On 1/9/2022 6:10 AM, Eli Cohen wrote:
> > > > > On Thu, Jan 06, 2022 at 05:50:24PM -0800, Si-Wei Liu wrote:
> > > > > > On 1/6/2022 5:27 PM, Si-Wei Liu wrote:
> > > > > > > On 1/5/2022 3:46 AM, Eli Cohen wrote:
> > > > > > > > Check whether the max number of data virtqueue pairs was pr=
ovided when a
> > > > > > > > adding a new device and verify the new value does not excee=
d device
> > > > > > > > capabilities.
> > > > > > > > =

> > > > > > > > In addition, change the arrays holding virtqueue and callba=
ck contexts
> > > > > > > > to be dynamically allocated.
> > > > > > > > =

> > > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > > ---
> > > > > > > > v6 -> v7:
> > > > > > > > 1. Evaluate RQT table size based on config.max_virtqueue_pa=
irs.
> > > > > > > > =

> > > > > > > >   =A0 drivers/vdpa/mlx5/net/mlx5_vnet.c | 51 ++++++++++++++=
++++++++---------
> > > > > > > >   =A0 1 file changed, 37 insertions(+), 14 deletions(-)
> > > > > > > > =

> > > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > index 4a2149f70f1e..d4720444bf78 100644
> > > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > > @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
> > > > > > > >   =A0=A0=A0=A0=A0 struct mlx5_vq_restore_info ri;
> > > > > > > >   =A0 };
> > > > > > > >   =A0 -/* We will remove this limitation once mlx5_vdpa_all=
oc_resources()
> > > > > > > > - * provides for driver space allocation
> > > > > > > > - */
> > > > > > > > -#define MLX5_MAX_SUPPORTED_VQS 16
> > > > > > > > -
> > > > > > > >   =A0 static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
> > > > > > > >   =A0 {
> > > > > > > >   =A0=A0=A0=A0=A0 if (unlikely(idx > mvdev->max_idx))
> > > > > > > > @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
> > > > > > > >   =A0=A0=A0=A0=A0 struct mlx5_vdpa_dev mvdev;
> > > > > > > >   =A0=A0=A0=A0=A0 struct mlx5_vdpa_net_resources res;
> > > > > > > >   =A0=A0=A0=A0=A0 struct virtio_net_config config;
> > > > > > > > -=A0=A0=A0 struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTE=
D_VQS];
> > > > > > > > -=A0=A0=A0 struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTE=
D_VQS + 1];
> > > > > > > > +=A0=A0=A0 struct mlx5_vdpa_virtqueue *vqs;
> > > > > > > > +=A0=A0=A0 struct vdpa_callback *event_cbs;
> > > > > > > >   =A0 =A0=A0=A0=A0=A0 /* Serialize vq resources creation an=
d destruction. This is
> > > > > > > > required
> > > > > > > >   =A0=A0=A0=A0=A0=A0 * since memory map might change and we=
 need to destroy and create
> > > > > > > > @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_v=
dpa_net
> > > > > > > > *ndev)
> > > > > > > >   =A0 {
> > > > > > > >   =A0=A0=A0=A0=A0 int i;
> > > > > > > >   =A0 -=A0=A0=A0 for (i =3D 0; i < MLX5_MAX_SUPPORTED_VQS; =
i++)
> > > > > > > > +=A0=A0=A0 for (i =3D 0; i < ndev->mvdev.max_vqs; i++)
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 suspend_vq(ndev, &ndev->vqs[i=
]);
> > > > > > > >   =A0 }
> > > > > > > >   =A0 @@ -1244,8 +1239,14 @@ static int create_rqt(struct m=
lx5_vdpa_net
> > > > > > > > *ndev)
> > > > > > > >   =A0=A0=A0=A0=A0 void *in;
> > > > > > > >   =A0=A0=A0=A0=A0 int i, j;
> > > > > > > >   =A0=A0=A0=A0=A0 int err;
> > > > > > > > +=A0=A0=A0 int num;
> > > > > > > >   =A0 -=A0=A0=A0 max_rqt =3D min_t(int, MLX5_MAX_SUPPORTED_=
VQS / 2,
> > > > > > > > +=A0=A0=A0 if (!(ndev->mvdev.actual_features & BIT_ULL(VIRT=
IO_NET_F_MQ)))
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 num =3D 1;
> > > > > > > > +=A0=A0=A0 else
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 num =3D le16_to_cpu(ndev->config.max=
_virtqueue_pairs);
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 max_rqt =3D min_t(int, roundup_pow_of_two(num),
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 << MLX5_CAP_GEN=
(ndev->mvdev.mdev, log_max_rqt_size));
> > > > > > > >   =A0=A0=A0=A0=A0 if (max_rqt < 1)
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
> > > > > > > > @@ -1262,7 +1263,7 @@ static int create_rqt(struct mlx5_vdp=
a_net *ndev)
> > > > > > > >   =A0=A0=A0=A0=A0 MLX5_SET(rqtc, rqtc, rqt_max_size, max_rq=
t);
> > > > > > > >   =A0=A0=A0=A0=A0 list =3D MLX5_ADDR_OF(rqtc, rqtc, rq_num[=
0]);
> > > > > > > >   =A0=A0=A0=A0=A0 for (i =3D 0, j =3D 0; i < max_rqt; i++, =
j +=3D 2)
> > > > > > > > -=A0=A0=A0=A0=A0=A0=A0 list[i] =3D cpu_to_be32(ndev->vqs[j %
> > > > > > > > ndev->mvdev.max_vqs].virtq_id);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 list[i] =3D cpu_to_be32(ndev->vqs[j =
% (2 * num)].virtq_id);
> > > > > > > Good catch. LGTM.
> > > > > > > =

> > > > > > > Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> > > > > > > =

> > > > > > Apologies to reply to myself. It looks to me we need to set cur=
_num_vqs to
> > > > > > the negotiated num of queues. Otherwise any site referencing cu=
r_num_vqs
> > > > > > won't work properly.
> > > > > You can't really use cur_num_vqs. Consider this scenario:
> > > > > create vdpa device with max VQs =3D 16 (RQT size created with 8 e=
ntries)
> > > > > boot VM
> > > > > ethtool modify num QPs to 2. cur_num_vqs now equals 2.
> > > > > reboot VM.
> > > > Once VM is rebooted, the cur_num_vqs has to reset to 0 in the reset=
() op.
> > > Why reset to 0? The correct value to set here is
> > > config->max_virtqueue_pairs.
> > I am not sure I get you, perhaps post a patch to show what you want to =
do?
> > If you intend to set to 2 (non-MQ) or 2 * max_virtqueue_pairs (MQ) late=
r in
> > create_rqt(), maybe it's not quite relevant whether or not to reset. Bu=
t in
> > the habit of keeping things consistent I'd prefer reset to a value to
> > reflect the fact that this field won't have a valid value until feature=
s are
> > negotiated. Whenever there's a need in future, this field can be easily
> > exposed to userspace.
> > =

> > >   This is what happens when you add the
> > > device.
> > This is not relevant, and doesn't matter. Essentially that line of code=
 to
> > set cur_num_vqs in vdpa_add can be removed. The value of cur_num_vqs wo=
n't
> > be effective before the MQ feature is negotiated, i.e. you don't get a
> > sensible cur_num_vqs value before the size of RQT is derived from the MQ
> > feature and the table gets created.
> > =

> > >   Setting cur_num_vqs to config->max_virtqueue_pairs will address
> > > your concerns with respect to modify_rqt. Once you reset cur_num_vqs =
to
> > > config->max_virtqueue_pairs your concerns with respect to changing
> > > mumber of QPs should be addressed.
> > No, it won't. If you look at the caller of change_num_qps(), in
> > handle_ctrl_mq() there's following code:
> > =

> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ndev->cur_num_vqs =3D=
=3D 2 * newqps) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
tatus =3D VIRTIO_NET_OK;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 b=
reak;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > =

> > So if you set cur_num_vqs to max_virtqueue_pairs while MQ is not negoti=
ated,
> > it will result in a very weird success for a non-MQ supporting driver t=
o be
> > able to change the number of queues without changing anything effective=
ly.
> > You may argue that we can fail the non-MQ case early before coming to t=
his
> > code. But this is another patch, and would make code more obscure, not =
less.
> > Intuitively people won't realize your cur_num_vqs doesn't apply to non-=
MQ
> > just by follow the name.
> > =

> > =

> > Regards,
> > -Siwei
> > =

> =

> Si-Wei:
> So your point is that you want to see cur_num_vqs 0 feature negotiated
> and other 2 for non MQ, and whatever configured through ethtool
> otherwise.
> =

> I can send a patch to address this concern of yours.
> =

> Quesiton is how we want to proceed here. I do want this series to get
> into 5.16. Should I send a new series or fixes on top of this? Also, it
> would be helpful if you could list all the changes you think should be
> made.
> =

> Michael: what do you think?

Fixes on top is best, including the Fixes tag.

Merge window is open, so
what's there right now should be pretty close to what goes into rc1.
If possible please send a patchset with all fixes so it's possible
to evaluate whether we are there or it has to be pushed out to 5.17 (hope n=
ot).
If there are cleanups we can push out to rc2 pls make that clear too.


> > =

> > >   We could even leave create_rqt
> > > untouched or modify the code to use cur_num_vqs. It should work the
> > > same.
> > > =

> > > > > create RQT with 1 entry only.
> > > > Here cur_num_vqs will be loaded with the newly negotiated value (ma=
x_rqt)
> > > > again.
> > > > =

> > > > > ethtool modify num QPs to 4. modify RQT will fail since it was cr=
eated
> > > > > with max QPs equals 1.
> > > > It won't fail as the cur_num_vqs will be consistent with the number=
 of
> > > > queues newly negotiated (i.e the max_rqt in create_rqt) for modify.
> > > > =

> > > > > I think it is ok to create the RQT always with the value configur=
ed when
> > > > > the device was created.
> > > > The problem of not setting cur_num_vqs in create_rqt (and resetting=
 it in
> > > > mlx5_vdpa_reset) is that, once the VM is rebooted or the device is =
reset,
> > > > the value doesn't go with the actual number of rqt entries hence wo=
uld break
> > > > various assumptions in change_num_qps() or modify_rqt(). For instan=
ces,
> > > > =

> > > > create vdpa device with max data VQs =3D 16
> > > > boot VM
> > > > features_ok set with MQ negotiated
> > > > RQT created with 8 entries in create_rqt
> > > > ethtool modify num QPs to 2. cur_num_vqs now equals 2.
> > > > reboot VM
> > > > features_ok set with MQ negotiated
> > > > RQT created with 8 entries in create_rqt
> > > > ethtool modify num QPs to 6.
> > > > cur_num_vqs was 2 while the actual RQT size is 8 (=3D 16 / 2)
> > > > change_num_qps would fail as the wrong increment branch (rather tha=
n the decrement) was taken
> > > > =

> > > > and this case too, which calls out the need to validate the presenc=
e of
> > > > VIRTIO_NET_F_MQ in handle_ctrl_mq()
> > > > =

> > > > create vdpa device with max data VQs =3D 16 (RQT size created with =
8 entries)
> > > > boot VM
> > > > features_ok set with MQ negotiated
> > > > RQT created with 8 entries in create_rqt
> > > > ethtool modify num QPs to 2. cur_num_vqs now equals 2.
> > > > reboot VM
> > > > features_ok set with no MQ negotiated
> > > > RQT created with 8 entries in create_rqt
> > > > ethtool modify num QPs to 6. suppose guest runs a custom kernel wit=
hout checking the #channels to configure
> > > > change_num_qps can succeed and no host side check prohibiting a sin=
gle queue guest to set multi-queue
> > > > =

> > > > Thanks,
> > > > -Siwei
> > > > > > Further, we need to validate VIRTIO_NET_F_MQ is present
> > > > > > in handle_ctrl_mq() before changing the number of queue pairs.
> > > > > > =

> > > > > > So just disregard my previous R-b for this patch.
> > > > > > =

> > > > > > Thanks,
> > > > > > -Siwei
> > > > > > =

> > > > > > =

> > > > > > > >   =A0 =A0=A0=A0=A0=A0 MLX5_SET(rqtc, rqtc, rqt_actual_size,=
 max_rqt);
> > > > > > > >   =A0=A0=A0=A0=A0 err =3D mlx5_vdpa_create_rqt(&ndev->mvdev=
, in, inlen,
> > > > > > > > &ndev->res.rqtn);
> > > > > > > > @@ -2220,7 +2221,7 @@ static int mlx5_vdpa_reset(struct vdp=
a_device
> > > > > > > > *vdev)
> > > > > > > >   =A0=A0=A0=A0=A0 clear_vqs_ready(ndev);
> > > > > > > >   =A0=A0=A0=A0=A0 mlx5_vdpa_destroy_mr(&ndev->mvdev);
> > > > > > > >   =A0=A0=A0=A0=A0 ndev->mvdev.status =3D 0;
> > > > > > > > -=A0=A0=A0 memset(ndev->event_cbs, 0, sizeof(ndev->event_cb=
s));
> > > > > > > > +=A0=A0=A0 memset(ndev->event_cbs, 0, sizeof(*ndev->event_c=
bs) *
> > > > > > > > (mvdev->max_vqs + 1));
> > > > > > > >   =A0=A0=A0=A0=A0 ndev->mvdev.actual_features =3D 0;
> > > > > > > >   =A0=A0=A0=A0=A0 ++mvdev->generation;
> > > > > > > >   =A0=A0=A0=A0=A0 if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)=
) {
> > > > > > > > @@ -2293,6 +2294,8 @@ static void mlx5_vdpa_free(struct vdp=
a_device
> > > > > > > > *vdev)
> > > > > > > >   =A0=A0=A0=A0=A0 }
> > > > > > > >   =A0=A0=A0=A0=A0 mlx5_vdpa_free_resources(&ndev->mvdev);
> > > > > > > >   =A0=A0=A0=A0=A0 mutex_destroy(&ndev->reslock);
> > > > > > > > +=A0=A0=A0 kfree(ndev->event_cbs);
> > > > > > > > +=A0=A0=A0 kfree(ndev->vqs);
> > > > > > > >   =A0 }
> > > > > > > >   =A0 =A0 static struct vdpa_notification_area
> > > > > > > > mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> > > > > > > > @@ -2538,15 +2541,33 @@ static int mlx5_vdpa_dev_add(struct
> > > > > > > > vdpa_mgmt_dev *v_mdev, const char *name,
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
> > > > > > > >   =A0=A0=A0=A0=A0 }
> > > > > > > >   =A0 -=A0=A0=A0 /* we save one virtqueue for control virtq=
ueue should we
> > > > > > > > require it */
> > > > > > > >   =A0=A0=A0=A0=A0 max_vqs =3D MLX5_CAP_DEV_VDPA_EMULATION(m=
dev,
> > > > > > > > max_num_virtio_queues);
> > > > > > > > -=A0=A0=A0 max_vqs =3D min_t(u32, max_vqs, MLX5_MAX_SUPPORT=
ED_VQS);
> > > > > > > > +=A0=A0=A0 if (max_vqs < 2) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dev_warn(mdev->device,
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "%d virtqueues are su=
pported. At least 2 are required\n",
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_vqs);
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 return -EAGAIN;
> > > > > > > > +=A0=A0=A0 }
> > > > > > > > +
> > > > > > > > +=A0=A0=A0 if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET=
_CFG_MAX_VQP)) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (add_config->net.max_vq_pairs > m=
ax_vqs / 2)
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 max_vqs =3D min_t(u32, max_vqs, 2 *
> > > > > > > > add_config->net.max_vq_pairs);
> > > > > > > > +=A0=A0=A0 } else {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 max_vqs =3D 2;
> > > > > > > > +=A0=A0=A0 }
> > > > > > > >   =A0 =A0=A0=A0=A0=A0 ndev =3D vdpa_alloc_device(struct mlx=
5_vdpa_net, mvdev.vdev,
> > > > > > > > mdev->device, &mlx5_vdpa_ops,
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 na=
me, false);
> > > > > > > >   =A0=A0=A0=A0=A0 if (IS_ERR(ndev))
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(ndev);
> > > > > > > >   =A0 +=A0=A0=A0 ndev->vqs =3D kcalloc(max_vqs, sizeof(*nde=
v->vqs), GFP_KERNEL);
> > > > > > > > +=A0=A0=A0 ndev->event_cbs =3D kcalloc(max_vqs + 1,
> > > > > > > > sizeof(*ndev->event_cbs), GFP_KERNEL);
> > > > > > > > +=A0=A0=A0 if (!ndev->vqs || !ndev->event_cbs) {
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 err =3D -ENOMEM;
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 goto err_alloc;
> > > > > > > > +=A0=A0=A0 }
> > > > > > > >   =A0=A0=A0=A0=A0 ndev->mvdev.max_vqs =3D max_vqs;
> > > > > > > >   =A0=A0=A0=A0=A0 mvdev =3D &ndev->mvdev;
> > > > > > > >   =A0=A0=A0=A0=A0 mvdev->mdev =3D mdev;
> > > > > > > > @@ -2627,6 +2648,7 @@ static int mlx5_vdpa_dev_add(struct
> > > > > > > > vdpa_mgmt_dev *v_mdev, const char *name,
> > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0 mlx5_mpfs_del_mac(pfmdev, con=
fig->mac);
> > > > > > > >   =A0 err_mtu:
> > > > > > > >   =A0=A0=A0=A0=A0 mutex_destroy(&ndev->reslock);
> > > > > > > > +err_alloc:
> > > > > > > >   =A0=A0=A0=A0=A0 put_device(&mvdev->vdev.dev);
> > > > > > > >   =A0=A0=A0=A0=A0 return err;
> > > > > > > >   =A0 }
> > > > > > > > @@ -2669,7 +2691,8 @@ static int mlx5v_probe(struct auxilia=
ry_device
> > > > > > > > *adev,
> > > > > > > >   =A0=A0=A0=A0=A0 mgtdev->mgtdev.ops =3D &mdev_ops;
> > > > > > > >   =A0=A0=A0=A0=A0 mgtdev->mgtdev.device =3D mdev->device;
> > > > > > > >   =A0=A0=A0=A0=A0 mgtdev->mgtdev.id_table =3D id_table;
> > > > > > > > -=A0=A0=A0 mgtdev->mgtdev.config_attr_mask =3D
> > > > > > > > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > > > > > > > +=A0=A0=A0 mgtdev->mgtdev.config_attr_mask =3D
> > > > > > > > BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> > > > > > > >   =A0=A0=A0=A0=A0 mgtdev->madev =3D madev;
> > > > > > > >   =A0 =A0=A0=A0=A0=A0 err =3D vdpa_mgmtdev_register(&mgtdev=
->mgtdev);
> > =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
