Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DC15AF6
	for <virtualization@lists.linux.dev>; Mon,  2 Jun 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890491; cv=none; b=eMMUzsUR2pmb2Xury6h4dSmCzu+8oUv54o6tRymoWjLIqgFpJANpjnuM4Ylf3vu4HTlAZ+uuPG6L6YqnTdRECdLuTGRYpwWNeUacIJOt1AfTgidzyAJk9WE9u1XbbJJozQQyx2h0Ecpl/LJTSdAPmiSJJl3ET/ICNM55PL/o7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890491; c=relaxed/simple;
	bh=ADW9xya+1oa2cmviacIcm+dB4kYEr+YRKtM/wxWuyc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Adoa16XkFco5xAcjksfEFEjATnXh+J9148RKylpeDfokeZSwPeT7AUJcuyaRmXGW5cInPaNbI6S/BkknlZuF09NWkWUm0UKW7vWMBTxlEgcD37IPM4U/1piFkeWX6U6biFqONaBcHZA6uEJYuGClHHe+t0yKBl8dppaNmKz5IHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVULdCes; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVULdCes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748890487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C/P1ic66cDx0vo/JBziwVz7kRWsMBGoIIf4HEtYsGQ=;
	b=XVULdCesiDBOHgkMpNnXAJTBQlmj67y+PwfAapVb4Hqb9s7FLcyQyBYHYG/EgTe2XGmUo7
	jj+aNFBTfzORiT6KO6Inacia4KS+k91IE/ae6llLVVuwq+1brw3vPPbG/cuO3K5kdT/Mt1
	k8yjlWeSRm1IAKZXyzsUVtT7UY5fnxE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Pn8mn67BNyq8gCLP1OxQLQ-1; Mon, 02 Jun 2025 14:54:46 -0400
X-MC-Unique: Pn8mn67BNyq8gCLP1OxQLQ-1
X-Mimecast-MFC-AGG-ID: Pn8mn67BNyq8gCLP1OxQLQ_1748890485
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8726bf54568so6660939f.3
        for <virtualization@lists.linux.dev>; Mon, 02 Jun 2025 11:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890485; x=1749495285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C/P1ic66cDx0vo/JBziwVz7kRWsMBGoIIf4HEtYsGQ=;
        b=NrfKOrBY/aJoa8VUtErk7OkiV+AfPmaZkbXJuvflWc+eJhqLSGqliteM6T1xGun2Vo
         7I2Dj6Srb8bDXf8zkoXaZ3LGvwsqDPKl/piCIUQyjGDJ0sFiV0G7s8P6C+xweTS5Na8U
         cYZetMbYeKq13E/JM4ZuxR2cXWGnXpQByDNfPIvL6PXAvZwWEC+IRDbLpqYQiieKnhat
         FT843yGjOUEQckW0E1fi64s/6bU6E3C7QToLEGtlUjkoMDJ60Y8zZP8UZHcwD+EDDlY7
         1mkvmMFUhMaopUqagViXRrBYRO8D0JPFTRC5FGhBoDx+JuL4OCiloiP1lpthf9k1ry0A
         K2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV06ZROkfjd/P8a3Xpp3H76Ef+nGG1dAsjk/IM9sQQFcNEDHYOW71d27zSgPEFSuPbF2wsKnOvzpB10ue8r7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZhtPZ69PRnGhNx6JKml//eS4jnCp7EBRuClzX20MhyHwPz9TH
	qU0MFrxvCwtQnYrJz+nDpqJcyAmrkiTapVrQdTDSkVSXvX8mZElDGNs1une66N/9Tv2viLXUUHy
	qK1mXHYk3TWD31bPS8BxEMPaOP1wjVKzmlFOC8giUcySgSoyImS8wlZEAo4gnb8vO85xK
X-Gm-Gg: ASbGncs7f9o85V14sV944Jekza5LhDYlWp9y1PI523+nfIxf3jYplgE8XzzpEOLYGuD
	1sRkHbs4sftk9+/6I508eZ9fEA5GKUKGOCn5QJm3dvwmCW2R+k0oGSivwqRwJ0TpqdV0rvH6RlM
	iOWONAEUr36eckG6hM6cRczRClxQOQNJH2Fivu0yiYhp27h33JJ1j3Ls+tGUPX80Dg+stHuBFJX
	Leesafhe+r0+/ngw7IhFueNu0wwp9UO20aZ3Ps0pNuWgBk3eEx30JJJ0HbKg/5JnJ9jX5Lc7QcK
	elfXN2trsiYQq5k=
