Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E995305664
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449159; cv=none; b=SXN1dbOaiCodMbCEIW39SgoEszX11zn95U5mikQr+M9N1GOOliR4VvjjdvpFICISKgxGZTayUvRChpDRULVtIab1HETBnGbUqA/lSPt0/4/Lwd6Nc7y6Mb6MHmAF8xzxdKMwEKPgGDxF+E8u/KGHX+FIZQgjxxYonL/x7Fs753o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449159; c=relaxed/simple;
	bh=hew4HRz7gzgRJeKz628QCtAAjpVgxSwsN73kAg0Vknc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=crDZIdSEDRyGi+6COY7T+7dMPYqqaxkacW4jmiFysRtsPVJUx3JEC/Lqi20LCUzPe5oaCE9NBrh+XOj9aCuqc04ZUt5JjsgrjEgrOhzd+Rn4SAQL3uVSVKiVAagrxe8lAaywXD4VF4uxUFDV9JDyjXfLVZLE3sWZ12l8ofC91ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=usy34K+q; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="usy34K+q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780449153; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=0eHa6yckhgnZ2thl9UQcY+7GqF4vYCBdsjgDzs/ErJM=;
	b=usy34K+qr3xda7SJlzWSduw2P05b4gAyQAUrh/3sqmD+Aq2XTBVPqkkbFwnXTimF+m5oJ3CGSkSph4dd4kZWdyihV6EBj4khNkkStFboTOFeS/xcoDZPaU1U8aGIOLdMM4fVLp8Se+HYrnmxbe1LARfdG/YXQPicq5aqgIM4fLg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X45YUKy_1780449151;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X45YUKy_1780449151 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 09:12:32 +0800
Message-ID: <1780448985.5299122-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Date: Wed, 3 Jun 2026 09:09:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: yangjiale <yangjiale133@163.com>
Cc: Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 yangjiale <yangjiale133@163.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260602043123.10207-1-yangjiale133@163.com>
In-Reply-To: <20260602043123.10207-1-yangjiale133@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue,  2 Jun 2026 12:31:23 +0800, yangjiale <yangjiale133@163.com> wrote:
> When a descriptor list spans across cache lines,
> updating the flag first can lead to a scenario where the device side
> perceives the flag as valid, yet the corresponding address and length
> fields remain unupdated=E2=80=94resulting in invalid values.
> Therefore, the flag field must be updated last.

Are you raising this based on your code review, or did you actually encount=
er an
issue during testing?

I don't think there is a problem here, as all operations are protected by t=
he
head desc flag. Even if cacheline effects cause data to be written prematur=
ely,
it shouldn't be an issue. The device must wait until the head desc flags
are updated before it can start any subsequent work.

Thanks.

>
> Signed-off-by: yangjiale <yangjiale133@163.com>
> ---
>  drivers/virtio/virtio_ring.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fbca7ce1c6bf..036b4f90d30f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vrin=
g_virtqueue *vq,
>  					     &addr, &len, premapped, attr))
>  				goto unmap_release;
>
> +			desc[i].addr =3D cpu_to_le64(addr);
> +			desc[i].len =3D cpu_to_le32(len);
> +			desc[i].id =3D cpu_to_le16(id);
> +
>  			flags =3D cpu_to_le16(vq->packed.avail_used_flags |
>  				    (++c =3D=3D total_sg ? 0 : VRING_DESC_F_NEXT) |
>  				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vrin=
g_virtqueue *vq,
>  			else
>  				desc[i].flags =3D flags;
>
> -			desc[i].addr =3D cpu_to_le64(addr);
> -			desc[i].len =3D cpu_to_le32(len);
> -			desc[i].id =3D cpu_to_le16(id);
> -
>  			if (unlikely(vq->use_map_api)) {
>  				vq->packed.desc_extra[curr].addr =3D premapped ?
>  					DMA_MAPPING_ERROR : addr;
> --
> 2.25.1
>
