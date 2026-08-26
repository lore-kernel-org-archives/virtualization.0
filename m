Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9C202F70
	for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735559; cv=none; b=J7HvFpzowkSQMCaKTwO3WoGc+Y4bKukZf2A3G32qfPVPaC1Sy1XUvfqlbRNoCxhrRMZhQb4fE+b1KRMAVuSgqhKVSiZFGtXn3WRd/sbLFlhwLMrCbMbQ0grj2Aqj+KoR6j8PRg4z1qG5qZzYeMigGBnCezBgbEgVI3EszgvcDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735559; c=relaxed/simple;
	bh=jJ0iCKXkupcWYCLLg3Q9qvJeq9MVivssXevwS9nM0IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqzTYYqz8SIEvhjfSMl5jb5IncOCp68OVkBn3QUxqjRwRBMbZIggZuGYgl84xD2N1mCHTbhyHlE3M8HvW0Qwm6M5V6S7eT6gJE+tIAg2I2oIrMluGLJLpVfBuDJkVMsK3BGqG+LBLaEGdVL/rJimr05oHQhZ+z/DEVlbYTUUEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiGCV/rA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiGCV/rA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787735556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYypDP23l8+z5GFtsi0b2m8IG1ywsJBjN6KvNksv8AU=;
	b=OiGCV/rArC7XE/jUkYEk7L3MOQcT0celJzhEMiMvC0uqOwD40bsjYHEn/cDfAMmQjpHTaQ
	F82wRGlRRO5sGVJDGbX6IWCDMMVkBvVUJypsfee/C4hbb11ZCYzSID8EQipWj5qMazQ1Nn
	5MUP8FlI2fq04qeAUiPZBmBcQ60ZE6o=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-VlmY8pKfPyeYivLblmB7IA-1; Wed, 26 Aug 2026 05:12:35 -0400
X-MC-Unique: VlmY8pKfPyeYivLblmB7IA-1
X-Mimecast-MFC-AGG-ID: VlmY8pKfPyeYivLblmB7IA_1787735555
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66d309b367dso11267d50.3
        for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 02:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735555; x=1788340355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYypDP23l8+z5GFtsi0b2m8IG1ywsJBjN6KvNksv8AU=;
        b=SOhWyaKRjLmKnKIh0nAJGPYbhiyQvTYcE+TPeb1AkH00FlTbx/OAWALhRxUTw1JjFS
         cyBYorugG96n5ineIplwes7rHWxJzj26QwiVuGCGopKRvEovhGCAuL3b42F/DegmDRdU
         hGivmiIsz1kMqr/HB4brG4XHLy7DwTYORuXaf6j98xxtofT4xIjSf/FH03K23sC/agnT
         uah17pfrBXEooYbVfXJnUAzwPIShSAm/OO9QVMwiu86038Gki4Zg/6qVSoPI9z5tM1KN
         Gu0QXP/kl8km7f8ky9PEfZ+uwRjGp8YA33S5Z/Myk4uz/fksuGBW+WtN9fXztd1iQkCn
         4lvg==
X-Forwarded-Encrypted: i=1; AHgh+RoaQBjxNj8+2bK16fIqg+7FJTg63/cBtU+b4gqnU5rouUulegRdMo/Es0Qb9q8LcfizVwMPfTXN3AApfveLNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l/Z/Vw/gpxe2nuKzXs0lyX7WVmSWWKCdhsu2tZQpt90uGHF/1V
	tgEpISLmybOAvliiTo/3NhGyfbbuJwtDvilqJUkcDAnaWGzGN1pJq7EJ8mzneISUSDSFhiZuQ02
	/snXMBRktMvKhM6jZDVj9ojlaOAinEOD30zESp7s0CMag/ztskdW3W+jRcO5LO57jWXBir7Za5l
	gGlkga9teC1BVoZuI8zuCUiFSekQh+1deVfE3ojH9Oc8E=
X-Gm-Gg: AR+sD11o5MEuEaXP8fPqJq/9BssVuEvpD+BmwoH56dv2wM7krlUDGLhMOAjKYSed+ev
	+ScE1ZUzva1oQ6xSKqZZ4MYAT49qTxPre7zXtlRnybITOzA+njX+DHk8kfBsKD0Ynf53A5TwEAM
	rqcxuej6807jpIEyFXlgCsoCGgfwE1wMlxWubj7ac42A8tnfwSK7un+VWKZHB8BY+gqGUB/D/Lx
	ycxJ2IIRpEBopgltVGMPfK/5spDFlTwu1zpxqpRXprgBrb9BBR2GgFsZyc=
X-Received: by 2002:a05:690e:1287:b0:66d:93e:f06b with SMTP id 956f58d0204a3-66d257a051amr1765856d50.38.1787735554614;
        Wed, 26 Aug 2026 02:12:34 -0700 (PDT)
X-Received: by 2002:a05:690e:1287:b0:66d:93e:f06b with SMTP id
 956f58d0204a3-66d257a051amr1765830d50.38.1787735554112; Wed, 26 Aug 2026
 02:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-4-graf@amazon.com>
In-Reply-To: <20260818211425.91009-4-graf@amazon.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Aug 2026 11:11:57 +0200
X-Gm-Features: AcwNN1XsZZTvVP8jUU_5cuFmNQLtjMqxb9_tgIM2DJA5YJgmKKz40xIfpGBt09U
Message-ID: <CAJaqyWcLjFyYFOQCTS-70obHGCx8R67oSSGZ+nNegHKYgiLWiw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] vdpa: drop the VIRTIO_DEVICE_F_MASK example value
To: Alexander Graf <graf@amazon.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Feng Liu <feliu@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Woeag_a7LZAnN3pxdP--uFWgtCgE50nJ6DAMznfXn6w_1787735555
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Alexander Graf <graf@amazon.com> w=
rote:
>
> The comment above VIRTIO_DEVICE_F_MASK spells the mask out by hand as
> 0xfffffc000fffffff, which was correct while VIRTIO_TRANSPORT_F_END was
> 41. The bound is 42 now, so the macro expands to 0xfffff8000fffffff and
> whoever reads the comment to check a feature mask against it gets the
> wrong boundary between transport and per-device bits.
>
> Correcting the number would leave a comment that has to be updated by
> hand every time the bound moves, and we already missed it once. Drop the
> expansion instead. The macro derives its value from the bound and needs
> no change.
>
> Fixes: 838bebb4c926 ("virtio: Define feature bit for administration virtq=
ueue")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I'm not sure if a Fixes is needed though, as it will cause backports
(which means work) that don't fix any code.

> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/vdpa/vdpa.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 47c6c3d23f5c..395ca549573a 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -548,10 +548,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, =
struct netlink_callback *cb)
>
>  /*
>   * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_=
START
> - * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
> - * all 64bit features. If the features are extended beyond 64 bits, or n=
ew
> - * "holes" are reserved for other type of features than per-device, this
> - * macro would have to be updated.
> + * through VIRTIO_TRANSPORT_F_END are unset. If the features are extende=
d
> + * beyond 64 bits, or new "holes" are reserved for other type of feature=
s
> + * than per-device, this macro would have to be updated.
>   */
>  #define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
>                               ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
>

