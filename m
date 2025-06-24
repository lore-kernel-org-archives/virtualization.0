Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C8172BB9
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Jun 2025 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726219; cv=none; b=TA6jTQA3wpK20Aazk+bZhc0z9yWPwi8uadxqVCWEB4TROpWnottjOouiJEMrW54yZaJsvJJkNbBCC6OsuEoQVGQyiG9Pi5wfpmMvKv531CcCGv/TT4S+Jtbt1h9vwequPefHqi3erl6FGdsPElt4HUDSMaanHQPvFvaQS47fP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726219; c=relaxed/simple;
	bh=/auqGXR0o1/P/foYc6AgZw0KxuJdncmvKGkmkIKxkSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6Y2a9Tc/4SJ8tfQCWHlY7VR6sJqVcTnUmarTLioq0B6pFYe3r2CA82dJ1i+aKmsFJVJYy8afwd7Q85cSfwtNsAuymWAx/VTJyXTCxe90EA5PqFG1G39dl5klgG7oHrHWDXMXijHFFNGK3Ca0Z18x3WC4YKLYyxB8NEOCw4mlDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw2socHm; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw2socHm"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9EAF41056
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Jun 2025 00:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -3.791
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9h_Ctj-f1PO for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 00:50:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0CC2141144
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CC2141144
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hw2socHm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0CC2141144
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Jun 2025 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750726214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/auqGXR0o1/P/foYc6AgZw0KxuJdncmvKGkmkIKxkSQ=;
	b=Hw2socHmMCLeu7lfybV86LQsaGzvvR0Ih4xSp3uoPzn4YygUou62Q3H+WPoS8vx2MVHZ1P
	n6Zv7ywMGc+edyA1g+HR+KXvw6kaiwO6zp9qnkp/m3tknJHXZXetY11urVhHOLWAt86HHg
	VibpRpDiieYUPDMDR1OdK2bkX3zf828=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-C9brR-cLMUyiyrgSK4S11A-1; Mon, 23 Jun 2025 20:50:12 -0400
X-MC-Unique: C9brR-cLMUyiyrgSK4S11A-1
X-Mimecast-MFC-AGG-ID: C9brR-cLMUyiyrgSK4S11A_1750726211
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso6338982a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 17:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750726211; x=1751331011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/auqGXR0o1/P/foYc6AgZw0KxuJdncmvKGkmkIKxkSQ=;
        b=vayLzh+hlR4um3abJEAMyFMuKd3xL+ehhouwPD60emOOhlFUa6vonxt8/WHbTcta8k
         i3o+mKv8kqv4dFbk76baicciahc0tBG54O6sSCXBVDsI8SkCcT+uB5P2caN/15e1c7Wh
         YocdROgsPprn2C4cjFR8aDtNuir4KmRKrpgiRrhBQhteKqjUvTMqEqCoTwz7FrDRY9JM
         I36G8XHpFXG4QJkzPUI/McuUSXGdAZE88Gay1kU8hBeLy0Sk/3Uatv66eQjL13EAk/fV
         JKHU6zEcPSX5YGdeMYj7TT6gNzC+2a3sRoyqYr1rAsLbTHTgIdx/Jfol6y2v9EmeGtbF
         G2gw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9tZcJwnC25kpqllDJOrhjGxtDuNwHKF1f8PjN6zUyk818jpPVObcZzPf8GxgY/w9QEVLUPY7pB1QJmtY9g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw7Uk/Hy7BasDLan7LNWHit8mH3Sqb19lHbMMAmnS+g9mXavFHT
	TaYSHdJqsNoWeEQ0RBQiILmDVs+7ryv6E200ApATWOQcoRHs5y7lhfn7NMRc8aCGrfr+hfq3o9C
	UZ7X4uZHUoqVyAY3SPB1NydwBdiD7PW89naN3mhxCa0RwIq964x1q48SBod8dMueUZuKfP9HLey
	CfP4b3FnIPVH06X12O4JK/M34AF+0KGLN9rnypdbydvjPNMMTxJgzpD7GZBA==
