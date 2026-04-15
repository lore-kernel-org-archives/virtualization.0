Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D083DE433
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267670; cv=none; b=ly64npENSMLUp4M0WUs20j1d/ZfVo0VBaiecIxKP8hiOc/rfqLE04G1Vp2umYaW70wuHe+cUFcETh7xLWccV2ctB6bttIcWuljHQAl8T6yphMUzMn9+YWt0vBYxDO7g7mPE3zALktr0wQ4SVEQg8emj5BdH2hIor9p3RX3SKU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267670; c=relaxed/simple;
	bh=2SsUYUfpJ6Cn7ENP9SVUB703hjWJHv3onCi+Vq1hxh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=a1Kj6MRMfD11ol0a1Bt2lMjqF918mPIqagHw9TaPddx2YXIpF6iT/we9ie15a+y6EwXCBtkxyfzeiITv1D9MCNiGb0qoJ1+U/ESp7o6rTlpjjFt4euqpXEKXLfdZLMlq1/ltSy9ZUIVSaCRbMOpuVpYc2BeYLwwr0vpdg4hLRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8Zq7DjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8Zq7DjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776267666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
	b=f8Zq7DjOmYTXBequ3/tmRfUCcwbMgHfny8aAjTmbZhXSNS8AEpGFYjEMzPw3e0Ni32ohtM
	eayP9CnLIwIIJh238MyNHv8+0nqqvihXJp/qDsQjZLvsVIm2kS3x6OlkG/mZwBvjMHO9Lb
	7D0FZgT4rrnPzmspTxAE8od9nJksiVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-qAhtCaawNkioiKGchYIBzw-1; Wed, 15 Apr 2026 11:41:04 -0400
X-MC-Unique: qAhtCaawNkioiKGchYIBzw-1
X-Mimecast-MFC-AGG-ID: qAhtCaawNkioiKGchYIBzw_1776267664
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d4ac6ff9so40117585e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267663; x=1776872463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow5K8hzTuD9W/wj2bq1mSm/2juaMM9qh5FYIv6eXqRM=;
        b=kym3H3wEhGRcbVRKI6vwE7tRYt5EmXyaVJf8ogBQJFf3qrEoBq1b9YkkrZA2tF5Cb6
         CR+AYCz80U5mCfA98qBFt+J3ju4QggHK9FZIQGoz5jzzLXifG3DAdrO9qTzwO0FzC6mx
         QVT7a9tBtViR+B2DYgivd6UKTrv6+eybeMlVlhyXqxzwEJv382ijbguP/Y+NFe4133GO
         ByM1J3qI5hIvDa75LO1DyH3vihFIDMg8l4BZpTpQ41HE6MxEAOcqkQaWbObmjkqZignQ
         ilx4flry4wRNkIMpdRK2jKPdRP1sW8sobuUNZhHBCVOmKjM87MljFS8NTBKR3GVXqmpH
         j9Dw==
X-Forwarded-Encrypted: i=1; AFNElJ8lF8iqRmi9PDRqrubixzE2rtZvnHhMvTrAHARJuGT7UA+Z/sz1tJ/4kEIBOFTtF216vMkn7G4zIW3/JWR7EQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCNFqVpdfVvwkSJ94aGq56reb/SGJ5R3KHNaynEcGqtfYGRkjP
	yjVNPRlqmDNN/evDVfFd+3+UdOcu/QOiPkux7p8FATWg8ixWV6HsE6cqE9r8Ur9T7L2EugaMILJ
	X/crv9ebpH8JWsd1B1ebTERVCD1QnFFrb3XOhA5j1rttMqRN9TbV6qMzK+J/mxqMiY3e1
X-Gm-Gg: AeBDietVEJiOiiuZPwN24QCJWGY2IuqWaGItwl1e2HIACb+lmu6OzLF2MoCQgF81jwJ
	pmfLqIyP0wRF6sTZedN25f7vDe2mW+kORRx62Zs6v0zZGL404hTEhJQd/AsX8cM62YhDXQTeTdo
	4u3o0fcOFn5d3TNzrU9XDDohfrarDFjzvPPYmnqJHR5X8KogtKeOhGxAJ4COglcoM/Lcpiv6P2S
	6mHqgnXL6A5Edqihr+O6d2wnrAYdmg7ubQ+EQIiSEWzhwhsrGd7kC5I96269HPRh6q8Yf6BrHhN
	/iU3EDN6mcpg6f0L16l3E34tf6KwLp1Zgk8lqP4E3sHF62JSboUBhNDq4g/wGYzxL0VY/O23LZS
	0qgDoqfR38tAr5f3eat1iMWNO4afVonNpmtzHpIqPE8KSiHaibXAY35PLUgEHDOzxN+/sV303Hg
	rBAUjQPA==
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488d685fcf7mr215995615e9.22.1776267663574;
        Wed, 15 Apr 2026 08:41:03 -0700 (PDT)
X-Received: by 2002:a05:600c:a106:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488d685fcf7mr215995085e9.22.1776267662938;
        Wed, 15 Apr 2026 08:41:02 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm6314894f8f.20.2026.04.15.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:41:02 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:40:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad-xdCce7fPbBeyP@sgarzare-redhat>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
 <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260415-fix_peek-v4-2-8207e872759e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AfzQfGbFiEykYPcdOU4EMXM_Xwbu3e9YQK5QdWGOaMg_1776267664
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 15, 2026 at 05:09:29PM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the number of bytes read: MSG_PEEK
>doesn't consume any bytes and will re-read the same bytes from the buffer
>head, so summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if more
>bytes are requested than are available, the loop will never terminate,
>because `recv` will never return EOF. For this reason, we need to compare
>the number of bytes read with the number of bytes expected.
>
>Add a check: if the MSG_PEEK flag is present, update the byte counter and
>break out of the loop only after at least the expected number of bytes
>have been received; otherwise, retry after a short delay to avoid
>consuming too many CPU cycles.
>
>This allows us to simplify the `test_stream_credit_update_test` by
>reusing `recv_buf`, like some other tests already do.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       | 15 +++++++++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

