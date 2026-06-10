Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0293AC0E4
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781125591; cv=pass; b=e6+BX6ydyhW8fMxPpfPdZnQAE1HwRwjQegk9nT0CH1xWoEqYvO38cKRG6dqKObUQlc0hBwlM2zXT6mBx3mxKF9y0pOsrs/5p3wVMDcAi1cT40/izjL+j+QwwTwNRIEh76D7Jy25ISPmKrFIEvxZSMyUFAi/5rsgTw3DezyP0Q/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781125591; c=relaxed/simple;
	bh=8SPk+9kPUL0DQYsfiU6U+3rhy9CmKqHE6O0qDp+jLZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/WIrZGIFraG0aqh933h0MeBXkIUmPPsNLWGixz/ygtwBqJznJ2vzh+IaSqjQdu/6t032x+iefQrUygOMo/CDEe7H67IYyIRmTpq+C+cFUDpxFVbQxkBatM2UsH7YiY7Q5FKSoeQ6PeLAzpX64zwy26qDsL6x0zW/mrlWA9Dqg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH4txPpw; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH4txPpw"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7f5eb760240so6968357b3.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 14:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
        d=google.com; s=arc-20240605;
        b=YHrfZXOW5UWYmoZC1NRCVoerpdHNsRyGj+gHsMiheuEVmn2YixfHHfkTEEPUyX9NXZ
         uLuBbkcofvzVPNPoHt6vxWw+iMmmdNTFPyLT+3A7Z5d6+aCQPMf01IJYTo4je2Vi2n1E
         wPZ0Jupqmt8JTPmzjVMAolzildVMuTesTfLH8ePTKtoFtfJiGHpQa6SK/YGCEjQzM6EI
         tHQGTomyUvd7I92tHnpMW0oXoGVbNrOJ57aKgKGrjdr0Mc1q1aKQ/UcubZ1Jqvyf0yjm
         odYNyQ02V99dAKCcDwjG20iuX477j2X6zFNQ10AYvY/dtfDzDWQEe5c2485ozkFsf/vu
         9Gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        fh=a28XyCftFm303Hq774JB9EZNNrJsmRC5e8ck4CdCtx8=;
        b=YHEifuY9sa7c1EGcqd4HPh7Fj8FCjLAZ+qCcan0jET6sSryag6R7f8TZWOQvceqyr7
         fn2zXFamp62h856rVoghELsWVE8f+SvqdpDhfV+y9i9PH638KHnqVKw31ofV8DsbChrl
         fCOoDEt7Hm0HvP1L+kvE5ciUxvo5fq3gMWFJRpQXuH09Ah2fQUS9Poie2quvUJnP4Me6
         HdJynaBhUXX+dhlRadnpzjYzE6wU84S/PcqojPwZCeEtmdNTKP9lU5XVyJNanMBZ2VlQ
         lZwT16Wzpdn7Oh9FAjgUUQfL8TOYL8/im7RKsr1sHXb3uxks6lJQQpJpDxIF+/Zbz1qm
         UDGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=LH4txPpwLidgKBu51sluesoZTxME4kT5qlUQy4WDR6Jn1zNu1+WqkXbs5AxB9obV9u
         htjf1cMEpx1Rmz24Um45HbVqZCk5kcIqhdOXyo+2m5xYUwDe2cmAohYKGdx8VhGG65de
         EMxQussr78mDNa9jlFG2OTKLZ7syNAx/eXowuuq81H0ASvVEZPwPBRi+HUv+8ZWryaG3
         tQyDW6gKp2CfGL03sXr3kHq2PDNuQzBoVLsLbDT9tmRuVVW9qe0Ie5jSilfCo2xj23E7
         /Foa2ziUUp1Tluu+UEu4uhTmcsISxpp8NKqSoBmkzm5ZmuUB7YREGQzx4yJgbhw+87fw
         kRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125589; x=1781730389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=fILbQKDeXKcWHCQ5xnq4nPl34pCXtx1FpOwlKfE47EWSAbgaqCg1wJ0BBveB0q9t+z
         mXSyW0tVX5k4XvTmr/1C6+1x/SIyYKXRYBhbcoKHibqUNjqWCZkmrbvC4acM/7xVf6TM
         dXjD4+RNuX5mjMRBYAD65OSUH/cUwXQsixaaAlYcYFdWQy/C8THg5QRnnbMrOH+K745d
         LMSvHgmg8LbNm3k+EE9+3IKV6CZF64oHOhqrUSQmZ2FfNr1DgWTHh6W8nHF2JHDeI+vR
         qIQ3McefD0ORiind9mpzH/e4ck9aAvF1VCzvEdfzbucxwYw89WPduyatOfaB/RgQ4QOg
         anbA==
X-Forwarded-Encrypted: i=1; AFNElJ8cvIimd12Op/SQfYbEDX0L+YUZRyDhaHoRvQu/qPYlQ3phoOUJffUhAOqeONHSs5eGT6A6X/4ARfpzvEny+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIyc+zzyPoZffKeHUQ17yYTsuo7/tlCP4KdqQzgrSvqPX3RrOX
	PDfOqZwVNXh+ceox8J0yPik/gOjko5ZoCPFnoTeB3mEvF6lnkbhvYRtS49xOwKUis9p2NzHLTYN
	8YlB5Ob8/Vl9tCbR1qnhfa3Ks0C1UQ/U=
X-Gm-Gg: Acq92OFGP3n500lCuO1xf7VLFPM5bJ2XczgVQzW4fAHHeDDIkh9ftLwxZ0fcd0FSCuu
	Al83Ba03S8DMe/o1HRQkUoRyvIwOJzJenlV+y74Ud6Z+2QodwONhzoXyiQ3UJKm3O1/HEk7Ff3d
	DNjDcp84p3iAlRu/B4Bwv6JQR4RFQS2zJ1u8LeJkFbLK3SS5fKNPLl0I2eKp+7cgT9XW1NiXCS4
	wWjNf9O76BxScP4MvrQS+l6ezFVhOwAGzjTmaYVtfVPCG8M9QOcczNDo/1qgAMu/TbTRrDj+DBv
	YnFBYPZXVonBUIVmms6KxGvevQ==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>
