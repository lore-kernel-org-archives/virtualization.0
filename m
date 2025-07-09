Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4C2E7647
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075720; cv=none; b=JSfTprCwKblbLudFoQdW3SXbqdi57cPMKuGT8GndVKPFE+vLkpORpL5ztJQTN4BptKToFthUnoN5vHqGikoirAcbqyLyDUsmdoXtB77FOq0R62/EpY/+dQTIEiF+thZAelDrBeeVxCjLrimb2LvKI++/AcPtECtiXyXHEY8F9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075720; c=relaxed/simple;
	bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG7pr4iN4EYQelyugrXX7DpcFfEQaeRxgoNaTOXT/WOJ+kxu5Omz8MEH7OyIj3c52Crzu908McqhBht7PCU0Z+SjpAmQthRcA5ySgGSmtKMfTUPLdRLlvF0jfUMT4jyOmN4QQULJCiTCIbxPeq2bK3VLaAm2yqyovmvfIntOxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRpeezjt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRpeezjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752075717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
	b=KRpeezjtUvoNzpLvAqZmpn5f54I6NILh9iAg9iYTduM9/jycSw30KKgcCg6AQ7VgXuH15g
	1fSfgVS9vsc0uI2la3IXm5a52plppf+Zv77eHHiUCSjjoWmNr7YP11l9GausLNjdjc3cxb
	rtXvQRj8fNATJaC58AH/rhY4UPvK0jg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-FAae7FdCPkqwF0EIV-ijUQ-1; Wed, 09 Jul 2025 11:41:56 -0400
X-MC-Unique: FAae7FdCPkqwF0EIV-ijUQ-1
X-Mimecast-MFC-AGG-ID: FAae7FdCPkqwF0EIV-ijUQ_1752075716
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e8b565f32d8so1278019276.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 08:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075716; x=1752680516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XShysqjVfJShNze3cNJCjWk2VTczMmDbx321Os6iHCE=;
        b=XM0fj6F22S4P5w6/dVc8qvnRXzZ62s2ILgzbPjqzGY21T1dVB3GNuO7Yxu3ebHcrb8
         haH8DWd/KGyHg4oCTS6VZQ/PcVqgFx7n/jD2PIiDWxtg90B6mJFngXIvhw6ewxK8yFeH
         7+mC1vE1JAqCNAYKds4JP1QuDx4dM/g0W8RBH7tzBcExZRsZ/Zc9Ikv3jZR6pZdqcQ2A
         pT9wtK6F905KA3xrrWCYPeQZq7PpN7G4ZUBA8+rwC0us8EBqR51XPcX7abagJQWUSlSF
         CRhbAnYNQt7hTon5W9kCsIlKPmnNWP5UDRnMb284qGtJlffkgjwL7UpGhEzAXD9vkbDw
         hk8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRdGTkqZX3Ge+a4snwi3MYXwBXuqFBjOe0R2tDyM4FsOffWEoeOz+3iZ/K73KpiouR/moxhVIsjMbtfSSxMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5O7jEjVh82ATiCVeExAfC8iUlgr+fxvr29aUvnDDoczcjp4yi
	qfMjhqhKO3nAzlK4dsYa+e7MFjeKybR85iPWrbu/Y2HchUnVEd/mPeAH2yQTGVGJOe6TLF8UTln
	vCMcxjajGuW/BJwaQSuwl/agNCEKlHrBsQPMegnroPFxgEosZBj1l9OgZivLtexZzSeUy92FwSN
	eg1u5ke/qgq2TFpdGshdKkzBzYnF88hJqbgKfEEonUaAc=
X-Gm-Gg: ASbGncttOC2sCWTpMHILVR/rTDbcZSJWOhN9aSwS9BNkWaJgpewRD3fiaOhxQ9r4lwT
	u8laIROSUETVFKKfNwMM04oo28Xfy9/2SQEIRoJU4WNUYLLQyes/uQCvatuCcdJ2SLEYmNMnvtZ
	9roDEY
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id 00721157ae682-717a044be8amr108447557b3.14.1752075715507;
        Wed, 09 Jul 2025 08:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFxKvhbTdzloCbFbyh1tiZpUMkvI+DBzINVmDyNWIx7ol4flKg78d/Go2l26/5A8S/OniJB3RHqWchsMadAI=
X-Received: by 2002:a05:690c:6409:b0:713:fe84:6f96 with SMTP id
 00721157ae682-717a044be8amr108447057b3.14.1752075715039; Wed, 09 Jul 2025
 08:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com> <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
In-Reply-To: <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jul 2025 17:41:43 +0200
X-Gm-Features: Ac12FXyROMf2rt0OlirwLyo137Qn7MCpqP2NG-8va_x4r6nW2FeYLXGlppWreyI
Message-ID: <CAGxU2F4GbeCJDYrs8Usd8JJcTrp99gyn3c_zXqpnz+UH2NNBGw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kr_8m6fuTYGTooG-PXQcTcWGS6HzXeKRhYh7E1ukKaI_1752075716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 17:26, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> >
> > I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
> > null-ptr-deref" test. Here is how it appears to happen:
> >
> > test_stream_transport_change_client() spins for 2s and sends 70K+
> > CONTROL_CONTINUE messages to the "control" socket.
> >
> > test_stream_transport_change_server() spins calling accept() because it
> > keeps receiving CONTROL_CONTINUE.
> >
> > When the client exits, the server has received just under 1K of those
> > 70K CONTROL_CONTINUE, so it calls accept() again but the client has
> > exited, so accept() never returns and the server never exits.

Just to be clear, I was seeing something a bit different.
The accept() in the server is no-blocking, since we set O_NONBLOCK on
the socket, so I see the server looping around a failing accept()
(errno == EAGAIN) while dequeueing the CONTROL_CONTINUE messages, so
after 10/15 seconds the server ends on my case.

It seems strange that in your case it blocks, since it should be a
no-blocking call.

Stefano

> >
>
> Yep, I saw exactly the same issue while testing a new test.
> I already sent a fix:
> https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/
>
> Please, send a T-b/R-b on that if you can.
>
> Stefano