X-Received: by 2002:a05:6e02:258a:b0:3dd:869e:d1d9 with SMTP id e9e14a558f8ab-3dd9bb04986mr43707835ab.4.1748890485366;
        Mon, 02 Jun 2025 11:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDB2BJKvNT8wrVq77BTo5j1RKq7jCh6zygyLgk4tNvo1VWUIo2Syvkw5u3DYlSjqc4/evPNg==
X-Received: by 2002:a05:6e02:258a:b0:3dd:869e:d1d9 with SMTP id e9e14a558f8ab-3dd9bb04986mr43707735ab.4.1748890484945;
        Mon, 02 Jun 2025 11:54:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd93534293sm23059685ab.13.2025.06.02.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:54:44 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:54:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, Oliver
 Upton <oliver.upton@linux.dev>, David Matlack <dmatlack@google.com>, Like
 Xu <like.xu.linux@gmail.com>, Binbin Wu <binbin.wu@linux.intel.com>, Yong
 He <alexyonghe@tencent.com>
Subject: Re: [PATCH v2 0/8] irqbypass: Cleanups and a perf improvement
Message-ID: <20250602125442.19d41098.alex.williamson@redhat.com>
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Mb1p64FLG1Glzqd3W-w3cNWXZ6ODIHZHtE5bcYdmUY_1748890485
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 16:07:26 -0700
Sean Christopherson <seanjc@google.com> wrote:

> The two primary goals of this series are to make the irqbypass concept
> easier to understand, and to address the terrible performance that can
> result from using a list to track connections.
> 
> For the first goal, track the producer/consumer "tokens" as eventfd context
> pointers instead of opaque "void *".  Supporting arbitrary token types was
> dead infrastructure when it was added 10 years ago, and nothing has changed
> since.  Taking an opaque token makes a very simple concept (device signals
> eventfd; KVM listens to eventfd) unnecessarily difficult to understand.
> 
> Burying that simple behind a layer of obfuscation also makes the overall
> code more brittle, as callers can pass in literally anything. I.e. passing
> in a token that will never be paired would go unnoticed.
> 
> For the performance issue, use an xarray.  I'm definitely not wedded to an
> xarray, but IMO it doesn't add meaningful complexity (even requires less
> code), and pretty much Just Works.  Like tried this a while back[1], but
> the implementation had undesirable behavior changes and stalled out.
> 
> Note, I want to do more aggressive cleanups of irqbypass at some point,
> e.g. not reporting an error to userspace if connect() fails is awful
> behavior for environments that want/need irqbypass to always work.  And
> KVM shold probably have a KVM_IRQFD_FLAG_NO_IRQBYPASS if a VM is never going
> to use device posted interrupts.  But those are future problems.
> 
> v2:
>  - Collect reviews. [Kevin, Michael]
>  - Track the pointer as "struct eventfd_ctx *eventfd" instead of "void *token".
>    [Alex]
>  - Fix typos and stale comments. [Kevin, Binbin]
>  - Use "trigger" instead of the null token/eventfd pointer on failure in
>    vfio_msi_set_vector_signal(). [Kevin]
>  - Drop a redundant "tmp == consumer" check from patch 3. [Kevin]
>  - Require producers to pass in the line IRQ number.
> 
> v1: https://lore.kernel.org/all/20250404211449.1443336-1-seanjc@google.com
> 
> [1] https://lore.kernel.org/all/20230801115646.33990-1-likexu@tencent.com
> [2] https://lore.kernel.org/all/20250401161804.842968-1-seanjc@google.com
> 
> Sean Christopherson (8):
>   irqbypass: Drop pointless and misleading THIS_MODULE get/put
>   irqbypass: Drop superfluous might_sleep() annotations
>   irqbypass: Take ownership of producer/consumer token tracking
>   irqbypass: Explicitly track producer and consumer bindings
>   irqbypass: Use paired consumer/producer to disconnect during
>     unregister
>   irqbypass: Use guard(mutex) in lieu of manual lock+unlock
>   irqbypass: Use xarray to track producers and consumers
>   irqbypass: Require producers to pass in Linux IRQ number during
>     registration
> 
>  arch/x86/kvm/x86.c                |   4 +-
>  drivers/vfio/pci/vfio_pci_intrs.c |  10 +-
>  drivers/vhost/vdpa.c              |  10 +-
>  include/linux/irqbypass.h         |  46 ++++----
>  virt/kvm/eventfd.c                |   7 +-
>  virt/lib/irqbypass.c              | 190 +++++++++++-------------------
>  6 files changed, 107 insertions(+), 160 deletions(-)
> 
> 
> base-commit: 7ef51a41466bc846ad794d505e2e34ff97157f7f

Sorry for the delay.  Do you intend to take this through your trees?

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

