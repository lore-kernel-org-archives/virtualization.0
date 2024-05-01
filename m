Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC665134B1
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582566; cv=none; b=D+Grsu6d6lR5D9snctQ9Oe88244l/6WVJIifepqfBpq3lVBTjIeGAu+/m+FZ6sNkF9jftBPB9QeyVR1rR2HveNXq39uD3lL3CK4fuLllSpprPa+5Vin9JjhBdEXhX93PWOR9YJKae+78ElaAFJToyGo7VompoOpZ/SkGlflRug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582566; c=relaxed/simple;
	bh=1XZHi0YzBLS47mbettJ83dDPGL16uhOqOK1tJN4dlpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+y/EA18J6u89HXxiaux52nLbh+Qr3eqPdrG+AdXu4BemL0j8ASJWmuD/+wxJySMDngqbYRCrfVabRYkGUgQQuxM5C/4BiMnV70bv6JJo3wb9T/41ezUdMQ/FKuUWzLIQJ6uvudiRluleLAgLxshMOgc1Ras5W4Oywbr2qO8VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7def44d6078so723639f.1
        for <virtualization@lists.linux.dev>; Wed, 01 May 2024 09:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582564; x=1715187364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL5zLFLZ9/A+euis3e08Nm55+lvX3+T3wPrxtwGnFpQ=;
        b=cgPr2rXO3S7p+ZBwPKsxk59r2v3m/5yBNdoybGZKSDAC/+1SCqB3/DEvacgq/QaR76
         7Hu7B68o0pQwV4qEXTxoi7SUZGeYavpCTpk1e+r5gyiwS4sytNrOBpTABEQQUNYzwtLx
         EI4p/gfpI5lpfowYtomVHTzT3CpYYF4n9/szSM/p5bfI63Vdc+9XW3ik1MHkgW6kWata
         ZLVDBRctghcuvN5Ic8/TZZYXZp7Qbr9CV6l4Vi8IuXe3bfhmM7FClz0IZW71JQ1yloKe
         N61BNShfJPY1hxQRVRaEQnPeMRLkOHEShY8t0jDA8TTg7MIvnvBQn1pvxT8ne+og9rwB
         RbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsM1rvxDuQXhNZVXakxEiajRlEgC851I6gUesPCyNtf/eaTAOQPVbrsm/rARJhGIiZANYawivCAOwJ2FhfEVK/Gz/Rb1SYVfmVmUMmDF0=
X-Gm-Message-State: AOJu0Yx99sqKKbX1Ij9IzWOWzTuoX18NWtMfmOf5m3MmBBhfwLCI/38F
	NLCR7F8RISQHRmgZR1vgYXG2pqckYN3+IDu92ZkKGT7eFwJ9nrQn2DhD4H9vyaAp5MEhDROF8XV
	InANml5o4jyR77U6ZIHJY5UiWBR7fq/ZCc0xmLWvm1T412GZTCsZlmiU=
X-Google-Smtp-Source: AGHT+IEBjXreViAye+0kXgWGM8QAOQnK+EHu2cHJMy66fdP74jLwDb6XfrE99WN2U9+ggleDVkBLcX+2gumyBDoVt+kvePoHzc8o
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8684:b0:487:5dce:65ab with SMTP id
 iv4-20020a056638868400b004875dce65abmr6872jab.0.1714582564003; Wed, 01 May
 2024 09:56:04 -0700 (PDT)
Date: Wed, 01 May 2024 09:56:03 -0700
In-Reply-To: <20240501121200-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa73d50617675ca3@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com

Tested on:

commit:         f138e94c KASAN: slab-use-after-free Read in vhost_task..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a152a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
