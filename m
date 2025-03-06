Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716081547D8
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269879; cv=none; b=Yx4qp8LuSyihHpyR3AAEDffe0l5YC0ITQDiV7zUH+Ty+OcA4btCxfb9sXFw/DRHSMS7o6pNlDzthHpbOVGYUi8ioMeGHcrMg3ZsmWvJUPs9I98WkXokHfoElMXW8SbHfKfWc7aO4gsbjdV14D1nEk7iDMMpHogAq+nyU3qOoBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269879; c=relaxed/simple;
	bh=R8Sm3svdW/goUTU5rLDpziJHP2XsdLH8VJwkfv4HNAo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEUiGlA9BszusYawAqmNHJd2HI2nNXEbAlx6llyixqETOt1ob9SRPwwo9W+HLNkM0R5wzXTaft16Z/3BJBcESgU3i9kUPNOP6czp7eQ6cG0jrwtPQy2gDl224vvrnTilnOE2gxflzaUPTboY/eUaLBkzD5rl+7PzSXfKxxenjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjwHxAum; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjwHxAum"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549880cdb1fso790456e87.2
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741269875; x=1741874675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9w1loW1D93ByGjxUH+v0w87cRUrgY5imRrAfL3a+uhQ=;
        b=UjwHxAumoo8OHhaJPyBpjPHwjqHwwjP7XC8SLMTK+1z52Ar2ZLzbzhRwXBhYBBh+TM
         yNSGyXOIC+VCaDOwcnM4gVHjJHMH0zVJfW0EVgZszyK64gv+qrECtaLBzJNCspjaVzVn
         xm35HD6A/3YKM4e9mLxN+zZnc1u7aP8TylSe+dZuBqaZZYn820LqWDQb8NGJ6MAMYdzC
         BS8LNYw1webxeTQbj6yMPW4Zm/EFuXP+3ANt1clIKfUE4S0i1Kvk+WqN2TZOZvNFRtbP
         Mq2XR9VNFdjtdI5LA+0/SR0Xm3jRfSO2XSuIC5MSmk/qYqbsgM/4ql+nyhyrnQYs4pbz
         Zl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269875; x=1741874675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w1loW1D93ByGjxUH+v0w87cRUrgY5imRrAfL3a+uhQ=;
        b=D8CeXeqFz5VxpyPxL+iCB6LtK+EwmcIjSH2j4TUzdNR3zAYx+Lpz8a3uH/sSbpt77m
         FxyVEnTSv7rV1hJJQ7sCas4jvcSfs5cnPdFMMJLI55nGXeDlxvXhNCmqp1CHF0VMBIlf
         D2DYmP5aZM5YOgqKAWKXtKxhfa9YgvyUBc3yJzCk1FQLg88ltsZhw97bfBbudnsP3bVs
         enCnX3/0mxan39/RQbQKDWvQev32GIWDv82CmxgJ45eie0JaCG0qBsjhH6qEHDRyH057
         50su+Doa53VuiBI2HQt4fUUCR1MAvFoPqFEoCTDjGyMcYNzWMflzNZkDlzxJu5usEMS6
         qLAg==
X-Forwarded-Encrypted: i=1; AJvYcCVraeRPoTRXSaTD7Q28VDzHZnFGSdQeXeZgXSuHKz8BgTdxO/FEjtzbletF6Cx2ajBH2xS2v7ngo5p73OB9rA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynK7l7mIlwAnQv7RZW1eCuZKA9CujmqlUOpLCcjTiLyHje5upm
	7hVADXcoptRjFaFn59yKB4iWyAHR8nksQoBAYFOZokN/kGEWvKEa
X-Gm-Gg: ASbGncu2s7qVgctwAH9HQ94zqjv6kKY7bkjAQLTKpTX6D6OuTQ+2dmoaW0YmCVeXYaK
	v2horqPKioPoPDZMLSWm+ZufRN4HPDfnE4DIDzp+YsbDgHJsAmZK8BQAT52BtPGlo0PAIY+JXNz
	AQj6prbA2dOx/rrZFy+xRIa5mowF+y8lZG2bnr+zhEDkv5gicCgoRQyytBM7e6V7BHarY+oMhLR
	3lyPvcy5Lp2zxDnXGdsGFNh/eGnNHqJwDG1WCppErudKS4KFBgqUga3ngwrTFfY9YPqu/6sCJd+
	nruzn0EiuFDzcTCsX+tRmp8FneK4yr9dRNbklIB2WkMU0IxS6eUdAFH0Zchw9QZNhCY=
X-Google-Smtp-Source: AGHT+IGonnW2BIlqC2FdXER3bXAFv4ISuWErmmFhIv+nnElrcZtI1jJxe9rCZw7FGgE21qslHhMlvg==
X-Received: by 2002:a05:6512:281d:b0:549:5b54:2c66 with SMTP id 2adb3069b0e04-5497d345ea7mr2751359e87.23.1741269875014;
        Thu, 06 Mar 2025 06:04:35 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf82sm185064e87.154.2025.03.06.06.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:04:34 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 6 Mar 2025 15:04:31 +0100
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Message-ID: <Z8mrb_zcou6Hn7hF@pc636>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>

On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
> On 06/03/2025 05:52, Matthew Wilcox wrote:
> > On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> > > Some drivers can use vmap in drm_panic, however, vmap is sleepable and
> > > takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> > > requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> > 
> > In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
> > is this supposed to work?
> > 
> > > +	vn = addr_to_node(va->va_start);
> > > +
> > > +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> > 
> > If someone else is holding the vn->busy.lock because they're modifying the
> > busy tree, you'll corrupt the tree.  You can't just say "I can't take a
> > lock here, so I won't bother".  You need to figure out how to do something
> > safe without taking the lock.  For example, you could preallocate the
> > page tables and reserve a vmap area when the driver loads that would
> > then be usable for the panic situation.  I don't know that we have APIs
> > to let you do that today, but it's something that could be added.
> > 
> Regarding the lock, it should be possible to use the trylock() variant, and
> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
> active, so it's unlikely the lock would be released anyway).
> 
> If we need to pre-allocate the page table and reserve the vmap area, maybe
> it would be easier to just always vmap() the primary framebuffer, so it can
> be used in the panic handler?
> 
We can reserve a vmap space for ATOMIC or NOWAIT allocations. As for PTE
part, we can also populate reserved space, because after that operation
those are never get released.

The question is how many users need this. As for this particular case i
am in line with Jocelyn Falempe. Allocate for DRM and write on panic.

--
Uladzislau Rezki
