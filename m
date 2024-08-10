Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EB15747C
	for <virtualization@lists.linux.dev>; Sat, 10 Aug 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723291625; cv=none; b=CWH1BoO0HJyPyHYWheXuuUXp23UMVG8QW9fayW4d4Nu5db2B+g5abB6klG+rAaWFGU8FJ0jGxUW7qF0RT6ef89qpW6LcKNL+wTXk/Ib7eCULoQvzA3XJueXYdJt+qjAe+6C9ZUnVV+/n3K7GKgl45IUrAYVSSFEYiIjygnN5IRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723291625; c=relaxed/simple;
	bh=JMi4VqlR6VLRsS45yK6xehSfzEWKZlPxzkPo4WsyD6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=daCJXJ1SFmBSLLhGCjl88p+b8s02VqW9KCw6qN8061pfxH7pIx9dXCO1wOCum9uhFqgJfFiPgCt4qVvV5qklh0CcN+qTrOvcOJarYHid0pCrls4n/gOxCaKrVbD79KyLwY3pzmfYpW737n1t++1p9z7vRsqWisuCMPvPzQRYAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b38200743so37929475ab.2
        for <virtualization@lists.linux.dev>; Sat, 10 Aug 2024 05:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723291623; x=1723896423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brS7xkekpvIr1jOYZCd0Wlyr5RS+/5cL13gt+qEWR4I=;
        b=pydj+fNQBpJPd/OwM2ScTBKpM8vubqv7Cr+136jkQjSlvtB0YRFTb4Vot7OteumH4N
         NxUQjxGjwQWJJw0IZarh6nY2DqfwlzDmkrC4GrfMVRraSLGYn38DZIpLCN1Q0jTL0/z1
         Tdu42LXdBYLomcdyR4LUlt0x0IHg7MUItb8hP6cmpduuJvD9gcpABMOTUU9Ps5ipVozj
         GwyZ48cdo0Pt++YVITOJtme3QS6xJ2BR0yobl6pukSzUoDyCD+DFHIr19Rih6vO6Qg9v
         cUm71QA+aKTF3vhsXy3DBJ5IgJUndOTzoUpJmmFEXBseLqqFax/oIRBDR5aA65Wpbs50
         aAAA==
X-Forwarded-Encrypted: i=1; AJvYcCUC97eteIeH5ENdElsnpHtAK917b975AnXX2qp9CZ1b7RQvl2h+Ons0GwgOJ7yKL5futzDfSs/HTS5CXle6D6aCVjtrskaVknpkSYU7GDs=
X-Gm-Message-State: AOJu0YwoKUrFXQhscDIcwIl//qutKcdsQOpVDSLzaDZyPpUa3DFKDI2T
	LehzKhnjpPihVqpSGaTn8UpiGFwWQrXNDXbjvWCFOVja+mED1nAzmIGV8IJyKOoiLJmuVnwYylI
	I6LlW1TQScJtaxMS8hV+mjrVnVJovC2g84OzCwIJSmnCjAgNnoITlZQk=
X-Google-Smtp-Source: AGHT+IFy+VeqXqzz/19A1XE5ksRo66lpGRBRIcR5gsemJWKDHHV8VcCm7/3BuhZRoKjTALyu3JVCmRt4uDYiNtIkUWqL8gt9FFWm
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39b8134a48amr3691455ab.6.1723291623131; Sat, 10 Aug 2024
 05:07:03 -0700 (PDT)
Date: Sat, 10 Aug 2024 05:07:03 -0700
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9b85061f5319be@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 634f1a7110b439c65fd8a809171c1d2d28bcea6f
Author: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Mon Mar 27 19:11:51 2023 +0000

    vsock: support sockmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d3c97d980000
start commit:   eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1033c97d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3c97d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a1b97d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e7b2f3980000

Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Fixes: 634f1a7110b4 ("vsock: support sockmap")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
