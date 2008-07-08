From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 0/4] Paravirtual spinlocks
Date: Tue, 8 Jul 2008 10:29:18 +1000
Message-ID: <200807081029.19242.rusty__12948.7500330017$1215477099$gmane$org@rustcorp.com.au>
References: <20080707190749.299430659@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080707190749.299430659@goop.org>
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
To: virtualization@lists.linux-foundation.org
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Thomas Friebel <thomas.friebel@amd.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 08 July 2008 05:07:49 Jeremy Fitzhardinge wrote:
> At the most recent Xen Summit, Thomas Friebel presented a paper
> ("Preventing Guests from Spinning Around",
> http://xen.org/files/xensummitboston08/LHP.pdf) investigating the
> interactions between spinlocks and virtual machines.  Specifically, he
> looked at what happens when a lock-holding VCPU gets involuntarily
> preempted.

I find it interesting that gang scheduling the guest was not suggested as an 
obvious solution.

Anyway, concept looks fine; lguest's solution is more elegant of course :)

A little disappointing that you can't patch your version inline.

Cheers,
Rusty.
