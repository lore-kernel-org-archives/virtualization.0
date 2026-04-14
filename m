Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF22C11FA;
	Tue, 14 Apr 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176549; cv=none; b=hN44rPuHSmCbJhftHeYT9RLcFs3z0v2W36KagN50l+CG2XHkigTJPh219f3vw3q18l8lyBkL0VFjRPuCwhTS9RCf5NP4vhNHZHCDaMRu0edf4+nWVaTN+HiMKNfIQKMl9yYNRiqomvf1pX3jwbwLermeg7XAnuu3ZmlBuvPW8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176549; c=relaxed/simple;
	bh=UIcmHulSaQtBHy2vVHU+6OgGuET68ZtsO2HlSja/A14=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gG8qLazPZumWlRk+hNSImnG6IYrXPpOWU6FXxO/TsYjnZHRRqEtOj44hwxC3Zk76g/bK42u3FeUmOTGLBTpcNIb20n6AOq+InuL1QfgDeT6i8OJUIQ3+G9l7vcbHYjHltEYaWcTiHCFR7XU1Xs9lccbwNTLPboCwfWMqcy5bxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Y5BjaLt0; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Y5BjaLt0"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wCeem-00FC9b-KE; Tue, 14 Apr 2026 16:22:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=XN4JIfDgNH9DCaRDhVx/eV6ftjzRJWNMrRvzCG8XlRM=; b=Y5BjaLt0zEQ7VzcC9Qf9HQJDpZ
	+8ve9zJdXcz5rP1c1l/s5pF3jiME85s0kok+vY3QE/++DQzP7tWmZ0CvI5C29geYcZrAJYfkxfiWS
	k0mgs1p7DVRXEQBYlcDVPl1DZMJxcsXSEX4tupCTIQgJiwje0xtj4JinBZeK9Qc515VLCcu6brlCl
	fW5PVnu7o+b5ipuhmn2fxE+MS9C6u1Cr0SfUZ9OkoM+Ba+zYvce43zW9f7bkXHPUJ99HO7ug8vsq2
	IJNr/nrRqKhixfXAFSCgqocJ7GUv4euJruWVigp+oNv/jf0AR6u6S1orInYa9ZAtsOMe3CqE0B9dw
	hIqfdkUA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wCeeg-0002cY-KB; Tue, 14 Apr 2026 16:22:19 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wCeeT-00DigL-6l; Tue, 14 Apr 2026 16:22:05 +0200
Message-ID: <e965ff22-37b2-406d-b885-e2736e84c0f3@rbox.co>
Date: Tue, 14 Apr 2026 16:22:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
To: Norbert Szetei <norbert@doyensec.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 18:34, Norbert Szetei wrote:
> In vsock_update_buffer_size(), the buffer size was being clamped to the
> maximum first, and then to the minimum. If a user sets a minimum buffer
> size larger than the maximum, the minimum check overrides the maximum
> check, inverting the constraint.
> 
> This breaks the intended socket memory boundaries by allowing the
> vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
> 
> Fix this by checking the minimum first, and then the maximum. This
> ensures the buffer size never exceeds the buffer_max_size.

Something may be missing. After adding another ioctl to your reproducer, I
still see crashes.

     SYSCHK(setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE, &min,
                       sizeof(min)));
+    SYSCHK(setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE, &min,
+                      sizeof(min)));
 }

[*] Setting buffer_min_size to 0x400000000.
[socket][0] sending...

refcount_t: saturated; leaking memory.
WARNING: lib/refcount.c:22 at refcount_warn_saturate+0x7d/0xb0, CPU#2:
a.out/1478
...
refcount_t: underflow; use-after-free.
WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x50/0xb0, CPU#12:
kworker/12:0/80
Workqueue: vsock-loopback vsock_loopback_work
...

