Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C41C0DC5
	for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831581; cv=none; b=qgsdBaWKzT/AuT7KXhr3fB0vHGx/dbiFKbS7CsqJMQHN3WPXK3xsxEqsRRKGhdF9l55MYBiIvYC3eoIm19FK5BOSoDx/EGz9bmjG7zbi/4YAHt+CENl9EHRBnEUZfDjJgRr8fUpj4lktwxwIl23J3NkGcJFbjJ6S/BtAxehD3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831581; c=relaxed/simple;
	bh=BAkGv4BTL2i9YIh3NwpQqsz/OZhP2ZV84NiG/9N+zJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VXAzDTOC90XhwigQGas92ha3cTdZVrREvoJmdPbWNGryBvg0btLPhG+zvzkeEkS++AYEEP7fidlm/nZFGOG3ArsSjWpH5kqilbKXAjLUNFP6P851KVdjvq+6+ewygSe9OxsMYzbCRGQZiDSFICpQREjwtLDr0ObYBQn7u11EynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uoacz83a; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uoacz83a"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e117634c516so3044153276.0
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723831579; x=1724436379; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQMMCc0Ov2Snf2l0Tj49um7esv/76zOwTy43mPOxM=;
        b=Uoacz83ae7W5BPZ1dK1oD/YX2YTdyUPljVlWa9W2IoDWEdVr+KfobPz3A14Sw8z2Y6
         H4GvJVdmkK5vryTCTSZabbArA8NeEEX2HPVTIVMPVO0UVr4wKhAe5MPkTBxNcdl3+Nlu
         fURPRVHm2pNc00eX/lFhRmOy7fibYGKZikBKwR1zNWS5cS8lHcTwcgXWYZkTRXuQYNhL
         HDD37UYd4bcVnFfyAzeeSZx/HTcpQU/p7kE0/EW4ZQY1dSyAMy/MHbJxFVQcKpwHPQTR
         /QKrCpwYTIQwBSkeGsPCm768q/PqMtMHukHSQks9e2CchSxFwDLm5Fc7tF7E5DAGPrd1
         p+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831579; x=1724436379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpaQMMCc0Ov2Snf2l0Tj49um7esv/76zOwTy43mPOxM=;
        b=vUvqEwtfCiAUllPGI0VcYU7Ccuh0JfVuftiWUGHhn1GttIZihQaT+VTO3++2XV5o9r
         OdArY0JzlmgdYu3EgBWQd2d7ML6P2iap+cv6r8jui/0Roi/1eoDddcfETW7mYU/5xCnk
         wdV/qfjoy1RWPSx8r0luMXXD8smXHmZuwWV7H4dEPRqlvDfX495R9AIGNxWVQuz0HEN6
         ctlN56WKNrbQqhl4ms6dTPG6i8gXSKxZIOdZpgSNZIHlcfmQC6ZqS54y7J3M7cF1EATk
         Oj76YUp7wFN+jJt0LbfyG2yNcQx1qun9PrJD9+4/Xm/vW4eaNGDp+Zfakzr19Sn0WwCF
         WmlA==
X-Forwarded-Encrypted: i=1; AJvYcCWAeGVVK5Pug1g84zzLul+ec0JZHVTRoRgLXEZEiN3mWgVxsDYepj78E8Ojf+eFoJ8IQ7izIqa1ujNQox3crun9RoWPfS06aVEU5PHRNSQ=
X-Gm-Message-State: AOJu0Yw4N2y2DfEDf4BZOHTSHlR5kHG7nP/yN3LS2MARwSfJZoswwT2b
	iPR8C8LWOYdqaQscv4FOdYuFyWMe/uGb9jrllc7Z6mU8K5pA/GngsEkZWLXxoQqvMkJqttwkELp
	3OA==
X-Google-Smtp-Source: AGHT+IEdNFeoKk4+WTl7rW1Wn4ZVfgiEMGusR3d/zsIkeQp8Z52WLAOPOy/a12Umw36tOHJ8DGZr9uL/nNE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ef4b:0:b0:e11:5a4a:b1a2 with SMTP id
 3f1490d57ef6-e1180e9eb93mr6271276.5.1723831579081; Fri, 16 Aug 2024 11:06:19
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:06:17 -0700
In-Reply-To: <00000000000074ff7b06199efd7b@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <00000000000074ff7b06199efd7b@google.com>
Message-ID: <Zr-VGSRrn0PDafoF@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 29, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com

#syz unset kvm
