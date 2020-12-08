Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DDC4167B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 07:34:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFC323A69
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 07:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFC323A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0B0087AF9;
	Tue,  8 Dec 2020 07:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pH3VRsRpOLgC; Tue,  8 Dec 2020 07:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28F8D87A19;
	Tue,  8 Dec 2020 07:34:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 068DEC0893;
	Tue,  8 Dec 2020 07:34:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 373E4C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D24220445
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GOXPqvsAmhax
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 1AC1B20444
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:34:50 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id a16so23245323ejj.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KDNQai3ANvzHnuzmpGlNQLHSGL47jHO8xbQVoARcp+Y=;
 b=Ql2AB5GySJ65IFMHnw4MwFF+6A1fSxUbm0S/QCOsRh1e9K/RdvI9O9Yt/4u9lp/8zU
 WXpOxpcxkqc0ECWU/gBhCpde+JT2de7S+dnMJ/ThfJ2V2LjxOF40eH+xPBzu+Q/qIrx+
 IwJMliL/zNWO3P9FiZ3xRymHceBHcF2+A/XrgHm9IFQRlZCouH6KOsfRn0s5kND6IZsW
 ogcY6Q8BQynWXyWAzonWHDSrCT8Sypi5HvX/2Vh7p2n6UQ6hmXMEakUREVC0a87Bb0xI
 dc7Jx8nAnn6wruao79UPpFzmcbZp7kLhkcFlYOKujv5rwvsUxw/3IHEMFG9ts7W0/Zd7
 gtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KDNQai3ANvzHnuzmpGlNQLHSGL47jHO8xbQVoARcp+Y=;
 b=UxBt7d8DGIzelatzghLROjQkgQsm+jkwo0VGUjIi1CvN5q6bnul2vubLkrXB4O+07g
 G8nME+EdtkLI9hhiK49wzTTjwE3/xByaCvT31ThjHJoQ8hK9lbYZq1/KNPUY34fLMaWI
 Rd8odX6HbE69nqFQCTqp+l0R6kPG0/GVz8dpAoihAgjPtN1BOVYcifNuQcv6DrTm3xzr
 BLJt6gK1zYJXs1MNiAlU6Jb2uft+0NQ63+PdgJcHaPSWGZC7Y6l7tRj4gQeRaQD5C33d
 +c90H1YTU7EDDgqoldBPz4tSrPLON1CkezWQ6aGWi9oFkeOQvpTppmIuxgCh8WnHKLz0
 Ykhg==
X-Gm-Message-State: AOAM5336rgR7oDDaoh0xx3rck+zzMP8sPW2GwJuXvUN4eobrduq4TqlZ
 W302zOpGqP/bSP+SyzS9/zc=
X-Google-Smtp-Source: ABdhPJyAJ58CckXILtlZ1T1LSuVkaaFCXE8XFbVwePtP2qOXF2umzTx1ojn2UCAcCz94h+QkAZmFtg==
X-Received: by 2002:a17:907:444f:: with SMTP id
 on23mr22557982ejb.300.1607412888472; 
 Mon, 07 Dec 2020 23:34:48 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id mb15sm14605264ejb.9.2020.12.07.23.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 23:34:47 -0800 (PST)
Date: Tue, 8 Dec 2020 07:34:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 09/27] vhost: Route host->guest notification through
 qemu
Message-ID: <20201208073446.GP203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-10-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-10-eperezma@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============5318714924304962202=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5318714924304962202==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CKf/2jVYos1l2hij"
Content-Disposition: inline


--CKf/2jVYos1l2hij
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:47PM +0100, Eugenio P=E9rez wrote:
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-sw-lm-ring.c |  3 +++
>  hw/virtio/vhost.c            | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)

I'm not sure I understand what is going here. The guest notifier masking
feature exists to support MSI masking semantics. It looks like this
patch repurposes the notifier to decouple the vhost hdev from the virtio
device's irqfd? But this breaks MSI masking. I think you need to set up
your own eventfd and assign it to the vhost hdev's call fd instead of
using the mask notifier.

>=20
> diff --git a/hw/virtio/vhost-sw-lm-ring.c b/hw/virtio/vhost-sw-lm-ring.c
> index 0192e77831..cbf53965cd 100644
> --- a/hw/virtio/vhost-sw-lm-ring.c
> +++ b/hw/virtio/vhost-sw-lm-ring.c
> @@ -50,6 +50,9 @@ VhostShadowVirtqueue *vhost_sw_lm_shadow_vq(struct vhos=
t_dev *dev, int idx)
>      r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
>      assert(r =3D=3D 0);
> =20
> +    vhost_virtqueue_mask(dev, dev->vdev, idx, true);
> +    vhost_virtqueue_pending(dev, idx);

Why is the mask notifier cleared? Could we lose a guest notification
here?

> +
>      return svq;
>  }
> =20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1d55e26d45..9352c56bfa 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -960,12 +960,29 @@ static void handle_sw_lm_vq(VirtIODevice *vdev, Vir=
tQueue *vq)
>      vhost_vring_kick(svq);
>  }
> =20
> +static void vhost_handle_call(EventNotifier *n)
> +{
> +    struct vhost_virtqueue *hvq =3D container_of(n,
> +                                              struct vhost_virtqueue,
> +                                              masked_notifier);
> +    struct vhost_dev *vdev =3D hvq->dev;
> +    int idx =3D vdev->vq_index + (hvq =3D=3D &vdev->vqs[0] ? 0 : 1);

vhost-net-specific hack

> +    VirtQueue *vq =3D virtio_get_queue(vdev->vdev, idx);
> +
> +    if (event_notifier_test_and_clear(n)) {
> +        virtio_queue_invalidate_signalled_used(vdev->vdev, idx);
> +        virtio_notify_irqfd(vdev->vdev, vq);

/* TODO push used elements into vq? */

--CKf/2jVYos1l2hij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PLJYACgkQnKSrs4Gr
c8j+8gf+OhTHgPK0WzErs2NE4d0Ejs/ALV8z04626r9RXEFYC2Dmt4SiTUraP6EZ
P9Y5q2kAblCrBmheQQumXy/5QrGI1I/FCEtxRA1HFtSTfw8rElmzyKKMlv0I+aLY
06411eTjLH7Zcbw0DXBoCq/D34+j3B4s1XZK/sMWOtPofAxgzEAs24h+pmhkmHMz
y7vx211Io+dCP1BFJygv99K9fkMz3ZPYP9x9EBd49ySIaaIUQzEO+0knT1hVgd3w
28S8DYYxyu1XIrang6jbi9qxidnxf0VI1AhaibRWbBSYIrZeioGSeVUmJl32LrBR
fqt3IvJyBw52U11v0zbmStbzogfVOA==
=xYDv
-----END PGP SIGNATURE-----

--CKf/2jVYos1l2hij--

--===============5318714924304962202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5318714924304962202==--
