Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387748;
	b=BJnN55pkcD+LM9EztTZF7yeNnU9ez/919exRsGs+DSCtkABZVozDK0i8EGQDS5bf8Abp
	 AbvhjfG5WeljjJcApVDFdNOJyR2x7z12NqsJTfGEwgni6OlJ8YInOkcjodBchhKrCkIeC
	 t2DcT64562S7Gvk3P7Vksa/LWcZf+tGGVJaCuNgcWC6Thn8DVXKlhZ7F7A41Jde0uER2a
	 mEECFJJqRNOHacBQm2i+HwT39Rz4b/Qg6Kuz2JyAU8Ncyf/zGSId+Ux1pE/dXl5MbZcYw
	 mR5G149U4K43J1l0zaa3x6cylEGxvEkWIFR4sx9gFlRSRg4N/tQ54AJyO8jhVrshnZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
	b=uTinFmobABL7Noe6e6kO5hopmrfz8ZjSYvcWAucM5ROCfVMx6suv/tFz8evmsVhf/6Vx
	 +iD2+voA/msRad+Ndkmbe/O5/wH9ues6LVz3WlPnMXn9nQBWDgCjECZ+ekAgGYRUXeuwF
	 dmXJ28ZZPeWR02WfRhJuWgDq6YM8HMb84P2F90UvmfQ392iddcSP4N3OLC3OCOtuOaXlO
	 v4BnIbZvDnSDw0/MXGSomXzXrjIHHKoHAxbyCudimd5m71tnjZ0TCV/F5BpkWuaHGDDCB
	 h+KcNDOeqA+25pF3rzf8wnVADZSOzeB91j7NY2a62Vk041TMSxTXOL4OHXxj9FWSpkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=PMP3hDb6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2237606A324
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 09:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2237606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=PMP3hDb6
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5361e313e63so30616321cf.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 01:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387746; cv=none;
        d=google.com; s=arc-20260327;
        b=KDuRjuBKBjt/yMDidhNmE+wsuOp/HJrHdLl4587NTlzWh4XDu0eIVZq+UgsPsk1989
         4x9OqtKMTsIwMnNO1wex3jNwqvY4ZSj+RI6sXNXNuNi3weRggQON0RBZlGwOIbeVyqpH
         S7j8q6S/ykC8AgsIyMswRgeca0iZkk4OLI8kEbfrTxhbR2JpU26q0bH3nMvA5g1ocNR0
         ShLj8TadMVxuZsjd7jQVr8CTKzXUQ9G7yaY1oYJCCfYMe03Yl+r7mKjkT59af8cwNpeU
         jXpRZ+wCkQanjApEdZUCb3PLevsDcmDmZfA1Z1i8Ku3g0LFEs0ZTqH6K3S3OtuFTjPaV
         acDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        fh=rAVNmQcniWmp3fFZ1+I9d4CG5pxoBHAKI4bOF9QgfKI=;
        b=gJNoP4tccBm6gEz44qsHubUEGhhGT8ZwVJ9W0ERjzDn3DIa+N0Xu+RYe9lJREHOhke
         pv0fuwMFuSj0eFf+mXj7UoHXUUnM/PD9QUmAqFe7SboKJL9dxcThJMGRftA5+diBYmaP
         Vh04dg62XsAGJtElW6rokNmnAyGLazslJPhPpuGfCIlyLOTlSyRymUjM8dFUtwYKPF8X
         oEJQvViZGvGd6bayzZZFgdUCNODd3dO1TWG/r/sH1wP92Gw/eJORZ2RGy7Qgt0XUgMzD
         qPGFHFvchChJvPV7+Ra5GZyBhxi4Z+SHFai/UKQw4BFL5vG3h4jxuyewXtSljaoXWQF7
         sRQg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794387746; x=1794992546; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        b=PMP3hDb6K0ZCHB8aQ6gd8JYjmIlSYa3E4dVPX3CxEkxVBVxLTjjvPK3ZRjSFQyxfS1
         laqa0N/t2JbbfLviY3DcqyvEZ2w5lrmjNnS+tQPbFxrxOg9eyV23NaImLy3DVPThs5aG
         7p8bpfoQpDiY0qdoaLWR9/7NzeQWLY6QwB/jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387746; x=1794992546;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IjyYgf5Mt5Oaaa+hEYrZohiloVo+c5H01zKLrOs5Ypw=;
        b=kCcMb3rqkC/ZXpt42s/d6ZmK1b7VM93RiBdV/yQ49IDI19oQ7FSe/bp9anTJ9wXKit
         8lCQph794kcgyUzwIkptinuWa1076HJ2Y0/qllpFgmqWMi3bzCfX763Q4UruwA+SHrfr
         UI7qR0pB1fclIRM2On0giM2qYk8IPfZSi9NAXFlsn+L/zhUI0+4iA7Ed2XCq8c+LgZsz
         5gDsblHveCCx7nuhbN1BVOmpVzPtLHwrSIBMB+hj3CBSEo7qNOkNAtrOD331AuTzDA7t
         iKq7RIrvWKZNAN/0hksJW2Dy4dQVKQBVmRKUneadzqTtPZLeFKN1OrIH4LjTwd+KxbIK
         wIuA==
