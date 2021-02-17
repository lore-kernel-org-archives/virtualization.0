Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5DC433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:45:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C456B64E4D
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C456B64E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D8F387263;
	Wed, 17 Feb 2021 12:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfADGU4-642x; Wed, 17 Feb 2021 12:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20DB78725F;
	Wed, 17 Feb 2021 12:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC46EC0174;
	Wed, 17 Feb 2021 12:45:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8728DC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7A65787262
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mYtvvOTg43FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:45:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EFEAA8725F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613565899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LdV3rLZJQcwe7yOhKJf+uyqCg3gHM0IziOlYFpxcxzE=;
 b=eDfq+kVostb2Zaho/wqcPq4tXLO4dBvp9c+l2No15HWEgaZqXiDoXmNG/RbLJ15C0mya8u
 q98R/JZoVcQd2aNL9ca9ZZfZfcYjqSRIvt5m8YO63gBKcXPAyQGMITfdqL8P/TSu64nd60
 jaJAQXZAHvLE7lAPpXD2gUI/TQ+WBqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-KVfYYkqnM3CpE5qnO8tlJQ-1; Wed, 17 Feb 2021 07:44:56 -0500
X-MC-Unique: KVfYYkqnM3CpE5qnO8tlJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ED4B100CCC0;
 Wed, 17 Feb 2021 12:44:54 +0000 (UTC)
Received: from localhost (ovpn-115-102.ams2.redhat.com [10.36.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B98D10023B4;
 Wed, 17 Feb 2021 12:44:49 +0000 (UTC)
Date: Wed, 17 Feb 2021 12:44:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v2 3/7] vhost: Save masked_notifier state
Message-ID: <20210217124448.GE269203@stefanha-x1.localdomain>
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210209153757.1653598-4-eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============8717427502455008073=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8717427502455008073==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline

--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 04:37:53PM +0100, Eugenio P=E9rez wrote:
> It will be used to recover call eventfd.
>=20
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  include/hw/virtio/vhost.h | 1 +
>  hw/virtio/vhost.c         | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAtD8AACgkQnKSrs4Gr
c8j2awf/UHpk5f3tKV12AGNdVg31ydUM74AvMrV0hYGB6lTdcFDChrTUGA2CJBcO
g3f5GUVM8kfOYjbtYi7rPJw97nxZ8L65byVZgXC6nvBE/Wl7wzENysTM8a1Og/87
xquNt0Du/prug5i29Tdt5463ivuZT9vZYa7FsFfdFw1eQPOp3VrCds52eEym4AS0
zqTy0EVjB8Nk91m+IwTfyNzg3shdYSry8p0r5NK3UpxMRCQv2o3vHG1hXaDLO56/
kRx3OtHyjC0NlIePRLsyKm9ap8kJEV1F/ioqPXXKPyx7UOxjMcKY1kx6PJM8mMjv
O1wlfz6yjtOvFq/UNw5imUJ+lj8ytQ==
=rvvf
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--


--===============8717427502455008073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8717427502455008073==--

