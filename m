Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D923093CF
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686003; cv=none; b=CBWQx/2q3IKGtsIm3F78wa8GnLp7dbaCOy0JlC5dN1FRlP+/37C2PqhAXLDFE9ViqoA8wEj6NVArZcDMPM2vcNCVawcG0oPBfIqYkKiCb5nKMkyZQhkrqkLjx0+w/bm5ZQV1BwMH7A+PoA3PipmMt1WoRFKopflp9AmWDOCMkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686003; c=relaxed/simple;
	bh=FRlMTSLJ/LkYA/BzotLzFxEqgaYNv0EIO57ddaa3V5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHubji1N6byVptcIWV0wfrviq9D/9Wua1Y0yDgAGvv0WgXTygBMHzqpU8jUVeHL1UxlFsH2oE0fEmLqW8SKekwQ0gEXjppIjufPVpXMCW7QdiO81sQ/YlO9L4pjA1S14D9UVxYQ+YZkdTgSlszaKI+3bnfBcrmm6FAik4HyfQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSi2XrAU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSi2XrAU"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so926102f8f.2
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686000; x=1758290800; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRlMTSLJ/LkYA/BzotLzFxEqgaYNv0EIO57ddaa3V5g=;
        b=fSi2XrAUEvQqALDZPIZyZG05grG+99S8v/nhEa8UKRXI989g0NQAVauG59D5bAiMSz
         DupRYADtlEoNyzLI7e54PFww4jVRUm/ttP0x2uFhdi421QIqr4C2AYzJfPAJBz5vOWpd
         rRXeqY/Nx2cCVm8RDiznmOV4sGyxjvukqnDuQKgAWNVfk4A4k9xVYvkaHgrg8L9mJGww
         i3HxfseoYu3qWaNHH4u6iWF7Vn4qRIKwwnUPTyMcT4NG1mE9xkY7h+d9IOeXQpWrkF6f
         yhgWR38QpaaDAttSPhnigZ3U297l2fzCwv8kWe6v6lv/4bICiILlG3K2t/fFrQSRU5qh
         UDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686000; x=1758290800;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRlMTSLJ/LkYA/BzotLzFxEqgaYNv0EIO57ddaa3V5g=;
        b=dgtWsMliqSHAceiB/hwr5pEEXbiPLrMmOMfKkPBQc8FFF4n1KqWraklbVJxKqCzY9J
         2ZKh2qPiqMVGcjZbp0i9P1DIvwQWS5AJ0Mzl+B6WatHjMQ0te03Xa/k9qM6/zme2O3A8
         8B9ioB8L+rHeT4TQiwNodB/1qs8dexpscR2Ezk65wHFEiv3iUzTAfqMpN0dQlk5x2OPc
         LaDJqZpUaX+4B4LgTppGz5lrSq/TAvgQjEhB3t1rVQl4R2sNh4Glztr9HbpeamEpJyCU
         jptXwuXp+iIW01NZaozUEQhfRLMEpkeNyxhcsQBqSR3zh0tox70ztfnML+qUUf5ZfyjN
         9Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCWmEIAbEKctnjhwQ4Q0q3Qj2woYs/JhjHpTvd1UzyLcwK16+GWwvn7OeGoJnM11iSMbReRzJwB0tef8mmYUKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh9fIO0xDw+3lMKwD1oo2/qWIZmM+Vm7fmLxHIqLTiQGYLlLTl
	6WK+ca0hVau2vW3bkSJg40AMSfe9x2No70jzpX7hb+26+omEYhZv2pEF
X-Gm-Gg: ASbGncsd0ZjWbPksQukQJAUQdoDW88/f7uyWa3HJt47j+suYhjgN5vOEPG7V6nyr9xH
	m9R2JcGqLluCWE9dKy7VgfnQpZ3QB34UOcBWkN7H0MVJeM1tND/LvyMxCth/7rlrOvsCd0wRepk
	/5jfa+BrMU50ptbYJFp5l1Oa+ab87VQgrslN7PP8KJlsB+r4OQej7HWacHHVwuuEnT4Nu2fpjU/
	HVkO1djpatelqB7Ob1/5p5HEdyNxzKiPJTQNeWmcoBiTXr+cNmuyOtliO8uq8XhOkODTmTWvXAE
	ijBFXWF8bib2sF9YvX3VYvb/6KNwzk6CzlwtbtDMxtHY9sx2MkGEQE5984Cv/2yTfqGS3U21Unu
	+sFy48bf6MCPBm5habUfkdZnfyuS4/WbC9Z6otr+JOrBPbmvDMx53lUD/wKVvGtPMQe9Z
X-Google-Smtp-Source: AGHT+IEGTFi7JYS5g+yPa7h/IdVXR1wnmLz0HIzSvf9OY0DM3QOIA/rU3oyaswgIPXV5nn/ocSsxhg==
X-Received: by 2002:a05:6000:3109:b0:3db:b975:dba with SMTP id ffacd0b85a97d-3e7659fa51fmr3102179f8f.63.1757686000099;
        Fri, 12 Sep 2025 07:06:40 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd9fasm6600759f8f.35.2025.09.12.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:06:38 -0700 (PDT)
Message-ID: <6da404bc53aeb60f16cdfd1cc0bc70ee68a2ce0a.camel@gmail.com>
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, Amit Shah
	 <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev
Date: Fri, 12 Sep 2025 16:06:37 +0200
In-Reply-To: <601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
References: 
	<601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2025-09-12 at 04:56 -0400, Michael S. Tsirkin wrote:
> when a previous version of this
> patch series was being discussed here on this mailing list in 2020, it
> was decided that QEMU should match the Linux implementation, and ideally,
> the virtio spec should be changed.

This wording has been copied verbatim from a cover letter I posted to
qemu-devel and doesn't make much sense for a Linux commit message.
