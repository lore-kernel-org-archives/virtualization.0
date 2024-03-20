Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD7182C5
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915125; cv=none; b=YbwaxTxGAGsRKmLmHZsGgdpIeRIv34m2jz2Z8l481MJ1y4YKhAM0fP3SJkedPfJzuWGL5Teb+1c6VYN2iqq3F590DkSfCVa26gN4TBb288/x7wTTUur3UNuJfavNA4k0ka+NnCL1qvsZbVxFWHQp392SCq2S7VFuq95Xbu8PqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915125; c=relaxed/simple;
	bh=Fg3+p9aGxeQZ/9oyVfu/Bs1KEeita6s240ybpqDaibU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lBdKt4Sm6/kVVwf2db46g2OSNI7Jqz3DJdA6e7wCo90JFaWs757Sk5/IsI17lCGYW62VncEo0ckspJMLtq+zNluSoWGM+4FPcEWgsD+WYhnSpZkFXZAg/cw2CiOAJmbBT0PSwzWSJXwLqhkUwD8LyN12m1klfQAkPxDbz9HXlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so481558739f.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 23:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915123; x=1711519923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGhV+BjFTmT2BRGB/4pS+DB4I2X3ipzTIt7FUzSRHWw=;
        b=kr9RntPTI9nuusUJj0i6kncSx+15u1Pew1ihh1O1d3QKundsWx+gGkAoHeJWbssT8a
         IL1kVFFMxFJUIZasSs+iqQaity+wfEq7ANlUCFPhCdi/Lge9pJXCv/Ud6HOjgdRO4+jy
         TEo/qfpK7KZ0W/WAcrxqHyNHcuSKC/cQFT5+vWW3gnnoM5XEYOx6aAE6sWVqSCNlFHuH
         AFgoQlOW8rsc8AUIi7ypQxNsBv2Kn6xAcQsFmaf8y3zC2QQTuAUC6Mx9kEanZ5K5F9Wm
         tmtj9/29AcPS1QILRf7YLFJfwuRMb9n0WDyxKsVPyiwPbJjApSI7YeCv2SAqUPJ2WnUz
         mUQg==
X-Forwarded-Encrypted: i=1; AJvYcCXLwjZFjp4CVUHRqErVUpRLDMGPpWpDAi/EhWQTjRJh0oGDQbBSQoI9JRLE24Lg5BpCM8uGwW2reob1lWXv27DSGsix2Xx2zrWiAhC1P2I=
X-Gm-Message-State: AOJu0Yy0cUqF78MEMtXN0W9hPXGF6oqTs5+hAPicGMICl7Sqb5Ec0XMi
	+hy2KCw2JDQzeRV3zMPB/4rYmM1ebt2j/yNp3MEsB6JobRd40fFv7K8/x2ukWnkwvp7y6HEtvZm
	GCbhADITyZjfM6OGWC9ApPqF/87jacs4iFcs1Fb0qziuyfFb49tvOEFQ=
X-Google-Smtp-Source: AGHT+IGU/qjjRg+iFnh0XV8rbPxCgFHKjyUJ7lfwD/79GZ3RLd9rgNbteeYz+Ih6Qhu6AEfq4m0FCpckZ5ER9pr5gNHc8NbD+0BD
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3423:b0:7cc:ea7:4f0f with SMTP id
 n35-20020a056602342300b007cc0ea74f0fmr347660ioz.3.1710915122555; Tue, 19 Mar
 2024 23:12:02 -0700 (PDT)
Date: Tue, 19 Mar 2024 23:12:02 -0700
In-Reply-To: <20240319185946.GA1134281@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f00030614117851@google.com>
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING: refcount
 bug in __free_pages_ok
From: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	pbonzini@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com

Tested on:

commit:         52998cdd Merge branch '6.8/scsi-staging' into 6.8/scsi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7b1f286a7e950707
dashboard link: https://syzkaller.appspot.com/bug?extid=70f57d8a3ae84934c003
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
