From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Sat, 14 Apr 2007 15:04:03 -0700
Message-ID: <46214FD3.3080400@zytor.com>
References: <20070414204154.871250608@goop.org> <20070414204924.125386443@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751451AbXDNWFI@vger.kernel.org>
In-Reply-To: <20070414204924.125386443@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> -
> +LOW_PAGES = 1<<(32-PAGE_SHIFT_asm)
> +

Again, for debugging... it would be interesting to replace this with:

LOW_PAGES = (0x100000000-__PAGE_OFFSET) >> PAGE_SHIFT_asm

... to smoke out further problems; this will take the strict definition 
of "lowmem" (modulo the pci region, which someone unwisely made 
dynamically adjustable... which would have been fine if initramfs could 
live in highmem, which it can't yet.)

	-hpa
