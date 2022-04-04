Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7451FC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Apr 2022 08:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 197F0823CF;
	Mon,  4 Apr 2022 08:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fC8ImcqSG_mG; Mon,  4 Apr 2022 08:49:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BAE5B81DAB;
	Mon,  4 Apr 2022 08:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E35DC001D;
	Mon,  4 Apr 2022 08:49:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C888DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 08:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A610D400EA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 08:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ndd4rq0yfHcd
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 08:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E486B4000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649062151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RJO4YOIckljaxC1WSdxpeWFwKQ7UkOt90RkMFXKO4k=;
 b=DLZs+zElZP5KVcp0ZtKGQKkLzv+AkVDoA7pc7H3IESw63dgBrn9A2pb91CONHeHYdsF2QU
 JfbdWa21/m4C871nEaameDGq8nuhXQDir669kZ2Argw0OJ1plXRnmXBRRJR/PCCjZrVxew
 kCZO1gCATpp6mjKZgaDcaN0VqeInXmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-EPhsp-OiMlabi_TXNoruqw-1; Mon, 04 Apr 2022 04:49:07 -0400
X-MC-Unique: EPhsp-OiMlabi_TXNoruqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC8ED83395E;
 Mon,  4 Apr 2022 08:49:06 +0000 (UTC)
Received: from localhost (unknown [10.39.194.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B8111468973;
 Mon,  4 Apr 2022 08:49:05 +0000 (UTC)
Date: Mon, 4 Apr 2022 09:49:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <YkqxAA9tKikFf6iX@stefanha-x1.localdomain>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 virtualization@lists.linux-foundation.org, vgoyal@redhat.com,
 miklos@szeredi.hu
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
Content-Type: multipart/mixed; boundary="===============5172964636648542465=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5172964636648542465==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="johlXlSqV4WB+rsv"
Content-Disposition: inline


--johlXlSqV4WB+rsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> Move dmap free worker kicker inside the critical region, so that extra
> spinlock lock/unlock could be avoided.
>=20
> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--johlXlSqV4WB+rsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJKsQAACgkQnKSrs4Gr
c8i0SQgAiiCpauRR/VRZdej/Av1FxtiygazikyP74EifydRA7XuvYtXXTBsEUJvP
ZA03bAV0zFAqyG1EIjvGbXtjzw0zjsmbFYugfdIMwnv36drNn6tnSKT73+iEE7/b
iGsJWY/kLB8Muo+N4sZ0JpIfp3NsOFb14V/iLKFQfbH+hEClkoP9wM1etdkY3ogZ
NUgSmWRgk570CHDF85/CFu1zg7wG4KTeLWMa0o+uNSqXBPjOji90z/RsP5EZs6QT
Pk5Mmr/XRlgN0s0TR+NZc7EuP7Efgh4kZsViz9VkFEl+TPCDOvigsCTjDRTVRIgc
76EOklRhkCrNLaHJGUz7jL2GrHElIw==
=zLYr
-----END PGP SIGNATURE-----

--johlXlSqV4WB+rsv--


--===============5172964636648542465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5172964636648542465==--

