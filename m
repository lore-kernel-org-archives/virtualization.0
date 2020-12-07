Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC69C4167B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:43:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451C1206C1
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451C1206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB2B587929;
	Mon,  7 Dec 2020 16:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MGQ9Iscx7taT; Mon,  7 Dec 2020 16:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9768F86995;
	Mon,  7 Dec 2020 16:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B685C0FA7;
	Mon,  7 Dec 2020 16:43:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CEFAC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1929887B96
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nFi9m038YLa
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:43:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D72D387AD9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:43:26 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id lt17so20464861ejb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 08:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=trwWkN08RC97k3KH48B9gNQriEKWSyCbtbzCxwfGmWE=;
 b=B1EfYNbMVMFOaHv5Q1+MqxN4scHz/Hv2fxp5bGgVC+k0ctBrJNkDB5ON3sGBLmaQW5
 blaRzeSuWIpqS+bVQsZMBPxJI8qZqkB3vAkb7ZKE/z1Y2OwARk5Rn2HNXDzI7jOlrvf4
 RNSG3KDnMlyl33wXV01uXcO2Fn3qrf6AB/zxTIeRuxVzkPpRx14EgA0CNunoi2Bl4rGC
 5qAN0mMe6htUVLfW/sP/mFXpYntXPXC2gICjdEpOUEJvh+hE+akT2xtD0KWG30J3Gniq
 Dg6xvPp/SY/g5caQK0EmruRZ2vgxERtmT1abew+RC1FKJZNx/gw5mhLQw18Yzijrqefe
 e8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=trwWkN08RC97k3KH48B9gNQriEKWSyCbtbzCxwfGmWE=;
 b=QyP7QJh1qQkAmqLarADxzi5y8dTAiLWElv9HMFzMPeEdJzFttGCep1bef109bav5fj
 KagHUDwPdQCmu2rM5oXx0fVa8F7rLmzmcJLZm8qByhOI7jQkNNbjoHR1NFryguXOeX3k
 DT3ftjspV2xEyYrtM8sOnJfQ6OIpFAvvEjC+9p+Op3iuJwT3w025nr4damTNadAqkjz1
 xLU2WCVjI8uHaunTyVop2z07EH52xSbQ+TZGsnLtvG/QZ4mm25zg4WPbJBvI7+tEgR8c
 jhIyYueweE0bY3UHbU2xmDqn257dfpM5Pb5JtA6tAHvNMhr3ntzNOe6fne9wOn0FSUE/
 Hvfg==
X-Gm-Message-State: AOAM530sQ732A3n9NRpDxqs+lkgTP8Rr3nUAZsInuMCWYMu9hS7sZHW3
 y2t4/s19DaUofePzP7LlNx4=
X-Google-Smtp-Source: ABdhPJwY9MeoSxGwRPyIJV5M0g2NpLCkzQk4QntsuJ7EEGm36J5EQc7Tf8qRkCsQBxMYB/d2Z8WFeA==
X-Received: by 2002:a17:906:ae41:: with SMTP id
 lf1mr20055824ejb.369.1607359405393; 
 Mon, 07 Dec 2020 08:43:25 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w20sm14259249edi.12.2020.12.07.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 08:43:24 -0800 (PST)
Date: Mon, 7 Dec 2020 16:43:23 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 04/27] vhost: add vhost_kernel_set_vring_enable
Message-ID: <20201207164323.GK203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-5-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-5-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1532844565806573754=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1532844565806573754==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:42PM +0100, Eugenio P=E9rez wrote:
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-backend.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 222bbcc62d..317f1f96fa 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -201,6 +201,34 @@ static int vhost_kernel_get_vq_index(struct vhost_de=
v *dev, int idx)
>      return idx - dev->vq_index;
>  }
> =20
> +static int vhost_kernel_set_vq_enable(struct vhost_dev *dev, unsigned id=
x,
> +                                      bool enable)
> +{
> +    struct vhost_vring_file file =3D {
> +        .index =3D idx,
> +    };
> +
> +    if (!enable) {
> +        file.fd =3D -1; /* Pass -1 to unbind from file. */
> +    } else {
> +        struct vhost_net *vn_dev =3D container_of(dev, struct vhost_net,=
 dev);
> +        file.fd =3D vn_dev->backend;
> +    }
> +
> +    return vhost_kernel_net_set_backend(dev, &file);

This is vhost-net specific even though the function appears to be
generic. Is there a plan to extend this to all devices?

> +}
> +
> +static int vhost_kernel_set_vring_enable(struct vhost_dev *dev, int enab=
le)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < dev->nvqs; ++i) {
> +        vhost_kernel_set_vq_enable(dev, i, enable);
> +    }
> +
> +    return 0;
> +}

I suggest exposing the per-vq interface (vhost_kernel_set_vq_enable())
in VhostOps so it follows the ioctl interface.
vhost_kernel_set_vring_enable() can be moved to vhost.c can loop over
all vqs if callers find it convenient to loop over all vqs.

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/OW6sACgkQnKSrs4Gr
c8jcDwgAvhR1DPn/758yBurYSAd5bodrjz48KqGTFPhHnHIzAsDSztsiZ/VKnhlt
lkf8slJQyaaQ5G9Po4HX6CNdMSNmkBT1mz0lk6dnr75aHQ/hijqknpXM1og/4MRQ
lCUyXQhHsLGZ3ETT8Is/Bgg99b3T0SykRSzhlpzIMaPqGgzvzTNdh1u0SFKi3W3o
Vke/ZS/yZ2K0F+sNwQzPGp5JflOTagn1QuGO8JslZinLNh8y3C05n/6ZCWbM9Jl9
ABaBPHhenGFmH672WMK839qEawHgEUS6aziPnVfPczqudEqinJpHT9Oc6xMeBG1D
mv3UoTm7iaY08guxGcO5yO6FILXe/g==
=IdPX
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--

--===============1532844565806573754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1532844565806573754==--
