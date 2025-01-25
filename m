Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE217578
	for <virtualization@lists.linux.dev>; Sat, 25 Jan 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737820922; cv=none; b=JV3LNhf+xAZ2c1JvAWlcZfTLtOiJmUhBEf8yAmtJ9+2xsA63l7p3N4fmgV9rHX2unb+JM0wD93LST/xU5JxjDg41y3FmhiNEsrWnYY/BispJA9vKlkOPswNHcEkLCOPqH9RA89MKjDzLYeUaKBEf1XZekhM7cgLIKLLt73wYFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737820922; c=relaxed/simple;
	bh=uE5Q+TPkQGHQlA8Hl9aBMXaZm5tKr+Bq4VsFQJyjFn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqrsuebXFzvqrz6cH2jAsPPOYO+9qaK670OJbaO4lzNAOqSjPcy/YMeohchHXrUBtooGyBjXqNV293rxfL2hqn3gZNwhDE2J3+GtqThhgdAnQQ3xSykvBaPSRG0LttNMrVWCGIh+/pc9PJT2079T5mqSjo+Ymln2ay24u7YxpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com; spf=none smtp.mailfrom=virtualopensystems.com; dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b=aFbkmhyb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b="aFbkmhyb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso633599066b.1
        for <virtualization@lists.linux.dev>; Sat, 25 Jan 2025 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=virtualopensystems-com.20230601.gappssmtp.com; s=20230601; t=1737820919; x=1738425719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE5Q+TPkQGHQlA8Hl9aBMXaZm5tKr+Bq4VsFQJyjFn4=;
        b=aFbkmhybOGLmGioAaSnI9K9XwmpJvVTLcPyXp0zHQIKVDiaf8WPAOCKwNj96ax1ps8
         utxeFFGjl9JrQ0dVXNp2vguTnU3phbeNP0Z0EnoXXQjm5mh2FkP1ZpiDgP5dYhNJMIfo
         m4+U9zL+LIzlFh5zalxRKadowgrkSlsk2LpiR+8EmoOvqn4DKRATKdcAjBhcS93THfe+
         Mvdqn2SEHscfLfe7pXkCf3QoYQI2OYSNyOZnYmAiaiqhUYpQH7oZp+wN74U+mePlvlhV
         XSrUwsDPAXX7GpKLuyvkTPzBa0RxivJxBSR3Xeut7c/u54yTYoZheDERp7byiGiZg2VN
         3kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737820919; x=1738425719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE5Q+TPkQGHQlA8Hl9aBMXaZm5tKr+Bq4VsFQJyjFn4=;
        b=uYs3Ip7a9FMhcyWbG0dn3CF3wyhmQKYYcf0MjOt6QALwYgMoLE+DhHZRGBSfdbDRBO
         LEQaEpXjguKE4q+uPlHu1hBwuK+rbT7KWJzjUJEcppkKjz6AH6g/ZDbS3H5r3/qL1PR4
         jYnAXygaDofKyQCWi4mQGVJ9uglWTPgIdHTNmbhdoM0cNhEz8i0m2WpTFf4246lTsszK
         0KY1xEfEtb4aiaWQzFktOdAfAUl2TyNSmeF3PuML9PfFehP8ouRkdpbTtJCxZrzDRWcP
         aQZIyIKClPvAfUatfmBJAiD5FTGRSfcelpNFSxKOPaBLY07g6B3Dc6rs5+7SzzRvUz+s
         x8uw==
X-Forwarded-Encrypted: i=1; AJvYcCVAEd4REF6SOypnEhJNtNDQNtQl6ufelYrgMB6WdtMmkdQo0BwRUEE4IzNtgP091lEm/V6c2RIdexdr67QC3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCM9ZG8GL+Tq0vaSFNzc9ovteWSeLxX9tb1xHL/Sx4xfOSQqcL
	jrDxNIKUdRnp3hOlz/TdsN5M3LjiRTmlThDm6lr+zy3c2fVMpNbpJbeQKSC9FB0=
