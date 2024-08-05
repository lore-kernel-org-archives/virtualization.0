Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007614A85
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821553; cv=none; b=pHvhGwo+LW/hulsKdaK1dICfZBKIKkKNR1Qokp07NgeaPNNF+8RM8jI37DHgsVN51HXQAdoHQcOiNRd1IwuOkv9KeCIj5gcnyJ6Dvb4uZx6FX/aGWwMC7CO2snunm+7NhaGe92qvi6muSYfM4B3Wtry34dPaQQSWb0WGF74Br8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821553; c=relaxed/simple;
	bh=7eY1QssSA6yvdxMIRziI8rmKqJcfx/S+KXoHbvdcozk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlwfldLDMLY/blITDPnrfhJfp7A0EBr3HxNdK3+LzZpLSlSPMF1A5WelOfsrCzGV59oVzD6eDpeal14YX8j5udV9bdr7YZyPcehQDLmFwuJzbXMG21N1nn/YYBtAK2+YI1ulMx94qtlnUj7NYhxa4HDiwpFpNDIRPB+fgKeTawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvnLiFtq; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvnLiFtq"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-83446a5601bso3121930241.0
        for <virtualization@lists.linux.dev>; Sun, 04 Aug 2024 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722821550; x=1723426350; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N5glQdSVR2RR0Hk5zcwnQYnTX6UnuAlGQrqOAoIES8=;
        b=AvnLiFtqJVgoyTKmQfC/fmF7B6uz1gir/mKKpgpDCdFR0vJ2aBQr3gt2sssl03LadC
         zQE4UX6F2OQBOS1QOMOYUIf7sihaAM4UKpPXd6Z0D/RdEp/mOvLGJ96nLdl+FwodbLLk
         0Fufby1Emw/LtYkSvq8uPVLN63w+pwsJp7/sswzY+6hAFeWLkIdRYCAPMkRz1MgdReyQ
         5ghoD8e4IkNmMI8cK0u+2yT2w7PgwCzd1du3yEsjQq+aGVKKCKVM0XDKG0Na87pI5sWm
         XAP0cRk9TazdS1YiebmuuBPuUIJDSop+EtJOVZPgQ5qf6d6FLHL+NtCNOfqut4Xu0LdF
         7zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722821550; x=1723426350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N5glQdSVR2RR0Hk5zcwnQYnTX6UnuAlGQrqOAoIES8=;
        b=fwQBCkNt6S0FqI+wRFDP81zOTiKQPrS05Tx6v+sfsWqZ++kfHlnoMXMTE3mZ2zWFcB
         JgEX8oyQUH1Ko4O2p6fRlUD3A73ChiVx9EYpCkF6CZ4Qhbdt3Yr2KCxI7qlcaRbtthra
         HD53W4A3RSw/aSLK32semj7zW7L0gJsvCstTO9t7NeYKn7WOMEnk8qtpX8qWK3ZYbdrm
         iKQRqnLqJwYPtbu0bz0QOB1n7ssuBAiMNxwOxGWVprcsEfdP/m8OPL6t3m+1XTc3G6ev
         EmJBOm2AQDzLSt7EAWC1DU0R2bwXQz9FRytmAZmc5z0FEt9VIdXTKLDD1IHUCq2dF61P
         eneQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKtsCF/V+gnaWLHhbylyJEw+e7U8ZXWiu9CZEfhiVAFACz+KCAqHoR+c46kSxWMz89l7NBjyi/yO0iF28CMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRF0N0Xy8P2LvMagideMcIXIXZLIy7lus8LCDeVOM4srYZw8jr
	oPGtIKG1XT22rkb5M99ee6V9M9D5ZmAHcEwsg11FW7kKjmIGeS/8Y9DrvLFhnomvY/wmiCknf3j
	v52sC6+F1QRY580Q7JcmjNxpscJg=
