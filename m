Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93D1EF09B
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763524693; cv=none; b=RyWBaDsL4Uu/eLm+pihbMMm3dIzC9x5u1WBdjPeCaUoB3awoEcUvbUHJIsPgwbd/G8SRZYpAY9yUMs5zxc5PGVI11jZW+ZZhWsp4lTFkspEZqZgzZDp4TgRGD+3+zA85Unx1b8lpunHry94KIBs6UmZjeD80u2Zh749bf5HbBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763524693; c=relaxed/simple;
	bh=PI3QKLL1UFflRMFBd9gNh7xeqS0cnp6FXnZ/gxAlTuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaalwbjBuihUmBgWI3L9+u1gA+eo78Xb1y4PyW7kw1jAA/V2SOZXi1a/0OWQXYjeXj8cRyko7X2s8aqDLtVWu/RNpvQ+H1V3M0mtAUrYIRpZnFpdnbjyosHLctWnN0Opd+HKOUxm5kNVNR4atouixn4/bB2ZMtV1PxLqA80jkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T34KPg0+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T34KPg0+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so8406842a12.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763524690; x=1764129490; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PI3QKLL1UFflRMFBd9gNh7xeqS0cnp6FXnZ/gxAlTuI=;
        b=T34KPg0+GIzaVCziWQe60tiWQWcs1VwuLWHJBSaMpUmKOdCCvqVK9ZPclwMeUTlfCt
         T4uH1LXneGUq/09hg4eWQyvW0lOHBCF8Zp92QIQExvKJgMl2STrUumt4KxEYPqJ7Tacr
         qpAiAV+3yhHcOoFpunOttugs+NJCdGZsX5hqvk/+El8YsArs0R97k+YV/ploLfpGvXVh
         jbsD8+/0VcKNGa3G/Oz2pqPhFtOadKfpEAxKaEUgyntZXBrjgXIKDr4L/8DqMHCWc1kp
         va6wifw0+rFDYEHkpV+ZHPERIGMoGVIpS11zzRFr+1Fzs9+QGvlR/80W3Ev7riCAZzCS
         aX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763524690; x=1764129490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI3QKLL1UFflRMFBd9gNh7xeqS0cnp6FXnZ/gxAlTuI=;
        b=S58DlVAE5PkBW0K4O8wbUlbNVByxPV3ddJ8MM0MxmVx5g5vB3kly6AjQJRQ5qO1Nap
         FWlLrmI4pJPR/5oC+Q9vLuUpwa2Nqb0PxyN4R2+C0+caYYq+NX4jxKL9yBvZsupYefzc
         n097lhpd6J2AxlLi6XJpw7numEn/ildJeOOtMBhxfXcPL9l4Lw6KndRibQ/zqEHIG65V
         o2jmFmpA7I3W6flxbPESAcrnNKIil8wMiQ7+9XOdtmcGTE5FD/66fxCJf9fee4aACQYu
         k/F3oXx7Uha+vjQLzaYdI402MHdoDaOWyJo2cSI5DKZFeDavhLGe9HwmkjBZYAzGj2AM
         7ujA==
X-Forwarded-Encrypted: i=1; AJvYcCXyEvXrCV2Af4sTyV2YnSxhanYbco7TrIgNTaRHSdE1u4noFwdkGhFnla7sMmc8r3QV/65TrqUZYjWY1msEaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgmQsqYrHh7wxsiYgB+ghUkcAEdI6CIYaGWIxd4tMh2r/WITB2
	V9msBDN8fba0B5bkkMTw4pzChLOY8l+ms3bzOzQhyh5RWmEOKp81CM+dnayjf0PiJWL5IVADpu6
	vMUx8+cVdZWLTvl7PW1av+OAO/Vu6/Uc=
X-Gm-Gg: ASbGncvZwA3dJwwafr3oOhqLfVwgFYxuR+3U7vrhbbIWz1rxUQWm3h8+GvlvT32No6U
	EK46RwIuxWEl6hc3rkvefPYg9Fl5H+ZuwFOvF12Fe5f+27DsjjlSQDnMwiWvOKHR5lEQ5qxhJI9
	wU8terLJLlkAmXUPu3vIv2mAAYSxT/RCBlhKGK06T+aPX702nTrIH+KA4k9DBLgNIGA/nHUcRwb
	NTX6efzSt1jS+HohLmEw5d4xB91hxye99j9FhMQS+xZK5HkoUtjwAH9lUg+WmdnWQhYKyD15WUo
	YfUOrg==
X-Google-Smtp-Source: AGHT+IG3PwSV/TBqcgYiQTrXM8pDMO5dg/Jf6yZQNxRWinFCJb2bV92dB5BAFrlKAhEykr/231k5fj1ur5+oNuf4Gz4=
X-Received: by 2002:a05:6402:52d5:b0:643:c8b:8d30 with SMTP id
 4fb4d7f45d1cf-64350eac57bmr15010389a12.30.1763524690169; Tue, 18 Nov 2025
 19:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
 <CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com> <20251118105047.20788ed9@kernel.org>
In-Reply-To: <20251118105047.20788ed9@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 19 Nov 2025 09:27:58 +0530
X-Gm-Features: AWmQ_blCdRe1tCw5lI8xL4ehntzBrd_SGHl4OQqj-ctDdgKE4rWDvz00iLoDe1Q
Message-ID: <CAPrAcgOBa5Q3k5r=G4qixzWRuvK+PEinj9sGVf-nxWYon4BkpA@mail.gmail.com>
Subject: Re: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, sdf@fomichev.me, 
	kuniyu@google.com, skhawaja@google.com, aleksander.lobakin@intel.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 00:20, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Broken as in patch titles or broken as in it crashes the kernel?
> Both are true.
Yeah, I will fix both

> Just to be safe "as soon as possible" hopefully
> takes into account our "no reposts within 24h" rule.
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
Yes, It does

> Also I'm not sure what you mean by RFT, doubt anyone will test this
> for you, and you're modifying virtio which you should be able to test
> yourself.. RFC or PATCH is the choice.

Just to be clear, would testing packet flow with all the possible mode
combinations
under heavy traffic be sufficient and exhaustive? I think this should
be PATCH once
I sort everything out
