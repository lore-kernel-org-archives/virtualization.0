Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB2DDD9
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428976; cv=none; b=TDwOdR1NHiYEHqufwOg461lxLPKHU2915sMIwZKuFcTqAXdA95YRon6gpzdaEI9tQsqLpmqgnpsaBlMXP2io2HaCVgj/ARcSY0QQEt0sxzM7uDU0MdNliOnoXebQacxFfKSFV10ThWSJNZaMC20S/Xo7qhI3pqiWnLywifQ4MNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428976; c=relaxed/simple;
	bh=AQfUW3gFNrbjXXL3IloGvW+E2jBS9PDIeGTSBRAl+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OmyXqUVGeWQgvuFixQIirL/7GW2ijlOefu/ppR1rGGRhvphNdc4dGiiIA4xpaLQz/BvEfsxux5oMRuGpmqaqXocnlcQUBKHuXJWHrsrg7I/APuaLGzlIaKnaYfg1ejCkaJP+umZoe8Wg/8N5rMbhdI5mcN3ljaJl5okt+T2hT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fl97IKut; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fl97IKut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710428973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EtZDDd/rvhCl2ys9FRYjPigN0aLlgEl2NbUy3nuNa/o=;
	b=fl97IKutY6aBnF6qX2fmlgb9ew7nFw+Hy5KJQExEFLk/2yniut/1NydZbLmn+wCCJ/dSkh
	utSAgXIUUMyhI+rRsOgTHCAei7HTPlZq8xtVg6HWIbF6JL2PUXU5NwehMPSDlN6DSEkHWO
	k5ZHUqvFtRQ1VaUBHyRZ2tVFZWRmfmE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-xct7V9XPOlKPQpAzDMClog-1; Thu, 14 Mar 2024 11:09:31 -0400
X-MC-Unique: xct7V9XPOlKPQpAzDMClog-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513b3ca9650so903487e87.2
        for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 08:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428970; x=1711033770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtZDDd/rvhCl2ys9FRYjPigN0aLlgEl2NbUy3nuNa/o=;
        b=or4FySB3aBjGCO2fFOuzQO7IHpnTYY2WYz/JW5jmlG6482Ud9TIMvcTMFuOYbpU6X0
         bXI/AtyUry3K1S2hCSBKQ0rpA4taP43eFjsimIy/iSpc6JBy7KVMQ+51BFjaIlhfJgRU
         ADbfBGOpG/GLpEHKTyb+VH5A8XpNzMnNRZ0ui75IwymYPp0NXJvZAyORPmhTT+k9jwfu
         BWE5LLYd5ZMK/pjEQMOba+NWf0xJU6zVLOuHrP57Nj8XsMXtAaCbqH6dG0ENDAc0qYBy
         JM1ZE+0WSluyETp7mRHVtGC4Hl9cs3dNvRGuBrGzsvZGeLZ3u1KfHbvEEKr03eHwS3p1
         U5dw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2qLy0Jd1Y57lFYqkgM8sdPKbm/aa9nFJrsEEKRZhHIr0baX/mxSibN+flsMPRO3wSLXZJG5u6uHwp7hyKbT3UCxwRpP40Wj9ZyngD+U=
X-Gm-Message-State: AOJu0YyBIc7O33eNaE3008BvsyImADhuGNdWIGXiGPbIMcNTwMK/5cQr
	DEYnZMyvdx699FCdaxeWPCrMx0btosRI3drV7L93KL86RNSVKswWY5G3+hYYPBp81fj02V4cJEN
	n0gqWizn39WTj/7jRRsC2ELLNYHadNCT6KRx7tDCdBljuNgjwxdVWlrWZr5J9CK6k
X-Received: by 2002:a19:914c:0:b0:513:cab1:dc9a with SMTP id y12-20020a19914c000000b00513cab1dc9amr1492774lfj.19.1710428970157;
        Thu, 14 Mar 2024 08:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJWuoe/3iFru0sIgh80GCQKJ1jGXO44jJmLMs2cyMkKY2erF0fOYFgEPRPLaBXlctWIZnyYg==
X-Received: by 2002:a19:914c:0:b0:513:cab1:dc9a with SMTP id y12-20020a19914c000000b00513cab1dc9amr1492752lfj.19.1710428969612;
        Thu, 14 Mar 2024 08:09:29 -0700 (PDT)
Received: from redhat.com ([2.52.141.198])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600c4e0900b004132f8c2ac1sm2732690wmq.14.2024.03.14.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:09:29 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:09:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240314110649-mutt-send-email-mst@kernel.org>
References: <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <73123.124031407552500165@us-mta-156.us.mimecast.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2024 at 12:46:54PM +0100, Tobias Huschle wrote:
> On Tue, Mar 12, 2024 at 09:45:57AM +0000, Luis Machado wrote:
> > On 3/11/24 17:05, Michael S. Tsirkin wrote:
> > > 
> > > Are we going anywhere with this btw?
> > > 
> > >
> > 
> > I think Tobias had a couple other threads related to this, with other potential fixes:
> > 
> > https://lore.kernel.org/lkml/20240228161018.14253-1-huschle@linux.ibm.com/
> > 
> > https://lore.kernel.org/lkml/20240228161023.14310-1-huschle@linux.ibm.com/
> > 
> 
> Sorry, Michael, should have provided those threads here as well.
> 
> The more I look into this issue, the more things to ponder upon I find.
> It seems like this issue can (maybe) be fixed on the scheduler side after all.
> 
> The root cause of this regression remains that the mentioned kworker gets
> a negative lag value and is therefore not elligible to run on wake up.
> This negative lag is potentially assigned incorrectly. But I'm not sure yet.
> 
> Anytime I find something that can address the symptom, there is a potential
> root cause on another level, and I would like to avoid to just address a
> symptom to fix the issue, wheras it would be better to find the actual
> root cause.
> 
> I would nevertheless still argue, that vhost relies rather heavily on the fact
> that the kworker gets scheduled on wake up everytime. But I don't have a 
> proposal at hand that accounts for potential side effects if opting for
> explicitly initiating a schedule.
> Maybe the assumption, that said kworker should always be selected on wake 
> up is valid. In that case the explicit schedule would merely be a safety 
> net.
> 
> I will let you know if something comes up on the scheduler side. There are
> some more ideas on my side how this could be approached.

Thanks a lot! To clarify it is not that I am opposed to changing vhost.
I would like however for some documentation to exist saying that if you
do abc then call API xyz. Then I hope we can feel a bit safer that
future scheduler changes will not break vhost (though as usual, nothing
is for sure).  Right now we are going by the documentation and that says
cond_resched so we do that.

-- 
MST

