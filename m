Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B214F9C4
	for <virtualization@lists.linux.dev>; Fri,  3 May 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725706; cv=none; b=bXnACbmkVQC8+NYDoxPSsZxmCVCS2Iq/Cmvvi7zj1LPb6PpP/ihrNjUb0ZXY8HtVolIRfch2i+xUnJaufj/IBgLPSESwz0qy/P5VUji+d41EDeUjctnDQVA6gesiBKC+FxjPp7Xtzdf9Gyocl4kZibTSaRPtv3uRvaHREHtpnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725706; c=relaxed/simple;
	bh=UVlVTMXTLw6RvOzSuoVTlX0sQGNjYzgASvrJB3JYJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SagsmXAA6hkzvbXcoB3C3gdxWTCSDIIlBp1ZIdtJZok3lgcEpsf2FlOvycesc7M7BrqYE9v6jGmXISm3mEULZ2kCbjvMeAWbMD8TT+msFe4m0tI4jxdliBbZVhb2MOKtAOckZPgUBhPc7wNNrPfV8qhOQT522khSUuFJ9VKRH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lFOhJ+Uj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lFOhJ+Uj"
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7480F3F29F
	for <virtualization@lists.linux.dev>; Fri,  3 May 2024 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714725701;
	bh=AlJo1okllW+Gooq+iCi8WFoUidjFb7UUNaY7qhrlJOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=lFOhJ+UjXogCS5bwOf7G0euhuTW8a73BWlLclvCwAr8S3SQHzcyIVyyTLufsHkvf9
	 nzrUeABzomiaiISqZoI24OUMtMC7XvGLrvCI+OwGJJrHv6ve4ZCBxzmp57u01cQqdm
	 4ZxL3kxaug0Z95gHIS3BUt0mbsCyx1GxMhp9deSwojl1ajh6v1LNR8x9VpKUcCp1Wf
	 GDV/8VsQPnFEoXVsqDEIftplRbdiRH5et8eEi8v1WKli6ogFo8PFdwWsUYWBtXOwrt
	 lQk/G+tGSJQsG4BKNl345u3q1H3Nn9hhwq0BZuRQ/wSdG7ee72NxHG4rUkmPZ+KL9H
	 U9yd1J6IdtDlw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5725715b9beso2107482a12.1
        for <virtualization@lists.linux.dev>; Fri, 03 May 2024 01:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725701; x=1715330501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlJo1okllW+Gooq+iCi8WFoUidjFb7UUNaY7qhrlJOY=;
        b=aLo6s3rsEeqDgH/9Oy0mAjk8kDwlI2Puvm0+WjC5HXY4plnzXfwCTxKQtzUzRCMm5r
         AjVU/w+jvdiuDcvDucfO80z0l8kM+D71gQpVxe5JCwj37FV4JOJqDYW+gdW3er75Ebh9
         tZM9Umo3E0Hcc6ugWWK+EYP/i87wTl/3fu5iYJajVU09UsOXWCiEh9Il0sM56cYhoEl4
         0lQfxq4MfkXo/Y9jzubx9loBWO9x9iOV+DxmTW+xR3RdZ7CGg9Ai9RGhB2kIA151KJ/1
         YxpxN4+f1fVGG9PN4EN7U0FTIl3ODgHSck4Dgfywm9ujrD6fuwPni3eRNnumc+AHp4wr
         QfWg==
X-Forwarded-Encrypted: i=1; AJvYcCVg6Oae8D9wpkeOsp7/NxcYLU0oYEeq1vOurEecgih5TKh4RZi+0IMEjzvkHnrAta0Zw/bW8mcSXXqY8Ha4WStTjhmb6ZFMebyH1bTcijI=
X-Gm-Message-State: AOJu0Yy2Cb2y52FAtrqC5xNQN1Fb4lbSB3AjqFuiscnMnby4A7xl+nGw
	+QvkRwYOEsocfOP7hhiglHTi68VcsvBZr69yG5zeLJu8CeE3/ZW9BAGjwzImLStCyGS0gziQNTU
	ysb09J84+c9nLCx1S82V9+vrK0D5ezGI4OP3sRa4a/U4eZwxEy5NbNpGp7z2zxTDWtj3UqOPi++
	KUH94x
