Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18B1B14EF
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944561; cv=none; b=DOmBU5KnqimxSVGeRtNo3TJk7xPZNtFAY/29hzZnC54CtOEH3UGhO8JfNSD3ohuRmZxFob+OwtSeG4hFy/e/1HX1KBjLU7rA4pXMw0SIgAIZySu9ffltjOiYTmISb0NwhpBiaw64i/Ar+TfCuLLZb8hsM6NqH90AH3QunTkEOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944561; c=relaxed/simple;
	bh=vdLEYwn3hyH0yYINE9e21Zqj01ES2SNI5IJDGg/dBag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7WKsIcr4xp8uSmcjOuVlL4fXcopjXsk1Kv4nnDBSDKKcBo2hNGaXXfSi5edqu97JtnGO4TdlKYCnPN5AjX91sMWjVrzt6AR4S/dttOa++RDOE+BFEQcyxrzFmB1VPJNjVLbBDVtv9qBByplXYrV975QOM8UirDJcBaMsajRFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqYxJ9Nj; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqYxJ9Nj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDDC140720
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 15:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYT5VGFfLWXP for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Aug 2024 15:15:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C8EF405E6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C8EF405E6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LqYxJ9Nj
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C8EF405E6
	for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emt4Aa5SKw7SFyxXUt2WM0K5CmZW1m3fJVEf3z1rDFo=;
	b=LqYxJ9NjA/knLb0TXBGsc2tNzgfVcOKgn5SY5mgHXfpLGaD6vXIzd7vlRa2GS5a+z04XZW
	jrblPMt2/V0OkU1oBGwF2ClOWgJE7dqhA2fzOT3APtAvNHnbhXLt7i+DQ2IIqo+WF2csEt
	Az4BpD7R6KMzAoHEG3PAO/zBA+iueD4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-FXqjz-1tOhO4apZonKzhxQ-1; Thu, 29 Aug 2024 11:15:56 -0400
X-MC-Unique: FXqjz-1tOhO4apZonKzhxQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f3f9517948so7216471fa.2
        for <virtualization@lists.linux-foundation.org>; Thu, 29 Aug 2024 08:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944550; x=1725549350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emt4Aa5SKw7SFyxXUt2WM0K5CmZW1m3fJVEf3z1rDFo=;
        b=pPJSfrzPyhi50DSbKlUXmfCupteeqeNmSK37ICmNgLwBp7XWwf78G9riSXuAVAojhr
         JhPDUcuiKNMCX/sUpSW0WFHH6FAEv1OqFN3Y5/KCB89mgRB2LjRICeFLrcdlqeEFRxtj
         PVxzr9KgpqzgXldPwN+MG59osbDZfUFGZmwfEBpFWMHm3c4pPCj4Zx9HgV6yvpEewIaF
         rWJm/46ZnOTMvpD+4+PmjgbOp19s28hp7Mz8Sm+2vf0ZhVZVKkqdJEmbq8xemVyCpTpl
         k+b8ecDKyJmbST+rezGDeY+EF8nAhnObWN4X9WFgMtPsPZ4/Ve6IviFY04vVUiouizow
         KMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9UAkcT2g8Wy1fYoTNO0sV4jP9brLBx5qyRS8eqfo0VQrGG/QgKS9vc39OFWelJIxZWNbEX97CjJF6POto3g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQ6q4FY7xVYzhZnYAszdBDJizwrZZ24neIzpF0DJVMReDh50I0
	DXMktggFI3XJCi3qPkSuxzr4GHjFuGINLNzlRm2+4BgwJ9OOpCj+CxJOoGiqNpsd+PIVyyY12eD
	XFQ9inA/hie4XpFI/bfjJVWRpF+Y24uI6dD8eVbKs7FDpWZad3MVWs/GVVm9eMSpbMaV8ddx/Aa
	tIaPjBaip2UkqdZzYG/oSzHQQFoNxLEr641kcx6Sfh4rX4RO3nnBModHukhvsS8OOe
