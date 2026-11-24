Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521212;
	b=IAzHPaEXfvcPm3tW5kPfuWMIMOhbFKyHr4ig6IenO6P+D8Y6A3MR2L4DzlTbMybUS/L8
	 8FxptWmqE0CD9iBJhsUQWtZJfJo3iLnWXGiYymjuMIWd0lg/BLl4Ml9nSwatYASDazw//
	 J796BEDPtMn1MBz2HKPEv04x8hV3gUfZZA9fsIr3DCY7Eeyg+3mspcRamqewLPcm6g6HA
	 e7NuAsCdm1OBUq8CgMv1KxDXJqgdMpw3tArdDaBD682/QaO9XIcehnHP1C1HR9jL10AH1
	 VRQSKqpdUb3bVRufaZc7fCcR5Fmz3j5e164pTA7zhyuTzes4msuHx7VyetNE0mbMMDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
	b=u1r42kt9b2uf/czLOuR43OltG3+b7vWw3pZxD058j425Ar0u60DXOXmD/WhC4xfcyN0Z
	 ARlEm1WaGjkEx1Us/+I0G1YKfr/6ckE203+qS2vvVz7b0Me/zHwOp/mrk37CkgrU4VIN4
	 5JsL6feqvQXPbHLwiiVPANqypR4gJcQ/LlJpH1SenKR9dVP/r2Jv1XV7uGcD3sqhlqmWG
	 Aqehlmp+Gmooo4uTdWK+x/DagVGoPL8eSAnJ1VZVkV8p2cN/6pRR1O7vpY0wj3+umZKGG
	 mM9QW3fl4ffRaIrtArwaNoXLuZfWRbLV+TUxlCSn45wTE3SC3SgB2V5D4oHGvKnueWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=RDkTejwO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBFF606A322
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 11:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDBFF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=RDkTejwO
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-536c8f958d7so33663301cf.1
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 03:53:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795521211; cv=none;
        d=google.com; s=arc-20260327;
        b=lxBBMD6HLRY4gFbS9kTjB9bBidCDRJ+RFbbNAlQbnWRUYcCINDynBeS49o6KS+UnRX
         51nRSG5qlrNHZgkpM6IunQy3Ra+gkMtwj5y66qHWwbfUSqtuD/HVVcIJ8RPjHAKtOG0M
         xwuFmMgtR8EsIzbHsyiR+lw0pbanNWU7/8IY5MgQEvF28m0ashEHscip7Uvfe4wzAz79
         lzNjOsDM+brAQQX/VKnUGZXaX40hXEKmyueBKknDditBLHiarBw2tW/RHwEUqPljFRFC
         IB+mI90jwruQH72gZr1X958zx+NGkmMJ64FFN7MELmJMtATZ7KtuznsttVjl7EM3c9cs
         tmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
        fh=EOzHZmCUQ7ebRZUBHAf3B060+rJXzTNBGPOT1NC4axA=;
        b=TZ5wP4SQJ/ZnyedGoIJQ1LX9cSiAYRb9aBwZ7BJGP2Ttu+GKbnIvaUkQ5QWGsUEXJ2
         aeIgUJ4cD0RxV5ZoiD2XvncjKn54AabAdslgDo6I5NqIOBghwKic17v4xzLM9+Ckr8MX
         JeYkLvgIVgPPv4vNKmJ6kE3F2ixQqvpST5oqmFK82oPjHF3uUpEx1W8v1Fj63q4uSf4g
         qQ5nzFZInWx4tupt29AbfS8UNOlY8IZG39ECIsplbqOcJrBUC38D4gjQhDlMLGV+cWJx
         II3WdiEl4JvdA6/9CliIHJj8GiyVqI3mCs5GaDna+sQiVJovA4n4KGQPqnVc/7dsVfP/
         ityg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1795521211; x=1796126011; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
        b=RDkTejwOFRotSEOL4XUGTMWhBwglqklg+1t/vIoDkhZmJssdhBwuiG4UAYp7TBOpcP
         XVb8x/LbWoATO5az9UsBpgUTqeuzVEo38Gh8HqFSDB8/7QSQ9mFnYMGrZBC66YgM7qt/
         sCFK1Y2JK70Etr3AD/hNstLLJL3edJje3HawQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521211; x=1796126011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fXDSwCteyZ/xoOThhEVEgHgDKXealTWvNjRPjKwF/z8=;
        b=hdzMaJwxZ95ssvGORC6eki5HVb49xm3j1jwNh+2Xtg1svlhoEBVZgMLNPqfS8LLfGB
         ARQHfHA1p0WdxCy+fTOteO2GasBtwnyut59YBUIG6l9aPOmBEuZ7BonMlVSF7P3fzbQO
         jvARl3RDkRTBQQbibdcXveRtUcp9V/Q8AdQ2PviI7pIGje9GY2bs+NgGcZC3Xyz7SvjF
         Niu8OWzwH5UvP6E8DYUUGDmDMKcax04w9dFOWwwD+eRbNuxvLABlaV4aTGv95PxmmJZu
         vqOgvBRr8cHxngWPLkYGZnHrpwIG89GX/GkZifX0MBtX2TEok+3fr6w2KBCxpadz6M+u
         D4XA==
