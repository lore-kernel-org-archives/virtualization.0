Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E819A2B8
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631303; cv=none; b=GL014HOAhPrzyMEAuItIDFrM+ETHAZ6vcnuE4P+VYr1WwUjnh/ibkFyvWehg/ftUPQeL60H1SYN42BCyaPQ7UqStlcyoArMZ8MknSsZA86si0EPCTw5xWe90cZqOBuXlm6OqDgCdK+jpphoWqD6jAIXrmu6StF70qYA1aRFpCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631303; c=relaxed/simple;
	bh=6OKT3WqegH1QtD1wyuXce6fGlAETjVHusGyC+Pzsr8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwpMrPsG91D9iiRoUeDz3mKxRnfvRBLpiL4Ex+RmrH9Q1U/h8DKXK0qGLNgcef78Hf3YH1GXUv1XAaKVd3ltsyWXtz634yLns9HY/0POKnMpBKWNS9YGpsZEZf5ccDUN1raPQ8edYjE9hTi5Se7YqT2IJUPuJ4nBeMTk6u0VSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rhzzqe/R; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rhzzqe/R"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-42121d27861so34063705e9.0
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718631300; x=1719236100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXOhkuogz//QmdU93D8xI7eVOtiFpWIJJnt6ZBb+35s=;
        b=rhzzqe/RFoWbq2hQRHu3DgzEcGkOzf9MPX5SESUYU4RTE/POdTk55IuLQEq1/nz1L0
         55dFR7Hrr0OsL0VBdoZoJ46LJ6wHkwqBO5sRMJn2cw+b+fWPpcYfFXOWGFTwwzw0OUZb
         ss4GNP8q4JbIQEwM0TMACTCQ7laWZqwEvnCcrJWMJNc/vvkBAU0EDeodS8xbGRq6iLEj
         FN2B+1IDoLpaB4PeZeF1ixrw5T/oVQqLVs7+kLZFUtva4mYPfr/cb6+tKrzH/3iQ62cT
         7+TWQO51a/PlAeVFtmVhilvvDbd7lUGbKto1DK9BmFR3UKinLmC6Uz8HutfKRtFMoVSN
         t8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631300; x=1719236100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXOhkuogz//QmdU93D8xI7eVOtiFpWIJJnt6ZBb+35s=;
        b=Y0PremGd5Yy/yOWqHZ54rMYKBYHo93U1x5+8YKrUjSUdu4JCJH67u1r8f9WoOwedLb
         ebPi+whkR+NTeFIXwWq2aLjGGrckicMGReawBN8lFTSrSy2bGCAoWnTVfk6QSNNZgJZx
         QA43+rJuvNyU151vEHWTh06CJHiFA6N8NjyEoJahFENXEeMdeGkdx2p/UjsIoCC/Ghg/
         +bxo0jA02NuUzekzpYLiwCTtHbFtzEORge8d9ZX52YiOA7Hd0+kgLe4gVZDIiIZQH7x7
         X+lBJ1g3xTYybK+96SCpfJNOY8AlI/Umj2nkI09UQ2I6QmOlfs8VjcOsB5tR51vthxRD
         iCEg==
X-Forwarded-Encrypted: i=1; AJvYcCXHl2+UxmLd6IPZlJ29+0aKpJReZLwWobho8jmfmfql2czwp+N9YrmmugTR1bjAYNYmCGUkypPOuyxQ5KAoVoxjMK2Hqxqeezz9ZhG36vY=
X-Gm-Message-State: AOJu0YwrTV3L0gt1sd1+rl+1UwwiGBBzss/X+2a/r3/pv+hF66HdHaIx
	K1kujBDjgqo9MUjQxqin8tyzYZe+zgSBAhKQRc4boPindMMqtud/JOtM87QzHBI=
X-Google-Smtp-Source: AGHT+IG6C1PBpqaaWvWNAxk7Rv1Qc1N+l7EJFwfh6/c3prESpScO1tKh4vNfH7nfLGf3e2rMTio8eQ==
X-Received: by 2002:a05:600c:4448:b0:421:819c:5d6b with SMTP id 5b1f17b1804b1-423048262c3mr72180135e9.23.1718631299909;
        Mon, 17 Jun 2024 06:34:59 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602f620sm158614925e9.19.2024.06.17.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:34:59 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:34:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Thomas Huth <thuth@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
Message-ID: <ZnA7f5wW0VXQGPQw@nanopsycho.orion>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617131524.63662-2-hengqi@linux.alibaba.com>

Mon, Jun 17, 2024 at 03:15:23PM CEST, hengqi@linux.alibaba.com wrote:
>In virtio spec 0.95, VIRTIO_NET_F_GUEST_CSUM was designed to handle
>partially checksummed packets, and the validation of fully checksummed
>packets by the device is independent of VIRTIO_NET_F_GUEST_CSUM
>negotiation. However, the specification erroneously stated:
>
>  "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set flags
>   to zero and SHOULD supply a fully checksummed packet to the driver."
>
>This statement is inaccurate because even without VIRTIO_NET_F_GUEST_CSUM
>negotiation, the device can still set the VIRTIO_NET_HDR_F_DATA_VALID flag.
>Essentially, the device can facilitate the validation of these packets'
>checksums - a process known as RX checksum offloading - removing the need
>for the driver to do so.
>
>This scenario is currently not implemented in the driver and requires
>correction. The necessary specification correction[1] has been made and
>approved in the virtio TC vote.
>[1] https://lists.oasis-open.org/archives/virtio-comment/202401/msg00011.html
>
>Fixes: 4f49129be6fa ("virtio-net: Set RXCSUM feature if GUEST_CSUM is available")
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
