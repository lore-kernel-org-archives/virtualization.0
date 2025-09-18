Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8178314D2C
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212075; cv=none; b=JbJRRtbo7ytYJOoRhkqnXwAB3hXdZUHIAv4irlz280f376srnjHJPkN2Zo1/tYo7Si1jcYQaMB0rGu/3L2aYLO9EXaX5QuJm5BzkjyQ4q78KGlwPCv2ARjEFL3glc9kKS6FIR4SIWa5P2vHf6X7ooBCjxVHmeMcy9fzPKSNkiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212075; c=relaxed/simple;
	bh=bmboGWdmYKGEjDqvYv1DVm9bs5qgX4S3Ny/0S2so/l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HICH5UZ4MnPZVcEzqMM9UA9Xo5cNiy7C1kQMbOggpw2BQS4KeMMYK6uy3PLPn7KXnRGU0ZHELOzxodh1eOz+WLrL9ZlOdQEBnvsPaoR3M/k/z72v2dAtAwdEDzkXWwi1v5KYc0vmi/XTjyhy/R3K23Q0n7/7/SFxWGKkBMvu/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7at0H6q; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7at0H6q"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CA9E802C5
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G66d-aFgRkWJ for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 16:14:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 87B0A802BF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87B0A802BF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7at0H6q
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 87B0A802BF
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758212071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4F3hybZYhx1Ydbv1SoblmjPS3ZmGcfGwW98Zsh1rblI=;
	b=D7at0H6q/zN/kQy7hxyKqAyuAce9M9Ee+NAM4h/3GY23FhrNs3ebddZhfk9OOraFiJF7MN
	UO8YazYsRd4fLnzH1rabFlxvuZcPoUuB/YLdtPqYwlC5GuDVBTuy906mwyb6l8tlcmJQ1x
	cCIkI4bxf4sCZFnl4AvNgddgh4CnHfg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-NeYslHR_P4aDu15gTUOzfA-1; Thu, 18 Sep 2025 12:14:28 -0400
X-MC-Unique: NeYslHR_P4aDu15gTUOzfA-1
X-Mimecast-MFC-AGG-ID: NeYslHR_P4aDu15gTUOzfA_1758212067
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb2c65e0d6so861187f8f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Sep 2025 09:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212067; x=1758816867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F3hybZYhx1Ydbv1SoblmjPS3ZmGcfGwW98Zsh1rblI=;
        b=WWkSjvw0mStxgZm6KqJ5aFX4gyNHkDNkG44GqlBJj3N8Hjs2x1jX23/QK9S554TbUI
         uavF5O7rVAEJJsizSp0dLOfRxvtWV/rXjPydhx3hYwhs12G8o2d/0nRmTiEW2yRNPFZN
         OnCAAviv2q+OzYLAJz23Z9fNdB5O9Xeb338xNwce8vfOu6j+adnkKgJaunQ8ZnfFAbfv
         wJwEsAMbQWSYC4csk3kTlfYSiMlvLja7Mz7V1b/D6/QVZPXuUWx2kHSOKaFrjtHGhN4I
         xfH0Mlc/y8obWeng5o5Tql/jtAGy8nmYqdKTQf8MiRwAPzLK5amKB9WwiKruOeg9xz0P
         THkA==
X-Forwarded-Encrypted: i=1; AJvYcCW5HT70PxaI+AkYGehzvPVYf5KvqR0LJzHKScvVNe5rD4P8IhdVCdWl/TU4ZHQuRpMLXJEJCB/fgun+YN3goA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywd74p1Fb26iSTu9xAuZaeEF7u4RXFlyUeK5R7JagTYCEQh1cV6
	x0MjZaEigufUZdQlPy8uo9I7pQ7KxY2tKbrmKBnKYTUp9xqADjI5PsO1CG7nW24PMxNws1Suit/
	7j37/zMZaB/PE08/cJQm1Yoy6Yl7+Xtia9XMlbBrZEOiaO5FEnNufRSlIPm3CUOUUhXu9YWw+ZO
	lLtRydQ3I=
X-Gm-Gg: ASbGncvpV+FVnJ7Nr8AClP6vRjWgbXvmzfnWl67eKfAW9RkDsOqEBg6VXUC7vSm3Gsj
	H3xEfiP+/tus166hZglrRwMh4MjP6neiuqZD3Bxj2rAWV2wrTGriYRX7wP83+bcqkN0xIGuCVRS
	UE/TWfoiBS62NUgkXWILkZ4AMle6N2v47Y4p6+4gACTdvbHmkTrr9941HoHySsijF/3VRNDl04G
	I+ceciyRKvaimcYWLn1IbpSxgxCkDJYhSrq0V2TwBuVFCeAwKO2HlPxGDB2Ht07TY4wHwmTCWRx
	vR9dUMjrarypDrVEZ+dcoXhJnjdBYsWqLCc=
X-Received: by 2002:a05:6000:2283:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-3ecdf9b4972mr6994280f8f.3.1758212066822;
        Thu, 18 Sep 2025 09:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWuV5SNvbO5Tb9W3Xvg5a4aZyLEyh56k2xiIjkOqz9AqDLzlVKqyG0LIYCFPiIYi4OwFCHPQ==
X-Received: by 2002:a05:6000:2283:b0:3eb:df84:62e with SMTP id ffacd0b85a97d-3ecdf9b4972mr6994243f8f.3.1758212066373;
        Thu, 18 Sep 2025 09:14:26 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm4388197f8f.37.2025.09.18.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:14:25 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, maxbr@linux.ibm.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
Message-ID: <20250918121248-mutt-send-email-mst@kernel.org>
References: <20250918110946-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250918110946-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2QKFi9fM51AUlF_rlPo4lUQRHNf4nE2cxlPjy2EZKg0_1758212067
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OK and now Filip asked me to drop this too.
I am really batting 100x.
Linus pls ignore all this.
Very sorry.

I judge rest of patches here aren't important enough for a pull,
I will want for more patches to land and get tested.
Thanks!

On Thu, Sep 18, 2025 at 11:09:49AM -0400, Michael S. Tsirkin wrote:
> changes from v1:
> drop Sean's patches as an issue was found there.
> 
> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 1cedefff4a75baba48b9e4cfba8a6832005f89fe:
> 
>   virtio_config: clarify output parameters (2025-09-18 11:05:32 -0400)
> 
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
> zhang jiao (1):
>       vhost: vringh: Modify the return value check
> 
>  drivers/char/virtio_console.c |  2 +-
>  drivers/vhost/scsi.c          |  2 +-
>  drivers/vhost/vringh.c        |  7 ++++---
>  include/linux/virtio_config.h | 11 ++++++-----
>  include/uapi/linux/vduse.h    |  2 +-
>  5 files changed, 13 insertions(+), 11 deletions(-)