X-Forwarded-Encrypted: i=1; AL+hErFKpIiFbDBQAKNcOG6231/AzdhZ24sSwRxxHRGvIoY7K8BxwJZ7AWQWSczu3spin8a/DFiQkIPQNFYBLW33Fg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9r4Sn142MPwTfcOh2E5QM0+MbN5jefK4er2a1azqniF+bB2kcP
	EbYjhX2LVLpLUzIIfndXPlzh/A3UKGKCpfA06YWEe7dRISbzMuU2QoIS0uB1FatZWfOKh9XvtN7
	6n2Dn59OlF0R4dpT/kXXeVi5XJlsCDTYfM9JmCRKRvA==
X-Gm-Gg: AZFdTZfaE1FQmDq9rG0isImqZqFDWmJKqHDgiw9cQFHMiyU56clQhIh3Y0Qgb5js6Gf
	/Zj24DxdCP1rQ+/mn13jCFnPa1dHLIcTk/kikZ5V8WlUIyo4Rye5KcU+zG6LAAL/6XGIt4aFr56
	sqjyDSFO2xZsZffQBepbdY7L5Kg9MmiLotTxN1nEp1dA3NlM1d/6ZKfexomXSnO6ByhMy3nvULn
	IBVRYQzB31G7c7FF0nIv8Lb2fhZLjAnOdRSb8z9vRrzIK+qPCxsLJqiPfMmnevVc3sAv9erX1Aq
	LfSBmblMs1GCDkvrjvE7OyBn689sYB6bqCGsYxgd7p7q3O+4ZuAqaRkWHoFJFJRwmxQZLZ8P10B
	VVxEAxiJ24P8j2D8W3BRau2jhCjaCvBBAeX1UXNzdVC4MF35cDtRnrDviSKi9Vumb7w2S5w==
X-Received: by 2002:ac8:5a08:0:b0:55d:4be8:937e with SMTP id
 d75a77b69052e-55d76a2d266mr263720841cf.50.1795521210875; Tue, 24 Nov 2026
 03:53:30 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105150943.86650-1-mszeredi@redhat.com> <20261105150943.86650-2-mszeredi@redhat.com>
 <656d0e00-01a6-4e90-a924-4ad2329c3d74@kylinos.cn>
