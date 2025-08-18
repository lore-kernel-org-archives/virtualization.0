Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72C3218D4
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520763; cv=none; b=UcoehsmTty4ja2wqtTasPzOZUdpBIJjzwwG850NkXnyGMHXD68WlYVs6OLb3SuvHQPWlKWqreSaYCBUz1TsSPGlnal3+QzYfxeFcBgM4aoqznWoMErsUkdU9+ASGb0sc4DLo0KcHIWedpF325ksRkUezcFNE1v+IsBwJA+4i3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520763; c=relaxed/simple;
	bh=4S3lO57l8+iKrAxUl+Kvk3EmV6llV1LJafB7h3SlimI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRSvo0wWS0WQN0M6TCqlxiVMTBz27nxmPQvCfTMuU0bYxiXMgMls4NsUncc6UN8LYZKUJFglW7HzqnR1Jw0arTsvFoDkD61HfDgLJ38baWcbRTWzDuvfGBz47dqR724XVIIcsVQQnDiKIBpU1TC8IAnXDOp3j70wMlqkZ0aRDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cQvVPMxj; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cQvVPMxj"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b1099192b0so68021731cf.0
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755520760; x=1756125560; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4S3lO57l8+iKrAxUl+Kvk3EmV6llV1LJafB7h3SlimI=;
        b=cQvVPMxj8fIX/0YgJcWVCQDLzu1pBe3gaO6yrC4eM7Wng6ckT93g0KckSRi2yQVFtc
         32zxOERbVDOtoVM+NkCGI9GC9XOen28EV3T3uZTTE8YrsbIB65gDWw+9rqKrPazOFDoo
         b1qWbjxFTl3u4bdVMjSDa7LAHcF/NJRfp3zPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520760; x=1756125560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S3lO57l8+iKrAxUl+Kvk3EmV6llV1LJafB7h3SlimI=;
        b=LWmBrwx9kLqVRx0XvlxyGZTnzUfR4ukvegW6F5oYoLZ9add2fETNyINCHHSFGw/2DL
         LwWviHEi5ZIw4vI4rpEcen20rfR3/5kayIxPwb+HxyP7666iG7QlnkxNbGkrJfj4AVFF
         19IUZ8KQ8VvPad2H2ITUOWEypfvkAJMOkgs4cp+3CAI+V/lKnQhNWiscWsXSpXMRAJ3+
         8se11xQnn1achZNr9H3ZHhO/rjceBxbAUlyCIGbgNhO5RuzIGjYoqMxsVSEDs+OzDbDY
         hWs3qi8QU59Bvj0ak2tn1v1qTBr43lRhg3s2PIG3jqpWa1LvB94kmW5REDyvGOQVKNYH
         RzGw==
X-Forwarded-Encrypted: i=1; AJvYcCUk1PRRTbqgEo1T1jKHUsY7PKrpc/5SjWPTdXe5pSiJVuK3i2TB5eooPPHeIA+GyuVuJQrm9UJP3aZemFhoqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaSsIQMVUglNam2wSMOhua+pUuo9drH4Rk52oqGJGleNAOSGQP
	J9RHsTiU+ObJZFECMX5fn1JqI7B0ajAf5IOFvOYvssPaWnbOUyN6PuiXHx63akUpTBg/19SVyK+
	MSoFmhXkQGMjxcFQRhLfIybnG5eZb5D6NTvV39itqVQ==
X-Gm-Gg: ASbGnctX9OWSH7TiWdgU5/lJlI8yLycfc7/0P051YHd+dEGzgfZI6fL7zNm4b5eJ5Fu
	SPh3w9G1CiAEIhtNpQtBKDSDQd+39le/EWWkd+OfZsPjwnEGxFjsgGBu2y38gl+4H06QGMDxAgA
	i2sjHrqnEonclPG1hNMHox8F9zWKSLPBws8kknT/PrF7l67bTpbbILtMLOvtJBZlXje4xm51C7a
	ONvXmI51w==
X-Google-Smtp-Source: AGHT+IHTVfIp3tGvUZAFXAJoC8pdO0JicuolNHjGaNOBIUbD022NhuaCOz+3QiJZ9hTn1z+upsABGRkQm9kDTstUAig=
X-Received: by 2002:a05:622a:5984:b0:4b0:67c2:8fc4 with SMTP id
 d75a77b69052e-4b11e30abc0mr198664701cf.32.1755520760011; Mon, 18 Aug 2025
 05:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250703064738.2631-1-lirongqing@baidu.com>
In-Reply-To: <20250703064738.2631-1-lirongqing@baidu.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Aug 2025 14:39:09 +0200
X-Gm-Features: Ac12FXwdvgsTsqvq6Gd_fh853qWx2O0CMMumZ62t0U7IHrddSGRW6GK52NgJ_c4
Message-ID: <CAJfpegtAB+N5A+MAfw5uqqEXQaOC=rbvLRa_H0bFT8UOyaUp6w@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: fix the hash table using in virtio_fs_enqueue_req()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 08:48, lirongqing <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The original commit be2ff42c5d6e ("fuse: Use hash table to link
> processing request") converted fuse_pqueue->processing to a hash table,
> but virtio_fs_enqueue_req() was not updated to use it correctly.
> So use fuse_pqueue->processing as a hash table, this make the code
> more coherent

Applied, thanks.

Miklos
