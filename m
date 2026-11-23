Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467019;
	b=TsbLciWchBO/SAYQJhgCR59AZzVJo6yZ327aDx+xYb/xPigirWMgHn3lFtd+ekCLethc
	 yEXXWXyaTCLmbbw6xQqjTZUUB5yw+pHkhKVSXCuNKdUmLmwZWxQgXcWh97OBdifMntX7p
	 mPeizSQRFmSEG8CiYYhALQ7yuSfRJZtaiDZOpyY//uXK21na0hNYsEmA/yrx/6Jjbf2Aw
	 3W2Q5NcfNEF2zJH5RHRFDamWDsFlsFyNWHSrovj5Bd3Y7jiCEkaHrSF76C0syEFsfVgXH
	 H06OdmR4JzGTtwPREobrF786SrzXjp66rt+Ew8EsABBVNmqmLQXV3nFUTri9/k2yivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467019;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=ZNYA94p3wyS8MJFRTvI2DM9YWDVViRJcOxfX03aG+YQ=;
	b=o4XJjsBCkP6Y2gaNdkiX4koOudO1uTuPFPvoF/CEg8Dj8w8KO5w9n2Dga0k4p6QdidzK
	 BxRfRI0s4m7dFycBouvcgKns7lNqon5+IkgMWeC7yuuFz4oi+oGZpKIOqdiGXRam9dSiT
	 gH2ABvuNQohZbxsifgpOWN9XhvvazmYqtjfq2V4cwT65LwE5B3V7veqkB7Q2QC7Pn77LC
	 80ena7vPXvMZK2dVbmq+UmZ0bHFhfoSkZtz+TpWcMSj3aVWuB7tXQ7wast3KH2eiDZ/2Q
	 4lCx60JA5wpdEy4RSvmSTNPOjBpvTueMRi3qVqxXWlK0D/xXCCNol528X0ZOxWua2/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yE7+gK8y;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0C606A326
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 20:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD0C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yE7+gK8y
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jYJ3q15xwz5wWG;
	Mon, 23 Nov 2026 21:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795467015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNYA94p3wyS8MJFRTvI2DM9YWDVViRJcOxfX03aG+YQ=;
	b=yE7+gK8y71CCSIXYMcs5D3wXsCcXx9mWGsWUfx+a0+LCkNQKF+rwLIofC2hkL4APTqWNN4
	HFq9r7SqP7KSwHxKjHL4XA2iXwskA8wP4DeE0EEQafbRuAca3OkegadQTGTLgPrhJ6vxec
	NjpkPw6PHcybKEi3Hc+xYOOjW3qyD2KosatSURlrTADe2iBAMgqCDzPEJ4SBbpOhRuZhAu
	fo7tiDans35cQFpMIBk1V2GJa9fVGumHGOicaQw58VeXSLi1qUFaPHVSvUD3I53LVblCOY
	oKGCWsHLnAtwr8Y+hcAjMoPsNggktFQ4llBZtxgVe46TI8zIN0kXipNzyQjVwg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <c663141e-78bf-41cf-81d0-fdda6fcbca74@mandelbit.com>
Date: Mon, 23 Nov 2026 21:50:11 +0100
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
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
To: netdev-bot+sashiko@kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, maheshb@google.com,
 peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org
References: <20261119153056.353156-1-antonio@mandelbit.com>
 <179530424233.3135.6226986969775563090@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179530424233.3135.6226986969775563090@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jYJ3q15xwz5wWG



On 22/11/2026 00:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Bounding the IFF_NAPI queue by packet count only
>    (net_hotdata.max_backlog skbs per tun_file, ignoring size) does not…


Right, and the commit message says so under "Still open": this bounds
each queue the way enqueue_to_backlog() bounds the per-CPU backlog, but
not the memory a user can queue. Closing that needs the queued skbs
charged to the writer's memcg, which touches more allocation sites (one
in vhost-net) and every tun user, so it will be a separate change.


> - [Medium] The patch silently changes behaviour for IFF_NAPI users who
>    set a finite send buffer with TUNSETSNDBUF, and the commit message…
> 

True for a send buffer larger than about netdev_max_backlog packets:
there the queue limit now drops before the writer would block on socket
memory. With a smaller send buffer the writer still blocks first. A full
queue dropping instead of pushing back is also what netif_rx() does for
a full backlog, regardless of the send buffer, and blocking on the NAPI
queue would need a wait/wake mechanism tun does not have.
I'd rather
keep the fix minimal; netdev_max_backlog tunes the limit and be done 
with it.


Given the above, I am not going to respin.


Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

