From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Fri, 2 Aug 2013 11:25:39 +0200
Message-ID: <20130802092539.GB28327@gmail.com>
References: <20130724103907.GF16400@redhat.com>
	<51EFC1D4.9060800@linux.vnet.ibm.com>
	<20130724120647.GG16400@redhat.com>
	<51EFCA42.5020009@linux.vnet.ibm.com>
	<51F0ED31.3040200@linux.vnet.ibm.com>
	<20130725091509.GA22735@redhat.com>
	<51F0F202.5090001@linux.vnet.ibm.com>
	<51F7ED20.80202@linux.vnet.ibm.com>
	<20130731062440.GK28372@redhat.com>
	<51FA1087.9080908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51FA1087.9080908@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, kvm@vger.kernel.org, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:

> On 07/31/2013 11:54 AM, Gleb Natapov wrote:
> >On Tue, Jul 30, 2013 at 10:13:12PM +0530, Raghavendra K T wrote:
> >>On 07/25/2013 03:08 PM, Raghavendra K T wrote:
> >>>On 07/25/2013 02:45 PM, Gleb Natapov wrote:
> >>>>On Thu, Jul 25, 2013 at 02:47:37PM +0530, Raghavendra K T wrote:
> >>>>>On 07/24/2013 06:06 PM, Raghavendra K T wrote:
> >>>>>>On 07/24/2013 05:36 PM, Gleb Natapov wrote:
> >>>>>>>On Wed, Jul 24, 2013 at 05:30:20PM +0530, Raghavendra K T wrote:
> >>>>>>>>On 07/24/2013 04:09 PM, Gleb Natapov wrote:
> >>>>>>>>>On Wed, Jul 24, 2013 at 03:15:50PM +0530, Raghavendra K T wrote:
> >>>>>>>>>>On 07/23/2013 08:37 PM, Gleb Natapov wrote:
> >>>>>>>>>>>On Mon, Jul 22, 2013 at 11:50:16AM +0530, Raghavendra K T wrote:
> >>>>>>>>>>>>+static void kvm_lock_spinning(struct arch_spinlock *lock,
> >>>>>>>>>>>>__ticket_t want)
> >>>>>>>>>>[...]

[ a few hundred lines of unnecessary quotation snipped. ]

> Ingo,
> 
> Do you have any concerns reg this series? please let me know if this 
> looks good now to you.

I'm inclined to NAK it for excessive quotation - who knows how many people 
left the discussion in disgust? Was it done to drive away as many 
reviewers as possible?

Anyway, see my other reply, the measurement results seem hard to interpret 
and inconclusive at the moment.

Thanks,

	Ingo
