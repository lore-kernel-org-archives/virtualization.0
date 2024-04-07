Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD048485
	for <virtualization@lists.linux.dev>; Sun,  7 Apr 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712459580; cv=none; b=qr+H9fvW7Uz71ENwksPPtUwiBEXZTMH2gd0lVuk9iIqd3OTIPStk0Sa25bABFKDRk8pJFeCAgofwuBS5xVZ3DZlzgIuy5XVbrX8+CNtqSgXVPFifNfq+w2PiEAc8JiyTs3kAT0FVNrkrsi5AajOa/k4ku4gDP9BPCaIELWc9rQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712459580; c=relaxed/simple;
	bh=TiIS2U0Z+wfIv7YPyJrbBALHfW6m6U5jca6+YzZuA6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDaBd5SP/tr459NMrk+cUyW/aDAsJvI9uHAp93VT//sfcijO3u7X6IetgwnIuP30U2CQIkGi3MdczTJcbDqAcJIZ48P/lfrk6qB7+Ma2But2psUa/S4PQ0pc8EBWTMadt+WTfMh43Z67TQoV9GujBAfUGsqrOWUbm4iPSRr9ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lq1lBg3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq1lBg3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712459577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJmu/t6Sirl2odpSd1zSsNcSzxnsR4Ufnqv6dslmQe4=;
	b=Lq1lBg3jJm4jSUZ/GIybfSzzCE26MTKnCVqw0hSGyOdu24+V6lWeAYxS/TkDmBJ77QmJLZ
	kpHGTc1SAkhKphabBVWH/1aLJ+lY9Ahi/x13TStguXFh4teN8N2U21QE5+BuDJeSd6f/O+
	MRsp/dwwQXaBBH1pqoe3/XaPqWl5ih8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-vJHIx-m2PqyNRSpv1WSXyg-1; Sat, 06 Apr 2024 23:12:55 -0400
X-MC-Unique: vJHIx-m2PqyNRSpv1WSXyg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-22ee151dc4bso1299971fac.1
        for <virtualization@lists.linux.dev>; Sat, 06 Apr 2024 20:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712459575; x=1713064375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJmu/t6Sirl2odpSd1zSsNcSzxnsR4Ufnqv6dslmQe4=;
        b=Lx1yCWRKAdFHYat4Ccf+6ygkExwycZ4XIXPvvYSOBVoCNlmsOiNngYtdy+/faxG8Lt
         Ps7dEuJ/RDYfRNmZ8O6sBd077ZLc632zrNSyx6fi54T+XSHuPcwj3lJqPwqDWMu+18hd
         Vf+4Q/pF3EEiNRdOvZH30V3e/MSQVqKARzggYb+hMv5VoxZVnx7ikiu2wINpUwp0pyLT
         TgaQdhVMXc2BWuD/iqn31LXw48IwfaRpKGp7G+UIuOooaQYhmNQLlngPrgq1+sFyf9a+
         mXGYGek78rgnsD76zW7bS8maAsYQ3RX9sVicnZmuYALVQa7fT8qV+RUpgcWCfBPFu38N
         t7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV/WaiVxXdKVqwGbd72xjtJVEHMTcgxKMsIqweqy1hIhHbm7N5LbNf4Xv7IMWbMzGZwlU1GUsyInWo6O65gnsBA5p25YUPrRPhNMNPxfj8=
X-Gm-Message-State: AOJu0YzZ2I3+hMDGEdWJdXclz128C2SlMkeB1tTWcFDRMzeQlov0QwDN
	wUAAjUqBiyFNz5Ewsdke2UrAMGzmMVxjxHv/2TnDLLTA3aYmb2EmlOsLMn1AAb3BJ2jttIdMAqT
	nygKHNbSxXEWP/HuO49EFxkNI56pr5Ddalv5qacmR9hqAsVeP1aAAze9QQN3H8srJjcUMuMeCEI
	y07hd3v+TxwZs7PaAa/dGKAZM5necylaK72K1Cquw=
X-Received: by 2002:a05:6871:6a5:b0:22e:ae01:db2f with SMTP id l37-20020a05687106a500b0022eae01db2fmr5926304oao.36.1712459575181;
        Sat, 06 Apr 2024 20:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxJaq7stpKgMSraYoLMx3TodA+2coKA76eR/QIAcIB6lXcpj5+7p+9fIFMZ3XBRdEPZlKh8jIwI46m3wMubro=
X-Received: by 2002:a05:6871:6a5:b0:22e:ae01:db2f with SMTP id
 l37-20020a05687106a500b0022eae01db2fmr5926294oao.36.1712459574910; Sat, 06
 Apr 2024 20:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
In-Reply-To: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 11:12:43 +0800
Message-ID: <CACGkMEuBt9BvUSr0hhSx4obX9SmiZgze8eK7Omujx1LBDgWz4A@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Zhu Lingshan <lingshan.zhu@intel.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:21=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> VDPA_GET_VRING_SIZE by mistake uses the already occupied
> ioctl # 0x80 and we never noticed - it happens to work
> because the direction and size are different, but confuses
> tools such as perf which like to look at just the number,
> and breaks the extra robustness of the ioctl numbering macros.
>
> To fix, sort the entries and renumber the ioctl - not too late
> since it wasn't in any released kernels yet.
>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Fixes: x ("vhost-vdpa: uapi to support reporting per vq size")
> Cc: "Zhu Lingshan" <lingshan.zhu@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>
> Build tested only - userspace patches using this will have to adjust.
> I will merge this in a week or so unless I hear otherwise,
> and afterwards perf can update there header.
>
>  include/uapi/linux/vhost.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index bea697390613..b95dd84eef2d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -179,12 +179,6 @@
>  /* Get the config size */
>  #define VHOST_VDPA_GET_CONFIG_SIZE     _IOR(VHOST_VIRTIO, 0x79, __u32)
>
> -/* Get the count of all virtqueues */
> -#define VHOST_VDPA_GET_VQS_COUNT       _IOR(VHOST_VIRTIO, 0x80, __u32)
> -
> -/* Get the number of virtqueue groups. */
> -#define VHOST_VDPA_GET_GROUP_NUM       _IOR(VHOST_VIRTIO, 0x81, __u32)
> -
>  /* Get the number of address spaces. */
>  #define VHOST_VDPA_GET_AS_NUM          _IOR(VHOST_VIRTIO, 0x7A, unsigned=
 int)
>
> @@ -228,10 +222,17 @@
>  #define VHOST_VDPA_GET_VRING_DESC_GROUP        _IOWR(VHOST_VIRTIO, 0x7F,=
       \
>                                               struct vhost_vring_state)
>
> +
> +/* Get the count of all virtqueues */
> +#define VHOST_VDPA_GET_VQS_COUNT       _IOR(VHOST_VIRTIO, 0x80, __u32)
> +
> +/* Get the number of virtqueue groups. */
> +#define VHOST_VDPA_GET_GROUP_NUM       _IOR(VHOST_VIRTIO, 0x81, __u32)
> +
>  /* Get the queue size of a specific virtqueue.
>   * userspace set the vring index in vhost_vring_state.index
>   * kernel set the queue size in vhost_vring_state.num
>   */
> -#define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x80,       \
> +#define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,       \
>                                               struct vhost_vring_state)
>  #endif
> --
> MST
>

