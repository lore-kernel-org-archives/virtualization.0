Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9201D2147F1
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560958; cv=none; b=gCa3HEzxWkVdfosCfNBgEHjP1XwtZhDxm+knzOgs8SOVWSpPED/VYi3K5LoC3T65Ddsk2LDQVIll0j6mzn+9Vur8YVN3vGTWIwDQgpmavQxIgcdtxTXAAPQBz83PenxBeld4ZX8c6xozWcG7AvO17do/7QO5hdUUftUgay+zpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560958; c=relaxed/simple;
	bh=OUt0/jxjDIhAZJSBbKELluJlEtZD3xmetIT0RHwnBEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw+zUPGwbNTzLsGZTWZsCA2aliksau5frRAMsbaEKx6VQxsOMfD3zJem4gXYqfp+NtXf8rp/bmm24dfcn36wanBoUhzttTNrd3DchG/6xdeQuGaYJbPi4gq/nx6IuwUFeLEtm1KMbqj1d4lMKbBJOPWz8l3uHG06WleDj3tahPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD0hOgS2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD0hOgS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737560955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OUt0/jxjDIhAZJSBbKELluJlEtZD3xmetIT0RHwnBEs=;
	b=PD0hOgS2qtMxgrw2G2bkWjGwhf4l6GeghDIDsD9sQ9q6/P4Kj84+qAkBi03A+1CpxX6d+E
	qQoKypAZlhcu0JBPzxkkKMEHbS7AKrSeqNPZtsFHNBbeO1LUGbAI7QnukIxsYe4RwMs6RR
	1zCYSjtIFT+HJHwvNcUsS60qA3GKcec=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-Id-tbIlxP5GuMNLrjzQBOA-1; Wed,
 22 Jan 2025 10:49:12 -0500
X-MC-Unique: Id-tbIlxP5GuMNLrjzQBOA-1
X-Mimecast-MFC-AGG-ID: Id-tbIlxP5GuMNLrjzQBOA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32BF0195D010;
	Wed, 22 Jan 2025 15:49:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.37])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C6AB195605F;
	Wed, 22 Jan 2025 15:49:09 +0000 (UTC)
Date: Wed, 22 Jan 2025 10:49:08 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
Message-ID: <20250122154908.GB178738@fedora>
References: <20250121103346.1030165-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DXeYdRgQDVnzR+62"
Content-Disposition: inline
In-Reply-To: <20250121103346.1030165-1-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--DXeYdRgQDVnzR+62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=E9rez wrote:
> A VDUSE device that implements virtiofs device works fine just by
> adding the device id to the whitelist.

The virtiofs DAX Window feature might require extra work. It is not
widely enabled though, so must virtiofs devices will work fine with just
virtqueue and configuration space support.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DXeYdRgQDVnzR+62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeRE3QACgkQnKSrs4Gr
c8hanAf/TOqItUc9R2v8eCNa8oV55YOCbkfLwKwTCpi7FpMtdVg1V0VhluJ17HzV
GhRXTzWlyBpn0exPWSwvAnnFqElTHipFTfzLW5bGUfx3Xy3KnrMvlzeHs0iBgnPD
pqlR/XSJDGSNUM8bPn+qi3JayXSp6P2N9iTVI5G+yWQfrIUTg4D/cKV8RalKD2Et
GX5DSOJslYXAXnqWntcZ/tHa7bIdC16sOZrSPRHcueYsf1jeTZ89QC//hVVzPxH+
I6yrkYfd3gNaubLdTr1sdgeB523l73Pf4uC/oUx36tR4Aqs/fuR4MQxs1wBgJI9/
2owDDcfxgllCctSYYPQ7kgSXzzRr/Q==
=Arcr
-----END PGP SIGNATURE-----

--DXeYdRgQDVnzR+62--

