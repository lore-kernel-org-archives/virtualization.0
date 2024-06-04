Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD597142E63
	for <virtualization@lists.linux.dev>; Tue,  4 Jun 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488162; cv=none; b=ZQAI7f6EdEOV6oUP6SBwSfwh3KYRg7N/lGkmHDH1ZEKOSgc7kydUvKV+cZSl9KUnxzzq6BuGEYwpSpHCseUoFOeina9YaD3r2FV4YJ/yoIoavVEFe1V5jnPeBPJLkOrscFAbL14iT9a4FPFIAGfFSLBBgm0N5tAW30dLv43gXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488162; c=relaxed/simple;
	bh=ydW56PzluKWgcPSKukxF7UDGObejUYK6H6Hy1neKvYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTYbfGe0mEUarFhF8C6SIzH5DfU52S988OlI0Avdg7r0fW6+Ji1se32BcfLW6Dtz8KjpNstJ2sSumRhXHhHIlcjTqphcPOd76ZMn1kOy9yalTWWrsRenrriMK+JAvhI6sX5JchC95U702/+UH+ydCYLSeqP33MRIAqve8nsv90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gbk5v6nn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gbk5v6nn"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b93370ad0so3739396e87.2
        for <virtualization@lists.linux.dev>; Tue, 04 Jun 2024 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717488158; x=1718092958; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl2Hglw606KlgDBUaavgQPdiC9MzZDauPWAbRuFDlKw=;
        b=gbk5v6nnghNH18RkjrpG0fJi0ubZGliG4me3MoI1poaANR5u49LK3z3wfMmvPBH1Bb
         msQ2NmNo435mQy2f8r5tZWp2HRh4XrJSysk7Z7+8PliToTdv49V42IzOdMNQUfobm7xj
         EPRm780oafzBhl0F15JLu12N1p2C2to+Yhr3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488158; x=1718092958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl2Hglw606KlgDBUaavgQPdiC9MzZDauPWAbRuFDlKw=;
        b=QRpu2VonYn4w1DWqmUtPx/kMx9NxeddK4MU4aAUtx0d88g3cwQ0kodncRJGC8BKxw/
         ymIe8F4X6bc7FlgMUwg68XbH3pWL2Vt6P8x0z9Rreh87J/0qY/m7eX5b8ncQixnpN8Bg
         A/kccrtDU1Aw0ru/7aIZC55QzpIWuvgNWSr0iS7Dh4aYD7YyxjYltqlsSpah298GWsjd
         waqbH5UVpYT8Vs/wQjcYVjsbN0CXx27PkfovX2gXvLQM1na/tPmt3JD8pSjH+EoCg1GK
         AtQBEnnvK6YBrZFLuPQk5DzGMzzRgmArLF05858BF0funAq2znq699Ak1ZtoHT/NrC/o
         TD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZbZ5+t68Dq16eRGhhSWTuspIDrQ2aM3mnFEoydAfQwMyooISkN0nq8/ZvuZHVnhA7rb4cqSh6Y75MqxvTnPi/oPsB7mLbopFQ+rBipfc=
X-Gm-Message-State: AOJu0YzqQsFDloy4ZQBxcMEFFc61hH6x1GN6u0uVc24Jzgf+6ZlW7JIa
	xRL4DaSPtpfv3t0GQq+QbQqGrQS+6EUT/nh6qqMkezMntAeXCkrWO0LpY3lLcFgzn7a6A6PPtlY
	gdndwXBPrNC7+JdoHq0rYplbOz2vGsW49sVYc7Q==
X-Google-Smtp-Source: AGHT+IEPelug+UmeuJqbrHG9tmKC1riKOZH4vA8O545Sh3JVlejgXDR2o6c3TGLIXiXayqZdAErYV1fLwDpcwdWqEu4=
X-Received: by 2002:a05:6512:2e7:b0:52b:90f5:494c with SMTP id
 2adb3069b0e04-52b90f54aa8mr6341929e87.43.1717488157694; Tue, 04 Jun 2024
 01:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com>
