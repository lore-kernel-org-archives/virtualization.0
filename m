Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190777;
	b=XCAdGoCLZSi+o6tRQS/KFNiGgq8kCkDUBItq3MUPwbTZ0/voHMihLeVDmh6BQOcmt0ch
	 Mft1pwWjdu/GX6vgeu44RUArtmMJxOC+Yk0BNUNygA1t5ULpoXt3ixFkDxrY+w75nq+8u
	 twX3kR+ahlaHpZm0ieBESxpR9uqqtUMOEK9U4SI3uiqeqKIgcdMta1e/aeRzUP3BnJ0Ap
	 YCwLmSp2lkFNfYZPy/TD8Wpod5MOQB8TE3GrQJl99h4d2uQxmsN1bM7iI88/T9j6szoWn
	 1RkaUu4XgXXI6Ndgg5x0nJ/37f2m9YZZyU2X1mRvSjo3IRilNjipSppXKUF9neoC62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190777;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=/ihHdUU+jVviFggXvCzCtgwm16AszawpC1LIVwl/qQE=;
	b=M933Fq3k4VXDvN49FVDh1BRXO6ye4rV6iF2ZUBKaKKrmuq+xVAqXX6pu2nPSG+Jz0nT0
	 0+fm/uW+InwSaFCgatKb4oYRu9nkbUkSZpHWsFo1eUjXEZ2qh+DsBVyEXJEqP0ZRIFPuR
	 nFcTyUXGunEQV2sFwElla4u9NkM04iQDwllUu0QszzFP4uXG+sxFk2D9CcilBcltWJrEy
	 QXzlx+dOZB3z/hYpaE+ZfpxZPjy5wqsfswcCPWfdWEST1tBDjG3/lggaQvcNAbOCqoGrn
	 CbAlTgmc6V0JgQVe0US81tMa2gcld74UGo+3BRpULcSJZtEukbR/pH+FIKVWmhv61EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="ZB+h/5GB";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB03606A32A;
	Fri, 20 Nov 2026 16:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB03606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZB+h/5GB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ihHdUU+jVviFggXvCzCtgwm16AszawpC1LIVwl/qQE=; b=ZB+h/5GBbqvAkJ54ekxLjvGA9O
	D9LNJkH8aKH9mziEUcEVeeNVW2eYGGN+jTB+vaoKK2DQgefgBdVSUC0euwaul76MaXXzFGDda38w+
	CV0HQYku2mlycBmx7xX50bcgh02e8WB6duHoVw6iN5E4vh+UiiLohZ0W4TpcgZ4sOV99I5tvJit2c
	68reAYpL8/lyYbw3n35mPFLIMmbRicjxfdsTw5KiOvU8QL/I+AfqCK8T2Ep/sGYTxHxleNyUs6cJ9
	Fyt0bfHGbyQV6TfKt92/kvpu1GtQWsEPV/dyOSyL9dPgWZDp2vTpqx/50Qk3hkzlOf+tFUU/u/Sb/
	2OzNA4UA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUR7u-0000000FVv0-3ZjW;
	Fri, 20 Nov 2026 16:06:14 +0000
Date: Fri, 20 Nov 2026 08:06:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Khan Zhao <zhaoguohan@kylinos.cn>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <awBv9nN-ZkyKi3vT@infradead.org>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 12, 2026 at 05:53:47AM -0500, Michael S. Tsirkin wrote:
> vhost had a TODO to replace page pinning with a version
> of set_bit that works on userspace memory, since forever.
> 
> It is really best to avoid GUP on fast path entirely.
> Implement set_user_bit and use it in vhost, to do just that.
> 
> Should not be too hard for non-x86 too.
> 
> Reported-by: Khan Zhao <zhaoguohan@kylinos.cn>
> Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylinos.cn/
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> 
> lightly tested. pls test and resubmit with your tool.
> 
>  arch/x86/include/asm/uaccess.h | 18 ++++++++++++++++++
>  drivers/vhost/vhost.c          |  7 +++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -594,6 +594,24 @@ _label:									\
>  	__ret;								\
>  							})
>  
> +/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
> +#define set_bit_user(nr, addr)					\

Please make this an inline that actually has proper __user annotations
for sparse type checking.

