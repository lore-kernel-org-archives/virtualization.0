Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208216A39E
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072724; cv=none; b=gu6sPthDepNX0yHDl8A0cF9oDb/n9Mjvnzt4vzYpLSL/uHBwWYWULPoHeDI2Uu3AgRssu/AWrsCC9Ah6HeashM8xlc46PJLiJ56RSq9dgADOx7cldXVuEy+iSbTcZdKPTauhDriDaNPUpi8u1VWP5zM8Jf5pNT3f4h9CLD0Q0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072724; c=relaxed/simple;
	bh=vG7jrcKKcfR9jcKsFoYSnucoCS29Bqs8j2EFvZ5/2l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYZoSztqfMc/kA+j7h2L3zrRESTe2MUezKdXZVqJONuKNuZahDr4n1ptKTSg5DpY+KOqcb9nxKIYUcmcg/s+iyJ9z868ScIhJrFBH88OrKCLet+mks7R7QcMGAhTMVypiBzTHkmqYRs/g+L/SE8/HnSfamHnQ8pjZK/30ALecEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO0BnHO9; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO0BnHO9"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db23a60850so2885006b6e.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724072722; x=1724677522; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/8M/g7fqE01VwwYaYDweAywXeYFLeqwtlEF1ZaGpk4=;
        b=dO0BnHO93sMQyDcCLiavWs6peCXmdl7qupAnVbZV3mr/Hl73gtIAXIjDch5aoiBvj0
         3Ivuy3SbgWwp7J1IzP7SA9FLnHZiY91paWLw8fo0WEFZS1fOiX39YZTVy+7gwD22Lw6Y
         SleOvJINNbnofIMvWbtnHomSQFsfAfdcEH2qY8EZK51o1eT2ZXlmNZPFSrLrn0QQEDWO
         7OXxf7Z9hC26HLYtz6H7OXzcxdTHPDjAOUXW7iI2vr+KbW4NbdtNtprLQKfHMqBht/KV
         Clf5FIObl0KTeGI8h0mQrzs8l5uucDEHUzWcJPhZZZ2Wo5obu1LWoSCyK/2yukN05hTT
         niRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072722; x=1724677522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/8M/g7fqE01VwwYaYDweAywXeYFLeqwtlEF1ZaGpk4=;
        b=cLX38CFBjQZYEMwydKYYG3jxxQV8fR1O+9ZZ25B+7EAXSoxdLo/RSqaql3jHfzxvnM
         tEoxvsgfMfHzuKvgRwAjPzA9rGXPZvkYAWRo7k3HPMLqMp6JBhTrR9G1OslXqoIqXbNX
         CHhj0ymBfQ+7p+RRH8UpJ6uIjBj4K6gjfKfwHPvCyEczhLyOTqSpctqmh/4NqQ7i6DXu
         9JTW7y/Zw/vcMV/rg7xQ4neVqufiPo9TgzeYf3+p1+9nV7+e0LJvm2J6lo6IOkZ+NLCm
         KFYoc8UyoVgekLwNCoAxl3WwfjqtBfMzdOyXmXMEsgzy2fKc+BDGU2Yg7xPXZZpXIEqo
         ls9A==
X-Forwarded-Encrypted: i=1; AJvYcCUMhh9ZEM14VS5FWSnZ4xYJ3h2D3GwiT7Ldba5h3mi28RzYWH7pWz0GPOMY07mduNcVu68uMqb81oIZ5hWuXdcdM8HSGstUcSYDKOcMwXg=
X-Gm-Message-State: AOJu0YwPs30LZPila6j8QuTNRL7D0CezaEiO+mmuoifEeW2dMOAA9UPF
	HNHAMRrS6wzl5C2BsCVDSybRaQw7+3ba2+stS9GsANnvUUhQgGQ1BbxLC/HaG6xCX5iVycrWT9U
	ben+IeXoT1qFxm8YeNOUq2Rog2bE=
X-Google-Smtp-Source: AGHT+IF+JXI/F7OpCZMQlNI028X3cJz1MKS7sgQJvdmUOiyv7sBO0EGsiFnw9O36MFlLrsrjhATXZC4U/psLN+bN1oQ=
X-Received: by 2002:a05:6358:5927:b0:1b1:ac2e:c50e with SMTP id
 e5c5f4694b2df-1b393199981mr1474341155d.9.1724072722410; Mon, 19 Aug 2024
 06:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com> <20240819124924.GA7642@lst.de>
 <a31af580-f420-4b34-8945-0269914a901b@redhat.com>
In-Reply-To: <a31af580-f420-4b34-8945-0269914a901b@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 01:05:11 +1200
Message-ID: <CAGsJ_4z-5ypPGoG6JDwRZGDt5Dby9r1tvh-txFdnkhQaKq8zGA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, torvalds@linux-foundation.org, 
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 12:51=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 19.08.24 14:49, Christoph Hellwig wrote:
> > On Mon, Aug 19, 2024 at 02:33:06PM +0200, David Hildenbrand wrote:
> >> It should all be caught during testing either way. And if some OOT mod=
ule
> >> does something nasty, that's not our responsibility.
> >>
> >> BUG_ON is not a way to write assertions into the code.
> >
> > So you'd rather create exploits than crashing on a fundamental API
> > violation?  That's exactly what the series is trying to fix.
>
> I'd rather have a sane API that doesn't even allow this level of
> flexibility with NOFAIL.

yes, i have already sent a RFC enforcing direct_reclamation:
https://www.spinics.net/lists/linux-mm/msg394659.html

somehow, it is not ready yet. i think Christoph prefers scope
api rather than GFP_NOFAIL which definitely has
__GFP_DIRECT_RECLAIM set. I guess you know I have
at least  5 series running, so it will happen soon though.

>
> But probably I'm missing more details here why this all has to be so
> complicated ;)

enforcing direct_reclamation is right and will work for a reasonable size.
but for this overflow size, even if we enforce direct_reclamation
in GFP_NOFAIL, we are still failing.

>
> --
> Cheers,
>
> David / dhildenb
>
