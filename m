Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC114E2F0
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563281; cv=none; b=vEVVnXOQHFY9vGYrnQcy6yfAr7zphFjcEtfMdNjPf1e1Xeg1spwuHxxzq3S50ZGY1Sf3H46unhn50c/68wpR1cHaIWoifmqjYLe4zX1Ks+arM8MAJagZrrZqCT7CdloTzDJCSK9n236Kj3VDCh1GvX2YSpfyfZUF92wOJzJz8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563281; c=relaxed/simple;
	bh=c+HAs8na8S1a+bn6lSS66HuiZEpVDV+PpxLmevXlW20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz8PX7B3HqXCaYcGYMqTTdx07LaVr1TZMzbrDYui0vIIqMP0VnDWJq9Qbzf40vA3b+I83MGeXJUJO4s5FTFhozG/HoZ4bENhUDPinxPsHyKjgUkNW5wFpGAOJUxZ8KBuC4AVqf9qf/SJW9F069K2ZQlAN6FNk2SL5C4rq7OTKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTC0KRye; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTC0KRye"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso22463a12.3
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563279; x=1712168079; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+HAs8na8S1a+bn6lSS66HuiZEpVDV+PpxLmevXlW20=;
        b=kTC0KRye4Ktnea2nBUsenZ/jetKbwBWRxJoEEcgYKXZ8glnsg8d3qXJQmcTAMQ/ZcD
         +Z6r7P1n1yJ60KyDYvdn2Q/xUmgTMS21SunQnBF19oQSffLESFRsfZxstacvgcz8O8tT
         sRm6VN9leFIxKNPVGObwUtfwofxPzrpCke0h7eBpdiLpAToDazrnSCbbgnaLnaz904Z5
         hXgRy5jar+3X02hhOQ7EsLjQTkI7tc4UQUPrW1dPLwW7R3cSBIhYVGfZWhbTt3yPKPz7
         X8UkEkGA+zdPOX8i33PRt0qtqzg/4X7Oc5NrcaCUcG/MvruZWOZNRsgj7myN0p7VqR6/
         gR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563279; x=1712168079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+HAs8na8S1a+bn6lSS66HuiZEpVDV+PpxLmevXlW20=;
        b=r5MKih/cQAMxpi6q8xMr05Me8P2NjrBeim01NkUy+BqxKU5fpDZmpZPHdCcpH6RTqa
         of8TyA9QdIhnJhbbikqDZC0IhV2XCNPwIXUUKLNlcc2UNOzARZer5ejlPZB+dw2p7P7g
         9wMXaXGRelAsBRO/jVReQjGremrODIMKa1p3oxNENrHw38HL4Sdu+my0sPBzVLRuo88H
         4J7phOm0kqc+E1a0yWneS6JFndpjogKmu18MhtbxDtf4lEcsSmOzGGMr+UW4eIAOJhqO
         xu169+SUU6n85d3IXkCB3LYgUGHUSK9qySym8Ch2kb6rDG5g7TMIcn0H8yHxHD++9CoR
         6SGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXr+ZdG7azGHq/JND2BmPQNvRk58z+k7JbuMNCBfKGEAyMP/UKTSWzrr8McBtm9hn3Ak6cX4dBVYosO1DLsughuWXyf0Xq2Zu+yQk3fJU=
X-Gm-Message-State: AOJu0Yxbc/LN+0Ow7M+BID8mEq1tPfgm0gY95wzG+EKY91VaVAlnr2Jh
	x3Uex/FPHoO4F7rmlQty9e2LBDPI20uPskXvacJRT/aikQNcik3icS/RDNQMgzF/zcpJOG1JDKg
	CgtJZnr18O0A0XYc4y/ddb+aU5TA=
X-Google-Smtp-Source: AGHT+IHnSIlLulq0AsyDt/9ly+HaxaRItPV6nqivKIU7J2Nb3KNQ0NWtBnqlPPqPhd9pV7pygYtLClxUydXGZyW5r/Y=
X-Received: by 2002:a17:90a:65cc:b0:29b:9a08:6007 with SMTP id
 i12-20020a17090a65cc00b0029b9a086007mr394616pjs.46.1711563279395; Wed, 27 Mar
 2024 11:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327175556.233126-1-ojeda@kernel.org>
In-Reply-To: <20240327175556.233126-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 19:14:12 +0100
Message-ID: <CANiq72=kGWSQR7TgKDnAaef+FS3VGQeo3ri5vv1wxpW_88vdqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alon Levy <alevy@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Closes: https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPz=
neSJHEnc3qApu2Q@mail.gmail.com/

Should have a [1] at the end.

> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Given there is a loop going on here, it would be good to double-check whe=
ther
> this variable was supposed to be used for something useful or if it was j=
ust a
> remnant of a version previous to v1.4.

Also, I see Nathan sent meanwhile a message about these two that were
also mentioned/reported a while ago [1].

On my side, I noticed these due to my loongarch64 defconfig
compile-test with Rust enabled yesterday [2], but I don't want to step
on Tom/Colin/Nathan/ClangBuiltLinux's work, so please feel free to do
with these patches as you will!

Thanks!

Cheers,
Miguel

[1] https://lore.kernel.org/all/20240327163331.GB1153323@dev-arch.thelio-39=
90X/
[2] https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4pPzneSJHE=
nc3qApu2Q@mail.gmail.com/
