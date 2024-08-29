Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66E1AD3E6
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939016; cv=none; b=V6HmDhHRGC0dZxD5eZxFBkBciUmdV8uqsS4kXJy/SC8TKcusZGEA0bAsh+aTLMawuv9hax3EqeeVoinw8CkHGnShQoqTh9EBPS+Q6/7Zaiv3kI+4gwjMT4Jhkr2OrepHMk47TfIVb5ONqcSeMDVOl0aJK00OdtDiK4U8hkHMvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939016; c=relaxed/simple;
	bh=giGBQU+sQEwpl2UxJ2qyqRaobzqGFI9NezCBLi0vtgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCukzoL6j13R3SVn5Uae+qMX34QP8rnjp1+loXVsdyRNZJWl+CGNDJY6KbouD9FKNCGGasPUHvRgmI6sb4ztebmdNi5ma0Q0xWjT9PW37WGbX99hruRQjbPhJpTGNXxZngAsf4TCRb2rljbQ5xUUDJV3mVwKRlkPTJWox9BAZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOwdxnFg; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOwdxnFg"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AF2240B5F
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 13:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ILmrR-Pdz1m for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Aug 2024 13:43:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2027640118
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2027640118
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dOwdxnFg
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2027640118
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724939010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0Z2TTAubebcI3yRFy8BOcjudxXHokyVQvE7gs+dc9U=;
	b=dOwdxnFgpxcV0siWqYFcTfF4yrQxpWE25njpiLQuEqPobMXmCmu04ILypjTM8+q4Xj4Zsk
	6nSlf1wmVP2ZWojMIySHoYPXpBKrBMYsLPgbgGKOLtY4zGHNuvS8+9dncnz7ppLa6fS76v
	wd4LVLup5YAZ4TBG8/alsOlSdvEB+ws=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-KZF1yZVFOkCvaavlf3tDQg-1; Thu, 29 Aug 2024 09:43:21 -0400
X-MC-Unique: KZF1yZVFOkCvaavlf3tDQg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6b3825748c2so15357787b3.2
        for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939001; x=1725543801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Z2TTAubebcI3yRFy8BOcjudxXHokyVQvE7gs+dc9U=;
        b=I7Ts3208LLv6z2rPD+Ck9hCDvSdOeS+vOe/NIXTAsfkGk9xbXlCDNyp6W72DO2lBs7
         ucSkTNmwlNqw2tRBGOw5LK2PO/U9bLEfWpf7gN5+yiRBFzQyr0S+snCURJeBV6VDSrgI
         v4/Sa4IblbT100M9fYXny8Aw2GLJmtVy0DKUjHUy85TWRQQn6YhFaXDYJuxMVeHK4DUl
         XIU9RwmBMYzWoTdGCFAXU8FPi6XrDWkxS+7o+ytG9bEij3K3rummgaLLbWaEANSVN4G/
         zfNvsC/UaJRZ6uSY3Rh9WwOnT2SgASJwRXLq53tULtFDHUkRzb+VxvSFqj2j8jmoQZbK
         Ca6w==
X-Forwarded-Encrypted: i=1; AJvYcCXiCAv/DNLEpuBSzHZzyJppwBgPiwk8oGQ+jDEpknqiRzFBLk0+oiBYiP9j5Ho0Ok4eiEwSwnCUyIGQdYt9ZQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxpVBqVZPtii/DE1PMZnSsIidNAQCJw0l76lmLQ2m0EWpxTLOrV
	S3vLXNWX9YUM0cqK8g+z76Qcb0wJvInovFlj1y+Y045hFKYQDi0l1KCLyx8l15zOImz95Trb7QU
	CORopUsQfBb7DjPhNu0cmmp1qWR5Uc4wlzaa5CxlmF1fB2CMhl2WJo3TPHMmeRd8S/pGh0ULpgH
	ZIkqpC/p3J7YtxG2WPetuA0uNU7gLOudj3wE4aEMGiKrwqYMiw5lmE4w==
X-Received: by 2002:a05:690c:f03:b0:61b:1f0e:10 with SMTP id 00721157ae682-6d275964aecmr37487067b3.4.1724939001195;
        Thu, 29 Aug 2024 06:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKHkEXcfTNGzxGT7v9KMH1vSi8w5QzeRtQyq6gaTRJfFSbAnlIh//kHPNxfyUlcn8CoE1HLbBmIbGorcq3lvo=
X-Received: by 2002:a05:690c:f03:b0:61b:1f0e:10 with SMTP id
 00721157ae682-6d275964aecmr37486857b3.4.1724939000930; Thu, 29 Aug 2024
 06:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-4-dtatulea@nvidia.com>
