Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D593CCFD4
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018826; cv=pass; b=QuVkYwco3/MNpQ9iKXi1L9a94qFYu6J7w/q4VFTQFPy4b1TnnwzD55q7n3uY3LSty0gJyKkbi7HDyaY8yXWqk42D4OgSifr/btSb2oN31n4EJDfuzsBIdTDzbRnn/j4dcIGjznLtmk5GUwXRTsFINGI/NNjaW6/0MKgjteLd9HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018826; c=relaxed/simple;
	bh=T//X4/fJkR1oeZd4ePkbHp1KaPM7ugaGmDaRiFm/0I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOUXBfHq8i9OYV6TW3MBDhmZ0SQua/iRZzEQylH1qmQ4ftHVS0I2TbvOgo2KjHfnQCJt89yM3CP6Vm0q1HigVUSe969+gfEK38bE3eLM2lLqg6H1/p3abPPfRAl/jbrb3D7BH1qOBAVDE0sQNYqpU10ZkrVpTetqPe/ciLVAQMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANkZmHgO; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANkZmHgO"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so958847a12.1
        for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 08:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774018819; cv=none;
        d=google.com; s=arc-20240605;
        b=ORvZRO3V8L3XBjkH5NxNKWWuoQEKyeQuAc6cQxOZOyEoHKVk3jK/udZ2HEIdDR2c4J
         K2zDhhQaOeF3d572KnLKpQ0sf9hxYJ3eu1eQ67NLALpTgtfwz+WizKHE8XoHr7tR762T
         TlSxnf/JNsA2/fEvVp7MCVjUeMt0hmXUimhp4HthJ/YOxRdOKBlB3ydn1Bnm0fclrK0Z
         m/FJhC/z2xrP19r+4tmFRJG4hGZ93TrBP9OjhkFueyhbsWp3GnRvJfcgNol/398PLhGj
         I3VpN7cfeLh7BZJlAUcLjYS3D6PfqmfU4FUH1mUm9T5LL9E7QneWRZ1bJsnk+Xww33/I
         y8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OqajqpvSgf8sKnTU17XNoO03H85xM7YFWH1WJ0jdhSk=;
        fh=IYl3nL8gg+dhXIvTK70I8lBB6/iD83xcYpwLP6OHGck=;
        b=ApUldYvmVAy3W9ZJksna+kk8KX2KROmd2ouQkC1tVSNgQr2u/JXQci7NW1zPaB5XGe
         ZNlEbNrNxMAzydYoY4LXi91AJRIioQ9OADfve2kCE/HH4pqmZbHJeQDM6I30IjKk3dHA
         CplK88R9fL1Dn4Shh/g8z0FkJmLfANa2QY3iVC5cMoTbheAJ9Z+OuWBMs2C2ZfNWvjoB
         tLxs2d7oNC/J6WZrglvVeTKbk/+gbLzhpSa8fJ3QNpf2TJTk4XAXxL8vEV/sg/lSppiR
         l0N8QI5N1TIObMzmAdli2FLlkII9SHBEHYgvuamEuEJ3jyD2teQdRSGF2g4rmU1IrcyS
         q9dQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018819; x=1774623619; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqajqpvSgf8sKnTU17XNoO03H85xM7YFWH1WJ0jdhSk=;
        b=ANkZmHgOsb5xYxaMK9K1oucrXhyGUkHaqZU823cIl2eUTPKq6Y3cWSR2yW8RbFJGyR
         jyRlPoLBsKCxFQFtSSRWwMd7RtrsqsitjDHjzvaPiVV/QiKhItIx8jaaEhx52YgZdtdT
         7PvRzh372MURvYWdIFo+TZ4izjbQO/mBBcPJaZIu+7j5ZxtHc0Bc6jrnLXprRRGcKTqL
         Z8ASNIggHlypFAkkJCBfigCiviXEmg78c47flUpPVdUxzsZh+N/ow288GLWxSiC7bHiA
         Yd/WjHY/w6IWP+Fd7/ao4Jc6NSRJRW22Kvm1YRC79BdpqC1/pzM6Lv46Figw2w7PmVzk
         4DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018819; x=1774623619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqajqpvSgf8sKnTU17XNoO03H85xM7YFWH1WJ0jdhSk=;
        b=WRRxdWOlLwMBXxq3hEuPj3kF64XD27CW2c/NDQ0M5fVXmJtYKIgKHfSek0iBOEXBwj
         E6JZ4dkTNG3rflf/4kVlA2BgXgSvVEHLrG/rLGcYKhTaM/mYegGRTCEqGWe5fhHM7ysp
         b2kj65SQNji5YFKlIV9pke+NsdmeDKDxax1ubrFq3y7kRD48OguFpyd2o7zac4kEYkra
         BM1K8+i2VT3JTgzjMTEylAYS39cvGuMNdaSAwKwuN4MYimrZ7rcUaYJQvUCSUqwE/7Rm
         PtqjtUBf7fm2oQvozuOG8J/uKWcSa6CveUuefvXSzj6SoO0lNSFGn+dsPxbr2Nac9BxY
         wqTg==
