From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Mon, 7 May 2012 19:25:27 +0200
Message-ID: <20120507172527.GA5357__1614.46158676899$1336411844$gmane$org@gmail.com>
References: <4FA7BABA.4040700@redhat.com> <4FA7CC05.50808@linux.vnet.ibm.com>
	<4FA7CCA2.4030408@redhat.com> <4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com> <4FA7D3F7.9080005@linux.vnet.ibm.com>
	<4FA7D50D.1020209@redhat.com> <4FA7E06E.20304@linux.vnet.ibm.com>
	<4FA7E1C8.7010509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FA7E1C8.7010509@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


* Avi Kivity <avi@redhat.com> wrote:

> > PS: Nikunj had experimented that pv-flush tlb + 
> > paravirt-spinlock is a win on PLE where only one of them 
> > alone could not prove the benefit.
> 
> I'd like to see those numbers, then.
> 
> Ingo, please hold on the kvm-specific patches, meanwhile.

I'll hold off on the whole thing - frankly, we don't want this 
kind of Xen-only complexity. If KVM can make use of PLE then Xen 
ought to be able to do it as well.

If both Xen and KVM makes good use of it then that's a different 
matter.

Thanks,

	Ingo
