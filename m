Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC33090F5
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137082; cv=none; b=Xq05A5C0denYU3e4U88LnFQYf3jVcVlijUqfQQDfiuXkD+8Mjd+5a4MSUfZNzYasuL4DxPm0rkRJe1XbgjkFmQduAagsStzBPvuO9DE9R+gFpjVOO2EjSg8oz6bQNyIB1iLA1es4pK0IO2rgCzCQhYR5tkR23y6bJUuVkAYBkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137082; c=relaxed/simple;
	bh=6S/I0aqRZ/F7+hnivrbJxw1X0W/1DAFC2mRV55eaujE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V04D2CFH96OJA5HhqiVWLFZ6MC9bIA0YXMnssD53wOw7Oa72UmeLsv66VCOWi6mvNqGEokxcJvATOFqWeeUeO/km6h8kI/DlNuRZJUtKZz1OD648ek23WqGNAiGg4mHuVedXEG7PMk8J4Wa7amT3IMffnf+RbnlBvL2/yfb8hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhJyYmGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhJyYmGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaB2KVWRNAbMaNATIpxj7yIi4zwUBMB8DFcAl65yplo=;
	b=PhJyYmGDr1t6OSSu0KgnvCw+xLY03QC9UrxcBi/ODZA8sz1FryRfCpKq2P1mQXJ2WXD23i
	sVlWwKHfyZ1Cd+Eco8jWwADrqe5M89FgSymbrpdmr3eOD1mrX3xwt6LhyyAUeOAxXk9p4X
	wy8ShLPx6rH7DaoDuMTeL9ettx5TWnE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-ejP9cnbmMeaCvZ6h7ztXlw-1; Wed, 26 Nov 2025 01:04:37 -0500
X-MC-Unique: ejP9cnbmMeaCvZ6h7ztXlw-1
X-Mimecast-MFC-AGG-ID: ejP9cnbmMeaCvZ6h7ztXlw_1764137076
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso6733166a91.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 22:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137076; x=1764741876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OaB2KVWRNAbMaNATIpxj7yIi4zwUBMB8DFcAl65yplo=;
        b=psF+g6o67SHloiH+WIALvVPZ8hJ2JCuDBgqRf+J9U245qW1c5ZiVFE0XpG4wnCdcRY
         MW7377ch9sQMRqKWt4H9y1L6Rz6bUwebDVy2do2muVQAcOlZQdjUcGumPfP4WouhmSZY
         /9GtW6inM7ZweIH2/OB//cW7ySZIHK9KcRPc1ebDzumy/xl45s3vHM39QUBlgVOu7yIU
         9eKJDEhOSG6hRNdshAP8Fbd7brN2ppIxudsbBHrz+txBB8AoJ1vIz2t4U0viLadDrVJF
         lpn8KSDjLGni8jTo3olJ4Qe/sOLxp4eVzXspA13IN2MNJp3fvGJBMRwsHQWD2MKGDCUq
         ev0g==
X-Forwarded-Encrypted: i=1; AJvYcCVy2TdesVCF/5eCz5yrMNlkAssaG6JUQUNjM7H+owSFJ9OQMv1M1mcP/ePGqn7SO0/FufBGjN0qgTtt5yX9oA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yycv6ZjcXk2aT5yHvWWvc/eTw1TMLowE/lCKcKhQ7+JNAucw2AV
	v3uXGlQSWO0WRO+oEkVhbcirDAQqQcIDxoLB1cpsgaP6rowilwI8pUDIm6MRzYTF4/YX6xHjAxg
	VDG0PFPGdxr3L9g6vD5K5Ut7AmoOadUTibzQn2y6Yclfrv79tsLWDmd0LCM4GVorW/GwDTDdSLJ
	vrLQ6gilso++3V2FoQsGI6f5Nysc1dOBTXdnpQzYTjzpc=
X-Gm-Gg: ASbGncu192/hUZzsfLCw1vHegDrEiBdG8sQqNfWUNyqahiSmXDQaiCI6GCZZ8+sDZ/o
	aBy5R6k7vxGz+4Q/x3XL6AFZUj5zhNzxmGQdzsPcAXCTx1IOtNO4AQq3w5+bsmXYzyZ7nabX8vd
	2ESFE6xiRH/SSqIkjfuAJTm3xTVyuxLzLf1LV5kahkUnOBZsWa0Ir0JOKMxn1gCxnGyeg=
X-Received: by 2002:a17:90b:3a81:b0:343:684c:f8ac with SMTP id 98e67ed59e1d1-34733e4c8fdmr16172931a91.8.1764137075877;
        Tue, 25 Nov 2025 22:04:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMgyGfGhHuIXlnMSRmydbJ73Umy+/ihi3Es7MfZVsIvdOL46Du5q/FBIP1Zh+sAGvjoTwtO6cxu9UWM/LPP4s=
X-Received: by 2002:a17:90b:3a81:b0:343:684c:f8ac with SMTP id
 98e67ed59e1d1-34733e4c8fdmr16172898a91.8.1764137075386; Tue, 25 Nov 2025
 22:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
 <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com> <CACGkMEvD16y2rt+cXupZ-aEcPZ=nvU7+xYSYBkUj7tH=ER3f-A@mail.gmail.com>
 <121ABD73-9400-4657-997C-6AEA578864C5@nutanix.com>
