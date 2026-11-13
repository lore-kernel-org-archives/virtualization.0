Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582467;
	b=Ye0hHwtXyvrrA2A6Im2qBJZk900B1bB0cvqCQRa4lBzs4HrKIeSTFgwlptiG6jagL6JX
	 Ixn+NT1npYTItBpHIJTKi910BiySN0xMuiDWHMKCgEPd3kS0LoPjqAhRfGHhagvheTdoq
	 CqrVvfAnbTYmAf/2x6j73BZCGLW+PqQSZpLCnopuVhMXDaH70fMmDvEr0ic0wz1yCSR9p
	 PkalP0zIropVjBm8+fD5kutOoMeh/qo4BwmlQ+v7WC/Py9ul9Kpinu2lMn+8HYmruYpxc
	 u1xBB+arQEiVZ63vwgO28WKYRE/VjP2oWVm79aAQVcaDf6nkM78IVTyfwegTHrxtoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xdl4Tdbv431DSm2QRDQ9sk/ziyVXTlG68qSFJIbEu6c=;
	b=ktOJHtynMIdFDCoq0utZcypu7bBlsclLJegDgdIZ9uiO5dKmsY7NqoE/R5keI2JZORtf
	 vPnCKYtjP7Lxs7mHnnPyueIHQiOczY8v+euZCSWImybKwOw8mIsXZYAh3RyILUimpIFry
	 ThNfndXkFIAUCuO5XKfOvq7h1701ZIrjcNlO5EknyumBfmSlg2IiyVc+mZcos1QHOYcWP
	 mMJwizSlczHljSD7WDO/FbrN3yxfbOSyWGvOYj/rj9ufC0dpT6Za9QR1He8Z0BAiVGKQX
	 lsjihrOpWApzgfgsJ4j6mmBq7YTrkUuXkMcfksk5bWIcUJa4edl/mawY1vaL3RLBGCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjnFH63k;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF499606A894
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 15:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF499606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjnFH63k
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so1936697e0c.3
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582466; x=1795187266; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xdl4Tdbv431DSm2QRDQ9sk/ziyVXTlG68qSFJIbEu6c=;
        b=jjnFH63k9YMPuco8qE5Bc00ZTb0xEMXQz3TybSuv+HEmXBJ+yJc4v8XRd1SeCn4dUT
         vPcU5+e5EZx9XT12Zn4XOE+zCNfcukxz4wb8H1kt0kkC9lQD5Zbbb53TsHSCz/2HF+Xh
         BQ/R4RgZOwDusQTkpV9/lqDtS3S2SG9XgesSUaIgNRYZ7QKXtPiOJVEmhDFOiEw5alrQ
         3dOcpX3yMgfFPe3nkYVvLIBY86T3RIt4VkE5gdqF9gyUGn7eT8y5Y67XvTLd//6al6HT
         VFmo+Q7Mee6B3WkoYVccYXrNgm/age34fjhQAjLP56A9dtpZ1dqo8mDW+gVvmAarLqDq
         42oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582466; x=1795187266;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xdl4Tdbv431DSm2QRDQ9sk/ziyVXTlG68qSFJIbEu6c=;
        b=FDhXwXodXG7Fe7V9ZTR2UNi6vvUUk6jT4Dfm/6u6L+SZkVLX9l6Nzk6AYOxVM9UJlW
         vfvx0BJEVgz6+7O3D32XmHpxQUrnAJ55TsoEi3PFwEv57UQvWir2HTXfts9KG5qIvQlU
         T1zwM/wpuINqSnF88FxmyneKZMTUZRAbKsrRXZCMXzBLOJhVMDMwqajP1GZRVu1N3DgP
         rDWyi+o2bPoIguyDfcIGfznI/qKnPK8y4CsnL/NSZ6eYXclBeUMG3mDT3DrZlA4qaanI
         kUg3jEm5xkUxXg8iH1tSDszfUVHshjtu7rwmEmr6yhac7KTRFfebGb40LmG491zpS1Ac
         KpSg==
X-Forwarded-Encrypted: i=1; AL+hErFyle9+nklRjisTonMR4LJoNovELWwBKRZkoNMBNLNIiGKiQ3CiiJmucXT0ZoyrtAY/rA826t//qq9MKTi7FA==@lists.linux.dev
X-Gm-Message-State: APuU4Z94JjoKnpcu4uohrI4yjfKRHFE2tUu9/i6u2sbGhQToFghNw4yV
	Y+A/y0G8DARAa0ZXx63A30PzDI7egp2oOVi26FScSKrzpLu3yizL4OIh
