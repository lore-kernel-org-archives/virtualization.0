Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7D9C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 20:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DDCF40298;
	Mon, 15 Aug 2022 20:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DDCF40298
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=n7wjnkSj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJW-XR0hCp-K; Mon, 15 Aug 2022 20:34:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 914CF4028D;
	Mon, 15 Aug 2022 20:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 914CF4028D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CD7C0032;
	Mon, 15 Aug 2022 20:34:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 042B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B44D340894
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:34:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B44D340894
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=n7wjnkSj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wVqoIQZ6KOd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:34:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FADF40893
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FADF40893
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:34:29 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 ch17-20020a17090af41100b001fa74771f61so136798pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc;
 bh=4KBjvCyqweA/YX6s5FrlHJFUw4QF4lCn5nqOQumUNOw=;
 b=n7wjnkSjZc1R11i26aCHTFhm74vZ8nzR9cXmhqbIckThGcJwEbsNfn0yV54qtZY/aA
 3754Wn+6H4TQ/KYOC6p+fWd1hFCRjZgh8a+5hypTteu8iZiY9VzQymDfIdktlyVPjyIG
 bFXqUv97O4zemEtV1538vosbA6PIRXK2HIb2m5JGaEJV01domLWcDGkxsCjCOlTZF9uy
 /URJnyuvJfrpvx6obJoe42NfPRQxaMogFFImYSbep1347D3/i7RRT0EgcIkcMQ/XUAJn
 m5qnorABzZVhiWEK4fk3BjC3N0xItDOHL+utn71Os/nV1ahcNywlz9dYRl4cxp59HSqQ
 iVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
 bh=4KBjvCyqweA/YX6s5FrlHJFUw4QF4lCn5nqOQumUNOw=;
 b=15WdqQYXFda6jxpTcC1TlIItgoSGy+Zjm6wyI4BhHA5tgWPM8N/gpP9s96yDE/WbHA
 W65PDcNeoGTzTY5ctf7yQFNcLdMUJeNY3EfyFb3gqWF5aToCEWzM2u42WD6TWXTvceDs
 95oMV08xCNke5kubrUIDGGFFIhr5BbrL8aaRXXqzfkY1o2M7mjfQwANxten1e39UfDWP
 heQS2U3QyJXb6fWJqHR6D5pl7D//I/IgF7t6fLZ34C82spTTQ/Xk9UKEkgoamt5oTRIq
 5yrZ2StsKcKbkAJWP3+UlAgSdjbmOVzfL3o3nzNEw36t0TwnTJ6+RztWNKhqUtEbZek/
 J8rQ==
X-Gm-Message-State: ACgBeo2D+LYa5ubrc/W5q+QVlfyRpDl6PpDt39jiX+5vCzOPfxCGU2kC
 xGFQpg+fCCfHuX+jOfNDAkM=
X-Google-Smtp-Source: AA6agR56UkQzLgBD2aEpa9hh8Hb8XpBeAwQQqChCNJu6bckZm5Rn+ApILdQPknCukpG3U0gTJGgNkA==
X-Received: by 2002:a17:90a:a416:b0:1f7:3b5f:1cd1 with SMTP id
 y22-20020a17090aa41600b001f73b5f1cd1mr20111586pjp.216.1660595669422; 
 Mon, 15 Aug 2022 13:34:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 128-20020a620586000000b0052baa22575asm6934652pff.134.2022.08.15.13.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 13:34:28 -0700 (PDT)
Date: Mon, 15 Aug 2022 13:34:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815203426.GA509309@roeck-us.net>
References: <20220815090521.127607-1-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815090521.127607-1-mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 15, 2022 at 05:16:50AM -0400, Michael S. Tsirkin wrote:
> This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> 
> This has been reported to trip up guests on GCP (Google Cloud).  Why is
> not yet clear - to be debugged, but the patch itself has several other
> issues:
> 
> - It treats unknown speed as < 10G
> - It leaves userspace no way to find out the ring size set by hypervisor
> - It tests speed when link is down
> - It ignores the virtio spec advice:
>         Both \field{speed} and \field{duplex} can change, thus the driver
>         is expected to re-read these values after receiving a
>         configuration change notification.
> - It is not clear the performance impact has been tested properly
> 
> Revert the patch for now.
> 
> Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
> Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
> Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
> Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
> Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Andres Freund <andres@anarazel.de>

I ran this patch through a total of 14 syskaller tests, 2 test runs each on
7 different crashes reported by syzkaller (as reported to the linux-kernel
mailing list). No problems were reported. I also ran a single cross-check
with one of the syzkaller runs on top of v6.0-rc1, without this patch.
That test run failed.

Overall, I think we can call this fixed.

Guenter

---
syskaller reports:

Reported-and-tested-by: syzbot+2984d1b7aef6b51353f0@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=2984d1b7aef6b51353f0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11949fc3080000

Reported-and-tested-by: syzbot+2c35c4d66094ddfe198e@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=2c35c4d66094ddfe198e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163e20f3080000

Reported-and-tested-by: syzbot+97f830ad641de86d08c0@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=f267ed4fb258122a
dashboard link: https://syzkaller.appspot.com/bug?extid=97f830ad641de86d08c0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146c8e5b080000

Reported-and-tested-by: syzbot+005efde5e97744047fe4@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=005efde5e97744047fe4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106c8e5b080000

Reported-and-tested-by: syzbot+9ada839c852179f13999@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=9ada839c852179f13999
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118756f3080000

Reported-and-tested-by: syzbot+382af021ce115a936b1f@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=e656d8727a25e83b
dashboard link: https://syzkaller.appspot.com/bug?extid=382af021ce115a936b1f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135f650d080000

Reported-and-tested-by: syzbot+24df94a8d05d5a3e68f0@syzkaller.appspotmail.com

Tested on:

commit:         568035b0 Linux 6.0-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.0-rc1
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=24df94a8d05d5a3e68f0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12758a47080000
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
