From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Tue, 6 Mar 2007 18:11:30 +0100
Message-ID: <20070306171130.GA13403@elte.hu>
References: <20070306081909.GA9331@elte.hu> <45ED2837.3020108@suse.de> <20070306085222.GA17002@elte.hu> <45ED3121.8090308@suse.de> <20070306093436.GA30239@elte.hu> <45ED3F29.6000705@suse.de> <20070306102658.GA7478@elte.hu> <45ED4AD8.6020504@suse.de> <20070306115937.GA25313@elte.hu> <45ED9678.5050907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965309AbXCFRM0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45ED9678.5050907@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Gerd Hoffmann <kraxel@suse.de>, virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> The whole point of pv_ops is to allow the hypervisors interfaces to 
> evolve at their own pace without having to constrain the core kernel's 
> development

unfortunately that's a self-serving oxymoron, contradicted by real life 
;) Pretty much the only way to ensure a sane ABI is to do it like we do 
it with the Linux syscall ABI:

	_to have only one_

We do not let OpenOffice or Evolution have its own separate ABI to Linux 
so that they 'can evolve at their own pace'... We want them to cooperate 
and come up with a common ABI (or rather, we try to come up with the 
right syscalls ourselves), because divering, overlapping ABIs are a huge 
PITA.

We do not unify their pointlessly diverging ABIs to within the kernel 
via say office_ops (while we could) because that's crappy on its face. 
Hypervisors arent in any way different, they just _think_ they are 
special because they are relatively new. But hey, i dont expect you to 
concede this point ;)

	Ingo
