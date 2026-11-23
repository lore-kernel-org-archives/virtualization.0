Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795411393;
	b=lnG5qyJuYARKNqZHUsVf1hI9Y630HEm3kjni+AVA0ZU9Co1HaK/zZC0tXcQI5/3e5UZP
	 lU9zpSjU+NlPV60+1d8U/+zP59PqDIJ84QUCPh/VifyG/98Q88mksvUzZOeZgxJY49uSv
	 0+xGi8iu9zHKQFfBVyQOubdtPFLfCeSa4dhCGgnAEZlwAMhGpltH37TCwO8QVjlwQzjdc
	 qtBEOBGlCindXa5gDlpg3JNpkl4eNUObQys+9nl+Dp9iZ2xQbagGTl54ABYXzjo+yaF+N
	 Y2czsTDU+qFa5ZRyNBdDlMkzvp0cSYQVe2K7hBWD1bXheHt9LXQbdrFVojIiZFE0rtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
	b=1Obt2URFOVsVeYHbj+zhfwKHSEUsLaNBbRdE/c2ftAOxzK0gTf6G/kzDoSg7yw+zSzmx
	 6Ore/Q4LOlYKN8crPykqKdOzncSBKLS+HFTO57cZ7rcNDld14tmE2bfakDsFATD4lFESK
	 vw18/aJuWYVgXWHKx1y0IQa50SnEjZi4J3nJM0B+avKUGi1tXVIiIqkBwwl8/xwIozKoI
	 Q/9cQsNDNfQ6JsQWaaUusps8ObN/7/+qke4rX7+BMkC4YlVQPzS6w61vqFVAVqANInlrJ
	 N5hkGhEQBzciHfiOXuH1T8hofcxdMxl/AvPKINxj1AA7I/x914eM7/vlqbcQPefs7Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3EaPA5W;
	arc=fail smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF61606A31E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 05:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF61606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3EaPA5W
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ad0102edd4so26313261fa.1
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 21:23:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795411391; cv=none;
        d=google.com; s=arc-20260327;
        b=dTGiRxYMYE+S+2I7OtjaDsipgOFnRFI23svqNrBYwcUDaqfbP5p+W/QwqId8iE4gsw
         8CBKBgMPp2VCmYYKndJRqOfH2KmYg32Fjuf+RelNKucGOO0EbUuQvLwivPYmwWUSQ96N
         14Rt2k6Py5oS9TQ9POEofR/J2NiEIez00U8XU8g5Pi59NfZxYARAvp5pAIv3qKR+efPx
         PR5wEd0/cQEDUAhlWjpZgCmarcMaCrDnz99jVHXGRO8D/fx+FC6SskGPdKPmqHVXYP3J
         LDyrPEzz8HxByWrQmCGZPMlMQ/QH5WJHu0ifguM6R1X5qsGHYsCnvcWYrLk6zsJRZDU3
         9MHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
        fh=lJBWMhCmOpOjM/P03i1IKKhiBGvHJHw8Tvm6JJe8QdE=;
        b=RZ62upKbDrkh7dmludlw4IZ9AcBkx4GahgMzyfH6bpdORMNW20jimDB+IMzZsfdvaR
         OuGpsvG/czhGtfrYzSaTtzlmgYCgzoXP6LdR3BJAVkApbdCXNJ4tVg+YleubjmnB67Ml
         jjha/GHwgIKyy/v8yvyUXYmogYl6mE2Ksrcog1pRamHxgsylgs+aUE2tzmzlRPpNjAOU
         T/jbIbEo9KtIjgjA4PT1ci3IXiRUybmlo1uXzkxBaxOXFESveTDyaE/WKgoiRboXEFaW
         jh0Qklclw+y/kIC7zbuKR0LILhcngbCEjyA++WL8Pp1i4wQ8CxgR7B4oXVGKKC/3+pJL
         xSuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795411391; x=1796016191; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
        b=B3EaPA5WbRPHa5V1lWE1EubcIqpSVS6jirxTRGCGGJBV3x0Lint29NlKoeWy2BSzPt
         kwCh8982O2DGM/laPsOmTT8HRvcbpzH/HT4bZJCq3OPTlAHW6B4HEc5cQOrGDYUx6I0D
         Do6CHeQsNKfKVcXh8erycpK+zCA9HDq052DWFeSoLqRGJw4LQgAohMtR4pjZfR9L8knB
         EMNThWc0JXF6wPe2VKHxADns93uOO2TbaBs08ohoIAqYsFW1e9bNqPw5AamwUVzKzIAi
         Nj4yB9W1u3WcfKSlS5fbltnb0VqYY9UyOxlFb1y8gHi4vejyiR4c+GRK7pJs+F36vRga
         yQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795411391; x=1796016191;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zj1KMJVaKNaumg9rUcx+XITIlfu/2H9J2RhD6HuzcNQ=;
        b=dOcsJTmAQ7QdMCAyHokNAB0bXNr5AzIa1bX+bjbDmkRVjhuR4oDqkkTNcBjimtCBrF
         8gxUqcyq2JiXV6M4J/PgcV0Z7t+G2fzKBYqTf/cymbJ90GXLxzlySfbewodB+JECEpMY
         q2Rqoas9ZhlnPidy8jKbBFHBrL6R55Z4KTgqs3TPdHG09ITXjbRteEtXPqo846sZuMYc
         Uc74hfmnDtonDntF97T6cFQAFpi7lkV6wH5JF6U922ijaJwW03hmsOYikQvsHFDqad4V
         o7CnMP7SWiZeGn5G3EGLrBZQgac+CyjHRj1bUkmJDePyvuogiYo0i6zT1hWzPO1cTmqp
         BeOg==
