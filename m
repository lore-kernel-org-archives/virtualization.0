Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2B369D72
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378606; cv=pass; b=KW3aLTlNes/kISym44co6JeMPHst1Is9j/ylCKBOb9Bicazk/TMsJPUs+oogCRPlq5372Z95ygHGK2mN/0YCD5/1fD7ck5tFxUIWiPj8zJFOIBqZLqY3f2HetQeCzgQN3sJ9K7e7I+z8eN2ESnrY7O4UFnRfe5XIiDMBxcOygVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378606; c=relaxed/simple;
	bh=10plZnvJMhdXNsmI90PPzAB9gg2/WU+vKhsLPvgRwP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TomoIGD9UATWOw7Vi/qJTKxgjG/djJ6VuqUFAjuvRKAgG5yeh9EEN8dzasNcvWq8haWKrpXyVjb0KzfoAbn7sanMVTJfflYQyDXEXpCyCjsiJwoH98WeaGYDmkj+J6J9fpsafv52r4MhOKROGc0nvbeKyKj7QpNLjhuCJJjW0Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWJfspA3; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWJfspA3"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab01c46697so11057081fa.1
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 19:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792378603; cv=none;
        d=google.com; s=arc-20260327;
        b=UP7RnNzC094uXh4y9Yoqw3cbPu88ftD4T6oIkJoiZ5VVOJn471tZsVKGr0e0Cficzu
         qk9WdbU5EtW93KehnjPuE2MX2dYsp12z2+spWCG97s4w9mLkeDqKiOcjEoe62N9gMsE1
         QLD+NFdU1NWLhrNX07K6uPCSoAHmFgUANH6H2hb6aTdjF9pITlLzmAmP4hZAK0WblzCk
         T6sCxa8YJOB3rhD682i7Swn8POiXVDhWChs5dzP7xvCfhsojIeWIYag/EBxIonTYd9Go
         cm5oOcVybsGKbQRrg+h7R6hvO9+Q2y2H8I1PtmmKBr9YO+Egoa9HKxEAXwTVSAeCIn2N
         ZLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rEXy3zJHTBuMv4/u8qe2uCzOwS6GppmHMS1cvnhJedQ=;
        fh=tfvODTJoP18ITTbVzDSvOEUYewnp3/9RsLDyBxPkIaY=;
        b=rkvQWcAdSVasrMZuw0KBWWd20qToUtZcK5UwvIJdwNxyG15Jr7A0mYahRgiLJMuawa
         j7gjtIEnIIGTOBvS6IqpkUXDH3cIN2ZXM/GbqpE+GD4xzcEwMA+QL3D5nRcXJ/OVFV/p
         /bk5gMCc2VKeCdPRlA3R81SFIDo5IuX9YUIYkbtqQlCdsj8jnyicA1yk7MTT1SeimJAL
         zbeRhQyD5T9EEsme4wuDp1gur/BJnAI654WQjaMMNX5pjB4MGqwiiUG/ABJiksztem1K
         HYj8HIwDyEytKmdGLaWmWELU7qjx2ypdwIxtZh/SRVi7jdCjgGAS2sylszO97/9pirGu
         rrhw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792378603; x=1792983403; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEXy3zJHTBuMv4/u8qe2uCzOwS6GppmHMS1cvnhJedQ=;
        b=eWJfspA3Arkwdefy3hQ8SlHMPZf0XjzKqIGcx1S5Zq7SDAanxoJ/zd37J8RMRf2h32
         vwWUkDYQH5kO6j45ZMH3oocC71WBbDqVQrAwqD3OvP/G3jwCFYGOH33mIBf7E8EDHrsY
         hjMaIDGOdfVnFQmH96uuIKsBZM8qtOUYbTI9FjC5CmP2KMpEnBNixRcnyEWeczLfbJeu
         R/fQM7eZ9dYfnfNrgXAX6MdRvDrqVLVBWuVKiXPIENquSe9ZjKHKqyeaPNpdxcXyszda
         oFl025N5lGuo7ubJXJKPESBpoIvMSU+FIMw37H6OTHd6J2rTdHEo1OnM6AtLVuWTbE3Z
         +y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378603; x=1792983403;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rEXy3zJHTBuMv4/u8qe2uCzOwS6GppmHMS1cvnhJedQ=;
        b=bhay+uwzlV29qeZp7aE8LYnpgDZ/Falu7KlQkf7rN0596ZxM+xoAMpmSpIah/5M+wu
         37dnXEy6L7FJpi3JYo//shuvU+l+R3H22mJvUViu/SshEHqtWYMAwZAUR9sHBd27/bI8
         lT1c/B/1RRLM70hrcappaj9bYQ4L20u1drnbfSn2BA8e8su9dk/XWGr2VcyFjcRjRl1I
         6hz35WEyW+bx+B/SYX2UEIIF42UXfTHAYSyprXE6Mc+vUXOuXtSirkYHX6YGUmDDi6ca
         3x1By6/T86r3lBrOR3fatTeUkeypeMPAH0U4OctdNvR4wR5nl1DH5AzzLpY+47lfMI7h
         Vmag==
