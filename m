From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Wed, 25 Jan 2012 14:05:13 -0500
Message-ID: <20120125190513.GD18606@phenom.dumpdata.com>
References: <20120116142014.GA10155@linux.vnet.ibm.com>
	<B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
	<4F146EA5.3010106@linux.vnet.ibm.com>
	<E9F33AFD-F051-4D68-84FF-D259FD6AD19D@suse.de>
	<4F15AF9E.9000907@linux.vnet.ibm.com>
	<1485A122-9D48-46E3-A01E-E37B5C9EC54A@suse.de>
	<4F15BFAE.7060500@linux.vnet.ibm.com>
	<4F1FC370.5020506@linux.vnet.ibm.com>
	<20120125163552.GB23999@phenom.dumpdata.com>
	<4F203FC0.70907@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F203FC0.70907@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@linux.vn>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 25, 2012 at 11:15:36PM +0530, Raghavendra K T wrote:
> On 01/25/2012 10:05 PM, Konrad Rzeszutek Wilk wrote:
> >>So it seems we have worst case overhead of around 8%. But we see
> >>improvement of at-least 15% once when little more time is spent in
> >>critical section.
> >
> >Is this with collecting the histogram information about spinlocks? We found
> >that if you enable that for production runs it makes them quite slower.
> >
> 
> Ok. Are you referring to CONFIG_KVM_DEBUG_FS/CONFIG_XEN_DEBUG_FS?. Not

Those were the ones.

> it was not enabled. But then may be I was not precise. This test was
> only on native. So it should have not affected IMO.

Yup.
> 
> It is nice to know that histogram affects, since I was always under the
> impression that it does not affect much on guest too. My experiments
> had almost always enabled that.
> 
> Let me know if you referred to something else..
