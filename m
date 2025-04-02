Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FC1F418E
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628550; cv=none; b=qB0ZoG4llQFFF0LGeWxfP5XIjPfnv5YfkLe+n7LsPMo6B21vmfiaLAO7yObmiQ+iyzEZx18Yk0Kk6UufSeP7ySwbyEhOiD8VNFKwNFN9YHcxOBueTWP5bBq5MzQoNNuIEpDMPwgae4R/cyMFVKbfo+3ilK+1Ql3Uv5tQWxwZPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628550; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5lM8xogzeW4n0nRgNF6ndk+WnSCNENZIzkcJRODHcgdk8cJzJoXkp6pJkmoomVFpiTNK60VUb5hf8HzOjoOsT3c2ZVQqRCZaWoN0lYibo6zhEuE2xbOOhwbJSg+VvU16uGvU6Hu0Pb7Li/SUP3k4NcDuRkoksElzHtmOcmcLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UejUibxB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UejUibxB"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac298c8fa50so36539666b.1
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628546; x=1744233346; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=UejUibxBdcjFyU50nYgIYoW94+6o1oraDYBpdsNZX+57aLAH39neIVv2XALmYmW10v
         h0m0NTRUfNUgE+8eJTTBlkIQbTOj0KPhJ26vNdi661td+AA3mHfg1WRjoWU869kMohxk
         1xJdYe6A4wyJ/EoDQT/D6rW26At6W7OIaPtP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628546; x=1744233346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=MeULnVeRXhYdbhBCNG9bRAmG9g4qy5xI+WRDbJtbBttNH8IFxfF4B7JOe8+JYwyxpI
         kUUkOuM1wZTaiRSlhcGoBnQCj1W7ZKK0fzczqPuQjHHrqUEuP2Dgxawetet6rZt1h0UD
         Q+jQRinrRrc/f/fetRdBvLdaJc2ehKcs7FWc9Y28BUYKe2evi9Gm0nYXtdyrN+2vSaRp
         8+u+/quIbT+01ixlMXkZECAqLmRkSYU24RpMQjz0bhktU0gOvWM+zpHzYAKcRCAi/AMj
         7KOAnLIc6E/5SdvimaJGUSDWWe9f+aBn1MntSR6OiYbDuTXVCKh4IoHAL2IWfWlAGKbS
         WX+g==
X-Forwarded-Encrypted: i=1; AJvYcCVyfGxLZMeyEexEN0gSXLAGa/RH0gBTGPOjI2gcE0Dq1ZNF6caEwjQQKdr/xtvOgGNGIwuO75OAfTUrlpmxGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkJzG+Byk4xzfP0Qf62bbCzkE6+1X9zKHAT+KTu3SRnK8nREwS
	q4Y9f5Wvf+rkD2DKA93kKcGfmlq21G60pbnztQ92879vw2epL8bncPtao6OwuD/zw52Xf7ztbEd
	dgd129g==
X-Gm-Gg: ASbGncsrHmGAbBNFxw0qAeZOHEMNAyiyvo805RjEzjw9svsDywwDjT/jV7b5TNllSBk
	54C3Cga0SJcGsNPfhKb4T1UdrbJcklR2MGRwM1iOIhTR8yRxdWrlP3qVVpAX5GR/8dHRpzta2Hp
	TM72L/ahF6lS3eUkqhlqEfqle+RIje2gtbEMPcLBmysa3krvQHP0ZqSEcoh4+lqhQQYMQA8GuEX
	77hZN8sGpoF1ynA8YPRdZrWqTSfDlML/J1T+3RAnDhszXkC5n1/Tl2KMetj05gGVGGsRrPpoWT/
	S+NLEkIhvqVheKyr/xpM7YunqqQ4lXDZ/J4DUx7tk+LKOKgCG9LD9R1BL/pcau5+VrSaFi32eID
	ZHdAKfXjyRly2Etpe9Zs=
X-Google-Smtp-Source: AGHT+IFWLhSr4/8TYqJJ4neUiMV8lpDMLy3OUmPse6bhk2WPaPi0GF/c0uiLkXpxA3I9wk+Ki654tg==
X-Received: by 2002:a17:907:6d0e:b0:aae:e52f:3d36 with SMTP id a640c23a62f3a-ac7bc03c034mr20104366b.6.1743628546589;
        Wed, 02 Apr 2025 14:15:46 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f0cfsm962491366b.116.2025.04.02.14.15.46
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:15:46 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf3d64849dso28004366b.3
        for <virtualization@lists.linux.dev>; Wed, 02 Apr 2025 14:15:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmqdLg/OzI/lf+BrSzzd2tSdBRT8QgU6TOVDOtzRS1/jQqHT50xfTThi2+SlIZg1D7FbifztfIhvkWI7PtPA==@lists.linux.dev
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus
