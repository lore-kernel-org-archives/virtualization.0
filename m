From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 00/33] xen: Xen paravirt_ops implementation
Date: Tue, 22 May 2007 16:06:48 +0100
Message-ID: <46530708.3040402@goop.org>
References: <20070522140941.802382212@goop.org> <200705221657.53607.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1766010AbXEVPHH@vger.kernel.org>
In-Reply-To: <200705221657.53607.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Xen-devel <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> This is the Xen implementation for the paravirt_ops interface.  The
>> series is based on 2.6.22-rc1-mm1, and I think its ready to be cooked
>> in -mm with a view to being merged in 2.6.23.
>>     
>
> I already got it in my tree now from your previous post. Does this
> version have changes over that one? 

Yes, I've done a few passes of tidying up, and spent some effort on
beefing up the patch descriptions/changelogs.  There are no significant
functional differences though.

    J
