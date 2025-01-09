Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DE215F47
	for <virtualization@lists.linux.dev>; Thu,  9 Jan 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417706; cv=none; b=HqWq7xnzP9zuR1QDWXIA1KU1AZivq8R1a1antDU3/+SoUm/WkP7PPTwL+a+EvFiAPvJe6LphdUYdqhNl2v5KlsF94vzLwJLAr3Bjv1QoQoUqLgxegU82yXdJ0inOpmV/nDbC/QK8Cb8KR+Y+h+8fyKlpsssr4khSFuU52ad+9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417706; c=relaxed/simple;
	bh=kbyruUblBhGqvdvcdX8FQpbEnhYxPFdcdXEruhRjdaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IPsgv+09HtLef/jcGEoLIiVFvLn1FBmgs4q7Od3HPER5MzLONeCWgmbSNAIV+OXjdIdLBIii3m/DBJRX9JSOhb6+LD/kIiDUEhcQytCSvVmsWOBdwpMyl/pUZceU4L2nbtGYaOIgg+Bhazw+aBbXQ0zAMikL7f9lWXrOsIKN+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844d5c7d664so57980539f.2
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 02:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417704; x=1737022504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1KyLOxtLSju+kMk5DlvaCFJoyIAsTFtQb1SI5TVf6g=;
        b=ZxDk05lbWYNjcDwg0R5ekYckvHjX0nKCo1tEkKK80vRi+YshzYa/8GTUKmWGTl9Qky
         PFDDxDZcJvx2lTey7NUZxp6QuJQx8G9vIe6ncttE0Qle7pTqUX5Gu4pamUxD3vc6zM4q
         AeepkQQp4yASfKU/X8SGJDsPPRh8h4HiAf5p+7kI5vEPH/9ZsWJMKBTB8meG2+I3WUZg
         6yFlCFkDeHrHTmzJrHd+JvK6L32sWss4ekzeJesVwYcOhUeVhLSwQQnxg1AKa2xPhXbv
         X3MEUsWeOZ9ZwstFdDIsf35sVBnxtQQpnLaq3jZ4hkEw5/73tslD3JPZntuJEE1UBfxE
         haRg==
X-Forwarded-Encrypted: i=1; AJvYcCWIBtUHdlocABimjOA5XNMoS0L80wfc5z5dAyg8e0P9MNR0fIBl4COJ2NK5f99sMnkcBUtnoiXRP9VCc0YQkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWANbltfFi1F5kayGelemjOwy9Ci0HigFw0WlFiywiiiS8C/AX
	hMjn/WFBkfTIBGD+DLUenbRDTiTSrSDf/uN/7gYtx2+mF7SIVEeOVfeFb/c2bLmeo79GT86nVYC
	7iMmrQ8zJvw4wJ65B2EKGywTz+x2MEeKKpxUDtm/U5j2vCvxPzq2aDYs=
X-Google-Smtp-Source: AGHT+IH2QInG3jDHyiVNPfZgn0++Tkz4Y5LCkLxo9WKy/mclasTAGOgowMoJPjHgAXD1Pi/vi3la0WkAWKV44ggGP4GmCciogWru
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:3a7:e86a:e80f with SMTP id
 e9e14a558f8ab-3ce3a9a5b0cmr54427525ab.3.1736417703971; Thu, 09 Jan 2025
 02:15:03 -0800 (PST)
Date: Thu, 09 Jan 2025 02:15:03 -0800
In-Reply-To: <a4n77w3u22efhdnyz5xn5gjvsfq7xncy3lyn32xqobnuw6gb27@kxubdyn4hr2q>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677fa1a7.050a0220.25a300.01b5.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] general protection fault in vsock_connectible_has_data
From: syzbot <syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com>
To: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
Tested-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com

Tested on:

commit:         767faff2 vsock/bpf: return early if transport is not a..
git tree:       https://github.com/stefano-garzarella/linux.git fix-vsock-null-transport
console output: https://syzkaller.appspot.com/x/log.txt?x=17c9d4b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=3affdbfc986ecd9200fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
