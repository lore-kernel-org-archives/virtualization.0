Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2041CB4D
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352924; cv=none; b=hC+4WrpxtSXRmXb5NQQaRyuxPosm9JiSzQiX05d5Z0YNAJ5TAXgshXTTcMMGjOsVgCOLvUADbeKlSAyT5HmvgPIl/vIMczyNcogxMIT9ltTxML3lgvJmbonsHWZnkRMGeVUl/HG3xuVNNOu7mbD/HTNnp9Wc3YONFL+65KSdJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352924; c=relaxed/simple;
	bh=z8+NKlZVaJg0D1viDndIi21e6QYlTGrfLeaOwjDv2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZ/LHzvFxFGKcQ4sYqziyh8wYaIZaRq/SRjiWybogge2bSZVd3bvrr4M+4rzigzG6MfAmY2+lMvx5kQiE6RWJBrCRJ5fFcPC2LMiZSNPp/mqbaouhgnyWBDlylcGIhLaTwyWYDRpM9Al+OCZlcqliTda1cr4q2K+gwUMdfTI2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIeT7heV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIeT7heV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so9604895e9.3
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792352920; x=1792957720; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nT4NId0U2jiAqaCcS2HDGNFvu8HoNbnVXS9R3IhMNjk=;
        b=lIeT7heVUaqhG3oNlAAP1YLE7mJwOenICJxE8R3rZzE+Cz2UcUyvlUO/9EdoccODcJ
         RI4iKcaDm2zb2XFD6nqnmJJy1LZOnO0HrOrdnnt+vxrL1txPrhO17TYWKRdScr510aXP
         T2l2EenL8BeGNHpKJaOKULRekdUFnzzBg/gjUav9P0SUayFl8Z1z2IcZFmbuOk6rTOTs
         mfwLYSEuNJ0yNhBRx+G95WWqUcsGG3LRTRCBvLeed5YRSk+pr7njh86w1wYHAeKtsffX
         Inlev9ghXbUX/H+ZpDEEJxaLo8A5ayAsGVPFNdBTj0DfHAlSBUEWP0dC86iObLTsp2Zb
         gsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792352920; x=1792957720;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT4NId0U2jiAqaCcS2HDGNFvu8HoNbnVXS9R3IhMNjk=;
        b=2wX7sEqqNkWQhN8oe6KvyEeNpcC37I3j+vC0HuUWYeD8cA/9ofSpo9mYZiWBtpTBhW
         KTpGFfpXFJOZ2DxN5KDg6ko2fl/xWkAY2gsiYG67hItFUm40PNR4XCCCkgrKpdvPvdpV
         n1z3ZMWcT4rpqxgeamskxLwOToKGd1e+i5Q821eNmOiSTfaRhai+vLqs9AuY6tJ1cmZ9
         wfzTr4IdWHVUAKeT8TanC5cu6WlvYA3pSUF1U6rYqAErHmSM6tB9xvZlqmqcfjLUqC0J
         EnGpbbYRX2RCXFABRt0k0ZXNd/H9dEYAD01K/dTcH6kXTZPXs4Po/QjQOZDdUkEk9PNv
         s03w==
X-Forwarded-Encrypted: i=1; AKwUvBxHYMN+lIayWSnWznA3Rwunyw+GfyP6YueiuHE8hWGBfat37zv4++cwLvboNgkm9DHzsd3tnr0ui3QrFaovig==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8pybm2AxPx8Yi2PTosmXJcfBIM9qfIpt0BN+9Sj4xag+ROpC6
	s04uScHpNDXcSLHYmmFpm7GloL4FB10i9Xd9tKFuccOzcPugS2pFgK1y
X-Gm-Gg: AYBFou1diR+Fhlj6nukUXN3kdOlIyvZMmx8mo71sRcsRWPEr79DyN65FSe43CeTAOxl
	Ck9e3O5CtJ4z/Ryrmjvvqn4VnvqLlZ9jEhSowVUV5jBJUX+BakH0zFtczKPOsWVupVkI2yiQ7O2
	yDduEdbTKVUXN2y6XdBxnhv7d9MCHtd9KByzu6DwE5DKk4s4cBve+6NHafr4+yzFmyESlZgxz/o
	s9/UPaldr303FrBSlXsAEfL6w+GTlb24vvQ9xRNw5/QDhokCGQnr8+TxKDYWWCUkRCj4dj1iUx8
	ONrisGarmilkLT7Aoa7N51bB1ThrsS/F0VXbFGJxm00HEbSr1qSb3B2tq2N+NOIvyY4cDQKcO4q
	BAFOckO/RaLQ6Va/qSMAY2rM/HaxCAD58O94LOt5i/syT3P49fkxUiZLpJb9bhmOpVJmf8AZ5AS
	AbzX7UiblucB0RIFw+THe4/C0vQeB9E2SBOp/hEV0gokQrLZ6YtFaM+L7+x1bL7hhOBaWQaPdbX
	v+Octloi8SzhytWRTzu+kq+2z4b17ObIyo=
X-Received: by 2002:a05:600d:8488:20b0:4a1:e3e2:93e0 with SMTP id 5b1f17b1804b1-4a1e3e2967dmr30105055e9.32.1792352920294;
        Sun, 18 Oct 2026 12:48:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50d1bcsm18886835f8f.54.2026.10.18.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:48:39 -0700 (PDT)
Date: Sun, 18 Oct 2026 20:48:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, eperezma@redhat.com, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018204838.4080b238@pumpkin>
In-Reply-To: <20261018152358-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
	<20261018152358-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 15:24:41 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > against the 7.2.10 source tree. I have reproduced the leak on an
> > unmodified 7.2.10 kernel.  
> 
> 
> This should fix it I think? Can you confirm pls?
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vringh.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..4b097170bd36 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
>  		return ret;
>  
>  	if (vrh->use_va) {
> -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +		if (!access_ok(uaddr, sizeof(*p)))
> +			return -EFAULT;
> +		ret = __get_user(tmp, uaddr);

Can't that be a normal get_user() call?

David

>  		if (ret)
>  			return ret;
>  	} else {
> @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
>  	tmp = cpu_to_vringh16(vrh, val);
>  
>  	if (vrh->use_va) {
> -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +		if (!access_ok(uaddr, sizeof(*p)))
> +			return -EFAULT;
> +		ret = __put_user(tmp, uaddr);
>  		if (ret)
>  			return ret;
>  	} else {
> 
> 

