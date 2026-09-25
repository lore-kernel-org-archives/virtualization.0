Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020A1922FD
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790315907; cv=none; b=aIIzOLLqli4gjMXk1sFj6S/X1kARh4gIn5HbuVvcO+3Lz9eu9sn2mEN6DsfKft+pcqzNpx7nWkZDkmU2f3GVlk+PzgqG7LCgE05/zXtTt8abbzhdbrniVL5oTrL9eiaQylLIxPxl6eMEpP7kZxbyUbL+umAq9AqTMEnC12YetT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790315907; c=relaxed/simple;
	bh=wFmH4rK3RuleiChH3Brg/+jAhEcDUYox1Ynn+R6XLKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI1oSoUp9Bt6NvDRDOOQBvL1hv/6JZK5jo9HRUjImqJEOtl58JJaAv0RHghXFl6H0AYU3xch6K4tbzC0XiCwBCAVwO2q0OQ19N1i2sBGZORTw9OKjxHAGS8zggRmAKbQdi/RSoVhtlZC8OBfZ7suGkErMF+SxVRZ6m4muhv0em4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSH6f2Jd; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSH6f2Jd"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso2442955ad.2
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790315906; x=1790920706; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFmH4rK3RuleiChH3Brg/+jAhEcDUYox1Ynn+R6XLKg=;
        b=mSH6f2Jdad02+IHxmN12phTaRfpURKXLS/a62qTDAtgNV2Bn2hR+6nqhdmvfJZCaAT
         9nNPnZaR2dGyWZaLz/Gd+jpKx3ksvMYS3v2UyDtlxLJkXn0/fSA9ghJzDsSNnwlL5/ib
         77mPJKsuZ9vbJYGVSbB8Y9tPi47wHMA67lEq8POT5FZTX2imTqff5fEhXfpJkbEvxlIG
         wTx+trX9kH/oQ7rqnpP3gN8khJbYLPYkPA7PR1Le1sljdn6JcQ5QUEQImMNcuIvhEFV7
         rMXoSrkPbzCp/Wm1YAO4gZWXLpnRDgNvG/ztedCcwtspE5mjn71JdIeGxTCMlkHol3SX
         a/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790315906; x=1790920706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFmH4rK3RuleiChH3Brg/+jAhEcDUYox1Ynn+R6XLKg=;
        b=OeSjmD2h6m5uYWTsjNn34fm+XVAlonSIhLxfioJEQWuY7LIvwhfydf45AE4z9vCXKg
         fTNybjsP4iWSGvqB8CezTAxHdDvZhh8rUzJS7EnnGiomishC07VCNgneDdKvGjJWkhmC
         1ikHAhH8wmq2hFvB5tM9p68DQHFcgBtSBhuz6SGgJOI7NMqnGjox/BM+CqErzroleAnO
         SFckK3yoTeb8qUaBFXjEltBVN6M5Td4Zx8jB4UwqQZRm1dZyz6jw4SE8B9w/ms+6j7i3
         E609yYoFuBnrcDhH1rsSDpKCJKtlePAEQqL+W+Dh4G0+j+Y31tKlYmk4rc4qrv29x75n
         8WnA==
X-Forwarded-Encrypted: i=1; AKwUvByfp9Tn+YDtLW6AKTHaEWnlUnGXD9sd0sY28q2CZPi8h8DOJOGIxUYYLzqzHLccUm8U11AWkoymqVdOsGmYhQ==@lists.linux.dev
X-Gm-Message-State: AFuF++loIBQDvFPZP3UBq3Kk8r9dMndf151trNUEea6yV0R00bZ0d6xF
	3Wsh6duhuvu1xu7LdwbmNHdDp+YEQL9pHuNmgTJa3EE3b3+oKPXovdKf
X-Gm-Gg: AYBFou2WPlTTv6r9Ufmt7qvfao+T0vjeu5sReDN5g9v5Pj5ruStz9h/rXE8z3n2ihQJ
	KnjiFhhyKd7ZSw6b98QLDrsteWJbOhgAttvVhfG+KAI92a8sF72nx35PmhhE66RIbGGUexGYLsa
	MODoOnw+FJ3k0PYUYSXzgEbRkA6tyP3jxcoQM8a1ppjh3cERA/PmXMghCM8hlPqI5uhOrDr7cCA
	m7mH1DRTd0MD4ppe60p/1BSE4nv3YgjSlYlg0nXQuJvdfVFxdlb2GfWYDJ+qjAIx2yZGPwBOFJ4
	nH8pPNRl1x3BJCuziB7caJ/UDC5hoNg5gGakUKufVkxQ716d5DLAVUtnhHQf4Eyr9roRykbR5cF
	AD9G3pSbtM7ObATIBw+fbXJtdlo7bRUticXDm8iJEcF0KdwFf+26tq4S+lcwuy/Rxw8KT6444ke
	mNCfIj/WMwA2JL3BIkj48k6FsSvAXj1AQ6dyakXVPouWlUYs57QKOnZMJmZpASx8HkEscsIlXWE
	k9zrtDvkPyD3/bD3dz0sqojxUN+UqUEBVsfIeYa
X-Received: by 2002:a17:903:1987:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2df7da68a41mr37782425ad.0.1790315905645;
        Thu, 24 Sep 2026 22:58:25 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9143cce5sm4734955ad.54.2026.09.24.22.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 22:58:25 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: sj@kernel.org,
	mst@redhat.com,
	david@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Kairui Song <ryncsn@gmail.com>,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Fri, 25 Sep 2026 13:57:49 +0800
Message-ID: <20260925055807.32678-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925054408.10431-1-lance.yang@linux.dev>
References: <20260925054408.10431-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lance,

Thank you very much for sharing this and for your interest in the related
work. It is great to see DAMON and virtio-balloon being used together in
another real, large-scale system.

One scenario we have recently been studying came from Sangfor. In a KVM/QEMU
deployment with guest memory backed by shared tmpfs and host THP enabled,
host-side DAMON can report a much larger hot-memory proportion than the
guest's fine-grained activity suggests. The related discussion is here:

https://lore.kernel.org/all/20260915025514.2434-1-lianux.mm@gmail.com/

We are preparing more complete experiments and improvements around this
scenario, and we plan to discuss it in more depth at LPC.

I am still actively running experiments based in part on SJ's earlier
introductions and our discussions. After LPC, we hope to share results on a
more regular basis, together with discussion outcomes and reports from more
scenarios. I believe DAMON will continue to become even better as these users
and perspectives come together.

I am also contacting the authors of the DeepSeek paper to learn more about
their setup and experience. We hope they can join the discussion so that we
can work together to improve this area further.

Kairui is also very interested in this DAMON use case and may already have
discussed related ideas with SJ, so I have kept him in Cc.

Thank you again, Lance, and thanks everyone!

Best,
Lian

On Fri, 25 Sep 2026 13:44:08 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMON
> and virtio-balloon:
>
> And it worked: time-integrated host memory use fell by 21.2%, while peak
> usage stayed about the same, with no significant CPU overhead.
