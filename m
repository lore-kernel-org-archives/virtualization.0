Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B11BF53
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791191; cv=none; b=k2cofytpR9dnzn8psCvTEZ7t9aSPuc9wajQjOH5ygxdoQEGRSNsnUdp+GnTKCDD8eZDYVF5BwHwqpzg3Zc9U8VWSkUCNo8eemBYxnXjc3XA8R1yXnSO9jalSHVT5YiB4IjRIxytYL8ff0Wzn6vVOGD9qO8MP0GlwuwEPb36yyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791191; c=relaxed/simple;
	bh=9bENYGurmFD+lyWhpF/h4fT2q9KBBedL30ubdo6nPzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+NwM6cuvZY11eWUhFygeKNPG5Du/h5655hBt5lqXJyDAkBmJ3ily8+kXelkM0lSS8YXj+KNNNwesbPTqO8YJsoVAxOr9CoTkvux5RqtixHQJE93DeNSAzxwLiwZjUkN3M5nqEwK0ip+C4+PvVtP2gmGzwBhlcsO3/o/Fk8myyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iO16g+DC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iO16g+DC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso34191a12.1
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715791188; x=1716395988; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bENYGurmFD+lyWhpF/h4fT2q9KBBedL30ubdo6nPzc=;
        b=iO16g+DC7mOhKpdGEHaOn11fxkT1pVeYo2JRApe9ZfDBdUzYESNkz0rOSXknvS3gDx
         1XjFJYhaWLLqCZEMjnVx/EsbDuxe4GH1joVyl1B29xxPVuc0QxNPvmABoEpX4oi+LOOB
         PG/JqvL3rfjrpfQRsYWWdIUKZIQmAJ7UQUY60nRFXY0b3QV92zq4Za/VcABSPYWcVOrv
         VctU32hG/AVDZsBKXnB9HX3rZlyx8ohid5LkPPJaAP8qD7gLKao08t9agMmeTqnF24do
         ej0g0X0u5UwHRyQmealy5rzPQx1TDaxijimxJ3YLbFxCOqUp+cdR1kAIuoWE5Y8CMhVH
         6SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791188; x=1716395988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bENYGurmFD+lyWhpF/h4fT2q9KBBedL30ubdo6nPzc=;
        b=JMwzx9QEFvzjOpqFetP3tl3eQOUYb2MFRB9525x/81V8m4Zgunp9jpYwir23czjDsA
         ycwRqusVXI9f73yS3qaQDgStlhvmIvJIUvAhtHhOrd4/G/oIp/lfqW4QOg+U/akVX3DD
         wfYE5UCFFpzHH3ARMDl8iQCPkb1zvswpmbeVjtxh6V+5H6+SPtMIW3JHaubb9XQUkg9B
         Fs8lLwMJYxk4mqvtNIVpkFdBabgLHP3QmSaDWXMjNkBHOoBDhiIQPc8tNUkVliTlCg/d
         Vx5SWbBja5axLoefWgnM9FSv+HqKDEP4qs3r/zguodFw99Pk8uVMrAoCdkoGoTFpVMmY
         mgtw==
X-Forwarded-Encrypted: i=1; AJvYcCXLEoXXvWNPL+vSCxSLRb0FnAhsWeLxlPEmnB4SZLOD8yxnMT2feK6pc+YKJ08XdaLfwF+ZF/ng6LKCrf8JvH0/J+GZKioJPrF3vIzMTf8=
X-Gm-Message-State: AOJu0Yxv0hsuM2qyfZwnNibOwS0DbY2+Wnkj7rqJ8QMjIiAOwMqyIZd6
	sNju867qoD0EZzooOq8qM6DZPiX2gGA9dDITGjtul3VNuc0Q4bGWuD9c+DbrUJLE/1Jst3AsC6/
	dzvO2TMnMAeyyYMNCUJ8FNFRYMsCWeC26j0mD
X-Google-Smtp-Source: AGHT+IEDnTHxBXJDLOhQK3N6fY2vO+8C2/vNtru0HF39N6eQumAGvn9Z4FrV0M/FJATLFj/wu3KVHCz/8jxBsqCnSBk=
X-Received: by 2002:a05:6402:222a:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-574ae571da7mr797614a12.3.1715791188198; Wed, 15 May 2024
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240515163125.569743-1-danielj@nvidia.com>
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 18:39:34 +0200
Message-ID: <CANn89iJjMcZ74eCWqBdTferLtZ1AwyMSiGBkdqMNFMV2t0AREw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, 
	Eric Dumazet <edumaset@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 6:32=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fh=
c8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