X-Gm-Gg: ASbGncsNNxWJlf4BjK30fmR1m6eXsR22cga2YFyvmZNIhacOWwK6newCq7LglBEeRwV
	TFK7EHwDA3RoQJC0ZLs05qc4PkL3UzkvQhV/7vD3QYG6FNeGzAhwLG03/s2Bdeca7xJxxie0slC
	y9jt8f
X-Received: by 2002:a17:90a:d888:b0:313:f883:5d36 with SMTP id 98e67ed59e1d1-3159d61b385mr20481163a91.1.1750726211541;
        Mon, 23 Jun 2025 17:50:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2mZ6TFzZC61NvgUQr50RK9GKr+Zt2TEe1NWxDOMMJSfnof6RsI9yY3mdeAsIKTHaPT/FkDTx1NOWeRFhiZ3M=
X-Received: by 2002:a17:90a:d888:b0:313:f883:5d36 with SMTP id
 98e67ed59e1d1-3159d61b385mr20481119a91.1.1750726211082; Mon, 23 Jun 2025
 17:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com> <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
 <CAOEp5OcybMttzRam+RKQHv4KA-zLnxGrL+UApc5KrAG+op9LKg@mail.gmail.com>
 <CACGkMEsfxXtHce2HeYwYxmhB0e5cOjn17qM6zFEt75bQhbtrDw@mail.gmail.com> <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
In-Reply-To: <CAOEp5Oet1P2EWTwLJnMYY4CVAzDWgdM8wbvV3+BH6aY0kE+O8g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:49:58 +0800
X-Gm-Features: AX0GCFuyvFlQ7RhA5QlpqKcUbeYXfBe9mHMJd9IBrNPZibzgOsK55WFol474x3I
Message-ID: <CACGkMEuPsCNuNZbPsAj2d-tqz0RrJGAyPQAjt1nFbJdgtiKsGg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ZfhZwE2dMj6E1tjZr2PyxpgsqOll2yh0NQqQShLG7w_1750726211
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:28=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> On Mon, Jun 23, 2025 at 11:07=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jun 23, 2025 at 1:40=E2=80=AFAM Yuri Benditovich
> > <yuri.benditovich@daynix.com> wrote:
> > >
> > > > Yuri, can you help to clarify this?
> > >
> > > I see here several questions:
> > > 1. Whether it is ok for the device not to indicate support for XXX_EX=
 hash type?
> > > - I think, yes (strictly speaking, it was better to test that before
> > > submitting the patches )
> > > 2. Is it possible that the guest will enable some XXX_EX hash type if
> > > the device does not indicate that it is supported?
> > > - No (I think this is part of the spec)
> >
> > There's another question, is the device allowed to fallback to
> > VIRTIO_NET_HASH_TYPE_IPv6 if it fails to parse extensions?
> MSFT expectations for that are at
> https://learn.microsoft.com/en-us/windows-hardware/drivers/network/rss-ha=
shing-types
> If I read them correctly, the answer is "no"

Ok, so I guess it implies the implementation should be ready to deal
with arbitrary length of ipv6 options.

> BTW, my personal opinion is that placing all these things with hash
> calculations into kernel instead of ebpf does not make too much sense.

If I remember correctly, we tried to enable it via eBPF, but failed
due to the rejection of eBPF maintainers.

Maybe we can revisit the idea. But anyhow the hardcoded logic might
still be useful as eBPF is not guaranteed to work in all cases.

Thanks

>
> >
> > > 3. What to do if we migrate between systems with different
> > > capabilities of hash support/reporting/whatever
> > > - IMO, at this moment such case should be excluded and only mechanism
> > > we have for that is the compatible machine version
> > > - in some future the change of device capabilities can be communicate=
d
> > > to the driver and _probably_ the driver might be able to communicate
> > > the change of device capabilities to the OS
> >
> > Are you suggesting implementing all hash types? Note that Akihiko
> > raises the issue that in the actual implementation there should be a
> > limitation of the maximum number of options. If such a limitation is
> > different between src and dst, the difference could be noticed by the
> > guest.
> >
> > > 4. Does it make sense to have fine configuration of hash types mask
> > > via command-line?
> > > - IMO, no. This would require the user to have too much knowledge
> > > about RSS internals
> > >
> > > Please let me know if I missed something.
> > >
> >
> > Thanks
> >
>

