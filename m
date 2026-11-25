Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638345;
	b=KyVoc4ZfZMF0h+mao5YswTk8GQSe3lEXJCgXhpU/seTeVcvyt5V0/6nXBv6+cTrrSIWg
	 4+fq7veRARHoR+2GGRI0vIZlklvd+UKlsm8DsUfYRUujhBWt1FSTVKI0Dly0TyKIsLsGf
	 Qy4i7ZWOAyYR5IUIA1tkY7adjwzdFErDVK5dGjjSJU//OBakMivFRxM1a2XbSd30u+QY5
	 GAsUDpxM431/0xLU0xtNcWSe7xcnplQR4KSA0L4sXbFJ4x5nqc539kx/EtbOExjMNE9Ye
	 UivCyvSgVIVg86rsMevMjkGdzAD0zy5uSArha4GwYQLUybj925iBB/aNIzb+edJovaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638345;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lS099HNDB2vWaVw456YMi/ugemrk/bhKCaW9qXISvfo=;
	b=5FsBRQGtX9TTSHeAidIekJJ/RYJXOwJzBVEOVyNnyEF+VxAg5xxHF59QBdo/ngxdvzUE
	 /NBQ2/+R8jFZHdnXZzI71QjztEoMeRvl3Xcvb6L9AdeiKhfyWaJZsLU+A4WtT12UZwLXC
	 kNLF0be9hYtGtBf+Bbly79IgQqKfqgFvzGHyPDCjKg3fYfNILGvJGgJ7kvoO/2zip6NSH
	 akaKVFDn3qnZh0m1tRkXF/no7eaYiLLq3Qa1DluJRR2lSagIFiVRThV9/1hH6/6/7iR5F
	 VQij7uHkxRZlCCEP5axqsP2OzQ5MTUzmESXMfaBEkUorjSH2Cte91/vYlfNINlg616w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b="piR1+C/K";
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87D606A31E;
	Wed, 25 Nov 2026 20:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E87D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=piR1+C/K
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xWJYI-00Bcqg-7s; Wed, 25 Nov 2026 21:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=lS099HNDB2vWaVw456YMi/ugemrk/bhKCaW9qXISvfo=; b=piR1+C/KYT1cZdTtb7eW0pAebK
	WJyloRhlVYKQW8DPCtOok6tcTDUiIIep9bK4ou5HR7BN28fTJ8FVAvRqH6TpyNsIO8lXMDBdwPCac
	NAEK69BWJV3Jo7KYRc07ADmJkLx/AjEOeFDOibNm08VDUCT9khfoBoflhheCrtNwxAXu13PMA3bzb
	RS7MVwTDlZ5GyWvk2GNSNlNdb7j7XoDwuvXGVJh7IxA4T4RJMjaz3KPRSRpKxyaKhYeXt+QoaAXAg
	8UcuzyQ84mpb4Dt9vaUEn42oGUxgSUKJmDyRgLaGZ4pMi3hCnG+6w+0OpFW3bHAzyR7PsR0pX5Jhz
	WqTnchow==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xWJYC-0006Ku-Dr; Wed, 25 Nov 2026 21:25:08 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xWJY5-00D6Li-1U;
	Wed, 25 Nov 2026 21:25:01 +0100
Message-ID: <f8a1d452-3557-421e-9429-1d6eadf0ad30@rbox.co>
Date: Wed, 25 Nov 2026 21:25:00 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>,
 Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
 <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
 <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
 <ca274ecf-3525-4bf0-a525-0460b5ea2d28@rbox.co>
 <awX2oDI/Mbt+z6J2@devvm29614.prn0.facebook.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <awX2oDI/Mbt+z6J2@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 21:42, Bobby Eshleman wrote:
> On Tue, Nov 24, 2026 at 05:17:56PM +0100, Michal Luczaj wrote:
>> On 11/24/26 00:19, Bobby Eshleman wrote:
>>> On Sat, Nov 21, 2026 at 07:32:15PM +0100, Michal Luczaj wrote:
> 
> [...]
> 
>>> So the attempt never times out, and a late OP_RESPONSE connects a
>>> socket the user already shut down, overwriting SS_DISCONNECTING with
>>> SS_CONNECTED. I think that's a separate bug for a separate patch,
>>> though.
>>
>> Great, I'm all in favour of consolidation. So in the scenario above,
>> invoking vsock_connect_close() on vsock_connect_timeout() (with sk_shutdown
>> check dropped) would result in CLOSE/DISCONNECTING, and no more late
>> virtio_transport_recv_connecting(), right?
> 
> Right, that late response will fall through and get an RST back.  I'm
> not 100% sure yet about how to rework the sk_shutdown check yet
> though. I mention TCP's approach to shutdowns in my reply to Paolo and
> I'm thinking thats probably the right way to go about it, but not 100%
> sure yet...

I just wanted to admit that simply dropping the sk_shutdown check was a bad
idea: vsock_connect_timeout() may outlive vsock_release(), and that check
guards against bad things happening.
