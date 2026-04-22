Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4321C9EA
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840888; cv=none; b=GIjBHYfdHHP+w+YRHu8WwtNzLC579RaDj3EvAxDFQ8XrEe+bc7x/FX6D8MPcahOzCfEHr12oWq5ZTw3jImvFD2YYJk87THJZViZPw3/ceEWpwkKLNKF4iyAB3e8F1rWVN+9txwGlCBc/VXcR8T7PJ6b5nPGxSLdtsh9HmuSwKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840888; c=relaxed/simple;
	bh=M5g0U17jf72qYxMz8kLVwYzsVn+6qWRz8++xq+cwags=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9zfm/qyoBGQRD4pKOFVgPJxT++RpPfXun3ud4ixgZyWZEC+z9CqAYgrgqxt7svMgeppXm8xCCzmNqL5WiqOIxl10ZWSVZwCVu7ECSgoRskpq/WZnbl/TQLzilVTYU/0FKbb8KvHuG0CYKVeXNm1pkA/nRBsHiFv4F+LBoFWv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56f65f62b4cso1716561e0c.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 23:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776840886; x=1777445686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyxMyDKhrlWE+5iCHg59pMAULgdQUBAeBRtLLkE5UPM=;
        b=lzCddj5bWv9Aq08T7ktzMC4IA/H2ECKWVUnBZUq74z+j+wjJI14Z6mO6RfBuSeqLUr
         ICOp/GjkemMU8NofKJvKFxW0P5SQiDF+yCsq8zjvr6GRrg9GrdrkP8fuJVQcCE31OO2F
         Phoai7FmqCxzQnszVa6F9DwB5DgLEBWMxySJ8lt43zp6ygkuALid1IqJreMKuWm2XIkX
         ybJPrP7tY5d5gzv/ha9DxUiUQ7QxItOk7FtwvKzE5Zn67fZxgT5cwGz2Z4HMviGneIH5
         EnOMnBLhZX9SxkfwxwBxEmtnGnImK6UFgguktaBAwY9HNL/1wShEGlLnbEo5Zizg0gtW
         +E0w==
X-Forwarded-Encrypted: i=1; AFNElJ+2xLAx0qmCyYzp7Nw4fEfYTOo4+ikg0RN+XKObuhKEAieB3mIJ0C3Ju8n5c5fmCbQ+b/NjrL+RaAUfBBa2RA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy82xGBpqfrh3zDpp3yUTXRV48MVvBefnepqmnZmfvpdYOHacyx
	L67DX76IOAMN6MW3RB/az/eo2A80XJbHnQcZ4d3N+Q9RKXdWqe8YRnj9UtsJVYYYyb4=
X-Gm-Gg: AeBDietIAei3jxN8JulpNKIsB6zxifutBLktA+dUc1TF5EgrCewhNKc5uGibG9v5suA
	GZm2oZZdqPGWqLw+U+TXxQuRU9dK75Nvb+gej/PA8J0hThgE2krmmR2b6hbGEiINZlAX/WiPx0l
	ESd/4iMPrJlniBas9GOA3DLIWSmbE5akEyGgbTg3KY0rtVFKFeDx8ik6IzE21A+3fLViAM1rUF/
	ZizP+FWqva+Z0U2KUIrPmUl8MYSaLfLL49ktT1gV6zN+wowJv6h5VWPtCONEh+XOS0HrW6vNdI1
	Aw2dPfR+fX7mUjMfyVD3XB6LHoYButvcibpJyJEOGVtIKs05hbumdaqmlCsob+Ndr76gMeOrYwF
	jlbAKhKeVFq09oP9Y0aSWquRqdR7vw8wQHIn6eh87ZiXP3t+GTLdVuWzGEC0yvqQBfS+VfPlbsf
	0kg0bw14mGJpDaDUmqub6MvA7tzEtIcc/wazURK7Io38NmHa/v8+lSPVrgtXETkYrI4+ylX1VTo
	xg=
X-Received: by 2002:a05:6122:3124:b0:56b:7484:39b with SMTP id 71dfb90a1353d-56fa57fe337mr10793769e0c.4.1776840886171;
        Tue, 21 Apr 2026 23:54:46 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm9240407e0c.5.2026.04.21.23.54.45
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 23:54:45 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56a9076813bso2098967e0c.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 23:54:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+WOJBzDB7Mp1/KF2Tf4ERNzNizqFJJeRhr3gUpPv0ssYv88KkxXzXygVXnSWG3aVc3VUJ48EH2JdIggZrgeA==@lists.linux.dev
X-Received: by 2002:a05:6122:f84:b0:56c:db8b:504e with SMTP id
 71dfb90a1353d-56fa59fbc9fmr11532873e0c.13.1776840884876; Tue, 21 Apr 2026
 23:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1776808209.git.mst@redhat.com> <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
In-Reply-To: <006f9142e591ba8c340c3b354aee76aec5c285b9.1776808210.git.mst@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 08:54:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtNPY1=92H8GZSDkQ5_rNnxL6WkjTF=1ApjwTA4z1TqA@mail.gmail.com>
X-Gm-Features: AQROBzCgl_wyqpfJ8JAvw4YHU8svwkzmMCs8RMYgDiGFQgsN4z72BoUKVxkZaoc
Message-ID: <CAMuHMdUtNPY1=92H8GZSDkQ5_rNnxL6WkjTF=1ApjwTA4z1TqA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 10/19] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 00:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
>
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

>  arch/m68k/include/asm/page_no.h | 3 ---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
