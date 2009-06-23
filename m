From: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Tue, 23 Jun 2009 15:58:33 +0200
Message-ID: <200906231558.33794.borntraeger__30595.0097310872$1245765722$gmane$org@de.ibm.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906231355.53557.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906231355.53557.paul@codesourcery.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Paul Brook <paul@codesourcery.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 23 Juni 2009 14:55:52 schrieb Paul Brook:
> > Here are two patches. One implements a virtio-serial device in qemu
> > and the other is the driver for a guest kernel.
>
> So I'll ask again. Why is this separate from virtio-console?

I did some work on virtio-console, since kvm on s390 does not provide any other.
I dont think we should mix two different types of devices into one driver. The 
only thing that these drivers have in common, is the fact that there are two 
virtqueues, piping data (single bytes or larger chunks). So you could make the 
same argument with the first virtio_net driver (the one before GSO) - which is 
obviously wrong. The common part of the transport is already factored out to 
virtio_ring and the transports.

In addition there are two ABIs involved: a userspace ABI (/dev/hvc0) and a 
guest/host ABI for this console. (and virtio was not meant to be a KVM-only 
interface, that we can change all the time). David A. Wheeler's 'SLOCCount' 
gives me 141 lines of code for virtio_console.c. I am quite confident that the 
saving we could achieve by merging these two drivers is not worth the hazzle.

Discussion about merging the console code into this distracts from the main 
problem: To get the interface and functionality right before it becomes an ABI 
(is it /dev/ttyS, network like or is it something completely different?).

Christian
