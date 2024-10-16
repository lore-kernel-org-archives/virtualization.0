Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94888205E05
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074206; cv=none; b=uzz3H46dLjcsHPsuJpAKWrMxAnhjW5ZkUPLBlBNEJJXhGggN1I04mpOU3ln48HICX63LACOzscqLiqdTo5uEcgiK8TfzNwUkR36lm/myl1h0HM1CmbDnYMyylvOnQPR7ZdBcTZlFaJ0yeu4cMWTPLqGtbq61w6sskQ3CGskoGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074206; c=relaxed/simple;
	bh=q/4Xnfo2QoXLnMrsQKtONWcJi0JMSdcZjjDyjdhf5aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIFWgZirZLs7hGNsXB4Ltvh55Z8K/96wnXG8Y6qSFhrwGS+0HWoNM9k6Kbh0bU/jX5CNN5YDLhx1VbdgxvQgdU/skMwXpVb/xVbi/lBAQYkf/lKmR47BJ/6dT4zs0FJs+MBF9IEqQGpSX4SQFdL1+9LB39ftsUyIAsfzrk6Qf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3SSt4/I; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3SSt4/I"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fb49c64aso4363763e87.0
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729074203; x=1729679003; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/4Xnfo2QoXLnMrsQKtONWcJi0JMSdcZjjDyjdhf5aQ=;
        b=k3SSt4/IbAGqr4M7HCjvEmIhwBObD9m8F1APWRDnkSUR7G3yeXzo6ClIXvA8VnvioE
         jJ4G09r9SjzEkFV76WZ5VAV/OxBpFbet2gI6i4LT3i35Lde1rcYWKMjv4NqubAm6+AQP
         3UoU0Coskf2RuJs4DG/iFRppR0618lxbgOZe3x1xulWI4n2ojMC5zWIDRSV0yozj8n5r
         gB8ph9oX4bLBwUWHL/em2i7HzEJ1NJH19UUhoQXA8jFgtMZnwrDY/XPFzMrAzJXhlmF7
         hubgsJyr4WlqNDZ9t70cSXY2HLbxmcai7bnpHjKHo0yAoSgI6qisp+ofAnR2ac1KO7VJ
         WS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074203; x=1729679003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/4Xnfo2QoXLnMrsQKtONWcJi0JMSdcZjjDyjdhf5aQ=;
        b=ceD8GdHP1sTi4Jv86vDLoWbHTLNlNp98mOfFwMYu1/zBFl1xBoc2zAKxT7tQprWBxj
         5EerDgCFR4ANO4ZePKAvXiegGFmMnoXgmK8r9ftVL3qvkAkeV2Ivwth4lKlCwA/5/yG6
         aV/k5o6O5gEcn87HVFRnrBFj77XjhGDPqUHjA8lr9gVBnqdstFNEqJq9iy94AqWLK+IE
         LcsTN5otZjHH+zPM8VpfSLiMx/Lvn5o4oi/GOmKQIYWEh0vXqUyd2Nk6ML874AehCEed
         RoRbrracfGY0pkrDJgw9Inff/Xb7x6rXl/jbOVN87XNN3X3BH9rW8+8bxVg8VNd6yRMn
         yBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1bHqcJwCynguzA26fs0p4wSNkH+b5GUBb6O4zWCEQ9vkSbXGdeMbbu0BHAvJoXEsMKDDylu3q6DlU8i+0VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1N7hrju1TKQ9GlGnDGNIuCYYxNuwtmXVJshcCVDhkCkpud26P
	3BQFWQOGT26L6LpsXXsJ12mCPCqWHz2yn5FAedc0IUyH4NfEhYUqjUu9EkUCtM1nqP3WhX+sZVc
	cG/aDI7FzmwO1jDW02QW245CJygufNpIw
X-Google-Smtp-Source: AGHT+IHecL3xyZYXLTNm5iA6rs/KvXKjLMOFmfwx3AdAWDJHF6WIEmSzNsGABI2L/R0hEVHbIIgQ2Q6LGf7wWO/MM7E=
X-Received: by 2002:a05:6512:10d1:b0:536:a695:9414 with SMTP id
 2adb3069b0e04-539e54d7907mr9596702e87.6.1729074202511; Wed, 16 Oct 2024
 03:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241016072553.8891-2-pstanner@redhat.com> <Zw-CqayFcWzOwci_@smile.fi.intel.com>
 <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
In-Reply-To: <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Oct 2024 13:22:44 +0300
Message-ID: <CAHp75VcO5g1UerroLaiUa4n7Aj8TPQ594tPGdG-T-xkh4uqyCA@mail.gmail.com>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 12:22=E2=80=AFPM Philipp Stanner <pstanner@redhat.c=
om> wrote:
> On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> > On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:

...

> > > ---
> >
> > I haven't found the reason for resending. Can you elaborate here?
>
> Impatience ;p
>
> This is not a v2.

It doesn't matter, the reviewers and maintainers should get a clue
which version is to be used (even if it's a simple resend) and why it
has been sent.

> I mean, it's a bug, easy to fix and merge [and it's blocking my other
> PCI work, *cough*]. Should contributors wait longer than 8 days until
> resending in your opinion?

Usually we may ping for that. And yeah, depending on the maintainers
it takes a while to get it to the point. In some (quite rare I
believe) cases we may escalate up to Linus about this. I probably has
only one case like that in my full period of working on the Linux
kernel project (several years).

--=20
With Best Regards,
Andy Shevchenko