X-Google-Smtp-Source: AGHT+IHlZ3rFD3g/29XAaqNiQcBTtkHVtg/oK1Vbw8GOa/ClL3c2Z1ULbHrxc5nNLGqMSoO1GysdyfJ90pMhY9vzhV8=
X-Received: by 2002:a05:6102:c8d:b0:48f:b1d3:4890 with SMTP id
 ada2fe7eead31-4945bf33391mr9330717137.31.1722821550250; Sun, 04 Aug 2024
 18:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-2-21cnbao@gmail.com>
 <CACGkMEsZPBbQfh+kyjn0nFb76Ad8_o=CXxD2hJt5fxoPa3rhvA@mail.gmail.com>
 <CAGsJ_4wDOH1WoR0viTMO7vf_K6r1ET0VQ4-A4gwqirHvsqwE8A@mail.gmail.com>
 <CACGkMEuzYXp51h2tPk29HKhvSfgsC5WSYtGt==SVMDU-0YSPEg@mail.gmail.com>
 <CAGsJ_4z+-XdAEt+XrxGTnoB4PnimKXhg0JciiwPST-OQYit+-g@mail.gmail.com>
 <CACGkMEvnfFVWWd9++BkZu=7iL8+yo71Fr=R00sTJ+pZUbKbiXw@mail.gmail.com>
 <CAGsJ_4w9UrgBR9gs-J74036JBXaod2OE0WOtPiMYyw+ov7VcHQ@mail.gmail.com>
 <a7276007-7567-4f8b-a9c8-e491e571c80f@I-love.SAKURA.ne.jp> <CACGkMEuqnkN2LUwUkRzmR4jQtDHBb02KJY0assOhc+s9wQ-qUQ@mail.gmail.com>
In-Reply-To: <CACGkMEuqnkN2LUwUkRzmR4jQtDHBb02KJY0assOhc+s9wQ-qUQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 5 Aug 2024 13:32:19 +1200
Message-ID: <CAGsJ_4yJ1XO0_9OUW+jhosi02=6bC6yPFhRQ=P5tSckikSV3bg@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to
 misusing __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Maxime Coquelin <maxime.coquelin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:37=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Jul 31, 2024 at 6:21=E2=80=AFPM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2024/07/31 14:05, Barry Song wrote:
> > > Jason,
> > > Thank you very much. Also, Tetsuo reminded me that kmalloc_array() mi=
ght be
> > > problematic if the count is too large:
> > >  pages =3D kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NO=
FAIL);
> >
> > If "count" is guaranteed to be count <=3D 16, this might be tolerable.
>
> It's not unfortunately, the maximum bounce buffer size is:
>
> #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>
> >
> > Consider a situation where current thread was chosen as an global OOM v=
ictim.
> > Trying to allocate "count" pages using
> >
> >         for (i =3D 0; i < count; i++)
> >                 pages[i] =3D alloc_page(GFP_KERNEL | __GFP_NOFAIL);
> >
> > is not good.
>
> Right, I wonder if we need to add a shrink to reclaim the pages that
> belong to VDUSE bounce pages.
>
> >
> > >
> > > You might want to consider using vmalloc_array() or kvmalloc_array() =
instead
> > > when you send a new version.
> >
> > There is a limitation at https://elixir.bootlin.com/linux/v6.11-rc1/sou=
rce/mm/page_alloc.c#L3033
> > that you must satisfy count <=3D PAGE_SIZE * 2 / sizeof(*pages) if you =
use __GFP_NOFAIL.
> >
> > But as already explained above, allocating 1024 pages (assuming PAGE_SI=
ZE is 4096 and
> > pointer size is 8) when current thread was chosen as an OOM victim is n=
ot recommended.
> > You should implement proper error handling instead of using __GFP_NOFAI=
L if count can
> > become large.
>
> I think I need to consider a way to avoid __GFP_NOFAIL. A easy way is
> not to free the kernel bounce pages, then we don't need to allocate
> them again.

Let's try to do a fix for this patch as we are waiting for your official pa=
tch
in mm.

I guess, further optimization can be a separate patch later in the driver's
tree :-)

>
> Thanks
>
> >
> >
>
