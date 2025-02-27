Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8722F177
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651736; cv=none; b=FRVrRx3Wm0hf8uJ6+H6csJbzZIKwIVPlY0QW8EmdxVDkY5K4wIgui7y3QATZ2TKpiKcOqlp0U3w13XpLjQUMuxG5cxZvvCFfg+R8tLMWHQZBim4C964Xp1R3cmhNusMD1Z3JADVYHmy756+lYJRUB/924ZApX0d3O+Z3jQrLyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651736; c=relaxed/simple;
	bh=T9BHAcLO2Fi8F/is/hh9AfEDFJvEd2NLh8ELZM2jcp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7cPpPFCnOR8UCn9QasK17r9R7kmS0yf6/C80o38IiFJUFDKgfauQqtG36n7bT9zFJlBrC69HyGx7Fn3Q9tzsClzKocEZUBBl8t8jOQMP6oyABLHAvJ7KA4FEd51+UEZtBVjF3Gxc9CwUpR7VQOJqysY5+aEu6zFkiYgGRJoVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDX1htN1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDX1htN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740651734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlN7ERFRgkJUG+zgZJ963Qv4eKnSMi6hs0/GkrW6sYs=;
	b=XDX1htN1522u9PF7oyQqBZZohXGLKXlXpI1SpDHAToT7Z15ybPFLhRhiLoE0S+cNsM+i74
	/pUTRv7QHYPbUlmA9DwDeA2N699Z392zapIMXogcpUHdxmYXYn2vwdzGhSpL3bkfcsp80A
	InIndWPAIXuM3v2Ty6Oyb2iWc+Eeugc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Rq6rMTmgP7avHmp9DjUoRg-1; Thu, 27 Feb 2025 05:22:12 -0500
X-MC-Unique: Rq6rMTmgP7avHmp9DjUoRg-1
X-Mimecast-MFC-AGG-ID: Rq6rMTmgP7avHmp9DjUoRg_1740651731
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5df498f31ccso758201a12.1
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651731; x=1741256531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlN7ERFRgkJUG+zgZJ963Qv4eKnSMi6hs0/GkrW6sYs=;
        b=RuBKzx21fKKE/PncjgBBW3y2jY2S+ZlOE/d2DTZ3sZ5Qicddch9JlUi0rEw/yh2KEx
         s/gPHCZqJiCHOBXegjxXoYz5RMX0CvDPBckrhl0uMdw65Nt2T1LXysSWy+swkPHj3bkO
         zrkt1YJX5Td4qikK/IE+Tr90diYuodjxwV0QVeC2LQuh9/3ep2GiDvEsgN+/oOHuh48Q
         FgTMsz4akcDWltvWDG2ugHaCru55Ig95puvxZvI8SYptof9Qu7ZwngfmeewR04S2pRSR
         jC+WGE2JL1YzhDrd7Yy2pwdevZFFnbVyJqt2zbt34yNHEIzoKH45N/LywhWRMW4spKix
         YmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3DqAyzQ6PJPP5G+pb70n1d3B+Ac7556KhLom3Wqh4K/SgWy7ebwYkzAOVQco8kqHMgm/EARP2lfnE9rxk3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQvBCMGs5CZ4sylSS/Z5zSX8DuCa8Js0fb4PR2I+bmWw+jEo1c
	DCTZiOSblv9+nWl2oz7oEnVPYuf+xz6pdeyJe9DlP12U5oSI8vjPgPgD3REEAHb2fNBN6Lb3tdl
	y5aitLNqmWqSMzGyUZEefgj2kWy1MWgZueI8tpIH/tWsKAtcdxRyH4AL2G3goQADyc601oU542B
	QJbWbxbId4X/pRcGgHX267MZxU12tE+eQzhbgZIDw=
X-Gm-Gg: ASbGncu8uSqvjEetPsGmLv5nJ4zh903+Ysw0sSaqnQBURejOocjig2RQZw4tRkjntoN
	V6Nw9k4DT9qSPReHUhybHTk3Qp2x14PaheceGJ+GRXqC5DHnw+TrraofLZ+dItHIBkZca6XJo9w
	==
