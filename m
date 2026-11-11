Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415459;
	b=GulrEReUM2k784wXe6BpFTcO+RJfPin7GSwS5JBrkfxmcHflctnm1guTFF3ftB2ysIUR
	 qORqNbXtjCzre5U0ZPMhE0SQHsQs7QV8rBwVJkxhVAPBuleuvA0FWUGjkEM+DFlzG0rlv
	 EYY8Mg1nE6PH9mjdmb9Y97h02t4PJp+P1ZFWsJYR9qKxCMyGIcLhrygaSSq0FKMDcluvT
	 KTZF04HLZjoqkBTgbq77EvvEvNsIkwSoUxVxrbVHPtD88tTYlNRlL6dCPBeHE7USSlVMT
	 COc3ltvyrMWqBffiBG/v3MnP9sfbpSABNxbpMJ+YJZhGDoHdV0eNovKStMYYYW4aQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
	b=fEP+Ftmr4Br3XOUKawB9HfyIEkYebuVplb523JTZFl/6YWvS4vPP5AlOScTilsApnJt4
	 VfdhHdBx9rFGiwxU4p6zDv4ZqbbiaBCa1ybyWUdeBtgWhUKqGdNbKqmoyvchx+wBB+rv2
	 mYshgTP9nIJmfrfCYK+zZVXe7DuvJ9/wHKWQfmSk7NNuioBl3YCNkfip8fwyOGuGncTtX
	 xPgoKUnXxbHj/ktunb2UDfMBOYW/pueNhSDK8J7W/aougOXOt3qVuQLnxYUzYZvdcJDjX
	 iCWMHaJiIXTonVPjB9uO8fvLFo9ZVJgKF0IWjDbimEcfKdDBQtQ40I0WJeGoor8P1jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VurcQ5Mi;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CF606A881
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399CF606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=VurcQ5Mi
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso12931a91.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 08:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794415459; x=1795020259; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
        b=VurcQ5MijIwk100lzvsvlQl3xrZ7r4/OkVGhBoktc98J8bCioyluLnTwrN7rUpAVAG
         CPpFydwm8g6UM5HGNyNDVmnqWrLlgBeDHa03ZWEIk8PSc57nja1sGm9a0wr99WCB8Q6O
         PKnyo9rbV47zYPTH8+Mg2WuPUWKp8txvQp2RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415459; x=1795020259;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZsD1auAFGH9focpKeQLt7lmstuziSR0maGDEOD7IaE=;
        b=EBcDw8LUGf3AgIX+RY2xG2ybBlOED5SWhlOJ5ywBAocSBYxKfNuGFMckIf4a8J5QOX
         /r7zncvsLUPZYh3IX7i7+NdJB/3gSI/VRcRKz6DGLx0zKezzt4idZhfH4JsGqD4aG3YF
         QZ70t0V4vJT7ql0z8XNCB6n3Y9rlm2R8NL3w1VgrQOig/sThBQiqAuaQE0unOMkj1fWr
         HAi3t6wj8Pg0yI9QQ9BZ2leuuDzPq05R5xOea2HhHz0d5cWIZX66pUBiQckriCs+Sjk5
         M6oMOIllHLa3a99Z+ahxNTcNxpyNeDVnkmfH1dkXfbR1RE/yz16+YArV3gZw+MIthZVo
         0+jQ==
X-Forwarded-Encrypted: i=1; AL+hErHzke2G6O0wxoL7DSNGMO2cL2K3LZBVVXZ7opDRi6JTtZQzzvt7GBgyqyb+3ZMjYxh1qMl2an843x7Kv+nFfA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pm4lL81A1ayVFjYUqC434Z/SBL/hI61xociZEXfIFzyaOJwo9
	efLce8AQzrhZoZV6iJJLL7UPx7GXpAZvnD+S27JuX7JBW/9ceSWSrwgdAXWkO295ZA0tzKrNiB8
	ZcP6JiwgYgw==
X-Gm-Gg: AYBFou2Q2oMc4FmsNoLwI/JO5uU10axhZg0UcgpyNLPLuBPsK7t1VgcSGUjVYlwEOvW
	cZCkD717hA2Wh0llEwtWiaFPthEiS21J/N14S2WKjFKCM/e34dmnTiur2FiCz1dR+lwp77jrSNr
	Uu3v4ywA4JAKl8zg1RGEijq+eHUAv/pd7sGfCATQD8YLL1wo4jaLAkMR2f2DmuDUJDGWGWnqHxC
	mdPnvNhR8RJKoRmG6p2IHIUnUrt32rGCS1qY0JA0rH8TWpYmq45EM1IGAYZEh5q8wAJyMVX1GZD
	4d95p7sdLfZzrI/ivk8awgUtgDQi85lQgGrT07HpcMySO9IWHu1sWV+6KEwIPFoia4474tuzB6w
	92KNvOjzZ2ZBpVuks4x48zL491+GSGHTYdWOb3VFW5GO71b83Yhw+ow7N1xY4L2CNEbnQdy0hM/
	I7XGCRrCOVFwdegJGojwdGmVBLLsY/ECaLyQREo1MJ914PJzCOSnUctBecGA0HTrYxEWWS+KBOS
	af+0jsDUXSw+fXbWoo8385du49YSGzURcyHeSTENeRrfkc3IbaSPOWvEpbibdE+2beDq+/wLBKP
	OoOCyWps6244YqFOprg786GkiEifJNtAQiqx2+Q7EaKRUJwl3rKHqh/H7AhNQMKA82mL10qDRiI
	nfouhfaXQdrbLc3lVwjNdFZCE
X-Received: by 2002:a17:90a:c2cc:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b197caa440mr22529a91.22.1794415458565;
        Wed, 11 Nov 2026 08:44:18 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f497sm16556a91.8.2026.11.11.08.44.16
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 08:44:16 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso16067a91.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 08:44:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH+EN6pSgilFoczfKHvlhNROmwv3xkYsG/SpUxiq0UoK2s4GDLP8PHNsDltOLceJObvS+KuUoHbepHRPzHU6g==@lists.linux.dev
X-Received: by 2002:a17:90b:1d45:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3b197c817dbmr35589a91.7.1794415456305; Wed, 11 Nov 2026
 08:44:16 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
In-Reply-To: <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Nov 2026 08:43:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
X-Gm-Features: AclHuK9b6hltBFcCGqxpbtG8UmrJwldogvwXrVDW7-YQ5_XK3IWVlpv59flts7k
Message-ID: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 05:42, Christian Brauner <brauner@kernel.org> wrote:
>
> So the fix below is what we've done before for pipes and I think it's
> the right thing to do here too. I put the following on vfs.fixes:

Please no.

> -       src = kmap_local_page(buf->page);
> -       memcpy(page_address(page) + offset, src + buf->offset, len);
> -       kunmap_local(src);

This boils down to one memcpy.

HIGHMEM is dead. Nobody sane uses it. It *will* go away. It's already
effectively never ever used.

There are some broken 32-bit arm setups that use it, and legacy museum
32-bit x86.

Don't make one memcpy() that can be inlined become this garbage:

> +       /* The buffer can span several pages of a compound page. */
> +       kv.iov_base = page_address(page) + offset;
> +       kv.iov_len = len;
> +       iov_iter_kvec(&to, ITER_DEST, &kv, 1, len);
> +       if (copy_page_to_iter(buf->page, buf->offset, len, &to) != len) {
> +               __free_page(page);
> +               return -EFAULT;
> +       }

just because of broken shit that nobody has ever complained about or ever hit.

              Linus
