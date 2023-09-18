Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3477FCD37B0
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 18:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A90FD400D0;
	Mon, 18 Sep 2023 18:20:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A90FD400D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NbACBwVX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZdSUGyHs8kO4; Mon, 18 Sep 2023 18:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F28C4151C;
	Mon, 18 Sep 2023 18:20:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F28C4151C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06AD3C0039;
	Mon, 18 Sep 2023 18:20:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19282C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 18:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8904410B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 18:20:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8904410B8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NbACBwVX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ElQHEWhB9pm1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 18:20:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA74D40EC1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 18:20:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA74D40EC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695061208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoVmfHMlj/9Gd0s7DAzuFBmncmpMd27GPgcNKgmNNz0=;
 b=NbACBwVX8Mmq677eP74cW9surIRukuDMIopSxqGnF1ccz9MX+vRd2aNGS8/UMvtqm3jeDD
 R3J2QNUYk1yM7uAfRMUySruEXl0i5f5/s4RSM2Y31ma4uqNebIAq9sMvf5ZNlIKYC9d2TC
 NBeVtia2Tdyn3LHBfILhuNHFatvjKNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-wSF1iOQONOSoQnDzkEbHug-1; Mon, 18 Sep 2023 14:20:05 -0400
X-MC-Unique: wSF1iOQONOSoQnDzkEbHug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1F8E800888;
 Mon, 18 Sep 2023 18:20:04 +0000 (UTC)
Received: from localhost (unknown [10.39.195.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43BD1140E953;
 Mon, 18 Sep 2023 18:20:04 +0000 (UTC)
Date: Mon, 18 Sep 2023 14:20:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: Re: [virtio-comment] virtio-sound linux driver conformance to spec
Message-ID: <20230918182002.GA1460476@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <CABgObfbXsHN6=ZmL0s+mtCypXs11LNECECO3Uud_J6PMr+JwNA@mail.gmail.com>
 <CAAjaMXbjRn27fpZHK982m4MyJGXWQTR99WHPAZQfcun+pe3GBw@mail.gmail.com>
 <ZQhHgTxoUAnfYaiC@fedora>
MIME-Version: 1.0
In-Reply-To: <ZQhHgTxoUAnfYaiC@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, virtio-comment@lists.oasis-open.org,
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
Content-Type: multipart/mixed; boundary="===============3278781167046427684=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3278781167046427684==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zJydkDeRaTd180Sh"
Content-Disposition: inline


--zJydkDeRaTd180Sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 02:50:09PM +0200, Matias Ezequiel Vara Larsen wrote:
> On Wed, Sep 13, 2023 at 06:58:30PM +0300, Manos Pitsidianakis wrote:
> > Hello Matias,
> >=20
> > Please show and refer to code snippets from the kernel tree that you
> > think are related to your question. It'd help us make sure we all talk
> > about the same thing.
> >=20
>=20
> In this discussion, I am referring to the way in which the virtio-sound
> driver is manipulating buffers that have been consumed by the device,
> e.g., used-ring in the tx queue. My understanding is the driver builds a
> ring-buffer that is shared with the user application in the guest. As
> soon as the device returns a buffer to the used ring, the driver puts
> the request in the available ring again. This is my understanding from
> sound/virtio/virtio_pcm_msg.c#L324. The user application updates the
> content of the buffer at sound/virtio/virtio_pcm_msg.c#L322, but this
> task is deferred by using schedule_work(). The update of the buffer may
> happen once the buffers are already in the available ring.

The driver cannot rely on the device accessing the buffer via shared
memory at a specific time. The device may process the buffer as soon as
the driver marks the buffer available and/or the buffer may not be in
shared memory (there is a discussion about virtio over TCP).

I haven't looked at the code myself, but based on your interpretation it
seems the driver is buggy. Buffers should only be submitted when the
buffer contents are no longer subject to change.

Stefan

--zJydkDeRaTd180Sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUIlNIACgkQnKSrs4Gr
c8gcmwf8Df9rJohbFP1qGja+l4i5Qx86HPvGYk0inmxdiEMC7hMNOc7C73E5pkh3
uiTH4KuABzib9MPdmP1w0Ci/8rLtUA+5w6pF9oNCezLmzH4CuvuGsCYplKhX6Bcb
b/B7c9qaRNja0dTwJ8eMcyC5VBik6gckl1HKDGY0QwH588/zGHeRNHBx3WHQeffZ
fDEjGzPunG2ClPuoxMQUCUBmcf+SE1j6rdf3Gj+ZI3mOdeSAYVr9x+5+l/B5Fcqa
586ublOohmb4C7kZzOmm/1QHxHYIiR/p17Y3U2In+CLvOxWR1dW+gvXIiZS90l6C
2tdzU7UqcAVECoCCDMI+XZLAXHnZBQ==
=iQnx
-----END PGP SIGNATURE-----

--zJydkDeRaTd180Sh--


--===============3278781167046427684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3278781167046427684==--

