Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE43361DCB
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733296; cv=pass; b=uxIOMzP2du+kC+RmvRIadk2IOysGjPveoQezqAaBJyE87B3yltw5aRf3Kw12FUoi5Kvq4bb/qjptVYT9Z9qa6MKkRp+quPR16XyOGb//YGvD5//J7BrH+PQXX+nTIaz3L2IL4eZrTHETExI4FPbzHOo3213DZwCaIyVKAnZMPnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733296; c=relaxed/simple;
	bh=bGgTQXexaMUZVxmxmRTODsDlDix0mOZ0dyS6nk/xZjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJfsCtxPdcbdNr3916J72XdYAykpJ5f8p6kYuoPhfhWxLWylTE2SViLvnx3wPxgHT0gBAoNsVUd2a9eCanEJaQNbhi9Tj8TIXWejSoiJn1NMYcEQ6HJOUCNbWGdQOsCv7efRfh9ryJOjg5r5nVPIPG6tOn5EuMd5HF1lNRZW5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YszlGEsa; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YszlGEsa"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so15454445a12.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 08:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733293; cv=none;
        d=google.com; s=arc-20260327;
        b=ksYboE1bK1uwJSbTPrMN52rLzUx5GgLKJhDtzGbQ7P7Av4bteM3hP7MoUeg52ILD/e
         1AY4CL+wvpoTgyedSW5Gn+35YTrwJBkw7trRxNZ9NrKgUf55G3yLdjf/4eYCwbm+kaqk
         orGWKi+f6teaDug6r3rwOUvqqemu4SFCQvzhg+bnMW4zYaSc0/nCz05+R5czK/avQyaW
         k9m4SowVGw5Z0+0B2dtKdUVmHa/Oblxr59b1C2Tj0HgacmXdeoPxnInECMvBZeizoCj1
         JLdQBM8g95zeOZMtR6axOAB7GEaQSy2js+DpFfpN+R0zjWmJa93fGfaIsiDtsQpO9n4f
         1gTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5jBltnYvZaWbSQtBkyiLeAfwiYZjm0Y7WEn+J7RU7qk=;
        fh=2g7VkOgCR9jx1tSr0NqKtgU59fw6KyA9oRAmWMExtq0=;
        b=kJeRul7Mjp9rm6niAA9aoqWUDe0528hEzECdTlGLks8S3KL9MNYoVBAujWbJl8qzOR
         MeO4PkJJVDqlRws0S/n2XUdpd2tqECBxr76RnVu0ij8IBRXMkeJAmWkBlgFPUTl0UKcW
         O+1nLw6ORcIL41bi5n9ZnhAdZrYwLMHTlyxFeIvJLrzQ3IELWq7yMJSS3+jgF6jz4fH0
         1xcudXvBMFHbR69Uder2H5DBK3jAnF7sf/uUdapGPLLz/D3zo0e1hSVLPa10Mn2G/iAz
         d2Q5PpFAF6x+RJY9hFV/cokhInouDTjaxrF1K75ckX8zK+86L7UkhLNFobuA3jrFYMCY
         TrHQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784733293; x=1785338093; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jBltnYvZaWbSQtBkyiLeAfwiYZjm0Y7WEn+J7RU7qk=;
        b=YszlGEsaKe8O8blB1cvuFEOfmItGvz4+QsrZjj8gTRAlgLuXnPgw8YA1yY2/mR47BQ
         lZFg1WjHUOc2QNp+BbhkU6y3k9+u9d+L2+LHX1xRVc1FMpKf4MoD8IPGCyGXWsn0zc3Q
         2e+194HHGmPy5PkI8x/e7zPWNC9dBHmFMBa59wdmMg3eA3pUrJE/n02AYo598Fk/O5fl
         GfFULTasJqEb97kggm45VzqFjtAZrHsiKhC7ayZCMvgQSj/WSthdExN2jcGlkKz5ViDE
         z1Be8xJLB1tw4QYrf7RWQPBEYQQo1CJPcP8umJ/qYLvWhJSlA6pkonmxBraXnA+R6fGz
         jKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733293; x=1785338093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jBltnYvZaWbSQtBkyiLeAfwiYZjm0Y7WEn+J7RU7qk=;
        b=oa7M8Dh6M89R2n68b0vXDin08IV26kiM6wg735xtzF4lFVBdmWU89wXx8zFf+7Y5VN
         hegzbO6FGe+RziEDTWyAjarKsHSTuWR9LueLy//o/MofmGp6EUiSjKgLFlPm+jfq5M/y
         VXMNcykiEQ0SbXQphtEFHyJxiPtMNeN3KmvdQJiwGwb0jmWehoVLnCoVHhfY7o0QHHKh
         lm7rRTHE1kx0Lal1BtT9F7aBxMGVctip3BSNcatNWBqRSfcAG+qiwLc/H1O7sW9QFlyP
         btpkpZa57KkAyh9YMe7ogl8n93SfMQbRxS90VSrzG3ASMKbz/2OcJMB5TJHAhWc74Yhz
         V1rA==
