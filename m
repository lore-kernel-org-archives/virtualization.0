Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC591C84D7
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225190; cv=none; b=nDZJiFZf5/fbSwWGB/c2cY/wkxtOC4j9RqWdM7itXJmSmMDvHWzkiHVTdJqE/oICusg+bXJjhCFCzSsLQ2F8ol+htdjcr8YvyKDMlBawMe734CYfyJt7A1vgikNvPfNPCt1kiqYawwULxANbkWizxnGRrL2j7W3E45Yjxvw1jOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225190; c=relaxed/simple;
	bh=8e7GIaip+9DUu6uwe+92Lkc2KHRyqIMBY2m3F0Zzjmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l3f3a2HoSbSHN8tK9HC9g8lJx3zNg9sdhU6qS6hREMttXZhqKW1yqQXEZaSST473Wcmjhx8o1vIPeYf4dpFKHQd5ytUZTo4IWxzGHuGpwkzu62ovMnE6f1BM3GB8sN/XrIx8WitwT9Vv+ozHOGHJaHlgid2uh+LQjX4Cy0FYMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAaGmAeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAaGmAeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764225186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6f4WuqT6k2ip8WDEtzzNxSWpYRVd6qzfx+6SGoFmac=;
	b=gAaGmAeBuyjAe06+vBMHxy+ay9snq3Rgh3qUXHGuEo612loLVRnxL+Ta2yVAq6Xd+pIVM8
	ys2CyiVkenkm12pr3hQm/EdvkE+KnWuZpMJMq/mV4buaQ2kvtEHnzNZSYXSjkHhuzS0v++
	sZPu6OFgTJ/rnQt5hGSmc7Sz4Oqo83k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-jNrrfI_CMdCBbQFV5JO8Jw-1; Thu, 27 Nov 2025 01:33:04 -0500
X-MC-Unique: jNrrfI_CMdCBbQFV5JO8Jw-1
X-Mimecast-MFC-AGG-ID: jNrrfI_CMdCBbQFV5JO8Jw_1764225183
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b30184be7so377342f8f.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 22:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764225183; x=1764829983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6f4WuqT6k2ip8WDEtzzNxSWpYRVd6qzfx+6SGoFmac=;
        b=V3tRIiJ63vE8OMOKXlFZ0jh8oFzo+cDg7jD/gptAauzEb0Ez2gZDojDljeCBIDgfiA
         UkCOZQKbROm1xsDmt8nrcYq3LjqwlBHgKG3Ok7YzlTXr0FsmXvA1dPBP6s1rBpfRbSsY
         4SRTEegB6W0yGIUyNALSubNmXH4EV2NQRYiWdUSrd3PH1vlNj1q1lrRDfOnN/H3mO/yv
         4umUDTeY+Sn9ILNreGtXU3JsMwB/kz+Qb0Psya2w4wpOh2UE0xvJdp1Bprc4EGINrjZP
         LLeFSErHwKtYPpP23hW/AmRgdFYd6QtKjAoxOdLJfwZDRFK2OAqR+ymsF7RVLfv5Uo4j
         glKw==
X-Forwarded-Encrypted: i=1; AJvYcCUzZkJHvXEbibpaZun0rTlhmHlz+ZQzPuickbNrg1/K+malNKt2LcLFk8vXtoZDHdqoYvqiVaKWyMLkH790ew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy44/jQ0NnoYC8IVQ3AQYulOTGx4mYN6zxCQNVq+CuBv7LD99ud
	uQ86i/m98SnEm9jhaoXY8swxbemXsTpqSxJO5HBkPyOu6Sh1FUpxQiPJP2zNhPS2ceboARurV8v
	NPMM4nq2Ik/Ru9Po3eqnHuDfxYwtCbbAhdbSv2wl0ht0ZG1Znnp3Sy8aDYIodIK6PegHb
X-Gm-Gg: ASbGnctEX3K5xoKWIGZl+e9t2lI+MFL6x0UjsfZVXcZOnR8vZzigOEgJnu7nl7MRMAu
	B7vRDLhy1klBvHBJupGcUOHk528wCqVbHr5nSBKeSnyVGUFWMmqFj1OqfsyPmWQRgur/pUFSdy5
	gpUKAJLp6dlGQeIIylw+W4EaLmnOCA9s54UZX1600H1pdAVGQjVZ7eIw7kiiyDu6pcxqKjCh5wZ
	ZBg94bvxvmKl8EUdje1bIyknJigJgU0UwYg+UErxnLL7dcelJxqbDhKRQ0Vfhf+hO+VYanr7xG0
	tGfMjO3kV+L98LQWtkdjHbdxwvBOUVFLwJxfnfhT4XuTCSkCU3EqaqqZ7MYEtF4ZLjc/H56dJpn
	ug1aaY7e0XYNZORdKjF71jL3Q0rcbjQ==
X-Received: by 2002:a05:6000:230b:b0:42b:39ee:288e with SMTP id ffacd0b85a97d-42cc1cee3bfmr24580345f8f.13.1764225182879;
        Wed, 26 Nov 2025 22:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd5BXqoxLKYCHyGS/rkQDHdLIq8Q7KE+7gqo2WvMRKx7r9mM8PLb9fJTwm2WKv+5fomL13Sw==
X-Received: by 2002:a05:6000:230b:b0:42b:39ee:288e with SMTP id ffacd0b85a97d-42cc1cee3bfmr24580318f8f.13.1764225182391;
        Wed, 26 Nov 2025 22:33:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm1510686f8f.40.2025.11.26.22.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 22:33:01 -0800 (PST)
Date: Thu, 27 Nov 2025 01:32:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Sean Christopherson <seanjc@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and
 put_user()
