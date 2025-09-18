Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1A2459C8
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214342; cv=none; b=iqmSKGolo6RdeCOVMqCwHU8FaYfIhvBdR75lXfUzVYz1/OI4Tja9yiSO8iQmR6114+PpUIaENwv8ml62/I1KjkphMAEjHIIddtS+l0tKNyqYO/GA2+364f1kNx+rhptODjOfsjOaOqXp4y0YARurXnogDp/TU7LrYFRdmgJ109U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214342; c=relaxed/simple;
	bh=g+mvzN6J31AfqxKTFRmGGmksy1PcEAtdFhY3hfNn26E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PyChCrKtS297jEerI6BEEfI6f29EuyVjuiV6j3U9DZP2lS3LSFIXOPZ5Jyb8uHoKmiRmHoFr7e6mQwpeUdEmnKf7e5HcNxiRB70m3Ge3TJvrpxFV81fuyBdQW7UZdHLC004388vCGfnZX5glcPnAIc6GLki4LO7FGppWc2ucKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORXbt45W; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORXbt45W"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so1218387a91.1
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758214341; x=1758819141; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TsOm7EtOKhXmScTczmTf6QtxSQ4DX78bGCwpxVq0Ey0=;
        b=ORXbt45W9V1WlGgtDHr//lHI7BbroaBQK16yanrBS8v9CadDHAi+hMKqcbe+Jrh7MB
         +H92+eO4oMjwVp7TF416oPV6CoTeRnJZ2ZW92wLWCGipM49hbX4GDtQvP5xGHDHOsR0E
         fOKK2EdbOKzu0LcMdqicuJ+Tt5JxDdbcO7gw/J1kT683QsWFd59h98rGCjd0fWaRwKc0
         Ga5EKkparurkNPgYGfbXBteyCFhmFOHEda+swevc6Ln/TOneHmBUZ+0b+9aboiaW+DcC
         UfqLu2OAn08uveszxiac7DRHm+ZMHroI9bxlVb4lLXwE20erWOTheWaq9D+hm8o6yX79
         vgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214341; x=1758819141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsOm7EtOKhXmScTczmTf6QtxSQ4DX78bGCwpxVq0Ey0=;
        b=gIwcmpXnd8GIMd0b9pNSFseCmHF6fpr1uBTJTkwnB+6rVMdzmnKMAvk7eVe4+s4Z2y
         4QRGn6l2BtUI7SiyRdVKPv6ZXoD7vSYyuXmhlKKDSqf0CNn+giwYhA1Wf+LuGWS78Khf
         LPudfQ5JoLWVvIxBLp1X3/96xRlZBhykW/zSFmedhgt1n+rTm3M/zWVM0D3QOnN42JMR
         xsZB2czxLtNy3mp6G+qdvKY7upC7rUg2V7ABGdIwSsbaRuRhh0ElRTUt4RPWXp4g0Rz5
         auU+mlQS9V0iBervelujQsqNOA9tcMwFsBGKLkMv/gX+dFC8+V1hA9scFVAQNiGT81SP
         XPxg==
X-Forwarded-Encrypted: i=1; AJvYcCVEUVCOkVxnJ8s+N1jqzjffJa548wkIhUJxSjgZphhafgNW58xbLavCYRPaY+by6lKG2gpFSsWhMsmwtv921Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxzJJ6IUveOzahyu/tkO+SQ3Q5HzknF/ULARgXzNNIztuZvlxN
	Oa5x4dndJaUuUwq9RuY4sKPezlcvi0HLoj8sEepcU2z6D1J1zobN2Mdb5TgqpgPtSPlD6KID1VV
	rmfHH+w==
X-Google-Smtp-Source: AGHT+IEZkwSUL2OHRLRPak5y7ADnxAbFSYdsmOIZcHrSCCNpbNhv66RerRTNz5VfhHWZmuNmvGLbT6SRYfY=
X-Received: from pjl3.prod.google.com ([2002:a17:90b:2f83:b0:330:72b8:fcc0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498e:b0:32e:2059:ee5a
 with SMTP id 98e67ed59e1d1-33097fce1b2mr65859a91.8.1758214340696; Thu, 18 Sep
 2025 09:52:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:52:19 -0700
In-Reply-To: <20250918120658-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org> <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com> <20250918120658-mutt-send-email-mst@kernel.org>
Message-ID: <aMw4wx5ENt-odhYS@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> > On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > > So how about switching to this approach then?
> > > > Instead of piling up fixes like we seem to do now ...
> > 
> > I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> > I think there are three options for 6.17, in order of "least like to break
> > something":
> > 
> >  1. Sebastian's get_task_struct() fix
> 
> 
> I am just a bit apprehensive that we don't create a situation
> where we leak the task struct somehow, given the limited
> testing time. Can you help me get convinced that risk is 0?

I doubt it, I share same similar concerns about lack of testing.  So I guess
thinking about this again, #2 is probably safer since it'd only impact KVM?

> >  2. This series, without the KILLED sanity check in __vhost_task_wake()
> >  3. This series, with my fixup (with which syzbot was happy)
