Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168792;
	b=0Zc/8qy2SnN//rthlxTbVFmeLzDNn0G2uprpOkaCyRiTL4L3s0hBNk6z0PI4Y40dNdlH
	 qx/v47hrueEHg1hfjiqafRuA+2b6JLEZGKZmt2FDFtR3gVB8AflQj0WzfGmJZYHWBbE28
	 WUqrYOtldr9tSNGhkV3esVUcRNKq5wy6fuhFsf+XfzAP/rAT0MAxZdN6ewaCVkuTnWjh3
	 qWNs6mHH/j+DoKm1rOlrPe0oI+Sjk/AVJxjUSbHjGTMNRck1kTLEuzXJSBhWKeIf+B+oE
	 hfLDfP6/y18yNpJ47sV1y/h4/gIDbpSavWpiPxwmzbqT4R0gpRdjh4vIAhhJucMSl/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168792;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5MTW3Bb1xlAB31/ui2+9ZOx6EhVGmav+4JCZP9NYzAQ=;
	b=kXksoo15HaffURwLsEqPGMyelp7qcdxm5HCmlapVB39xx2QTCmB4bATAQR3geO63uKcp
	 IuTatONfZSsBiwR0jLAmHdT3fpmp++6/Vq/o1T0TTdsQiRXykbzoCk8XWOAiZt6zUw/xb
	 ysN13D3x/Nn7Wbsi/eKomcEsf16P/q4icrb1crPJ3sClnVVJkuQSGzkAp5FL+TTaj1XxC
	 WvBZz3t6s5+QBHMME/4DosAobf2HrN8K1PifbypfYvkUNB7nEbyCg0xa0fCmctNtgYyzh
	 Co+0s958QqfIa7v/pwjd/RWNiTa7QQ7DZmc4zbBiJLts2N8a6XNca0xMX8ND2PAI0sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGV6JsjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D042606A325;
	Fri, 20 Nov 2026 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGV6JsjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5122B1F000C4;
	Fri, 20 Nov 2026 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795168791;
	bh=5MTW3Bb1xlAB31/ui2+9ZOx6EhVGmav+4JCZP9NYzAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dGV6JsjD8eL2wvoK9L34MtqxyhjMUnbh2elegykorDHRrtp8kZI9a7jBq1Zkmw19H
	 dK0afd12stWLgg3UkoLkJPnrassVHDzfwJwLngXt2jpCgt+Z+C5hRYTg+cAg+eK1w/
	 vrZKMd1O+e/2/ToOK9I1iV74vy7ppc+SDlQwiMkLeKd1P2pb7ntHmqK9+QSm9CeHSH
	 rgEG6LDSYfa+yBaeHiCpsVMYJ1Es6PvEbL2iZhk6WZ066aeTDDU45Rsph77LyIO/xh
	 W1wkP3Gb7BSxq2WOVSw21rfIxxFM2rl6MULclRK3z5jhNj6ioJSAf8dvZAU79UnN6F
	 MfFA3ZQlWheCA==
Message-ID: <96462da9-9437-4774-a5c7-f99858481ece@kernel.org>
Date: Fri, 20 Nov 2026 10:59:47 +0100
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
Subject: Re: [PATCH] mm/balloon: fix NR_BALLOON_PAGES accounting on migration
 failure
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, shao.mingyin@zte.com.cn
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261115004708909xx05JgB9nXnOCG0zL7h_K@zte.com.cn>
 <avia_XgVOuN_pZ72@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avia_XgVOuN_pZ72@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 18:31, Lorenzo Stoakes (ARM) wrote:
> On Sun, Nov 15, 2026 at 12:47:08AM +0800, shao.mingyin@zte.com.cn wrote:
>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>>
>> mm/balloon: fix NR_BALLOON_PAGES accounting on migration failure
>>
>> A balloon driver's -ENOENT migration result means that the old page was
>> deflated but the replacement was not inflated. vmw_balloon returns this
>> when its deflate operation succeeds and the subsequent inflate fails.
>>
>> balloon_page_migrate() accounts the deflation and frees the old page,
>> but does not decrement NR_BALLOON_PAGES. Each such failure therefore
>> leaves one extra page in the per-node count, which also contributes to
>> the Balloon value in /proc/meminfo.
>>
>> Decrement the counter on the old page's node, matching normal dequeue
>> accounting.
>>
>> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
>> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> NAK.
> 
> this is generated by some AI slopper's script, spamming the kernel. The
> patches I looked at were wrong/broken, so no to anything from this person.
> 
> They've sent 300 mails in under four weeks spanniing: ata, scsi, target,
> ufs, nvme/nvmet, ubifs, ublk, zloop, dm, md, mmc, virtio-blk, mfd, gpio,
> pwm, spi, PCI, ASoC, ACPI, net, vfs mount, block partitions, and now mm.
> 
> and 17 series across 7 subsystems over the past 23 hours.
> 
> We need a way to ban emails from people like this...

Yeah, that's absolutely annoying. In particular as we REQUIRE people to
understand the changes they submit, and own the code.

That clearly won't happen in this case.

There is a real (low prio) bug hiding in there, so something to be fixed. I'll
take care of it.

I'll take care of it.

-- 
Cheers,

David
