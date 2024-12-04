Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626117DFF2
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Dec 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345255; cv=none; b=ej1T/4uVYwiQgPkAZ3dVtBM3SfUJb/kzY/YVOj7IrTcsLvREwz0RrafELPtNq6HxDDiPqz9BZ2Fmcpryj+fB55Dfv1h2DSpk5mvz9/WYuXgNlVacKk89Z+RJEzyWlX0HqflB0TqZoMvW7J0WavzjEntQiqH/pCNFv3rT30lY77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345255; c=relaxed/simple;
	bh=m8m0Pb5AOH9C5SbM5Y38gauDgNeP9F3syMc6moF6jSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJsDfPn7q714JodjmaIsYla+nq2Utr9oo+mVZ73Vi+4KqOwcDHccWSxChC/u/WmqHmwgkxOcbDUC04clkM+3Q6dLRUYxeCofS4PUtf3ji0qU+r3Ohgij+BeZDwSXZUduZu2eItj90yCSAOJflidemf9VX1IcLxu9/0OSbpup+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejYMOABe; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejYMOABe"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6014440BAE
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Dec 2024 20:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spLrVC9w-Rdx for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Dec 2024 20:47:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B542840B9E
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B542840B9E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejYMOABe
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B542840B9E
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Dec 2024 20:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733345250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m8m0Pb5AOH9C5SbM5Y38gauDgNeP9F3syMc6moF6jSs=;
	b=ejYMOABekEIpMrLRpahrnXnodU5f1cWckQBflMmr3DXe+1B3X07XVuwJ3Af+GQL9kU3uNK
	jxOV6MGKIWLuTOpgA2cCYAcdQZkWFdQZeQiutL8TllVbSh4W4p1hcxWfeFjj8NRknr7ab+
	qQBNzBYRZaEdGoPsS2RPd5mS/bAi+hg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-EatMqeSWO4i1fDBghL2ITw-1; Wed,
 04 Dec 2024 15:47:26 -0500
X-MC-Unique: EatMqeSWO4i1fDBghL2ITw-1
X-Mimecast-MFC-AGG-ID: EatMqeSWO4i1fDBghL2ITw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63ED41955F3F;
	Wed,  4 Dec 2024 20:47:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.246])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FF031956054;
	Wed,  4 Dec 2024 20:47:24 +0000 (UTC)
Date: Wed, 4 Dec 2024 15:47:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
	pbonzini@redhat.com, target-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/8] vhost-scsi: Memory reduction patches
Message-ID: <20241204204723.GA48585@fedora>
References: <20241203191705.19431-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hFZFi1BZnDJeU0rX"
Content-Disposition: inline
In-Reply-To: <20241203191705.19431-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--hFZFi1BZnDJeU0rX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2024 at 01:15:07PM -0600, Mike Christie wrote:
> The following patches were made over Linus's tree and also apply over
> the mst vhost branch. They reduce the memory use for vhost-scsi.
>=20
> For a simple device with 1 queue and 128 cmds we use around 25 MB. These
> patches allow us to reduce that to 8.2 MB when supporting up to 128 8 MB
> IOs (the current passthrough max size).
>=20
> For a more complex device with 16 queues we use around 2.5 GB. These
> patches allow us to reduce that to 77.1 MB when supporting 1024 8 MB IOs.
>=20
> v2
> - Rebase against current trees/branches.
> - Fix email threading.
>=20

Nice improvement! I haven't reviewed the patches in detail but this
sounds good.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--hFZFi1BZnDJeU0rX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmdQv9sACgkQnKSrs4Gr
c8i7QAf/f/EdoRoSDhepp8tPxlculmrsqaR7+Aqfvs/06vk9026xdKVo4XxwzXzb
3j1eWdSRiXw8f3Z3LmRV38D4TzMpUaJrGrgSRMXR3A+cFRJVYBF+eOO3MwmSDVXB
PEwJthub3exehRXYuYw8iTlDYLMu/JecoNlQIq4jTP+8dqCpdzFrI+/yrZVtIio6
9OPN8aDMWSdTO3As98NkRPsq8P3PMn3T5LR/D0N2ZI5cRCHDr+HswHVpRiNbyVeH
OBPWiHQn+Twix7r2+TEYwCYFDfvSWMD4ORtHRC50MpZjdbUjTdlzSqYT23Vt1j78
rxQ5ZCItLMyiQPbTBQ3krB70m2Oa4Q==
=aOhi
-----END PGP SIGNATURE-----

--hFZFi1BZnDJeU0rX--