X-Forwarded-Encrypted: i=1; AHgh+RpTesxrGRwuX8YIpUsvEWFKulj/1CfGk4C/AaRwbbExm9k5yyMWrjNSKVMvKXnlEuAQkb6oSDhtdaFF3KpAAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt6dq5Ghn3zdUKvRJQh38G4NWP9G9BJN9EaRWsUDvjzn3OLG/T
	9HUh/M+lq3g+Usnt3FkRmEpLA4yVXmZT2VaFunBbm3CvLaWaJSRD395557LCvXFW6tvZtDR1HlN
	Mqw2a2naowg570nP129VXuaFDvK/RD4M=
X-Gm-Gg: AR+sD11ogMxLzT2glA1qBNferjWx5z99v0rqADfhD0xuOjKkvL9JaIklRJNiWYiex+N
	YNBs06tu4ZCsHWD8vgoEjacuI378/9hmQb+1nCASY2Gs2s7kKYt9R8gJC90tVJ+FQOkVuhnxjiX
	VRQ4Bbq7zj3SsTB4zx8qRSG0xMNyflOZwn2Umk0nLv1wDISRJnWiFHgCLlDZEM4mp9leMMyn/Rq
	DyFFpohy5bzGvDGTX4vdXA/VNDRRMd0oOtO/Hriwd6mreH3LgqH+qPOhVgvwYoUryNMVw13666I
	6liyz9WbJffdEtx0b6dR
X-Received: by 2002:a05:6402:234f:b0:698:3b7b:e48b with SMTP id
 4fb4d7f45d1cf-69e652f8f0bmr8733772a12.33.1784733292473; Wed, 22 Jul 2026
 08:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260722063609.1546421-1-physicalmtea@gmail.com>
In-Reply-To: <20260722063609.1546421-1-physicalmtea@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 22 Jul 2026 11:14:39 -0400
X-Gm-Features: AUfX_mxnip1n59a4HRupWqE15wspcC5IuPhTMVkgIZO6ooPz8i07n-zmk1peQik
Message-ID: <CAJSP0QXMamS2rGRr4MtDM3ymtoH_DAD01NGkt4CjEJzZ6qbR5w@mail.gmail.com>
Subject: Re: [PATCH] vhost-scsi: fix T10-PI lifecycle hard BUG after endpoint
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 2:40=E2=80=AFAM Jia Jia <physicalmtea@gmail.com> wr=
ote:
>
> vhost_scsi_setup_vq_cmds() runs only from VHOST_SCSI_SET_ENDPOINT and
> allocates each command's protection scatterlist array (prot_sgl) only
> when VIRTIO_SCSI_F_T10_PI is already set at that moment.  Command pools
> are not rebuilt later.  vhost_scsi_set_features() may still flip that
> bit after the endpoint is live: it updates acked_features and returns
> success without reallocating prot_sgl.
>
> That is a feature-versus-resource lifetime mismatch.  The broken order
> is:
>
>   VHOST_SET_FEATURES(0)
>   VHOST_SCSI_SET_ENDPOINT
>       setup_vq_cmds() sees no T10-PI -> prot_sgl stays NULL
>   VHOST_SET_FEATURES(VIRTIO_SCSI_F_T10_PI)
>       only acked_features changes; command resources stay as above

VIRTIO_SCSI_F_T10_PI is defined in the VIRTIO spec. VIRTIO feature
bits do not change once negotiated. The device must be reset in order
to set the feature bits again.

VHOST_F_LOG_ALL is a vhost-specific feature bit that is not covered by
the VIRTIO spec and it can be changed at runtime. It is an exception.

