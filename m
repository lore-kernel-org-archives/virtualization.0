From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Sun, 15 Apr 2007 11:46:12 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0704151145410.15892@yvahk01.tjqt.qr>
References: <20070414204154.871250608@goop.org> <20070414204924.125386443@goop.org>
 <46214FD3.3080400@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752801AbXDOJ66@vger.kernel.org>
In-Reply-To: <46214FD3.3080400@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On Apr 14 2007 15:04, H. Peter Anvin wrote:
>
> Jeremy Fitzhardinge wrote:
>> -
>> +LOW_PAGES = 1<<(32-PAGE_SHIFT_asm)
>> +
>
> Again, for debugging... it would be interesting to replace this with:
>
> LOW_PAGES = (0x100000000-__PAGE_OFFSET) >> PAGE_SHIFT_asm

LOW_PAGES = (0x100000000ULL - __PAGE_OFFSET) >> PAGE_SHIT_asm


Jan
-- 
