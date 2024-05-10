Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EC56757
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315135; cv=none; b=N/oGEsDygaTlTJxCGw/1M1EQdwqs3/b88WPeMexuh9qcSFEHeNJ/IJ+MAMrjch4NXvVISyX2na418LH+GTPnwE/yHlPWbh80eDHsyYkpOD5vz/Y9lyacbsJ4v9HMUCouFTtq8n6k/3Dmlatume0LCdYy1JDW5qwTDw76jVWOjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315135; c=relaxed/simple;
	bh=XWUM+pYSFDwfKuG/KsJLm2Dw80p4Z8ax4UNSs8o+H6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMrKpzjKtN1BieP19D0ENX+bm5nYFl0ImtoIHpvbhJd2iKSQj2IEERlzCie0hibKqYK6L4XfMiFyk4oTsO/ClomTA9N08iL+qbkzYbAZ2tdZyvpHckJDKPu8wFFeiXn7Z8aIKki7VHY/fNqGrpEUvt22PW0mJfAQ65KyfCnMH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZujlSWRQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZujlSWRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715315132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWUM+pYSFDwfKuG/KsJLm2Dw80p4Z8ax4UNSs8o+H6Q=;
	b=ZujlSWRQdoc5dWaXpgYHH8fiFDsa4uhDYP98afI1wYLGcRnybx0cHGb12/SvsmRMlwvO1W
	TjeOruyaLSXj2l1+XD6h6J0iiemrETsJl3rElNbUP6oJVxPjnH0AAASqIaL28OnxDiS4QD
	8krEQzu0qgk/30UsqL+ndnDiy0bVibc=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-GXsYd5AbPOGTXv6tmk-Mqw-1; Fri, 10 May 2024 00:25:31 -0400
X-MC-Unique: GXsYd5AbPOGTXv6tmk-Mqw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4df1afdb123so760723e0c.1
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 21:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715315131; x=1715919931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWUM+pYSFDwfKuG/KsJLm2Dw80p4Z8ax4UNSs8o+H6Q=;
        b=GSwFXwUxkNnAGr5pmktwZjZmLe9KsqFJKNLNMfL1F00z/QI5Y/1Eb2bf0cy4Kyi1yo
         CLZVdTrQgwSayzFA9HoXUN3jdM5dQ5jkv6xUO6WursEyuesWuAVwOws3X0bXkRGFANMP
         dK9Mh62xRJKCX52Slcr1tiV197apW8kciQxCLiWxcC7V6A5RWcfMVkSHytCkf43RC5rJ
         MEn8z2OkXxE7Dvb1e5lSqgtuk6gpIVHkVrl09ES7tY69ar0naOKrAhduxxZUJqH3bZ3Q
         mW7Lj6VozoDRrZuxLJNzH6MN45HncW2uiU3MYoKo9OJPIm0qaR0JtrAaHgCbDw44lXYv
         riug==
X-Forwarded-Encrypted: i=1; AJvYcCX4BhCdgcPvqkLJsp2e1/xynGRyRy9mu1H7figlwEcFn80tCCixRzJ28lk05F/DtV0pXizNYqosC7SZFlRt+ZOlQeKnWFXZbljKZIc9cqg=
X-Gm-Message-State: AOJu0YwO+lmpPSyTPHY9AGdNfEAsRpjYdOsNXmMWEKaJhxJ3ShuPtzrS
	CV633Y//Md10lGOyHX/iG6Xay61kGQKLl1dApMCDXIS8Fg5bqmoAWd8YhUBcF9q/f7Hpd2cRgkq
	bO8KODO3ytFcm/HprmTdknOiakoVmalyo5d/VFbI4tslvj6mPBJqtwDLArEyCYe96SnIQXx/MuV
	mQzjbJ+gt09JLPgKadoMcBfYGFNT80/pfw8KdOXJE=
X-Received: by 2002:a05:6102:a4c:b0:47b:dc5d:6364 with SMTP id ada2fe7eead31-48077de5a9bmr1809876137.8.1715315131081;
        Thu, 09 May 2024 21:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJumCQ/csNtva7IMpE3rHI4bc8sr1ELddIbXcKw1oYHC2tohwrZs0y/draKO24Zn7Gtug1SyHs9mfVpO6vIzs=
X-Received: by 2002:a05:6102:a4c:b0:47b:dc5d:6364 with SMTP id
 ada2fe7eead31-48077de5a9bmr1809861137.8.1715315130787; Thu, 09 May 2024
 21:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us>
In-Reply-To: <20240509114615.317450-1-jiri@resnulli.us>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 May 2024 12:25:17 +0800
Message-ID: <CACGkMEuak3=DobCgK=069sogJxqU2yFgrtNmAQCKQg1FLONqmg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:46=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add support for Byte Queue Limits (BQL).
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Does this work for non tx NAPI mode (it seems not obvious to me)?

Thanks

