Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F132FA0EE
	for <virtualization@lists.linux.dev>; Mon,  1 Dec 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764577822; cv=none; b=tsJHatddO/tSddVSxWqkCHveQWh4yJNQVBocwPqpEL7n46Pp4B43gSjE4CtCMc9XUeo+bYVcFQGMS0HLVL/7JFAkSRjI9tkYbcyuacfpK6vsGtySelbx/mSecOWkQl1rf+US6o0gXjxiSgyZbjQc5b+hbKSQ/k2W3u9B7LIRmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764577822; c=relaxed/simple;
	bh=SwVqI6MJM5Lrg97Ok9vpLMdiyd5GgCZUgGLi9eNg6mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCyZSyLeJFSuM5h77cQ5iSduGDzH0b2DrsmsWAteIlT3X7ul3LtUWBsqW7Sg8KBqNmWsX0gQ2Fw6++pzItdkc3Jg2nQEKvqMKwh5HHDOb2fVP855fiMrEPrgBwpzY729XpWHRNaBkHH2c7XRUbWV1C9zFLHwa28pAaSmgecjOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMIXHQAi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMIXHQAi"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8823dfa84c5so41142076d6.3
        for <virtualization@lists.linux.dev>; Mon, 01 Dec 2025 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764577816; x=1765182616; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eJc3g3YpMCQbgaI10ZHeYIFEHAk4BHGKD03PpLocf4=;
        b=CMIXHQAi/VWS4qNr3uivFtCNqKrSEZgvZnulQCMn4u/3MQ+oolAbZco4GGLSyFQqaM
         MEbgtJmXWksrTwTUIkAF5Mi+TMP7/B3gAMegIh/UISK/oHUM+l48+czn5es1lKeZPYqL
         nU69So8nBCasMeSPLZreN35tkoQBMu2EZbXBUTDO9h6R2pVA71CTmX6AHUwhJfnvicEP
         h68MXu48+RGdJinfBRB1OgCHgwKEtN556+qTIQYIwpvVQsZdDjJX7emEyDIPTQrEF8h/
         p6jePebc5jreiPxejC0xI5xhEspUXebm18bKZllGqhSJxUbPMWP5AZUY4TCRKmW0OTp/
         2aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764577816; x=1765182616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2eJc3g3YpMCQbgaI10ZHeYIFEHAk4BHGKD03PpLocf4=;
        b=wNOFuSgthA1/JLz29IxSZkwVBxNJ3/+Np7r9+vbF9mjSlgPO4Tn27Lc6H2FDsbhMt9
         yN/yl6Rwq/FDcezomFbdIiQ69XZ2FVWKDHr/pSZJrQvmyeutr+7hWyitkr6h/vA3E5Rl
         76SrLAx+RgypTKPrJKRjKUt7RjAUxv3nOMckle95FIcjYUCXWEu6ZC4J5RsSehadXII5
         u+BftYqv2T+1Ryk/U0iI/3wJL3YmtwS8UPC+vgMQ1pcc4pGlZyD698Zvkb9HNWB1BUdf
         MsS6vajHLfKrKSGqQqvAsTl7kL1MqusZ7SU16r1fCa5M3WWtIlzJLoJu0U9GRD5f+d6p
         FSQg==
X-Forwarded-Encrypted: i=1; AJvYcCX4q7zYjaPaZKidrATY+R0VCOIJ74ejBIu43VvjBHUnaAd1Vlva8YxxdkhFzaFTnoiMw6pweZa63RZW7lQgvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx48ma89iZOUGyh5smqChl6p6kM8zfxvom2Qn8+t/bllSR0ChFx
	P89aoZp6jWU06NQF8v4fNYq3fz4f3jVEgfOWR6OcMGioWlyeW0+fVZS0Jb4ToUTx2tUC4w82N47
	P33QkxowdY4gSxwGxf1P28B5bZ6UQ4L4=
X-Gm-Gg: ASbGnctnU/8tPAI6kCo+0ciMNWrdWkw+H6XH1EjmTpvQ4lfQuiq1/T3i5EefV/6fEIw
	okqcOV4ugFOl6ud3f5DlMjtvakUsziOVtcjCpko2SEmHzN4FEasvjk+T1CYx5o5yLp+MZaOs7m+
	WeV6Ov4JQebh5xaJm7eZtDoUAy6wXQkExbTByuSrVPl0aH3poVGZ679MJ+FN3/+A9A7yzmH7ive
	8HJWPRvQsJePDGIwr/er0qEfTRfFOak98yOldi2rpci+D8984CF6QiCF63WQd+Gp3VAmWE=
X-Google-Smtp-Source: AGHT+IHsCmYuVPkQVfU+yWs4legJ9LdKct4F60FxyJiLbura9Wp1LF6O9gYr9xGvWJ06vP7t0LTxtkuDR8IlXcjYyW0=
X-Received: by 2002:a05:622a:392:b0:4ee:2bfb:1658 with SMTP id
 d75a77b69052e-4ee588e099cmr550604311cf.45.1764577816018; Mon, 01 Dec 2025
 00:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
 <20251129090122.2457896-2-zhangshida@kylinos.cn> <DFAC6F10-B224-4524-9D8F-506B5312A2E8@coly.li>
In-Reply-To: <DFAC6F10-B224-4524-9D8F-506B5312A2E8@coly.li>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 16:29:40 +0800
X-Gm-Features: AWmQ_bnNbz0I6L6p96dlX3gePB04hX8D_DO2J9xuy2-homPgSXL859tuVJ_3RFk
Message-ID: <CANubcdWbKoC3RgPz1Eb=auxfnq-4_tMoqWiRaZiPcZUxNHYwVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] md: bcache: fix improper use of bi_end_io
To: Coly Li <colyli@fnnas.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, agruenba@redhat.com, 
	ming.lei@redhat.com, hsiangkao@linux.alibaba.com, csander@purestorage.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Coly Li <colyli@fnnas.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=B8=80 13:45=E5=86=99=E9=81=93=EF=BC=9A
>
> > 2025=E5=B9=B411=E6=9C=8829=E6=97=A5 17:01=EF=BC=8Czhangshida <starzhang=
zsd@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Don't call bio->bi_end_io() directly. Use the bio_endio() helper
> > function instead, which handles completion more safely and uniformly.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> > drivers/md/bcache/request.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> > index af345dc6fde..82fdea7dea7 100644
> > --- a/drivers/md/bcache/request.c
> > +++ b/drivers/md/bcache/request.c
>
> [snipped]
>
> The patch is good. Please modify the patch subject to:  bcache: fix impro=
per use of bi_end_io
>
> You may directly send the refined version to linux-bcache mailing list, I=
 will take it.
>

Thank you. This has now been taken care of.

Thanks,
Shida

> Thanks.
>
> Coly Li
