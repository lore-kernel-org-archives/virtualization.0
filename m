Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE1146D6B
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087866; cv=none; b=doBtnhwh1CuHEcdObJJf+pJaggEyzm5FuAEEJC+O7YqQN0/ACiP49AyWs7xkLXeqYPmt5rFYzJpKNFz/idIUuETQMtRWyUTN/pRYQu8o1pbyjl2lTxIxha6I8Hx/ZI7hO2UyY6s227sZQ6ORxmXia5KJJqgvrFNoY7LfJuyPMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087866; c=relaxed/simple;
	bh=a5oRJlbBotinSuMy99KojZXXzAe92iglLoo21PHtORs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpE9egIEQPmN5+IgLE7UZps0RO+di3BoD/mZhHfJfhp8/oWWMx6eDmJI+suLjI+l2cSR+taB5s6fYlzsSD/b4U5/kSe43toREtlGDBl0dFW9OeB6va8/cWfwXSADVJXpX3hn5Hdqcl9FRo7CYdAxIgUIK3z1IZt35zRpm+DWhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f3XgyEmO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f3XgyEmO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42803bbf842so50545925e9.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724087863; x=1724692663; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TriEGbDPnDr6fTG2pfpr+71ha1M8t+nNaZGWcDeVPk=;
        b=f3XgyEmO/Pvu6fgEhs8ZieMDpRkwhcPnCsvz2h8V+ChkBLWUM1VcbBEeuOzsaiSq1J
         2cba/XkzZjbFRTN0b/Ln8umU9OyGs3u9lkw6uzOKc6nDn7hiLQ7tU2dTxb4vm5xD40c6
         wit485FH7N9fAs2ehZ4l56yGaeCXtjuKrBfUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087863; x=1724692663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TriEGbDPnDr6fTG2pfpr+71ha1M8t+nNaZGWcDeVPk=;
        b=BxdOd1rp5ll+czp8C/CnVo8doAqKYIuT4aB+VSpV/WDmf+LRBMWATJKbAfa5vV4LYw
         LGuQa8wmf+pCJMjadH8+k9cuUfA1sUzEaEC7urN9i/1YsB9PYPR7oF9nxo85yR1xNO84
         5GOBWCI+gcEbQJDVLW1PRDKwVLVRWJvjvsUeKL7V65qQfkW5Ij5UbF1N+wLTqOWEeHHf
         xgTXiFFlePKr1VIU8VErZYOB2D0ViWJFLG7Noot5/aFl6PgvadexvmeuXijy73MvB7ta
         cHIqhD9po0GR4YRbhBBMSlco1lXOlEdsjWwEAtez/BsiO1MOEwyWduN//rHm2td4pzS8
         jmpg==
X-Forwarded-Encrypted: i=1; AJvYcCWAVA5MJiv7WPkK9Pe8Mi1rBhxg1PcZwQyQh4knw27cfcaAiED7vBQiu7/4wNvZ0L+vjnaFoAs45QqYGJc0pybaDzPs4N35LLlOdN2R1zc=
X-Gm-Message-State: AOJu0YxdI0RGrMgBkisNzTDlZwf5+jMPImmXQCZo9p8rthRPDi2vBd94
	qEYUUUYwZmTiACy2C6IZDAmMcw6f4de5EZGagi2y4doSmlIXnjw16omWU5KBDy/zh5lRXsoLAnG
	x8n8Ldw==
X-Google-Smtp-Source: AGHT+IEbN+ZQ3S0F0gzLDpDMZ6zhXehyp3LZshe/ffjnA5FM7iTskWXWGKsv1BxAYIzRkJIh5Oy21w==
X-Received: by 2002:a5d:4fd1:0:b0:368:420c:74ab with SMTP id ffacd0b85a97d-3719464c2eemr10190616f8f.28.1724087862443;
        Mon, 19 Aug 2024 10:17:42 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6a0csm657754066b.22.2024.08.19.10.17.40
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:17:41 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2b1e1so1199359a12.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:17:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0mLKsS6dIY2RPsWyENCzynDI5CEfpOix5Cm6HKbBczJeSwSRRpVME5jiPDSUSUtHcuJhLtZcncFfo0wsjoSjesiOiAOuJx35c+RtBGAg=
X-Received: by 2002:a05:6402:1e90:b0:5be:eb9b:b703 with SMTP id
 4fb4d7f45d1cf-5beeb9bb98fmr5392382a12.2.1724087860673; Mon, 19 Aug 2024
 10:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com> <CAGsJ_4zWNgA1OZJ-iAa4KhDY9TuGb2vji4=FJ=Vn7ve5uF6XzQ@mail.gmail.com>
 <5424dfa3-03db-4a82-a08e-fb31285774b3@redhat.com> <ZsN9Eo8HWdEgqpf3@tiehlicka>
In-Reply-To: <ZsN9Eo8HWdEgqpf3@tiehlicka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 10:17:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaV+jNdKh26ZEkzRcpbxQCzZbPMsWn1+AM-tCxc6s44w@mail.gmail.com>
Message-ID: <CAHk-=wjaV+jNdKh26ZEkzRcpbxQCzZbPMsWn1+AM-tCxc6s44w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 10:12, Michal Hocko <mhocko@suse.com> wrote:
>
> Whether to BUG_ON or simply loop for ever in the allocator if somebody
> requests non-sleeping NOFAIL allocation is a different story.

Just return NULL.

The bug isn't in the VM. It's in the caller. Don't take on other
peoples problems.

It was never valid to say "I want to allocate lots of memory and you
can't fail".

Don't validate that kind of bogus behavior, just tell them "you're
bad" and return NULL.

            Linus