X-Forwarded-Encrypted: i=1; AKwUvBzm9lkpExUfj36J+nNhm0+BXhzL4d1xMzWRrU/xlK0sU9kz9SC2SWA8JTecSmsltp4pPoOQP2mJAwuANpwIZg==@lists.linux.dev
X-Gm-Message-State: AFq9FYK9AwvLXFLd8L1XAWU/LrL77Cn8CevF9o/0HUQbaFqFiiMzYXGG
	34dpnfEctFmKBmspx8OSbn9F9E6HWIAIbVUDXjBXemaYb4ZfGY3fY8m3NoOTmxcwDxoIojvnPCr
	/kpge3n52XoXhkdkOsBNcJW7AgjTu7zo=
X-Gm-Gg: AYBFou1HSiYd97pP6tPf++VMPEfyzcZqyeEIf3V3baYbWqiweJPJoK5K0/ffNMpk1IE
	bRmDOAm1wR7g149CHYWRQxA0duQf2fpP5hT8HOh9Cnc3NnFZEXLhUKTGilfmUb8zKRtYsZPKApX
	J9QGo9+e+HyIJ38JdzJ4eRrb1zIu3JQsiJfd0ds1NT5GpKZOs4vdKGr2hJYg0ikvTSYlcsO97B4
	Lo/1JV/igP45CZBy2tLS+3QCUP2Ey/TnXRZdY65SPCeU7BMSqLbsfhk0iYzQgIQJ/XWa3/llXi3
	tgl2aG44jI8U9JIapPpHZ1V+ScEt5yk92OqSHD6JIJZaxbdoL1OGA/w=
X-Received: by 2002:a05:651c:19a4:b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3ab29121df4mr16100801fa.9.1792378602626; Sun, 18 Oct 2026
 19:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016035851.771496-1-oss.patchbox@gmail.com> <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
In-Reply-To: <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Sun, 18 Oct 2026 22:56:31 -0400
X-Gm-Features: AclHuK-33whnZxqMRpG7_qtTL-IVLp_9OZjQHscnm4NOXyKbUUtioZXEGPyA0lc
Message-ID: <CAGG=RgB2NYmjugQrVOiKyfPF=_aU47CY_JXGmCLQ-kOe4Cxp0A@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if destroying
 the QP fails
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 12:01, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> This commit message is long and hard to read. Could you make it
> shorter and more readable please?
>
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Cc: stable@vger.kernel.org
> Nothing against the change. But it does not deserve a fixes tag.
>
> > +             /* The QP still owns its buffers */
> >               mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
> While here, could you improve the error message please?
> mlx5_vdpa_warn(..., "destroy %s qp 0x%x failed %s\n", vqp->fw ? "fw" : "sw");

Thanks for the review, Dragos. I'll send a v2 with a shorter commit
message, the improved warning, and without the Fixes and stable tags.
