Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516487;
	b=MYXTXzUgZi5+bk24uxwDOeipcBe89rmVA5QDq4c3C9NcY7Z0Z4EevzsV8zlTGMUuoeCK
	 LNYoequdVCnjsL+ZEYfE+xp2Zwz2/Ij32CDLeqk3eyPjatgwmrj2ttj8CpmlwK+q2YkxA
	 EJsxwLMie30cHHx/Dd1lK1jaFRKLbj1hko105+D2D5apU7Ulpbgv5DqfuBp0ZC3k/zWAD
	 owGVgniIGOz0NSJJxHRelMcsnX9086Xmy/Z6odQe/X0jRINWfMAOrLcN7WjPZ7q2otAbD
	 LnwTmWwx6ul/uMM3QTiOyb20T1FmLdZQew+mGjzxFcunZG3+seL4SrwyLG12KwHNBxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516487;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
	b=ktVPM0u/FC1eCzLpckzvHXlilKYe7Oc3Y4HWR+/NBd+4SC6uKdpxbSNa6BP/Ya0XzJbT
	 Rrm0l8MEhtLOuUb3CC5D6K0kVVlP2pz9n1nZWdA54LwZyopb0b+nK5klqGMJJf+3cFBml
	 JRjtzlO6246sPVPNS3t/07Irvv3n1aOC3iK+3NDRjhSc02X/DHrY210eAz5UcZPE5veo9
	 yZZ4toGQ/yJQagKWeClcsSy3Z7R+4sC6kGW+1iSZhtFVGZjFJaQRWtGV4eeT5O7LwNHBX
	 Rv18itNgQNI4W9AGoVHUvY7fChyBnctgV1Oiu3p6DXzRfK5yoO/Yfo0OGmiHRpMBjhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="cWQ9MB/S";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBD606B310
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 20:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BBD606B310
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cWQ9MB/S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794516485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
	b=cWQ9MB/SEV27c61OtK0XDaZhXEyPRk9nvugbvwcyhPM/lTzPwqGXApHVKcoYQ3HTkdkBDy
	EyM429DPAKfjzq+8yWSO9I7z3cDfnoKEUh0Dh3i25uRqXFA/9XF/6gNQdbk0lj4pH7Q9Jh
	heXh81knuYiSFewT3wdrfpJRqpvmsMw=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-9VgpCOcxMgebifEoUH2r_g-1; Thu, 12 Nov 2026 15:48:02 -0500
X-MC-Unique: 9VgpCOcxMgebifEoUH2r_g-1
X-Mimecast-MFC-AGG-ID: 9VgpCOcxMgebifEoUH2r_g_1794516481
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-45952ce9ee0so347446fac.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 12:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516481; x=1795121281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
        b=2KS6OFGA3tDusyIDweqlxsmUjnBC7U7s52xLPZhiOpLCtWwnNk+5mjOq4/aIwPm1rO
         5uILQsoYhSFBRYot/0IwUP+hwwk7J8iTYYiQv0qlsTdLnrMRJi8kHFP2djx2Bfb+xr5z
         ABrug7WKu+ylZJwY/oqbGpSRnOR+ud8IunVrWQZSl/gcLHO1N8PzU3/Zqn0qsZ5skFuV
         y1497IZtfvA0lsDB5kgZ1cwMeUZgEN4PwUPc8Z0M9dYFLZ99jiwNYLIGWetZKxg96Mw3
         fta+Z0COjCjz8cVXWeu6bH4zX1hrDAyMW6p4u6ojPsM3XDtvMQ2tLlcdqaClDu9roDkG
         pbAg==
X-Forwarded-Encrypted: i=1; AL+hErERfyMgVBUg3FtzwbXkEoARI0frcUBLGq7Sed9gq9C2uhckdy7zeOWyoUVhe6a1TseZ/AUO80KD3GvHTy73yw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+l6AWvbiE9EU3RNsYMNU2NUNISaJdH785dGU8id1oVf+vnxICS
	qmvQRv9giO/U6LANZHn6hUrLZlLh4UIUVUjPRuOAN/rtMMCc+bZpy8p3seiZ2XReBtESn00cgRT
	2KQZM8fUJMjwZb011kryztwyU+GgO3OFqZw3StfnLcDUDmeZbs5YxVBI41Z5ehyrQXXj5
