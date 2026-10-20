Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479123;
	b=id0zVLveCgYHErC5zpLrXNwjGBjXBmzZBpCG+Z5mU93Rao9dmwalR5NJkXrWLizri9Vk
	 vGc4+zjuVB8VGZouSXOOL4t0yOOh/chGVfgUiVEbwF1AFIb/ViOcUqNvEtUayGWmWFaJb
	 vYc1mwz71Xom53ol31fxnNr6ohIqi3EMaSAy04IlSi+WPLpY4igafJz/8kAfullElBtb7
	 I80wir3JCqrYNOb7rwt4Ih36x2KSDz7jQHpVg4ndDypXtdkDy2i/lwLgK2zK/iONEDOQg
	 KFMiRT3EmC0A+s2YW+ALYAz+HfzVhwwE7HsfwuqU+cdBpq31De5Bh0z9JaUaAHzGqJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
	b=wCODTU8OC2F2JgFempTQyBkUyti5Y9EnKVVMdA458DkmgB3aMObw4sn6h/vRS5Qv+K71
	 VGtSRddlc4Df33IWK/EmJQgw/S+2SvDeDu3F6BzNyiP6pCGtx1x2Db5hU2G+hF8qU7t2Q
	 c2Sii3YnlZAIc/kSCzaLduhtX6sjKd4tVMr6jU8ZkDtb9pYnZG2Of0H5FE1/7fQ9uC+a1
	 dGsTBqN39RdNcKgAFwk42h7ow4P85zRLG9JsTbBqJh3J8v8loeb31tRKoEOtJiycCZofW
	 Al6BbQBB1W8AoJ8QihglxLbn7U6bwsQrjhDr67Q6DL7qBL5epFqgqRWpJkWA2KgT2Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=PBqmoPfb;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784C606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 06:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9784C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=PBqmoPfb
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso4857564a12.3
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792479121; x=1793083921; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
        b=PBqmoPfbgMu5Qfqa89zKT811okX30OGznTFUAx/yEQ1kjkx3GkBKbwSpwvtryRQxrj
         54bELCznnZQQMOnmcQYGM9RqDQ/9XvHr9i8pNqT0kkwqOC9N2U/TpdAdgSjeVd1R46WC
         1tcoeaZuzz4YegGKhawwURd77KvpM4NlaZHzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479121; x=1793083921;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oDF42rmnmkhzedotr2E1sl7hiMAx0kNtO/q61gkgaPI=;
        b=O7xfC46ILdoljQ+8AZd3IFG6lAtNAGZJ4NikMo0osduy2aVEzNSaUJ6Pe8n5WUwJW9
         r2PEnGKj9uKlKpfHCUL5L1KP1bxNOHvAW/0KRgnKxYWMsYfD52CaU3k3wF2X/MLSaBfB
         3WMRQ0WeMLFlUYD/sjSJSvHoPKDul4VULpyWhiouKI+fGOfqJV6GDQc1bNjEKyRAk/Y4
         Nw04YOQCCnvn1PjvExbbGXgsz60Q5gZtFpCexHo0Z+kswafxUQncnv/AuBccTtRlRALs
         4SbbihjzWFEaFIzZI7JOotEYGLF3hltqWih80kJQc0zyiuPXFTV+8fR4dBWvyPe7av8C
         ILfg==
X-Forwarded-Encrypted: i=1; AKwUvByqgkKJet23Je0NVW3F90f1/PrKubNuw3p6+M+/gU6Epx9IjAaWPqIryZ8+67FcD4CbqaxF9Zv21eoj/xzHmg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJwuuy9N4Upu1mre+fodfRVkNbOTlUEHmlB8oPztWL1W2lEN7B
	HTdWRdYGwuyZLPJ3u/LpXHSHOlntHsEIMdGXeaTxzY6CbbQgJf2Cc/qLltA8WK0ccHCDlws/+wQ
	rp+Vtg9k=
X-Gm-Gg: AYBFou3qOUTsYug+imxnXN489TbO1syr6raXrNtVowkzoV9ZBNM36JEAFQC8G+ItO16
	UO++FFQ4DyX7p+6TCvBNadIvjfoJjfnkC2/ijtnHG270vfS+LctwLXs0M6h0ZLRGCjOHtR1uihI
	3igb1YeAJcZwGpl0TJSBompbHoOcySUQKiAITYe3dEnV9+NFm0cyHBOmm6gg6ixFhObD6CteL1y
	CUrdIdFBqQ7xXrEXFz7FOxbZ82G0jP0wsVA5FRx20g29YuuRcti7MEX+2MruWO69bwG+P5XvXyv
	ZVkK+HavHVNHKrBid2K3rpmrvq3fOdTG/pN+ZQimkeCqoUN6l2WIrFPPKcOdSpQSYfer0dtVkNb
	8kyqV6YjFNhuiX/xiTxPAEhTuF2QDemniMdhdi1ucB3oc9e8MmP74mXkC3kMXLq9gCjcxdua/vD
	ToVzisJqWZNlQgNJtJ2Zer3EWwwXnJ4Ns6aB9+0X/SxDRbRocbYbDoMop7diGwhO7Rr8e8h3rJt
	Mo0swdR5HqksU5e5/JQQGQWqL4/ZU9odQbi3Wpgu9u9RuiaO5+RRJ67QiFGjQCsFeOXfc4/asAm
	9SmK/jNlS46h52pnRU3SJzQGC5qsxBjpjWzlL2S0w15eXGC64w==
X-Received: by 2002:a17:907:c48b:b0:c41:3e8b:8605 with SMTP id a640c23a62f3a-c41a08dfc69mr708109266b.43.1792479120783;
        Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32876asm458253466b.10.2026.10.19.23.52.00
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c43fbcb4393so255943666b.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 23:52:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZ4NybXxMtJQ+6P5tkVtpUWydX8bYz6cJ0UYZcOm1c37DLMScRugZWKFWidZFsnbL+auzjJQMo9MnKL5x+gg==@lists.linux.dev
X-Received: by 2002:a17:906:dc8d:b0:c46:645f:cedd with SMTP id
 a640c23a62f3a-c46645fd0e1mr41541566b.8.1792479120078; Mon, 19 Oct 2026
 23:52:00 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020021924-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 19 Oct 2026 20:51:43 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Gm-Features: AclHuK8XyMOfalc2h8xLYAwuI7OOaq7eZ0Xa-sCHFlL0Wx6hRPrX61Uqe-VGGwI
Message-ID: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following seems to work for me. Testing would be appreciated.

I have a whole branch that removes __get_user() and __put_user() entirely.

Somebody should check that I did it right. But I didn't want to do the
pagefault_disable() around the vringh_notify() part, so it's not quite
the same as yours.

Let me just push it out. I was going to let it simmer, but your email
made me go "I should just let more people look at it".

Mind taking a look at the 'uaccess-cleanups' branch?

It builds for me. That's all the testing it has gotten so far. Blush.

                   Linus
