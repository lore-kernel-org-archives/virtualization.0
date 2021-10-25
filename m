Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:22:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF5960720
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DF5960720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BE4B6082F;
	Mon, 25 Oct 2021 08:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4STj1t585DF4; Mon, 25 Oct 2021 08:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 004D66075D;
	Mon, 25 Oct 2021 08:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1EA8C0019;
	Mon, 25 Oct 2021 08:22:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BE29C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40E9F6082F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erMfHruE5Ehx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2A936075D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635150161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pib8ma/BQeVkVseqwE+TRzGP17V6G6u5cRT95wmBcbA=;
 b=VvB+0DfqYMyMR782cP9Co57TzYkK641OGHYN0FoeaxsyYmWUGRwevTCCDKWXqnafvRsmm0
 itsoeYXp3wXnZUjGX2hH1OUvZUW/L0qkLzrk3JdtdjIeo/mF04C1LmH+dai/SDvHL70b2n
 An6xtunkiz1o4Vu6STg4+wQBOhc+/2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-HUQAky8lNRCByC_gVNhl5w-1; Mon, 25 Oct 2021 04:22:39 -0400
X-MC-Unique: HUQAky8lNRCByC_gVNhl5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C17680A5E1;
 Mon, 25 Oct 2021 08:22:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11DC07092D;
 Mon, 25 Oct 2021 08:22:09 +0000 (UTC)
Date: Mon, 25 Oct 2021 09:22:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
Message-ID: <YXZpMEKn8S/4nGbx@stefanha-x1.localdomain>
References: <20211025075825.1603118-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211025075825.1603118-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 kernel test robot <lkp@intel.com>, Israel Rukshin <israelr@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Feng Li <lifeng1519@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============2323140166815272895=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2323140166815272895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C9wt3Sbjl43MgXq9"
Content-Disposition: inline


--C9wt3Sbjl43MgXq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 03:58:54AM -0400, Michael S. Tsirkin wrote:
> virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
> back to a blk_status_t variable. blk_status_t is either u32 or (more
> typically) u8 so it works, but is inelegant and causes sparse warnings.
>=20
> Pass the status in blk_status_t in a consistent way.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--C9wt3Sbjl43MgXq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF2aS0ACgkQnKSrs4Gr
c8jQdwf/fzLqhl0442aIH8ivsv8J4yZzxYSvpzk2tEZCVN58tNxxTWg+5X0uRwzc
oD7cQ7LWeJVVDzUmLwTyfV4pdscQYq0JHNaWzQSlOqcW3ITAzklnFlbFml+U4Voq
K8xatotWSjF4A7osZPAaQJlXZQMj3BGwgjPrCfFTSfFQAxB2H4hZ/qipvFV1GSzv
wZl+qKZ63bOe9dZPrveJGG7T5AYJ0yeKkb3cYC7vQZyrXDIq1ebMTJviljtn/EQh
GvYN5hDiSm/fW/hFhzppVM1IvRlXjjS0lVIWtliFLCGNcBc90b8DYaDmhZ4SmYnL
XD4KCvqtap4utaH5KGhbmT2Y5cBxZw==
=201H
-----END PGP SIGNATURE-----

--C9wt3Sbjl43MgXq9--


--===============2323140166815272895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2323140166815272895==--