X-Received: by 2002:a2e:b8cb:0:b0:2ef:1f10:e277 with SMTP id 38308e7fff4ca-2f610514501mr19411801fa.34.1724944550271;
        Thu, 29 Aug 2024 08:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF8w/FaX9C3ZPUAUun6keBH6CcxT9mb81J79vRsiAKre8bMCAbeIvA/LIXR16ficN/CS2MtvD/ssp4SVq+k7w=
X-Received: by 2002:a17:907:9688:b0:a86:b789:164b with SMTP id
 a640c23a62f3a-a897fad4543mr271625966b.58.1724944538225; Thu, 29 Aug 2024
 08:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821114100.2261167-2-dtatulea@nvidia.com> <20240821114100.2261167-3-dtatulea@nvidia.com>
 <CAJaqyWcFVLXg=nUdOJOviWA+TDfbqBeEHrVROVC1nYrO8+ZmhA@mail.gmail.com> <6935f3aa-9de5-4781-b823-30c17817cc86@nvidia.com>
In-Reply-To: <6935f3aa-9de5-4781-b823-30c17817cc86@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Aug 2024 17:15:00 +0200
Message-ID: <CAJaqyWcW2r9bos3CPxE4yZfZDORzki1SKSyODSgJRLXocOam1w@mail.gmail.com>
Subject: Re: [PATCH vhost 1/7] vdpa/mlx5: Create direct MKEYs in parallel
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, Gal Pressman <gal@nvidia.com>, 
	kvm list <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Michael Tsirkin <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:54=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 29.08.24 15:10, Eugenio Perez Martin wrote:
