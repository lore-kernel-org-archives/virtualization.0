From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove
 HAVE_ARCH_MM_LIFETIME, define no-op architecture implementations
Date: Tue, 27 Feb 2007 09:21:13 -0800
Message-ID: <45E46889.9090801@goop.org>
References: <20070227081337.434798469@goop.org>	
	<20070227081632.356636957@goop.org>
	<1172589358.3408.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1172589358.3408.2.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Zachary Amsden <zach@vmware.com>, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

James Bottomley wrote:
> On Tue, 2007-02-27 at 00:13 -0800, Jeremy Fitzhardinge wrote:
>   
>> plain text document attachment (kill-HAVE_ARCH_MM_LIFETIME.patch)
>> akpm:
>>     
>>> Can we lose __HAVE_ARCH_MM_LIFETIME?  Just define these (preferably in C,
>>> not in cpp) in the appropriate include/asm-foo/ files?
>>>       
>> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>> Cc: linux-arch@vger.kernel.org
>>
>> ---
>>  include/asm-alpha/mmu_context.h     |    9 +++++++++
>>  include/asm-arm/mmu_context.h       |    9 +++++++++
>>  include/asm-arm26/mmu_context.h     |    9 +++++++++
>>  include/asm-avr32/mmu_context.h     |    9 +++++++++
>>  include/asm-cris/mmu_context.h      |    8 ++++++++
>>  include/asm-frv/mmu_context.h       |    8 ++++++++
>>  include/asm-h8300/mmu_context.h     |    8 ++++++++
>>  include/asm-i386/mmu_context.h      |    2 +-
>>  include/asm-i386/paravirt.h         |   18 +++++++++++++++---
>>  include/asm-ia64/mmu_context.h      |    8 ++++++++
>>  include/asm-m32r/mmu_context.h      |    8 ++++++++
>>  include/asm-m68k/mmu_context.h      |    8 ++++++++
>>  include/asm-m68knommu/mmu_context.h |    8 ++++++++
>>  include/asm-mips/mmu_context.h      |    8 ++++++++
>>  include/asm-parisc/mmu_context.h    |    9 +++++++++
>>  include/asm-powerpc/mmu_context.h   |   10 ++++++++++
>>  include/asm-ppc/mmu_context.h       |    9 +++++++++
>>  include/asm-s390/mmu_context.h      |    8 ++++++++
>>  include/asm-sh/mmu_context.h        |    8 ++++++++
>>  include/asm-sh64/mmu_context.h      |    8 ++++++++
>>  include/asm-sparc/mmu_context.h     |    8 ++++++++
>>  include/asm-sparc64/mmu_context.h   |    8 ++++++++
>>  include/asm-um/mmu_context.h        |    8 ++++++++
>>  include/asm-v850/mmu_context.h      |    8 ++++++++
>>  include/asm-x86_64/mmu_context.h    |    8 ++++++++
>>  include/asm-xtensa/mmu_context.h    |    9 +++++++++
>>  include/linux/sched.h               |    6 ------
>>  mm/mmap.c                           |    1 +
>>  28 files changed, 218 insertions(+), 10 deletions(-)
>>     
>
> Wouldn't it be a lot easier to do this via asm-generic?
>   

You mean add the two stubs to asm-generic/mmu_context.h, and then
include that in all these files?  That would be cleaner, but it wouldn't
remove the need to touch all these files, would it?

    J
