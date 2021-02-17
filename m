Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF7C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 17:24:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E05A64E2F
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 17:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E05A64E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4E4F87286;
	Wed, 17 Feb 2021 17:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mU9NtruFMy8H; Wed, 17 Feb 2021 17:24:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47FA587005;
	Wed, 17 Feb 2021 17:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 274EDC0174;
	Wed, 17 Feb 2021 17:24:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D96C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 17:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B6156851AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 17:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4IwxRH8B5Y6L
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 17:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0F48E85188
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613582653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=prGClKEbAowL5m/ig2FN3D1+Kydj3NJLTJWDC/Qhpu4=;
 b=Xfv/4zOCOlHqu99dYIeVomjL2SX7HqKfhPX0+MK/6kl1LfdrTYp7EykMHxMwT636bXp5T/
 1xH2B2yyD1gsND3wuBZtGm8C3o4UNJBulyGMQbyrU9i85/5GQ27o4sZfPYxAAcs4rzIvRw
 RLZaZ8+UACGXtHsQokoB/dDQCvO2q8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-G3vGFQMOOuygx2x5RO27Hw-1; Wed, 17 Feb 2021 12:24:09 -0500
X-MC-Unique: G3vGFQMOOuygx2x5RO27Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CAD3801975;
 Wed, 17 Feb 2021 17:24:07 +0000 (UTC)
Received: from localhost (ovpn-115-102.ams2.redhat.com [10.36.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E2D2100164C;
 Wed, 17 Feb 2021 17:24:02 +0000 (UTC)
Date: Wed, 17 Feb 2021 17:24:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v2 7/7] vhost: Route host->guest notification through
 shadow virtqueue
Message-ID: <20210217172401.GI269203@stefanha-x1.localdomain>
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-8-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210209153757.1653598-8-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Rob Miller <rob.miller@broadcom.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>
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
Content-Type: multipart/mixed; boundary="===============4774694784008840690=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4774694784008840690==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r4QXMf6/kyF/FvJJ"
Content-Disposition: inline

--r4QXMf6/kyF/FvJJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 04:37:57PM +0100, Eugenio P=E9rez wrote:
> @@ -40,6 +42,26 @@ static void vhost_handle_guest_kick(EventNotifier *n)
>      }
>  }
> =20
> +/* Forward vhost notifications */
> +static void vhost_handle_call(EventNotifier *n)

The name vhost_shadow_vq_handle_call() expresses the purpose of the
function more clearly.

> @@ -75,8 +102,19 @@ bool vhost_shadow_vq_start_rcu(struct vhost_dev *dev,
>      /* Check for pending notifications from the guest */
>      vhost_handle_guest_kick(&svq->host_notifier);
> =20
> +    r =3D dev->vhost_ops->vhost_set_vring_call(dev, &call_file);
> +    if (r !=3D 0) {
> +        error_report("Couldn't set call fd: %s", strerror(errno));
> +        goto err_set_vring_call;
> +    }

This ignores notifier_is_masked and always unmasks.

> @@ -1608,6 +1607,10 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, =
VirtIODevice *vdev, int n,
>      if (mask) {
>          assert(vdev->use_guest_notifier_mask);
>          file.fd =3D event_notifier_get_fd(&hdev->vqs[index].masked_notif=
ier);
> +    } else if (hdev->sw_lm_enabled) {
> +        VhostShadowVirtqueue *svq =3D hdev->shadow_vqs[n];
> +        EventNotifier *e =3D vhost_shadow_vq_get_call_notifier(svq);
> +        file.fd =3D event_notifier_get_fd(e);
>      } else {
>          file.fd =3D event_notifier_get_fd(virtio_queue_get_guest_notifie=
r(vvq));
>      }

Maybe you can extend this function so it can be called unconditionally
from both vhost_shadow_vq_start_rcu() and vhost_shadow_vq_stop_rcu(). It
would be a single place that invokes vhost_set_vring_call().

--r4QXMf6/kyF/FvJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAtUTEACgkQnKSrs4Gr
c8hq5gf/WPupi1xYyRBBSPKKAHCQeoJAEdrX2AQe3nE6V1pbI96pK+FAIZ1cxlYV
QHUGQlGN7ng9ajHBviW1upBxIcu5rM5vDG/KyQd71+Dgo1Opjfjm74/YWBF1ppaU
rj0dEkVcP97DsJ4yTJVwncSi9tuG9q4qsGmNforAH1dP2GaU8HjCx/xBEkEcVDGB
u6nUCH8c487YrVrRUos0fvNAnQyJPDs20zHXvo0zunCs8/7FdLjTn5ycQCS9zV9J
d6C7qV0+0gxE5y63qm3rSObzopdICdqRyDvghYs2nr6F4LOdN1F+NJAPXM1tgXDl
uxjmF6VoLMrN2SyW679rk2UJcaak9Q==
=swcz
-----END PGP SIGNATURE-----

--r4QXMf6/kyF/FvJJ--


--===============4774694784008840690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4774694784008840690==--

