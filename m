Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58475C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:58:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD4323884
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 16:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD4323884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FD2486C51;
	Mon,  7 Dec 2020 16:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XBMvXsuV432i; Mon,  7 Dec 2020 16:58:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C470486937;
	Mon,  7 Dec 2020 16:58:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A41C1D9F;
	Mon,  7 Dec 2020 16:58:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAFE4C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C616A87340
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZpG64Vkwa0Y
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:58:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 02E16872DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 16:58:52 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id n26so20475536eju.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Dec 2020 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ODFYNKTjMTwnPrK31rw4SLzGgzSU67H0O2yeRZFdhqE=;
 b=StWv8dDxId3OKQIuDuKxj9jQNu0m2dzeV78062mOPIKyxMU89QJYro/YNl6/gjoSSS
 v+t8vX/HJok65OHBMUd/BtXcUpWPE5Ub+gyBQOwt1/2u/C8p+9CU+1Mcr4dA+Y14w57i
 45c9afhRrA+LOIgaVY/Kd651s2f0piLIcWD4/ZPGUokK04B51HiNdCtNJ238uJfgGUcE
 rw4cg4ji6epNW5tAC0WMjVbnEYY1SQjxkYzqX3FZ/JoKmSLH1MrT7IFpcIu3FPLfnUTb
 s+MZhd9GtEOIS4n+mXJNrCelojEWWRysYkGqyQ3LzTTqgH5FkkH79xzDO9SGVNseGj6i
 Q13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ODFYNKTjMTwnPrK31rw4SLzGgzSU67H0O2yeRZFdhqE=;
 b=VbIKnT615p7LQodDjy+8o+um907qk41Ltkjrqdb9KI7D7A/36LcPzNvJb/PgyBdOIO
 7EJg/gYiTMrgvxbyvHEQPjcdioBQprKSUgXHU2AYR3u9MfO+5xeePIx0ML1TeHTcb3CY
 bssw8+k1DpnlrM6gBsWL1BGMV13lAKrVZOyI+PCs95fnl0Bf/tMvnti1bb+omrWZ8NwM
 L/PQiz1ZPCb68eVbX6QxkYI6Jch4VPAyg12a/wm0x3zRTJsck53mZLITPKVMgWoPSHmd
 VMTiKcwJ0O8dmvFhVHoN6iMjxmo7nUjMuEkd58dRyG8ugyY91pi87KGtUsAzWdiuaz+/
 kdaA==
X-Gm-Message-State: AOAM531WlotbgOSUIgKxIdevTyHzzxAKPCDC6kLPNulXnq9edhIb8i2H
 Kazp3gB5idVFQ8Wffo5xuG0=
X-Google-Smtp-Source: ABdhPJzHOW+Ylwqjw+on2+NxIj8szkbB93r8R6R4oPxzlBCIMpXESI+nx/IQwtqoqUYOs2yYBcEfMQ==
X-Received: by 2002:a17:907:447d:: with SMTP id
 oo21mr19969752ejb.367.1607360330523; 
 Mon, 07 Dec 2020 08:58:50 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n1sm12853926ejb.2.2020.12.07.08.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 08:58:49 -0800 (PST)
Date: Mon, 7 Dec 2020 16:58:48 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 06/27] virtio: Add virtio_queue_get_used_notify_split
Message-ID: <20201207165848.GM203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-7-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-7-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============5124506880094077304=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5124506880094077304==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EOHJn1TVIJfeVXv2"
Content-Disposition: inline


--EOHJn1TVIJfeVXv2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:50:44PM +0100, Eugenio P=E9rez wrote:
> This function is just used for a few commits, so SW LM is developed
> incrementally, and it is deleted after it is useful.
>=20
> For a few commits, only the events (irqfd, eventfd) are forwarded.

s/eventfd/ioeventfd/ (irqfd is also an eventfd)

> +bool virtio_queue_get_used_notify_split(VirtQueue *vq)
> +{
> +    VRingMemoryRegionCaches *caches;
> +    hwaddr pa =3D offsetof(VRingUsed, flags);
> +    uint16_t flags;
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    caches =3D vring_get_region_caches(vq);
> +    assert(caches);
> +    flags =3D virtio_lduw_phys_cached(vq->vdev, &caches->used, pa);
> +    return !(VRING_USED_F_NO_NOTIFY & flags);
> +}

QEMU stores the notification status:

void virtio_queue_set_notification(VirtQueue *vq, int enable)
{
    vq->notification =3D enable; <---- here

    if (!vq->vring.desc) {
        return;
    }

    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
        virtio_queue_packed_set_notification(vq, enable);
    } else {
        virtio_queue_split_set_notification(vq, enable);

I'm wondering why it's necessary to fetch from guest RAM instead of
using vq->notification? It also works for both split and packed
queues so the code would be simpler.

--EOHJn1TVIJfeVXv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/OX0gACgkQnKSrs4Gr
c8joJwgAxP2IQdibt4q6jUVfHjl/jy+5PpzROcRTI3+NTOW7RZAtHwg1VSLc+N8N
AGRSKiaMpsWS/ApNmdzTjrmMurFOZRjrsPVwu+UDqsd1vscYk9ZWhc3vS24gYSot
X9Y0av+ZpV0OBKlFGpEdqaOHt7LuK/IwyZe5fXGH0CAH25+OKky7gisAMXeY9c3L
CEusJ6PGE4fr+99IcJcefGiMPCW6QvmJQnvsq2F7ST1ArsPfhvZASZWnucmtXsNH
YywpV+RFNQrbyiMU86CwVE99COm16dTpb1n4QHu5+4tTQa9l3wy9cKTPrrFzlUGI
Wm8tTPQ1Njha3wNnYaoHBGcNMX0sCg==
=RgXt
-----END PGP SIGNATURE-----

--EOHJn1TVIJfeVXv2--

--===============5124506880094077304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5124506880094077304==--
