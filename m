Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8E13A258;
	Mon, 12 Oct 2026 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791769723; cv=none; b=KTw95yqmoZGfzep9TY8r1/OopcbhqdUYAOgjkYudO7d+xdnk1uDhNaQK1HEzk+7tJVO9H/7O0ONKP2hafuHFIZVoQ0hUMnew6SGRF1SFafLCxxWKO4f5cuyb0DfO2Q+EoemlMwPbBU8cShyeaZz6/JHGQM6Xf3qrZGbPutIl0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791769723; c=relaxed/simple;
	bh=jkLsQRKJYGvk/UUF42MEqe8PifE9uyhXO8/Jw1pw0wk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i0kDiSKWoY/nUlAFRs85Nu4jRUV0Cdr0fOePbpaMKJkoaudmq3BBIBvzPK9L8+nRmg0W+P6h56oYiKfL5YvwzfxqpDnOTF1JfQavHvHpqSAb9pXb6IjZNBPWNHHobZOl68bjjXjQpyiPf24qDPZLrLwYl76hMnzgb8IvseDSvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O15v3zad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O15v3zad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2481F1F0089B;
	Mon, 12 Oct 2026 01:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791769721;
	bh=6RtVqpwPvL4Gf/gOeDTxmKt/KChl7Ra6aa8i1t2U8DE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O15v3zadAHVqBJGg5e5mMFmyareYGQobxDafo3fAzVayi/04fm25LxPgNPcGgIv5M
	 n59VXfNTykNYKvjVXC4YxkaSPlEa4NoA1eZnjjGR+lUKATfZ6Sw+GkuOoccQuYb9Em
	 FSpnleAiZl2DMqcSYVwImvUYwffDtP0jmbtNdP2+FjZ+S6WyPlzpxGgymTVZU/yJcz
	 Bmao1KsmMvjvAhWO9cWQNuH7QWXdZOo7Va3w/gShB/Iu2wDnRrkNoaDtcI+Jxpc9YV
	 U31SZhXexURWk7uF+OYLGDZyXGgTQmUcOMfO5j/QowerA9Q5cbBn/cOTtBsHR3toQz
	 Hd/dRU2UDFOuQ==
Message-ID: <sashiko-outbox-167544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20261011014803.100454-1-physicalmtea@gmail.com>
References: <20261011014803.100454-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 01:48:40 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] vhost-scsi: missing validation of prot_bytes alignment allows =
OOB access
--

commit a2683cd412935b122ac2e93ce16af9655a892639
Author: Jia Jia <physicalmtea@gmail.com>

vhost-scsi: do not count PI bytes in the data length

This commit updates the expected data length passed to the target core
by omitting the protection information (PI) bytes. It adjusts the length
so that protected read and write operations take their length directly
from the CDB, preventing issues when the data scatterlist is smaller
than the total length.

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 885fac5ed042e..8b32caa7ec294 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct=
 vhost_virtqueue *vq)
>  		 * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
>  		 */
>  		cmd->tvc_vq_desc =3D vc.head;
> +		/*
> +		 * exp_data_len is the data sgl. prot_bytes already sit in
> +		 * the protection sgl. Protected READ and WRITE replace
> +		 * data_length from the CDB in sbc_check_prot().
> +		 */
>  		vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
> -					    data_direction,
> -					    exp_data_len + prot_bytes);
> +					    data_direction, exp_data_len);

[Severity: Critical]
Does this code allow an out-of-bounds access when prot_bytes is not aligned?

In vhost_scsi_handle_vq(), prot_bytes is extracted from the virtqueue eleme=
nt:

    prot_bytes =3D vhost32_to_cpu(vq, v_req_pi.pi_bytesin);

There doesn't appear to be validation ensuring it is a multiple of the 8-by=
te
T10 PI tuple size before it dictates the length of the protection scatterli=
st.

When the target core later processes this command, functions like
sbc_dif_generate() in drivers/target/target_core_sbc.c loop over the
scatterlist length using 8-byte increments:

    for (j =3D 0; j < psg->length; j +=3D sizeof(*sdt)) {

If psg->length is not a multiple of 8, does the last iteration read or write
past the end of the mapped scatterlist element? A malicious guest could pro=
vide
an unaligned pi_bytesin or pi_bytesout length, potentially causing an
out-of-bounds access into an adjacent physical page on the host.

>  		ret =3D 0;
>  err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011014803.1004=
54-1-physicalmtea@gmail.com?part=3D1
