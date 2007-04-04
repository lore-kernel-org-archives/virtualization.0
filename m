From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable
 entries
Date: Wed, 04 Apr 2007 02:25:57 -0700
Message-ID: <46136F25.7030907@goop.org>
References: <20070402055652.610711908@goop.org> <20070402055704.278590661@goop.org> <200704020812.18320.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992782AbXDDJ0N@vger.kernel.org>
In-Reply-To: <200704020812.18320.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> What do the benchmarks say with CONFIG_PARAVIRT on native hardware
> compared to !CONFIG_PARAVIRT. e.g. does lmbench suffer? 

Barely.  There's a slight hit for not using patching, and patching is
almost identical to native performance.  The most noticeable difference
is in the null syscall microbenchmark, but once you get to complex
things the difference is in the noise.

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh  
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
non-paravirt
ezr       Linux 2.6.21- 1000 0.25 0.52 31.6 34.7 10.3 1.03 5.31 726. 1565 4520
ezr       Linux 2.6.21- 1000 0.25 0.52 31.8 34.7 12.6 1.03 5.41 725. 1564 4585
ezr       Linux 2.6.21- 1000 0.25 0.55 31.7 34.5 11.8 1.02 5.47 720. 1595 4518

paravirt, no patching
ezr       Linux 2.6.21- 1000 0.28 0.55 31.3 34.3 10.0 1.05 5.56 747. 1621 4675
ezr       Linux 2.6.21- 1000 0.28 0.56 31.5 34.3 12.9 1.05 5.66 755. 1629 4684
ezr       Linux 2.6.21- 1000 0.28 0.55 31.8 34.5 12.5 1.05 5.45 747. 1622 4695

paravirt, patching
ezr       Linux 2.6.21- 1000 0.25 0.53 31.8 34.4 10.1 1.04 5.44 730. 1583 4600
ezr       Linux 2.6.21- 1000 0.26 0.55 32.1 35.2 13.3 1.03 5.48 748. 1589 4606
ezr       Linux 2.6.21- 1000 0.26 0.54 32.0 34.9 14.1 1.04 5.43 752. 1606 4647


    J
