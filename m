From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2 0/6] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 3 Aug 2011 09:56:04 -0400
Message-ID: <20110803135604.GA29761__7104.98595512963$1312379811$gmane$org@dumpdata.com>
References: <cover.1312378163.git.luto@mit.edu>
	<20110803135322.GC29501@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110803135322.GC29501@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@mit.edu>, mingo@redhat.com, hpa@zytor.com
Cc: xen-devel@lists.xensource.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 03, 2011 at 09:53:22AM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Aug 03, 2011 at 09:31:48AM -0400, Andy Lutomirski wrote:
> > This fixes various problems that cropped up with the vdso patches.
> > 
> >  - Patch 1 fixes an information leak to userspace.
> >  - Patches 2 and 3 fix the kernel build on gold.
> >  - Patches 4 and 5 fix Xen (I hope).
> >  - Patch 6 (optional) adds a trace event to vsyscall emulation.  It will
> >    make it easier to handle performance regression reports :)
> 
> Hm, you seemed to have the x86 maintainers on your email..

I definitly need some coffee. What I meant was that you missing putting
the x86 maintainers on this patchset. They are the ones that will handle this.

I put them on the To list for you.
> > 
> > [1] https://gitorious.org/linux-test-utils/linux-clock-tests
> > 
> > Changes from v1:
> >  - Improve changelog message for "x86-64/xen: Enable the vvar mapping"
> >  - Fix 32-bit build.
> >  - Add patch 6.
> > 
> > Andy Lutomirski (6):
> >   x86-64: Pad vDSO to a page boundary
> >   x86-64: Move the "user" vsyscall segment out of the data segment.
> >   x86-64: Work around gold bug 13023
> >   x86-64/xen: Enable the vvar mapping
> >   x86-64: Add user_64bit_mode paravirt op
> >   x86-64: Add vsyscall:emulate_vsyscall trace event
> > 
> >  arch/x86/include/asm/desc.h           |    4 +-
> >  arch/x86/include/asm/paravirt_types.h |    6 ++++
> >  arch/x86/include/asm/ptrace.h         |   19 +++++++++++++
> >  arch/x86/kernel/paravirt.c            |    4 +++
> >  arch/x86/kernel/step.c                |    2 +-
> >  arch/x86/kernel/vmlinux.lds.S         |   46 ++++++++++++++++++---------------
> >  arch/x86/kernel/vsyscall_64.c         |   12 +++++---
> >  arch/x86/kernel/vsyscall_trace.h      |   29 ++++++++++++++++++++
> >  arch/x86/mm/fault.c                   |    2 +-
> >  arch/x86/vdso/vdso.S                  |    1 +
> >  arch/x86/xen/enlighten.c              |    4 +++
> >  arch/x86/xen/mmu.c                    |    4 ++-
> >  12 files changed, 102 insertions(+), 31 deletions(-)
> >  create mode 100644 arch/x86/kernel/vsyscall_trace.h
> > 
> > -- 
> > 1.7.6
