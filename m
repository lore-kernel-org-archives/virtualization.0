From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Wed, 27 Jan 2016 09:39:05 +0100
Message-ID: <20160127083905.GK6357__33931.4784775071$1453883988$gmane$org@twins.programming.kicks-ass.net>
References: <20160114212913.GF3818@linux.vnet.ibm.com>
	<20160115085554.GF3421@worktop> <20160115091348.GA27936@worktop>
	<20160115174612.GV3818@linux.vnet.ibm.com>
	<20160115212714.GM3421@worktop>
	<20160115215853.GC3818@linux.vnet.ibm.com>
	<20160125164242.GF22927@arm.com>
	<20160126060322.GJ4503@linux.vnet.ibm.com>
	<20160126101927.GD6357@twins.programming.kicks-ass.net>
	<20160126201339.GW4503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160126201339.GW4503@linux.vnet.ibm.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 26, 2016 at 12:13:39PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 26, 2016 at 11:19:27AM +0100, Peter Zijlstra wrote:

> > So isn't smp_mb__after_unlock_lock() exactly such a scenario? And would
> > not someone trying to implement RCsc locks using locally transitive
> > RELEASE/ACQUIRE operations need exactly this stuff?
> > 
> > That is, I am afraid we need to cover the mix of local and global
> > transitive operations at least in overview.
> 
> True, but we haven't gotten to locking yet.

The mythical smp_mb__after_release_acquire() then ;-)

(and yes, I know you're going to say we don't have that)

> That said, I would argue
> that smp_mb__after_unlock_lock() upgrades locks to transitive, and
> thus would not be an exception to the "no combining transitive and
> non-transitive steps in cycles" rule.

But But But ;-) It does that exactly by combining. I suspect this is
(partly) the source of your SC chains with one PC link example.
