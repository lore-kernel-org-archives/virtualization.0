Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA48495CE
	for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B+fgKiib"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28ee72913aso892425466b.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1704894195; x=1705498995; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxoWcecCZExIIFdN0xtey41fgRaKWC8kWgC6rhb/9dY=;
        b=B+fgKiibMTo7l1AD2zW07rcBlUTw7zJY8+7RUyBLrn3wvftUIrPwQZ3Rnwyp8MF1k/
         2uB1xshnKGpVll2wXyM/muHb7lgNqMBuDCkAIqW+vbQeCmxVwmJ1ETwAiGfuvcj9/wBt
         8GEXUI1YfNhUNJdCMQAKda+vXJTGYg2CA+JEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894195; x=1705498995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxoWcecCZExIIFdN0xtey41fgRaKWC8kWgC6rhb/9dY=;
        b=J/K8ROEUo2VhDHF8jM37w1qiudAw7wSGiu8AiBcfH68razLMHWsZsWpTkpBeQrct4b
         tmo2WP4VUX5+eSZyh7IH2JRDsBpA3gvz0CHIjuCFFnwnuWk47JxE6MPZgVZ6LuGW9i7l
         DmsUU+bTYianQ29net93s+Wiqzc3FVxJXW93Atl1SFaqV+UNSJwBY6cBXafmIBn9L4AU
         HqR7AC3QILWIljLlvqD+67iHcXJPwEVBdE+SpfEJQlqBbL8ax7nFvHRocDgxPMy7WmAk
         MIcMMbjE/ZA/qgloNnTmmr3tPK7O4jgfVA3gEekO2PWUnjW6w9kEfSgHZit04lpOBiVE
         3TrA==
X-Gm-Message-State: AOJu0YyyMnNmgUEDSc7hhbk6D4HQtMkRftKuX4ToMWdVBZ+4tCzoxJJe
	trin1Gf0kFRWtuEUNBhbOShaDrm7axn25jss01PMGjfwyZQkBA==
X-Google-Smtp-Source: AGHT+IE7qXen0WzP3eRsTcPJeemmFisOpVGUmxTT0jNIjPU7JJsIbdU7hVIVpCEM3HkGIuIOnfGDYc1af8uv1zg7w4Q=
X-Received: by 2002:a17:906:fa85:b0:a2c:dfa:4f6 with SMTP id
 lt5-20020a170906fa8500b00a2c0dfa04f6mr92733ejb.16.1704894195507; Wed, 10 Jan
 2024 05:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz> <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jan 2024 14:43:04 +0100
Message-ID: <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 at 04:09, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> Potentially-blocking splice_reads are allowed for normal filesystems
> like NFS because they're blessed by root.
>
> FUSE is commonly used suid-root, and allows anyone to trivially create
> a file that, when spliced from, will just sleep forever with the pipe
> lock held.
>
> The only way IPC to the fusing process could be avoided is if
> !(ff->open_flags & FOPEN_DIRECT_IO) and the range was already cached
> and we weren't past the end. Just refuse it.

How is this not going to cause regressions out there?

We need to find an alternative to refusing splice, since this is not
going to fly, IMO.

Thanks,
Miklos
