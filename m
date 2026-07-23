Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC36372B53
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779644; cv=pass; b=Ak9fzdSIz9+GvKd/haaDGC+03a0b7dqekNV+hA9Tzrv1sGxdkvX7WzkyVANBhL4jiF9cN1Ep5JVa92U3fzBJUImRWMfPcWgWwHCqYg2kxyoe13S0tKhkbFr4s/Sm8RL5hbDye7zwBX6dK4O9N8/Gky2d8yjMA6vm21TkKzcM6UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779644; c=relaxed/simple;
	bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/vQnNFP+Zjvz94jTYk5qcAOUrFRBHc7QF4mzofarcZ45Wmj7vz/MSZb2BsotWfX0m452lbFuVKZKswlWHRytSQ2XK8sPw18TspxIHFdDfyC/Q2Zf30dDEY6jJdLE78FmVfYCl3auOsP+Y/Ecwgq8Hz3QNRHxtARwtTPBiJlB6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIhYcw4u; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIhYcw4u"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so135021cf.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 21:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784779637; cv=none;
        d=google.com; s=arc-20260327;
        b=AnmBDBg5oxWfa+2QXakwd74M4mhsJ/SZmG4VuOSJaKMfztwBW7bHBefa2Qnptu3+B4
         TFOWD2a49q2/N3IhsrVZfc+ZPnu/waY2CEH3U5UPGjs58u8YFm0P1Y34O4JU+LCGXJG6
         tXtfnMrWQgfeRwIA1LWKcdwPDYOaXpUngEvWhlGS8skz1kMCuo4X1QEGyoHJ1DKLnrPS
         hAgAxu1KiMHbuw/bwUZ7n+KWUnVJSqtAvqbnkov9kJhnyS/u5iV+TvUpq7vwfpGQcE0+
         y9bp1mUywN8+F6uVm5D2ceivWwrjAb8re16PBJNvJWnJg5sGNLQyzTwg+5zsCjlylzC0
         3bwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
        fh=5m6JKY7eR9XmN1VsjnSsS9zuBuSDT2D8fWMZzox7P1Q=;
        b=O/nVI9O9tmUZmzsak3XwG47d+UXkz4g0wEerJRv5XCB+BNfOXk3rDprYp2giT1MPVA
         YgO5S9idEGSSH9St/l+VH15LjL4n9y3SBY8ydC9YpZ8KgZhM6mr85q4sKyORSOCWWeSc
         NoFpnuGoOcbGpO14ch2FNWwGxNi08lFcs6OnxMCD8dxRk4h6e92QJUR68E8G4cvaZTmz
         hS7HJXpNXizpGg6r3cqcQguHCnP9vwOBgVDtnxOS3XlNv19IN2wOnf0WmnCaT0rCr+oh
         kuJRdDsdKajZqL/GDUXa7mMflm9k5IbnT1RPOhHnaApe3HleQCAGbO2igO5zfKoYwVu/
         I8zA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784779637; x=1785384437; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
        b=GIhYcw4ulitm0ogV9lWkSOXGg/aOiFnH1BpkzQg4HGnFxrQMtkwVS8rDcxgAjGZ508
         WVM27QRtLG6pOqjTKMSBsNg7ZkUoPUIral4t9x5Uoogu/A2qL0Ez5HvqQj/i1RLT5nbW
         Vxg62RGiJzwduUoKEwblepPtoaqnt2ra4XoNoeLrkrf7uTXC6pPx8yH4OqFzS7xaiArS
         ZHs7QF4MVmbPX9SOC4n8255RAsdBtrMG0p/xIEZKUU7hFBQGGEkzkTyV0XzsMxAU5Sl3
         AzYgabympI9TIaKMRocRxLdZX3UVbArR7sw7+w+q/cOhy04GS7MQtD7fb6ImYKXaWNwa
         rcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784779637; x=1785384437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8K+zEl28QTXFlBY2G5c0iSNTDb1DkSYdmQKQjZLUJmE=;
        b=T9Kch0ywM2P8hZmytkZ0bCCH+Q636m/Qd+5Xli7iX0rZ003WpkYZ3gMdMlrOyTwdyj
         vEWcwhqkKYra+9iYLwAHrGY4+dGmLf9/ojdEd+ikPFo9uynnEiQ9rkZ4Uk0p4NqD2Lrn
         RWiRq5J/ZzwMAxnAYn2sGWRQ4F52qGeaRPaJBi14gUYDQ7DEwq4SenjQz1aV4yV/7zY5
         J1IFsLRFipavKmzPnYx5S8Y7lv44uJOKqZlw6Acy9X3pVN0o7Cpb3LqavmHNbuCIxOno
         li24dhTKo+UxJC17paxiDUAABRmfBDTel1lgr5n8t0duKGyIqZeaUOUOo4bipak1ut1U
         tXvg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9lmZsN3y1nv6n3SbTJe5otBAn6YNJOXuzQIRYhDcmkTysvcLCNlExDNv8b40j6VBS7xv5Y0RwCd73apJmTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcaArAqU0dWlE/ssOrP/t+sQp8oo0SSmCI5vuQoIqvvBjPap5+
	w96QZXZ283LuypvF3pJOnTN/91RBdddkFns1YDQmYTAtRllUipnA4cm77YzI2cpx7uyduT+Sh8R
	8/iOoOC9G8nCpwMOJg2x63hOQiyTY1YQD8Vp5AAjI
