Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05E20F067
	for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603847; cv=none; b=W2NjebWSCwwoOjdDkJsyz44fww91fU45/rg3APuLPpK3yZuXmQbhZSsccd7OLT7/QHPJNOX7XzBrr6UB/IImlLYfjR73CnuNNmlbr9/5CpF4qW5mt6Xop2JdaavBpIJMpcY9ugumNkmf1vLnaiQAz/CqimsN6wHDfV/vxosqhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603847; c=relaxed/simple;
	bh=2WNbzwLyVV6yh0b9rLN6fCx7T6MdWJyCfYho6Zl5BSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUgWX2vid1qY3TG/MKWnT+AX2bnYIM1GJxvGGGu9dZ0o5/wW926bPgktV4XSg4FrOBxZzsgnGsBCX3tXuRPsbZ1y5vs2LMtBLZu8PjK4+KY32dlNypON8Ei6cuWt3dE7cu/BKtNoYznfk9+gKigb2KUtISfO5qFzclEX+52XW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuMGKfBH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuMGKfBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763603845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgC+wxOBycuCmMOntc5tfhr1/4wD43qqUekchTy+Stc=;
	b=QuMGKfBHD1CRx3z9XGdyMSHkwmVP6IKnX5saUGhhfOKSeZ3qn6Qna4YOGnEOhySys7HkiE
	9hDGN9EU6E58Motqiq6GGVCTzAgpLrU6ImVSVzLUfVorvxtTMrg5pP/90PnGyJ+h66KtC6
	+O/vnu3iuHeSbiZlnT4kUuk96xAcUXk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-uCrHU1g2MWCMJEGa98QIDw-1; Wed, 19 Nov 2025 20:57:23 -0500
X-MC-Unique: uCrHU1g2MWCMJEGa98QIDw-1
X-Mimecast-MFC-AGG-ID: uCrHU1g2MWCMJEGa98QIDw_1763603843
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343fb64cea6so910784a91.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 17:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763603842; x=1764208642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TgC+wxOBycuCmMOntc5tfhr1/4wD43qqUekchTy+Stc=;
        b=WxHKqQht0v1TDJ788fAs8RQgnv9Uaetq6gc6OM05Xvl87/ntSwKBiraY23FULvyYlm
         1YIQ+zW0Zvu2mPL9ac/nIyBPCru65/9yOrnkIwxhyxGomzqtHyciexzx3Wln4PeVRHtg
         GqRTifMvP/8+QgsLvU1ivKcVs80QMqvEEldLCjetEPhwGq3A0d4G7FpRlzvl0h/aJW+w
         wUm4ntbexAUp0joJkFGTZ8DbuFfr2KQwKZ19htVCc15YgKNhl3LdaArX6rTBaNdzZiTg
         Fu0XUKwOOmlFdqhcszxffzYzl9ZXa+XCt93WPMJb+GHzwPywI2sDkNODwtVpFbeqIKak
         ZjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+x9fqdohoiWepphg15XUKWzfvvg0xQd+gm4HP4cOo3BBLoP+NF/MoQ9KVWGEW/T1Auzy+3tAE9gizsC3qMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1+pgrfRlOaN2LmLhjBz2v7DIdl/VEZtlOdERmMqAFjpFXQArT
	BedBqCQASntnZ3ytjHHioqIFH8/jV+0xFnmxnyrQ2fSM+dZy55LOnUL7RgrhjKdP/dLfqfoHuq3
	Mx+5K7jOpn8CXb/OYr8X97OjYLmR5i7gnmZpnMHziuW/xuww7K72Ci/gIznXAn+DnMavk95lCik
	U1Wb8l+wJglF1cTa0O38PQaqnsjXhqcnifJmS9HnOaCWgpjY6rlYo=
X-Gm-Gg: ASbGncvfwA6Ur0h3jE4gPeeQIbccdfMCq35W72O81RiQ7Rg+L0TyV6aoZ8jzf1TLz2m
	2rmt1qCPRo3Ypb0hBm+dsd9waDJ/QGyvyIjD2YN5PnD5Cz2uuOf/BEyDyxkld9INQbz+wXJMWHh
	oAQfVhF2NmwnheB0qDENdGYk+LOgz8Rn4BoQrhdbJhtTC/gwSBnZge9s7TenbCp9U=
