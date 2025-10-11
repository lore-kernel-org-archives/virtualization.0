Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7331B4156
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174408; cv=none; b=DiTzfqiR78YjFpCp12OkmcRJY3kWWxQBtuymqF1XJ3phHxlJbMWFPTu4niT6bi5qc+Dci/1UANhspoDQnJ6jTiAFrXC8oZdftwHU+XjWy3M9r6/q7vMph+UMROeqj82B1/NE/SCj/aFimFC/R+nw7hPoijD2CGzL2McneL+4UTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174408; c=relaxed/simple;
	bh=uoR5iCl06TSuJEKybwo9hzsSRh9KKwCS+jO3rdPrtgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TDjNHI6I4P0uQWlKzuwfzZK2s1OFI1/ZIY4ju6YZK1huGVYsOj9dBkntfkdFnpe1nAL+7hD33uQnJtuNKcKwyBl5bB0dgLztnHsAYZJFJ6w3HFQC3RH5sSr4KWIGualtLIGoGyW6HMIpgtVmBR9WuBo2kzkooo8gTpHta78hVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-919d48f1869so2092299839f.0
        for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 02:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760174403; x=1760779203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjiTOOXYfrDkGuy+IGNqV7zuRFDvWxSpBbVz/rW3gRE=;
        b=Cv8nsCpowvHXqp89JT81nZl075HlqCjdLaXzlDlJQlTxMdDu9tTqaJTcvfrZzEWb/s
         cFwPSescDF2FfjvQMqU/+8tvPC7+p3Ms6vezGYHmvK5xCJsnDnltorhqKJ5nwBQ/3xjY
         HWp6gVqdqUg9bfzr05+RDqtmHgCWiSdhZqhWpF+vx1+65MedtN0TEtY+itcuxMr9l6K6
         Up9q8B59qfl1um+ltm4R31KcWY8B4ZwXtCSpgOi2vVf6mWVm+XrhvvSJhrvgwANZtNjv
         Tbx5iAte7A/HUHqv4da0CpkjS/MP5RYRcL5x+CBTJ0+Ahb1oU0prMfiQz5uO5RQbKs4s
         fHEA==
X-Forwarded-Encrypted: i=1; AJvYcCXMVyHtFRRWoDzhxzUL5wQW2AZB91hUt0BgtGwAY+FvDbTnIZme6Ti6W7zgRn6QSCn4quoWeO4dpoFuvcTiHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWKL7R2nMEiiBhcL7/iBuGHmG+XKHQONkp3Fa3ZFvdzVE+sW/y
	jC0J2168bN+cePkCATAN5u3C0cS5+/RtTXExWCv2bMvEZG3WHRxSUKIpsoCZZneZSnTqtbSzPhi
	bGMjmtBsBDxe4Ch1KGyxETn2gKLksTaJukGrZ78SqvXfFaRitjYlQehJXqzA=
X-Google-Smtp-Source: AGHT+IHIx/fEEScZKonYGrmBu/nBVlA8h1a9UNlBcPcUL2wzdKBhGjEU7W4CUUX1nYdvLnQP9G5mPRbKDsvNi+mV4kFtaIQ4J7LF
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d04:b0:93e:2f4c:97be with SMTP id
 ca18e2360f4ac-93e2f4c97d9mr644131839f.15.1760174402904; Sat, 11 Oct 2025
 02:20:02 -0700 (PDT)
Date: Sat, 11 Oct 2025 02:20:02 -0700
In-Reply-To: <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea2142.050a0220.91a22.01cb.GAE@google.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
From: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
Tested-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com

Tested on:

commit:         07394736 Merge tag 'for-6.18/hpfs-changes' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=60ff1a9f60b0f77d
dashboard link: https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a7a9e2580000

Note: testing is done by a robot and is best-effort only.
