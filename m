Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB11C3314
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207817; cv=none; b=bD5fxHlIumJyoCdUoKoFfOqVsMm4IGHCaML8EH2fx1GBRcXomXpK+BuMcW2SO+0+t+3JQh25nh3Dg477+IDSVbkVlvO7q4sOaprHrdGflJstkHOtiM93WWB+3B2hbwVutZD4e9F68j0JpHa5CPZmabv7tOkEvNj0tKXegL5p5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207817; c=relaxed/simple;
	bh=EkExrjB1v+E3308pb6pdcKo1s1yc3WIbaOoY/+f5qXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ffgWX1kiss2I3hv7q0gUltulqLE8OIIWcXyohB6cusnU3T1tREQsQQR7qNH8WMOq+3A67ySbGkNR1EyXAvSwY7h3yH8aDmoT2UdMQYkoWrosz2jA+Qzl8wOvbzxrBf5razqvFdF+rKEBJBLcHz9+qYyTclS4ZZo0gXsjBmJ/5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JOLUq1p4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOLUq1p4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC0E84142A
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AG09_6mMDb9e for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 15:03:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D7B9641429
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7B9641429
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JOLUq1p4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D7B9641429
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758207805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
	b=JOLUq1p4cHteaOzoUSEwPNJgt7wYW0Hzsow15lDRy1YX1AUuyHUKhhSihc97VpKNnr9vuV
	2eL6Wio4dtO4Cu8lhVQUfqYnA531USOui3UdN9RXEDYnUMLRkApd/Dk2ocoa3aho0UTH1f
	vPblG5MiS0fyxAFGwT3PF6AoC2G5skw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-JU98OA3hNuGbGCVurX3klw-1; Thu, 18 Sep 2025 11:03:23 -0400
X-MC-Unique: JU98OA3hNuGbGCVurX3klw-1
X-Mimecast-MFC-AGG-ID: JU98OA3hNuGbGCVurX3klw_1758207802
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so6536775e9.3
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 08:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207802; x=1758812602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHuroaDALPzA9ek/TZGAIvvuwoq2PBaqEYZO83mgbI0=;
        b=DWqhIXgJz9bdQvXSaf/iznPIXn/G7FsTkQyOJnD7EfQ8CBJ9E0OVv2p0/wxW2NMly/
         2xEEFO2j+R/4PzFe79GRyWkotnhBTEKiKeXB0HeIwTAqLepJO64UUg44yuNWse2pmbvl
         eZuA+u2oFFhmMzC2U6bh/2eR/jioVFZd1X5xeWQoJmud5PQ5eZynS7cx5tTsomU17Hpl
         YNl5lnK3noICFqE+HPZAvB6Ymb4dnk9n+qeBDlOc/eAuiFq5SvI239sgHGm56vkuZR5F
         Pl8aZ7ZblyzSoS12tgZu0xDS8abuhewBb3R0K+r9AJx0rIuyNEIS/gykZKt6MFTJ9VpF
         5W9A==
X-Forwarded-Encrypted: i=1; AJvYcCWzy5z9wQbHNxwXchJ03cGsemRhOK79ceb1cfZLt1GLTZty/mlHyqDFyWZ2NRHYqEVSyELuU9q1lbujur3eMA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz0wv3XkAkc1fhWowHrgCSIwErff3H8D8oAkP/puhujtS59bmKK
	ivZwT/7LEFKfvD2HbhCYGosIYklN0wpBME4TemrGK0AamAk9N3QNJNX2f1AFGBGhVTz+XFgJYQM
	I1UV9pwPUrtBfb4F6M0ZfmaB4+xU7FIhMgs/UaUpfMQVp9cANOYVKF9bswiUdffMbmPkUnFueLu
	RL7MKbixU=
X-Gm-Gg: ASbGncuVpCAp/pQWYTuuOd/C/RfRt+iFFYsz34moZZY/j1rpT62YX6liSG1E0ULzVMb
	YaIyBVuLxZ4xwXKNh4ZmrdP2r0Hp8M/Q5JgZB8bHcvG/sSfJtxl6VKiDe92E4htDU3fdd4bsHG3
	36wCpeogoJkz5zLHlhR6nJlr9wGUj4m8xielxTh2hnwDDgzi1EiDTJRjesuzIxYBADw/M31O0m5
	LWNuYJcDomZmNWEARRjnKw8w8GqCZUBMr56JuCLMExvrFY9qQh/JzEwpa76QPaRk85jTesR//yM
	NyvX2iaRSFFkuFV+3OmViy9PeaaybsoG8/U=
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63892355e9.25.1758207802092;
        Thu, 18 Sep 2025 08:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzXMO/8xWkfvQqlitTmfPRvJ7wLVF0bHaOOs2wJAFpxqVjxaTdhQB7sp9EBt86tb48mNkwbQ==
X-Received: by 2002:a05:600c:3111:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-4620683f1e4mr63891665e9.25.1758207801215;
        Thu, 18 Sep 2025 08:03:21 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm45758515e9.24.2025.09.18.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:03:20 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:03:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918110237-mutt-send-email-mst@kernel.org>
References: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250918104144-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 95OB7IkLJPAVtjNSGrrGOYJRGTr8MVDp_SRH4ErHrOk_1758207802
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 10:41:44AM -0400, Michael S. Tsirkin wrote:
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:
> 
>   virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)


Sorry, pls ignore, Sean Christopherson requested I drop his patches.
Will send v2 without.

> ----------------------------------------------------------------
> virtio,vhost: last minute fixes
> 
> More small fixes. Most notably this reverts a virtio console
> change since we made it without considering compatibility
> sufficiently.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       vhost-scsi: fix argument order in tport allocation error message
> 
> Alyssa Ross (1):
>       virtio_config: clarify output parameters
> 
> Ashwini Sahu (1):
>       uapi: vduse: fix typo in comment
> 
> Michael S. Tsirkin (1):
>       Revert "virtio_console: fix order of fields cols and rows"
> 
> Sean Christopherson (3):
>       vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
>       vhost_task: Allow caller to omit handle_sigkill() callback
>       KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks
> 
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  arch/x86/kvm/mmu/mmu.c           |  7 +-----
>  drivers/char/virtio_console.c    |  2 +-
>  drivers/vhost/scsi.c             |  2 +-
>  drivers/vhost/vhost.c            |  2 +-
>  drivers/vhost/vringh.c           |  7 +++---
>  include/linux/sched/vhost_task.h |  1 +
>  include/linux/virtio_config.h    | 11 ++++----
>  include/uapi/linux/vduse.h       |  2 +-
>  kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
>  9 files changed, 65 insertions(+), 23 deletions(-)

