From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable entries
Date: Wed, 4 Apr 2007 17:56:34 +0200
Message-ID: <200704041756.35016.ak@suse.de>
References: <20070402055652.610711908@goop.org> <200704041347.42822.ak@suse.de> <4613C828.2030604@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992972AbXDDP4m@vger.kernel.org>
In-Reply-To: <4613C828.2030604@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 April 2007 17:45:44 Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > Why is there a difference for null syscall? I had assumed we patched all the 
> > fast path cases relevant there. Do you have an idea where it comes from?
> 
> Sure.  There's indirect calls for things like sti/cli/iret.  It goes
> back to native speed when you patch the real instructions inline.

I was talking about the patched case. It seemed to be a little slower
too, but in theory it shouldn't have been, no? 

-Andi
