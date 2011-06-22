From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 00/02][RESEND] virtio: Virtio platform driver
Date: Wed, 22 Jun 2011 11:39:04 +0930
Message-ID: <87oc1q8vnj.fsf__26378.0617541217$1308710696$gmane$org@rustcorp.com.au>
References: <20110621102605.1382.90232.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110621102605.1382.90232.sendpatchset@t400s>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: vapier@gentoo.org, mst@redhat.com, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 21 Jun 2011 19:26:05 +0900, Magnus Damm <magnus.damm@gmail.com> wrote:
> virtio: Virtio platform driver
> 
> [PATCH 01/02] virtio: Break out lguest virtio code to virtio_lguest.c
> [PATCH 02/02] virtio: Add virtio platform driver
> 
> These patches add a virtio platform driver to the Linux kernel. This
> platform driver has the same role as the virtio_pci driver, but instead
> of building on top of emulated PCI this driver is making use of the
> platform bus together with driver specific callbacks.
> 
> The virtio platform driver can be seen as a reusable implementation of
> the lguest virtio driver - in fact, most code is just taken directly
> from lguest_device.c and reworked to fit the platform device driver
> abstraction. The first patch breaks out code that can be shared between
> lguest and the virtio platform driver.
> 
> This code has been used to implement a mailbox interface between the
> two processor cores included in the sh7372 SoC. The sh7372 contains
> one ARM Cortex-A8 and one SH4AL-DSP core, and in the prototype two
> Linux kernels are running in parallel on the same chip. Virtio serves
> as a communication link between the two cores.

OK, this seems pretty neat, but I have three questions before we nail this
down (note that lguest doesn't have an ABI, so we can change it as much
as we want).

1) The lguest bus is dumb, and I never thought about device hotplug, for
   example.  It would be nice to handle that somehow.  Is it possible?
   Is this something you care about?

2) Have you seen the '[RFC 0/8] Introducing a generic AMP/IPC framework'
   patches?  Seems to overlap with what you're doing after these patches.

3) The S/390 layout is identical, except their struct kvm_vqconfig is a
   bit different.  Perhaps we should just use theirs (they use a 64-bit
   token instead of an interrupt number).

Christian?

Thanks,
Rusty.
