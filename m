Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E72AE6D
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248941; cv=none; b=Kxy5vpiZC4v9r6eHwYFkDiiqIsVKyoVWkVNJZK/rDXMCbxk0pjbwdYDZL7ReTWGbCdWh0wv0zFFtWAniym5ubKLexNix71otnCrfWkuP0CaG7oLV7hVb0ljZ0qYGO0W8VPeNikGwujXXkHQVN4F/nHGoMJiFU1ABVA6vSXZI7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248941; c=relaxed/simple;
	bh=EgxY5QsE7wzpasqsrTS/a2pj594T9ax+wqiGDiBhuY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCBah6eNL8FAtgSr4+CSSsP4ZVSMsMvo9jglKO8BRrQD0Zq/t5YetRt7T8fVbcJURV6znFaUgYlNkM7u5fL8D9s2bYZTUxV2+aKzxipkz9rdth2XXxtlfx5t61TMj391sonsmtVnGInhaPJbK3/b7oGPIIuYhK/KSytg2ryIvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fq2INlWJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fq2INlWJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3a604b43bso376595066b.0
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752248937; x=1752853737; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flK+SksbT18bLb3jG4ILK6UNz0qu/K2MvbsIMeVlTeI=;
        b=Fq2INlWJNJxHKHU+3TcW9eUx2o+WBQZvEVz8Lv48ZGP6kUjalSW5hZPQxIRSWM0xi+
         cHu7D0ZZUKUjWtTJSQWu7WYkVnqHjj/I79DDLITCowVXSgiLUMwpbxAMeMIXKUhzUJqn
         0HBvosvVfWS9BYq5tF773vsg6P7Fshi+tBWUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248937; x=1752853737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flK+SksbT18bLb3jG4ILK6UNz0qu/K2MvbsIMeVlTeI=;
        b=Xz7duAML1ubegG/4h6Bz4OLxcqXCEjsLDXhf7manyPThoCB24Z4uqhVoQ2fq7dzhmX
         E/z4tP5iCoek0CWB1uCoFc6gx7u1QYebtQkpDRwtlGukWWqUiVfBuillDq/SpqzJFOHQ
         34fZ+IxTi/TCMPmI8v21BpZyC4/PndM7LvwbhSXq8pVwhmAI/FmQD+a9MJgbqIELDI0v
         LAnEc1mgea5Gy5GJyfh7wl4dvzjAXPcisE+5FnLcCcjeGQcYI4jZ/G95tEqCuKFxpNuU
         zAbN4umTP+mxBTeX8HzWOIel+22xRbd6MxU4BxyZ9BWnbEB2W+VAxTqrqjiGLX6PpIAl
         Ma5w==
X-Forwarded-Encrypted: i=1; AJvYcCUc7XxmuaoC88VnBGz0ibclrpFY2K343RhOMWYEEuqs8l1HjTXZtdd+DUxJWWuNtq4iDNbBZhyk2offNc3fSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlU9qRSv3SAiRFMOPWYpVGQv7xpwzgwFexAJJjy+qaCkBKsTMp
	4yS2hPqiXSRgKsyLtWIpvajpB90avbEV3+BvNIUjvJVjHHVg5u0AbwlmiLvuCgjQwNpd380auS3
	7kZaw8BdMig==
X-Gm-Gg: ASbGnctNcSit0AT9Dc8tRw+jp/1LXb0lPO4fnwV3k9A/rrZEuReK7XDmFfQlymDwKfA
	5p615yUCqRuIGDQl2sZy8V7cygr4hSBj1G9gQGYA+YOsPHeWr0VwAZuUMeBniEU3gwC9N40+zha
	3sMC4kOBIONXlTfMuumDnWEQRrxJ9FBS8ZwsnP86V8niTBXVe0f+oq+IzUp4GqftrATB28bJI4C
	h0Bwkf0Lq/q3Fixxd5JqiySFGQhJnBDrGIjnZihHeOHDSTI+aT7uXRxJUQ4Vegatbn3kwzLixZ4
	HqtaH6gtz96KWZJ0LGKhv8cBCcPH6d0sCpBMba87waLocYkeiY0aqPJqlaRsDmE09JNymJRiR1H
	YNrmSzXLpiSB2UMBIA/WKOlF9GaeG2fT3RQz5g3CIHb6YwXF0vMt3S5zpCdy96EKnwA9Ds+ov
X-Google-Smtp-Source: AGHT+IGokbDGdPMx173aFp4EXEGY3k2PbPBF3mREmtwjc0yBa2izZ8FkcNKCG4R3r9Ik4BwdFpWMCQ==
X-Received: by 2002:a17:907:3d05:b0:ae3:62cb:7654 with SMTP id a640c23a62f3a-ae6fbc8853amr454788966b.17.1752248937424;
        Fri, 11 Jul 2025 08:48:57 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264636sm311608066b.86.2025.07.11.08.48.56
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 08:48:56 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso3604306a12.1
        for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 08:48:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6WFKv6eUAbPupjhBD0+i5IHIsUTR73q2K76sdWzHtJL1zh+9IZGzlodEdvIQwMqz04bodwTcee6McmtqW2Q==@lists.linux.dev
X-Received: by 2002:a05:6402:2345:b0:606:df70:7a9f with SMTP id
 4fb4d7f45d1cf-611e84881c0mr3248744a12.19.1752248936308; Fri, 11 Jul 2025
 08:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250711093744.120962-1-tzimmermann@suse.de>
In-Reply-To: <20250711093744.120962-1-tzimmermann@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 08:48:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnUp7M-RZ6yzOyF6bzA4cmbckaH4ii_+6nBm0PqKOaQg@mail.gmail.com>
X-Gm-Features: Ac12FXxfNX9iFY-MTPcFF9E1sp2PSMV-QdcnP7if0RVZKfq1TRX51YyGvLKD3nY
Message-ID: <CAHk-=whnUp7M-RZ6yzOyF6bzA4cmbckaH4ii_+6nBm0PqKOaQg@mail.gmail.com>
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

On Fri, 11 Jul 2025 at 02:40, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Reverting the whole thing is the only sensible action here.

I'm assuming this is against some current drm tree, not mine, because
it doesn't apply here.

I'll try the smaller set of reverts that Simona suggested for my
testing, and will get back to you on that.

Background for others: current -git ends up having odd hangs when
Xwayland starts for me (not at boot, but when I log in). It seems to
be very timing-dependent, so presumably I'm just unlucky with my
hardware.

The timing-dependence has made my attempts to bisect it very
frustrating and non-conclusive, but reverting 5307dce878d4 ("drm/gem:
Acquire references on GEM handles for framebuffers") made things work
_better_, to the point where I thought it was fixed.

Until the hang came back.

The "hang" is not some kind of kernel hang, it seems to be user-space
getting confused by the changes. Because I can still switch back to a
text VT, and there are no messages in the kernel logs. And the system
"recovers", in that after a 30-second timeout (it feels like a minute,
but logs seem to imply it really is just half a minute), I get

   gnome-session-manager@gnome.service: start operation timed out. Terminating.
   gnome-session-manager@gnome.service: Failed with result 'timeout'.

and it restarts, and things work fine on the second try. Except when
they don't - on one reboot it went through this twice, and

Now, because it's obviously timing-sensitive, it might be something
entirely different going on and I have no guarantees, but it does seem
to be related to that commit 5307dce878d4.

And I only see this on one of my machines. Again, might be timing, but
might also be that it only shows up on certain hardware (in my case:
Radeon RX 580).

           Linus