X-Gm-Gg: AR+sD117nsKgcUhG9neV6azsDKUKf4D13LMSAIWwvirnkM8X9/QDg96TnLmIQR2RN4P
	rmfZrG4rWM+spYgcq6M6hMXweOVhTi/csS1b2EenPzo8D3Y6oqyLlMJdOf9OINJKV5nGBpQZSIb
	xj9MVIWnjsA1BY8F+ru58IH3nuAeod/fsgEFC/AWdkyQxSHsYpM5pCArB+8casMatqjBcneProe
	uvpL+LnbCJ0bpChnHQz8TWErViz77llFkPhW+VoRGtuaWX2kLcxhncujM8R9q+dH3Bt2Tz6sKba
	LGQagzfvj6vBx8nvpA==
X-Received: by 2002:ac8:5a45:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-5283b8f3543mr6081881cf.0.1784779636303; Wed, 22 Jul 2026
 21:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260721005603.1710551-1-linkl@google.com> <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
In-Reply-To: <20260722173639.34d3f58413354218b24a5b0d@linux-foundation.org>
From: Link Lin <linkl@google.com>
Date: Wed, 22 Jul 2026 21:07:04 -0700
X-Gm-Features: AUfX_mx3uQZpyv5zi_Q9zPvKus9UiXbRlkAo3cxV-vdSjkfxBWwgopwFhNLbarQ
Message-ID: <CALUx4KSfUUud86k4SLwETJAciRc8kZ9QocvBj39KmzXDiQ7J1g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
> hm, now where did that come from. I can find no such commit and that's
> the second time this very unusual thing has happened in 30 minutes! I
> wonder what's going on.
>
> I'll use
> 36e66c554b5c ("mm: introduce Reported pages")
> OK?

Yes, that Fixes tag is perfectly OK. I pulled the previous hash from
an internal downstream tree by mistake. Thank you for catching that
and correcting it!

> The bug is very old so I won't fast-track this fix into 7.2-rcX.

Completely understood and agreed.

> AI review pointed at a possible pre-existing use-after-free issue,
> related to virtio-balloon. But I think this is a rephrasing of the
> issue it flagged against your v2 patch.

I actually looked closely at Sashiko's flag, and to my surprise, it is not =
a
rephrasing=E2=80=94it caught a completely separate, valid edge case.

My patch fixes the UAF on the PM suspend/teardown path. However, Sashiko no=
ticed
a UAF on the PM *restore* error path. If virtballoon_restore() fails during
init_vqs(), it aborts without unregistering the page reporting worker. When
system_freezable_wq thaws, the reporting worker wakes up and dereferences t=
he
now-dangling vb->reporting_vq pointer.

Since it's a driver-specific lifecycle bug rather than a core MM workqueue
issue, I will write up a separate follow-up patch to address it in
virtio_balloon.c
shortly.

Thank you again for shepherding this fix into -mm!

Best,
Link
