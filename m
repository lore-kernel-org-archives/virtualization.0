Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FF168BE
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835865; cv=none; b=WSMXLmmKIOgLkXB1358L3j0y6Gg8/CmLvJiJ5rUzp4Z41UJWBcPwY72ZHmWyKtD/nPpwGOPMA8S8Dd1pCDHfaVrFTOSlH2LD5VyAD+Tv0TIOFsrUdJdK4V1PctsUWNG8S4/C4NjWXdrs09rRffsya1D3WuDSP8WX429OEg7pe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835865; c=relaxed/simple;
	bh=22JucIr333S5hWoQojYq8sDzxWaVqwg8jNiaohfDBE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SJFW2xNbUViebnsUD5viB7GjOpPn6mT40U/I3jiThIqCaAyz+NImrAR+cf/uXqEe1ZFVL6ViTBIQNhu/PUxHV8G1Nzw5zCmGhN0BPprLEgPvHVz6AoThMbOpODedYXMsMkohBGvm3UhwvuFO4D6pd2qJkXnRbyQvjmssYzxZxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so364876639f.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 18:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713835863; x=1714440663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz3oNrlg/tZ0pVKzc2WrDO3+pRPfzflWiDsR/M727fk=;
        b=N2lzzN7pWw1a+CR31jKyZK53LqfNtbE8ci4q5P2/TuNsnbHB09wy4AiQoPfcFq9zhi
         Uu+r5dM0k1c5vOwVUusVBzlTXxZnV0kb0ARAm6gqsJ6IEB95HCQdNpYRv3Us/wWAreB7
         ufAspWb/H9hGTK6GB+7V50K3MWqEXtEJZsrVb0Jd3J6SlF5eTXldEuvqNGQN/Z93fxsx
         vbQDbgIdQgdOPMwajOOwvgEvUP3d3qdt6ir+f+V2ENx7B07Y5YjItoidcnSpoBqS8+Tf
         +ZCe1/G6hsaHQzO3Mpj+MbuwPiwFMRYfGfSxRG4J60BswmGdnBNMVUlXkJgXaS/7/yG1
         OYJg==
X-Forwarded-Encrypted: i=1; AJvYcCWx+8CChLUlhqH81q7uKe4K32+B0lmksGIDH/hCiqF+Rf21dEkV5rQQwzKiGX5E8kR9St6PIaBIKG1I0XTR0gDnxvksEYpYyVFHCUrG1LE=
X-Gm-Message-State: AOJu0YyAelkKKpfhqUUDZF66DDzRLyYa33y7MhFVmDWkVFTa7ySOKlfE
	ULepIJlCYBmzFf0qIalm7LY9IqOZpTHFpSgncBLHxWTVfTdBUbAor3e1T+75r+FSpRsX6AqZFCV
	2eP8StSHQJD7uTAPWYgmaZlfKsMGLYFPjojSmLXf19affIrNMu6noSkI=
X-Google-Smtp-Source: AGHT+IHodPS3M1cJI0kzh6PKVQhHFuy5lI2gp/FKCQIK5MUvSHRJwKXkmGBl7t3+5hguQZybcRaW0A0Oqr+8oMCpedZQCN1uEESx
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4126:b0:485:6cb9:9a79 with SMTP id
 ay38-20020a056638412600b004856cb99a79mr103537jab.0.1713835863671; Mon, 22 Apr
 2024 18:31:03 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:31:03 -0700
In-Reply-To: <20240422101622-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db97ee0616b981a2@google.com>
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
From: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com

Tested on:

commit:         bcc17a06 vhost/vsock: always initialize seqpacket_allow
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b58abb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
