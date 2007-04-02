From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 04/17] Add pagetable accessors to pack and unpack pagetable entries
Date: Mon, 2 Apr 2007 08:12:18 +0200
Message-ID: <200704020812.18320.ak@suse.de>
References: <20070402055652.610711908@goop.org> <20070402055704.278590661@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933644AbXDBGM0@vger.kernel.org>
In-Reply-To: <20070402055704.278590661@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 02 April 2007 07:56, Jeremy Fitzhardinge wrote:
> Add a set of accessors to pack, unpack and modify page table entries
> (at all levels).  This allows a paravirt implementation to control the
> contents of pgd/pmd/pte entries.  For example, Xen uses this to
> convert the (pseudo-)physical address into a machine address when
> populating a pagetable entry, and converting back to pphys address
> when an entry is read.

What do the benchmarks say with CONFIG_PARAVIRT on native hardware
compared to !CONFIG_PARAVIRT. e.g. does lmbench suffer? 

-Andi
