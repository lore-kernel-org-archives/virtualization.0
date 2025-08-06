Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A3220F3F
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515920; cv=none; b=qN3MneElJPGXrIKuHilb+gDTvpBp/OiAPkbfQIHn1HaS/BYEL5SzMqG2Zt9cYmYfhLqT7PnXsxnS64jG8l2LrbsqU8Zi3MK9a9LoWI4Ysjiu6+iJHf5rExqIH35nsuGK4qknGjGp69mwSsbAafVtCCftHesWcwqIjDezCXI6KC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515920; c=relaxed/simple;
	bh=/giIOQzx6K5sOID8U14r2OeiCF3tDg2h/q4DxXrWByo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqfR7L8hjK/zuVO8H8KzRGo/Hm2UOlZIQR6d/z0bnymX0e3u6LnJQllWtjEUnSlTuLF1TigdG1PrfF/EiHUFLDWprJHLV1qSCGi1ziuYSKiQVra2J+RrVcChgSikmH7aJkfSaKBeYeEvkmse9qtkCHnamedo9bLaFYl+YcVTJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAHz76Ig; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAHz76Ig"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bd050184bso553976b3a.2
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754515919; x=1755120719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4QNupblGALoqqGlWBz1ZKrdzPYMUg1WIWZepG7Tblc=;
        b=aAHz76IgfFrf2TR8socV1a5lFJkxO4dhMevwqatAI1FTX4lxjTGO3TWFQUNUSa6NMk
         F9jki0Zy8kkaoYmJLsVqlo2b3VFKSinXuTXucZ9JSrDQFtXflHFfr1IYg9iJCTF27290
         QNp6ftxPKIoCgLppOTP094Jd5oyAWtlYQeJTAGgqzF5zgb7zhZjhWhkWx2o1JxoOldsk
         ltnljNvHCUTWzZpOOD3kiWjd8yveUXTgVmnO7iFhCWTk30n9XuH5j/bopUl8Gxq6Jn4+
         AhQug89aBQL5S0kKkX9asi9LJAwVya9if8+pTi34lhCuLaMdt//0yvNIKYurS2lkTZCv
         9+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754515919; x=1755120719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4QNupblGALoqqGlWBz1ZKrdzPYMUg1WIWZepG7Tblc=;
        b=GgALF3uzfqAVWkkktKBYnQRXM8xWcfsyF5GN4aGvVhBgxf5loju1YBqguMHCb3vb0L
         zSMXheERqSwwtizVceHbPy4/W2clEy45TYH8qfAddOax8rFrvzoN6tSTVHkmuDKmHvuY
         /ow3NDKX+XCvv/H9g/+xYYOC0bkbwlRPB5BpeKWuwJPVNKlFcK/gDw1PBk05N8C/eC56
         zTJpkPBT2I8gHL90Cou5SGX5WzwbFxeRhAvvkTv4OuXCAePMrfh2ZHFvXGjjAwxcIX3z
         ueGD+dZp7MI4pGQgvgwtBPyZlwOI9fD2y0nMpc0zJWsmjUYQfwYcEGgMl9q0UcC2lz2h
         qHEA==
X-Forwarded-Encrypted: i=1; AJvYcCUhaTvUfkRsTmsQu8YUg+0x+5VwHDJeQY+C/QvK/SODCFc0n29P7uHP+rY8OiSV1OEED7cWdPwEj7eyoX2Xkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzegvwqaXBwOBc+NedYoIqjyXv0Lt6mrhsleK8xfT+J5dcH9uJU
	Dk3GHISjEp1Z318d66KtQQDZI3cnXRbmgO+SS6M19xyYlGvdSrTJ58ut
X-Gm-Gg: ASbGnctLFjmVp8QTaWd9yMnPc8PTcYojfjGSQpV/n/whmU3L/3I3wy/ZoVmCIYLwnIy
	YPFJjZ0cjAD/dkLQSmj900oM+vvuDrAb1b7AROspOC0Wr0zQ3VCcJnvpuIvsi7ikH20TCgeEarz
	MCL9oAZmSncwKnbuiCYc/1ZfsGwMjQyqsMwk6NKktGjPTJYsRKT8fyszYxHBwVypL9GQyY/Lq3C
	AxEhtMVtG9FhiWX2EHOlLUj+RKw2btiO+ZfvftaX9JE8ew1D0Azuqq1LrnRoFU3ZTWPuGN5s58N
	zBvypiWmIqi7U65RFv0gDsdTKTOJyPwe7/W9H1Pjq7I2AzkLvVPpg5f3TL4jGenBQ2gHC26HrpN
	0djyPUlMFDeBe6XDUracTLiI/uFBsJSOgy2/Q15CH
X-Google-Smtp-Source: AGHT+IGL6cjVW6DkJpKi2u1d7wydoW9gDvkjjcaUvStQY9bO2NaVBu2bNe7BKLheg0BV5EpYrTDCdg==
X-Received: by 2002:a05:6a20:7fa0:b0:232:b849:b906 with SMTP id adf61e73a8af0-240312526cfmr7106360637.11.1754515918621;
        Wed, 06 Aug 2025 14:31:58 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm9477788b3a.123.2025.08.06.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:31:58 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:31:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Message-ID: <aJPJy+s0yhvbJK08@devvm6216.cco0.facebook.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
 <aJJ/uWhqEu1TG1Kz@devvm6216.cco0.facebook.com>
 <20250806191348.GG61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806191348.GG61519@horms.kernel.org>

On Wed, Aug 06, 2025 at 08:13:48PM +0100, Simon Horman wrote:
> On Tue, Aug 05, 2025 at 03:03:37PM -0700, Bobby Eshleman wrote:
> > On Tue, Aug 05, 2025 at 02:49:08PM -0700, Bobby Eshleman wrote:

...

> 
> Ack. But net-next is currently closed for the merge-window.
> 
> So please don't post non-RFC patches for it until it reopens,
> around the 11th August.

Got it, thanks!
