Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424943128A2
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299950; cv=none; b=k0xutP5h6JmwRtLjcO0zLfyJb6r9SockPfnvJ/tx4ipoo8C3rjAP4sQtuJMFgt1AECFx0jlxbVmJ23t8ZtCJKER4XBobAL7sD4TUiRS74xRek5jXFEh8BF94sLSz8ly1i5YorO784YzlCy0EeV97oxP32jhT4jfYyd/Lkk0blVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299950; c=relaxed/simple;
	bh=Lg5YJJaXpBc/s0JfoRj0Jz/sHkqXKEkjrx56oNdh6UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzC+A9LsJdXQf8GMPXiF6+JKE/+Kock+rKF75XtS8zNq4Ro+6i6+E8/hNP3aHfCmwFEp9mIqtc98DoZiF/lkkty3ZMUHrUbelMeFJ3mP06cs6aENz3BrZtSfXQlLekGyOEPCORveuJ4vlTFFOEpYdnCXOYPL44Kw9Z4IK0bgni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oFyr5vUr; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oFyr5vUr"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c59dc9so88396701cf.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756299946; x=1756904746; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS9A1xArxW2DbHOyp5U7gUvufvKTYOF7Z8twNaozFaA=;
        b=oFyr5vUrtm7+yMvhmf8zqU3OEe5lPS0keliiTsWLPWNbR7I7lgWyUb8vzS8LzRLubm
         szj3YGDe05S5/P60wLps8oml6JnQciBtVvBRGNjNT3KLZUKJx7T03ju2j8nlr4Ws23cK
         ZBI3XyEoX32A/kmE5pazVJp4VPQuU/DbsXpmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299946; x=1756904746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS9A1xArxW2DbHOyp5U7gUvufvKTYOF7Z8twNaozFaA=;
        b=TrTItXZkCSyYGNLmm1VVe1aTWwyLAAmW90Q1GaCO44hHmcjcDTCfHssrQliDUnNylH
         5M7dUhYvN80e7kzBO18FhuXtHqLlOeyvJ/1lwDM6VivezV/J9S7MXwVch/qdtVqfQft1
         fj6rhdx0UtU4+ERTo1LZzKzr0sC+mxIdYer/nBQ4Lm40OsP9kJd/+L/Grd3W6DLn0p0D
         yzCtoPpDCyjKnx+uuYcxXrqHMXo0UHhs+yTkUdxApqYMRhbSIEJe8R9rYElxgfepSbex
         lLxgaZk4pgcZ8BE8PpO4goP9jPT1sECOvh26Em2WBKKFb4iA6a1DMwk5sc6BlHPVRn4e
         diug==
X-Forwarded-Encrypted: i=1; AJvYcCUsVFVb/MfHOnfHu3s0KaV7JN1OeKzKF2lbGM346a7c2ki0GlRYPBP4qlo+97YvU4sJuioQOhPgnnhXMZBjuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwETyuhDJlrIb1ppb9yWf88JOFHj1vKnVqnwyHTSWmWY+aegvMT
	g/afvc9fxtJJ+wDbjbdk0+JQf1zdD8I3xA8MkDQdQ3TGnm3r/pGytORPDwe6y3H3p/+645v18Wh
	Y/SNG17rF8qqshRjIgc8vw1Zb2Zz2rYyCHefi3WusaQ==
X-Gm-Gg: ASbGnct82yRRDha9pM4Jpk8udE6MT5vdcpLu1RMC2wzJAttSQdgWDrlLQrAPkebnvNF
	jRTWS0JtaRRkKlGVJjqev79F+jG1XaMD37uNOBLuKJ6yLsm7qs1Ltb8WuehgI0nteu2x9fP1IFr
	T9oSB1cUq7RnxXsgtJ+kRJLwA6XY6/zEv22zgphyJFL4LiWiOkkHPYx0kUIPTtLWE9cNz/KnLyY
	ks9nIV3HcS55aTkfel8
X-Google-Smtp-Source: AGHT+IGLeocHq+w8KKF32Jz+bx2Tk/02BB9NqaabL//OB62XP1A63lXRphuALAt/uyjA7/9UrZ1B5iZzrud5rKizpFo=
X-Received: by 2002:ac8:7d50:0:b0:4b1:1fc6:863a with SMTP id
 d75a77b69052e-4b2aab0cfa2mr202698391cf.63.1756299946002; Wed, 27 Aug 2025
 06:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
 <CAJfpegvmhpyab2-kaud3VG47Tbjh0qG_o7G-3o6pV78M8O++tQ@mail.gmail.com> <1E1F125C-8D8C-4F82-B6A9-973CDF64EC3D@nvidia.com>
In-Reply-To: <1E1F125C-8D8C-4F82-B6A9-973CDF64EC3D@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Aug 2025 15:05:34 +0200
X-Gm-Features: Ac12FXzh4c9-bhOGpJCxyjBS2F9uSLYJUbMNbime6Sd-tJCzwd6Aonr7-j-nBrI
Message-ID: <CAJfpegtmakX4Ery3o5CwKf8GbCeqxsR9GAAgdmnnor0eDYHgXA@mail.gmail.com>
Subject: Re: Questions about FUSE_NOTIFY_INVAL_ENTRY
To: Jim Harris <jiharris@nvidia.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Roman Spiegelman <rspiegelman@nvidia.com>, Ben Walker <benwalker@nvidia.com>, 
	Oren Duer <oren@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 at 22:42, Jim Harris <jiharris@nvidia.com> wrote:
>
>
>
> > On Aug 20, 2025, at 1:55=E2=80=AFAM, Miklos Szeredi <miklos@szeredi.hu>=
 wrote:

> > FUSE_NOTIFY_INVAL_ENTRY with FUSE_EXPIRE_ONLY will do something like
> > your desired FUSE_NOTIFY_DROP_ENTRY operation, at least on virtiofs
> > (fc->delete_stale is on).  I notice there's a fuse_dir_changed() call
> > regardless of FUSE_EXPIRE_ONLY, which is not appropriate for the drop
> > case, this can probably be moved inside the !FUSE_EXPIRE_ONLY branch.
>
> Thanks for the clarification.
>
> For that extra fuse_dir_changed() call - is this a required fix for corre=
ctness or just an optimization to avoid unnecessarily invalidating the pare=
nt directory=E2=80=99s attributes?

You see it correctly, it would be an optimization.



> > The other question is whether something more efficient should be
> > added. E.g. FUSE_NOTIFY_SHRINK_LOOKUP_CACHE with a num_drop argument
> > that tells fuse to try to drop this many unused entries?
>
> Absolutely something like this would be more efficient. Using FUSE_NOTIFY=
_INVAL_ENTRY requires saving filenames which isn=E2=80=99t ideal.

Okay, I suspect an interface that supplies an array of nodeid's would
be best, as it would give control to the filesystem which inodes it
wants to give up, but would allow batching the operation and would not
require supplying the name.

Will work on this.

Thanks,
Miklos
