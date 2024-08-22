Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872F175D5F
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320288; cv=none; b=fmn/M4AB0hTXUE0WX+x/UxYZaSfxtHbPGJEErp/Za8riUm5nJeytqgHam/a4Mz+0cTSfs8PcP8/mbMnTTbZPTCZ0IeBi89dY5SKaCB0IZXki8AmH//XW1HUvChLzMWyfuwsHpO29/5HxVZrNR4jbQ9+R23UFe8AeboVzswRUFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320288; c=relaxed/simple;
	bh=zyKRzY/SvnlOkDVZZtodP9QR5B7gWKm+fpX090TNVtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWsT9o2RxWkPjYQQmMJvxFf922pM8Fgo5HRepUGsu0zQzy0Y7vEt3+4vJNkuo/WUI6u0+LWDWxxrdbb8zZwNx6UPM25aVBYEYpacSpyp31B3svNfME7FGjkidYaJOQNPyKWA2UCnYa6uHXE9No+bpLaQmTooswUibq6H9i/VRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VnsUTX3s; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VnsUTX3s"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8677ae5a35so75235366b.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724320285; x=1724925085; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uWXamfb9PmO8IqynHQ6je4u3jkpRRtgsSbtDZ+0taSc=;
        b=VnsUTX3sTkhN3WrtpeTUFgaNU5+EE+byieDQO7uE2/dfYp9lMTga2WjTwn9p6/8rr3
         rC6Fd6qvPBZVnu/b8wq/ULkkvlGcKnyFE6chmxh41xxQQsSEQqTUlJieFjjs+/VGIEkX
         zxyPwtOXIndQ3LAJ0XDLfC6IPU3Ejn0wTl6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320285; x=1724925085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWXamfb9PmO8IqynHQ6je4u3jkpRRtgsSbtDZ+0taSc=;
        b=I4X9BVgqijT6D+LPZlP9dSUE3NfKGFfYAANitk1Vlc7w7yLoiO6pk0fNv/y0vp0oDR
         MvXGygeQD9Fmy129guKCV1vZwqG6pV9GRkQsjZy25LYyPXAQ/3t7kF3CgcDsEs1C7cuc
         9/WrxGFpB4l9FJU9eoPjRL1JQ9WCdKvxwmnwOiHJdFy9DZNj1eJD6ae8rRaZfVxs+wCW
         vRvLDupp7KXLaPDX0D8lVzcnK0w8D7uINJbAhZ2eGnAc2sIpj5QWgTRlkzvn00gA87xN
         LJSgGG/ZjLqQSHBz4FH1CR6SpkG+AvutQhcYsDMFfSLMYJAwmhWFNYV7rbdfhaTHytTp
         mT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9P8MJc37UUha87m+aC4FtfVi1YWltrQppij4jgo1RiWknUOe9A4dN40A8eDzZv3rTtH/AriFwem3vY6JTyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkA1mMdLpzH3yblrwZiIlqhjh3z724GDM8hdLjnrNaV+XrTbH8
	5uXV2dG6CN+BsGrTSnJM3RNVQ8i4Gs/MywyjhGZSwm/EVrCge1wtPWYYb4XtXqUHKiwmAtH+gfy
	w663tlA==
X-Google-Smtp-Source: AGHT+IGdIPI7IOmzSjS3RbAq8nWVsjhMaf1l8P4I72ZFOjmAZnIB+F9j1TDtHaOhRp4zfYugsLJ+fw==
X-Received: by 2002:a17:907:9308:b0:a7a:9ece:ea5f with SMTP id a640c23a62f3a-a866f44c3demr433884766b.41.1724320284313;
        Thu, 22 Aug 2024 02:51:24 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47d1dfsm94958566b.149.2024.08.22.02.51.23
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:51:24 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3717de33d58so294982f8f.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:51:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7pEnx+7E6nz3nco5Ggh4y6X1rciEI99v8MMqWKKoUkrEIOUS5mQey23iyLugYB1pZ42TGNK3PSH3UK+ZCKw==@lists.linux.dev
X-Received: by 2002:a05:6402:5243:b0:5a1:83c4:c5a8 with SMTP id
 4fb4d7f45d1cf-5bf1f0d5b41mr2904696a12.14.1724319879729; Thu, 22 Aug 2024
 02:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka> <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka> <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka> <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>
 <ZscF4SQzxKv9evmR@tiehlicka>
In-Reply-To: <ZscF4SQzxKv9evmR@tiehlicka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 17:44:22 +0800
X-Gmail-Original-Message-ID: <CAHk-=wh-pXKU_+EPMLgdaK62s8Zp3zhcCBtYLDR=LUQqWAUHNw@mail.gmail.com>
Message-ID: <CAHk-=wh-pXKU_+EPMLgdaK62s8Zp3zhcCBtYLDR=LUQqWAUHNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:33, Michal Hocko <mhocko@suse.com> wrote:
>
> Limiting NOFAIL semantic to SLUB and {kv}malloc allocators would make
> some sense then as it could enforce reasonable use more easily I guess.

If by "limit to SLUB" you mean "limit it to the kmalloc() cases that
can be done using the standard *SMALL* buckets, then maybe.

But even then it should probably be only if you don't ask for specific
nodes or other limitations on the allocation.

Because realize that "kmalloc()" and friends will fall back to other
things like __kmalloc_large_node_noprof(), and HELL NO those should
not honor NOFAIL.

And dammit, those kvmalloc() sizes need to be limited too. A number
like 24kB was mentioned. That sounds fine. Maybe even 64kB. But make
it *SMALL*.

And make it clear that it will return NULL if somebody misuses it.

            Linus
