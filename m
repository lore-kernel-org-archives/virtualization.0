Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF813FD9B
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125219; cv=none; b=HjQYwyaaBriEnZz2fDbpfc9ifVjs0GQU0zzu4E4mwzMSqjxRaM/rS+QQlCfAJ1zD+GKtHSAn7LKGMB1wtVE1Q5amtICldP2PSIP8QaVRp+ZMqMa7jrb+bGdlEsRudWp0c8zpyzY1R6mwXu8oktkINCjtELjomkV7ShBtfu1eR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125219; c=relaxed/simple;
	bh=qk1egQM2JNvc63+rRmeRd9v2nHB/bxA49QrzTy1fl4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvHmgiZlmTfhQqlWc6RoOFwrunER9/jlnKY153I0dazfkKuEYpqBgp9WUincBqxQvOp1nJeAzhsEZCQlVuP11N84s5iDqZuKYOGAnhcD0K/x6Denp2r7Vlnnz6y9iJm1IQT51Dex+fx5NWDBJBuIB9SZPsm/tUEYN9nTjH2maj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMdzfW1X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMdzfW1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714125216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SF7RTKa6t4C5+wP/KjjyLAdJPGCWt78sOV84cNp7JJI=;
	b=QMdzfW1X1wmdEUJ+1cifKRNM+HFUwIWdBJCa+SxGjgne1RHM7kSWhKvmAeVyn8Qy1zjE3c
	E6RopKiBV7P6aj1YB9M1aEcCek69Q74xG3Oqd44q+vgXiYZlhPiUomC4VZKSozodEuTInR
	0XU7zVjIBRLWFnXQhXOsIQzpgeWpGXw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-WkUxeK-cNUuwGcGqeHmotg-1; Fri, 26 Apr 2024 05:53:35 -0400
X-MC-Unique: WkUxeK-cNUuwGcGqeHmotg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349a35ab5a9so239426f8f.2
        for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 02:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714125213; x=1714730013;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdhA0L/FT5p9+GsCL/jeeC5DkMMMh3/RT01Rp/cFgsA=;
        b=aS3Lo6BXSA0Bi4nLeH1j+ZRuxj8GXWY7azr2vNhRoLMffYYAhQiMRILfvgYZmwPbjl
         13bq/Rtsb6seOhsyfPZVjXcYFet8U4lRiGP5XX/5jyp8GNw1AR59QjfgI5e9UHXA9CgO
         p+0yBvg0upTzRhEGzZRQ6pc0xmD7hVuzew9rKe+vn+16A3bhDgv4uAtsrnKM5jur72my
         Bs2J20TCokQwH5+rXP6ISCZPQEBifVbNbYYTfXAANt+dte+J1JVtr8K2DL5JxSTAFAtd
         U2SBmQYzo4sUSvCmBHaE+8akhlDhD4N+UqlXOGLiVLc2xU1/G4Hq4zV/uo338WWarwOF
         ftyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfzZeahzFqSe+cca1wQspmUnsyur78h6uXRA02Wo0+Mq9ba/47e7rPcn20oj9yQZKmKUfGFNmMNow1G/pIYBOQ9G4GARRE+dXwYr5Cmu8=
X-Gm-Message-State: AOJu0YzXUgdOyb1ddHjceBgHdPJv9TNJ3HVoBQl7slgVIr9EGkoW3Q+C
	P42GKrzK6YcPxnKUGGLAizi+PTS/A8CyGEkTmDdIq+2Vqf2WxzFTMxf+kCi0qKM4dHsL5D170B7
	IaNyT/TKkkiAC1j9QONVblkH+2NfHElOYC6yGeenBpGJNAZlx7WX9/3uxML3CNs5Q
X-Received: by 2002:a05:600c:35ca:b0:41b:7ac:f5e9 with SMTP id r10-20020a05600c35ca00b0041b07acf5e9mr1559310wmq.4.1714125213446;
        Fri, 26 Apr 2024 02:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvn2OAmfL1wURh4cdXLhzcLIEPzTZL3dr6s5TwPGmuCiNnV9dOu3etu6/6iUZzJFQYubU3kg==
X-Received: by 2002:a05:600c:35ca:b0:41b:7ac:f5e9 with SMTP id r10-20020a05600c35ca00b0041b07acf5e9mr1559295wmq.4.1714125213026;
        Fri, 26 Apr 2024 02:53:33 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d6950000000b003477d26736dsm21910405wrw.94.2024.04.26.02.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:53:32 -0700 (PDT)
Message-ID: <20148f24e2e35e711dc47878e19fb6bd118dce29.camel@redhat.com>
Subject: Re: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, 
	jasowang@redhat.com, mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jiri@nvidia.com
Date: Fri, 26 Apr 2024 11:53:31 +0200
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-04-23 at 06:57 +0300, Daniel Jurgens wrote:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control VQ
> was only used during device setup and user interaction. With the recent
> addition of dynamic interrupt moderation the control VQ may be used
> frequently during normal operation.
>=20
> This series removes the RNTL lock dependency by introducing a mutex
> to protect the control buffer and writing SGs to the control VQ.
>=20
> v5:
> =09- Changed cvq_lock to a mutex.
> =09- Changed dim_lock to mutex, because it's held taking
> =09  the cvq_lock.
> =09- Use spin/mutex_lock/unlock vs guard macros.
> v4:
> =09- Protect dim_enabled with same lock as well intr_coal.
> =09- Rename intr_coal_lock to dim_lock.
> =09- Remove some scoped_guard where the error path doesn't
> =09  have to be in the lock.
> v3:
> =09- Changed type of _offloads to __virtio16 to fix static
> =09  analysis warning.
> =09- Moved a misplaced hunk to the correct patch.
> v2:
> =09- New patch to only process the provided queue in
> =09  virtnet_dim_work
> =09- New patch to lock per queue rx coalescing structure.

I had only some minor comments, possibly overall worth another
iteration.

More importantly, this deserves an explicit ack from the virtio crew.
@Jason, @Michael: could you please have a look?

Thanks!

Paolo