X-Received: by 2002:a05:6402:238f:b0:5e4:9348:72c3 with SMTP id 4fb4d7f45d1cf-5e493487986mr7779704a12.10.1740651730970;
        Thu, 27 Feb 2025 02:22:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3pM8WlV3oQBfytyyeOaQOimRV0KwS4EKHWJ5i0zUzAv1yCmDn5hX3VcUGzB4vcvxPmQuMR1bS9CT94wGST18=
X-Received: by 2002:a05:6402:238f:b0:5e4:9348:72c3 with SMTP id
 4fb4d7f45d1cf-5e493487986mr7779686a12.10.1740651730586; Thu, 27 Feb 2025
 02:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250226213844.3826821-1-kbusch@meta.com>
In-Reply-To: <20250226213844.3826821-1-kbusch@meta.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 27 Feb 2025 18:21:34 +0800
X-Gm-Features: AQ5f1JpeYWXlUn8jsieYhOpf1esALXljPtGnrofbGi8hLpfdoH4ms9lz0ZIIMxk
Message-ID: <CAPpAL=yffyhUrdEJHtAw4BDpV-=Z5mZq0r1ZFcoj1v1OBLnp_g@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] kvm/x86: vhost task creation failure handling
To: Keith Busch <kbusch@meta.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jMG3umsGhlSMDhCuzqvQk03nG1_FJ3rakgonH4JOcDo_1740651731
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Keith

There are some error messages from qemu output when I tested this
series of patches with the virtio-net regression test. It can
reproduced by boot up a guest with vhost device after applied your
patches.
Error messages:
Qemu output:
qemu-kvm: -netdev {"id": "idoejzv8", "type": "tap", "vhost": true,
"vhostfd": "16", "fd": "10"}: vhost_set_owner failed: Cannot allocate
memory
qemu-kvm: -netdev {"id": "idoejzv8", "type": "tap", "vhost": true,
"vhostfd": "16", "fd": "10"}: vhost-net requested but could not be
initialized

My tests based on this commit:
# git log -1
commit dd83757f6e686a2188997cb58b5975f744bb7786 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 102c16a1f9a9 eb54d2695b57
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Feb 26 16:55:30 2025 -0800

    Merge tag 'bcachefs-2025-02-26' of git://evilpiepirate.org/bcachefs

Thanks
Lei



On Thu, Feb 27, 2025 at 5:40=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> The suggestion from Sean appears to be successful, so sending out a new
> version for consideration.
>
> Background:
>
> The crosvm VMM might send signals to its threads that have entered
> KVM_RUN. The signal specifically is SIGRTRMIN from here:
>
>   https://github.com/google/crosvm/blob/main/src/crosvm/sys/linux/vcpu.rs=
#L651
>
> If this happens to occur when the huge page recovery is trying to create
> its vhost task, that will fail with ERESTARTNOINTR. Once this happens,
> all KVM_RUN calls will fail with ENOMEM despite memory not being the
> problem.
>
> This series propogates the error up so we can distinguish that from the
> current defaulting to ENOMEM and replaces the call_once since we need to
> be able to call it repeatedly due to this condition.
>
> Changes from the v1 (prefixed as an "RFC", really) patch:
>
>   Instead of using a VM-wide mutex, update the call_once pattern to
>   complete only if what it calls is successful (from Sean).
>
> Keith Busch (1):
>   vhost: return task creation error instead of NULL
>
> Sean Christopherson (1):
>   kvm: retry nx_huge_page_recovery_thread creation
>
>  arch/x86/kvm/mmu/mmu.c    | 12 +++++-------
>  drivers/vhost/vhost.c     |  2 +-
>  include/linux/call_once.h | 16 +++++++++++-----
>  kernel/vhost_task.c       |  4 ++--
>  4 files changed, 19 insertions(+), 15 deletions(-)
>
> --
> 2.43.5
>
>

