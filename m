Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1115DBC1
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105660; cv=none; b=dvblY5UsIxKw4tkRtz12K08lasWwiDnZEtNxUUh/wlfG8AVMAqE3DwL4FmpK2sOj1ewhSx5BOuOrbZY5E2XDdJXZ0pAvsmiHrUhHablXbDGcYSTwcLgyAKHBywMTYOwcnSgTO2bP8kHBUZWu9n/e6C1wCgN8SLCmrMpO7pA8LVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105660; c=relaxed/simple;
	bh=0SiC4utX1MHiQrLdEyTHG+P7hibYw/QjzBAqGCqkidw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeYfm7LldseOplSKDxld6eO4gqqFvS0r29+mvUJZutaLQyVbldqHIWiEVEQSv3yJyTjLTEwTQkRrBmULjJAPKampp3DJnDHNrGkt4Z0OLwDoyQLS1twH/fJdqqCK04cLi3ZSUfEXwaEkp1yH1BgZfBJ29uoqAHj724X2waicINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vmwcik0s; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vmwcik0s"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so6333907a12.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724105656; x=1724710456; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn6KHqgsFaMZe+qpmygMyW93e0XUrsZ0daru7qiw1Lk=;
        b=Vmwcik0sed0CcPZmF+xdtjWn9Zi2+/PkMiS99f28KpaxRP5H2BCMVb1XsisYrzD+Qo
         uCXrg6ewK9+/uil0bF+iR78kiQe1DduHHoLjqiD/oxv8GGqOwuVqnWF7fN8TsTd+S41o
         LiuZ1r61jmctv71xi+5KqdKVbTXhvNQ5Wnrxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724105656; x=1724710456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nn6KHqgsFaMZe+qpmygMyW93e0XUrsZ0daru7qiw1Lk=;
        b=h9DZXJFtp2smBhRQdkpSdki8UF2FB39m4DJDCHgKS0fbKKe72FUjfcm/0rF23VVUzR
         K46RnfoWBW7CvQV1+cLx61DL+V5Yv8y+3OjmBLHrO4qXfoAMhAYRzp5udEApr83Ff4VJ
         zrenuqmjfNodz93mE92h9kWQnL2Vgvcl5mKLarP3KhAKVLeS6FiK31eOGhv85eL2/bx1
         3oeZ+7eh9YlErZn4w3MhCSWdnnSjPKAwi/WhVHiwFscYDh+a25tZ85dvD6JfpT12xgx5
         dr0TcC6YeA+hUHxrDg70yvF8EK9iGR0VjZd/oXMxItoJsNqfRqDwvD+RRtzpP8WzNJVf
         k57w==
X-Forwarded-Encrypted: i=1; AJvYcCVnt9wIwRikVy+/YwBEXvFICtBJbZp0H2gDJKWcQuVQ+Rto0jGNoCLEiCzB040Kls7J5QoTeS2TOE6NjG4VRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjFCgjQIwtVJ78D/HBiLWsEmmPW+cNnkvKNAwduQ7SdMKF4+5o
	1Jur3NxI0MKnc6ZIOc6avYywGyRvTl7HtLehJockv/Heb1/qImsF5Y875mWMvEyLtCnmxrSbz5v
	lQgHTaw==
X-Google-Smtp-Source: AGHT+IH0vEtaVqkj7N+DougF7+ptR+Op3FwRjpvM5Pfw810e2TKSnuUYfTNe+53uXzF/eOSJk4LYZw==
X-Received: by 2002:a05:6402:348b:b0:5be:ea9c:5fce with SMTP id 4fb4d7f45d1cf-5beea9c614emr4449240a12.16.1724105655787;
        Mon, 19 Aug 2024 15:14:15 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081a19sm6028292a12.86.2024.08.19.15.14.14
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:14:14 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718706cf8aso3044043f8f.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 15:14:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAaCD3CEtNmPqO3QqPn6ZvlA99w4AGmIIldJu2V3fx01rT693E7Jpg/WmjjwANqb9ISBozy91kuEc48yMDEA==@lists.linux.dev
X-Received: by 2002:adf:f012:0:b0:368:71fc:abb7 with SMTP id
 ffacd0b85a97d-37194446b13mr7177410f8f.16.1724105654263; Mon, 19 Aug 2024
 15:14:14 -0700 (PDT)
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
 <a366907d-191f-471d-aa5a-fc8f3f88198b@redhat.com> <CAHk-=wgGLFV4mkNGwhpTMYrR2sVJVbnJ8RrfaHihDwtR+Z5O+Q@mail.gmail.com>
 <6814fdf6-cf32-43e9-ba20-705ec5238abe@redhat.com>
In-Reply-To: <6814fdf6-cf32-43e9-ba20-705ec5238abe@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 15:13:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCfwHQW7Uznx0=9HCJPjcS=Ljh1TPDLUF_d10o86mQ9A@mail.gmail.com>
Message-ID: <CAHk-=whCfwHQW7Uznx0=9HCJPjcS=Ljh1TPDLUF_d10o86mQ9A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 14:57, David Hildenbrand <david@redhat.com> wrote:
>
> On 19.08.24 22:35, Linus Torvalds wrote:
> >
> > Maybe. Or it might just lock up the machine.
>
> Yes, regarding the security concerns it might be a bit better that way.
> (no security expert, so I cannot judge ...)

The thing is, in a static universe where time does not flow, that might be true.

But in such a universe, we wouldn't actually be alive, much less do
kernel development.

In *REALITY*, security is not a single point in time. Real security is
about the *future* more than it is about anything else.

From a user perspective, security is very much about things like "keep
your system up-to-date", because we _know_ old systems have (known)
bugs.

But the other side of that is that from a developer perspective, the
#1 thing in security is about fixing bugs.

Yes, you want to be conservative so that bugs you haven't fixed yet
don't cause problems, but that "be conservative" absolutely *has* to
be priority #2.

Because no amount of conservatism is going to help you unless you
actively fix the bugs.

And the thing is, a locked-up machine is really really hard to debug.
I can tell you from experience just what the bug reports will look
like, but I think you can guess.

So locking up is one of the worst things you can do. You are pretty
much always much better off making forward progress and try to report
the issue.

Including for security reasons. Because you'd rather have a security
issue today that you can debug, and fix for tomorrow.

A dead machine with a bug you can't debug is not actually suddenly a
really secure machine. Because somebody will just figure out a way to
take advantage of *that* bug too indirectly.

Being able to kill machines at your leisure is a great way to stress
other parts of your network, and suddenly that dead machine might be a
big security hazard when somebody figures out a weakness elsewhere
("Oh, look, there's a bug in the fail-over that allows me to do X").

              Linus
