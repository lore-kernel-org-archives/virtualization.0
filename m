Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD74CB2B
	for <virtualization@lists.linux.dev>; Wed,  3 Apr 2024 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124514; cv=none; b=jpk5CXP48M5TW0Yp/F5ATg5ad8dTYptEDhieiADX0LDwwggFv+UD/fPXLF3LAGUtpS3IRXg5xfTccUJOj28KviJ4toqP3Ka0DwrJhC2Erro2fQQ8jiIr6AgxEOfZg2IDJijHM1ZiKiLS6ofakuN43YxVu9CH3zlfTISPGbHTmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124514; c=relaxed/simple;
	bh=n+K/WKHKa56zG0gtzaNGqEcUES/pcfC2imzCQDemtFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXinvMSOEQ0/5EMMwbBCKRM05iMrxxOdnrC4efi0kgeyvtzfhtvqBUQv0v+a8UUfsmJXLj7C52zzn2yVzTx8fPcYMO7EAC5TB7QOJ28q3qgz5IHNos2rCti28J8OBmVGrEVkF47D405/N9uTRu2W04Kd6x8W9xUAK/qMP1N1HSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Carb0pZQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Carb0pZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712124511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKiObTP8y8JIszvzACHMM1F2zBJdbISLN+XkZvP60BM=;
	b=Carb0pZQmaAU8cEFbY1jKHRcL51vs3qvVNVDS3RIMAnXHNeiroiHHF99HCaE65JkCWL6o3
	orC481Dwhk/jBTTGwbeSFJpPiej1zdMRGkI3iGS45b9Aspju1830DNJNRtInuHRp3YetQM
	Gio+3AbsS6X3yHoMU1e9UMWtrsyYhY0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-p1UVSz_xNsOvTvOacRGxPg-1; Wed, 03 Apr 2024 02:08:30 -0400
X-MC-Unique: p1UVSz_xNsOvTvOacRGxPg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-60cbba6fa0bso101104847b3.3
        for <virtualization@lists.linux.dev>; Tue, 02 Apr 2024 23:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712124509; x=1712729309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKiObTP8y8JIszvzACHMM1F2zBJdbISLN+XkZvP60BM=;
        b=KG1ZkRgWKjH9Oki6QFKf8hoBroXhN64/egMByVXO9G1C/7dcleiBChG/pSncT/kclt
         HtOAV7XDk27fsILooaKdlBCZuf7juDb6PNjVg6esVuVRHccnwvbJ9ofVOKg7/IqSZimV
         LdgKimq6TwQFynmIbPrVG+Yv0alKswJb/u3rb8ihJUdCB33nLxXadkY/eX/PeFSyF37H
         mOxtFTeaGlRPXIID31joZ1SAuf3WwHEUjX5beja1ETPnvDR5sWTEMv4G88dVMjetuQtu
         NapRfoNsIzBM6I+G+I6tgrLOUMMWRjhKagc8jHWybLcynnfsK9Z7Ui1UNGMehbUsdvB0
         /XKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe0IR+r5rIzKxf9jf0hfZbJobETuGhCQXzooLa8AlUs3FgpdfRXPC2zqYiJZ3Bw6DBOAa9uHYtjp4j6tfPz8DqlQPqkDypPhqALU0cyqE=
X-Gm-Message-State: AOJu0Yy55J8tIZzZ6BxXTscIxl3oLiC9CpptoRH2zxzcayjNIRwX7OCy
	ewLsGkrvDyDRng60Gy87lJYX7cQiuu/l4UgZKVQ5va+3NPd726hYo7mJ/Gi5yhVB1gQwTISHW4P
	DRQDjUm2RBOkrnvbVH0UkRe/r1WleVQCkm2+m9UBZHmXHiRMsKnTeM88rruJvgxqLuxYaASVyTg
	NSY5Oczgk6czALVFmtSx14+ToiUQ1xT/qyUgdn/CA=
X-Received: by 2002:a25:8d81:0:b0:dc7:4ad4:c977 with SMTP id o1-20020a258d81000000b00dc74ad4c977mr11567592ybl.25.1712124509552;
        Tue, 02 Apr 2024 23:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLucByfZxTlPvL5mn2OuVfkSkFpPoYO9hN2EI2zakPuPYMkYPkNEVffrYwZ3CRZp1u0dhS7qJEshPNUUMJLuQ=
X-Received: by 2002:a25:8d81:0:b0:dc7:4ad4:c977 with SMTP id
 o1-20020a258d81000000b00dc74ad4c977mr11567576ybl.25.1712124509222; Tue, 02
 Apr 2024 23:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
In-Reply-To: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Apr 2024 08:07:53 +0200
Message-ID: <CAJaqyWd+MsOc=ac_Ns=L0xtQ9iTX-0_sbREokRQnnjr_aHF6fQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Zhu Lingshan <lingshan.zhu@intel.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
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
> Fixes: 1496c47065f9 ("vhost-vdpa: uapi to support reporting per vq size")
> Cc: "Zhu Lingshan" <lingshan.zhu@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

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

