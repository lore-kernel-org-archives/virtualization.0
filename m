Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2E22EE5
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258941; cv=none; b=l/MkiRJtXuIMf+j9dDdj7SwQSYgS52UJHlpU8F+yMtFdSNmKJkq/KHeu07TsHyO7SFh6ECnpn4L+MQdE5YbdBburRyhGHwkG9Dm709/1eR1qq8EYqSw3oO3LuNAwFDfaTDCSl7WTelwWo0IMNXW/uB/6wSPEyGsUprx+alJUe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258941; c=relaxed/simple;
	bh=747T9jLSqH8bFgDb72pde2D+kt0cpKYYu/2oRmA4qo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8hfDgLbuiTB5BwqZzIwVYLrjik6O5SiqXvRONy8ojjaz0he5JyhQb+3W4T9pXS4LVNlhf9iwBpYqwJ0cvjd++7H+Zv+x4YZBp5pr4JmWUgDSCr2PEDM5R6Dc/uJsTcsrVrUZhg7E1eWPaZBVdEc5gtBucJ9gAafNCDyqYibx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXFJXX5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXFJXX5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlAq9ja2RSbJ2WExbn5JQkIBqDsE/3iSsVzG9YVP7BE=;
	b=TXFJXX5CoBrtvTTjf2ILo2xWysKiBPc8sqb9l1dzHnbZTTdN2eKnxewIlQ6oE1GEA6OFog
	pmhywWcwZaq0zPpgk4UU2rTD1Lgu7SHGDO3Iwktxw9h/WgioiW7LK9rzZx8N3pz5yZSC3t
	pnb8L+Op2xWH/89/3nTQ0+YPM4uERyg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-SBlekZx7PUW4N_8FQ1amvQ-1; Mon, 17 Mar 2025 20:48:56 -0400
X-MC-Unique: SBlekZx7PUW4N_8FQ1amvQ-1
X-Mimecast-MFC-AGG-ID: SBlekZx7PUW4N_8FQ1amvQ_1742258935
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso4604621a91.2
        for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 17:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258935; x=1742863735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlAq9ja2RSbJ2WExbn5JQkIBqDsE/3iSsVzG9YVP7BE=;
        b=Oh8lLwsZ6qvaXJEsRWivHL2lG5RhUndqTOrtCoZ2PPWo8Vb0qe1VY+cN0WLGlQ67Fe
         adkgD5fVSf0MP5voBFOO6qulI5CG3QpezE1Ye8qhJ3NjDjYJWqqZfdRztauhNF8QpYAk
         wuuPFhp8EucudfDscuhYNZJAN/T4k4d6fENm8V3fIB3H8OT1VBAm3EJkMx6j1iecoaFa
         Jw/VT+iiMBETpl2fsJ5HjMR44pcAFLD3Lw8PMN/S19xqPuW6tmwtSNi78OqRf3pvr+pa
         QVMqZ/Nl3qupg5cu6IbDNHzkl1bfSp0Vxe+HRNPRdnZXe0Wz8KIHDLcLj0SlAiR4w4yV
         tfwA==
X-Gm-Message-State: AOJu0Yw8qu/qyXGdsE2kQyLDryg5sfhFvz3RfXKZUkO6l852KJDQVVW2
	i6rRkrtNprmyi+FMXfRdxuCnzPjEnlxBYyQjZ34GAXE4G1uBS73zrz8qfNBOV2Zqd5YO9XalqSa
	bJk4N/BnIjqNzqVHGOzy+0JXV7Gm66OSnnXGCShFXfZHqAC+HJMyeMQLh7EHyNmkYlYp/Zhqs3f
	idhFHIAJxDGbigCQqACMlLzlxxYKeZvIoQLNxjHYc=
X-Gm-Gg: ASbGncv8zZO23jq45s/FuhSusmy9BIF2lIogD8NrW6wHIOA3u21lrw0QaSqr0rrrpmg
	kmB+IkAOgnnVABsos98f+bRDpbEce2184EVAruPB9dUM87dLvkZVTwsdD71CkBrgIE/Mceg==
X-Received: by 2002:a17:90b:4b10:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-301a5b1313fmr486184a91.11.1742258935177;
        Mon, 17 Mar 2025 17:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjSE8bZtH24Q4k70pqmCF3Pl5ZG79aTMFklPXXWxS7VadnbTFOusaQmH8Wzxx/kb4T1iFplzJMw+APpySRBkg=
X-Received: by 2002:a17:90b:4b10:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-301a5b1313fmr486162a91.11.1742258934866; Mon, 17 Mar 2025
 17:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-3-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-3-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:48:42 +0800
X-Gm-Features: AQ5f1JrAlxtKtwUtKRrW-cmJuRCs9VYdUge7DAbLNhWk3XLXSW2HZUWTJOSqcLg
Message-ID: <CACGkMEuhqbxr-20Jghn10fWH+pCAVih_KvWU6Mj+FXgE6TOTVA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] vhost-scsi: Fix vhost_scsi_send_bad_target()
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T03w77ejxVgB71Vl_yuAotlmwJTVJtbs-l0fqJEupUA_1742258935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:52=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Although the support of VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 was
> signaled by the commit 664ed90e621c ("vhost/scsi: Set
> VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 feature bits"),
> vhost_scsi_send_bad_target() still assumes the response in a single
> descriptor.
>
> In addition, although vhost_scsi_send_bad_target() is used by both I/O
> queue and control queue, the response header is always
> virtio_scsi_cmd_resp. It is required to use virtio_scsi_ctrl_tmf_resp or
> virtio_scsi_ctrl_an_resp for control queue.
>
> Fixes: 664ed90e621c ("vhost/scsi: Set VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERS=
ION_1 feature bits")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Move this bugfix patch to before dirty log tracking patches.
>
>  drivers/vhost/scsi.c | 48 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