Please generalize this fix to only allow VHOST_F_LOG_ALL to be changed
at runtime. Rather than protecting VIRTIO_SCSI_F_T10_PI specifically,
attempts to change feature bits other than VHOST_F_LOG_ALL once the
device is operational must be rejected.

Perhaps other vhost device implementations have the same issue?

Thanks,
Stefan

>   submit a T10-PI WRITE with a 129-page protection payload
>
> The I/O path then follows the new feature bit while using the old
> command objects.  vhost_scsi_mapal() (static, inlined into
> vhost_scsi_handle_vq() here) does:
>
>   sg_alloc_table_chained(table, 129, first_chunk=3DNULL,
>                          nents_first_chunk=3Dinline_sg_cnt)
>
> With first_chunk NULL, __sg_alloc_table() sets curr_max_ents from
> nents_first_chunk and calls sg_pool_alloc(129).  sg_pool_index() then
> hits:
>
>   BUG_ON(nents > SG_CHUNK_SIZE);   /* 129 > 128 */
>
> The kernel reported the following call trace and register state:
>
>   Call Trace:
>    <TASK>
>    ? __sg_alloc_table+0x1d8/0x250
>    ? __pfx_vhost_run_work_list+0x10/0x10 [vhost]
>    sg_alloc_table_chained+0x59/0xf0
>    ? __pfx_sg_pool_alloc+0x10/0x10
>    ? vhost_scsi_calc_sgls.constprop.0+0x43/0x60 [vhost_scsi]
>    vhost_scsi_handle_vq+0xf02/0x1700 [vhost_scsi]
>    ? __pfx_vhost_scsi_handle_vq+0x10/0x10 [vhost_scsi]
>    vhost_scsi_handle_kick+0x37/0x50 [vhost_scsi]
>    vhost_run_work_list+0x8e/0xd0 [vhost]
>    vhost_task_fn+0xe1/0x210
>    ret_from_fork+0x348/0x540
>    </TASK>
>
>   RIP: 0010:0x4
>   CR2: 0000000000000004
>   RSP: 0018:ffffc90000dbf940 EFLAGS: 00010202
>   RAX: ffffffff82396810 RBX: ffff88811dc28b80 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000081
>
> The host worker dies and the machine stops accepting network service
> until reset.  The missing object is prot_sgl after a post-endpoint
> T10-PI enable introduced by commit bf2d650391be ("vhost-scsi: Allocate
> T10 PI structs only when enabled").
>
> I also checked the other feature bits handled around endpoint setup.
> Only T10-PI allocates this endpoint-time per-command resource and does
> not rebuild it on a later SET_FEATURES.  LOG_ALL uses lazy tvc_log and
> already tears log storage down when cleared; HOTPLUG does not allocate
> prot_sgl.  So the chosen fix is to refuse T10-PI enable/disable while
> an endpoint is active, rather than adding a second rebuild path in
> set_features().
>
> Return -EBUSY if vs->vs_tpg is set and the T10-PI bit would change.
> Userspace must CLEAR_ENDPOINT, SET_FEATURES, then SET_ENDPOINT again so
> setup_vq_cmds() can allocate protection SGLs when needed.  That matches
> the existing "build command resources at endpoint" model.
>
> Fixes: bf2d650391be ("vhost-scsi: Allocate T10 PI structs only when enabl=
ed")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/scsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..000000000000 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2219,6 +2219,7 @@ static int vhost_scsi_set_features(struct vhost_scs=
i *vs, u64 features)
>  {
>         struct vhost_virtqueue *vq;
>         bool is_log, was_log;
> +       bool is_t10_pi, was_t10_pi;
>         int i;
>
>         if (features & ~VHOST_SCSI_FEATURES)
> @@ -2234,6 +2235,13 @@ static int vhost_scsi_set_features(struct vhost_sc=
si *vs, u64 features)
>         if (!vs->dev.nvqs)
>                 goto out;
>
> +       is_t10_pi =3D features & (1ULL << VIRTIO_SCSI_F_T10_PI);
> +       was_t10_pi =3D vhost_has_feature(&vs->vqs[0].vq, VIRTIO_SCSI_F_T1=
0_PI);
> +       if (vs->vs_tpg && is_t10_pi !=3D was_t10_pi) {
> +               mutex_unlock(&vs->dev.mutex);
> +               return -EBUSY;
> +       }
> +
>         is_log =3D features & (1 << VHOST_F_LOG_ALL);
>         /*
>          * All VQs should have same feature.
> --
> 2.43.0
>
