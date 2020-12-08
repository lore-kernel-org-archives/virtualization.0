Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E0C4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:16:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F3323A51
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 08:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F3323A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F353987439;
	Tue,  8 Dec 2020 08:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0MgcVq7VgiT; Tue,  8 Dec 2020 08:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 574A787423;
	Tue,  8 Dec 2020 08:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 307C4C0FA7;
	Tue,  8 Dec 2020 08:16:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54D41C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 34BD587271
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKIkeGg7ORTB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4583787270
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:16:24 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id d17so23368273ejy.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 00:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0MZ4ych3emYAu7+Q9yW/YIpRfM16QACSHELWSs2rWrA=;
 b=kF3j152eFYRZ/AwAwWDl/8sH1FPpTecOhMACHlnX2wSwpOpc27L5GyoUZDH2EvCMwK
 y9wdK63uwUY50RL+FKK/zFY7ENKQWtMei9T/F0e5Or8fI038x1kXF1sF1iwFXCgopmSZ
 AJOEaH2ql+No+qeGgAULvXiz+Aa5U0IxKDHTifUL42IzuKIBSNaQ/pZhZmfPEU7UhTou
 jF99BF0DppWSjdEFpvFU6Dcpd/2h1jWuRu8A5cPwUhFScGvhBsorFjDslWEVtkJS4M21
 tXsRydYs0Zv/Xh41I5eXCNNTkCFv+auW8eCgzL3yGUKOt5Y6+a+UpjbWfn52hfDkrVvE
 N6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0MZ4ych3emYAu7+Q9yW/YIpRfM16QACSHELWSs2rWrA=;
 b=UI2MtyQUfFAZXRwPaiYymlgUPyr0vK3wD81xiPCAiQXCWqXjpBfNT+BPianrCorhqQ
 QyOpuEyTy1hm4A0Ti6J1BxDkI85kyDfKWTZYIDIbEjqUMGN7eLj66peHlVFcoHQTHQXc
 in7OFqNaYSYZrk4MsFCxK03zpXkRgYR3AYrNfH5/aD9nYxT6xiYyBZirnon5bpLS04Zv
 Uli79rneeoApQ5N4rIhfDjXCMnAZCHALm1Z/F4yEYzmiQaXkwT0+gWFnUBhd9dfhWZUf
 PXWU/JH9T9XE8NEPYaWS1+owU5YNzVm7SFRYk9hij5iXtvf7D8FuYzizbZHwG9jnboS0
 xwoA==
X-Gm-Message-State: AOAM531ja/RcLqWdLzXrCNFCiO9Lo4PyeKFpB2dno7Zzz0g5HFe5TlHo
 ihEPQE7CBtDBiS8RESWGqdA=
X-Google-Smtp-Source: ABdhPJxyWbI55Jd6qYICL2uwX+696K8Y0xIltzoZqUUzlSQ/rT8zc0suMehmzBTJUlToBddDlIP13Q==
X-Received: by 2002:a17:906:3294:: with SMTP id
 20mr22572710ejw.239.1607415383508; 
 Tue, 08 Dec 2020 00:16:23 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z26sm16339109edl.71.2020.12.08.00.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:16:22 -0800 (PST)
Date: Tue, 8 Dec 2020 08:16:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 13/27] vhost: Send buffers to device
Message-ID: <20201208081621.GR203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-14-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-14-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1950410760583143680=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1950410760583143680==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chReQkDOePndSGWY"
Content-Disposition: inline


--chReQkDOePndSGWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:51PM +0100, Eugenio P=E9rez wrote:
> -static inline bool vhost_vring_should_kick(VhostShadowVirtqueue *vq)
> +static bool vhost_vring_should_kick_rcu(VhostShadowVirtqueue *vq)

"vhost_vring_" is a confusing name. This is not related to
vhost_virtqueue or the vhost_vring_* structs.

vhost_shadow_vq_should_kick_rcu()?

>  {
> -    return virtio_queue_get_used_notify_split(vq->vq);
> +    VirtIODevice *vdev =3D vq->vdev;
> +    vq->num_added =3D 0;

I'm surprised that a bool function modifies state. Is this assignment
intentional?

> +/* virtqueue_add:
> + * @vq: The #VirtQueue
> + * @elem: The #VirtQueueElement

The copy-pasted doc comment doesn't match this function.

> +int vhost_vring_add(VhostShadowVirtqueue *vq, VirtQueueElement *elem)
> +{
> +    int host_head =3D vhost_vring_add_split(vq, elem);
> +    if (vq->ring_id_maps[host_head]) {
> +        g_free(vq->ring_id_maps[host_head]);
> +    }

VirtQueueElement is freed lazily? Is there a reason for this approach? I
would have expected it to be freed when the used element is process by
the kick fd handler.

> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9352c56bfa..304e0baa61 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -956,8 +956,34 @@ static void handle_sw_lm_vq(VirtIODevice *vdev, Virt=
Queue *vq)
>      uint16_t idx =3D virtio_get_queue_index(vq);
> =20
>      VhostShadowVirtqueue *svq =3D hdev->sw_lm_shadow_vq[idx];
> +    VirtQueueElement *elem;
> =20
> -    vhost_vring_kick(svq);
> +    /*
> +     * Make available all buffers as possible.
> +     */
> +    do {
> +        if (virtio_queue_get_notification(vq)) {
> +            virtio_queue_set_notification(vq, false);
> +        }
> +
> +        while (true) {
> +            int r;
> +            if (virtio_queue_full(vq)) {
> +                break;
> +            }

Why is this check necessary? The guest cannot provide more descriptors
than there is ring space. If that happens somehow then it's a driver
error that is already reported in virtqueue_pop() below.

I wonder if you added this because the vring implementation above
doesn't support indirect descriptors? It's easy to exhaust the vhost
hdev vring while there is still room in the VirtIODevice's VirtQueue
vring.

--chReQkDOePndSGWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PNlUACgkQnKSrs4Gr
c8i9Uwf+KL98CWZdfBbfOzMa4z1SurHdDzNVHmvessTG6JChYGBDqPsIWpD7BZkb
xT/Qq67zwsCyUzrAlmFN90vPucMpqvB21DfXXv4MpjBWS5X0yjwwMQFktulDW/0y
TYJd7mplqyRUC8UV0yzv4U7N9RH15oZ8fyZ0KvYwXhlLgjsfBZAPXekHrVU+Ir1W
5Lx5C+/+h0ocxFTU2ycn4y0flbIvYZXtGf5y9dX3g48JH0R8D81d7qXamsRAA1Cw
uYhOsTVIDTpLWPuT6gJXu8ibk2Zc8tFcBul+5G1XfMNWAaUkZqsQmzGpOl2p3DZK
XuOZqG530TE0w0AtfRTsiDrsjWfvjw==
=TPSt
-----END PGP SIGNATURE-----

--chReQkDOePndSGWY--

--===============1950410760583143680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1950410760583143680==--
