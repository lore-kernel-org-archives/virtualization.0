Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936F30C37C
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763353963; cv=none; b=HVx1UsB9i5qkEpBNpqGzINsNYeBaV10dESSXBOnkdargP7ZcIt+T67ZiNBGrk7j+BZhWd4qdsXlYw9Y5tRecKZTO96tHYXIQRsJMDv+lj8dCwPx+cHXnkJ9yP5jJVE5osCWoQzmMcKgbxdrgrj9MhFxbRC+bKzSASaP6YAdE2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763353963; c=relaxed/simple;
	bh=J5vSilRzoZFuz0Leuc5DFfPJlb/Y30/AvuhtXQq3ZlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0ha+Q+GikkUwsHWzsbvGxVSUVxJefutFSW3WWyyAckHyOc0WjKAuS3W1rarmr9Uyx0FCysLN4CcC0ULBpXoCfXfUll8iE6DO69+FkjpPprc4/W1e1lSZytuE31Sb1s1A9uYUTwX2XsMRk4AgQ2xjq+2ot3mVBP6MrhQFcQXNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avIrSb9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avIrSb9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763353960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSNhFmpZIayhIMAREUUJiVdpe4HGYG1VRWTSSJUjCFU=;
	b=avIrSb9nmc9HIOFRoEqjACLUFQTRMi/Q7RQ2Nz2Q1UXHFLPV1YSz90AtRK0thSz7fzOPH2
	X1lRgEgdjZRXJehZY918wemjK0pCB66FrRmf/dhj5foILwsuymck7A2ZYK9QwLttt94pLb
	o0iR28GWUH4g432KkTMWfMDE3LwPbMc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-LVOIgdmINWeKcjOVZjIYRA-1; Sun, 16 Nov 2025 23:32:39 -0500
X-MC-Unique: LVOIgdmINWeKcjOVZjIYRA-1
X-Mimecast-MFC-AGG-ID: LVOIgdmINWeKcjOVZjIYRA_1763353958
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34378c914b4so7769565a91.1
        for <virtualization@lists.linux.dev>; Sun, 16 Nov 2025 20:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763353958; x=1763958758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PSNhFmpZIayhIMAREUUJiVdpe4HGYG1VRWTSSJUjCFU=;
        b=fS5GbFIpbQjJ4TGdgY5l+ybvQ8oS/GNbWdOvvcS8hpiUtK3oRw/m4gOPwgPO6JlEUR
         2RBg7jFEYTRO03vsOxVHgG/aNoFI8cthN5jRTgpvcq6hMk+gFR4CS8iG78JHMQBm0lw8
         nP9p/KVd655MS7CgqPt3y9BkaeQHwMi+ZU6Um03vdVibBIxgYqQKIOwgwIoJknHA8br4
         L37QvoCTbqAyWGRYy5DVcixAEZaWv3qkxL8HFvwZTR5yofbyU4fUycmwFtr9N8lOrDdi
         2F6Cy5bADyrxs6OcffZtjyXpgXfLG9KzVhaJf+kJt5KO2Y6m+5rcTo/QMExXcF69X+hH
         94eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5faR+5Q8lzr98H72kuqsbdyJESna7r/tQ1coMd9i/87wrJIKgn1FLcFe2MSgtKZUMwhcCoAkIjefDF29kTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysoA8ZyplVevnnrb+WHCLgiD5Ve4c2jQe3CXdPnhgyHT1y4npW
	qJrXYLwtONimr42U8G2sabjc4FHESUkzAEd61vBYMJcaVf16BujFPQD/ftaNcBED1EGMiy/gc5d
	ZnFqwK04hNgM2w4gymnz56+W6r3HRCmKwbF2O9YcKen0N5yQftOm8iLDuaMV45rSyJWtZGy/0dl
	NsnwaHb//g6v8T3ro/XfNTFgpDJkhqC0RJKHSA4UkhY7A=
X-Gm-Gg: ASbGnct8hycsqTYyZsBJpEczM3lzTOcDGtrqFMEM1JVEe9cI8SVzGMsa9bKYRUVdQtK
	6eqiPON+/toChEgDu45DNmTCgza6SF2Zpyrl77id36yALGRIulkL4xXgcMtKLmYrgjKDtIDEhKa
	y4KyRL6WrjWXH/BBE7qIW1JhvUFIfc6sfMLxH+K+OvykKYUYHiMr1XWi44g0bRxzgON2U=
X-Received: by 2002:a17:90b:17cc:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-343fa746bb1mr11596133a91.26.1763353958262;
        Sun, 16 Nov 2025 20:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV/CXg+2Vp41Uxj1ipRGPfCEHzBTb0qkxrfYbNf6nESBnGQRPNBjl3xkLuDzxOomcKItMBq22OwlAlxuNxCgg=
X-Received: by 2002:a17:90b:17cc:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-343fa746bb1mr11596111a91.26.1763353957756; Sun, 16 Nov 2025
 20:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
In-Reply-To: <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Nov 2025 12:32:25 +0800
X-Gm-Features: AWmQ_bmmS7p123oc35P2Z4K1bi2qA-5GyIOKkN9ecGPR6mCexnHaHFp0vKfQcx0
Message-ID: <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: ABXk9hB6gvkqeKtVmZcCqHPlBSzydVlsiRH2FICe91w_1763353958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:53=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote=
:
>
>
>
> > On Nov 12, 2025, at 8:09=E2=80=AFPM, Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On Thu, Nov 13, 2025 at 8:14=E2=80=AFAM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> >> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >> ("vhost: new device IOTLB API").
> >
> > It has been used even before this commit.
>
> Ah, thanks for the pointer. I=E2=80=99d have to go dig to find its genesi=
s, but
> its more to say, this existed prior to the LFENCE commit.
>
> >
> >> In a heavy UDP transmit workload on a
> >> vhost-net backed tap device, these functions showed up as ~11.6% of
> >> samples in a flamegraph of the underlying vhost worker thread.
> >>
> >> Quoting Linus from [1]:
> >>    Anyway, every single __get_user() call I looked at looked like
> >>    historical garbage. [...] End result: I get the feeling that we
> >>    should just do a global search-and-replace of the __get_user/
> >>    __put_user users, replace them with plain get_user/put_user instead=
,
> >>    and then fix up any fallout (eg the coco code).
> >>
> >> Switch to plain get_user/put_user in vhost, which results in a slight
> >> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> >>
> >> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >> Before: 6.08 Gbits/sec
> >> After:  6.32 Gbits/sec
> >
> > I wonder if we need to test on archs like ARM.
>
> Are you thinking from a performance perspective? Or a correctness one?

Performance, I think the patch is correct.

Thanks