X-Received: by 2002:a17:90a:c110:b0:340:f05a:3ebd with SMTP id 98e67ed59e1d1-34727c5a321mr1248026a91.28.1763603842262;
        Wed, 19 Nov 2025 17:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiOBx5TtGT/ofIvTzG4rvjAW5DLBaw7wYScD05ecl8tqaojALyu5Wx2zCrUNx+TEAVc448NdvTDVTmBdWDDT0=
X-Received: by 2002:a17:90a:c110:b0:340:f05a:3ebd with SMTP id
 98e67ed59e1d1-34727c5a321mr1248009a91.28.1763603841887; Wed, 19 Nov 2025
 17:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
 <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com>
In-Reply-To: <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Nov 2025 09:57:10 +0800
X-Gm-Features: AWmQ_bkp3-p1ykT07gW2-3QafOCuEJ3dN95qJ-5YwVEPAGAlLFk5vJNIKwB0qOY
Message-ID: <CACGkMEvD16y2rt+cXupZ-aEcPZ=nvU7+xYSYBkUj7tH=ER3f-A@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qc91tT58MXuiebve64bNh6ML7Gbli6vPFSTFyOJGPc8_1763603843
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:35=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Nov 16, 2025, at 11:32=E2=80=AFPM, Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Nov 14, 2025 at 10:53=E2=80=AFPM Jon Kohler <jon@nutanix.com> w=
rote:
> >>
> >>
> >>
> >>> On Nov 12, 2025, at 8:09=E2=80=AFPM, Jason Wang <jasowang@redhat.com>=
 wrote:
> >>>
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>>
> >>> |-------------------------------------------------------------------!
> >>>
> >>> On Thu, Nov 13, 2025 at 8:14=E2=80=AFAM Jon Kohler <jon@nutanix.com> =
wrote:
> >>>>
> >>>> vhost_get_user and vhost_put_user leverage __get_user and __put_user=
,
> >>>> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >>>> ("vhost: new device IOTLB API").
> >>>
> >>> It has been used even before this commit.
> >>
> >> Ah, thanks for the pointer. I=E2=80=99d have to go dig to find its gen=
esis, but
> >> its more to say, this existed prior to the LFENCE commit.
> >>
> >>>
> >>>> In a heavy UDP transmit workload on a
> >>>> vhost-net backed tap device, these functions showed up as ~11.6% of
> >>>> samples in a flamegraph of the underlying vhost worker thread.
> >>>>
> >>>> Quoting Linus from [1]:
> >>>>   Anyway, every single __get_user() call I looked at looked like
> >>>>   historical garbage. [...] End result: I get the feeling that we
> >>>>   should just do a global search-and-replace of the __get_user/
> >>>>   __put_user users, replace them with plain get_user/put_user instea=
d,
> >>>>   and then fix up any fallout (eg the coco code).
> >>>>
> >>>> Switch to plain get_user/put_user in vhost, which results in a sligh=
t
> >>>> throughput speedup. get_user now about ~8.4% of samples in flamegrap=
h.
> >>>>
> >>>> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >>>> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >>>> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >>>> Before: 6.08 Gbits/sec
> >>>> After:  6.32 Gbits/sec
> >>>
> >>> I wonder if we need to test on archs like ARM.
> >>
> >> Are you thinking from a performance perspective? Or a correctness one?
> >
> > Performance, I think the patch is correct.
> >
> > Thanks
> >
>
> Ok gotcha. If anyone has an ARM system stuffed in their
> front pocket and can give this a poke, I=E2=80=99d appreciate it, as
> I don=E2=80=99t have ready access to one personally.
>
> That said, I think this might end up in =E2=80=9Cwell, it is what it is=
=E2=80=9D
> territory as Linus was alluding to, i.e. if performance dips on
> ARM for vhost, then thats a compelling point to optimize whatever
> ends up being the culprit for get/put user?
>
> Said another way, would ARM perf testing (or any other arch) be a
> blocker to taking this change?

Not a must but at least we need to explain the implication for other
archs as the discussion you quoted are all for x86.

Thanks

>
> Thanks - Jon
>