> > On Wed, Aug 21, 2024 at 1:41=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> >>
> >> Use the async interface to issue MTT MKEY creation.
> >> Extra care is taken at the allocation of FW input commands
> >> due to the MTT tables having variable sizes depending on
> >> MR.
> >>
> >> The indirect MKEY is still created synchronously at the
> >> end as the direct MKEYs need to be filled in.
> >>
> >> This makes create_user_mr() 3-5x faster, depending on
> >> the size of the MR.
> >>
> >> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> >> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> >> ---
> >>  drivers/vdpa/mlx5/core/mr.c | 118 +++++++++++++++++++++++++++++------=
-
> >>  1 file changed, 96 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> >> index 4758914ccf86..66e6a15f823f 100644
> >> --- a/drivers/vdpa/mlx5/core/mr.c
> >> +++ b/drivers/vdpa/mlx5/core/mr.c
> >> @@ -49,17 +49,18 @@ static void populate_mtts(struct mlx5_vdpa_direct_=
mr *mr, __be64 *mtt)
> >>         }
> >>  }
> >>
> >> -static int create_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_=
vdpa_direct_mr *mr)
> >> +struct mlx5_create_mkey_mem {
> >> +       u8 out[MLX5_ST_SZ_BYTES(create_mkey_out)];
> >> +       u8 in[MLX5_ST_SZ_BYTES(create_mkey_in)];
> >> +       DECLARE_FLEX_ARRAY(__be64, mtt);
> >
> > I may be missing something obvious, but why do we need
> > DECLARE_FLEX_ARRAY here? My understanding is that it is only needed in
> > special cases like uapi headers and we can use "__be64 mtt[]" here.
> >
> checkpatch.pl was complaining about it because in my initial version I
> used the "[0]" version of zero length based arrays.
>
> My impression was that DECLARE_FLEX_ARRAY is preferred option because it
> triggers a compiler error if the zero lenth array is not at the end of
> the struct. But on closer inspection I see that using the right C99
> empty brackets notation is enough to trigger this error.
> DECLARE_FLEX_ARRAY seems to be useful for the union case.
>
> I will change it in a v2.
>
> >> +};
> >> +
> >> +static void fill_create_direct_mr(struct mlx5_vdpa_dev *mvdev,
> >> +                                 struct mlx5_vdpa_direct_mr *mr,
> >> +                                 struct mlx5_create_mkey_mem *mem)
> >>  {
> >> -       int inlen;
> >> +       void *in =3D &mem->in;
> >>         void *mkc;
> >> -       void *in;
> >> -       int err;
> >> -
> >> -       inlen =3D MLX5_ST_SZ_BYTES(create_mkey_in) + roundup(MLX5_ST_S=
Z_BYTES(mtt) * mr->nsg, 16);
> >> -       in =3D kvzalloc(inlen, GFP_KERNEL);
> >> -       if (!in)
> >> -               return -ENOMEM;
> >>
> >>         MLX5_SET(create_mkey_in, in, uid, mvdev->res.uid);
> >>         mkc =3D MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry=
);
> >> @@ -76,18 +77,25 @@ static int create_direct_mr(struct mlx5_vdpa_dev *=
mvdev, struct mlx5_vdpa_direct
> >>         MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
> >>                  get_octo_len(mr->end - mr->start, mr->log_size));
> >>         populate_mtts(mr, MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt=
));
> >> -       err =3D mlx5_vdpa_create_mkey(mvdev, &mr->mr, in, inlen);
> >> -       kvfree(in);
> >> -       if (err) {
> >> -               mlx5_vdpa_warn(mvdev, "Failed to create direct MR\n");
> >> -               return err;
> >> -       }
> >>
> >> -       return 0;
> >> +       MLX5_SET(create_mkey_in, in, opcode, MLX5_CMD_OP_CREATE_MKEY);
> >> +       MLX5_SET(create_mkey_in, in, uid, mvdev->res.uid);
> >> +}
> >> +
> >> +static void create_direct_mr_end(struct mlx5_vdpa_dev *mvdev,
> >> +                                struct mlx5_vdpa_direct_mr *mr,
> >> +                                struct mlx5_create_mkey_mem *mem)
> >> +{
> >> +       u32 mkey_index =3D MLX5_GET(create_mkey_out, mem->out, mkey_in=
dex);
> >> +
> >> +       mr->mr =3D mlx5_idx_to_mkey(mkey_index);
> >>  }
> >>
> >>  static void destroy_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx=
5_vdpa_direct_mr *mr)
> >>  {
> >> +       if (!mr->mr)
> >> +               return;
> >> +
> >>         mlx5_vdpa_destroy_mkey(mvdev, mr->mr);
> >>  }
> >>
> >> @@ -179,6 +187,74 @@ static int klm_byte_size(int nklms)
> >>         return 16 * ALIGN(nklms, 4);
> >>  }
> >>
> >> +static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx=
5_vdpa_mr *mr)
> >> +{
> >> +       struct mlx5_vdpa_async_cmd *cmds =3D NULL;
> >> +       struct mlx5_vdpa_direct_mr *dmr;
> >> +       int err =3D 0;
> >> +       int i =3D 0;
> >> +
> >> +       cmds =3D kvcalloc(mr->num_directs, sizeof(*cmds), GFP_KERNEL);
> >> +       if (!cmds)
> >> +               return -ENOMEM;
> >
> > Nit: this could benefit from Scope-based Cleanup Helpers [1], as it
> > would make clear that memory is always removed at the end of the
> > function & could prevent errors if the function is modified in the
> > future. I'm a big fan of them so my opinion may be biased though :).
> >
> > It would be great to be able to remove the array members with that
> > too, but I think the kernel doesn't have any facility for that.
> >
> I didn't know about those. It sounds like a good idea! I will try
> to use them in v2.
>
> >> +
> >> +       list_for_each_entry(dmr, &mr->head, list) {
> >> +               struct mlx5_create_mkey_mem *cmd_mem;
> >> +               int mttlen, mttcount;
> >> +
> >> +               mttlen =3D roundup(MLX5_ST_SZ_BYTES(mtt) * dmr->nsg, 1=
6);
> >
> > I don't get the roundup here, I guess it is so the driver does not
> > send potentially uninitialized memory to the device? Maybe the 16
> > should be a macro?
> >
> The roundup is a hw requirement. A define would be a good idea. Will add
> it.
>
> >> +               mttcount =3D mttlen / sizeof(cmd_mem->mtt[0]);
> >> +               cmd_mem =3D kvcalloc(1, struct_size(cmd_mem, mtt, mttc=
ount), GFP_KERNEL);
> >> +               if (!cmd_mem) {
> >> +                       err =3D -ENOMEM;
> >> +                       goto done;
> >> +               }
> >> +
> >> +               cmds[i].out =3D cmd_mem->out;
> >> +               cmds[i].outlen =3D sizeof(cmd_mem->out);
> >> +               cmds[i].in =3D cmd_mem->in;
> >> +               cmds[i].inlen =3D struct_size(cmd_mem, mtt, mttcount);
> >> +
> >> +               fill_create_direct_mr(mvdev, dmr, cmd_mem);
> >> +
> >> +               i++;
> >> +       }
> >> +
> >> +       err =3D mlx5_vdpa_exec_async_cmds(mvdev, cmds, mr->num_directs=
);
> >> +       if (err) {
> >> +
> >> +               mlx5_vdpa_err(mvdev, "error issuing MTT mkey creation =
for direct mrs: %d\n", err);
> >> +               goto done;
> >> +       }
> >> +
> >> +       i =3D 0;
> >> +       list_for_each_entry(dmr, &mr->head, list) {
> >> +               struct mlx5_vdpa_async_cmd *cmd =3D &cmds[i++];
> >> +               struct mlx5_create_mkey_mem *cmd_mem;
> >> +
> >> +               cmd_mem =3D container_of(cmd->out, struct mlx5_create_=
mkey_mem, out);
> >> +
> >> +               if (!cmd->err) {
> >> +                       create_direct_mr_end(mvdev, dmr, cmd_mem);
> >
> > The caller function doesn't trust the result if we return an error.
> > Why not use the previous loop to call create_direct_mr_end? Am I
> > missing any side effect?
> >
> Which previous loop? We have the mkey value only after the command has
> been executed.

Ok, now I see what I proposed didn't make sense, thanks!

> I added the if here (instead of always calling
> create_direct_mr_end()) just to make things more explicit for the
> reader.
>
> >> +               } else {
> >> +                       err =3D err ? err : cmd->err;
> >> +                       mlx5_vdpa_err(mvdev, "error creating MTT mkey =
[0x%llx, 0x%llx]: %d\n",
> >> +                               dmr->start, dmr->end, cmd->err);
> >> +               }
> >> +       }
> >> +
> >> +done:
> >> +       for (i =3D i-1; i >=3D 0; i--) {
> >> +               struct mlx5_create_mkey_mem *cmd_mem;
> >> +
> >> +               cmd_mem =3D container_of(cmds[i].out, struct mlx5_crea=
te_mkey_mem, out);
> >> +               kvfree(cmd_mem);
> >> +       }
> >> +
> >> +       kvfree(cmds);
> >> +       return err;
> >> +}
> >> +
> >>  static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct ml=
x5_vdpa_mr *mr)
> >>  {
> >>         int inlen;
> >> @@ -279,14 +355,8 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mv=
dev, struct mlx5_vdpa_direct_mr
> >>                 goto err_map;
> >>         }
> >>
> >> -       err =3D create_direct_mr(mvdev, mr);
> >> -       if (err)
> >> -               goto err_direct;
> >> -
> >>         return 0;
> >>
> >> -err_direct:
> >> -       dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECT=
IONAL, 0);
> >>  err_map:
> >>         sg_free_table(&mr->sg_head);
> >>         return err;
> >> @@ -401,6 +471,10 @@ static int create_user_mr(struct mlx5_vdpa_dev *m=
vdev,
> >>         if (err)
> >>                 goto err_chain;
> >>
> >> +       err =3D create_direct_keys(mvdev, mr);
> >> +       if (err)
> >> +               goto err_chain;
> >> +
> >>         /* Create the memory key that defines the guests's address spa=
ce. This
> >>          * memory key refers to the direct keys that contain the MTT
> >>          * translations
> >> --
> >> 2.45.1
> >>
> >
>

