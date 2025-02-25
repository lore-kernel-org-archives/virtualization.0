Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C0269AE6
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493295; cv=none; b=KJgioTuxDF+2SYerk8CXAUJtpNbQ4+iQF0OImZadAp/cb/3zJaii/q2/SEgpUij4iGqJpLoYyhG9RlIrmO3CnlxOehUwBWT5967YxBahUA53L6luu0NEHQ6wbRhy/tXTHiflDFxIYbUpzZQpdQL46LmbjJ1q8ocp7vyXWaMPA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493295; c=relaxed/simple;
	bh=JOzSXnruxMx8fo4ynquuHZbCjEVyeQDk3Gw08yi3rfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vBC9K/os2eOINZ5fmB10/1VHALUCexFfGUC13i7lbS5tYVfHM2zKhJkBSADtVgBhc2//YAIAPeYkaN0y/Xcxb3sBYfewhxsR2d0AyvIVRWolkAHnyROrtg5QQ/5Pyq8IUdMa2IsiKzxrJpLY80xWJsWKv4C6DT/sZa8xhCqi9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV+gF3aB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV+gF3aB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFFVttm850UqVz1pmb+AlnJQK6y1OGWuLBvoqE/ivD0=;
	b=dV+gF3aBJG2ObjJtIOteRp5o4ZeAAdcEKWswESee9ZMQmGHBUaahzzAvaGbeDOp5nEvgMS
	yxigvz2BdKIrv3feZK9uw/ziY+BM2BRNPAMbzrRQzSoNbao8v6JweV1l/2DhQ6xb2pjIi7
	JzGOCritUGnPMlHVwgTaJeMHu1uAWP4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-P4qKvM_uMA6zJh-zwEl-tg-1; Tue, 25 Feb 2025 09:21:31 -0500
X-MC-Unique: P4qKvM_uMA6zJh-zwEl-tg-1
X-Mimecast-MFC-AGG-ID: P4qKvM_uMA6zJh-zwEl-tg_1740493290
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f29b4d4adso2317845f8f.3
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 06:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493290; x=1741098090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFFVttm850UqVz1pmb+AlnJQK6y1OGWuLBvoqE/ivD0=;
        b=RZOUE7ys/II1P2SnV4VZRWhYbMJrgJPUn1x7xvEBN11CG0lLT8W/ZWvPojWj4IrGM6
         pa/BzSbv33zfABov8Gm0rN1WbfPfJh0P7Bt6lis0arLMyzBaweADPWjbic+giffKhk3C
         hyUFkj921krw3flAMJwptVWU0wf5BwP2+cdT1f+tcOCMX23RsG5zSdiCvPGOZNLsFnlC
         RTxu4r//LBKANN2FY0AVyeAiuv90hcu5XFHgOUaunhHgJ2PDzwLT3oJgdYvhYYUD0QIa
         Em5t3tBsUmRNr6/Ffq/IHRkdPScFvbBu0ykHzrQB97zlLrabOVhjcz3VFxiu/c8iINqM
         uc6A==
X-Forwarded-Encrypted: i=1; AJvYcCXvXOZOvX1m85qZ8MkpaGv6UjG11xjhkhBYAN+uJb0ondpHp7y7jLdIadM02zjBn2gS/GtTg6n6B07w7XmW9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMsgbpzNv+21gEqnFs2cR7qVJwUbrU1FuwTjmQiWyCMwFEN81A
	Ix8iRVcpuJ3fSXi+NtYJS9i/0PIYxgOT1aESe/RuxuG7m9kH/Fbr1Lp/YfeToWAe9Jr1SJRWP7Q
	hiW3XXbFClwRng+9qWRQZYFKWJ4Zhqcfs3uPjsvIhmT1E2+dd0HzJj5tGZzdXuXMh
X-Gm-Gg: ASbGncubRr9plFQENMoHkI+hrtwzMeIBpSIgs3CdU0osKJw3nvwOCaz4lJ8/50Vp9fo
	tCeeMyxFk1KJyUFjxPEWAAJROJT4qMkSZv66al3NUEAYIOm24lBH4N8qm8KGhJ0YdEzkGeQeejW
	e878K90tis2c8d309yU4/k91ZjIlKd/ddw/viNl+IsRLf3iHoDtjkB96k35QGtf60Llfs5SDq5t
	lDxQLfj8ZfGiGvEY+uQ5N0kYlIjfvn94deYgPi1gLzs3aIuR3YwH4t2UpLudxMdbmA2HkuC0H43
X-Received: by 2002:a05:6000:401e:b0:38f:210b:693f with SMTP id ffacd0b85a97d-38f6f0ae79cmr12378081f8f.52.1740493290279;
        Tue, 25 Feb 2025 06:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPzWsgH9v1k2HVPYkFXNJ3hhFz69OOLf5Yi+p9svSln8YhJs1OVyxaR00ASzjgQujycgWCZQ==
X-Received: by 2002:a05:6000:401e:b0:38f:210b:693f with SMTP id ffacd0b85a97d-38f6f0ae79cmr12378040f8f.52.1740493289721;
        Tue, 25 Feb 2025 06:21:29 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cb08sm2423039f8f.29.2025.02.25.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:21:29 -0800 (PST)
Date: Tue, 25 Feb 2025 09:21:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Peter Hilber <quic_philber@quicinc.com>,
	Jason Wang <jasowang@redhat.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Parav Pandit <parav@nvidia.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] virtio_rtc: Add PTP clocks
Message-ID: <20250225092115-mutt-send-email-mst@kernel.org>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
 <20250219193306.1045-3-quic_philber@quicinc.com>
 <20250224175618.GG1615191@kernel.org>
 <vhlhes7wepjrtfo6qsnw5tmtvw6pdt2tfi4woqdejlit5ruczj@4cs2yvffhx74>
 <20250225141240.GW1615191@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250225141240.GW1615191@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gjajg3BrJD4tKwXuoPEKYIeCgy36YL9BnBSXBDLyYCc_1740493290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 02:12:40PM +0000, Simon Horman wrote:
> On Tue, Feb 25, 2025 at 12:28:24PM +0100, Peter Hilber wrote:
> > On Mon, Feb 24, 2025 at 05:56:18PM +0000, Simon Horman wrote:
> > > On Wed, Feb 19, 2025 at 08:32:57PM +0100, Peter Hilber wrote:
> > > 
> > > ...
> > > 
> > > > +/**
> > > > + * viortc_ptp_gettimex64() - PTP clock gettimex64 op
> > > > + *
> > > 
> > > Hi Peter,
> > > 
> > > Tooling recognises this as a kernel doc, and complains
> > > that there is no documentation present for the function's
> > > parameters: ptp, ts, and sts.
> > > 
> > > Flagged by W=1 builds.
> > > 
> > 
> > Thanks, I will change the offending documentation to non kernel-doc. I
> > was not aware that these warnings are always considered a problem.
> 
> Likewise, thanks.
> 
> I guess it depends on the subsystem. And perhaps this is fine for virtio.
> But for Networking at large the rule of thumb is not to add new warnings.

Nope.