X-Forwarded-Encrypted: i=1; AJvYcCWQBmigxA/ShP7Pnr94gtpMUyG7+4nVQEt1ZPp8IIJ3YkTngRdqjqChilN0olRaQf/AtovMNgYEW7MMc/ESpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHBXF1ba69liO9i1JQcBFeV9J1VGjmIDdC9a+5YKByPAH0oUkE
	wWZfd2fyGaAfI2hBOoAOCbdYr3E2gp+krv5ol/ukWhmXVdvYEZ+G6fD4JPjL6A5pq0YNh/qGZZh
	0BIBnKIAEJY6yLRSomgiQjSMQWusT+Ak=
X-Gm-Gg: ATEYQzx9CHThjtxVGV+OHxLMY074tP+Qtn2dCmccdvFpjVrjF4HTP6fYfEzwQq2pQ6D
	vXM4Vdu8Xukg1A1UAaJdgSaPlEDvISVrhY1nH73uHdFKotbv2y09XnseZ2WlsLXUPzOWKqh/9MH
	4l7xTKH43YESC9YhH++F61OIrKXO6nrJ04cGr5IRPibgxM2QdrVAMSWcW1v6an0SX4dX+MVjGUD
	DdzEzSZ3UpqpHLlHMXtsytVDk9SXPw1+TtEFCm2KBrNKcQnCcnOONNIfFszEAsjvqR79oML9WKK
	Bv5XVB7SciLjxxBeRovIAFFm6sPkGHBAek8shw==
X-Received: by 2002:a05:6402:278f:b0:668:50eb:bcb4 with SMTP id
 4fb4d7f45d1cf-668ca30bfdamr2648714a12.25.1774018818532; Fri, 20 Mar 2026
 08:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260319025609.10721-1-liwang@kylinos.cn>
In-Reply-To: <20260319025609.10721-1-liwang@kylinos.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Mar 2026 11:00:05 -0400
X-Gm-Features: AaiRm51A69MYmUGOXnhjmFUpFf9waVwNEvtB-ds7Ig0pLeHbNnczwyxWNEa8KKc
Message-ID: <CAJSP0QXErw8yDeCnOgK6jco1-yDpS5x73vQLMtrj7oy7JxNEFg@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Verify that server properly follows FUSE protocol
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 10:58=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> Verify that server properly follows FUSE protocol, by checking
> oh.uniq and oh.len.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/virtio_fs.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Earlier patch series addressing this:
- https://lore.kernel.org/all/20251028200311.40372-1-brajeshpatil11@gmail.c=
om/
- https://lore.kernel.org/all/20260216073158.75151-1-ytohnuki@amazon.com/

The second one was applied and I think your version conflicts with it.

Please take a look and let us know whether you want to drop your patch
or send a v2 rebased on Miklos latest tree
(https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git).

Thanks,
Stefan

>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 057e65b51b99..c30f6f58664c 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -768,10 +768,34 @@ static void virtio_fs_request_complete(struct fuse_=
req *req,
>         struct folio *folio;
>
>         /*
> -        * TODO verify that server properly follows FUSE protocol
> +        * Verify that server properly follows FUSE protocol
>          * (oh.uniq, oh.len)
>          */
>         args =3D req->args;
> +       if (test_bit(FR_ISREPLY, &req->flags)) {
> +               struct fuse_out_header *oh =3D &req->out.h;
> +
> +               if (unlikely(oh->unique !=3D req->in.h.unique)) {
> +                       pr_warn_ratelimited("virtio-fs: bad reply unique =
%llu (expected %llu)\n",
> +                                           oh->unique, req->in.h.unique)=
;
> +                       oh->error =3D -EIO;
> +                       oh->len =3D sizeof(*oh);
> +                       goto out;
> +               }
> +               unsigned int num_out =3D args->out_numargs - args->out_pa=
ges;
> +               unsigned int cap =3D sizeof(req->out.h);
> +
> +               cap +=3D fuse_len_args(num_out, args->out_args);
> +               if (args->out_pages)
> +                       cap +=3D args->out_args[args->out_numargs - 1].si=
ze;
> +               if (unlikely(oh->len < sizeof(*oh) || oh->len > cap)) {
> +                       pr_warn_ratelimited("virtio-fs: bad reply len %u =
(cap %u)\n",
> +                                           oh->len, cap);
> +                       oh->error =3D -EIO;
> +                       oh->len =3D sizeof(*oh);
> +                       goto out;
> +               }
> +       }
>         copy_args_from_argbuf(args, req);
>
>         if (args->out_pages && args->page_zeroing) {
> @@ -790,6 +814,7 @@ static void virtio_fs_request_complete(struct fuse_re=
q *req,
>                 }
>         }
>
> +out:
>         clear_bit(FR_SENT, &req->flags);
>
>         fuse_request_end(req);
> --
> 2.34.1
>
>