Message-ID: <20251127013146-mutt-send-email-mst@kernel.org>
References: <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
 <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
 <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com>
 <CACGkMEvD16y2rt+cXupZ-aEcPZ=nvU7+xYSYBkUj7tH=ER3f-A@mail.gmail.com>
 <121ABD73-9400-4657-997C-6AEA578864C5@nutanix.com>
 <CACGkMEtk7veKToaJO9rwo7UeJkN+reaoG9_XcPG-dKAho1dV+A@mail.gmail.com>
 <61102cff-bb35-4fe4-af61-9fc31e3c65e0@app.fastmail.com>
 <02B0FDF1-41D4-4A7D-A57E-089D2B69CEF2@nutanix.com>
 <CACGkMEshKS84YBuqyEzYuuWJqUwGML4N+5Ev6owbiPHvogO=3Q@mail.gmail.com>
 <5EB2ED95-0BA3-4E71-8887-2FCAF002577C@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5EB2ED95-0BA3-4E71-8887-2FCAF002577C@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PPTCbc0JhHKOQVLqtz1Zibu-0eAkFo03cs6ZykoD92Y_1764225183
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 27, 2025 at 03:11:57AM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 26, 2025, at 8:08 PM, Jason Wang <jasowang@redhat.com> wrote:
> > 
> > On Thu, Nov 27, 2025 at 3:48 AM Jon Kohler <jon@nutanix.com> wrote:
> >> 
> >> 
> >>> On Nov 26, 2025, at 5:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> 
> >>> On Wed, Nov 26, 2025, at 07:04, Jason Wang wrote:
> >>>> On Wed, Nov 26, 2025 at 3:45 AM Jon Kohler <jon@nutanix.com> wrote:
> >>>>>> On Nov 19, 2025, at 8:57 PM, Jason Wang <jasowang@redhat.com> wrote:
> >>>>>> On Tue, Nov 18, 2025 at 1:35 AM Jon Kohler <jon@nutanix.com> wrote:
> >>>>> Same deal goes for __put_user() vs put_user by way of commit
> >>>>> e3aa6243434f ("ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()”)
> >>>>> 
> >>>>> Looking at arch/arm/mm/Kconfig, there are a variety of scenarios
> >>>>> where CONFIG_CPU_SPECTRE will be enabled automagically. Looking at
> >>>>> commit 252309adc81f ("ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations")
> >>>>> it says that "ARMv8 is a superset of ARMv7", so I’d guess that just
> >>>>> about everything ARM would include this by default?
> >>> 
> >>> I think the more relevant commit is for 64-bit Arm here, but this does
> >>> the same thing, see 84624087dd7e ("arm64: uaccess: Don't bother
> >>> eliding access_ok checks in __{get, put}_user").
> >> 
> >> Ah! Right, this is definitely the important bit, as it makes it
> >> crystal clear that these are exactly the same thing. The current
> >> code is:
> >> #define get_user        __get_user
> >> #define put_user        __put_user
> >> 
> >> So, this patch changing from __* to regular versions is a no-op
> >> on arm side of the house, yea?
> >> 
> >>> I would think that if we change the __get_user() to get_user()
> >>> in this driver, the same should be done for the
> >>> __copy_{from,to}_user(), which similarly skips the access_ok()
> >>> check but not the PAN/SMAP handling.
> >> 
> >> Perhaps, thats a good call out. I’d file that under one battle
> >> at a time. Let’s get get/put user dusted first, then go down
> >> that road?
> >> 
> >>> In general, the access_ok()/__get_user()/__copy_from_user()
> >>> pattern isn't really helpful any more, as Linus already
> >>> explained. I can't tell from the vhost driver code whether
> >>> we can just drop the access_ok() here and use the plain
> >>> get_user()/copy_from_user(), or if it makes sense to move
> >>> to the newer user_access_begin()/unsafe_get_user()/
> >>> unsafe_copy_from_user()/user_access_end() and try optimize
> >>> out a few PAN/SMAP flips in the process.
> > 
> > Right, according to my testing in the past, PAN/SMAP is a killer for
> > small packet performance (PPS).
> 
> For sure, every little bit helps along that path
> 
> > 
> >> 
> >> In general, I think there are a few spots where we might be
> >> able to optimize (vhost_get_vq_desc perhaps?) as that gets
> >> called quite a bit and IIRC there are at least two flips
> >> in there that perhaps we could elide to one? An investigation
> >> for another day I think.
> > 
> > Did you mean trying to read descriptors in a batch, that would be
> > better and with IN_ORDER it would be even faster as a single (at most
> > two) copy_from_user() might work (without the need to use
> > user_access_begin()/user_access_end().
> 
> Yep. I haven’t fully thought through it, just a drive-by idea
> from looking at code for the recent work I’ve been doing, just
> scratching my head thinking there *must* be something we can do
> better there.
> 
> Basically on the get rx/tx bufs path as well as the
> vhost_add_used_and_signal_n path, I think we could cluster together
> some of the get/put users and copy to/from’s. Would take some
> massaging, but I think there is something there.
> 
> >> 
> >> Anyhow, with this info - Jason - is there anything else you
> >> can think of that we want to double click on?
> > 
> > Nope.
> > 
> > Thanks
> 
> Ok thanks. Perhaps we can land this in next and let it soak in,
> though, knock on wood, I don’t think there will be fallout
> (famous last words!) ?
> 


To clairify, I think vhost tree is better to put this
in next than net-next, both because it's purely core vhost
and because unlike net-next vhost rebases so it is easy to
just drop the patch if there are issues.
I'll put it there.

-- 
MST

