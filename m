Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3D26C385
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767766380; cv=none; b=NGP8CNRhLv7SW+FINWqjzTpb7zCeiO/r8VDaH6tNKFTu/Fg9kD2AGS7h0PjbBiYQgngiWOM+Uko8SJm3IV8K5BXNiRExB0axOfQnYb20pjxQFfLAXNxLQqMa4yuusIYrkVEIOOjfLwBfpXsWJ3d2s6ncai/6jr/GpXe+yzsZ4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767766380; c=relaxed/simple;
	bh=D3BXtcumwJvvq9eXw6PUSHKum6X81vvHyYQBCXThgmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+x24TAt0CcV4CPazpfD7+Ov2FzehE4HoHPGHAj1aabG2YfkOY8G2GvMhqu7NoSUjHtO5IO8Xes1kTjiz8ilYJ+0eCz+4xsgkqV9gU1Hx+5Pm76Gl6LJWuWCU1Wl4DbNNJzJXSXw7JxJmZLqUwxsbvjH4SciwuJ5xJkMCUxXddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npTqPnu5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npTqPnu5"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7277324204so273079566b.0
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767766377; x=1768371177; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3BXtcumwJvvq9eXw6PUSHKum6X81vvHyYQBCXThgmk=;
        b=npTqPnu5mgXxQ8ZliHk5iu1tu0JLgVYhDd8TZVYHAQw2W/AcSlEktkmEC5QeQvTe6I
         X8G6EnDY5YhsGhaK8aF3ckIwEK+K6b62lJLOkJ75rdxloSOak+mOcdEmV2B52+kZJtVo
         oUfoCmP+6A+EqINaahdwhoyyn+vI9/vKeRBZlxCofupZTpSOWnuamur2XSTsXqaVortv
         D/b8OY5q/jvMhqFhEhmxZjisSAynh9rTUXOheb1Z35ot88pkXpyELWQ66TOGGOmazWru
         A4towEbMPVURLLCd3/6t0aTGTxiREISs0hO/VqJEHjRIh6NcKIxVdGZwQ0Ly17aTTnUU
         CF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767766377; x=1768371177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3BXtcumwJvvq9eXw6PUSHKum6X81vvHyYQBCXThgmk=;
        b=Ojdzu2uAMrga396jgLXVVm4Zu/5FgIsRGBPzexj8uyY1BomuZbJ0GHhcdryaWYCYzS
         7ZPtfKtCBEga+e0nN8PinV2V0ZlGSp6Fk6XJamfODm+kcbBm3ryhVnDSyBlgKsCUcJVf
         KD0RVEpgjD0GFItQvh0uOX+qqMzdtqCjiadYQN8AMGsiTLbCO1PPqjhwK2bkiONHk15f
         Q4bskoweHblJJTv2TIWUNQ09zzAg4AocQRLwU31yvir2BOxsyGfbhRGg/vLCUcK6np8N
         +W/ORG72LeOd2z3AuJGbbMZJMns1ZYhdjHQ+PYjKLJaKckvVVc/Jq+fvvBvTZDQeq+/I
         +Apg==
X-Forwarded-Encrypted: i=1; AJvYcCX1rQKVZffeDhp1aKAVb/UazRzt5i4I/I+6SF8wxRIF5m5X5fzJiYIoAYWwDq2xIUYBtZLDkkATObbftd9zVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuZVOC8YGobBHJ4pAXX8Oh+m6s3vcj6+NM9v2PTLpjJkCIi5Ib
	zM0sAK7ZHqAE607mVjMDlXXUjqPKusw+u5FAZwDC+IfUcH3Ic1YfzPIeYGJEQEW8fCN3R75KwWa
	olmfmngBx5wsiHPm7kFT35V4o/h7aAhU=
X-Gm-Gg: AY/fxX5e0Dgnn0AFcegUHHfVWGgavqlawpfsacyyu59RJDaQ7BfjnfY/S/gqV21MHgS
	YgBNWkvBx4gDAfFBYx7jQAp3JpiHHFOCvNrFbzqytMsg9VSWI3F11RxXfRh7bxwbUx5yDPjFvGa
	JlvKSZhyhgw5Da5cdV77FykLEYpw9j+NYRn6aJqiT9auZ/3XeZYDW+KzZgmwJ8SCCXqm6uRyuze
	7PsyAKmXIHHotEEbfSaoBkXHKfLrEMYbPl4ZDckuopizWFgp1AtIvROS7FCgibow9Vv/RVR9MAi
	ox5cGdijbXj+IQdCytZ4h2dmIxU=
X-Google-Smtp-Source: AGHT+IGEdXauSnucruM/n3OjiiAB139nO+cqvugOWDgfSThFPqTn7sY0WVAynZZkYDoxwk9mYMwoDO7ZCh7XOtdZ4vc=
X-Received: by 2002:a17:907:3f9b:b0:b73:54d8:7bc8 with SMTP id
 a640c23a62f3a-b84454481e0mr132675166b.59.1767766376964; Tue, 06 Jan 2026
 22:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
 <20260102180530.1559514-3-viswanathiyyappan@gmail.com> <1767698557.9158366-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1767698557.9158366-1-xuanzhuo@linux.alibaba.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 7 Jan 2026 11:42:45 +0530
X-Gm-Features: AQt7F2pNx_sz0Kz4voUNMq2vLTYeuDB9vTdIYRox5y4oe9K2F8DBFcuRCXwgv2c
Message-ID: <CAPrAcgOp6K_udUQUZhb+JhJqS26M3YjBzHDdS=i1_9iXy+3k7A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/2] virtio-net: Implement ndo_write_rx_mode callback
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	eperezma@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

This refactor has the secondary benefit of stopping set rx_mode
requests from building up as only the most recent request (before the
work has gotten a chance to run) will be confirmed/executed. Does this
sound good enough to justify the refactor for drivers which do the I/O
under a driver specific spin lock?

On Tue, 6 Jan 2026 at 16:53, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> If this is a common requirement, it would be better to provide more examples of
> driver modifications.
>
> Thanks.

I am planning on modifying these drivers which I can test with
QEMU/vng. Does this list sound good?

e1000
8139cp

(I will do these if the secondary benefit sounds useful)

vmxnet3
pcnet32
