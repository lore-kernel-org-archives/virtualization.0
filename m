From: Avi Kivity <avi@redhat.com>
Subject: Re: [Xen-devel] [PATCH RFC V3 2/4] kvm hypervisor : Add a hypercall
	to KVM hypervisor to support pv-ticketlocks
Date: Wed, 07 Dec 2011 12:53:54 +0200
Message-ID: <4EDF45C2.9060108@redhat.com>
References: <20111130085921.23386.89708.sendpatchset@oc5400248562.ibm.com>
	<20111130085959.23386.69166.sendpatchset@oc5400248562.ibm.com>
	<4ED760F1.6080804@redhat.com> <4ED7DA85.5080504@linux.vnet.ibm.com>
	<4EDBB6C2.9050303@linux.vnet.ibm.com>
	<20111206164947.GA13184@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111206164947.GA13184@andromeda.dapyr.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Raghavendra K T <raghukt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization <virtualization@lists.linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave@linux.vnet.ibm.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/06/2011 06:49 PM, Konrad Rzeszutek Wilk wrote:
> On Sun, Dec 04, 2011 at 11:36:58PM +0530, Raghavendra K T wrote:
> > On 12/02/2011 01:20 AM, Raghavendra K T wrote:
> > >>Have you tested it on AMD machines? There are some differences in the
> > >>hypercall infrastructure there.
> > >
> > >Yes. 'll test on AMD machine and update on that.
> > >
> > 
> > I tested the code on 64 bit Dual-Core AMD Opteron machine, and it is 
> > working.
>
> I am not that familiar with how KVM does migration, but do you need any
> special flags in QEMU to when migrating a KVM-pv-spinlock enabled guest
> to another machine?

I don't think so.  Sleeping is an ordinary HLT state which we already
migrate.  There are no further states.

-- 
error compiling committee.c: too many arguments to function
