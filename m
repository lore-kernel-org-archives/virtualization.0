Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5A2673B7
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843662; cv=none; b=dlGyeULG6ghQU3KGLdnYc/8a4p3LjadcTUVmeZ60DNOE8iPfV9idycAjLAhSmUKEBfEkAeb0ttBaIHhYNw1ncgc/qPAtElxY7E5MuCsJyIGl3xY/eYjPoPO4WFrk3yELkN/vLVZOdt3ngI0nQWS2fzw7HEQaLr3Jh861emqVkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843662; c=relaxed/simple;
	bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhQ87tlheM1BlBu0g7Xt2XaCCF4JI50xLWCrkPBPmelbRXLcHLDCS5tWulo6doPiazFXu7Pwpx6BAVKOOOQCOnssIX0T5mqZd8Ztp8iT+phNRjfB+k+JLC6c5CahsWhqW3PQ55gbYOhyPuRaqBGH7ort/rmVIaj0YUR4yIOwlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5SR+E4q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5SR+E4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767843659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
	b=b5SR+E4qoIqNlInac/aFtFgkKJdvZNj1CB+pPGaDW4w8GwhDhgG5OMF5A+F7+BuHu3frPT
	FzIBChne2YhmZeznPnpZw4WQ4AvsDpLcXRUFYFwb9APaNznciNQNMNZ12JSrFU3tTt4ywM
	VJl/e6/oSCpzokmJVLdHnrP81DH3IlE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-bxlXv53oNMi_OjLc0LG6rw-1; Wed, 07 Jan 2026 22:40:58 -0500
X-MC-Unique: bxlXv53oNMi_OjLc0LG6rw-1
X-Mimecast-MFC-AGG-ID: bxlXv53oNMi_OjLc0LG6rw_1767843657
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so2784111a91.0
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 19:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843657; x=1768448457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
        b=eNyMEvZpnx7Ij4TgrFILy4vhRdA5ZrAAsips79QvBfoC8tC5DZ/04rHEAkRSxvI75O
         dSlWXd0dC9DRw17s3GCzfRWLDC0FXtYSvnA5NQd7OZfU9VruuOjAroskuO3Mmm7sXiwW
         axCpiaaj3Tf2txqe8p/mh7TUx/uZL9Nv8xmnujGBD4Drw4RV2Fp0nouunG+Ngx1PmFCr
         kMN/6SaPxdyGzfUn/3PcDnZLjeDNK3EXnVIhrJ8WCAt7j+fTDxE6UkV8FFR1/FaFtUyR
         q3Ugz7Qq/fpSZio2Xot9lAsmyPiZZkSJXhOAO8bxSPX2ByCnFTqz6CmZ9gxeDluvjagm
         2h5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTMmBJsPHuiIeCJwg7CI3gPlrUdRtSD9Isu9NCghxLYLUjDVf8wtSHRomXavNwJaWLFaVVoVkJl2sU9Cus0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAdrLgTJ7hnkO6fIE+wTV9aLgzdwoamzSx1F/9DVjF04Rdhyym
	SkQtf3DKWWkN3aExmQV//4LRuXJF9PQtz40jkHuODMsAR/WDlrDgbd1uw74Xdx9+l5s4swFcSIm
	qBCazJGw7sgqXhORQZv4bQLRWnlbkQm0pUMICkka2jWgSJugtkCmbsIIM36xDubdaXqWOSqgkIe
	oKqKjwfGnknqtiiSfM272j4TAo/p6ofjz+MkqGdxgWqm0=
X-Gm-Gg: AY/fxX5zpNR8GzMy1ok/8vG3XuIRuB7jZ0+6oxPp2HXwEDmYNSlStJHjK1ZImC61CMw
	x5tbIYZWU39DBzeFMYJdSfpLGMZEb/VUT/ekxjUjdCU0jHeDxmbzgwRmeiqqbhG2n7UNmmz/02F
	xEg/4PX/nTlgWGWHIDbkWaGTBc0txwzNmSdJB2cKOFsvRq77cQyrfJvOgYv9yS9E4=
X-Received: by 2002:a17:90a:ec8b:b0:34a:a1dd:1f2a with SMTP id 98e67ed59e1d1-34f68c020c8mr4599017a91.20.1767843657574;
        Wed, 07 Jan 2026 19:40:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRT/gHviVKg3BmAeVmqnf6QovlGyDQiLOP3X7YJzYa/y5gFMdrkkTDAfiNZ+bZ74TXfET7NZIrA4LL/VqNrJg=
X-Received: by 2002:a17:90a:ec8b:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-34f68c020c8mr4598982a91.20.1767843657139; Wed, 07 Jan 2026
 19:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-6-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-6-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:40:43 +0800
X-Gm-Features: AQt7F2oQUWxfwmKfkPMH58sXdUHRR1BABNg8c-gOhAXPWs9rnLQwCP9cTooUbiA
Message-ID: <CACGkMEs-V7g6fP418K3SmD-oayT0mGOnzPt-ynkNAjiSVfHppw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 5/9] tun/tap: add unconsume function for
 returning entries to ptr_ring
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mPi9g1xkG2QWBSVZv7tMIQQ_hSDU44tAU3LoaMWw8Rs_1767843657
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Add {tun,tap}_ring_unconsume() wrappers to allow external modules
> (e.g. vhost-net) to return previously consumed entries back to the
> ptr_ring.

It would be better to explain why we need such a return.

> The functions delegate to ptr_ring_unconsume() and take a
> destroy callback for entries that cannot be returned to the ring.
>

Thanks

