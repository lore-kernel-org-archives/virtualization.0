Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826271E105E
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730092; cv=none; b=PFqtC6RfREssEc2JqqmQEM2QZK4FucxzosMhWb31GoT+rO4DEDnANGRWKh1zP0XJh8zHy/9tx93A42gVHjqAk75mWhv+d1X16Gl0a1uj86783SBVJk9SEN4+Xx/2TMxJ32HyQP0gGiOkGyay329QtfvO7lRQwjE/lQEVr8mSsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730092; c=relaxed/simple;
	bh=r9GSmtMicPcq5rW2NPP7VRMa9gYB5kx0AW78fr0QhO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tySBY3E/9wz+Nz1xMbGe2aJH7uT78xBk5M7KBMqM1QSbehxy2akCFX+tX4CXRhsPfVLI/BuPPryfPI2q6wip2xsJqNSR6s6Z14RvTvFdecDjDLjJbpeokyx21h2t4iv8YAtlyjCerey5qfm2NNbkq55uKvl32AXNngmz/H3tTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwqQpQdB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwqQpQdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740730089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdUTuAdjhkxdXouf9L2YfL8fvPAf9Q3Za2OJ9RnA1QY=;
	b=GwqQpQdB4AxZuofKRmSjci5r9TUXHyO7hc/7/QxKbPbmxzxKGwaTqBOOGc1rL9m9rvqMFt
	g1MDmQZbP7+71Hxl4DDYhelb4lUdsfYz79wf+o0RsFnwRf0GbYyIRXTM4Dk2zX/CYXtPDy
	4e1meH0ZtrGnUKIdZPcHBuO1FTIiG+0=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-B3vc_nBJOuSloAlT3VhGvg-1; Fri, 28 Feb 2025 03:08:05 -0500
X-MC-Unique: B3vc_nBJOuSloAlT3VhGvg-1
X-Mimecast-MFC-AGG-ID: B3vc_nBJOuSloAlT3VhGvg_1740730085
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-521b2a5ad1cso3565518e0c.0
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 00:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730085; x=1741334885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdUTuAdjhkxdXouf9L2YfL8fvPAf9Q3Za2OJ9RnA1QY=;
        b=MPulVIKwrNehAKAtJ5FuA04ghZlW/YNJ7WIxqydI2sid0djICOTKKWRze43Nt/aqB3
         RUOTewf6aJ5GhzFt7mThgNQ3tXFkaHLgvQPH/wpeMnlp1/cQbo5YBrM1sVKYbH0M9Y4B
         Ngd9EscfHH6s+/+AcGBvPnMU8fb5nh7Rx4VTvaYxCO9bC9BQiAHDGkmVWqyjFP+x38ml
         DSrpFV2ai1n/QJ0rB97f5oHHIN1jCEaCG1PvMAFYaS4jumt+po95jTBa6bnxHMz9O9Q3
         WLjon2rMpYFvclj6sifWHoV4wRt9z1DSjILQIVhGCrH4KuRRYWvI3AGh1b0GtEO9S58k
         qzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP6eBWD896Wpe/y5N/urlzXDA4lksOMGP2EuvGbLEEg04BSJAI6zDsfy3wgj+aWS2sQGie0jRA5i5UmnTBcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw6SDPItvYLmIKvAbcfVmX43VOj2RWzHJDdO7Vtfua4JO4dKBN
	h6MMPdBAPgYe9Bi+w4L4CMAnSwlNp4MoftQOHbcOa9TbmgQ2R5Qg36l93DD6/OBjk6gDi+hpTrW
	BXbtOeBG81DnkRp/JM9rr/51Vz1hm0eeCCtuPHKK1CDaD4lMmnMwINle1YBr3qdLJENHz7o/ukT
	RWYk8tlf3zv/kp4hYzP7PH6IwwMtOKJzzfEH5F71I=
X-Gm-Gg: ASbGncu75TOIlynF0Lu63biJdLLCC2cys8n9T1mmb0rIT4FSsmWRIjVSs7bD+UNaMH+
	74rf2caqohMuutwhFvMTPTnIRLLkRn9AHBXYBg1bD/QEKCtRW7txVrNypTtr1EtKf+awOxcxMug
	==
X-Received: by 2002:a05:6122:8293:b0:520:4fff:4c85 with SMTP id 71dfb90a1353d-52358fa2777mr1810212e0c.2.1740730085129;
        Fri, 28 Feb 2025 00:08:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnzJbPx76VPjBpQt7am7d8LKNakTr6F/2ZNTopcxram3/9GKreE3AEQUVie6mNxSMpVmuq6MObJy/GAXT7g5A=
X-Received: by 2002:a05:6122:8293:b0:520:4fff:4c85 with SMTP id
 71dfb90a1353d-52358fa2777mr1810203e0c.2.1740730084874; Fri, 28 Feb 2025
 00:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com>
In-Reply-To: <20250227230631.303431-1-kbusch@meta.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 16:07:24 +0800
X-Gm-Features: AQ5f1JqPk0QRBHoltnkDQ29vhpwSBSIPKORj3Gk6lgM7TDuBtJyK6aRdH4dto9I
Message-ID: <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/2]
To: Keith Busch <kbusch@meta.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org, netdev@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jg3xs9XpbGUAXRCpR7gqBzhXl3lgqjiEAeNomGYE3kM_1740730085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Keith

V3 introduced a new bug, the following error messages from qemu output
after applying this patch to boot up a guest.
Error messages:
error: kvm run failed Invalid argument
error: kvm run failed Invalid argument
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000806f4
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200error: kvm run failed Invalid argument

TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Dc5 5a 08 2d 00 00 00 00 00 00 00 00 00 00 00 00 56 54 46 00 <0f>
20 c0 a8 01 74 05 e9 2c ff ff ff e9 11 ff 90 00 00 00 00 00 00 00 00
00 00 00 00 00 00
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000806f4
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Dc5 5a 08 2d 00 00 00 00 00 00 00 00 00 00 00 00 56 54 46 00 <0f>
20 c0 a8 01 74 05 e9 2c ff ff ff e9 11 ff 90 00 00 00 00 00 00 00 00
00 00 00 00 00 00
EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D000806f4
ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D0
ES =3D0000 00000000 0000ffff 00009300
CS =3Df000 ffff0000 0000ffff 00009b00
SS =3D0000 00000000 0000ffff 00009300
DS =3D0000 00000000 0000ffff 00009300
FS =3D0000 00000000 0000ffff 00009300
GS =3D0000 00000000 0000ffff 00009300
LDT=3D0000 00000000 0000ffff 00008200
TR =3D0000 00000000 0000ffff 00008b00
GDT=3D     00000000 0000ffff
IDT=3D     00000000 0000ffff
CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
DR3=3D0000000000000000
DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
EFER=3D0000000000000000
Code=3Dc5 5a 08 2d 00 00 00 00 00 00 00 00 00 00 00 00 56 54 46 00 <0f>
20 c0 a8 01 74 05 e9 2c ff ff ff e9 11 ff 90 00 00 00 00 00 00 00 00
00 00 00 00 00 00

Thanks
Lei

On Fri, Feb 28, 2025 at 7:06=E2=80=AFAM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> changes from v2:
>
>   Fixed up the logical error in vhost on the new failure criteria
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

