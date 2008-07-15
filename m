From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Tue, 15 Jul 2008 11:14:58 +1000
Message-ID: <200807151114.59562.rusty__22679.1499568664$1216088098$gmane$org@rustcorp.com.au>
References: <487B05CE.1050508@jp.fujitsu.com> <487BA152.1070102@goop.org>
	<20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080714212026.GA6705@osiris.boeblingen.de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 15 July 2008 07:20:26 Heiko Carstens wrote:
> On Mon, Jul 14, 2008 at 11:56:18AM -0700, Jeremy Fitzhardinge wrote:
> > Rusty Russell wrote:
> > > On Monday 14 July 2008 21:51:25 Christian Borntraeger wrote:
> > >> Am Montag, 14. Juli 2008 schrieb Hidetoshi Seto:
> > >>> +	/* Wait all others come to life */
> > >>> +	while (cpus_weight(prepared_cpus) != num_online_cpus() - 1) {
> > >>> +		if (time_is_before_jiffies(limit))
> > >>> +			goto timeout;
> > >>> +		cpu_relax();
> > >>> +	}
> > >>> +
> > >>
> > >> Hmm. I think this could become interesting on virtual machines. The
> > >> hypervisor might be to busy to schedule a specific cpu at certain load
> > >> scenarios. This would cause a failure even if the cpu is not really
> > >> locked up. We had similar problems with the soft lockup daemon on
> > >> s390.
> > >
> > > 5 seconds is a fairly long time.  If all else fails we could have a
> > > config option to simply disable this code.
>
> Hmm.. probably a stupid question: but what could happen that a real cpu
> (not virtual) becomes unresponsive so that it won't schedule a
> MAX_RT_PRIO-1 prioritized task for 5 seconds?

Yes.  That's exactly what we're trying to detect.  Currently the entire 
machine will wedge.  With this patch we can often limp along.

Hidetoshi's original problem was a client whose machine had one CPU die, then 
got wedged as the emergency backup tried to load a module.

Along these lines, I found VMWare's relaxed co-scheduling interesting, BTW:
http://communities.vmware.com/docs/DOC-4960

> cpu_relax() translates to a hypervisor yield on s390. Probably makes sense
> if other architectures would do the same.

Yes, I think so too.  Actually, doing a random yield-to-other-VCPU on 
cpu_relax is arguable the right semantic (in Linux it's used for spinning, 
almost exclusively to wait for other cpus).

Cheers,
Rusty.
