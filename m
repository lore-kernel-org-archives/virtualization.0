Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E529207656
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494637; cv=none; b=ZwqYy+H38xRIKsI3KH1rEFSSbhBjZt0RQE0utRa0dXaLvnwr03DULk+AgbMdj5KaSejMX9OMhSyTP80/xJ7YSUjsi75FHM56OvH5sgwRrXU7LamqHT/Ml/pDPq9EERo6JAcTyVAMEQPn1V2dE1sjtYz4MWZ/hx4g3Hv9eWN16ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494637; c=relaxed/simple;
	bh=lKkX0jSDmzCgHP0q2ZI55ieL6iTIROIb0PrZYeN893Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4NAhYhDs7OCkFzvkdJaLTIVqSgrOJwmeivTsbnQ16S/f+P7b6458jgIXGvHYnkPc4cZk2Q/qD/Dx4h3/2fxaYnZjE2StM7sOgez/uzrxtjovutcGq851BhiknC8VmXgHJx7OJ4aiWORud9nCe/vh1FCMZ9IK8O2PWZ4aKouv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLLSpljM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLLSpljM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D01A040FDE
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 07:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OwwTVvvnm2QH for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 07:37:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A58AB4024C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A58AB4024C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QLLSpljM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A58AB4024C
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736494632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKkX0jSDmzCgHP0q2ZI55ieL6iTIROIb0PrZYeN893Q=;
	b=QLLSpljM8n+I/4XrN9pqJY8Q/snSUYtrzlUFL7MHbjkUFR+blXvc3R9nY1eBnyxdSzciYj
	Rg/D2KC8ESDPZTHhMBG+d0PFWqBUrhGZPj3HDvNRKDBnG3bUw//uhbqEJ9y8iwZKYluwuC
	u3l8WP/vF6NF1QFhe3qHO1p69YY6FAg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-SHPyC1nJMtSpRSDjTCN9rQ-1; Fri, 10 Jan 2025 02:37:11 -0500
X-MC-Unique: SHPyC1nJMtSpRSDjTCN9rQ-1
X-Mimecast-MFC-AGG-ID: SHPyC1nJMtSpRSDjTCN9rQ
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d821f9730aso2701963a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 23:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736494630; x=1737099430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKkX0jSDmzCgHP0q2ZI55ieL6iTIROIb0PrZYeN893Q=;
        b=RhBn6ogywCRTT7e1o0LVt6pjpXj3OoPKGE4vXxJOlBG/athZMx38xDtzoNT/XDToMv
         Its56tuBnBI6fw6rXFsgGz8N5oTY3WK7/o6P4nOFv7jLVIGcbfxgdKV0uCMFybTYtTvS
         naIb6VsSBccvOFoH2icRnFeq1U49aPfHsMkUZwP0n8Qn1Sw+5y1mb3vIHLKSBqYxi6mz
         4qoOp6kXtHChL7wVhTv1jrleoIY1kZ32YXItQ1Ez0Hp0qdigyb0LzKJsB9pY7COzxMT3
         aZ1RrThsN89+TD6WC6X4evhLJP8TY8KlXLGIa3/Hkj6Fvy+F62AkjXT4+INwGnc6IyB/
         VTnw==
X-Forwarded-Encrypted: i=1; AJvYcCUv6TT6uGAXO/t+5g0ntg37RXy8a9yCcFOiyEnUTzItYx9kMYf+BBTEaKQNnIysWhuAyMZOT8tzAjPxcQ87IA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YytNGSYH9bq3BdgT92Vpt6qziHu/xzKGJnc+MwJ68nDC4ojPpMN
	4hjGb6g5KD78N0y03dOpvN/mjdl3jM5LqGPgRe9PPZeODbzaxsR8tmLrJGOfHU1xa/brE1/QAu5
	MN5jCeQWBaXnKMpPcCxAj919/nKg34VA1S5j7KQ2j8EV9RS14dn1eiJcctgy2f/b/xSuEIZXMHC
	tf4hbaOjau0blr8wm2zR9+yKTauvSsaSKyuE6t0pyHw/HQ+V+zi+QEwA==
X-Gm-Gg: ASbGncsTckO26+geEjYtUS2o78Wx5GC6Pbr6cyasCdsWxRNmbnrLtZr7R9tAF0INILB
	F7SxrNZ+833EaPksr4Oh5o7SdjCnBBU28UZQhJAU=
X-Received: by 2002:a17:907:3d91:b0:aa6:7ff9:d248 with SMTP id a640c23a62f3a-ab2c3c452c8mr540921266b.8.1736494630074;
        Thu, 09 Jan 2025 23:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM+E3EJ9VIADqft4XZeqnSe1+lGGIJwDA4N/xijHGbaNmJmQVeQUzAlHVdy720k+fmj7KB/3fUzKLdRp4U0YE=
X-Received: by 2002:a17:907:3d91:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-ab2c3c452c8mr540917566b.8.1736494629743; Thu, 09 Jan 2025
 23:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com> <677fd829b7a84_362bc129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <677fd829b7a84_362bc129431@willemb.c.googlers.com.notmuch>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 10 Jan 2025 15:36:32 +0800
X-Gm-Features: AbW1kvYh6DcaW0cgKJgVFtgsup_78mHRUFkOPq--rB-NQ70GCEus3ijRcbVoJWE
Message-ID: <CAPpAL=zta_HNWcWsbL=0ymRfd_ZKx1nZ=F+Jo4kLXaUnqFnLDA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FB_3U8GYlrRa7uNaPVbYR2CKh-kfNTtmfMT2OWlo6rg_1736494630
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches v6 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jan 9, 2025 at 10:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akihiko Odaki wrote:
> > This series depends on: "[PATCH v2 0/3] tun: Unify vnet implementation
> > and fill full vnet header"
> > https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
>
> As mentioned elsewhere: let's first handle that patch series and
> return to this series only when that is complete.
>

