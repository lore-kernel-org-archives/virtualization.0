Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B14C4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 13:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87E1A60BA9;
	Wed,  4 Jan 2023 13:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87E1A60BA9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T164K/ud
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNQNxIv-et_h; Wed,  4 Jan 2023 13:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17A3160692;
	Wed,  4 Jan 2023 13:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17A3160692
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB7DC0032;
	Wed,  4 Jan 2023 13:04:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 259D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2D7E60B5C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:04:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2D7E60B5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ke1HzPFQKNEt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:04:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F3E060692
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F3E060692
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672837447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qox/oCIKrJgN89xrHJUvG+swnnlfN7DPV4U9vLlEgHk=;
 b=T164K/udNfLL3MHRvqoM9xWudo1b6jZvyCK7ugALKhfH/o0PIVa8XselgTWUwdz2l6VmPX
 dohisYVXSYg3fOnjQi+FLv4W/MZ1GjNLeGnRChsdIUBKbL9VQyWPzWUQ1YIG0lK8cNtKSK
 TgIXhjNOXpKnrINi+njdW1DWZ+lGpFU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-OjYNycrNOKuTGb_ayxF8fw-1; Wed, 04 Jan 2023 08:04:06 -0500
X-MC-Unique: OjYNycrNOKuTGb_ayxF8fw-1
Received: by mail-wm1-f70.google.com with SMTP id
 bd6-20020a05600c1f0600b003d96f7f2396so18679807wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Jan 2023 05:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qox/oCIKrJgN89xrHJUvG+swnnlfN7DPV4U9vLlEgHk=;
 b=vaBr4bhc/fmnHt2iRQaAcjz4p3HEOEdmhLub0LS6kMrpcy5CTlmf9cSTePXxVnkrul
 ZNTs6TuRnZvvWilVk1WqOI91sReFpYwc/KtSf/dxRZzLwPjsWqt79Qk4b4q4OVvmWSYv
 6uMy50lXhAEuFOGFJgnfSCl1tvjCT6eIyH3M1Pq8ANzfiMZXSEiDQ7VDYBjKXX2n7w+o
 EEVo8oPGp9Qw8ZrUb7qQkxBLZ4aFfC9W2m5ILonV9KOi67WHF+wUNU0gVODc6enFuLtE
 hFRJqVhmLhZklUeCaBXrRQLzLuFe63dFA8NNfnyYQdjcpAN9p7Nr08lFebBRA0VhIGvr
 YoGw==
X-Gm-Message-State: AFqh2kqUezXwJmP9QWiGR2GMnuUIzrvX+hru68gQFlM4+GG4oXTk/U54
 4n7a2z/yyu8sh8Fb4MBvkh+OwUvUIgPg3DviAtZYDLnGG2vDhc/2B7fSLkjExUXN/WunfJvxSqG
 VOc0MrdaQyce2zNZSjTH40VibVSWIgcrhuSJFjsODuA==
X-Received: by 2002:a05:6000:18c3:b0:288:ca2e:7d74 with SMTP id
 w3-20020a05600018c300b00288ca2e7d74mr14295782wrq.14.1672837444934; 
 Wed, 04 Jan 2023 05:04:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtlcfpal455TLuLVy79Kxfe58vG4oN1jPIOPsIFNn4IYhDNS4aZnX9DtEvIz+VUUb8U5/RbTg==
X-Received: by 2002:a05:6000:18c3:b0:288:ca2e:7d74 with SMTP id
 w3-20020a05600018c300b00288ca2e7d74mr14295762wrq.14.1672837444627; 
 Wed, 04 Jan 2023 05:04:04 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 j1-20020adfff81000000b0024cb961b6aesm33027899wrr.104.2023.01.04.05.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 05:04:03 -0800 (PST)
Date: Wed, 4 Jan 2023 08:03:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [syzbot] kernel BUG in vhost_vsock_handle_tx_kick
Message-ID: <20230104074613-mutt-send-email-mst@kernel.org>
References: <0000000000003a68dc05f164fd69@google.com>
 <Y7T+xTIq2izSlHHE@pop-os.localdomain> <Y6A/Yyoh2uZSR0xj@bullseye>
MIME-Version: 1.0
In-Reply-To: <Y6A/Yyoh2uZSR0xj@bullseye>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bobby.eshleman@gmail.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, stefanha@redhat.com,
 Cong Wang <xiyou.wangcong@gmail.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 19, 2022 at 10:46:47AM +0000, Bobby Eshleman wrote:
> On Tue, Jan 03, 2023 at 08:21:25PM -0800, Cong Wang wrote:
> > On Tue, Jan 03, 2023 at 04:08:51PM -0800, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    c76083fac3ba Add linux-next specific files for 20221226
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1723da42480000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c217c755f1884ab6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=30b72abaa17c07fe39dd
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc414c480000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1604b20a480000
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/e388f26357fd/disk-c76083fa.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/e24f0bae36d5/vmlinux-c76083fa.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/a5a69a059716/bzImage-c76083fa.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+30b72abaa17c07fe39dd@syzkaller.appspotmail.com
> > 
> > +bobby.eshleman@gmail.com
> > 
> > Bobby, please take a look.
> > 
> > Thanks.
> 
> Roger that, I'll take a gander asap.

I'll going to revert commit f169a9538803469418d9ba2c42a0236fc43cd876 unless
I hear from you soon, we need linux-next testable.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