X-Received: by 2002:a50:8ad6:0:b0:571:da40:22d9 with SMTP id k22-20020a508ad6000000b00571da4022d9mr3885260edk.10.1714725700957;
        Fri, 03 May 2024 01:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBuV/ajKla/mGXugVGzrUJzKdU39g+p8pvY2kW+73IngbMk+LI6dFP+gITXBDAPHIyVKjFag==
X-Received: by 2002:a50:8ad6:0:b0:571:da40:22d9 with SMTP id k22-20020a508ad6000000b00571da4022d9mr3885243edk.10.1714725700481;
        Fri, 03 May 2024 01:41:40 -0700 (PDT)
Received: from localhost (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id x15-20020a05640226cf00b00572a0550acbsm1447983edd.55.2024.05.03.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:41:39 -0700 (PDT)
Date: Fri, 3 May 2024 10:41:38 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Ricardo Ribalda <ribalda@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, stevensd@chromium.org
Subject: Re: ACPI timeouts when enabling KASAN
Message-ID: <ZjSjQh-deMr5IDM8@gpd>
References: <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com>
 <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
 <20240416133309.6d09ac3b@imammedo.users.ipa.redhat.com>
 <CANiDSCv=E4j0C3R_pCYMxqxe8Xep6LKQGAqJ3PC0x1kFAMq5mg@mail.gmail.com>
 <Zh5p7ILwQYEoUR8l@gpd>
 <20240417145544.38d7b482@imammedo.users.ipa.redhat.com>
 <Zh_e_t7TBUdYdtyc@gpd>
 <CANiDSCvjf1eQmYgoOOfMqPkXcDG2pocXAXGxqwg3Cx4Mba99DQ@mail.gmail.com>
 <ZiAlMHdNVQo0zjqi@gpd>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAlMHdNVQo0zjqi@gpd>

On Wed, Apr 17, 2024 at 09:38:26PM +0200, Andrea Righi wrote:
> On Wed, Apr 17, 2024 at 06:12:10PM +0200, Ricardo Ribalda wrote:
> ...
> > > Doing the proper comparison (disabling kvm), adding '-cpu max' to the
> > > equation and measuring the boot time of multiple virtme-ng runs, gives
> > > me the following result (average of 10 runs):
> > >
> > >                      machine
> > >               +----------------
> > >               | default     q35
> > >      ---------+----------------
> > > cpu  |default |     13s     11s
> > >      |max     |     15s     14s
> > >
> > > I've tried a couple of kernel configs and I get similar results.
> > >
> > > In the scope of virtme-ng (optimize boot time) I'd say that it'd makes
> > > sense to use '-machine q35' and default cpu settings when kvm is
> > > unavailable.
> > >
> > > Ricardo, do you see similar results?
> > 
> > I see even more difference between q35 and default.
> > These are my kernel options:
> > https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/test-virtme.sh?ref_type=heads#L27
> 
> Ok, I'll run some tests with these options as well.
> 
> > I see an issue to automatically set the machine and it is that  we
> > would not be able to override it with something like:
> > 
> > virtme-run .......... --qemu-opts -machine q35
> 
> If I'm not wrong the last one should override the previous ones,
> so --qemu-opts should still win over the default.
> 
> > 
> > If this patch lands in qemu we might be able to ignore all these:
> > https://lore.kernel.org/qemu-devel/20240417135608.2613586-1-ribalda@chromium.org/T/#u
> 
> Yep, this is much better, thanks for this fix. Let's keep the defaults
> for now in virtme-ng, I'll just add a note to the troubleshooting
> section.

I actually changed my mind and merged this in virtme-ng:
https://github.com/arighi/virtme-ng/pull/110

I did more tests and in terms of boot time using the q35 arch really
seems to systematically improve performance (I tested this across
multiple hardware and kernel configs).

It also seems to improve the CI run test (that is executed as a github
workflow, where kvm isn't available). As we can see here:

 - default arch, run test 34s:
   https://github.com/arighi/virtme-ng/actions/runs/8935862788/job/24545125258

 - q35 arch, run test 28s:
   https://github.com/arighi/virtme-ng/actions/runs/8936234891/job/24546173523

Ricardo's fix can help to mitigate the issue with ACPI, but for now I
think using q35 when kvm isn't available can help to speed up tests in
similar CI environments.

Thanks,
-Andrea
