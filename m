Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B9166F17
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724134656; cv=none; b=GuZbJE5A+q1EQb+wb5T3r8g2Sq0lndl2Jjo/I5kO3i5VE3EFHGHarhT1MwreLwITyBpV7N7dyfInoIbbj5GNy4vUj5KGZXYV/iUiLFR1ErQrlXBTHAE4Ig7PUsBwvuNDz+E0LD0jNhmOmfY4ah60biYwN0mWchdhy7mc2nCO/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724134656; c=relaxed/simple;
	bh=GwCLjJdjQ0Yvn3XY9DLiViD88ued9iwnab9fP3xS1cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJYvGI8GcDc5PVVggJMVatSKmEcbeUkvoY1Udgf27yxqFLd5ImBTy4RD1z7ZI/WEuVj9CSV2RV+pHW1T5QoP7uVblN9U8FCk4iIvRbXIUNJit+9CHLDUs4+pBY3T898omPvO+EYu+y2uvt1Zvfhsum06Trh/Y7OeAnu7cpfeom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EZ/EZ4Es; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EZ/EZ4Es"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so4195857a12.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724134652; x=1724739452; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56N+3ZnhzW8ZfoNYTDxVJgLpZofU9AGU8Qdg270Now0=;
        b=EZ/EZ4EsJ2IhKV4IVe+fhoTgg4rJ8VNbqqqKsmAoxGEe0v+yT7QmSVC5bUkhVVOhBT
         PV6D2YNTVIkE2FY8ApayL+M2hVMKnLIK6jJ6fzmkBk2vD6PVEb2cHD0On/JvYCBRcArS
         2XDDxgTQ0xSghb6HcLgQBHcmFIf/ibP31O1mgfUZonpxN7T4dTia2AD/87CEobCIgpkw
         07yfVs0tYqkin6l4GLz1g1qGJljCkDNMy6O014MCQb5vEyO/3LS1vosnW7zMDMisHODj
         UkXJHbI9lrEgA4z8DmI/yOOptn6V42ZCn4KWtvbAT7ZKPkQgvgXlPLcFgZuo5HqCOMeU
         AqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724134652; x=1724739452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56N+3ZnhzW8ZfoNYTDxVJgLpZofU9AGU8Qdg270Now0=;
        b=dlJYMxM6ZcQm5kJcVWFhG4ZIUSBu6trCGUDYvi/svx+VH+aTWZrFXcZyhFJlmIfcR0
         i4WhdIsLmnWVbE26LNaIaFi/VxYx+y3OQtIFS7hyDdV+vblFB7h79O2Dmwp1nXBBc9rO
         aZK/ADudS45h8eIk2nXZLMBcLz/q6M69zs3NPiTvsgq79KxKn3SWW9Vez2a/nDkhAAIW
         eMsVbdPD8aEd2D7f2vzKTTNMMpUutPtiJg3qnGnnszWeD4c5S9fuNHmwaPAWQwLEcrbs
         HL2iDzyaZUI72eYEswIJ+TsrkxLh2o9QZD9P+HDPSbvwM5LDrIO/XNpbylHvj+kPXf5D
         Vffw==
X-Forwarded-Encrypted: i=1; AJvYcCU44kw6+YDZM1WHFKQCKIDuYQI9zJhEfX6ed8OZKci2wCZc6omGWpIKITlOsBWQloHDqCTIG2LS72WrcarzQns6n/D+rktkK9XVStSquGU=
X-Gm-Message-State: AOJu0YxJFMXDMCDOpwtgY5snytCAanfQxtyLBj/9jQKrSoWCd3TlWSPg
	8MvIQATflDeSD2PdnsJgv574UArLXVpfqYGvCH270uAabsMPn4kpHIKX9bhZhfg=
X-Google-Smtp-Source: AGHT+IF1fVcmkpkLaENHujEcxVs3gkip9d6D2T9b5YQCS0rC4414pWwXTFChRiYzOZIgvF7utuJdqw==
X-Received: by 2002:a05:6402:84b:b0:5be:bcdf:4110 with SMTP id 4fb4d7f45d1cf-5beca263a7cmr9618497a12.0.1724134651917;
        Mon, 19 Aug 2024 23:17:31 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfa4f1sm6330386a12.43.2024.08.19.23.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:17:31 -0700 (PDT)
Date: Tue, 20 Aug 2024 08:17:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <ZsQ0-gPUyOYK8Ne-@tiehlicka>
References: <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com>
 <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
 <CAGsJ_4zWNgA1OZJ-iAa4KhDY9TuGb2vji4=FJ=Vn7ve5uF6XzQ@mail.gmail.com>
 <5424dfa3-03db-4a82-a08e-fb31285774b3@redhat.com>
 <ZsN9Eo8HWdEgqpf3@tiehlicka>
 <a366907d-191f-471d-aa5a-fc8f3f88198b@redhat.com>
 <CAHk-=wgGLFV4mkNGwhpTMYrR2sVJVbnJ8RrfaHihDwtR+Z5O+Q@mail.gmail.com>
 <6814fdf6-cf32-43e9-ba20-705ec5238abe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6814fdf6-cf32-43e9-ba20-705ec5238abe@redhat.com>

On Mon 19-08-24 23:57:29, David Hildenbrand wrote:
> On 19.08.24 22:35, Linus Torvalds wrote:
> > On Mon, 19 Aug 2024 at 13:24, David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > Right, "warn + loop forever" is one alternative where you could at least
> > > keep the system alive to some degree.
> > 
> > Maybe. Or it might just lock up the machine.
> 
> Yes, regarding the security concerns it might be a bit better that way. (no
> security expert, so I cannot judge ...)

Would it make sense to simply enforce and oops? We do expect that an
incorrect usage would trigger one but we have no guarantee because the
actual user could be 
array = kvmalloc(unsupported_size_provided_from_userspace, GFP_NOFAIL)

which might be actually a valid usecase because that the normaly
requested size is large, yet reasonable. A lack of user input checks is
just a sad reality we have to live with. While those bugs absolutely
_need_ to be fixed it is better to not just allow them to
array[large_index] = payload
and make them easier to exploit the kernel. Sure you will get a warning
but your machine has been compromised.

BUG_ON will shoot the whole machine down which I do understand is just
too drastic of a measure. Making the allocation loop for ever with
cond_resched() or a short sleep is slightly better because it contains
the bad user but the process context is still not killabale that way
which is a problem on its own. I am not aware of OOPS_ON that would kill
the calling user process. Yes, this could still be leaving locks behind
but still better than a compromised system.

WDYT?
-- 
Michal Hocko
SUSE Labs
