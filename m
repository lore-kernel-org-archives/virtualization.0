Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26020469B
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436501; cv=none; b=X+a7sDG4/y3TgkP9dDiPJmMoJ5Sj3FWo9TmAl5OrjtJYd7v/K8rn5Lb5w3yxmqe/PvwxT4WEDp9K1QE33bhxKhJHNu31G8481OgH7I+UbXttT62iC227h5TmLF7SQpaAUNUhIguw/fgGPoLDw1BdBCNvf7s0VTnDnuSjU3qJHxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436501; c=relaxed/simple;
	bh=Spu51y9HfZuOxHXPfsEWvCmRgGJgzXcQUPYrBwwbc4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9jXbeOeF3iEEilYXOoRtzUG1Rfj6Rx2iEgx4W7bQ2QyEon4+Bgolo6sAK23MG2j/6IaZ4XDiwim5fdSDSBbnAJqXYTPp336NWt2WKDbP04/rrPLZqMbJm134ZHrdVMLZqlatWj/ezHV55kQ7w98kUkhLRMkC0+rvGqtiUM8S9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YsIG8cgA; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YsIG8cgA"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tVuSA-003GPX-Hx; Thu, 09 Jan 2025 16:28:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=NnAJ9ysjnx9++5Tx4kBs7NCrt44ysPVsN78x25Ia93U=; b=YsIG8cgAFFi8vjxD/YzvpAyj9G
	oQlYlT08oJ3QDe3lvIYyOnGCJW8m96RaXXVSKTAZL3GfkdyVRQa2+Zzxhk1J+2B2HSLhuM9if6E1i
	Uzpya8zCKO9JlMrVpkrlgOwFkjgYEPDw05neTBPiVcOCCY1YdQsOgb3hcYj3hLBkb/z1cP5FQ4Wng
	F07tDkAFG9W5RlGoOmL+ijIUCGK2mEvdXiYG6H+ue+BymTN+IS6FOScwjVHFd9GUb6TkeMjr9cCE8
	gmari1ZpangqHiEeSU8bHfOGCd5LuvF79YLJsgXu0IVUTlp3vS6jw/Qc/IANUsQXRCRnR1h5+2WEV
	65jdyx+g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tVuS9-0004qn-2n; Thu, 09 Jan 2025 16:28:09 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tVuRs-006wNO-LY; Thu, 09 Jan 2025 16:27:52 +0100
Message-ID: <05c8648c-d6ca-419b-a4ec-6b305f4ca19f@rbox.co>
Date: Thu, 9 Jan 2025 16:27:51 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Wongi Lee <qwerty@theori.io>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 virtualization@lists.linux.dev, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>,
 kvm@vger.kernel.org
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
 <wix5cx7uhthr6imrpsliysktyae6xwuzpvg77uscswyqwszzfb@ms5osa4ckdcm>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <wix5cx7uhthr6imrpsliysktyae6xwuzpvg77uscswyqwszzfb@ms5osa4ckdcm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 14:42, Stefano Garzarella wrote:
> On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>> ...
>> That said, when I apply this patch, but drop the `sk->sk_state !=
>> TCP_LISTEN &&`: no more splats.
> 
> We can't drop `sk->sk_state != TCP_LISTEN &&` because listener socket 
> doesn't have any transport (vsk->transport == NULL), so every connection 
> request will receive an error, so maybe this is the reason of no splats.

Bah, sorry, I didn't run the test suit.

> I'm cooking some more patches to fix Hyunwoo's scenario handling better 
> the close work when the virtio destructor is called.
> 
> I'll run your reproduces to test it, thanks for that!
> 
> Stefano
> 

