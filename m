Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459265;
	b=4GP1kmtPI776ja4pPs7vvxcu5FLMOjQFMSHmuiCYSwdWPGGIUCbCPF9hpqF/Bl5jWZMK
	 Jiew23Undr/VHdC6erkd2EjRYt/C5gPOCYxQkvvE8J60+VX/cDwzv6pScJonY8IAjkHwX
	 u+HCc+qjNET+hIT1xr0lFHrHl5PCKfkmHjFxZ0ViSG1ErIIPykpj3vUa2WWbglHqaLGcp
	 PdWygt7BlWFjq9ZXFcKu2IXBhI0TRlkrlVSXn3gNhEpmnHX9ZzV5xcA7Jo6ED+Dtr2cWQ
	 D5XrgzmiTswOkl6SNMwovRJ/3RiJVT88CMPrxEiqc5mZgGD/cIGsn2nzZm+wKVVp8wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459265;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BGxY9jevA3QgkBoZTefIU18+q9fvG5+KvxW8VaICI4o=;
	b=CA5DsoaVdZ9jBe0E2MApKTii+Rw81dctoCg8x4v0tlfyI4mRBta8zr85zpQyiB8A+FN4
	 JH1l1Joz6qi5L39fh8rn2Hcr99OL8kcXvGCrxgHGxK0j3iUFag3L67rgwvfDuQd7MC2wN
	 hyeC7b5L4TEc8miNftlpAdbDcXHCk/NtVUwq21+wQ7MPJMU+Kw3Gn7fGy770Uo5TtzVfb
	 RMWPmzeGl6Rsx6d6KLJydtDRgeSWUCI6UI1ewCeJ6lIi33SmpxQJrxdq/j+W9HrLFqmp5
	 i5p5j/EXNnb09VK30AAlhN9Ah4C81hmajur1RikHPI+DGQR6arYyyD66gYEmb4QeukQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv9i+HuL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4C606A31A;
	Mon, 23 Nov 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv9i+HuL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F61F000CA;
	Mon, 23 Nov 2026 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459264;
	bh=BGxY9jevA3QgkBoZTefIU18+q9fvG5+KvxW8VaICI4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gv9i+HuLw0mdNlLQAToknH8q0eeD3vE2+wprgU4bRk6s1qJs4ngze+ymBm7oSBIfK
	 M+4SyCy8HzugK6f5b6T4/tOK9CT5n1bJec6VUkBWbUqFj3/8c6cNem99dyGcFJ6dFl
	 9T7JsZl02k9iH32BFMiAWViJN5EdlxaCvmaWCUamQV51j1u3QAyrTgpCL9UsCpkqlp
	 tYY/JO/OROST+HIpXEf4bqALFH71KjVenF9OxMnaCX6URG3dqztIgpRPtvewNCbmkI
	 hoLYv+Gn3TkggCZR/8pd1yXF558paVxJa4NQKuqT3vfTB9cO2PCRWd2U4Cqehg3a6h
	 ALb1BsyqnnUmA==
Date: Mon, 23 Nov 2026 10:41:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Congjie Zhou <zcjie0802@qq.com>, Jason
 Wang <jasowangio@gmail.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio_net: mask callbacks before handing off NAPI
 ownership
Message-ID: <20261123104102.120856c6@kernel.org>
In-Reply-To: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
References: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 12:13:44 -0500 Michael S. Tsirkin wrote:
> Virtio is special in that enabling or disabling callbacks (interrupts)
> accesses shared virtqueue state and must be serialized with polling.
> It therefore enables callbacks before completing NAPI, and disables them
> again if completion returns false.
> 
> With napi_complete_done(), that false return can come after ownership has
> passed to another poll. The first poll can then disable callbacks after
> its successor has enabled them, leaving RX stalled. Virtio therefore
> needs to disable callbacks before handing off NAPI ownership.
> 
> Add a prepare/finish NAPI completion API so virtio-net can mask interrupts
> before handing ownership off.
> 
> Reported-by: Congjie Zhou <zcjie0802@qq.com>
> Closes: https://lore.kernel.org/netdev/tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com/
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Message-ID: <20261119064843-mutt-send-email-mst@kernel.org>
> Assisted-by: LLM
> Tested-by: Congjie Zhou <zcjie0802@qq.com>

Not sure what model you used for this but it looks like shameful
slop. It'd be highly preferable to fix the driver. Highly preferable.
If messing with the core is unavoidable and doesn't cost any perf -
please look at the output of your LLM before you submit a patch :/
-- 
pw-bot: cr