In-Reply-To: <20240603152801.GA1688749@fedora.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 10:02:26 +0200
Message-ID: <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>, 
	Idan Zach <izach@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Eliav Bar-Ilan <eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jun 2024 at 17:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Jun 03, 2024 at 04:56:14PM +0200, Miklos Szeredi wrote:
> > On Mon, Jun 3, 2024 at 3:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> > >
> > > On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > > > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com=
> wrote:
> > > >
> > > > > We also considered this idea, it would kind of be like locking FU=
SE into
> > > > > being x86. However I think this is not backwards compatible. Curr=
ently
> > > > > an ARM64 client and ARM64 server work just fine. But making such =
a
> > > > > change would break if the client has the new driver version and t=
he
> > > > > server is not updated to know that it should interpret x86 specif=
ically.
> > > >
> > > > This would need to be negotiated, of course.
> > > >
> > > > But it's certainly simpler to just indicate the client arch in the
> > > > INIT request.   Let's go with that for now.
> > >
> > > In the long term it would be cleanest to choose a single canonical
> > > format instead of requiring drivers and devices to implement many
> > > arch-specific formats. I liked the single canonical format idea you
> > > suggested.
> > >
> > > My only concern is whether there are more commands/fields in FUSE tha=
t
> > > operate in an arch-specific way (e.g. ioctl)? If there really are par=
ts
> > > that need to be arch-specific, then it might be necessary to negotiat=
e
> > > an architecture after all.
> >
> > How about something like this:
> >
> >  - by default fall back to no translation for backward compatibility
> >  - server may request matching by sending its own arch identifier in
> > fuse_init_in
> >  - client sends back its arch identifier in fuse_init_out
> >  - client also sends back a flag indicating whether it will transform
> > to canonical or not
> >
> > This means the client does not have to implement translation for every
> > architecture, only ones which are frequently used as guest.  The
> > server may opt to implement its own translation if it's lacking in the
> > client, or it can just fail.
>
> From the client perspective:
>
> 1. Do not negotiate arch in fuse_init_out - hopefully client and server
>    know what they are doing :). This is the current behavior.
> 2. Reply to fuse_init_in with server's arch in fuse_init_out - client
>    translates according to server's arch.
> 3. Reply to fuse_init_in with canonical flag set in fuse_init_out -
>    client and server use canonical format.
>
> From the server perspective:
>
> 1. Client does not negotiate arch - the current behavior (good luck!).
> 2. Arch received in fuse_init_out from client - must be equal to
>    server's arch since there is no way for the server to reject the
>    arch.
> 3. Canonical flag received in fuse_init_out from client - client and
>    server use canonical format.

Yeah, something like that (I got the direction of the negotiation wrong).

See below patch.

I'm thinking that fuse_init_out need not even have the server arch,
since the client will only be translating to the canonical arch.  The
client sends its own arch in fuse_init_in.arch_id and advertises with
FUSE_CANON_ARCH set in fuse_init_in.flags whether it supports
transforming to canonical.  If the server wants canonicalization, then
it responds with FUSE_CANON_ARCH set in fuse_init_out.flags.

This works for legacy server that doesn't interpret the new flag and
field, and also for legacy client that doesn't set either (zero
arch_id means: unknown architecture).

arch_id could be a hash of the arch name, so that the fuse header file
doesn't need to be updated whenever a new architecture is added.

Thanks,
Miklos

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..c63d8bab2d37 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -421,6 +421,7 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and
the high bit
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and
the high bit
  *                 of the request ID indicates resend requests
+ * FUSE_CANON_ARCH: translate arch specific constants to canonical
  */
 #define FUSE_ASYNC_READ                (1 << 0)
 #define FUSE_POSIX_LOCKS       (1 << 1)
@@ -463,6 +464,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH       (1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT (1ULL << 38)
 #define FUSE_HAS_RESEND                (1ULL << 39)
+#define FUSE_CANON_ARCH                (1ULL << 40)

 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
@@ -874,7 +876,8 @@ struct fuse_init_in {
        uint32_t        max_readahead;
        uint32_t        flags;
        uint32_t        flags2;
-       uint32_t        unused[11];
+       uint32_t        arch_id;
+       uint32_t        unused[10];
 };

 #define FUSE_COMPAT_INIT_OUT_SIZE 8
