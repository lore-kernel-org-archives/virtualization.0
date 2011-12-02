From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] virtio: use mandatory barriers for remote processor vdevs
Date: Sat, 03 Dec 2011 10:09:44 +1100
Message-ID: <1322867384.11728.20.camel@pasglop>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1322569886-13055-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-29 at 14:31 +0200, Ohad Ben-Cohen wrote:
> Virtio is using memory barriers to control the ordering of
> references to the vrings on SMP systems. When the guest is compiled
> with SMP support, virtio is only using SMP barriers in order to
> avoid incurring the overhead involved with mandatory barriers.
> 
> Lately, though, virtio is being increasingly used with inter-processor
> communication scenarios too, which involve running two (separate)
> instances of operating systems on two (separate) processors, each of
> which might either be UP or SMP.
> 
> To control the ordering of memory references when the vrings are shared
> between two external processors, we must always use mandatory barriers.
> 
> A trivial, albeit sub-optimal, solution would be to simply revert
> commit d57ed95 "virtio: use smp_XX barriers on SMP". Obviously, though,
> that's going to have a negative impact on performance of SMP-based
> virtualization use cases.

Have you measured the impact of using normal barriers (non-SMP ones)
like we use on normal HW drivers unconditionally ?

IE. If the difference is small enough I'd say just go for it and avoid
the bloat.

Ben.