X-Gm-Gg: ASbGncvCUteoqH5oUrn/wIZXdJYbUCOVR4WXwIW4QD9XNoXKzFmdOJR8CBHzbk+aHL9
	pmANoiOAuVjkOgF5dEKto7UoBrnTkuXFOKF51MBWgr5TB01XlEYBRzN9lxDtcU32eN9OAKT/Cn3
	f5VSpoknZDu5jiQRnPPR0vcP+UG+TTErlpenPx5H7TjJyDB4dViYcPmMhlTECeDAPaWT4fllQ5m
	gs1RkXmzeNs6oA1JqR4VpLaIzORGLxji5K0dfm15Sl+XntI7BmVVV2Mp1KGcgsetiKq1sn3BAYr
	RJviZBKolk5kug9Vw7BlB+vj19YywZa2sWBWTI0pOA==
X-Google-Smtp-Source: AGHT+IFAV3Tgpgl28GXyZGKy+h50Q+HKeIA9DuUrxTSTxEIlXQlE65gkXX+PKJ4CfS8KKTrCnL7Vhg==
X-Received: by 2002:a17:907:d0f:b0:aa6:a9fe:46dd with SMTP id a640c23a62f3a-ab38b3aff9fmr3558037666b.38.1737820918687;
        Sat, 25 Jan 2025 08:01:58 -0800 (PST)
Received: from ritos-ThinkPad.. ([45.66.41.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e631a2sm300150066b.48.2025.01.25.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 08:01:58 -0800 (PST)
From: t.ampelikiotis@virtualopensystems.com
To: stefanha@gmail.com
Cc: virtio-dev@lists.oasis-open.org,
	anna@virtualopensystems.com,
	a.rigo@virtualopensystems.com,
	m.paolino@virtualopensystems.com,
	s.raho@virtualopensystems.com,
	chou.kensou@jp.panasonic.com,
	wminer@linuxfoundation.org,
	jsmoeller@linuxfoundation.org,
	virtualization@lists.linux.dev,
	stefanha@redhat.com,
	xuanzhuo@linux.alibaba.com,
	sgarzare@redhat.com,
	jasowang@redhat.com
Subject: Re: [virtio-dev] [RFC PATCH 1/1] Virtio-loopback: a virtio based HAL for non-virtualized environments
Date: Sat, 25 Jan 2025 18:01:54 +0200
Message-Id: <20250125160154.120339-1-t.ampelikiotis@virtualopensystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJSP0QXdvWWnp-61WMeWTLnDLPWiZVqvg3Nsc3zqLuEDkxARFw@mail.gmail.com>
References: <CAJSP0QXdvWWnp-61WMeWTLnDLPWiZVqvg3Nsc3zqLuEDkxARFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Dec 21, 2024 at 3:44 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, 20 Dec 2024 at 10:56, Timos Ampelikiotis
> <t.ampelikiotis@virtualopensystems.com> wrote:
> >
> >
> >
> > On Wed, Dec 4, 2024 at 7:18 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >>
> >> On Wed, 4 Dec 2024 at 10:38, <t.ampelikiotis@virtualopensystems.com> wrote:
> >> >
> >> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> >> >
> >> > This commit, is based on virtio MMIO driver, adds support
> >> > for dynamic allocated (platform) virtio devices. This
> >> > allows applications running in native environments to use
> >> > virtio drivers as a HAL and eventually communicate with
> >> > user-space drivers (implementing the vhost-user protocol).

[...]

> > The current implementation of the driver collaborates with our
> > user-space counterpart (adapter application) in order to establish
> > the control plane with the vhost-user device, and indeed there is
> > partially a trust relationship.
> >
> > Currently we are working on updating the API between driver and the
> > user-space counterpart in order to make the driver more robust
> > and make sure that leaks like this do not happen.
>
> Okay. Please take kernel lockdown into account:
> https://www.man7.org/linux/man-pages/man7/kernel_lockdown.7.html
>
> Userspace must not be able to modify arbitrary kernel memory or load
> code. Even root cannot do this except for limited mechanisms like
> loading signed kernel modules.

Thanks, I fully agree!

I have implemented a new version of virtio-loopback in which I am
adapting the bouncing buffer logic from vDUSE which I believe it
covers partially what you suggested.
