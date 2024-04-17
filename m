Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA56A329
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336775; cv=none; b=DzwfYjRu27/EPQAt0TgZp9evNYGwYWBzTsEgBohL3SFgSvh/E4zvjajrKETpEQYoYq6DcEXVIS1DmvbkHN5wRsETBwHSRdjAirdnQOMgIW6v6EncKdCHOshviaZroj+uNIktbCdErUbGxvZbi+mfPX7yIj6rVhV9hvSIpU5XGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336775; c=relaxed/simple;
	bh=CWmxHDGHvwKLlTrAo9tcQkBkOjqsjCVQtIgPBHR9YPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxbMBH7arko1I0IWI55IX3WE0Sjwe3+juk602esARQ9JpmgsFbUJBKHDJoNuJQbbCAqR2LW0NRoNVMMJcm8Vq+qy29G7Jm48wyVPd2/Pm4nOOH1RX6UNwnwqxhNQ6bZprCP35gIPfdeHZw1dPV0DlZkYqEDqsnZYV2kVBhKIk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsiizhWR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsiizhWR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51addddbd4so605597266b.0
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713336772; x=1713941572; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWmxHDGHvwKLlTrAo9tcQkBkOjqsjCVQtIgPBHR9YPk=;
        b=WsiizhWRp6T0643tID9h19KGH073UZBJmskLGmzc54mOd00qbZF8FKO/IHcm+ceJZp
         QKHySDHEIjGuR4NQ32NtT6ucvTnz5ux5LvoY4wPeDtvoOza7NevnfhEHA2E2N+DgeqIQ
         LqZ+xTyI20M4y9efueCo7mVMFAjFA5Uzjg2tyiutcxRZsiFiZcMNFghA0tSwK6NDJlUh
         7z+lNhPnDIzCbUhrTMiqrTlgKe2AXG2unthp0jQVoYR7gUcKGflCqQgJc+GejBeWPOAI
         sbn+Vz2mdHXBJTcg8MTTsf17R4CN6cmpeN+HL53SR0WwDeU46ATh30/VweloVSQxYVTB
         p11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713336772; x=1713941572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWmxHDGHvwKLlTrAo9tcQkBkOjqsjCVQtIgPBHR9YPk=;
        b=VKAO/1ykbHBvaBJaj2HprDGAFAtJB5v5bp2bhaC+5HDXsfbP1CvwZ5t09SL/aDJZ55
         32O5zDeqcz6D5Z3xrb2vwYwbI512SLQDOf1BepsQFqyuMVsJUrFu0E2fqNIwOmBBeZ0B
         v2NTv4Z4ql14SUq1eTWiOWDfWTsf9pOERipYrAv6uVl9Tn14ZL2JC0xxQGP2enNeirgi
         iqz26Bm0sm4rFbtdf+epKM4RgCsBfLAffpuTKmam53QZr/hV84Y7gsDvegL4u6HUZLa+
         Y1WYZlsKrLrxrlDxwoK5RP7+fkNsGtgMZS1OlwpQeSRZo3z9CkbiOdLfhXVrqNddfNF6
         I0XA==
X-Forwarded-Encrypted: i=1; AJvYcCX3vR37En1zcsvgzFygCOh/PjCOLUkpFkjpUC3HjMEGQ06xU1IMyYgggsN2jArP2MLXwF8Jixtm+8xeXzdM0sG8tT9eqDiVPA1tfUZWbqU=
X-Gm-Message-State: AOJu0YzAkqc5H2C3SNllRtEA+3xDI8mv3AVJjXfdJlG6IAyM9NISsUoJ
	PlNXQXYe1i3fSZz+kdZY12ZFzGenW9nv2Yp/jPEWOuCQ4d3l3Ij9nw287ZebbFRLZdEjSZNNEOC
	/+hEyrBMmed8QC3NCplbHO8lvob8=
X-Google-Smtp-Source: AGHT+IEK6SyzNHNLWDVG9m38qQ/cHS9V7n27oz4LHCwjU2ANrSRhqTNprA8tBP8e2Pnl2lRCtgn8TgKrDQcQAHb5pLg=
X-Received: by 2002:a17:906:3913:b0:a52:2dce:64a6 with SMTP id
 f19-20020a170906391300b00a522dce64a6mr9081354eje.17.1713336771469; Tue, 16
 Apr 2024 23:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org> <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
 <20240416192952.1e740891@kernel.org> <CAL+tcoDj11Y7o2f0Eh8-FMk0BxjtAwCupWaW7n7bOXTUVgAWSQ@mail.gmail.com>
 <26755c1e-566b-402c-a709-eeebe11352aa@linux.alibaba.com>
In-Reply-To: <26755c1e-566b-402c-a709-eeebe11352aa@linux.alibaba.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 14:52:14 +0800
Message-ID: <CAL+tcoAS81uW_aikoWrDhO-qF-aFD5rU4GsEAy2hHbC9ex2q5w@mail.gmail.com>
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Simon Horman <horms@kernel.org>, Brett Creeley <bcreeley@amd.com>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/17 =E4=B8=8A=E5=8D=8810:53, Jason Xing =E5=86=99=E9=81=
=93:
> > Hello Jakub,
> >
> > On Wed, Apr 17, 2024 at 10:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> >> On Wed, 17 Apr 2024 10:22:52 +0800 Heng Qi wrote:
> >>> Have you encountered compilation problems in v8?
> >> Yes, please try building allmodconfig:
> >>
> >> make allmodconfig
> >> make ..
> >>
> >> there's many drivers using this API, you gotta build the full kernel..
> >>
> > About compiling the kernel, I would like to ask one question: what
> > parameters of 'make' do you recommend just like the netdev/build_32bit
> > [1] does?
>
> Hi Jason,
>
> I founded and checked the use of nipa[1] made from Kuba today. I used
> run.sh in the ./nipa/docker
> directory locally to run full compilation.
> If there are additional errors or warnings after applying our own
> patches than before, we will be given
> information in the results directory.
>
> [1] https://github.com/linux-netdev/nipa/tree/main

Great! Thanks for the information:) I'll try it locally.

Thanks,
Jason

>
> Thanks.
>
> >
> > If I run the normal 'make' command without parameters, there is no
> > warning even if the file is not compiled. If running with '-Oline -j
> > 16 W=3D1 C=3D1', it will print lots of warnings which makes it very har=
d
> > to see the useful information related to the commits I just wrote.
> >
> > I want to build and then print all the warnings which are only related
> > to my patches locally, but I cannot find a good way :(
> >
> > [1]: https://netdev.bots.linux.dev/static/nipa/845020/13631720/build_32=
bit/stderr
> >
> > Thanks,
> > Jason
>
