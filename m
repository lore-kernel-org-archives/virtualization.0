Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767191;
	b=cKFKOvWqdkTNW999Pwo8ZjyzI+Vq274d/5pz1VRVQNvFYwNxpUxoB0TxmrTHWoX2t8j+
	 bbpkFu53vPs7ihOMiLcK0yJuvVqtVnjcxrgFxWWwsRfdEhsaZjFIOcWFlXV7/lo3rfhit
	 U+2rWZ9Rwn5vIEvi+Nnn9QMRD5Q7vcnWKmrGEuIl+1XVAT72Yz/hhpyHH/Ho9jnVu+6SE
	 FRUvy6/gVJ7f6zPV4DBrkOLWL0MYOT6cyiYHWThCuljmVTPYctPJxxhm6AGLYlg6CyMzH
	 6QXOgTRp9G6qUZCwRGOENDNxymdUwozogSkLwZ0WS1P6D6GaBSEfrEL4BjZ8HX8i3yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eneHgnMAcOc/djCTrB0nOV0g2dEReb07JOlhFtlo25k=;
	b=E7IKhibfPFFPfqRE1h236FhkOc11imbBYv/1JZ1vP72mP3NBtqVlSOGtrvH65ylleOHV
	 OrYfPJZpXt83clGqLjJpKGPmxhsGYc0oSh/lXWakFGv/PSTSDM5KGDS8VpfzFChWAK6jG
	 H452MqkduzUJv3SquqNfyEkP4BC39sbKD9DLtNpTfnxwihITn71/tnK403+qMKkEUof+Y
	 fdmUQMBNdyaIxVUdRgzNJ4/bYKMBdbZa6mP4nh2S+7tiQgomewuonSQe3Q3gXlYfx8OdE
	 cB97HwGle0AC3Ko9YrxGhmUBdVAvKFScva4IJaqYKPRVoAyWcSrBNhHX+2tlPW7vYdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHAShk+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D515606A31D;
	Sun, 15 Nov 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHAShk+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F7B1F000C4;
	Sun, 15 Nov 2026 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794767190;
	bh=eneHgnMAcOc/djCTrB0nOV0g2dEReb07JOlhFtlo25k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FHAShk+4mVyHfMAnpqQb+OFmANjbslij+dPs+VKBbPKcwALFWzseYnDCBD+Y0KQnB
	 eZokN67v9HcpcVJzMu7QcL2WCh42NL4Jex13p2ac4N3IIHZLw2O4XSIe/9Kfp/XdvD
	 WXBuKRM3/+YhgaTJjotCcRv5viJktfdeNs8F/zCfTRuaRLdxr8hDrCdz+K0mYCdgB/
	 uEix9WPF/7xr9GTPwHKLwEtWoHho4M2v9+PfaJ8HR8fzuAmpMNJz3uNCmGQGYNHKKB
	 Qk6cs37sqaqI1unCeXDFET6gh6hEjUE+MCU7uUCRV2hHQ9q+VHusvKEf6Qz0/SGvSC
	 PoSu6Qk+5Z31A==
Date: Sun, 15 Nov 2026 10:26:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: napi: add completion with an ordered
 IRQ mask callback
Message-ID: <20261115102629.2c6d107d@kernel.org>
In-Reply-To: <tencent_2A5F8EBA9EC78CA99CD080386A68EE90B506@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
	<tencent_2A5F8EBA9EC78CA99CD080386A68EE90B506@qq.com>
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

On Sun, 15 Nov 2026 15:12:45 +0800 Congjie Zhou wrote:
> napi_complete_done() can clear SCHED, arm the watchdog and return false
> when deferring hard IRQs. A false return therefore does not guarantee
> that the caller still owns NAPI. Masking interrupts after this return
> can overwrite the interrupt state established by a successor poll.

Please stop submitting this LLM slop. You reported the bug,
if maintainers have time they will fix it.
