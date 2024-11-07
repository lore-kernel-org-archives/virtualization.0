Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F51DE4E9
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981939; cv=none; b=KoA9CrD7xBu6a29x0ycLv2rOBZ0f0eyBwa1lN3e6h9w3SIcjU9TuCiiqKRl9p2Aqrejwq4HjZKvbEWmThD+YDjM4IwtXlh0o+n85bne4e18/8tRqU/u3SzGXRXJsm9h88li+F6ArD7jeoQo/ouBwqWs5E7h2n0ZcjbbrEBW/Ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981939; c=relaxed/simple;
	bh=QF2oNzITxX0gOBS8zn5XFRN+IaelJLPihLi4DtBISKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HusVzXO7VA46PZBE5UNsgZJbO45KtUzeL8K0u+89nBTe5iJAFFuz2j4ghWMbLzFVklOi0/h9SElAhVnv3QQe1rV4fdxkRvsbGRajgk3Vi6MDSbs0c33FDPtWdmakBjJQd59eAfYwIxc8jgeK9yfUWjHrzlPPtOxerws5CVe6KeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PcpJX6ab; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PcpJX6ab"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460d1145cd8so5510611cf.3
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730981937; x=1731586737; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GegbHPmHJ/jq3f0zR1yfgP7svIbKhdwG6vm6VMTRCyY=;
        b=PcpJX6abwX+8m50uBVZEdFuIjqnw2lHieFbvnxOd3PuI0GBt1DDEHspkMhyWpJ6Kqs
         h0jRiPb2mCiwF8ffJYj5dJyVn+b+zMDuTMGI7uCgAcmLhaYSrM3eaMt+76qXAPH6StvA
         pO31YdH65hcRT+QxCoOLLbEwMROv99uUBvP8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981937; x=1731586737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GegbHPmHJ/jq3f0zR1yfgP7svIbKhdwG6vm6VMTRCyY=;
        b=uoMI+u5UqhFu7sEIALmEqJPiGxI9fRM24ofhOnGyYmsHqxzfaOa/SqTC9RINh1IqBH
         HeqDWai05ZfVk3X76AU0kRqATrqLODV/PwIShoDtlA7uxeCV4cUkkRLAWhKlfsp3X+44
         nlj0vtonOVvUf9GRScIapBv008+ePvgOxAaKhMviTtCu/emsOFu+WKu5DnQJU9SlPUd3
         OYmPuvK4GNC4SuAjwo8EPLFs0GWpoFzEVURO4Ylh7xRBV5caTYfDeG8NDBQnyuvnmYXU
         BOJSx3ZxUy4l61C6yqd1j+e6zChqfx0i6eD+1R32IkS4/c4t2boZLOMIDnIhI6Lrm4q9
         iEUA==
X-Forwarded-Encrypted: i=1; AJvYcCV3MI/yKUAI3yRjCiKAEGYnjKIWJDixkSH06Wk/t4djwbwm/NIimuQzV+hCPQn/GdN5tfI4ONyem3loeGWoXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwemwFE9anC9YXLDKu1ZEhgxfusSEbvNvXsk5d0o+wg06i0PXtt
	hVKUU1SVEyoCTGbpf/R6CS2vdY7BytyvieqIZxqAEWeKMDSsKKnZ4gXwFewDr0Ojumuc3MW5rWF
	i4ZU74y52tHIB7DMXeixOQAKFLXVp3UVH1L7phA==
X-Google-Smtp-Source: AGHT+IFtv+GKUc4iD29o482ZbZY0XQcQSZGjqKz3tbmzgRu+YI6K2L6XRRlAB3NCQn9LUZKr4SQIt4pCMC+npRWgFFg=
X-Received: by 2002:a05:622a:4814:b0:463:16e:c5d2 with SMTP id
 d75a77b69052e-463016ed03amr18210951cf.11.1730981937210; Thu, 07 Nov 2024
 04:18:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com> <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
 <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com>
In-Reply-To: <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Nov 2024 13:18:46 +0100
Message-ID: <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 at 11:00, Hanna Czenczek <hreitz@redhat.com> wrote:
> It isn=E2=80=99t much, but I believe it=E2=80=99s most of fuse_fill_super=
_common()
> (without restructuring the code so flags returned by INIT are put into a
> separate structure and then re-joined into sb and fc later).

Probably not worth it.

> fuse_send_init() reads sb->s_bdi->ra_pages, process_init_reply() writes
> it and sb->s_time_gran, ->s_flags, ->s_stack_depth, ->s_export_op, and
> ->s_iflags.  In addition, process_init_reply() depends on several flags
> and objects in fc being set up (among those are fc->dax and
> fc->default_permissions), which is done by fuse_fill_super_common().

Okay, got it.

> So I think what we need from fuse_fill_super_common() is:
> - fuse_sb_defaults() (so these values can then be overwritten by
> process_init_reply()),
> - fuse_dax_conn_alloc(),
> - fuse_bdi_init(),
> - fc->default_permissions at least, but I=E2=80=99d just take the fc->[fl=
ag]
> setting block as a whole then.
>
> I assume we=E2=80=99ll also want the SB_MANDLOCK check then, and
> rcu_assign_pointer().  Then we might as well also set the block sizes
> and the subtype.
>
> The problem is that I don=E2=80=99t know the order things in
> fuse_fill_super_common() need to be in, and fuse_dev_alloc_install() is
> called before fuse_bdi_init(), so I didn=E2=80=99t want to move that.
>
> So what I understand is that calling fuse_dev_alloc_install() there
> isn=E2=80=99t necessary?  I=E2=80=99m happy to move that to part 2, as yo=
u suggest, but

Hmm, fuse_dev_install() chains the fud onto fc->devices.  This is used
by fuse_resend() and fuse_abort_conn().  Resending isn't really
interesting at this point, but aborting should work from the start, so
this should not be moved after sending requests.

> I=E2=80=99m not sure we can really omit much from part 1 without changing=
 how
> process_init_reply() operates.  We could in theory delay
> process_init_reply() until after GETATTR (and thus after setting
> s_root), but that seems kind of wrong, and would still require setting
> up BDI and DAX for fuse_send_init().

Agree, let's keep the split as is, but store the fud temporarily in
fuse_fs_context and leave setting *ctx->fudptr to part2.

> >> +       if (sb->s_root || (fm->fc && fm->fc->initialized && !fm->submo=
unt)) {
> > How could fm->submount be set if sb->s_root isn't?
>
> fuse_get_tree_submount(), specifically fuse_fill_super_submount() whose
> error path leads to deactivate_locked_super(), can fail before
> sb->s_root is set.

Right.

> Still, the idea was rather to make it clear that this condition (INIT
> sent but s_root not set) is unique to non-submounts, so as not to mess
> with the submount code unintentionally.
>
> > Or sb->s_root set
> > and fc->initialized isn't?
>
> That would be the non-virtio-fs non-submount case (fuse_fill_super()),
> where s_root is set first and INIT sent after.

But this is virtiofs specific code.

Regardless, something smells here: fuse_mount_remove() is only called
if sb->s_root is set (both plain fuse and virtiofs).  The top level
fuse_mount is added to fc->mounts in fuse_conn_init(), way before
sb->s_root is set...

Will look into this.

Thanks,
Miklos
