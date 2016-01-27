From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Wed, 27 Jan 2016 11:40:32 +0100
Message-ID: <20160127104032.GB2939__42762.0548442521$1453891698$gmane$org@linux-mips.org>
References: <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com>
	<5697F6D2.60409@imgtec.com>
	<20160114203430.GC3818@linux.vnet.ibm.com>
	<56980C91.1010403@imgtec.com>
	<20160114212913.GF3818@linux.vnet.ibm.com>
	<569814F2.50801@imgtec.com>
	<20160114225510.GJ3818@linux.vnet.ibm.com>
	<56983054.4070807@imgtec.com>
	<20160115004753.GN3818@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160115004753.GN3818@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutr>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 14, 2016 at 04:47:53PM -0800, Paul E. McKenney wrote:

> So you need to build a different kernel for some types of MIPS systems?

Yes.  We can't really do without.  Classic MIPS code is not relocatable
without the complexity of PIC code as used by ELF DSOs - and their
performanc penalty.  Plus we have a number of architecture revisions
ovr the decades, big and little endian, 32 and 64 bit as the major
stumbling stones.  There however are groups of similar systems that
can share kernel binaries.

> Or do you do boot-time rewriting, like a number of other arches do?

We don't rewrite the code (as in the .text of the vmlinux binary) but we
do runtime code generation for a few highly performance sensitive area
of the kernel code such as copy_page() or TLB exception handlers.  This
allows more flexibility than just inserting templates into the kernel
code.  Downside - it means we have some of the complexity of as and ld
in the kernel.

  Ralf
