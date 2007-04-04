From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable entries
Date: Wed, 4 Apr 2007 13:47:42 +0200
Message-ID: <200704041347.42822.ak@suse.de>
References: <20070402055652.610711908@goop.org> <200704020812.18320.ak@suse.de> <46136F25.7030907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992866AbXDDLr4@vger.kernel.org>
In-Reply-To: <46136F25.7030907@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 April 2007 11:25:57 Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > What do the benchmarks say with CONFIG_PARAVIRT on native hardware
> > compared to !CONFIG_PARAVIRT. e.g. does lmbench suffer? 
> 
> Barely.  There's a slight hit for not using patching, and patching is
> almost identical to native performance.  The most noticeable difference
> is in the null syscall microbenchmark, but once you get to complex
> things the difference is in the noise.

Why is there a difference for null syscall? I had assumed we patched all the 
fast path cases relevant there. Do you have an idea where it comes from?

-Andi