X-Gm-Gg: AYBFou0wxmkXhqxaNMQHnvBeslJ7IAL5xjzEf2x5vvn1b6SQVACIJZLiIP0ZQ0n/T8z
	+s9Yn0KjJkfzdTHgYibdWfA6qU2l8qQybyZVjH9vE2AbXDqdemoGEqFpgV9Jallo8is1a1Ijc9D
	c0PupXC6z8D863hl4IRPWI6eQ7SKj0koy5SVviA+2A27vBhd+iqbIzwUj35D5xEof+bItBpxuVm
	dTYd45yV1MQHZstTuBCUZkjKJ/irzny6fFa0RP8JrbrPSrvTla8ipKK5wDEoAIbVub/iTFjy0qx
	wGVWLG+x9wrAj5ctiqesUBXeIx9pDgTZFNnN3/rUzgy0I5GJ6o24tofAT2iiBFuSe/bPn1EfqsX
	BOgd00Qg+qVbRYS6ukuNUaW6IEcM0spE5dEpm+ftVBRaCoq2v8WhPufDCKS/6KM+7m9K0gNLDtp
	Q8P3I5PyJbOKKuPF6rDiZPxhtp0nq0pRI7NCbZwS4UxtBBT34qMiOjIVbcxSz1Ofyqv2CrE9iXv
	iaGaIr4bNg7HAcvAeIIIJD4nlAY1I3eo0pvL01aFzZYfr15pqSR2bG71cgcD0LOkqwErCDueyyf
	bgOoiNyWz4OVPTB3G7I0Z7wRV+XYYWxrsQ70xKShCWJUh2zQesS44U1maVF3Z7nBuSEdPWQh78D
	myVb7bj5cMK8sPGJUeHhBA/1MTyXax9/3kApLjBarFN/yQAJYywXNyih2cegtjtIaAQW4HnLPEM
	WkldDxVtwp
X-Received: by 2002:a05:6122:3382:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5ee344ee205mr1106421e0c.0.1794582465695;
        Fri, 13 Nov 2026 07:07:45 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee3df52b8esm122502e0c.0.2026.11.13.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:07:44 -0800 (PST)
Date: Fri, 13 Nov 2026 10:07:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 jasowangio@gmail.com
Cc: andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.14b320acee076@gmail.com>
In-Reply-To: <73aa2f53-e2ba-42b7-9712-06e223459144@mandelbit.com>
References: <20261111014208.1795777-1-antonio@mandelbit.com>
 <20261111014208.1795777-3-antonio@mandelbit.com>
 <willemdebruijn.kernel.1220f3b31f685@gmail.com>
 <73aa2f53-e2ba-42b7-9712-06e223459144@mandelbit.com>
Subject: Re: [PATCH net v5 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> On 13/11/2026 00:34, Willem de Bruijn wrote:
> > Antonio Quartulli wrote:
> >> Send 16k packets from vhost-net into a tap device with IFF_NAPI and
> >> netdev_max_backlog set to 8, in the three ways vhost-net passes packets
> >> to tun: batches of XDP buffers, one packet per sendmsg() with MSG_MORE,
> >> and zerocopy buffers. Check that excess packets are dropped and counted,
> >> that the queue keeps draining while vhost-net keeps sending, that every
> >> packet is either delivered or dropped, and that every buffer comes back
> >> to the ring. If a dropped zerocopy buffer is never completed, the test
> >> fails, and closing vhost-net then blocks until the buffer is released.
> >>
> >> The zerocopy variant needs vhost_net loaded with experimental_zcopytx
> >> set and is skipped otherwise; with it, vhost-net does not batch and the
> >> batch variant is skipped instead.
> > 
> > That means it will be skipped as part of kselftests.
> > 
> > And as a misc device all tests may be skipped in minimal environments
> > if vhost-net is not autoloaded.
> > 
> > Maybe a .sh wrapper could resolve both.
> 
> Right. With a wrapper script we should be able to deal with these.
> 
> >   
> >> The test drives a minimal split virtqueue itself, in little-endian as
> >> VIRTIO_F_VERSION_1 requires. It needs root and CONFIG_VHOST_NET.
> >> netdev_max_backlog is global: the test lowers it only once setup has
> >> succeeded and restores it first in teardown, and should not run in
> >> parallel with other tests.
> >>
> >> Written and tested with the help of an AI coding assistant (Claude
> >> Code).
> >>
> >> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> >> ---
> >>   tools/testing/selftests/net/.gitignore  |   1 +
> >>   tools/testing/selftests/net/Makefile    |   1 +
> >>   tools/testing/selftests/net/config      |   1 +
> >>   tools/testing/selftests/net/tun_vhost.c | 409 ++++++++++++++++++++++++
> >>   4 files changed, 412 insertions(+)
> >>   create mode 100644 tools/testing/selftests/net/tun_vhost.c
> > 
> > That's a lot of code for a fairly narrow test.
> > 
> > Not that long ago I would have applauded all test coverage we can get.
> > But now that LLMs generate them instantly, not sure where to draw the
> > line.
> 
> Well, the test has already done its job because it immediately helped me 
> fix some small itches in patch 1.
> 
> This said, I can definitely shrink this test a bit, maybe around 50% of 
> the current code. But it'll still be quite some code for a small fix.
> 
> Should I just drop this patch?
> 
> Alternatively, I drop it from this series and I send the shrunk-down 
> version with the wrapper script to net-next later on.
> 
> 
> Opinions?

If you could compress it to about 50%, let's merge.

Maybe we can use it over time for more coverage in this area.