In-Reply-To: <20240821114100.2261167-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 15:42:44 +0200
Message-ID: <CAJaqyWch9oNEYONUe=X0u02788Dey_8+_bF0sfiPZ7Yv53MVGA@mail.gmail.com>
Subject: Re: [PATCH vhost 2/7] vdpa/mlx5: Delete direct MKEYs in parallel
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:42=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Use the async interface to issue MTT MKEY deletion.
>
> This makes destroy_user_mr() on average 8x times faster.
> This number is also dependent on the size of the MR being
> deleted.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 66 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 66e6a15f823f..8cedf2969991 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -55,6 +55,11 @@ struct mlx5_create_mkey_mem {
>         DECLARE_FLEX_ARRAY(__be64, mtt);
>  };
>
> +struct mlx5_destroy_mkey_mem {
> +       u8 out[MLX5_ST_SZ_BYTES(destroy_mkey_out)];
> +       u8 in[MLX5_ST_SZ_BYTES(destroy_mkey_in)];
> +};
> +
>  static void fill_create_direct_mr(struct mlx5_vdpa_dev *mvdev,
>                                   struct mlx5_vdpa_direct_mr *mr,
>                                   struct mlx5_create_mkey_mem *mem)
> @@ -91,6 +96,17 @@ static void create_direct_mr_end(struct mlx5_vdpa_dev =
*mvdev,
>         mr->mr =3D mlx5_idx_to_mkey(mkey_index);
>  }
>
> +static void fill_destroy_direct_mr(struct mlx5_vdpa_dev *mvdev,
> +                                  struct mlx5_vdpa_direct_mr *mr,
> +                                  struct mlx5_destroy_mkey_mem *mem)
> +{
> +       void *in =3D &mem->in;
> +

Nit, isn't this declaration redundant? Looking at the definition of
MLX5_SET, the second argument is casted to (__be32 *) anyway.

> +       MLX5_SET(destroy_mkey_in, in, uid, mvdev->res.uid);
> +       MLX5_SET(destroy_mkey_in, in, opcode, MLX5_CMD_OP_DESTROY_MKEY);
> +       MLX5_SET(destroy_mkey_in, in, mkey_index, mlx5_mkey_to_idx(mr->mr=
));
> +}
> +
>  static void destroy_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_v=
dpa_direct_mr *mr)
>  {
>         if (!mr->mr)
> @@ -255,6 +271,55 @@ static int create_direct_keys(struct mlx5_vdpa_dev *=
mvdev, struct mlx5_vdpa_mr *
>         return err;
>  }
>
> +static int destroy_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_=
vdpa_mr *mr)
> +{
> +       struct mlx5_destroy_mkey_mem *cmd_mem;
> +       struct mlx5_vdpa_async_cmd *cmds;
> +       struct mlx5_vdpa_direct_mr *dmr;
> +       int err =3D 0;
> +       int i =3D 0;
> +
> +       cmds =3D kvcalloc(mr->num_directs, sizeof(*cmds), GFP_KERNEL);
> +       cmd_mem =3D kvcalloc(mr->num_directs, sizeof(*cmd_mem), GFP_KERNE=
L);
> +       if (!cmds || !cmd_mem) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       list_for_each_entry(dmr, &mr->head, list) {
> +               cmds[i].out =3D cmd_mem[i].out;
> +               cmds[i].outlen =3D sizeof(cmd_mem[i].out);
> +               cmds[i].in =3D cmd_mem[i].in;
> +               cmds[i].inlen =3D sizeof(cmd_mem[i].in);
> +               fill_destroy_direct_mr(mvdev, dmr, &cmd_mem[i]);
> +               i++;
> +       }
> +
> +       err =3D mlx5_vdpa_exec_async_cmds(mvdev, cmds, mr->num_directs);
> +       if (err) {
> +
> +               mlx5_vdpa_err(mvdev, "error issuing MTT mkey deletion for=
 direct mrs: %d\n", err);
> +               goto done;
> +       }
> +
> +       i =3D 0;
> +       list_for_each_entry(dmr, &mr->head, list) {
> +               struct mlx5_vdpa_async_cmd *cmd =3D &cmds[i++];
> +
> +               dmr->mr =3D 0;
> +               if (cmd->err) {
> +                       err =3D err ? err : cmd->err;
> +                       mlx5_vdpa_err(mvdev, "error deleting MTT mkey [0x=
%llx, 0x%llx]: %d\n",
> +                               dmr->start, dmr->end, cmd->err);
> +               }
> +       }
> +
> +done:
> +       kvfree(cmd_mem);
> +       kvfree(cmds);

Same nitpick here as in the previous patch about the Scope-based
Cleanup Helpers. Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +       return err;
> +}
> +
>  static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_=
vdpa_mr *mr)
>  {
>         int inlen;
> @@ -563,6 +628,7 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvd=
ev, struct mlx5_vdpa_mr *mr
>         struct mlx5_vdpa_direct_mr *n;
>
>         destroy_indirect_key(mvdev, mr);
> +       destroy_direct_keys(mvdev, mr);
>         list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
>                 list_del_init(&dmr->list);
>                 unmap_direct_mr(mvdev, dmr);
> --
> 2.45.1
>

