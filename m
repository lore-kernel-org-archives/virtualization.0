Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795586749;
	b=mi9hfQmYu9LAjDLDSsOh4aHuAEML19yku7V+LSiLHG17am6rnY46fm+LZrBg/XugtqC9
	 sLGSZ5wE1b8dw+qNnkccYQMib9axqkUuUuIrPP4kmvpV81JkHpBY337qvn8i/9fWTyT4i
	 aGowxrJtJqaZxXwmrxeRZrefEiOA9Z5oM5MTpsDGNdqWOyKsmLRrhHTeew8KltKNHYSvZ
	 mgGabBeTkEICRYHC7JxAfq6SK3djQ5LHhFsAyuxJF3zZLjN+P7D6gV5Z3cwEaR9ZUFsbm
	 nmjEx55EATQ/HCQUCgaYNGZnt0sHIsEVm/o2e09+pRQp7FI5G67/WevD297dM655ZbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586749;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
	b=k66swoTXmfwHT56zATQ8BqbffsDKe+CkUbO3kOcJRYgBlsecl6MeS/KkL4TIlu2NIK7P
	 q8hjF4IGQwYSgZ63tUvtXRFEbbTuX8Z9wsNNObzSXXS63kw2lrp+OGenIRIba+uwwR7r6
	 esHeE8c/41LaxvYbd2n47PU6oQpDSH75LdF9o66IpgY6LLUJeTiaOj7Kbv3Y9emkdoUgg
	 KT8NFQtx7eHYnCv8Czf1CdbQImScjuGvvaiVNjnOY+C8wJulOOh1b0oQDestSb3UgUdR4
	 aXlU6bRD8/Qxf8Q9JpLV8yNT7pCpR40CSfRoMEJgNrOQxd8FCt3I/O0M2AIjRzaXlIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiQH7oa8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.137
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381A606A336
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiQH7oa8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14491405A1
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 06:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.348
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Xrz0tgDl6LC for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2026 06:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C6D04059E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795586748;
	b=mCcixlGFZ9Vg3CV3mpI6nI7SIGt4zoLev2RoYei36GtbnzPH8JT4ZE0sMs7Fm+wvR+U4
	 Xf1i5u8wFO4jSDpOQ+8L9OXUepx0OL8NhltHSo9JsD+8ODm51Vw1OqQGVc3N8prJverbk
	 6KCm18UQhapLBkf2B71PS+u4/ji4s2EmHHFMarCA1G4SnGbrcMnFSt4iplyel/jjG6oXO
	 sElcgZhK5VMMz7zEVNdVR5wZuR7b5j/X+R5htUWLTZOEF03Hh0R93/Zm57mY/XjygHO+S
	 dcXZaeC9n+NvC82qxVBNhHq+3tN7rC9wmsuMPu8xqDbRVv7y+Cs1xA/SLCv+g3VMtjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795586748;
	h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
	b=kxOiwpP4h2fMJ1gLgMS2OnokdtZXibVCizouHwmr92tAa8Bog/r1FhCTrWBIR14u6396
	 w7EmlkyiUGj7+882vy7a9fMQY73Gm9aX/X+VpnNjUS7VxEyPxJi9Qvol/yMCb5BPSypCu
	 RrOZR+fEL8UB0N5M6xO6hQxIMfQ1TQVqmZ4v1sZ5cuxRltdbjZTH8MaNZd22o+SqM5qDl
	 ZxqPuXmdWYTKaezRswU8rsJI90pNz60StlGdBnfnJIM+HOJE2v8ibTsxc7Kui1MqGjwOW
	 3RKKVpuf0MwvwRi1ix/h2/FdvlplG2esJMv6P/X9WyE5d9S7CniEfRXg7dHpEz4tS5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiQH7oa8;
	arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=longpareto@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiQH7oa8
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C6D04059E
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 06:05:47 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-38644aedba1so8252120eec.0
        for <virtualization@lists.linux-foundation.org>; Tue, 24 Nov 2026 22:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586747; x=1796191547; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
        b=TiQH7oa8A+X1ELpf/WU2K3WKThb9XKMbKYD/f9wjhrssElLgM6rK8ii9wNHzjdlZoL
         M00LTD3vHeUOzwrKs0EELXBekkN8Nzkyzneu6T6my/tcAryHZb6awvGppkV9cjzeSbwR
         XoH4e2Usmn4Q8obUxe3n3HZ3QPsDlWNatPPcO0LPmzDNyzxz18FcJJLgZeO1YUaf2KQ1
         W4+Fl+ThLRX/iF5d7ZoA4YLhhym3LJnaCtP3lGhLlT18fS9WZwx4290jCBiv9abfxkWe
         pIGwynCZ2HLmBpx3cJ3G7J0gXn5DSC0rDBuStzyQtAi2jdep/4RPFwLrrbI+wp6PjpMt
         7qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586747; x=1796191547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvWUvSzQGWdU0amQGudBjE2MMEoWKQd9zyN2yG8Iybk=;
        b=BjkBZX2LU/3LA5dpP6mOdh73PQeGIoAjqlYXC9YjX8DzT9mK/KFtonRUhQrDpFRHUs
         26HnuPRve0EclqRQFLfkKUQoP6r5pK9WftNtxxIsTwQQ/pEPKJ06FYdsp9ZnTHUqIm56
         Gl35MnNaYpFHDWaf3ffNYb222ENqnEUR4OwI0siHa/4SzorWZuc3Bn7WRFA39+jIyEfQ
         VW7FzaQzIXfoB7mFwrFJsu1NKZ/Ho75+K84gKE1Tor8qtliZq6W+YI/oi06N0CBOVD1O
         gJ4XyjoP5NUBhHZqlu2pZsUmNKnYnYjaHJAHbizx7tjapwwBk6RWiQ2TR+3guC1cii5j
         4Ajg==
