Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03BBE65
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258878; cv=none; b=Et4GQRcTjYskvXvW8NAeK9j2NAnsLCcA3R2FS+aC2pWfxzRV3ZPq1k8KGw3S+PRQmh6ElnoIUQ4TOOi/Dwyf0MEKRe7mbW+bchIL0qcMjjk4qLekwCWGdrITtEZc/dzLqypqBCYM57DJzL7xwDaUpJfywPncZlLWzpzGxAcELFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258878; c=relaxed/simple;
	bh=q9cORwpFr2i7u4nU59k5OUVSEIAbi61v48KFlNjBrec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0cr32sQ4vtnbnw6uMU+9qhMpJPoM9AVOA8iB9i6lMBrjU4V/O4TQwfsjGodc23mAhMaO5GSkk+0IK11DqmUj5a1/kSSwXgSXQG9wv88CoYC9Cf6Cq/dzXIflSj18l2iOw6MKbqJfZGejEWFo0w8TH88FVLTs68IMneQ+Rwe4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGnk8Ifp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGnk8Ifp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZfDnbuROQarLxKZz2VKb8iNL/v4tVesJARFvFI6DSM=;
	b=PGnk8IfppLLRxrnQps0ZpncuuIc6iOI9jy0FhuBSlX2jZgeIv7+SeRGYLe2rnQuNVzR3OB
	1YI/UD1Tu1saIb1mIzVWOa48nWn0Iynv/x2SdZ7eUyp2VgiacEvkcKEtuDg0T+Ffgtyfp8
	Bdf8yAJkToVxUmJHUNnySAduDBHVB0A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-TU_5UCCcNkS9HH8n87BaCw-1; Mon, 17 Mar 2025 20:47:54 -0400
X-MC-Unique: TU_5UCCcNkS9HH8n87BaCw-1
X-Mimecast-MFC-AGG-ID: TU_5UCCcNkS9HH8n87BaCw_1742258873
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so4104456a91.0
        for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 17:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258873; x=1742863673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZfDnbuROQarLxKZz2VKb8iNL/v4tVesJARFvFI6DSM=;
        b=mvk40lCKIcq2hl5O+scx8XCZUmX+a01/PMACr1TCWzgmdWslVRSz1Qz6vLW9A6z0TL
         6Qcqa23lSoKdeeye5UuFJKETFjmSA46uqGxDEDInXGq3OWzx0aoEttg53hgP67gky4BY
         Wf33C3MLZAGN1HdKMvJsPxDNCKseJFnyFl44KxTBNbuQWgVgjcXCBWMf0GdHzriWWd14
         7Nr66NYgpm4RJ8Mi0FXmLLfn1DNkPm+3+AhaY5fqKKMSNQntGVpMucsbsAwDuJaWvwyn
         IF01pLnZdhZAyp0hNScMMfdw/9BtzN0Xu8XMKI61KITZua/IB0wxX9+TFllZHhQ4E6eE
         iBMA==
X-Gm-Message-State: AOJu0YwagWChKZpk9aLNLyV8EiBXRcBLWi743AVDD/j1aECu/3OBToX1
	KXtl2gxcT7IiRWoRPx85C4xFe+V9YGv5dfHiWK8KNk27MJi7fq30MyCxe7JZsjWrxrQdRyJmXjX
	qDBcvSuWFir2wO3nLkWkUkm6VS3xZwhaSXaS7xJs4Wb8BA8hnxywMm8bF2VWLlA7WOYrLQkjzui
	3QEBM07FG7q6eAkfbPW65E73S1KnGIHX/qSXki9yI=
X-Gm-Gg: ASbGncsL2nkA1Z8jkDPEJwQWKk5101hgQaAxl/N8HhviEJ5IwqldbBF8sSXiwYlHccV
	W8Ltj53K6MY61cCKf+7AtbEb5683hk0cQzElvRxogDa72P9w4xvvPehiI0932CS1AuWb6TQ==
X-Received: by 2002:a17:90b:4c92:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-301a5b12f2cmr456110a91.10.1742258873519;
        Mon, 17 Mar 2025 17:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzHqvPHhOWayxt9nOn+uABgh4pj7w82asDqMrwDQrO6X0w+kGSrD+YsTLhPM5iW1l3zRKfAFj+h8otb7DW0Pk=
X-Received: by 2002:a17:90b:4c92:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-301a5b12f2cmr456092a91.10.1742258873172; Mon, 17 Mar 2025
 17:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-2-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-2-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:47:41 +0800
X-Gm-Features: AQ5f1Jps6JQeDE5rVwNMXQm81xnyDS129cpfEryeka1nOPKDMf2qheCIDs5KSLc
Message-ID: <CACGkMEvDk-GzpVMPJPEJLRSrJjVHFsbXsd7LB9MjNEghbUc5pw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] vhost-scsi: protect vq->log_used with vq->mutex
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kLjrlAcImt6mR1w8XQOqeOmgRklOqxj3pgyxM1iiO-o_1742258873
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:51=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> The vhost-scsi completion path may access vq->log_base when vq->log_used =
is
> already set to false.
>
>     vhost-thread                       QEMU-thread
>
> vhost_scsi_complete_cmd_work()
> -> vhost_add_used()
>    -> vhost_add_used_n()
>       if (unlikely(vq->log_used))
>                                       QEMU disables vq->log_used
>                                       via VHOST_SET_VRING_ADDR.
>                                       mutex_lock(&vq->mutex);
>                                       vq->log_used =3D false now!
>                                       mutex_unlock(&vq->mutex);
>
>                                       QEMU gfree(vq->log_base)
>         log_used()
>         -> log_write(vq->log_base)
>
> Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can =
be
> reclaimed via gfree(). As a result, this causes invalid memory writes to
> QEMU userspace.
>
> The control queue path has the same issue.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

