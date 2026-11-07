Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027653;
	b=QfO3GOj4NMQs094bdabA3VbWKaKTMQZNMaghYsFZBYIuUcUyDxPfht6b4ls5z9M3ynU7
	 Snz5vfSxvcKM2GDfV6NQrYcteLCbielorxzl9rgdFBTr1GC807M7OHVkwRu63X5cjpKSM
	 a1rRKokFO6rBMwJ42zayJYDr4mMX6JBLcQQPEt3KhzyctajfdS99sP9hv1R06zM49g7Ac
	 IqfXi4YEb6gJT6BIP3YAK3mfr73FSOh+5xq/vPmqAxDM57iAFVq+jbD91sTUlsiRGwSOe
	 1klmTO6k/1Wcz6MxDvm3LpxHfPZTLJ5g5scjAopD2V1YJv2OLXUSUWfUNWPKy02ILvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027653;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=NnLdJUTw8NyPHACTvlK4M1CjSpMv4igCIqBIPH6KXZnwcfPhTrOSXNz4jTBZ6dNODqrC
	 tt7FEVgIZBom2kcPitUNjhi1X+C1GbjLB6FLAXnDWdpG1mrlecwL+sowJguTegFUpVLY/
	 pvAD1SIf9Wi9ttZLDd8T/jvgjTGCWY/X7ljjZrdRZwmeMTle0g8jrGvryPqbRbJXaMU5E
	 OAW4GdF/XL8BeBxXHv1WHwBPq9ZOcD2/HncQluwO3vNzaRWGh9lqUA47lp7NC2SeAEC+g
	 IKP48NK80wAuXgJ1lty4LMiP3w71swHoaLo2os1S0cAfauZtJgsgtjtFB8n5T4ZsNLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMHGtyOu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA9606A32C;
	Sat,  7 Nov 2026 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMHGtyOu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6471F1F0089F;
	Sat,  7 Nov 2026 05:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794027653;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMHGtyOuB9f1RSHcRFJlSV1ihIw5TjTFvn9j7G6T1Ldyl8Qzshzkm9/onwRlW8tIF
	 8ktP+aZh0chmBxFXrmYJS7zrAPJkdmSDtC0bCn7fGneYem8EL2ZEQnoD85NeGnHGN5
	 dQpUo4cgBghmhgtYGM6JlFrm/ju4oCsLvY/75JomUH5d3cm7OCFxeMCP09stPzzPlC
	 J8mz23huu7EdTy62OzQfh0bQWTlsWUXb9+CR+VC5YfBMvRdLIFHWfyksKrbk85WFp6
	 bjQ9hyeMDuHElskrpex5zDEQeEj6eU/46resCnEf81ksUr0tjHApwKKt5AtVHcfp8T
	 RBnP8Dg7z7gng==
From: netdev-bot+sinfo@kernel.org
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net 0/2] virtio_net: AF_XDP zero-copy fixes for arm64 and suspend
Date: Sat, 07 Nov 2026 05:00:51 +0000
Message-ID: <179402765189.488859.17099847531290257740@kernel.org>
In-Reply-To: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
