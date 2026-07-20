Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E03F9A16
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568860; cv=none; b=IkrJh10QMV60IiFpK4GqiFCnsGABKugoda/DEjQ7ccpHgs76pThyYs2T0iMygo03QtRn1K3szLkUVDF/fJ95ReAHCrhXjiTxSZw1JjacB+wAP2S9IYWtMgF4fd/Ctky+VFhYOULQ88a9x94Frdd94HbjWX696P6s+x0AKe2A0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568860; c=relaxed/simple;
	bh=9rPa7ILsFfD4wiBH1dl7enIOztDBOtxFqZVsoJxy5aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZipQPKO6ydXYwKv5hn9ieoTN24v/SCTlFTwc8zsm4X+eeurMNqGxlaAjEzAIJGTIyx5zjsgqNpUX70anjbpE2CHCgyQ1oxpy7+rQTezWSAZOQ5MHynYws/O9ZxLWLzElpRuZga2uw5iPiJWzD8zhG6ueNWIqtqKIuMx6taHku8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwKF5v++; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwKF5v++"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso6952522b3a.2
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784568849; x=1785173649; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJrcjKpXVQnKLdbBW9eWHsb14u8QHsUOoad2GXTIGJA=;
        b=GwKF5v+++NqbXhPNDufeZZ2ALUuVNDpCXltCJ9H6VHXsTZfcyKqdOH//N2HVMkJQV3
         +hvgG6fcOXNoKzkwVrR7GxU+MBYLO5sZbUndgR78PIQFiZfqY0BvFSYG2ZGR8+dwWYbr
         B038SNtlbah1bEc+RDusBdTCRz7EfDt72CNv1NbrbTHoMRIFDm2Md0y25MfI6TxGRKfV
         sIuvGc8Kz0CftZwLhE4GZY6eU6vJKD6gI7RBGnHZlUr6UKBpFILj4VoJyx2ign8QtPbO
         5KVGMFZQkgsHHSIJeDBduNuD41m/L6czIn3Nmjxynd+1ESPAoMjCdcmxsg7WIqmA7+LO
         JxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568849; x=1785173649;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJrcjKpXVQnKLdbBW9eWHsb14u8QHsUOoad2GXTIGJA=;
        b=lxbptSZGnwIlj5242TMstbsyUMnHspF7F4X4F0QRrp53TXsLG9YgodtkFDBy0Rjrns
         BBWaSgw+86DqpLBd/OzSGJq53ZtKx1u8+aNZfRhedai37+47Guh/SEZQ5Oc+IzV2KWtN
         UVeUsVF0aFnvJyJDEq4lKhBippGZycnEH9zJW+Ns8VqLLXBkpBZHib/LvjsZ6vFWs51g
         HiwPK+Ph4acC7KKzq7Xp0osRcF8+Dm+7D6QUTktFrKpx+99VBWTgDBeVI7JvVGRd01Xp
         3TW5zHMAph/fKj6ukWX1wF1VPuG0u/hClUKdCTasIpGoHaRYTMvlWxD6UgTIRztPf3Pr
         7aQw==
X-Forwarded-Encrypted: i=1; AHgh+RrE9OP0guJDuuHJhAJY4VXYWDa9lPqJNPUD9X8yGS74BZEZUe1Ap4sjaNLBztx7jSViidttfewuQGmy1tZTlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yywr1SqBwQu8g9hI8r1CBQD/iY3DW1BF+olRgKvNwBz/MpZJVfx
	yo5uj/cubqAs+iDU+CquGYgmzxbVK5HYYWOX9+cVneatH9KCBV5EQ2/7