X-Forwarded-Encrypted: i=1; AL+hErEpTcWUVaPz51IVXmmgHw/fq2M9xnccQtHZe4sbG7Flbc8VmQpw0CsDhlR2KwK1DFkoPvH/rT7aQqvkgTv1Ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+3K1wDAEKQg0UIe5F9daugjgGSeelyYqvhA9LSofPPMxK4oKz
	I0d5hfkDHLyskPsmQC1J+wpFZHEvT9tGw0DrBrmvd3GDuIyrKbo9t9cYAJr8Av6/InN/tP+VPQM
	5pdSbJsPcnyQoXNPxHRwRhXQLEsE+BVMz9qkezP+viw==
X-Gm-Gg: AYBFou3mwE7as94btYIexSNdmo8WuF67qDaIlmfxnEdSiu0kfMNYyXed/2teljgbDaF
	uwWILm3/qS1ngq7poGalKMizmF0A6qMPwdWG0dAtCiwyXuh2CJo0mQEf8b8a8H3iPq25xVpBNiI
	7S+eVwnuZd9b+7FEWDpc6Wr2U8xjJn6SpG/ctDBPpwwTKbJPWXessyu1lTycZ8G+bwm85N1mpy/
	v44L22uoWsKobjam7PGcf6xpZsHaJmtE+K884iPIzr75Syq/RPD/oxxVHlE8tPKu+1YrkHegnRH
	yh1J7Rqs96FvvufalvaN3jiFibpbO1Em4LQJIpfFzHGhhFhpo5tAKBqQpWBdAGU6baACrhMWWQK
	cSyqFIVaXUMaM0aJjYHLANljYfE176E0LxZSrzDza+Zmrl7VZhYGdjYz2zVgKbMSdIQ==
X-Received: by 2002:a05:622a:34d:b0:536:8f5a:64a with SMTP id
 d75a77b69052e-556c222b82bmr24946931cf.63.1794387746372; Wed, 11 Nov 2026
 01:02:26 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-3-kas@kernel.org>
In-Reply-To: <20261110145241.536019-3-kas@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 Nov 2026 10:02:15 +0100
X-Gm-Features: AclHuK9XqiIqd0G6zWinytDup_EFg0rRz4_cn9sSXLX9jTiH3KRFdGlFPrXk02Q
Message-ID: <CAJfpegvEeGN073FbaCRnhMeX8RHrckSxmFjkpdoyea2EuRf+zg@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: don't move pipe buffers into the page cache
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Bernd Schubert <bschubert@ddn.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 15:53, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
> A splice() into /dev/fuse with SPLICE_F_MOVE lets the reply to a read
> request steal full pages from the pipe.  Each stolen page replaces, in
> the fuse file's page cache, the folio that the request allocated.  The
> page can be a page cache folio of another file, a page written into the
> pipe, or a gifted user page.
>
> Always copy.  The server sees the same data, and the move was a hint
> that splice() never promised to honour.

Did some research and looks like this feature is not used by any major project.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
