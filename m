Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E23A938
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736134; cv=none; b=PkslShSrVfYMf6FQ/mOXSZw7aMcBG+lo/5NjMqh9ajGwITdGLoyG4waOO5Z9/7GBVIrDXhlaQR3puim98SLCIl24L0bR+3avwEtH3aBxcOYjOQP8JK2ewvU8i+AgiFhByO4yBoK9UuTw3vyclEFo6wSNp35aev81jJQKi0juZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736134; c=relaxed/simple;
	bh=PjmdoL8aK6SpmWV+gcuuagXO08GZB4SplEuasH9OLnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4LAmAAs2hB4s/fztCMqMOyu19hrJAZlSqQMnwbgo4qKILxIn1I7yVv7TS0nC6gbxpIdU1s0v7welCgSc1ncxWXBORM/6loFeqofPjOOB/D0YK+SPm5rkw3pJFhZ3s/2q/jJRd66cTcdSE2CrRyFkO16mjH4KHf5ZiRjww9S8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXMSxtnU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXMSxtnU"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso6208637276.3
        for <virtualization@lists.linux.dev>; Tue, 14 May 2024 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715736132; x=1716340932; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjmdoL8aK6SpmWV+gcuuagXO08GZB4SplEuasH9OLnY=;
        b=yXMSxtnUgn6HQMnM6x/YiLvD4kUuQUkDUj3Lkvulk2quU5CzD9qFjsVh7eBzUOnBh6
         aaf12ih4fm/YgBsahZhmji/UnO+kfuGPc+VBtg/AvRhrSU8CIzvSaNSGPc84+Lfr5L7I
         WpYJjZMplCnclpLr1RdTqKJU/JqNw8DkTjQLR1lMs2O8BQINGhkPAOb4VgwUDr4l8XIY
         X74TI6Il+GU4JTRNGyNsz7gez4/WTgPMeLrxI2nqVXovqITk3bTl7UQm3thh0AZZ+FB1
         FoyIVWW7ljzNgTE5ip7BH1YPZfCq5Z78Luqu77kbQp+Ruj6kQgLkjmge8cg9C+JjGtdZ
         zmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715736132; x=1716340932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjmdoL8aK6SpmWV+gcuuagXO08GZB4SplEuasH9OLnY=;
        b=fUhbeGgvxinsIDhTmwXkhPM0o4x125hXI3QtiaLNouFUbXt0ATtidTA6ZV+kjVXPVz
         aODDDOSQ2dkS8FYUvOe9/AxjODqTVMfrtYfcDd6T7IA9lxx2StGLP5S0000KgYBbO9r1
         RLg/vDDahD3TCm97/LEI0xyowkkNyFSPRzbJjdVhpcC0naZgMw2HNwSCRWIYWefLczBk
         eqSInFRkM5f4T1kH5+Tp0mNRFMW5N9Xqhm55aOEVWLk0RafhJsfOAR9tcfUZezcLw6et
         eSJxhFLQJXB4E57xzBXaubn5//RGqynC403oqdSrbvBCG+D2Wvlu8ZJNuBQpFD2uCvBW
         Vdtg==
X-Forwarded-Encrypted: i=1; AJvYcCWhN7ye6zLrq8oxUNf+J+xcWZzllDxTQwjUmE1LxdNQ+WvlPwDR8cl+5OHC/NMLhRr633nAlshrp6KcmQ3gycklfy1dbdgE6sgx3/V/6DU=
X-Gm-Message-State: AOJu0YzvOx+yXv9kUNI4SHJ/tQLLk7Ue4YxNgQPmSYvK5ORtJPSJIVYi
	ubzjUjimRF8UdqbNOg331gCkGoZmDduyq/qIREaKroH85nYtQQ0YJdJ8KPkAHubdKMMEKKdLDu2
	DWN2UcgFPIQjT4f78MjWAvPaVUBvUOs/Mcv73
X-Google-Smtp-Source: AGHT+IFWUUjU6sUNOq/Evye+BgmL3GiqmZBAyQyzUv6knnlnP8bIsfU6R8l0apQ6lQi0JL7TPW8eDB/LOqLphZSlreA=
X-Received: by 2002:a25:b1a3:0:b0:dee:5cb6:483c with SMTP id
 3f1490d57ef6-dee5cb64977mr12258845276.49.1715736131408; Tue, 14 May 2024
 18:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240514020301.1835794-1-yuanchu@google.com> <2024051414-untie-deviant-ed35@gregkh>
In-Reply-To: <2024051414-untie-deviant-ed35@gregkh>
From: Yuanchu Xie <yuanchu@google.com>
Date: Tue, 14 May 2024 18:21:57 -0700
Message-ID: <CAJj2-QFnOjzwbsMrTcrzPsbCFchtJLM0hiJDbR-xe1HcmV+ytw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] virt: memctl: control guest physical memory properties
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 9:06=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 13, 2024 at 07:03:00PM -0700, Yuanchu Xie wrote:
> > Memctl provides a way for the guest to control its physical memory
> > properties, and enables optimizations and security features. For
> > example, the guest can provide information to the host where parts of a
> > hugepage may be unbacked, or sensitive data may not be swapped out, etc=
.
> >...
> Pretty generic name for a hardware-specific driver :(
It's not for real hardware btw. Its use case is similar to pvpanic
where the device is emulated by the VMM. I can change the name if it's
a problem.

> Yup, you write this to hardware, please use proper structures and types
> for that, otherwise you will have problems in the near future.
Thanks for the review and comments on endianness and using proper
types. Will do.

Thanks,
Yuanchu
