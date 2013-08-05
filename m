From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Mon, 5 Aug 2013 10:05:38 -0400 (EDT)
Message-ID: <1952910281.9619371.1375711538505.JavaMail.root@redhat.com>
References: <51F0ED31.3040200@linux.vnet.ibm.com>
	<20130731062440.GK28372@redhat.com>
	<51FA1087.9080908@linux.vnet.ibm.com>
	<20130802092539.GB28327@gmail.com>
	<20130802095406.GB30072@redhat.com>
	<20130805094603.GA29303@gmail.com>
	<20130805095901.GL2258@redhat.com>
	<20130805135222.GA32429@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130805135222.GA32429@gmail.com>
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
Cc: jeremy@goop.org, x86@kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xensource.com, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad wilk <konrad.wilk@oracle.com>, ouyang@cs.pitt.edu, avi kivity <avi.kivity@gmail.com>, tglx@linutronix.de, chegu vinod <chegu_vinod@hp.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa vaddagiri <srivatsa.vaddagiri@gmail.com>, attilio rao <attilio.rao@citrix.com>, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> > On Mon, Aug 05, 2013 at 11:46:03AM +0200, Ingo Molnar wrote:
> > > Acked-by: Ingo Molnar <mingo@kernel.org>
> > > 
> > > I guess you'd want to carry this in the KVM tree or so - maybe in a
> > > separate branch because it changes Xen as well?
> > 
> > It changes KVM host and guest side, XEN and common x86 spinlock code. I
> > think it would be best to merge common x86 spinlock bits and guest side
> > KVM/XEN bits through tip tree and host KVM part will go through KVM
> > tree. If this is OK with you, Ingo, and XEN folks Raghavendra can send
> > two separate patch series one for the tip and one for KVM host side.
> 
> Sure, that's fine - if the initial series works fine in isolation as well
> (i.e. won't break anything).

It would be a big problem if it didn't!  Raghavendra, please send the
two separate series as Gleb explained above.

Thanks,

Paolo