X-Forwarded-Encrypted: i=1; AL+hErGbNCrM0U3C3osqFHTvCsjNBui0w1zK8XIaoqpAD1GpTbvDgtESdAY+q/AwH1plhdGC8hyi8icEPsWPQTzwEg==@lists.linux-foundation.org
X-Gm-Message-State: APuU4Z91wpDaawhGDfuvf2uZXvrC6zgeueRhcbHBFS/lg31nUw2+Eqf6
	141OLfKs5QlPWxgHNHA5wtcQzieDvUPGPG+YY0uF7hSoDooJYYsE5xIM
X-Gm-Gg: AZFdTZcqnBJGlf7pvr1VkwyvvWd2QIqbo/MGFDhjOPL2+A69RlbNO+0GlmrCArgZ8Jg
	mEdtS95UHipHU4vVU7akaUUbH8QzrFVLpGccLAt+meb62mzDl1hgfVgq6FvueJ5+92BmvIJBOlH
	5cSSzeqdCO9h5TRlBCNM4CQzfSchoxPbvAGuLn6ZOU/SaxIeJ31w7ywrtYhsrFp1wIsNOhi9JZ4
	FwEeMrBE8Q2eqZ3VZA8IoZ1do0Bvgo6ra9NPYR4Gr7IdZdOFeCWMI8qQVMcIhVc00dkITOezs6h
	ymckm0ff5UPJyn3iISaBZCAFSdproMlBwfm6c+RDny2zj56uLOsXYOwUv0WNrVPtDmcPtEw2qP8
	LriI9EkhfAPddNkDjzcJvuFTNwhF1hGBZUZznpVmKk8+gmQBf9wVGk5gTlm5c4f27SXm1YO8HdD
	V7onE/1zNxhmPjXppEl3uvsw5Rv75rEfGyxtqdhjh1DBXI3iscMt2KSOM6UikY+2t3On4Hk/k8q
	+gAnxA0J2ttAm5fQp9iflsFiHVtYlwtCT2q3zj6CTCtc6ZEez7Ug25+eTMGjhlSzRwiM//+D+qh
	VFxPgMgct9DIJUym9ZmvMIrW35h2TQnj985cLdKfMGW5PFRivPeZ8KS7DQngQ3w1cax7jgFpdpf
	r
X-Received: by 2002:a05:693c:8948:20b0:386:b08e:4b7b with SMTP id 5a478bee46e88-386b08e4e93mr8414503eec.29.1795586747002;
        Tue, 24 Nov 2026 22:05:47 -0800 (PST)
Received: from O1PCCC03033100.cn.corp.seagroup.com ([143.92.127.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm57080152eec.26.2026.11.24.22.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:05:46 -0800 (PST)
From: "chenglong.ma" <longpareto@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	2312891301@qq.com,
	blum@kernel.org,
	co+6dcbccedc9ec6452@bugs.sh,
	eperezma@redhat.com,
	fangxy@xiaopeng.com,
	jasowangio@gmail.com,
	kmehltretter@gmail.com,
	linfeng.sun.dev@gmail.com,
	lirongqing@baidu.com,
	oss.patchbox@gmail.com,
	p@1g4.org,
	phx0fer@gmail.com,
	physicalmtea@gmail.com,
	sergiiushakov@google.com,
	shubham@octane.security,
	stable@vger.kernel.org,
	stjepan.poljak@gmail.com,
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com,
	tavhadia@gmail.com,
	tjdqudcks0424@naver.com,
	tz2294@columbia.edu,
	xieyongji@bytedance.com,
	xmei5@asu.edu,
	yuz08559@gmail.com,
	zenghui.yu@linux.dev,
	zhaimingbing@cmss.chinamobile.com,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Date: Wed, 25 Nov 2026 14:05:32 +0800
Message-ID: <20261125060533.1296-1-longpareto@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <awWOpS3HR_2FTN3I@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org> <awWOpS3HR_2FTN3I@gremlin>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 01:51:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> It looks like it doesn't need VM_IO anyway, the other changes in the patch
> make it redundant AFAICT, so you should send something like the below with
> a Fixes pointing at bb2e6f166547:

Sorry about that: it went to security@kernel.org (hence no lore thread),
I did not test it on 7.4-rc, and you're right that VM_IO is redundant,
since vduse_domain_set_map() is the only way vhost-vdpa entries reach
the domain iotlb and it already rejects anything backed by the domain
file.

I'll send the one-liner with Fixes: bb2e6f166547 and your Reported-by
and Suggested-by once I have actually run it on current mainline.

Thanks for catching this.
