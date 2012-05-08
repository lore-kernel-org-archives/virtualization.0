From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Tue, 08 May 2012 12:16:46 +0530
Message-ID: <878vh3rwyx.fsf__5948.64202798835$1336577240$gmane$org@linux.vnet.ibm.com>
References: <4FA7BABA.4040700@redhat.com> <4FA7CC05.50808@linux.vnet.ibm.com>
	<4FA7CCA2.4030408@redhat.com> <4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com> <4FA7D3F7.9080005@linux.vnet.ibm.com>
	<4FA7D50D.1020209@redhat.com> <4FA7E06E.20304@linux.vnet.ibm.com>
	<4FA7E1C8.7010509@redhat.com> <20120507172527.GA5357@gmail.com>
	<alpine.LFD.2.02.1205072240020.6271@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1205072240020.6271@ionos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Virtualization <virtualization@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 7 May 2012 22:42:30 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 7 May 2012, Ingo Molnar wrote:
> > * Avi Kivity <avi@redhat.com> wrote:
> > 
> > > > PS: Nikunj had experimented that pv-flush tlb + 
> > > > paravirt-spinlock is a win on PLE where only one of them 
> > > > alone could not prove the benefit.
> > > 
Do not have PLE numbers yet for pvflush and pvspinlock. 

I have seen on Non-PLE having pvflush and pvspinlock patches -
kernbench, ebizzy, specjbb, hackbench and dbench all of them improved. 

I am chasing a race currently on pv-flush path, it is causing
file-system corruption. I will post these number along with my v2 post.

> > > I'd like to see those numbers, then.
> > > 
> > > Ingo, please hold on the kvm-specific patches, meanwhile.
> > 
> > I'll hold off on the whole thing - frankly, we don't want this 
> > kind of Xen-only complexity. If KVM can make use of PLE then Xen 
> > ought to be able to do it as well.
> > 
> > If both Xen and KVM makes good use of it then that's a different 
> > matter.
> 
> Aside of that, it's kinda strange that a dude named "Nikunj" is
> referenced in the argument chain, but I can't find him on the CC list.
> 
/me waves my hand

Regards
Nikunj
