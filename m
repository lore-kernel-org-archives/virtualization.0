Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94F139D0A
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502722; cv=none; b=ALmCIACWB+8mV5poiafiRGO5V1skbCF0Y6cz75RQ0axDsEDH/xLDm4KM6xt6sE+s8HhGDT9VZYS3iWHcXAjM78kD1xdDp8M4KdmixBy9RpSIo0pGrd+eu9l418aR9BzeaN8x0AidLB1sv9bqtD385ViW6COCJ4bTOtPd/x4w6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502722; c=relaxed/simple;
	bh=T6tfiulQG+spNomadDuTnkC/nFyjA7NR0xNHBVgdaZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrRw5+VYcmgByfgYb7y2DyESrV4tixBkIct6EDlJI3mA46yZRY4/Oez+MzMZ+wmE6dbWOUqv5vhnGINHqTqRX9HCkv00oA22ovcEdBvERiaCVMRQgW9DW4qLzjr2yRCjKaF5iAqDzJZoNC9hGGD7el1jEWc3qJD5W1wNFsfHcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+INTU25; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+INTU25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6tfiulQG+spNomadDuTnkC/nFyjA7NR0xNHBVgdaZM=;
	b=N+INTU2544aohOPTr0TCMvnmrku7FuIcgrikoAQtTCBzffc8ganBZCfMY2jaMTHzEO/5ew
	1JzQQPaHq58FGC/AxuAQZB/0j9yyz4A+NteRWi9KBaZ6qZd5/onSxUMKd1b4UplYiV/N1N
	La16mL81DZef/ui22UYN+//D8lbnrM8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-39RUrZNIP5GkRKj3Huf4lA-1; Sun, 21 Sep 2025 20:58:38 -0400
X-MC-Unique: 39RUrZNIP5GkRKj3Huf4lA-1
X-Mimecast-MFC-AGG-ID: 39RUrZNIP5GkRKj3Huf4lA_1758502717
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77e4aeb8a58so1994106b3a.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502717; x=1759107517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6tfiulQG+spNomadDuTnkC/nFyjA7NR0xNHBVgdaZM=;
        b=TaUweK8ZTiuG062Dp00mdwfHwq0cFpANL97QbUlB78GNe+N15rPRt5BlCIpC6QISTw
         GC1vsNkV+wtLh13ROaAZzpXznZgqrVzcabqDe+ZiYhQd96MjDyLl6HH1aVREkejlzsMI
         3zkjvGcJfSJ0H8xEaK8r6FzX8dTM9ki8a0JLTSq5w2FJFg474pbqqb3Owp0QAYEFUGgO
         3Unr/Rc0Ovl+ZH6oeQEi4fe4SIibitJmpCbZMfEZA3qEfeNSbRxutOeHIwZvYhY5p/vD
         GwuOz7CsvmymjaZSfafMM6YKizim/VWq22X88C6+jJ3H06LTBd+JcI7yvFO1DegEBHW8
         2Uug==
X-Forwarded-Encrypted: i=1; AJvYcCVJrisr6zDO4WE2/kV5BZfV/kQopBzsNdxpLpblic4M7jfsYjRvMh+2sdK5EaQA84jMD01zjCkuOAQ5paRuJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRtkx+hkaV/YkZw7qUAOfgAojLCYLH2911thfIOz84alVIDula
	ljtDcdn81NJ6TP8SMygrc8sP4AwdXkB5jEmX8guK4x9cNhyxzUob9N1yvvUh0YzK4VWYw4O+3wr
	Z6+e+Jrv2LkPwhdQLjve29K6F+74D8Dn0+PIOPB98JFSakagy37blSrfhA8ynP0lDdRCs9icL2/
	J45ke2OegTlm0PW2R2/oOYiC2I6Ekda9cbLHKo2r6v/tg=
X-Gm-Gg: ASbGncvXB43WSAETvPgci5QjcxwTn7XLKiMsqnMjK3km9bPvykN7cAIDts2I6DFNSuU
	md6HVQKLzVULpL0DhM0tmgj5x8aKXK8Vz4Gh0fSqFNaPEEzenRbc4lyK7L1GAQtAcWz3wpOIxYJ
	ceiHMTmg+e+qjQao8Ij+bHTw==
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a50b with SMTP id adf61e73a8af0-292762e1e5emr15160568637.59.1758502717291;
        Sun, 21 Sep 2025 17:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU49b1OLZTShTMzjMrSzEIICcIsG4gza3XDPGe0wySbldoNRcgacZ54sjtyDmDtkanSS+3TiA+qzduh6i6+lc=
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a50b with SMTP id
 adf61e73a8af0-292762e1e5emr15160554637.59.1758502716923; Sun, 21 Sep 2025
 17:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-18-jasowang@redhat.com>
 <20250921143014-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921143014-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:58:25 +0800
X-Gm-Features: AS18NWDJs_S-haReGVLawFCJUQJfYQJ881bo57npl_YRU2E1RTwRiJjUTnRbrv0
Message-ID: <CACGkMEvFL6ZbvdWtp8W+pBE032ictXMP4Nm1XySceW_LuaYG=Q@mail.gmail.com>
Subject: Re: [PATCH V6 17/19] virtio_ring: factor out split indirect detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EPbXknS_oKMRYkZJla2dsR72Wnb_CCN5f4-LSijsV9U_1758502717
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:30=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:52PM +0800, Jason Wang wrote:
> > Factor out the split indirect descriptor detaching logic in order to
> > make it be reused by the in order support.
>
> and I think you mean "allow it to be reused"
>

Fixed.

Thanks

