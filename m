Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737388592D
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965284; cv=none; b=gxDUS678wOMZ6JivkcHwlL2rDnjoElVrWvMEiW3BS87m4yG1b50euu3JLaO1eUj5wNM/aRePSDnuGff5P/eN/Tmqr6En9HcSbnzmdqW3LZzJ3c6Yl4J1xuZOnR4V/OXpaozdeF5bh3uADsEQGaIx+DPClKYUVOx8/xd39rAV7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965284; c=relaxed/simple;
	bh=U+UVKAt/Bq8p2XJNRPjZNvXZ6YosjOH7xSAmcPxwOps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iy/l+Hty+X1zov6v6Pks3iBb/lrYh/AIZhQFhplBBUK4meVnwFQpdg5GEkXqvHjAOXPoTkZL7apHsNNrFTylaJNiybTjv0PSyo37WRJA8fOyMX3LtiDeNTw22YeYs6PHxb4b1dDktuabEfpnsArjQA+cdUm5XcJ3lm10zv/Z0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3685020a8edso2223095ab.2
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965282; x=1711570082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90ngouxeClPqd2Uy/VEUTMh551N/5NtUq2TP2nVIm+Q=;
        b=BYUwQhhyPqQfyKbWMoJ7wV7aWlCCE4ukm4D47Nkgrc79jvlJhmga6QLgErQRhbeg+0
         rXYVNrrqChD0Tf8lqLLA6syDINPPJoFAHXWg0J6yeKWhU/RrH2Om9f+Zb6hk8k3AnmzL
         qu2jqELMTQlRG5uT0GlLbO2HNqtf1ERHvqI/Kbv94QS/kouJQxGZEsR77hUJrMRm7VpR
         iU0kC8qa/Psk7dRQEm5FdJ80psHlUNJtdWFgBdnWEtZhfK/Js61jqZoovOscgnESVEbq
         w02uB/6IVPGriwY8I8splejd1U/qAeF7TaWndhUuHi278f04KtAV+Yk1b7UD51dUVLo3
         DUpA==
X-Forwarded-Encrypted: i=1; AJvYcCWHLThe5t04wZ5lsbs9ImKabYI6wsFV7d2qnupP4ruFukatTEioOw23CoLwpZmHr0Xsvuzo4dCPTsQQwMI3PiNRowHhoJqwKHKxvJ+sdVU=
X-Gm-Message-State: AOJu0YxJOvbfA051d4SuYCaOrVFW/rSfAKLDOI/7i6uGhBsTAScC5Jtd
	KCQUAddrV6bp7vWkojx0w+HZDtKyVX444nQZIbBrfzLyrVvgsZSo4z/ARkrQMkpNqsSkz68mMlj
	azWr0/8E5KdjoXF8i3PwZhx1N48U+lTc1NJpWrDppRatrTLZae6H4qsw=
X-Google-Smtp-Source: AGHT+IFRSgFMkgU5w4crMUDJ7kthxDKNL9C7Z1syq/rB6BCaRhzrzbNaiH9JCERgVxC0vDcoLAhfCgoOJW3SIHdDAfFpp7CxCPQn
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:368:5b92:cfd8 with SMTP id
 b15-20020a92c56f000000b003685b92cfd8mr67313ilj.2.1710965282612; Wed, 20 Mar
 2024 13:08:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:08:02 -0700
In-Reply-To: <20240320113002.GA1178948@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4b57b06141d250c@google.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
From: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, osalvador@suse.de, 
	pbonzini@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com

Tested on:

commit:         4bedfb31 mm,page_owner: maintain own list of stack_rec..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=527195e149aa3091
dashboard link: https://syzkaller.appspot.com/bug?extid=70f57d8a3ae84934c003
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
