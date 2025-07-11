Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D732AE66
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255361; cv=none; b=hzeDd/y8RZZVK2a0fn6a/chXRQKQiIV0AyX5YxOW9hFm2DhmDJoeY7rAJ0uKzWgH7Ub2ykZC2CWC/9fIakN9HFOfMYOZxMZy5u3WI75VcIM251bbzDpUgHEDNtVFfN2E9SDwFcgz4qiYYtQjeUbIwVo4ivO8CU/r7sZ3JRzNawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255361; c=relaxed/simple;
	bh=SFT0AClCTdm2eLaM1sI47oHJOy9gFaAvpTBXeycEt+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sx3GZTpuHVr82E8FnwPx7XqzdL27sNTo141locd7rXpWV4xOcTV/4KovghorAkvxVf6tiGfIiPjCsMpqaAaNzY6eFLXxLrlimWZxHZuLvANNJ4m5cMP28FDFX0SGBxZpFKbGG2fpwUsydxGRkUjKuXQrdbvwwjUYOIoqxATeXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZhV7BzSF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZhV7BzSF"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so4448099a12.3
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752255357; x=1752860157; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y7KQBMvE5wPTJUBRle+pzVi+8DRYqjxpjSZtude4vk=;
        b=ZhV7BzSFq1aO99BVxekZvkg8xDo4qT5LmuSfEoepDgfyHj7hXeZGr48N6C1p4pkhkB
         aOSeM9FJZBtmDEKXDHMO3HQGbhnq+vMmv7NOzD2jJcPzqu9fVD4OEWViSk8AUF4doe/x
         gPyBpsoAbw99nbPxP4hCO9lW4pwTDbKUUCyng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255357; x=1752860157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y7KQBMvE5wPTJUBRle+pzVi+8DRYqjxpjSZtude4vk=;
        b=JQnDIm8H2+S/217SxcpfgdHW5bCfzDubBMw3J0UdOEv5zruAhuqrj0/btAI4yppvAj
         Cl0/ZSfURUDinLhoEVXom9NOigt3JzxXDk4IMxYZRAeYmPnoY82p2WpnH4JyZHIzWbSb
         x16y1Ghy5FRN2aXCcq4e1yItB+EhXovlXAVKevuJn7k1ncLBbnE6sq/+zWuEZMgGXMcD
         2bNDtkhK3T1tpHCQIJc8CHgqyip4UyCi/GbtBdgl9DU6DVr04CI6ig1n9f/8zkmfkMJC
         BfwiLAp6BGcNPgvek/4OfMY8QzSM9E5oRTnlqWZ75ibJKvDMoPEu2MkAiQm7szasyuY4
         qwiA==
X-Forwarded-Encrypted: i=1; AJvYcCUc6xLCoiKMHTWriHtifEvRqYDdvHFkszR2NGwREZuOn0j7ksxD7tiZu08F7iWWo4Hnkh1YP3Kn/HeZK0qbTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh4SjxXb/yDC9UXYa6gChHIv+igABpugceNoAnrgVIwRETu6SZ
	VlR8m6TKlPC72zSFdYo6TiD2dowYJYaS5ApRp5yUOMNYP7ehbIC5JU/NT8PI2O1poZB2ee2Z4pg
	1fy5ouhZeyw==
X-Gm-Gg: ASbGncuxpN34/goBS5atUhos6TyNNlVdg3RyoIwvHC1YPAmB3LIO2PLVIXSEKTVm8YK
	EWkmuZdXi8Vj6P0dAp2A/wgYn0lCxwY0jpjCb2eV1id2sYNBHmu0rMzUU5kO+6EU0t/bNWNoKBi
	wMPqz9M9iWt9BMmjBWUY5wWslh1pZwFzgeaH88Lavj/A7Iq+VIfYgFLzLF/5TZityhIhn9Bu6Yk
	oMHUfZQWGyiC/sfp7E34NInNZlOXVlokqqyaQLBEAU05cwgxzaXKX4sMOaN8DRaR9QLEPs1Qd5k
	47KjaonjBRweo/sJ3zKSmLR2P0bosczh1mIFJ3x1hR7yt6EJoTCSGaD8BYcDNIz1+hEOEirRzPv
	l32rCgQcPSjGJZB8kB5sswdtU16jy7l4rlHC8XvZ+ddNY0mIWZE3yn06sJarFeyXXNSfUs/04
X-Google-Smtp-Source: AGHT+IHwU21WI3t14jenpBfSVIRrgMBYOi1CKEWU3cqGM7dxACzWHSVq110nklqe2qWABSkfAKw5uw==
X-Received: by 2002:a05:6402:440d:b0:601:f4ff:c637 with SMTP id 4fb4d7f45d1cf-611ed0b4abdmr2959283a12.16.1752255357443;
        Fri, 11 Jul 2025 10:35:57 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611e21c724csm1504078a12.61.2025.07.11.10.35.56
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:35:56 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso4424102a12.0
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 10:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqZ+rGqALKjUtRja5gMfe/9XqnoHRQ80yr3mQ8YZV4vtRQ5Sl3MFSwJzcpiVPnlBLcBCFNGu6NnIqYrLMbaw==@lists.linux.dev
X-Received: by 2002:a05:6402:13ca:b0:60e:9e2:5844 with SMTP id
 4fb4d7f45d1cf-611ed137bffmr3157234a12.32.1752255355632; Fri, 11 Jul 2025
 10:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250711093744.120962-1-tzimmermann@suse.de> <CAHk-=whnUp7M-RZ6yzOyF6bzA4cmbckaH4ii_+6nBm0PqKOaQg@mail.gmail.com>
In-Reply-To: <CAHk-=whnUp7M-RZ6yzOyF6bzA4cmbckaH4ii_+6nBm0PqKOaQg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 10:35:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif6u3C4gk7BtR1M+0SvHruXZ7xycP5oDdg-SF1D=ELqQ@mail.gmail.com>
X-Gm-Features: Ac12FXz0Cw3UTlua4uIPZpLiT2Oslevjx3UEJS8nAOMBtacwuTkVhrNGLknGSuI
Message-ID: <CAHk-=wif6u3C4gk7BtR1M+0SvHruXZ7xycP5oDdg-SF1D=ELqQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm: Revert general use of struct drm_gem_object.dma_buf
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, l.stach@pengutronix.de, 
	linux+etnaviv@armlinux.org.uk, kraxel@redhat.com, christian.gmeiner@gmail.com, 
	dmitry.osipenko@collabora.com, gurchetansingh@chromium.org, olvaffe@gmail.com, 
	zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 08:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Background for others: current -git ends up having odd hangs when
> Xwayland starts for me (not at boot, but when I log in). It seems to
> be very timing-dependent, so presumably I'm just unlucky with my
> hardware.

Update for this thread as well: it looks like I'm just being unlucky,
and there are two independent problems. The drm problem *may* be just
the warning issue that has been reported by others.

I'm hoping the login time timeout / hang ends up being due to a known
netlink regression, and it just happened to look like a drm issue
because it exposes itself as a hang at the first graphical login

A netlink regression *might* fit the pattern, in that it might just
cause first login dependency issues and resulting timeouts.

After what has felt like a very smooth release cycle so far, having
what looks like two entirely independent issues strikes me as
unlikely, but hey, unlikely clearly does occasionally happen.

           Linus
