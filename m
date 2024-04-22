Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626A1DDE9
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805170; cv=none; b=BfptGfbZPQBL7G6TPYH77qYAYkkk2OhQSkepOZ67uHYQloOp06UAbSnjAPPM2TL1lnuR/rZVzRr+KSzK7TUpUgt5WlkWqfE1lI5VaeMcC37MV+j090SjS2a+Srtg0W7cFPcoqdJV2TO9Hy159jwmjj1ffJMZODWWydX3fECqxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805170; c=relaxed/simple;
	bh=HJMGmF3SYu4yTESElcXXrvUpfg3wITeaCnIFmbGW8Ww=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OYRO3fNhR9lxmtZgT+5OWoHskuF/YaKzDucbyPLr4PLP/xaYvp8zocdp1GvghZzdN47UGOCTfCNnNleGUGrG1H1TDqMVkbVcTPqYtVQWTJu7H95bn0yUK5FYD6liB0KeWnizWq0Efq0mVEkXvNVzXmok122G8bQNVKHOLcyBU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph4emm8g; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph4emm8g"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78f05b62602so308305785a.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713805168; x=1714409968; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrIzzRd5SEQLFvdzQYqOFzNQkQZWaPc3JGD8u2+BkdA=;
        b=Ph4emm8gXczCFxo59L6RUwWGt7wmKSRsLJUGPzBVLDiS9LIiG39P6e/F5IXqJy6IAf
         kxRsJ2aLg9Rb1pq1ZQfxrhrf2sayFtEvQZBkKDg4hU+XvfhYbr7V5bZ9/E25ipD/0/o8
         nZc2xmm5NvnGF4q+AH21tm6gt0gpiOv0j26HN+a/lGT+pP+rPeooYggU41vxazi0/EEl
         exZFS6Ghy33HBRWU5B23hE5jUZYzGCm/pqQSo69aGeqaU3e2lFWHEKXVLHXq0BWVWPx2
         kkb2McLaOqXSMRTTE7lf1lGbck+s9urrxoyQROxxwgSjgcfqIJrI8y3iap4eax+wSUUT
         1BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805168; x=1714409968;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mrIzzRd5SEQLFvdzQYqOFzNQkQZWaPc3JGD8u2+BkdA=;
        b=a/rhw7TRTKhDd3+s99jyVNgOge1jmVqLWUd8jABClyCa2gI1nyrjMr58Iv3Vqc1jZC
         fh0AazSjAZTqrRuSIiS0bP9F62f9hEf5QqPThvWCGNlZ1B/QNz85fgJ4vXSOGwX96C9h
         11lnY22dsjQ4UBD/kZ31R2j+C+rjwuTX48inCEyGIoFdh1yH+g6oX7fsYBdlHjd0Wnnx
         ohYfNysiRBow4Mea4r/adcB/Q8eOA0QVi2EfvP9sjoop0dhXePzheA7L5hBwJU1S9jsJ
         nuO21X2bar+CB+8x+1AMfGduucuoUBu3L6ArMHdRsyP7YOH5KduEZNzwMTxqtoYhjzWo
         1R3A==
X-Forwarded-Encrypted: i=1; AJvYcCVPnO6tiFVKYe3hrflAxi4N+vtUbizJYJIbH7G06rhhYQU1SivacGcV2Vh0/6P4fzsNOrWgBWcb1a7efnkNFoVxvpxRPZy1CUUi1gPr2wI=
X-Gm-Message-State: AOJu0Yxsq1ZGBFDCsrX5otWkMmLekkv2U3JCRKRrJzQU8qTn9XX7Z+LY
	rid1Mgv7rUMpwOQCtWxN8ErT9qggbMBwOHWXpNHNsJEPtNRC5FE1
X-Google-Smtp-Source: AGHT+IHHhU+Nvb87eCaQ76wWE1qXHzhzlsCm3OuWWbw2sH1hLhYIGaE9ghQG7Vrg+ndmJ6yOx+FQnA==
X-Received: by 2002:ad4:524f:0:b0:69b:12a0:296f with SMTP id s15-20020ad4524f000000b0069b12a0296fmr10630701qvq.54.1713805168003;
        Mon, 22 Apr 2024 09:59:28 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id s16-20020a0cdc10000000b006a0426f2bdasm4405853qvk.57.2024.04.22.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:59:27 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:59:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, 
 asml.silence@gmail.com, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 Paul Durrant <paul@xen.org>, 
 xen-devel@lists.xenproject.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org
Message-ID: <6626976f4e91a_75392949e@willemb.c.googlers.com.notmuch>
In-Reply-To: <a62015541de49c0e2a8a0377a1d5d0a5aeb07016.1713369317.git.asml.silence@gmail.com>
References: <cover.1713369317.git.asml.silence@gmail.com>
 <a62015541de49c0e2a8a0377a1d5d0a5aeb07016.1713369317.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-next/net-next v2 1/4] net: extend ubuf_info
 callback to ops structure
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pavel Begunkov wrote:
> We'll need to associate additional callbacks with ubuf_info, introduce
> a structure holding ubuf_info callbacks. Apart from a more smarter
> io_uring notification management introduced in next patches, it can be
> used to generalise msg_zerocopy_put_abort() and also store
> ->sg_from_iter, which is currently passed in struct msghdr.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
