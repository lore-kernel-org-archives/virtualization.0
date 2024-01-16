Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287011C288;
	Tue, 16 Jan 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLA1UlUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C61C433C7;
	Tue, 16 Jan 2024 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705417627;
	bh=kIRKUcVcxVmMhpLMvIkQ7L2DwolBSjPtJAMcKi5awzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nLA1UlUfbz+ZX/uZtX0RUoGBhCISq84R2AfMdZsgVBv9C0TlTz9rapxUrIxfAcu1h
	 OGzzjYsnLTSAS3Hub931XuJbST2ZxgO1Lp7xNdyRR6UVVIaJSLH+dpNKCmK9YDoFlu
	 tsN5hIpD7hof7m79y7Lu6XOTyUOhw7rfz06bm1tr+P8xJRpxXRTCBE0LiXHBdHzaQ8
	 Vj8JEyqc5oZXAdYncaY3sRPi2ShlcLGjERgPdx2yfQIeux3KlN1A8OJn5zD9EeN8hT
	 kdpgPFbHlJItwS42pUMBph5MUXsBuYqMoJVZCTm5iAhEXyceKDGbfrCzqe68iZTEqU
	 AtmGrWF0QbeNg==
Date: Tue, 16 Jan 2024 07:07:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy
 (3/3)
Message-ID: <20240116070705.1cbfc042@kernel.org>
In-Reply-To: <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
	<e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> For future submission it would be better if you split this series in
> smaller chunks: the maximum size allowed is 15 patches.

Which does not mean you can split it up and post them all at the same
time, FWIW.
