Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB71DEFC3
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969896; cv=none; b=XxVn49pS9EfiUNuaXYIY3DqDxC84YxNl44Ab3l+RkavtV1QmE05aUf/B6ZTIyr+nRCBqxycjDLdURWWZXZG5j2QDLiQyIZGdabjLSXqXQmNCK+I2e97p5VHS54WIX3TcSbVZ3vk75Z4aku3gYARUoHLTHzByZ5QN/3zC6Q78ZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969896; c=relaxed/simple;
	bh=XrCKTdSFrneJtpr4KeJ/1FrI8UZO5czXGK0I+q8xUNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDqx+DptZ70uvj8zq2vUKnlWegUSTgIp3qg/kCFbYb/6qHrvkXt4lspTi3wPRNwZhl4mt+jkW2apTSSULYQZCQ3ucoX0HP5rwUyJ4yukkRrsDzI20Z71UAuuI9lWvvU8QI0AGK7u65rT04WSRm/WkaOBv7yJQONEEhuPwx9VXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HjfR2w+q; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HjfR2w+q"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460da5a39fdso4494271cf.1
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730969893; x=1731574693; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I8US13aD05PtGROBNY39A0+lWIja+wUH11z2O2DFmBA=;
        b=HjfR2w+qtVQz97mLCGzya75MI5ayoujwGNypwHxJWZthw+NNhJrFH2aX9Vsp2evS8n
         IhWWSe4ySLHbkVoMH1nSQ4/Kpy0G/AHGWuAbg2jkoKV31Ffmepcsp/66/YiSNDbRPVd1
         BwwBGU9di5LhQ6aZyH6Gi17k3ZTIIIuEmYBxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969893; x=1731574693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8US13aD05PtGROBNY39A0+lWIja+wUH11z2O2DFmBA=;
        b=RSbdRTAe4w7xzurfRPbkDsNvfYEATATF+o+2su0hYaIh8eHYFeKqY8SWi1hr96wrUX
         rwnh5jM+ak4YHKHuurCEUjInmxCXff3ygB/wgOymLi3252T4KIPLh0S7AllLmzg9V+v/
         9XPB3wnaEzk9cgcL+E0jg6rJEU/ptGcLQh5KXgXDK9Qikk74qL9zKAwYaIT6LAwxo5Zy
         Dp/qHCIWjlfSdU4ZdzeR+PYY8AzmFlef4Td9q2qx9spsq1Kwndw231w6uaEYbALl8ZFr
         8y+cbkSkUtQnNTVAV9726O5k+lKPSBz0ObOtzqzhaXDTZTCj0JOzh6I8cYEjbOVdyqn3
         8rHw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5MZ3yzaqUaIEhCOZJy3WLT2APIxvjCrxG0jNEsQbVz029aj+HOmVDx5slx640LdLgvoBjM1wYooORl/viA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAB1olrgbBlCrbSou/Ctbho0C0/Zvrz4Cok/JG4anSLsYGq/MX
	8zZHjq5sFNk5EDAkUxkEgUoJjHnuJ/AXR2PcDlABnLDDCrZULPTpoXcTBegSNUr/uLSe255Y8C/
	vXQKU6Z/rPiZ7Y9l+GFVLnma6pEDXqNE0Bqm61g==
X-Google-Smtp-Source: AGHT+IHxPaWfeaWr7QYviaFixyD3GiKGEj6bLFLoEq9c1pZwSytCfLOCtXu+dknJoRl+41zTEmU1wKDp6CHqkFdc/0c=
X-Received: by 2002:a05:622a:1a0a:b0:462:f690:d202 with SMTP id
 d75a77b69052e-462f690d251mr43546551cf.40.1730969892756; Thu, 07 Nov 2024
 00:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com>
In-Reply-To: <20241024164726.77485-1-hreitz@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Nov 2024 09:58:02 +0100
Message-ID: <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 18:47, Hanna Czenczek <hreitz@redhat.com> wrote:

> To be able to issue INIT (and GETATTR), we need to at least partially
> initialize the super_block structure, which is currently done via
> fuse_fill_super_common().

What exactly is needed to be initialized?

> @@ -1762,18 +1801,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>         sb->s_d_op = &fuse_dentry_operations;
>
>         mutex_lock(&fuse_mutex);
> -       err = -EINVAL;
> -       if (ctx->fudptr && *ctx->fudptr)
> -               goto err_unlock;
> -
>         err = fuse_ctl_add_conn(fc);
>         if (err)
>                 goto err_unlock;
>
>         list_add_tail(&fc->entry, &fuse_conn_list);
>         sb->s_root = root_dentry;
> -       if (ctx->fudptr)
> -               *ctx->fudptr = fud;

This is wrong, because we need the fuse_mutex protection for checking
and setting the private_data on the fuse device file.

If this split is needed (which I'm not sure) then fud allocation
should probably be moved to part2 instead of moving the *ctx->fudptr
setup to part1.


> @@ -1635,8 +1657,16 @@ static void virtio_kill_sb(struct super_block *sb)
>         struct fuse_mount *fm = get_fuse_mount_super(sb);
>         bool last;
>
> -       /* If mount failed, we can still be called without any fc */
> -       if (sb->s_root) {
> +       /*
> +        * Only destroy the connection after full initialization, i.e.
> +        * once s_root is set (see commit d534d31d6a45d).
> +        * One exception: For virtio-fs, we call INIT before s_root is
> +        * set so we can determine the root node's mode.  We must call
> +        * DESTROY after INIT.  So if an error occurs during that time
> +        * window (specifically in fuse_make_root_inode()), we still
> +        * need to call virtio_fs_conn_destroy() here.
> +        */
> +       if (sb->s_root || (fm->fc && fm->fc->initialized && !fm->submount)) {

How could fm->submount be set if sb->s_root isn't?  Or sb->s_root set
and fc->initialized isn't?

Seems it would be sufficient to check fm->fc->initialized, no?

Thanks,
Miklos
