Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D476C61
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783268; cv=none; b=PGeE0ETn0IqpnrLg3VvpNRYmyC1UwfZkotUh/thvHaK3jHdJKqEmWZ3Fou5f9DiTSJTvoJfGaa7yC9Em977yn+eoSN4hcBUQ1AG4kAgZl7gmAtTRowOJ6PvmOQ6ZBjtAqPKY1wEQBSDm65tTXTtqAX1oQkvHI6nIk5NO6UZ77/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783268; c=relaxed/simple;
	bh=zrl2XYPD2NvxkFXNYylZOdwMoM7HEYcPRbF5dKoLrHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUTOPuv7Ddnhu3APySlHwh05zf+IOx5sqxXH5tdW7eHeUj0CXPgj0vbSTKdJUXIArmdtSfXWziv9dSvAIzSnC0lKdxkibrm9uiBPAWdCDElvpk0wQU7+0McDytLpi7EsYLxawVsjefv5Vmj/jbV1gmkCAgc0WMbw7xe6QBzCW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvUo0dvV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvUo0dvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730783265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrl2XYPD2NvxkFXNYylZOdwMoM7HEYcPRbF5dKoLrHA=;
	b=QvUo0dvVgPGqfPNk5a4h71MdHxXZTyzGkRvMC8BEdkS+eVI/D5oB9hbiDpDulFm3JUbWlN
	kzebijGCg6XmQwpsPaKbBuaNDUh7DIFIMIhTAmV4TpciTnvEqHXkMz87sYTN0qUzyCAhLm
	3jqizSmYpeq/gjyuF9ZaEXH8gWzFsDQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-lnDDafAXPWWUPoerKGN6AQ-1; Tue, 05 Nov 2024 00:07:44 -0500
X-MC-Unique: lnDDafAXPWWUPoerKGN6AQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e2fb583e4cso6135475a91.3
        for <virtualization@lists.linux.dev>; Mon, 04 Nov 2024 21:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730783263; x=1731388063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrl2XYPD2NvxkFXNYylZOdwMoM7HEYcPRbF5dKoLrHA=;
        b=xHwJ2uMGegXUj6+lYxGANxgEJjuArflJQVyJjWj0X1AaRw9G9UI2LZTtdznXmjuDM4
         ywpg6AQvZgShfJD9XloM/PKX2X0gOFWepkKzD05kO8f11cgphwXk6zVebaGoubJTxQZ9
         lo4IRnkohC2+NjVV2AmLWX2ZX3TgszjaDPRKofBAASqbjNclD71w1dBp84a+fgkBcXlx
         S4zTGv4mUXzIW5fs6C6UvlPvOQyuuTfT1PrqdzWFvqIOJoPUALoIcwCuM9pfdWVwzIyU
         C/Ag6io5G9QwG/d5JHHoATo81zKJdJuKYx1LlYaSClyx6V6zv0TGYkkjEti3LiEGcCb/
         KN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaZN4vko/21sL4XfiF9Bau1riQXBhrFSgvDY+SEqBtIycsSYOoq9XFTSHe/hHz0kFMw4horK7KRcB8W6kn5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiA6NOsM98Xm83yTCq+eVUbk1iwTZNabjnWpZDQS33TwIRAq2y
	MH28Go2NovWuol9kesiez/BZ1SPnzQpbbs4ED55abYT1TskOkoXGklNXbbP35odKdvXSMh63Cgv
	wRuFYx42yfVVgQ5tFKJSbQGtyklc3ZpA5zYKdoCW9yuGZZBJODmupNCnR0r4Cw/d+81WusdbPz8
	txbsdtzo9qLEL1Phjmi1naygAyJEX1yapmVCKRBos=
X-Received: by 2002:a17:90b:360a:b0:2e2:cef9:4d98 with SMTP id 98e67ed59e1d1-2e8f10a7281mr36436630a91.25.1730783262977;
        Mon, 04 Nov 2024 21:07:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO+OdM3vh9eQqrFq+MTzxcKxDTbAL58SjGs9/5RKPSL4uG9Ecquej/Aq3fG++zjn39UQYP1k8aOuXwkCsX4kk=
X-Received: by 2002:a17:90b:360a:b0:2e2:cef9:4d98 with SMTP id
 98e67ed59e1d1-2e8f10a7281mr36436614a91.25.1730783262570; Mon, 04 Nov 2024
 21:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com> <20241104184641.525f8cdf@kernel.org>
In-Reply-To: <20241104184641.525f8cdf@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 13:07:30 +0800
Message-ID: <CACGkMEtWrKovFgAiskOshGuP81DnAg6JjtRzNneq1tEa8gQe7A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by default
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub:

On Tue, Nov 5, 2024 at 10:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > In the last linux version, we disabled this feature to fix the
> > regress[1].
> >
> > The patch set is try to fix the problem and re-enable it.
> >
> > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@l=
inux.alibaba.com
>
> Sorry to ping, Michael, Jason we're waiting to hear from you on
> this one.
>

Will review this today.

Thanks

