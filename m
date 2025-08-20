Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A91FECA1
	for <virtualization@lists.linux.dev>; Wed, 20 Aug 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680127; cv=none; b=BKz2C6JV9Q3Jvgosb0kKPlf6olugV7Cy62iNl/T+5YEeyFInmIC+A0liEaYVAXOEW/liEfXMcTSXF5JNS2AeZAxbSTEmBWv7oK7IuE17sthMwi7mSREJFCdWtgiIeavRtZ/lSLK7WZBeQSxpWrvlwpav+Nb+uiwlg2SdsVPcWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680127; c=relaxed/simple;
	bh=iR+hp7xjDohlk4uLKSCKHyRXgQV+E/1v3D9EcSrOhN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQOIwCD/efIjlqFVmNeRgQjQ3NwepzBqMoJumaY+GrWI7DZUt5x7m6ioKP2z/x3pDYWJKpzfrPtBG24in1E1bWdgNpEZyXbQa9YGa99po8P6Rjc0r70157g5p46IhGwHEwyKqILHz31Ja5sBNeYZ+ZIbrOUEihTbJ+dY4gQrTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RT+5vZzM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RT+5vZzM"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b134aa13f5so39928721cf.1
        for <virtualization@lists.linux.dev>; Wed, 20 Aug 2025 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755680124; x=1756284924; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prBdbd5IwT0l6EaL1JkN4d71dM3Y9IcSn9RyaijIepg=;
        b=RT+5vZzMPNrTjg6ZAqnctoycc5mEhl3ou0wEKG3zuVA+MBUxfzRB/QYbrTJIQWnEhJ
         PwmrlSJv7FOByKd/cvD5XrebQCwTrmE+VD81FXtrIwT4ZW20DEYBxqRtWQlEC7As1SV7
         mUABmarEu5EO+YRAXa0YgTLUkz/qBMjhIlJC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680124; x=1756284924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prBdbd5IwT0l6EaL1JkN4d71dM3Y9IcSn9RyaijIepg=;
        b=n2YT4TQtAZVeb4ys1+vQRubtuIj94FT+dQTRIW8gFx9ciYXY6poxQbvJyYIp9gJMTJ
         r0xsc1EVTI9vS4IAMOlDt2nFlyhz4vE/keTzBEpcakkhYR8RA6sZoQUsLB7Nm4KuInT7
         oxAF5kRIQ1M6mRSkQY3yJCcp221ILOwsxteO1Q6Dq3XM2cKd6Up/DvUjkntoJ+mD4LeV
         sH2zQ9BriV2BbfkhX684XeSRROc9z9kg876WE7zIfJwZdXddpHEY0LYxBTWF9L7ii9v9
         eAszoOEJnxaE3hDNM9M9kbmeHDyy0kyQ8coTwDHflHc49wn5ZTLfjhQbzq5C6buhQMIu
         NiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6RhqDhzqLfvFsu5qbhGzS8k/CqsS9udM8kqixk6+vI+UG5xZI0JXyA9HUkOjtxvmrD5q0mVSKVatV5Ko8Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoWTnvrvTH1KvrRQubwnTmoH4uzl0+i7MDFDQGRXVvF+69bgT9
	2ugfyHaf1ttsK1526Q0N7FTJ7qO5K8vGMDrmUPUD1HUn4Q+8a8rWwQnUhglTtIQIUk3YH1i6ICZ
	19xe9B9idnJpWz+BQGE5LXn9g26kzvOSixJX24GE+BA==
X-Gm-Gg: ASbGncs4F7cvNreoP2q4puV6MJw4t2lhT1OWyBHKd571PfAfq3FhVWFZg7PNbVjG0wj
	DQ0dkJvECjKX+8u3rriP5xqyVOaYSM/HT24z6UwQgBDDzkv8TcMyyo44qw0nuWGdAftTz7o2vbY
	i1jL5uqMkM5eu5OWe56Z0CZBzSov+8Qc5brC0G9zTC9xKqWe3iXgbgQ3iZ4efv0KtzQhu+kXnvY
	ox41xTBvw==
X-Google-Smtp-Source: AGHT+IE9amIH8vBvDkdrmFCBMvx46Trt8+B/hM/ooS8/9+69L7vKMWavOQFjcJ0LSDyTfdtowVCQkWdhAiN053eMzys=
X-Received: by 2002:a05:622a:11d3:b0:4af:1535:6b53 with SMTP id
 d75a77b69052e-4b291bbdfdfmr24247191cf.54.1755680124542; Wed, 20 Aug 2025
 01:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
In-Reply-To: <D5420EF2-6BA6-4789-A06A-D1105A3C33D4@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 10:55:12 +0200
X-Gm-Features: Ac12FXyUk9U2BD5ab17RBeP0LlcO6BAKZygfWvTdoZSnBgGcz8gaw_tlQOpNzxU
Message-ID: <CAJfpegvmhpyab2-kaud3VG47Tbjh0qG_o7G-3o6pV78M8O++tQ@mail.gmail.com>
Subject: Re: Questions about FUSE_NOTIFY_INVAL_ENTRY
To: Jim Harris <jiharris@nvidia.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Roman Spiegelman <rspiegelman@nvidia.com>, Ben Walker <benwalker@nvidia.com>, 
	Oren Duer <oren@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 at 01:35, Jim Harris <jiharris@nvidia.com> wrote:

> Can we safely depend on the FUSE_NOTIFY_INVAL_ENTRY notifications to trig=
ger FORGET commands for the associated inodes? If not, can we consider addi=
ng a new FUSE_NOTIFY_DROP_ENTRY notification that would ask the kernel to r=
elease the inode and send a FORGET command when memory pressure or clean-up=
 is needed by the device?

As far as I understand what you want is drop the entry from the cache
*if it is unused*.  Plain FUSE_NOTIFY_INVAL_ENTRY will unhash the
dentry regardless of its refcount, of course FORGET will be sent only
after the reference is released.

FUSE_NOTIFY_INVAL_ENTRY with FUSE_EXPIRE_ONLY will do something like
your desired FUSE_NOTIFY_DROP_ENTRY operation, at least on virtiofs
(fc->delete_stale is on).  I notice there's a fuse_dir_changed() call
regardless of FUSE_EXPIRE_ONLY, which is not appropriate for the drop
case, this can probably be moved inside the !FUSE_EXPIRE_ONLY branch.

The other question is whether something more efficient should be
added. E.g. FUSE_NOTIFY_SHRINK_LOOKUP_CACHE with a num_drop argument
that tells fuse to try to drop this many unused entries?

Thanks,
Miklos
