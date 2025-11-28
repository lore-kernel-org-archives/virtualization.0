Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0781724
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293430; cv=none; b=ThT4jn28rEKpB+UVen04DtexmAlwmHBpnc+2945NnC/PaX1fkrz/31Rc1js5jGuH1M8BXv5Z5Xjp66mo2hC0GjOfjIE/ZXnsR1VrC/g80Xq9Jqdz0vy8Ve8K/NF3IRon2Pqh3XUr6dmfgdk5pgG4jtBZ5vdpc9lErhosYKlB1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293430; c=relaxed/simple;
	bh=KBcsmp5at+jJviL3J+0mcROw+lr8j4mNJ+AGY+9OtGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX0i4aVrvWpZ1RLyBbbC0lYkcxYRZe0aN6rpTt/Dj6THd6jyLz2TAkfXH++0YyT0TUzHrQjXSfIe5jSNocmcAsmo6l3O/vTTcThqpK7Sc23gBjT3+1kot88De6AHeWVhweC9yJIJUqhvycx31yKG08N0xHsPSXmEmwMUtthm0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EohoMbcs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EohoMbcs"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edaf8773c4so16567061cf.1
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 17:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764293428; x=1764898228; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=EohoMbcslBppWCzyB78X0zdPUNazPZ+8ULHM/CB+1nxoiM5i34w5x6N51p9GbRm31g
         nL2+wQVDPaEK7VbUMREkHLMucLKNjZUV7jn/PSSp4EwX1Ad4Ynm/WsPG5KqQGEUa6ApI
         TdeqPqTpAQIvPKJbCNuOAwd5v4T2f/cHDrn44XHK5JidfVviE0kakqc8QlAJBbK4Qz48
         g+qH1iOCHXfYRSy3OaDmahzOWlPhv6oLq6scohMU8qtZXz0Hy0EF0+OjcHVd6CUMgXpZ
         RI/P1ty+0fgEvclEs9VPhgt2kT8NZa5fFXXVqPcl9d1ZnhvzMpH0QOf+agOuGYgn7URI
         A1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764293428; x=1764898228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5P89IZigPftxBdPjv0hBiMVJle7Ici8oyWvWVUIt1w=;
        b=oCUtRapImgeO2F57WU8QHfCR3ZmyxhyT7pr1zI3VtbSmlMzSkfonjjxZiF9lqJiqCC
         Xu37YSaQ/TPINftKG1eIpSszFOnI91MEcvgRsZdw9OP55XrgO4qwjNWWZHkjO9loMUTB
         8pxJk5iE6i/fx5IYRksW+mJRGnT02EIfukLeTzplfl141St9A7RyobNk1F09/mDxoDEh
         yo5XztopJ7lyn6pF1zDaHe9FpU992CLae3kjQLsEaHAVbkk/WPkmvuUN0Cy915YyTPYt
         jQZoZUf6Wfto7dnP216LRG8pEj2JgyiFazHV+tScxXLunu/m1l8tUnLWJQ0LT4rm2ajm
         S41w==
X-Forwarded-Encrypted: i=1; AJvYcCVxOiTHffispyZhCpFe8nDNupcWmlQkyQKW9AuNuKv6nJ2p+YOCgRm16/kAoBA1kLAop+Qr+Ulsxu8NTjeZnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGO/XB8HAWTQCEHk4v61LzOaQ4qzuLkeaXPw+BYOVU4386d01O
	eNolT1RUGwUqsMe9zLLZllogiA/E6fzVwxLt4sTmEH3SkM8MM/i8wwv3wB92YVNamWJ78SwF/wW
	T1XZYlW+X8bpVw59/SvSW+vneoMRTC3E=
X-Gm-Gg: ASbGnctF3J+doslGhI//bi54phJxaIrnIavtiEzwDU7zcEs5c7xkVDaxVPVu+TTZwn7
	ICXNUq3GTOohyG7ZwDCTQy4s564CvsvIMrm5uh6ZwsQ3k45+mRI0F111Hb18Wh8gtAathoHWqQm
	KB79+rxN23NyVyc10L9Jmgy5mTubklMGnRO077kWOC575AoPTwbQh/GGbdpFIMXNERLyGMS1OzP
	PS8Xf5xu4RLDaCcwH9rVTa/Y6jyxM9bfuuIoaBPXqaWBTLY6v2mUUxSl6BMmY4XazLz/NE=
X-Google-Smtp-Source: AGHT+IHLwC+N+hhLqdlufghZ5fhnM4rSYysjvUV/1fIoNRweHCYWM0pQrvWGMYNUf8igtQ6F3vcEMbZAHieS7voSeP4=
X-Received: by 2002:ac8:57d0:0:b0:4ee:827:7e62 with SMTP id
 d75a77b69052e-4ee58b05b62mr339066531cf.82.1764293427985; Thu, 27 Nov 2025
 17:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org> <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org> <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org>
In-Reply-To: <aSf6T6z6f2YqQRPH@infradead.org>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 28 Nov 2025 09:29:52 +0800
X-Gm-Features: AWmQ_bnZka8N-6d6tnub2wv_mKK_srvt07g0FExU0PMtOqpsh3yITqQM0jweo2c
Message-ID: <CANubcdVhDZ+G5brj6g+mBBOHLyeyM9gWaLJ+EKwyWXJjSoi1SQ@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B411=E6=9C=8827=
=E6=97=A5=E5=91=A8=E5=9B=9B 15:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 27, 2025 at 03:05:29PM +0800, Stephen Zhang wrote:
> > No, they are not using bcache.
>
> Then please figure out how bio_chain_endio even gets called in this
> setup.  I think for mainline the approach should be to fix bcache
> and eorfs to not call into ->bi_end_io and add a BUG_ON() to
> bio_chain_endio to ensure no new callers appear.  I
>

Okay, thanks for the suggestion.

> > If there are no further objections or other insights regarding this iss=
ue,
> > I will proceed with creating a v2 of this series.
>
> Not sure how that is helpful.  You have a problem on a kernel from stone
> age, can't explain what actually happens and propose something that is
> mostly a no-op in mainline, with the callers that could even reach the
> area being clear API misuse.
>

Analysis of the 4.19 kernel bug confirmed it was not caused by the
->bi_end_io call. Instead, this investigation led us to discover a differen=
t bug
in the upstream kernel. The v2 patch series is dedicated to fixing this new=
ly
found upstream issue.

Thanks,
shida
>