In-Reply-To: <656d0e00-01a6-4e90-a924-4ad2329c3d74@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Nov 2026 12:53:19 +0100
X-Gm-Features: Aa3M54pdQT8drGLIpCz-lb5dYncahFoRCAsGVIFwkCZg_LrUi6uOLzpn0GsGbkg
Message-ID: <CAJfpegsOCq4oGfxzYh=DdL5x2BxaWc=c-SnSi1SOOk4eDOooqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device removal
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 09:50, Li Wang <liwang@kylinos.cn> wrote:
>
> Hi Miklos,
>
> On 05/11/2026 23:09, Miklos Szeredi wrote:
> > The virtio_fs object is refcounted via its kobject, so a mount can keep it
> > alive well beyond the lifetime of the virtio device binding.  The tag
> > string, however, was allocated with devm_kmalloc() and is therefore freed
> > by devres_release_all() as soon as the device is unbound, i.e. right after
> > virtio_fs_remove() returns (see device_unbind_cleanup() in
> > drivers/base/dd.c).
> >
> > virtio_fs_get_tree() looks up the instance, takes a kobject reference and
> > then drops virtio_fs_mutex before doing the sleepable part of the mount
> > (allocations, fuse_conn_init(), sget_fc()).  A concurrent device removal
> > can complete in that window:
> >
> >   CPU 0 (mount)                         CPU 1 (remove)
> >   -------------                         --------------
> >   virtio_fs_get_tree()
> >     virtio_fs_find_instance()
> >     // reference taken, mutex dropped
> >                                         virtio_fs_remove()
> >                                           list_del_init(&fs->list);
> >                                         // driver core unbinds device
> >                                         // devres frees fs->tag
> >   virtio_fs_fill_super()
> >     mutex_lock(&virtio_fs_mutex);
> >     if (list_empty(&fs->list))
> >             pr_info(... fs->tag);   <-- use-after-free
> >
> > The virtio_fs object itself is still valid here, only its tag has been
> > freed behind its back.
> >
> > Fix the lifetime mismatch at the source: allocate the tag with kmalloc()
> > and free it from virtio_fs_ktype_release(), so that it lives exactly as
> > long as the object embedding it.  All probe error paths already drop the
> > final kobject reference, so they are covered.  Merely dropping the tag
> > from the error message would paper over this instance while leaving a
> > devres pointer embedded in an object that routinely outlives its device.
> >
> > The other readers of fs->tag are unaffected: tag_show() is fenced off by
> > the kobject_del() in virtio_fs_remove(), the automatic KOBJ_REMOVE uevent
> > is emitted from __kobject_del() while the device is still bound, and both
> > virtio_fs_add_instance() and virtio_fs_find_instance() only walk instances
> > still on virtio_fs_instances.
> >
> > Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/bug/linux-0328b3a1-043b-468e-8425-6a613d91b5ef
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index ba8d79c4bcac..ef58bedc3941 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > ...
> > -/* Read filesystem name from virtio config into fs->tag (must kfree()). */
> > +/*
> > + * Read filesystem name from virtio config into fs->tag.  Freed by
> > + * virtio_fs_ktype_release() so that it stays valid for as long as the
> > + * virtio_fs object itself, which may outlive the virtio device.
> > + */
> >  static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
> >  {
> >       char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
> > @@ -505,7 +510,7 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
> >               end = &tag_buf[sizeof(tag_buf)];
> >
> >       len = end - tag_buf;
> > -     fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
> > +     fs->tag = kmalloc(len + 1, GFP_KERNEL);
>
> The fix for the UAF issue regarding fs->tag looks good to me.
>
> However, while looking at this, I happened to notice another similar potential issue: when the DAX mode
> is enabled for file read/write, the DAX window is mapped via devm_memremap_pages and unmapped when the device
> is unbound. Although as far as I know, the corresponding QEMU changes for DAX mode don't seem to have landed
> in QEMU upstream, fs->window_kaddr and other established page table mappings still point to this memory region.
> Perhaps we should also look into cleaning them up?

Please do.  Can I assign virtio_fs bugs found by sashiko to you?

Thanks,
Miklos