In-Reply-To: <121ABD73-9400-4657-997C-6AEA578864C5@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:04:21 +0800
X-Gm-Features: AWmQ_bmSzNmtLXzsLUvLhgWB8dvqy0Qa5CQPOMXfuQ7SoDSN1_7LIgv1Nc8s6u4
Message-ID: <CACGkMEtk7veKToaJO9rwo7UeJkN+reaoG9_XcPG-dKAho1dV+A@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>, linux-arm-kernel@lists.infradead.org, 
	Russell King - ARM Linux <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, krzk@kernel.org, 
	alexandre.belloni@bootlin.com, Linus Walleij <linus.walleij@linaro.org>, 
	fustini@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZEoyq-hW0gpU3iLSyWtiIhV-8ueQlzk1-sFVOV8Rlw8_1764137076
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:45=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Nov 19, 2025, at 8:57=E2=80=AFPM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, Nov 18, 2025 at 1:35=E2=80=AFAM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >>
> >>> On Nov 16, 2025, at 11:32=E2=80=AFPM, Jason Wang <jasowang@redhat.com=
> wrote:
> >>>
> >>> On Fri, Nov 14, 2025 at 10:53=E2=80=AFPM Jon Kohler <jon@nutanix.com>=
 wrote:
> >>>>
> >>>>
> >>>>> On Nov 12, 2025, at 8:09=E2=80=AFPM, Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>>>
> >>>>> On Thu, Nov 13, 2025 at 8:14=E2=80=AFAM Jon Kohler <jon@nutanix.com=
> wrote:
> >>>>>>
> >>>>>> vhost_get_user and vhost_put_user leverage __get_user and __put_us=
er,
> >>>>>> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >>>>>> ("vhost: new device IOTLB API").
> >>>>>
> >>>>> It has been used even before this commit.
> >>>>
> >>>> Ah, thanks for the pointer. I=E2=80=99d have to go dig to find its g=
enesis, but
> >>>> its more to say, this existed prior to the LFENCE commit.
> >>>>
> >>>>>
> >>>>>> In a heavy UDP transmit workload on a
> >>>>>> vhost-net backed tap device, these functions showed up as ~11.6% o=
f
> >>>>>> samples in a flamegraph of the underlying vhost worker thread.
> >>>>>>
> >>>>>> Quoting Linus from [1]:
> >>>>>>  Anyway, every single __get_user() call I looked at looked like
> >>>>>>  historical garbage. [...] End result: I get the feeling that we
> >>>>>>  should just do a global search-and-replace of the __get_user/
> >>>>>>  __put_user users, replace them with plain get_user/put_user inste=
ad,
> >>>>>>  and then fix up any fallout (eg the coco code).
> >>>>>>
> >>>>>> Switch to plain get_user/put_user in vhost, which results in a sli=
ght
> >>>>>> throughput speedup. get_user now about ~8.4% of samples in flamegr=
aph.
> >>>>>>
> >>>>>> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >>>>>> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >>>>>> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >>>>>> Before: 6.08 Gbits/sec
> >>>>>> After:  6.32 Gbits/sec
> >>>>>
> >>>>> I wonder if we need to test on archs like ARM.
> >>>>
> >>>> Are you thinking from a performance perspective? Or a correctness on=
e?
> >>>
> >>> Performance, I think the patch is correct.
> >>>
> >>> Thanks
> >>>
> >>
> >> Ok gotcha. If anyone has an ARM system stuffed in their
> >> front pocket and can give this a poke, I=E2=80=99d appreciate it, as
> >> I don=E2=80=99t have ready access to one personally.
> >>
> >> That said, I think this might end up in =E2=80=9Cwell, it is what it i=
s=E2=80=9D
> >> territory as Linus was alluding to, i.e. if performance dips on
> >> ARM for vhost, then thats a compelling point to optimize whatever
> >> ends up being the culprit for get/put user?
> >>
> >> Said another way, would ARM perf testing (or any other arch) be a
> >> blocker to taking this change?
> >
> > Not a must but at least we need to explain the implication for other
> > archs as the discussion you quoted are all for x86.
> >
> > Thanks
>
> I=E2=80=99ll admit my ARM muscle is weak, but here=E2=80=99s my best take=
 on this:
>
> Looking at arch/arm/include/asm/uaccess.h, the biggest thing that I
> noticed is the CONFIG_CPU_SPECTRE ifdef, which already remaps
> __get_user() to get_user(), so anyone running that in their kconfig
> will already practically have the behavior implemented by this patch
> by way of commit b1cd0a148063 ("ARM: spectre-v1: use get_user() for
> __get_user()=E2=80=9D).
>
> Same deal goes for __put_user() vs put_user by way of commit
> e3aa6243434f ("ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()=
=E2=80=9D)
>
> Looking at arch/arm/mm/Kconfig, there are a variety of scenarios
> where CONFIG_CPU_SPECTRE will be enabled automagically. Looking at
> commit 252309adc81f ("ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 imple=
mentations")
> it says that "ARMv8 is a superset of ARMv7", so I=E2=80=99d guess that ju=
st
> about everything ARM would include this by default?
>
> If so, that mean at least for a non-zero population of ARM=E2=80=99ers,
> they wouldn=E2=80=99t notice anything from this patch, yea?

Adding ARM maintainers for more thought.

Thanks

>
> Happy to learn otherwise if that read is incorrect!
>
> Thanks all,
> Jon

