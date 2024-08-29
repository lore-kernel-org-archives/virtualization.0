Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E29189F31
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918845; cv=none; b=dhYTEngzHSGe4RbyKeX/Qx8L05h0jufazg0up+Qs6WexrjXgUbsvbDoTOPwPaR/WeYGK2Q3TixXt+cOCBNsmJoWoKHXgxC4E9qE2pQhOktrpOxBumav7gVeNIHDpUhDJ9SJ4wRibZaUtSoDPpzQS8PIu+licmgpjMnWRWZ0C11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918845; c=relaxed/simple;
	bh=auFqkUNyv2Fd/0ioi9ZUc3h7ws94RlEFh6JNyRARyKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE1eesM8s42ifGMQoFh9rCws0kJuyxIx3STJ6AWz5t394F/AlnwDONKawRddk455islHDhNSeSZFyua/1bOXrLGmyQtD4NrUBHSJctM1jqv4t/i+sozqh8NgOK0+Z5TGmCcsydJZYKmN1sQ+BRPHQZthTSVvltwvciklgpjM99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VYXi5g5I; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VYXi5g5I"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53345dcd377so473439e87.2
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724918842; x=1725523642; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWHF4NxXib0BaVbETNyvLLP+DsSB41nEJXFZk7mMGog=;
        b=VYXi5g5In9yvEFKRboecS8npCYa9gfYuYK8yMQ16kUOPHz6V5tYQbh8iR1nwGzG5Uw
         RGTT2G4DL7IyK83DJnivWWEilJmefKt1Spf/uEYZsLyBdLA2TfHNqpol+bcSAXE0WLqj
         qBUeCpjk77biXKvaQSDM6M6Ddo0EUERlk1tDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724918842; x=1725523642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWHF4NxXib0BaVbETNyvLLP+DsSB41nEJXFZk7mMGog=;
        b=f6JCI+TIti5WY+VL6NBD3+0f2WkYLhWxBfeIsKB3wheXlAWkU2z1VCCdPzFmEbbGro
         /aGCbYCuCEiKpbgALcvNrM9YZphQ7ZMHC/Q3cyNwTXVrLxMDwViJDxxH8tdvh1xlSbfJ
         GdTJwtjAIa36JuWNYadCwrBfCxCWyJoTyvPY1jOE8zvoFlxG0lnRI2TcTTaO+t9J7vAH
         EENTYDqmY5Rzgx9rEwlELJiUl7CGsz2jPhz6xmOeSx9InF4TJsiw/5M6G3h7w7ygGKu7
         PmYuNCJmGafsSss4Ap5QQxpghwaAieufNKwvO2eAVJN08SR0WDN+R1zGO8DPKyNR+RwJ
         O8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVcHiysXB+cckVNf8Ic+rNpR3W0FX9cHg7oXlbN8YmEreyzkmFaOj/bs5oglAe0clX78DskBrqOlkA0QdiXWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd9uE4IIhE2V0BgbUViEgT1964LZJK+Nai7MQ/fPu+attThPyH
	qAn4YbC4oyNTAc1RE6n2qTzVWTVO6/5XIgmaPz3qnSDKowYmwUWNR45WWLjjNmsY8GVPHcTI6EF
	UhwBnTxNMZ5LhX0IcmwCZwYaTtB97+vuGP7TGZQ==
X-Google-Smtp-Source: AGHT+IGNbDJ14S2lYWoqQ5dAM0S0xuzu3UKx1UZtVenRD205hOgag/lAWnB20MTVkCtylH29xVj9OadK/FnKaKfGoUk=
X-Received: by 2002:a05:6512:6c7:b0:533:4676:c21c with SMTP id
 2adb3069b0e04-5353e5ae666mr1221299e87.44.1724918841596; Thu, 29 Aug 2024
 01:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709111918.31233-1-hreitz@redhat.com>
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 10:07:10 +0200
Message-ID: <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	Miklos Szeredi <mszeredi@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 13:19, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> Hi,
>
> We want to be able to mount filesystems that just consist of one regular
> file via virtio-fs, i.e. no root directory, just a file as the root
> node.
>
> While that is possible via FUSE itself (through the 'rootmode' mount
> option, which is automatically set by the fusermount help program to
> match the mount point's inode mode), there is no virtio-fs option yet
> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>
> To do that, this series introduces a new 'file' mount option that does
> precisely that.  Alternatively, we could provide the same 'rootmode'
> option that FUSE has, but as laid out in patch 1's commit description,
> that option is a bit cumbersome for virtio-fs (in a way that it is not
> for FUSE), and its usefulness as a more general option is limited.

I wonder if this is needed at all for virtiofs, which could easily do
the FUSE_INIT request synchronously with mount(2) and the server could
just tell the client the root mode explicitly in the FUSE_INIT reply,
or could just fetch it with a separate FUSE_GETATTR.

Why regular fuse doesn't do this?  That's because a single threaded
server can only be supported if the mount(2) syscall returns before
any request need processing.  Virtiofs doesn't suffer from this at
all, AFAICS.

Does this make sense?

Thanks,
Miklos
