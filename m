From: Will Deacon <will.deacon@arm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Date: Wed, 27 Jan 2016 10:23:14 +0000
Message-ID: <20160127102313.GC2390__1431.80308300561$1453890217$gmane$org@arm.com>
References: <20160114212913.GF3818@linux.vnet.ibm.com>
	<569814F2.50801@imgtec.com>
	<20160114225510.GJ3818@linux.vnet.ibm.com>
	<20160115102431.GB2131@arm.com>
	<20160115175401.GW3818@linux.vnet.ibm.com>
	<20160115192845.GA12510@linux.vnet.ibm.com>
	<20160125144133.GB22927@arm.com>
	<20160126010646.GH4503@linux.vnet.ibm.com>
	<20160126121010.GD21553@arm.com>
	<20160126233733.GZ4503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160126233733.GZ4503@linux.vnet.ibm.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 26, 2016 at 03:37:33PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 26, 2016 at 12:10:10PM +0000, Will Deacon wrote:
> > On Mon, Jan 25, 2016 at 05:06:46PM -0800, Paul E. McKenney wrote:
> > > PPC WRCnf+addrs
> > > ""
> > > {
> > > 0:r2=x; 0:r3=y;
> > > 1:r2=x; 1:r3=y;
> > > 2:r2=x; 2:r3=y;
> > > c=a; d=b; x=c; y=d;
> > > }
> > >  P0           | P1            | P2            ;
> > >  stw r3,0(r2) | lwz r8,0(r2)  | lwz r8,0(r3)  ;
> > >               | stw r2,0(r8)  | lwz r9,0(r8)  ;
> > > exists
> > > (1:r8=y /\ 2:r8=x /\ 2:r9=c)
> > 
> > Agreed.
> 
> OK, thank you!  Would you agree that it would be good to replace the
> current xor-based fake-dependency litmus tests with tests having real
> dependencies?

Yes, because it would look a lot more like real (kernel) code.

Will
