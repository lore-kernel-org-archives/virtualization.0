Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6A15383B
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805266; cv=none; b=nGY7uI2Y7fNLEtI9eQVajKNcPSX6W1F2Fy4xtE+q3nJmCr7iQQ5jwMkKECOzFc/WPt5EAcm5QzmB52glpfU69iD4Es3/lhQrJNxIrY9ymh0bTNTLv2OsVBU/grFFlMPTwzXAR46rROZ07uXhYFnfTJOBTcQdV0gUSRgyT/lIj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805266; c=relaxed/simple;
	bh=unovcmM/F2dhfHKF77+gvQUVhbqPaiyizesMAyFjp2s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GyhaB70undLyC9Ispob06pKVHpQ+voV9YXDOLf4P2aFaJFLA5eIKjqYiK6xY0eC5Clyg90kuW+ym7OTLJdtKLxWaa0ojHmLwOI00cSt7Jy78P9O6H4a1rxip35IeDG/GmPcTrQn/T6w4x4azD7sC3rUch2Dp+1SsgwtarPezvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br4lIDxR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br4lIDxR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f049fefd5so307845385a.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713805264; x=1714410064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qanenk0rOwdnK1RUZMGAjBSg7F/9gtEp8HpQbOgYLJw=;
        b=br4lIDxRTpjFYGQ38MM6gA8UgYGD27oDPdaX/yijUZhYiUKyxj5grQPQZ/2zMG2Is1
         QcfLEVR7d5YmfJQWZf60OrCMKmG3+14gxnut/qAtxszuRBABTS5IhOaoZyEOpcXwMGkc
         beM7iYp6Jfb1J3cYPAtdnQeFnzcexBMe6y95pYmqOph1eDaUeSCFer7y1djdSu2BcuEr
         A7W3Xni9fN6PPJSdYAZomS46BzjfekjeQvG3OesX068U74odpn5UvXi0dmM+M1CBnGus
         AXNaSyHOaPmz89Y43SW1s8vOiyZIF1HDdfjQwOTlHNJ3WYVidTG518BLpIkckhAl0IiE
         /S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805264; x=1714410064;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qanenk0rOwdnK1RUZMGAjBSg7F/9gtEp8HpQbOgYLJw=;
        b=bm4Dq4WgqL/O/3f3/3Tu/UfVHTfTJpkyGuUIOJO+TZ+0nSG/SMkxHysp8GV/K14jG9
         kP5+fNYuJ1FLgvjALtQ4ug8j+L6CUbdSCiy5pWq3QrpSCWJy7EorXXWcxPJTTOsQAumf
         JT7nFFhoFFXW9Pbwqs0TsOOrr3MjOh7nA8bpX+aXAIQuiD+SWmnC0PkzlpG7RClTSaI5
         nC+8xytRL7Zzefcnj5TR3nuQIORDRD/6vAdzCc4cCkyEs/WKc6jKcqYSdSpMRWR9T66P
         ZtrcIR2zbOYjRnm6zLbTyAKexfvaHBmr7JLPAdAM4YOBCGTI6vz2Zh1zXAjjHDb9tU0J
         kNqg==
X-Forwarded-Encrypted: i=1; AJvYcCUWWiKKXISezFjP4/kRnnhQfSEfueD1AeH5JFD9xVN02ToNb34e0oWRk21RVCdG58hJMza5fvNBbcnbgkqKbn1ujbMFrsRZ0/iRYql3Vng=
X-Gm-Message-State: AOJu0YxffiJOtMSB4kINqxLeztCKVYTGXtTNQyvVGbgJHQbGKVbQ7ctx
	kYlLpqK4DzzEn0l284Pont1L1gi8HEHIhCLam+XRFWIbrnrOO6FV
X-Google-Smtp-Source: AGHT+IFCpIo7/SLWyIv8N6OtBqSGdbVdoaFQ0NI9Dz45ssmy5gm1tR1kWrL5XUahomCwRIDa2Lt9fA==
X-Received: by 2002:a05:620a:4ac5:b0:78d:66b6:a786 with SMTP id sq5-20020a05620a4ac500b0078d66b6a786mr12207280qkn.35.1713805263653;
        Mon, 22 Apr 2024 10:01:03 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a0a4c00b0078d6120fad0sm4468257qka.108.2024.04.22.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:01:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 13:01:03 -0400
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
Message-ID: <662697cf21177_753929488@willemb.c.googlers.com.notmuch>
In-Reply-To: <b7918aadffeb787c84c9e72e34c729dc04f3a45d.1713369317.git.asml.silence@gmail.com>
References: <cover.1713369317.git.asml.silence@gmail.com>
 <b7918aadffeb787c84c9e72e34c729dc04f3a45d.1713369317.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-next/net-next v2 2/4] net: add callback for
 setting a ubuf_info to skb
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
> At the moment an skb can only have one ubuf_info associated with it,
> which might be a performance problem for zerocopy sends in cases like
> TCP via io_uring. Add a callback for assigning ubuf_info to skb, this
> way we will implement smarter assignment later like linking ubuf_info
> together.
> 
> Note, it's an optional callback, which should be compatible with
> skb_zcopy_set(), that's because the net stack might potentially decide
> to clone an skb and take another reference to ubuf_info whenever it
> wishes. Also, a correct implementation should always be able to bind to
> an skb without prior ubuf_info, otherwise we could end up in a situation
> when the send would not be able to progress.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
