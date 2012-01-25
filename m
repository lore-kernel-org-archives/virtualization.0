From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Wed, 25 Jan 2012 11:35:52 -0500
Message-ID: <20120125163552.GB23999@phenom.dumpdata.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<20120116142014.GA10155@linux.vnet.ibm.com>
	<B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
	<4F146EA5.3010106@linux.vnet.ibm.com>
	<E9F33AFD-F051-4D68-84FF-D259FD6AD19D@suse.de>
	<4F15AF9E.9000907@linux.vnet.ibm.com>
	<1485A122-9D48-46E3-A01E-E37B5C9EC54A@suse.de>
	<4F15BFAE.7060500@linux.vnet.ibm.com>
	<4F1FC370.5020506@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F1FC370.5020506@linux.vnet.ibm.com>
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

On Wed, Jan 25, 2012 at 02:25:12PM +0530, Raghavendra K T wrote:
> On 01/18/2012 12:06 AM, Raghavendra K T wrote:
> >On 01/17/2012 11:09 PM, Alexander Graf wrote:
> [...]
> >>>>>A. pre-3.2.0 with CONFIG_PARAVIRT_SPINLOCKS = n
> >>>>>B. pre-3.2.0 + Jeremy's above patches with
> >>>>>CONFIG_PARAVIRT_SPINLOCKS = n
> >>>>>C. pre-3.2.0 + Jeremy's above patches with
> >>>>>CONFIG_PARAVIRT_SPINLOCKS = y
> >>>>>D. pre-3.2.0 + Jeremy's above patches + V5 patches with
> >>>>>CONFIG_PARAVIRT_SPINLOCKS = n
> >>>>>E. pre-3.2.0 + Jeremy's above patches + V5 patches with
> >>>>>CONFIG_PARAVIRT_SPINLOCKS = y
> [...]
> >>Maybe it'd be a good idea to create a small in-kernel microbenchmark
> >>with a couple threads that take spinlocks, then do work for a
> >>specified number of cycles, then release them again and start anew. At
> >>the end of it, we can check how long the whole thing took for n runs.
> >>That would enable us to measure the worst case scenario.
> >>
> >
> >It was a quick test. two iteration of kernbench (=6runs) and had ensured
> >cache is cleared.
> >
> >echo "1" > /proc/sys/vm/drop_caches
> >ccache -C. Yes may be I can run test as you mentioned..
> >
> 
> Sorry for late reply. Was trying to do more performance analysis.
> Measured the worst case scenario with a spinlock stress driver
> [ attached below ]. I think S1 (below) is what you were
> looking for:
> 
> 2 types of scenarios:
> S1.
> lock()
> increment counter.
> unlock()
> 
> S2:
> do_somework()
> lock()
> do_conditional_work() /* this is to give variable spinlock hold time */
> unlock()
> 
> Setup:
> Machine : IBM xSeries with Intel(R) Xeon(R) x5570 2.93GHz CPU with 8
> core , 64GB RAM, 16 online cpus.
> The below results are taken across total 18 Runs of
> insmod spinlock_thread.ko nr_spinlock_threads=4 loop_count=4000000
> 
> Results:
> scenario S1: plain counter
> ==========================
>     total Mega cycles taken for completion (std)
> A.  12343.833333      (1254.664021)
> B.  12817.111111      (917.791606)
> C.  13426.555556      (844.882978)
> 
> %improvement w.r.t BASE     -8.77
> 
> scenario S2: counter with variable work inside lock + do_work_outside_lock
> =========================================================================
> A.   25077.888889      (1349.471703)
> B.   24906.777778      (1447.853874)
> C.   21287.000000      (2731.643644)
> 
> %improvement w.r.t BASE      15.12
> 
> So it seems we have worst case overhead of around 8%. But we see
> improvement of at-least 15% once when little more time is spent in
> critical section.

Is this with collecting the histogram information about spinlocks? We found
that if you enable that for production runs it makes them quite slower.
