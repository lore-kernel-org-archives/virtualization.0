Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4327291D
	for <virtualization@lists.linux.dev>; Fri,  1 Mar 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300550; cv=none; b=uSyFZOvtNRYqgxQ7m0bVN9KNpCQLvZrjd/DqCPzqjzk9FU+T/wJQRn9N2a41/9FVIr8jAt1O8aM9C5V0aSRbBG9ht/1ktBcTTSWWRhEafVaTHTVzpWO9iepy6cAvWkAdFnAa9H8842zU7stKdJxyN5oQsEwwpQdNLQc3RvuhMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300550; c=relaxed/simple;
	bh=uvKCAXMT8sNauk5+VTMaEUp0n/5PMKoLqFnsKI5EKpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gsht2vjimFBedHbHOlxewh57oWsj1+r91OPyZqJ5clKLxwCBTEjJDeU9snmlhgzdVoSAhT9QBJkQEzl8uINmD08OpoqrL9iKdZmlGbghJ6b0cYwhOBkbw+zLJglN8jNdFLpIS2qEgfDPj+f6o6XquP8ouzhgWncCFGyCKI6+O6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OyEcqU+i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OyEcqU+i"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a443d2b78caso290855966b.1
        for <virtualization@lists.linux.dev>; Fri, 01 Mar 2024 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709300546; x=1709905346; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvKCAXMT8sNauk5+VTMaEUp0n/5PMKoLqFnsKI5EKpM=;
        b=OyEcqU+iIBXoWx18HrOVmDPiUXTGyQuQAQYVlICGHIieHcDjBsZSFo/DlQlghpCihu
         7TI4KjnCgp39118Z9Y5V2z6ismnie/a4V1iUxIKQ2L19u+6D6wPE7ucAaxUhQR/DTtS/
         9q4YaNeppiJrYKGCvNhG5jBE1KDkevkIc9DnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300546; x=1709905346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvKCAXMT8sNauk5+VTMaEUp0n/5PMKoLqFnsKI5EKpM=;
        b=MVzF0ROgVztPaY2vvJ7I+cXcn5RvELOofLpej6jfq1/od1lSCDGNcmTFdooGmK0ZdO
         NdA8j0ZNBB3Y/vISoxemrlYySfYIf2ddmbkWwFh9ZwCFZ2+5Uize8hkK/k2Ei1hE4WUd
         ro8vxlsrzwajRKyPyjofrqw5XYbu7LYSqOvopC+hatxggDN4q5iwYbW1eahrpmVIxPzH
         gYywtWKEb0LaMr65gweddmW0pDkf2JBMjag+xF8TnpxVDYOaIYboFkYZC5+ERpkRnTG9
         wVwsV9zjMXpXg6eUORt9vV48ZyjC4UQBcz9Y4pPXXL1m539XV/q8XG034qnOaKvHJaQo
         mYKg==
X-Forwarded-Encrypted: i=1; AJvYcCVlxHxGgB33tUffVgKVOmWdX3GPxA4UziZOyl1CCYy9vwlMo+IohKmQ+Pw64Oik5mmNj+GztNl4aI2pNQGEjrPJWVVBGD8ohOjnuZ85VCA=
X-Gm-Message-State: AOJu0YzbHBe2dBoAo/mWduOBTWeRWb8PL0xYBTIo3jKBrw4TRhlzPSSq
	37oVQ52fuLKwidnXwlTlnX8vUYqk5JG+wPwXDcHVEyZ8sQWRABmg/YeZvKzFXBYjuvXGvWbmbvC
	nnCDgjoyWiLw2e0RMNesvVFYtocv+76f1JkelEA==
X-Google-Smtp-Source: AGHT+IFKyHCJjugXaVuo0TxhU2eqFIxuWNNPqdDj2p82dGOLUVGFGenBabw1NVs94YGP7ZFDeiyjxuD5xd7aKXazFdw=
X-Received: by 2002:a17:906:b347:b0:a43:f170:aa44 with SMTP id
 cd7-20020a170906b34700b00a43f170aa44mr1504212ejb.47.1709300546044; Fri, 01
 Mar 2024 05:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240228144126.2864064-1-houtao@huaweicloud.com> <20240228144126.2864064-2-houtao@huaweicloud.com>
In-Reply-To: <20240228144126.2864064-2-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Mar 2024 14:42:14 +0100
Message-ID: <CAJfpegtMhkKG-Hk5vQ5gi6bSqwb=eMG9_TzcW7b08AtXBmnQXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: limit the length of ITER_KVEC dio by max_pages
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:40, Hou Tao <houtao@huaweicloud.com> wrote:

> So instead of limiting both the values of max_read and max_write in
> kernel, capping the maximal length of kvec iter IO by using max_pages in
> fuse_direct_io() just like it does for ubuf/iovec iter IO. Now the max
> value for max_pages is 256, so on host with 4KB page size, the maximal
> size passed to kmalloc() in copy_args_to_argbuf() is about 1MB+40B. The
> allocation of 2MB of physically contiguous memory will still incur
> significant stress on the memory subsystem, but the warning is fixed.
> Additionally, the requirement for huge physically contiguous memory will
> be removed in the following patch.

So the issue will be fixed properly by following patches?

In that case this patch could be omitted, right?

Thanks,
Miklos