X-Gm-Gg: AYBFou0so8I8jf83AbE3xBOzOuBltYOA9eBvaBO1lespKEz//WoDEtZacoUN2ixGl1j
	nQ7+09dGl9bILIDhXEf9XhgHL+pJnjFzpCb2LQA/MWH403xH4c8xdCW2tqWcq0G39dKM74mYvbz
	2MBdLFG9xsPuYv9msR9f9u55POWgOEgHpzlvn50THqmhWWLzglceqxu2bO/99sfwYOTtLw70PVc
	RYpJtur+GUjlMsUAw/Al3RA3VR8Q24BugrD4/FnFw8026Kznk/3s+SgP5jmui2BW/wp+XYy6wNj
	ZOA16KzrjzBP47G4a8ypC/+kidVXlphk98YsZi+yun/pHTNgC2okwY9fHV+QO1QPMw/MY4dQ+Hf
	7tHzvj0g+gim53sUM86eL9XcjGX3wgs4cuBY1Zv/CiKe6Gf/Gaa5w
X-Received: by 2002:a05:6871:7b0a:b0:49d:ff8c:205e with SMTP id 586e51a60fabf-4afdf2da638mr911061fac.29.1794516481391;
        Thu, 12 Nov 2026 12:48:01 -0800 (PST)
X-Received: by 2002:a05:6871:7b0a:b0:49d:ff8c:205e with SMTP id 586e51a60fabf-4afdf2da638mr911021fac.29.1794516480871;
        Thu, 12 Nov 2026 12:48:00 -0800 (PST)
Received: from sgarzare-redhat ([69.196.88.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813465esm686251a34.16.2026.11.12.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:48:00 -0800 (PST)
Date: Thu, 12 Nov 2026 21:47:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
Message-ID: <avYllBVgJg2AHYc0@sgarzare-redhat>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
 <avXyzxvIN3ngFepE@sgarzare-redhat>
 <179451283622.7.13355395779239029915.1767743913@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <179451283622.7.13355395779239029915.1767743913@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NcJCQauo3SOGCBAdPuOhZS7D49e6G3kD-UCmexzrtao_1794516481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 12, 2026 at 07:47:11PM +0000, jrmmhm.kernel@eldare.de wrote:
>On Thu, Nov 12, 2026 at 06:23:00PM +0100, Stefano Garzarella wrote:
>>On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay
>>wrote:
>>>The loop
>>>and the zero-length check belong to the fix (without them the reader
>>>returns early or spins with the lock held), so this is one patch;
>>
>>I don't understand why that fix can't be in a fist patch of the
>>series...
>>
>>>+    if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>>>+        return __vsock_recvmsg(sk, msg, len, flags);
>>
>>... I mean, why this change ^^^ can't be in patch 1/2?
>>
>>BTW I'm not asking to split it (at least for now).
>
>It can: the loop is needed for the deadlock fix, since without it the
>reader returns -EAGAIN early when it wakes without data, but the early
>return isn't. A zero-length read with data in the psock queue already
>spins with the lock held on net, and as far as I can tell from the code
>the early return alone fixes that, plus the MSG_OOB and MSG_ERRQUEUE
>cases. In v4 those reads were patch 2/2. They went into one patch only
>because Alexei's diff replaced both, and my v5 sentence justified that
>badly. You said you're not asking for a split, but since the early
>return isn't needed for the deadlock, it would fit as its own patch:
>should v6 have it as 1/2 and the lock change as 2/2, or stay one patch?

Yeah, I'd prefer 2 patches with this change as first patch.

>
>>I saw some comments from sashiko, can you reply to them?
>
>I'll wait for your answer before sending v6, and I'm replying to the
>Sashiko comments separately.

Great, thanks for that!

Stefano

