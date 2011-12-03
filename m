From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Sat, 03 Dec 2011 15:44:36 +1030
Message-ID: <87hb1iqls3.fsf@rustcorp.com.au>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
	<1322867384.11728.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1322867384.11728.20.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm-kernel@lists.infradead.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 03 Dec 2011 10:09:44 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Tue, 2011-11-29 at 14:31 +0200, Ohad Ben-Cohen wrote:
> > A trivial, albeit sub-optimal, solution would be to simply revert
> > commit d57ed95 "virtio: use smp_XX barriers on SMP". Obviously, though,
> > that's going to have a negative impact on performance of SMP-based
> > virtualization use cases.
> 
> Have you measured the impact of using normal barriers (non-SMP ones)
> like we use on normal HW drivers unconditionally ?
> 
> IE. If the difference is small enough I'd say just go for it and avoid
> the bloat.

Yep.  Plan is:
1) Measure the difference.
2) Difference unmeassurable?  Use normal barriers (ie. revert d57ed95).
3) Difference small?  Revert d57ed95 for 3.2, revisit for 3.3.
4) Difference large?  Runtime switch based on "if you're PCI" for 3.2,
   revisit for 3.3.

Cheers,
Rusty.