X-Forwarded-Encrypted: i=1; AL+hErH50APHGCiuNfSYiOeC5r3JOvhqdVuOHxf5LRtbosFTbPQ+egDHShrRn/TMjXME7PbakID3rjTooG8OZZitKQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8tOHgn421prTfOoTTEeRXuG2n1kQZlnDRNLBWa4Bd54y2CCTbq
	cyBWgujj6Si8adBmqRRjtHfaGa6ADEIlsV0REy3YS7c71/FXE1XsS5k0YLcM+sv11OGHkH2bMWv
	fCEI1GAhPjwII76/Ms1zqJsWCFaUDsak=
X-Gm-Gg: AZFdTZekCoPaXPgrN8l7seN498912+p4EwY9+z5CjUROmvjCvrehxzhXZTm52O2lvSg
	arbaaQLZIOCpRY5MrCasnQXHaXNExKkNyRb4fhpfuH9EDtLsC4BMedWzlaX5ygu2eRHFmj7/lNm
	Cd8DvUOKkg73gqO/F+5MYXxJqzJPXzA+y92R8ERRvdDSACGuEy/tuy5wIcJBuRfIVY54qn/wSMU
	hDHofXda4+1TY2H1E8ynT5Sok5TWf6a9eGrwmSVkPS5kSymQaEmZWGWwwQaeKejCwN3qWA64XbZ
	hiHRfm9VTIS6MX67iUvx0VhSi0I1lNV9BQpB8NsLOc+XHmvU2ofBibS5gkh5DoECOllP7vYnKm9
	OkNbI2yzP+fC8YOv8i3wcsXZS8kuZQb3+LTdTcVKVdL2PbMFfX4vlTsgqc/A=
X-Received: by 2002:a05:651c:4186:b0:3ac:efb1:6def with SMTP id
 38308e7fff4ca-3ae7f9f7df0mr23250971fa.12.1795411390729; Sun, 22 Nov 2026
 21:23:10 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106054811.281798-2-oss.patchbox@gmail.com> <add2bfe5-0d8a-4b64-a8dd-5e02be00e425@oracle.com>
In-Reply-To: <add2bfe5-0d8a-4b64-a8dd-5e02be00e425@oracle.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 23 Nov 2026 00:22:57 -0500
X-Gm-Features: Aa3M54o18bPzB_y6cN5ZyBXSDft40ObSb8CAiNsU_ZagFcTkH4vNqu9TTbhSp9U
Message-ID: <CAGG=RgDLSueREjeeyw09oo8ttLHN2VYUC0qEDv+HYFUrSo0LdA@mail.gmail.com>
Subject: Re: [PATCH v1] vhost-scsi: do not validate vrings during endpoint teardown
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review!

On Sun, 8 Nov 2026 at 14:05, Mike Christie <michael.christie@oracle.com> wrote:
>
> Can you describe the bug a little more?
>
> If we have done vhost_scsi_set_endpoint successfully, are you saying a later
> call to vhost_scsi_clear_endpoint could fail the. vhost_vq_access_ok check
> and not teardown the endpoint?

Yes, the first case is what I meant. Sorry for not explaining the
failure path in the commit message.

Since a543346b96a1 ("vhost-scsi: reject delayed virtqueue setup"), I/O
virtqueues that are not configured when SET_ENDPOINT is called remain
without a backend.

VHOST_SET_LOG_BASE validates the new log base only for virtqueues with
a backend. Therefore, an invalid log base can be stored in an inactive
virtqueue even when the ioctl returns -EFAULT. A subsequent
CLEAR_ENDPOINT then fails vhost_vq_access_ok() and skips teardown.

I reproduced this on current mainline (8dac6df92a2e) with KASAN, with
the following sequence:

  VHOST_SET_OWNER
  VHOST_SET_FEATURES(VHOST_F_LOG_ALL)
  VHOST_SET_MEM_TABLE
  Set up vq 0, 1, and 2 only
  VHOST_SCSI_SET_ENDPOINT             -> 0
  VHOST_SET_LOG_BASE(kernel address)  -> -EFAULT
  VHOST_SCSI_CLEAR_ENDPOINT           -> -EFAULT
  close()

After close(), tpg->vhost_scsi still points to the freed vs. Linking
another LUN triggers a KASAN use-after-free in vhost_scsi_do_plug().

I also reproduced the in-flight command UAF described in the commit
message. A delayed READ completion after close() triggers KASAN in
vhost_scsi_release_cmd(). The READ has to be queued after the
VHOST_SET_LOG_BASE call, because device ioctls flush in-flight
commands.

With the patch applied, both reproductions complete without KASAN
reports, and endpoint teardown succeeds.

Without a successful SET_ENDPOINT, no command can start, so the second
scenario you mentioned is not what I meant.

I can share the reproducer and full KASAN reports if useful. I'll
include the failure sequence in v2.

Thanks
