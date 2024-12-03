Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DED154BEE
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269387; cv=none; b=fLQtKVShOt3cv2+QSaPf1leQn4ndzU3MU/kIXoduBsy3zlW47gtQrtbHFW6DRsm1ONQlcZaYTjAaA0jbuRvONHyoKVd3scDuOI6US1wTLFxfEg0KV3uCdjQKAHVMbbyAGDXbFUYo3u1KWjEPYGj96lbF4aboXC0T3m0lL56+Z9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269387; c=relaxed/simple;
	bh=/CZ2yNFlNF/WOHHJXMK+Nyg+piMw6SzQPGnPsKv0u+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+xo1ja9ipPD83XB1SJZ3s3h5uwVoL9C9V5Wrn6KlRMB3lSl9Wt5vb4OCqrOYIjuzL8pkenWwNRiFOH0SeMfT9va0yG81hMcHMfB5LGnAfB6k9vxjeh7RXa5KYwTsEVvE/fpoXHGqwMMj6ijH4N/rWDeDHa2FMu1GG5TWsVXCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DEsQtIA/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEsQtIA/"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85bafa89d73so615596241.2
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 15:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733269385; x=1733874185; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efxAKMGIsYtsJH1TfFadrRu53b/jP4XGduoqdQKfUDs=;
        b=DEsQtIA/Osg3hhjHeFLuceQdqnwEegQdxYLlSkGNLuxy5bBCdQ5v0mGS1Zv1KjXI7f
         XdjQTlYmInJsvYWOoKC916gjxmW3vikfqXfL50Ne2p4GTmNx4yWTBUOEBoobmL8a61MJ
         ZFqwfJH0xRxdPNEJYJ7G4OeLPI+/+mT5uzwMzlIpXDhZPZ6swMIbABhyGX+e09YLsv4Z
         J0/7qCrsuIChab3qQRvLfq69T6+e2O+dH07HjrWgBJaK8zpWqKIJjW2H/4p8UlMIN/Bf
         +VdpNr0KqxIwnY2j0knlY8I61qzGvcK6ilHvcSNe4rj6GJAalmtRFAa0W5PSW889Q2Xd
         z9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269385; x=1733874185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efxAKMGIsYtsJH1TfFadrRu53b/jP4XGduoqdQKfUDs=;
        b=HrdBikcJVVeLRZnDjML9hTquiZn/76PhO56tMJoFbnnOvkaMYG1YH/WSS0bcToAgBg
         ugokjqjo2yNovPhbvj5h9sxTyRNQQwabEtuc0fJgZFEOoZkEBrToivOmzQLUrwzvoHUT
         v1oxHrLQ+7joVbV6Wi1EgrK0KopOYosE+SlMTmLAZlbMlrEoAaDacmFrSxETWRU6eV2C
         5z2wiCK12+Qaoa8eLfoybvIu0E2l2peRuUx/CiPcsm6fpORoZZh1pZA/9T0EvT20mwgO
         swvrWHQKVpNIlLo3ebu7auGr7zgkVzRRbAg0nMFimcYLPJm9OCgdoy8113k9sAt4bavE
         OboQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnilYOPgrZrEe9JjSbWz7p42WFE726gODMCWo7pnE6XXIPLjr0AQNtdNMwhwdYrQwwy9by0A5z6bk6sKnIaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1Awfa4KgoDfQlaxwEWnVsEJ82OsGSEon3EDCNGmWlV30Grak1
	OSJNB6/3GeotKU/uC6VXNtEHHo4sgtvtg7zV5EJ7hjCuuzDvQjHAamyaF3eY597VcPFFfDp8Xv1
	u24ljQArCW2OiRt4VRSpYzAdl7kIXfBEVZRlF
X-Gm-Gg: ASbGnct9aPA9KrIp/JcCNzJKIjVUqu3MZIFNLNTujlMJZvxSqLYfS1zvca172j+JMFT
	Cit47NgY0yfaP2vShBiGQD8XbvozwJE145sGdE696ctk3ii6+9bXeyhmFHD13
X-Google-Smtp-Source: AGHT+IFnoxNObCnxOJ19RTHQOfy3IS0mP97qq1D+ZXM9Cr4w6i9KeiYqycIxeXsC6V041VYgYczgtjNRhEyAzhN1RZQ=
X-Received: by 2002:a05:6102:548e:b0:4af:ab78:f383 with SMTP id
 ada2fe7eead31-4afab78f4b5mr933855137.24.1733269384628; Tue, 03 Dec 2024
 15:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
 <20241203005921.1119116-2-kevinloughlin@google.com> <a9560e97-478d-4e03-b936-cf6f663279a4@citrix.com>
 <CAGdbjmLRA5g+Rgiq-fRbWaNqXK51+naNBi0b3goKxsN-79wpaw@mail.gmail.com>
 <bc4a4095-d8bd-4d97-a623-be35ef81aad0@zytor.com> <24b80006-dcea-4a76-b5c8-e147d9191ed2@suse.com>
 <25fa8746-3b36-4d43-86cd-37aadaacdf2e@zytor.com>
In-Reply-To: <25fa8746-3b36-4d43-86cd-37aadaacdf2e@zytor.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Tue, 3 Dec 2024 15:42:53 -0800
Message-ID: <CAGdbjmKwMrioAq1b1v_UhhOxU6R2xPztZ9Q3ZizC9iMA84s+ag@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86, lib, xenpv: Add WBNOINVD helper functions
To: Xin Li <xin@zytor.com>
Cc: Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	linux-kernel@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, thomas.lendacky@amd.com, pgonda@google.com, 
	sidtelang@google.com, mizhang@google.com, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 12:11=E2=80=AFAM Xin Li <xin@zytor.com> wrote:
>
> On 12/2/2024 10:47 PM, Juergen Gross wrote:
> > P.S.: As the paravirt maintainer I would have preferred to be Cc-ed in =
the
> >        initial patch mail.
>
> Looks that Kevin didn't run './scripts/get_maintainer.pl'?

Woops, my bad. I somehow ended up with the full maintainer list for
patch 2/2 from the script but not this one (1/2). Apologies and thanks
for the heads up.

I saw Juergen's patch [0] ("x86/paravirt: remove the wbinvd hook") to
remove the WBINVD hook, so I'll do the same for WBNOINVD in the next
version (meaning I shouldn't need to update xenpv code anymore).

[0] https://lore.kernel.org/lkml/20241203071550.26487-1-jgross@suse.com/

Thanks!

Kevin
