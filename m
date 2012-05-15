From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Tue, 15 May 2012 12:26:37 +0100
Message-ID: <4FB2598D0200007800083C55@nat28.tlf.novell.com>
References: <4FA7BABA.4040700@redhat.com>
	<4FA7CC05.50808@linux.vnet.ibm.com> <4FA7CCA2.4030408@redhat.com>
	<4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com>
	<4FA7D3F7.9080005@linux.vnet.ibm.com> <4FA7D50D.1020209@redhat.com>
	<4FA7E06E.20304@linux.vnet.ibm.com> <4FA7E1C8.7010509@redhat.com>
	<20120507172527.GA5357@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120507172527.GA5357@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, linux-doc@vger.kernel.org, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.co>
List-Id: virtualization@lists.linuxfoundation.org

>>> On 07.05.12 at 19:25, Ingo Molnar <mingo@kernel.org> wrote:

(apologies for the late reply, the mail just now made it to my inbox
via xen-devel)

> I'll hold off on the whole thing - frankly, we don't want this 
> kind of Xen-only complexity. If KVM can make use of PLE then Xen 
> ought to be able to do it as well.

It does - for fully virtualized guests. For para-virtualized ones,
it can't (as the hardware feature is an extension to VMX/SVM).

> If both Xen and KVM makes good use of it then that's a different 
> matter.

I saw in a later reply that you're now tending towards trying it
out at least - thanks.

Jan
