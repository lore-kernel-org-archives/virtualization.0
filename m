Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2482134B
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382712; cv=none; b=TFX9eGBktZmO9v2mp1ZSfHzqvXyWueRyveRJEH12DLi1k2m6zlQulmfR9vDuYKYNHOd3jh79rGUrWsTJxWb8qGs7ZG8MXRyTw69U67gRT1lohSSEo2VJWsl7QoN6+OqTFMOA75Fmn2g3lXT2bjl2OI06uvYjSQglH1c/PA3smqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382712; c=relaxed/simple;
	bh=l/wYZ0ksvviQhpjY9LlJjCHAcP+r38z8pgqoLqwTWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8mU9l9YwLZkAe/6sPqaFZhQV6Mu80IepR60ePOA8xAh5X2SHzBnh4Zw5BMp9UDap8BkpkFgjoH7UTUko3FcGSnTGxHlxXp6VHx2wmQ72w2xJvGwIIX/+3xl6ElqjjzeqImza59Tj8XXg5cYB/nZdfya0mssjKYWdXjEElwNwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jsPtaBmH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jsPtaBmH"
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2FBD53F16A
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713382707;
	bh=iOeyJ4evXx6rV3MpTAu7yvKllv+Ll7t4Cr9zvfgjKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jsPtaBmHsre6kG2OxvxcsRQ1MvENIWeX8v0C3FjFSqmFUo0sCT/4ADKS15QX3tL+5
	 8FWLYVuDjEL9AKnsHkP7nqpDAIyQfLxGGCpk7oUf6dFykmKoGacDQQ/9TdjC3+U0v6
	 qmtfDNTnZH/VujN8Pz8Er6Ekgw0GG+qmQBPaptZ25xR2Hdx8qPS9dX46k5WZDNBmSS
	 hl8PEPgoHXy/DQ0t/uMq9lv5+RC2xpt9gpOJzQSLXVC5tFPcmkEJsMY6fDxySFzjlf
	 7Wa7LgzvXPwQPfg91+6AcmJVJLAnODqTFvFM0EVn0+isQfE+MhvY/yejslSdo3iqiv
	 ZLsC/IwQgUe8w==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57030f8ef16so42053a12.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 12:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713382707; x=1713987507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOeyJ4evXx6rV3MpTAu7yvKllv+Ll7t4Cr9zvfgjKPg=;
        b=OBiZKj0vt3JLZc1riu3mCTt/6RUzq6HHC456GBgQF5xlpTMxckOYQkfS7V7y2S0Nba
         dK3DzY7wBcDLzhz94k6sFovGKg4K72T+cX+XMf0OIGplQy910+093OKfSSSCnbTgt/Pu
         qI3Uu43tZK94zZOjt1YmIUPFc+z2JSaozzTRsRM4J3rpRZttpI4b1no0cZAIPAWwPMlw
         1dc5CR/z3c72d5qvIJzVNPcUbadxsYEewmu30Vq2yVaWR2/tZyxfWhLPcpOiwgHBn+1a
         lVy3Q+n4jmnW2OVqeVDLVt0PJD8Z6feF1zxPDhbAPM4mOv0Z/kQpEhKrdPk79+vQMMGs
         axBA==
X-Forwarded-Encrypted: i=1; AJvYcCULjEI36QvTYKFRcm6o0zGaOkXiirZrvwtIP9nkT/Hh8cvNQddCem6JLB204uMe8j6pGm8ANrx1BjQayCFDimhUn20gXOAFYKSMdEWYeM0=
X-Gm-Message-State: AOJu0Yzg+WGw2AogDZYeLNjoAhsFJXVjaamgdxU5gpFDr+5K5STxyi5v
	btn8wLWq9YEZcJiobnZImIx46KwjxMokT4GS2o/1RJRsjBemHVZJKbRLU42eictx+FS24gpxSkX
	9ycE7qUJjDbuqfuPpnCPiGhILaGDn5Iiv2HxJApa8/JLEfSGHeQc9Fk5Cb+Vbgr1L1IGTlEQtHc
	uF3fvO
X-Received: by 2002:a50:d68d:0:b0:56e:c16:fbf2 with SMTP id r13-20020a50d68d000000b0056e0c16fbf2mr429376edi.23.1713382706711;
        Wed, 17 Apr 2024 12:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb2TGMJ45QXhg+qix3UarLGrjHpAbpXr4Gjc1TOH/dXyStFuROOOzW8fk4uT44UWdEfwoEpQ==
X-Received: by 2002:a50:d68d:0:b0:56e:c16:fbf2 with SMTP id r13-20020a50d68d000000b0056e0c16fbf2mr429351edi.23.1713382706050;
        Wed, 17 Apr 2024 12:38:26 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id w4-20020a056402128400b0056e2b351956sm7585561edv.22.2024.04.17.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 12:38:25 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:38:24 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <ZiAlMHdNVQo0zjqi@gpd>
References: <20240414043707-mutt-send-email-mst@kernel.org>
 <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
 <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
 <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
 <Zh5p7ILwQYEoUR8l@gpd>
 <20240417145544.38d7b482@imammedo.users.ipa.redhat.com>
 <Zh_e_t7TBUdYdtyc@gpd>
 <CANiDSCvjf1eQmYgoOOfMqPkXcDG2pocXAXGxqwg3Cx4Mba99DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCvjf1eQmYgoOOfMqPkXcDG2pocXAXGxqwg3Cx4Mba99DQ@mail.gmail.com>

On Wed, Apr 17, 2024 at 06:12:10PM +0200, Ricardo Ribalda wrote:
...
> > Doing the proper comparison (disabling kvm), adding '-cpu max' to the
> > equation and measuring the boot time of multiple virtme-ng runs, gives
> > me the following result (average of 10 runs):
> >
> >                      machine
> >               +----------------
> >               | default     q35
> >      ---------+----------------
> > cpu  |default |     13s     11s
> >      |max     |     15s     14s
> >
> > I've tried a couple of kernel configs and I get similar results.
> >
> > In the scope of virtme-ng (optimize boot time) I'd say that it'd makes
> > sense to use '-machine q35' and default cpu settings when kvm is
> > unavailable.
> >
> > Ricardo, do you see similar results?
> 
> I see even more difference between q35 and default.
> These are my kernel options:
> https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/test-virtme.sh?ref_type=heads#L27

Ok, I'll run some tests with these options as well.

> I see an issue to automatically set the machine and it is that  we
> would not be able to override it with something like:
> 
> virtme-run .......... --qemu-opts -machine q35

If I'm not wrong the last one should override the previous ones,
so --qemu-opts should still win over the default.

> 
> If this patch lands in qemu we might be able to ignore all these:
> https://lore.kernel.org/qemu-devel/20240417135608.2613586-1-ribalda@chromium.org/T/#u

Yep, this is much better, thanks for this fix. Let's keep the defaults
for now in virtme-ng, I'll just add a note to the troubleshooting
section.

Thanks!
-Andrea
