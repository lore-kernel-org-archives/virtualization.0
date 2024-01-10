Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6B4C3AC
	for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EeTRTi3t"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5574feb7958so5076980a12.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1704901656; x=1705506456; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioFiiBHR52hjIdzvcsREnH6I97Ku4C9Wv6P6MdH9Wh4=;
        b=EeTRTi3tc8Yh298U08w436zYW4HyOn++U84HG9W/oEZCTL0kA5oyKeMczMQxEvP9Nh
         6TEHeto1lSABQ06mrrAqaCgWrw/A9D0FCDG0wAm90Ec84TSJZBw6cuvA3S+H+DnBz7uN
         8YauIpc9msb5pU5ilWUvQH8MAQoXruONUIf6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901656; x=1705506456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioFiiBHR52hjIdzvcsREnH6I97Ku4C9Wv6P6MdH9Wh4=;
        b=ZYjVGIAZd/lGkoYDzxfUUH9J+P4qBs4pYnbBBzmfiMndgeFfxtEhWIrXxXgSG4/TZq
         zIOgzu5VOx7+OFAXKZUyoTXez309UuqbdUa9QFEYaQL0+ZgGjJ9FS/R2JPxCs/JlGqVj
         /OF48AR54EvohV8T3QLHXue6ooyubz5C67he/QechzvM9Dt7R9RKxWfCQAl6ok8vf5tC
         1x2DlgILhVv9nJMaxl8iWc6ToEj6bW0DoXUl4ptuPvavwqVaPXvqm1Wm+80SYx0DnBfc
         grbWqK9xW02E6AbgFSMLS86IDeVvO3CFOwTJvdQSZFu+v7db4i1eaOcS89Iw94JlZovw
         giXg==
X-Gm-Message-State: AOJu0Yzaxwk78Hix4x9cH//NAX3W4eZY6rDIFFO2eL92SCYTmzvGecep
	DAIRQdJkd/Q73Bdff7Ex8vJZFVFB3ylbEYp7TUTnHGpC2e5ZdQ==
X-Google-Smtp-Source: AGHT+IHA+OuPYsC1tzBqWdoxLHVwHiWSsYMXS2IR9ogBlapWDdJ3nk3Ig2HJ+z1HcTjDmTh0nn25aP29soAg7wAC96c=
X-Received: by 2002:a17:906:7d18:b0:a28:d163:ea39 with SMTP id
 u24-20020a1709067d1800b00a28d163ea39mr713908ejo.108.1704901655434; Wed, 10
 Jan 2024 07:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com> <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
In-Reply-To: <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jan 2024 16:47:23 +0100
Message-ID: <CAJfpeguE6E=s_t8WFVrJcXUar9ifr5+rhsmoJZYW5xWrTzRbMw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 at 16:19, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:

> > We need to find an alternative to refusing splice, since this is not
> > going to fly, IMO.
> The alternative is to not hold the lock. See the references in the
> cover letter for why this wasn't done. IMO a potential slight perf
> hit flies more than a total exclusion on the pipe.

IDGI.  This will make splice(2) return EINVAL for unprivileged fuse
files, right?

That would be a regression, not a perf hit, if the application is not
falling back to plain read; a reasonable scenario, considering splice
from files (including fuse) has worked on linux for a *long* time.

Thanks,
Mikos
