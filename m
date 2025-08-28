Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D863A1DB
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347587; cv=none; b=T058FN/MJv5IvayIXQipnmdTP250CtChZD+Vq/OROj4fJaggs93o4Or7r39eORdSI7W9+jJ+kl5Y2pgmmcg4mOSbxJXGxHKpc7vrWnNKNU3vT7slN5/YOXHT/iUlgxaTdbPxEMinBglqTiattVJRsHTLrLgfdaCHZswdiUkB0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347587; c=relaxed/simple;
	bh=hvnRnQeBlWogViGHqrd2JOdKSR/3mg9vBmKlLw/Pvz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnRU6d615Zq68Gmdl9oDD58eM+Uw2T0FjuaL7aRPe3UPEejic5mFO5g1xuliMjylYEKTXHfjfK+nhCxjsqokWaGrz/Nbmfb+GBYKEHnYeJWXCIfaTfYafxyu+h1rtcSYvMbz+ZYMlb6ZyT6s5VEQiUhwpByWzo7RnNOHEK0B9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUo4cdnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUo4cdnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756347585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuWJUdUgE10jBMdt4FfzRaIc9EOrRfX0+GmPYVYhe+4=;
	b=fUo4cdnDD4bQHIgvyADfwS5jTzr4vlzgzgTu2mnDIZaKIl3xzaQokh02DvV+3zP+0oNPNN
	HBH7ykCrPnO/LWLaa90m/+IWAOg1fkoeS45p1XrAqdF0EWVw/x7rRHhdNTos/5+Sh328Zm
	HyKDUtX4yebonoYZnWUApUUNilaBdzE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-LdF4HN9QN0G_F0cQqlwFqw-1; Wed, 27 Aug 2025 22:19:43 -0400
X-MC-Unique: LdF4HN9QN0G_F0cQqlwFqw-1
X-Mimecast-MFC-AGG-ID: LdF4HN9QN0G_F0cQqlwFqw_1756347582
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb7348249so93908166b.0
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 19:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347582; x=1756952382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuWJUdUgE10jBMdt4FfzRaIc9EOrRfX0+GmPYVYhe+4=;
        b=PBuap4rrhaAj0nMekBKoZ+gH89peYBRoiAi+9j4rTw85Fr89X6Xiz+O0hChY1cF9tI
         KHAkOgn9zpK5YCNB2HV2Mbfyokf/wpqjGTyCXUKoOb88fvmf56kJ45BB32osaf3MaBAu
         CFyldO8p7rCU658hPgi51cxINV72lkJlYl//7gqVogey3Y4DazRLQUBmA+1Qtu+SLO0N
         y24SP9bMe+2eMM3XbTGn+r45Sq+0fIUWDnAo0FNX8rJBpiZITJOxVVKzpH/fJse3jN/J
         pZUVKuBzC8i1INNzUtjcxiarUaT51ilbrMTOTyEgmPkar4LOmD08UrGvsJTUM2YILCLC
         7Rcg==
X-Forwarded-Encrypted: i=1; AJvYcCWbTEvEgmySsI1rIX113a3yauKyqu8xMPTggEMSbWsnh7SvC5xO0BMzl+RpEGJLo6fqZX3pgeXuP7tOQKFgBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymQocbgjUlZF8lgPOT9+azOYp6xQqSdeuyj6gsgchFWyu6WtE9
	wgS1H/MSfueKYoVfHPNmkSv6gCSc3pT2Flyt/RapVQpvAXI3PAN5PpEZUtb7lqxFWUZtuEbrOrq
	XlCuWyZGDleNpVSnDprc2rOOrgVVHqwKXVWyxRaYv/bxLgSWdrcGFty+22l8txcatJx4r4K4WqN
	+CnV1kRF2oKbCe2t59cVAvKw5N1tXI7OlDj+KF39b0Zp0=
X-Gm-Gg: ASbGnctAF+7eARZmsQe6OHYb1TKPLH3t21CumFRh4YQahkRR3Px9EyYcn40/ABX70ni
	nClPvDDyAJufohBV2k8GDvMzqcAVFTuKiiFkQn7LS3oMSAZykWwm73mRtnNFG37kJ76s0DbU3vL
	UBq20Pl34jjJD3gU35rEwWnA==
X-Received: by 2002:a17:907:3e0c:b0:afe:c803:a0cf with SMTP id a640c23a62f3a-afec803db44mr338070566b.50.1756347582058;
        Wed, 27 Aug 2025 19:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEywnZxZXd+LrwXaJupMXn8D4KG8fZV7ZXo9Nhl8+J+/NoGVlVy9jGmEHSZX26lkU7wovhDS1MB/Wlat2HYVJY=
X-Received: by 2002:a17:907:3e0c:b0:afe:c803:a0cf with SMTP id
 a640c23a62f3a-afec803db44mr338068966b.50.1756347581664; Wed, 27 Aug 2025
 19:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com>
In-Reply-To: <20250826004012.3835150-1-seanjc@google.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 28 Aug 2025 10:19:03 +0800
X-Gm-Features: Ac12FXx3ye1m5pDHDoHQMdklVzQePg1kNlD8XHk5EhKfbtJVcOqPjtReEt75Bpc
Message-ID: <CAPpAL=wp61suVw-VdqpT-Kxxztaokg_-DkjsVEHDTg7rxzsnbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost_task: KVM: Fix a race where KVM wakes an exited task
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u4G9cqNZsjejKW9eIJ0pJYyT9P8okGaXNDhskTE69Yk_1756347582
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with vhost-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Aug 26, 2025 at 8:40=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a bug where KVM attempts to wake a vhost task that has already exited=
 in
> response to a fatal signal, and tack on a few cleanups to harden against
> introducing similar bugs in the future.
>
> Somehow, this only started causing problems when commit 56180dd20c19 ("fu=
tex:
> Use RCU-based per-CPU reference counting instead of rcuref_t") landed.  I=
 have
> no idea why the futex changes exposed the bug, and I don't care all that =
much,
> as this is firmly a KVM bug.
>
> Sean Christopherson (3):
>   vhost_task: KVM: Don't wake KVM x86's recovery thread if vhost task
>     was killed
>   vhost_task: Allow caller to omit handle_sigkill() callback
>   KVM: x86/mmu: Don't register a sigkill callback for NX hugepage
>     recovery tasks
>
>  arch/x86/kvm/mmu/mmu.c           |  9 ++----
>  include/linux/sched/vhost_task.h |  1 +
>  kernel/vhost_task.c              | 52 +++++++++++++++++++++++++++++---
>  3 files changed, 51 insertions(+), 11 deletions(-)
>
>
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> --
> 2.51.0.261.g7ce5a0a67e-goog
>
>

