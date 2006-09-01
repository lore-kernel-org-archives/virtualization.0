From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/9] Guest page hinting: cover sheet.
Date: Fri, 1 Sep 2006 13:08:36 +0200
Message-ID: <20060901110836.GA15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751393AbWIALIt@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-08-25 at 11:52 -0700, Andrew Morton wrote:
> The obvious question is: "can Xen/vmware/whatever use this too?".  The
> preliminary answer I get back is "might well be the case".  Hopefully we'll
> hear more back soon.
> 
> So a good way to get some monentum into this work is to copy
> virtualization@lists.osdl.org and lkml, try to get it some more users.

Hi folks,
Andrew thinks that it might be a good idea to broaden the audience for
the guest page hinting patches. So here we go ..

The background for the patches is running a large number of guests on
a paging hypervisor with a high memory over-commitment ratio. We have
that situation on the mainframe running hundreds of Linux guests system
on z/VM. For hypervisors with a small number of guests the usual answer
to the memory over-commitment problem is a memory balloon in the guest
whose size is controlled by the host. For are large number of guests
the overhead to call into the guests increases, what is needed is an
alternative way for the hypervisor to get to memory without the
invokation of the guest system.

The original cover-sheet as posted on linux-mm:

> Fourth version of the guest page hinting patches. The code has been
> polished and another race has been fixed (keep fingers crossed that
> is has been that last one this time).
> 
> The basic idea of guest page hinting is to give a host system which
> virtualizes the memory of its guest systems on a per page basis
> usage information for the guest pages. The host can then use this
> information to optimize the management of guest pages, in particular
> the paging. This optimizations can be used for unused (free) guest
> pages, for clean page cache pages, and for clean swap cache pages.
> The content of free pages can be replace with zeroes and the content
> of clean page cache / swap cache pages can be reloaded by the guest
> from the backing store.
> 
> There are 9 patches that implement guest page hinting:
> 
> 1) Guest page state changes for free pages.
> 2) s390 exploitation of state changes for free pages.
> 3) Guest page state changes for page cache pages.
> 4) Guest page state changes for swap cache pages.
> 5) Keep mlocked pages in stable state.
> 6) Add support for writable page table entries.
> 7) Optimization for minor faults.
> 8) Discarded page list.
> 9) full s390 architecture support for guest page hinting.
> 
> The first two patches are independent from the other seven. These
> two just deal with unused/free vs. used/stable pages. The code
> starts to get interesting with patch #03..
> 
> Any objections against pushing patch #01 and patch #02 into the
> -mm tree?
> 
> The code runs well on s390 and does nothing for all other archs.
> Patches are against 2.6.18-rc4-mm2.

Only difference of this patch-set compare to the one posted on linux-mm
is that this patch-set is against 2.6.18-rc5-mm1. To go back to Andrews
question: is this useful for anybody else in addition to s390?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