X-Gm-Gg: AfdE7cl7uQWT07iJssGgVdvV46KBufgknyLxTuCXY5Nf2LsRKQC0QlTnQRDTe2sz+cZ
	lL3F/fdMvOHnCEdViqTCrQVgyGaDGxlyyGp3TvYboUKrfjRNunlODsCDUm4T8kfjg8uSOu89dUp
	oQGOBPsFsWMm2vNS7JIQGUJOBcJy0mlmdkf9V5wx8j+TE2aMDXQhZLKi8deFgtB9+a5X9ZFOVcw
	u8K0ZRG9bTg8XuZ8Q0dRCfZvEMMXXyejuKwOFJ5QSzf2cRkqDF4XO5I3pBdSGy1tsUC+dV1idn6
	tU0kQQ+fQT2xY2v5oNoYmp1DqtOy6c3lCFKasKBaMVHniiIrP3kfxWfo7znC6z+ndNOejl/WZQM
	hU4QyJTiVoUlfWb13fsWOQVWGK6Fbh5pfZgegJPREBOQEVstDmoBGEgFA1742ZSCEddnxvONRMK
	EGXGulYeMxxvpx7dhl5jg7ZFp9xkxr9ZmiI9kdj/H1oyjGjMoKWUJpHfpl
X-Received: by 2002:a05:6a21:6803:b0:3c3:4ab3:608f with SMTP id adf61e73a8af0-3c3ad81f240mr16989952637.29.1784568849345;
        Mon, 20 Jul 2026 10:34:09 -0700 (PDT)
Received: from ?IPV6:2406:3003:2007:2131:a42d:c0cf:43eb:f0ff? ([2406:3003:2007:2131:a42d:c0cf:43eb:f0ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcd9sm39542802eec.3.2026.07.20.10.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 10:34:08 -0700 (PDT)
Message-ID: <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
Date: Tue, 21 Jul 2026 01:34:03 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
Content-Language: en-US
From: Phi Nguyen <phind.uet@gmail.com>
In-Reply-To: <al3UuvBhfxp82krV@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>> After vsock_connect() exits the wait loop due to sk->sk_err being
>> set, the error was read but not cleared. This left sk->sk_err set
>> for subsequent operations.
> 
> So, is this a fix? If yes, we should put a Fixes tag.
> 
> Also, can you describe how to trigger the issue?
> 
> Because I see this in vsock_connect(), so I thought it was in some way 
> already handled:
> 
>          /* sk_err might have been set as a result of an earlier
>           * (failed) connect attempt.
>           */
>          sk->sk_err = 0;
> 
This only handles the case where the function following the failed 
connect is another connect() call.

>> Switch to sock_error() which atomically reads and clears sk->sk_err,
>> so the error is consumed when returned.
>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> 
> Can you explain how this patch fixes that issue?
> (this should be the first information to be put in the commit message IMHO)
> 
> I'd like to understand better if this is a fix of real bug or just an 
> improvement to the code (which is fine by me).
> 
> Thanks,
> Stefano
> 
Here are the steps of the syzkaller reproducer:

   r0 = socket(AF_VSOCK, SOCK_STREAM, 0) 

   bind(r0, {VMADDR_CID_ANY, PORT}) 

   connect(r0, {VMADDR_CID_LOCAL, PORT}) 

   listen(r0, backlog)
  

   r1 = socket(AF_VSOCK, SOCK_STREAM, 0) 

   connect(r1, {VMADDR_CID_LOCAL, PORT})

   connect(r0 -> self) -> -1, EPROTO 

   listen(r0)          -> 0 

   connect(r1 -> r0)   -> 0 

   accept(r0)          -> -1, EPROTO

Basically, it creates a socket (r0) and triggers a self-connect after 
binding it. This self-connect fails with EPROTO because it loops back to 
r0 while the socket is still in the TCP_SYN_SENT state, causing it to be 
incorrectly dispatched to the connecting-client path. The unexpected 
packet type encountered there sets sk_err to EPROTO.

After that, it invokes a listen() call on the same socket. This listen() 
call succeeds because the kernel's listening path never inspects or 
clears sk_err. Then, a new socket (r1) is created as a normal client and 
connects to r0. However, vsock_accept() rejects this incoming connection 
because the listener's sk_err still holds the EPROTO error from the 
earlier failed self-connect.

This rejection causes the child socket created for r1's connection to 
never be freed on virtio or hyperv transports; only the VMCI transport 
implements pending_work to revisit and clean up a rejected socket
This patch will prevent the rejection branch to occur in this scenario.

I think we might schedule the cleanup worker to run in the rejection 
path for these transports as well.

Thanks,
Phi
