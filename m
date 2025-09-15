Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1602C0F61
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974968; cv=none; b=KvGmR/oComFZ50r81b86Z/rAPyGLFg7dsKNgxgU8bqlTzXoVLEKGDwc9onCFMCFOl04qwErppnRvqCWA1oVJmaS+GhV6cf6qLass0AeawOnaL/B+riGG6L8i6bFJZGJvbvN+ubTNT6Mw1cMRpq6ZShPzd/QjpcSLfnWErqd2nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974968; c=relaxed/simple;
	bh=2JPORVW6LXTWz1WFLkUTMz20Mfpc+OepdHOpLzAybU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9si9cRP53U+PfdU24I0kCV47cUjQv8/F+lE5di67n3SdYzYvcYXLSzUoLUaOH8/V8mvqpqdsV3nyEZn6JW0dI66Gd9QIxq4hmJ8O2ahPZP96oiR8rWngWH9Fz0pRyZ6MCll98m3834YIKLEvCuuHSHGBXI91eC14t2cwbhxubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GosSahpN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GosSahpN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54b7cb9d30so3958956a12.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757974966; x=1758579766; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=54TM45a+t9JSioXK38Ar3BKPrMiJwoyxvjFtErXC3S8=;
        b=GosSahpNhlqT1vkov+evzHoNz8TTyYHc48QgnzzPMiiKB93yF6Qvui1vA+615Ii6fE
         u82Bx4/40DMqV3xku8CDazb5EmvpCcFEU4EdRF3pTC+3m4EEc/iMCXqB258DWmFJ8NPM
         fLIDWEOXiEeaknVpoY4cyo8xZjOfKr8//9ZF4+rvQvFaxv7AqxJm/1+fe+BGm1eF3I3i
         mhbdF+clIhX7fqLcWlpk7V7OpaD9mPk8U4lcElzFLNnE9KInc2yIvnVje4NtL+l3KDka
         0VeWBn/fvOkw0prhkUQdinIS7KpGEYwv2yZ6Yr1lI+90hQmdIkcc0BVv1TgzeX2iAv4a
         e2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974966; x=1758579766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54TM45a+t9JSioXK38Ar3BKPrMiJwoyxvjFtErXC3S8=;
        b=WGYltzMa2HZOz/z0lB8mSLXHj4TdvzYXhphzsYg1Cw/uSN5oarLT8Kj5ilrmMwIM6d
         4/qIluTeEXmEHkdOC0aB2085aXala2iCC1ONX+4MIc/RBZDgkHJ2azd3geM2M6rTbHgP
         Ui2kls7mTKfOaCYta5cHfK4MM2AzVAVNNliuon/ejx/geN/mMNERyUo1gsTagSXMY1qZ
         GoWixaYgC/dYa5pA3LUPhnatkEa/DcR7aOpSN4FNI9dY2X9aDBGWMmo/Yk5B+/AvOvsg
         LJ3uUczZVW5zqTDN3aDltaW1v/0pNZyLkYYZqltQLINXMQbQ1+sKrYoV2FJPNU1hKTPO
         s8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXpr6JEwFGcf7PV34XJ4tgXvx0HZX8mpV6bNyaBIEWIm7mJQlOBcXDob4XCRXSRtHBpX8UxjTZa3pphsXB3EA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdEGiIDbgUXMAUne3ZS3ji7cXmVjmzr6/WnvtitTReG6WDrdXP
	7pTj23H41cGB2zVFyW5ycYaAJ+5CjdhjzsRdNjE6JNkBGWOfK+eDSKSUkiEr1UAIRoFBG0F/mnz
	yI6eWTw==
X-Google-Smtp-Source: AGHT+IG4lyuAi+DdqkibJVbiXoSmhtBXMMowLBOZ3P1nBnHHcYoImlRydjxdcA5I2ROW09yHYzJ1IKE8fZ0=
X-Received: from pjay9.prod.google.com ([2002:a17:90a:1549:b0:32e:a3c3:df27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528d:b0:32e:358d:6678
 with SMTP id 98e67ed59e1d1-32e358d6fb4mr7344770a91.4.1757974966082; Mon, 15
 Sep 2025 15:22:46 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:22:44 +0000
In-Reply-To: <20250915182018-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <aMh_BCLJqVKe-w7-@google.com>
 <20250915182018-mutt-send-email-mst@kernel.org>
Message-ID: <aMiRtGJbx9ZHWDbW@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 15, 2025, Michael S. Tsirkin wrote:
> On Mon, Sep 15, 2025 at 02:03:00PM -0700, Sean Christopherson wrote:
> > On Wed, Aug 27, 2025, Sean Christopherson wrote:
> > > Michael,
> > > 
> > > Do you want to take this through the vhost tree?  It technically fixes a KVM
> > > bug, but this obviously touches far more vhost code than KVM code, and the
> > > patch that needs to go into 6.17 doesn't touch KVM at all.
> > 
> > Can this be squeezed into 6.17?  I know it's very late in the cycle, and that the
> > KVM bug is pre-existing, but the increased impact of the bug is new in 6.17 and I
> > don't want 6.17 to release without a fix.
> 
> To clarify you just mean 1/3, yes?

Correct, 2 and 3 aren't urgent.
