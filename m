Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A102EA15F
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992088; cv=none; b=jcvLQPij3GDKK3ngz+LriXdukZbjFT/+OQXVv1N/oWXCmTthy3Fs6IzsPru0NG9hlRRbsp9t7SWoFvI/5qakyL38dktkBI6FasgBxKE2BNh6KAj54i1ieLtRP06UtramZ6DJzuUHG30KONzXvktVsD4/uxsSUBpeqzbbpZgFBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992088; c=relaxed/simple;
	bh=tgMF8HuU+iL/6Y55dy6ba5v8RvxSKr6oTJYUTWCzqHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kIz5OBWoIEyR7ABhy4MRM855flKGMRvdFoUGEW0z0rGdvD3qkvJvJiAQ8v+63dBNKbXsj+pWpwls49O/dBn0Q+fKHleFfQBoRO72mr/momOUBHDyTsrKOY7FZSWOU2kDT4g7Eu3t/ukh8XVNi3rgbwP/RA0qU6rZGrRatv61CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86463467dddso534016439f.3
        for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 02:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992086; x=1755596886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23s4cMMxaWk/6h2mIsslFjC/yj0rjYz/dHBx5jBiKdk=;
        b=tu3Tc2/i0d0AHoPwNu5OkSoDZtrDmWuz+sxI6Zv0fhgd3nGzCmNco8UtUukt0+24yy
         ulRHb7W9oc0p5vTnLqmhjKaMFciinjIir7o4m6yugEyk8JqQHQqAka0zeGz9S7Vzys+c
         8eb3OzFDIQSYzmdxt20Sa9EpFX0ttNPUzTHjFrcIHCoG17NLcUgaPyomodtAWRCftk+a
         98fG/+cxt6rfsqPCCDehq4uTtMSmpYL4l1FreEEu18ieiUD/K6jedhBitWe0DHH+W+ll
         4p8p71ZG5HWxqLfAKMwhaqjeUw8hm7X2RDJHiq4m+xqHMSCowAS0tfSkRtCipg3YNfx0
         QLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB1m53QnyELGIoSgKmlFN5Pg2QZdkC2K3HoIT6CYQYg1zY77H4C2QTL18didjdzVpovqhGxvByTJxguaBnOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP0oCTt4EoGNmxEyvq63eiWhqMa0f+YaUnAdp050nHUaYjzIAI
	sm9637vDQ4mtMRj0FEPE9l62DXnNgMXpn7cjWWT3s5YucmAlk3oe0pA6rU2noKDnE4alFTHH3fT
	2soJ+vOJVbX/u0R76wW8BVpCEylcB8PFOebr0w6VuMLt/83VqMiBqco8LsY0=
X-Google-Smtp-Source: AGHT+IG3SLQLj7KxZZEj1GNTliTbrGRu9ikWa+/cuwM6xZfm+k+wklil9CcAWSa+9Q7XgA8ywVi7c7dtP5+lK+hEKORoB3z1DYwc
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1546:b0:881:8979:93f4 with SMTP id
 ca18e2360f4ac-883f127fca5mr3181687939f.14.1754992085862; Tue, 12 Aug 2025
 02:48:05 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:48:05 -0700
In-Reply-To: <20250812052537-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b0dd5.050a0220.7f033.0119.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Tested-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com

Tested on:

commit:         8ca76151 vsock/virtio: Rename virtio_vsock_skb_rx_put()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d54af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84141250092a114f
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
