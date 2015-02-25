From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH for stable] x86/spinlocks/paravirt: Fix memory corruption
	on unlock
Date: Wed, 25 Feb 2015 11:29:32 +0100
Message-ID: <20150225102932.GA554@gmail.com>
References: <1424769899-14158-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150224141731.GA16033@kroah.com>
	<20150224144737.GA26074@gmail.com>
	<54ECC0A1.1080802@linux.vnet.ibm.com>
	<20150224183844.GA8654@kroah.com> <20150225100806.GA7134@gmail.com>
	<54EDA08E.5080901@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <54EDA08E.5080901@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: jeremy@goop.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, Greg KH <gregkh@linuxfoundation.org>, oleg@redhat.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


* Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> > By all means!
> > 
> > You'll first need to cherry-pick these commits:
> 
> >  927609d622a3 kernel: tighten rules for ACCESS ONCE
> >  c5b19946eb76 kernel: Fix sparse warning for ACCESS_ONCE
> >  dd36929720f4 kernel: make READ_ONCE() valid on const arguments
> 
> If you go before 3.19, you will also need
> 
>    230fa253df63 kernel: Provide READ_ONCE and ASSIGN_ONCE
>    43239cbe79fc kernel: Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)

The affected spinlock code went over several iterations 
post v3.18, which I think makes the spinlock change too 
risky and complex to backport so far back. So it's not 
necessay to backport these READ_ONCE() changes.

> > That's the minimum set you will need for backporting, 
> > due to overlapping changes to the ACCESS_ONCE() 
> > definition.
> > 
> > and then apply this commit:
> > 
> >  d6abfdb20223 x86/spinlocks/paravirt: Fix memory corruption on unlock
> 
> the alternative might be to replace READ_ONCE with 
> ACCESS_ONCE when doing the backport.

Doing changes to patches when doing a backport is a big 
no-no IMHO. Either there is a clean sequence of upstream 
commit IDs to cherry-pick, or it should not be backported 
in most cases.

Thanks,

	Ingo
