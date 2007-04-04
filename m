From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable
 entries
Date: Wed, 04 Apr 2007 09:04:30 -0700
Message-ID: <4613CC8E.7020202@goop.org>
References: <20070402055652.610711908@goop.org> <200704041347.42822.ak@suse.de> <4613C828.2030604@goop.org> <200704041756.35016.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992980AbXDDQEs@vger.kernel.org>
In-Reply-To: <200704041756.35016.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> I was talking about the patched case. It seemed to be a little slower
> too, but in theory it shouldn't have been, no? 

Oh, the .25 vs .26?  That's definitely noise; on other runs I see no
difference:

paravirt, patched, busy machine
ezr       Linux 2.6.21- 1000 0.25 0.52 31.3 34.4 12.7 1.02 5.44 743. 1578 4582
ezr       Linux 2.6.21- 1000 0.25 0.53 31.4 34.2 12.1 1.02 5.27 736. 1594 4806
ezr       Linux 2.6.21- 1000 0.25 0.52 31.5 34.4 14.3 1.02 5.49 736. 1587 4601

(I didn't use this result because I did it on a fairly busy machine, but
the best-case numbers are actually somewhat better than the run on a
completely quiet machine.)


    J
