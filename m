Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CC2F3C12
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045545; cv=none; b=LZCwoHVOTXCtIW6woNkRsnB/PeM1583LSVrBM8pWaZwXPtNZogj9Zg04h06bP97CcEvBSaJsHaGu+Gc5VJxshHY1J7pGp31nr2nYsxtKXikcnEX6UdrHYNbINHn7LJ6F+bWpLr9z3Pe2sH5UfAUwCps9DogtmxYM9JmD/NjsygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045545; c=relaxed/simple;
	bh=wMfqNgwnFuW6kaOfH5o5fhpzsdLETYMsMm8MQ+qtlac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j0gF0ZNhA1g1jQUX37OfGSW7lS179NEO5wjCMXT6bnJg7uIzes6ynVLJK74V+QXInOjBqGa8CXr2DAkhQsboozL5h68PUBI1oaTt2P/73sPoA1YjZv16Xx068cUX/9caxBbkXbfCwtI45K26nuvCWiFhE+owl8YdxzlM8oBeuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db6d358bso87358545ab.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 04:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045542; x=1761650342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNdyPlI5JNwn11Fal6tTcpVingDDGvbnySJfVkaupSQ=;
        b=qIeBA3kY9Sr4RLNCuxsjp+IbWHfEwqV75MsA21lnPR+SQ7NV5KAal0d7wa9sNmN8f0
         jadz1Gr9tjmJNH31/AQF8eZMOjYFbKadk0TtRUvqQYIm35HQsK7oA3J5mIZezyRq0PHk
         Kcxs9dX2qH+v+24W27zt7o/jnoh9dTZ35S93gG+lG15FYEWkV50t6fI8eFOTUCJGLKDG
         CqTr6SNdyy7h/0KmRXL4C9WXkjhVt2bfQvTL8gQIKtW6EDVURQP14AB1Xoky1rdeBzZC
         jFyYj652XnQDqQJSxEzLYMynUrOH5NphRUDycvFYE5E1wvvuOiV/EEwxLX3KLDFPwEvJ
         sEvw==
X-Forwarded-Encrypted: i=1; AJvYcCUSd4ccn37b+4Cxy/XU821pUJYnXYDsFPvk8amcFyagxTBds20r1h01WTSYtogC51p/z58ASOU6cN/KdUyc0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgQEUjYQJNMWio2O/SxTkDIcjteBntvAB09VeagSlgYMqNOvfy
	Mw/I/WYmP/fzh6dlej4e7888iTr78155V2zbFMBPRn8WUfCD7RvJw3lZngXuJ+6wvVFjkVUflya
	XqHa3fZjslZ5UkPFQytZQc942D2+fUgEKO4sjUls/73kSMqaEFeI15Buhh2A=
X-Google-Smtp-Source: AGHT+IEcIo1pO4xDhDquoKwxmVbPrU03oJXllEdu6f5jSLQeJz66ctdLZISCA/3D47hgXamRzMXq0eAzq6GenTwToWEorDdtJPHH
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:430:bf89:f7f7 with SMTP id
 e9e14a558f8ab-430c524fb13mr270754915ab.13.1761045542520; Tue, 21 Oct 2025
 04:19:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:19:02 -0700
In-Reply-To: <jms5wjabuhoohobldv4zzfa6gurpnbw5xb5ejeha7md4z7atpj@r5b7mk5mn4n3>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f76c26.050a0220.346f24.0014.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
Tested-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com

Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1534c3cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a90d2f980000

Note: testing is done by a robot and is best-effort only.
