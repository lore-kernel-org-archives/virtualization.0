Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E261C230C
	for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831582; cv=none; b=Mvzl3YkDSUGJzDAAmCGKHySKbh1RFiN53PmmGglTCgTIfhOnoQ0HLh8hvXnY3xM3AR1qjJH2dYfM/kOz7SOYv4phPlm9KyO8iUucdVLTzLbgwFgA1c1QIkcn7K5HA2zmLswDUdwzlSAIL7Cw3W+3YJljUUcIgK67oBunp4oaXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831582; c=relaxed/simple;
	bh=QY3ohNySnzo+hMm9ROgMKm7NiLqGJh/ZGAf76kr1LEc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PXnjg2GircaPFEeEsBXy61IWeXIxnq8LFyVcSt8yKYNz3S4In44iBX0/ZBr2G49ZV5wrHROv/D79Wb1E06H28YotkYfs7ydu/IW9UVzROD2hnWnPQN47pAUYzWueOYBeD3WE0A+SaMkmPCE0dS16UsyWwntndeEbS3jXbAarvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3962d4671c7so25352795ab.2
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 11:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831580; x=1724436380;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk7VWIxUCGpPDcCbIVePL+r/gPaOsRfDlMifv32OdWU=;
        b=BljzCwA3CbkK2k1FnJ6BdiY9kjAvkY1Z+cYPWupkxn0GaTKxR8ssZg8PeaAFvUuan+
         2A5GMRmh+2DqqyzgCC+5ED5rVEuDp0ZdPxeIZ9qwZdw2ONRnGbUOtUV2bGy8H5exScI3
         kpJmLS6ic4IAVIX2OFIAQ6m8Kmvowcl9oOtGpFLSunJwKmu9XlXQBg7bDGRnYoL264wO
         qmnsTAvM1nTWclFIOed01/+e1LTiiSBzrrCN5A6MCwlX3Ve3Y5lQVZCT4E2nohUSyAiC
         NEVdRcnJqs2L1cOiD5eAd7w8I/20V8hGJmNNWfl6SjWfNnXZ95sb9kxl+EzENKE7oSNQ
         QYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsnfzf+Po7DQidItbamBE+oyW9BrByQf65F2BI3+ZONFXXz44sPbGZqkETbB9zYGC0iLLY1eTTU+8efPrWYzLysQ57QraK4x3Vdhon0K4=
X-Gm-Message-State: AOJu0YxDvgdDbYDzhir3xuaDnSXOZ6QCuep7U08RsYlktBRI+U4W2fEC
	mzjwtrzPtrw6AZ7RRGmXNuDI/HIAVaa5eO75BhBoem3Vs1R+q9BJ9/X/GOLuOROyaMx80r7lObQ
	dpaIyuWpg0D123wgzwGL+vpjlBYjd9B8YhhnxLYhH8raA1cz1rDQMNRs=
X-Google-Smtp-Source: AGHT+IGfABZaedo0n2HrQEGufCpZDZGGnqM4DHsd9tztChw2PWGsN8G47lQwd4Gzke7RLXZRN4XRizt1Lh6fHwwDJhTOWKzB+8q0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:39d:20a4:f42 with SMTP id
 e9e14a558f8ab-39d26ce4072mr1686585ab.2.1723831580184; Fri, 16 Aug 2024
 11:06:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:06:20 -0700
In-Reply-To: <Zr-VGSRrn0PDafoF@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd6343061fd0d012@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
From: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
To: seanjc@google.com
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> On Wed, May 29, 2024, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com
>
> #syz unset kvm

The following labels did not exist: kvm

