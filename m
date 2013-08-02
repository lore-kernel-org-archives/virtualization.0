From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH RFC V11 15/18] kvm : Paravirtual ticketlocks support for
	linux guests running on KVM hypervisor
Date: Fri, 2 Aug 2013 12:54:06 +0300
Message-ID: <20130802095406.GB30072@redhat.com>
References: <51EFC1D4.9060800@linux.vnet.ibm.com>
	<20130724120647.GG16400@redhat.com>
	<51EFCA42.5020009@linux.vnet.ibm.com>
	<51F0ED31.3040200@linux.vnet.ibm.com>
	<20130725091509.GA22735@redhat.com>
	<51F0F202.5090001@linux.vnet.ibm.com>
	<51F7ED20.80202@linux.vnet.ibm.com>
	<20130731062440.GK28372@redhat.com>
	<51FA1087.9080908@linux.vnet.ibm.com>
	<20130802092539.GB28327@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130802092539.GB28327@gmail.com>
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
Cc: jeremy@goop.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 02, 2013 at 11:25:39AM +0200, Ingo Molnar wrote:
> > Ingo,
> > 
> > Do you have any concerns reg this series? please let me know if this 
> > looks good now to you.
> 
> I'm inclined to NAK it for excessive quotation - who knows how many people 
> left the discussion in disgust? Was it done to drive away as many 
> reviewers as possible?
> 
> Anyway, see my other reply, the measurement results seem hard to interpret 
> and inconclusive at the moment.
> 
That result was only for patch 18 of the series, not pvspinlock in
general.

--
			Gleb.
