From: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Tue, 23 Jun 2009 16:40:30 +0200
Message-ID: <200906231640.30915.borntraeger__2116.26449968225$1245768252$gmane$org@de.ibm.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906231558.33794.borntraeger@de.ibm.com>
	<200906231516.15470.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906231516.15470.paul@codesourcery.com>
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
To: Paul Brook <paul@codesourcery.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 23 Juni 2009 16:16:13 schrieb Paul Brook:
> > I did some work on virtio-console, since kvm on s390 does not provide any
> > other. I dont think we should mix two different types of devices into one
> > driver. The only thing that these drivers have in common, is the fact
> > that there are two virtqueues, piping data (single bytes or larger
> > chunks). So you could make the same argument with the first virtio_net
> > driver (the one before GSO) - which is obviously wrong. The common part
> > of the transport is already factored out to virtio_ring and the
> > transports.
>
> virtio-net is packet based, not stream based.

You can argue that virtio-console is also packet based. The input buffer can 
accept up to 4K in one buffer and the console code can also submit larger chunks 
to virtio_console.

> > In addition there are two ABIs involved: a userspace ABI (/dev/hvc0) and
> > a guest/host ABI for this console. (and virtio was not meant to be a
> > KVM-only interface, that we can change all the time). David A. Wheeler's
> > 'SLOCCount' gives me 141 lines of code for virtio_console.c. I am quite
> > confident that the saving we could achieve by merging these two drivers
> > is not worth the hazzle.
>
> AFAICS the functionality provided is exactly the same. The host API is
> identical, and the guest userspace API only has trivial differences (which
> could be eliminated with a simple udev rule). By my reading virtio-serial
> makes virtio-console entirely redundant.

How can you know, that the userspace API only has trivial differences, if the 
question below is not answered?

> > Discussion about merging the console code into this distracts from the
> > main problem: To get the interface and functionality right before it
> > becomes an ABI (is it /dev/ttyS, network like or is it something
> > completely different?).
>
> Ah, now that's a different question. I don't know what the requirements are
> for the higher level vmchannel interface. However I also don't care.

You should care, because it might have an impact if two serial lines are really 
the right solution for the vmchannel.

One thing that I forgot:
You should be warned that hvc_console sometimes can be a real PITA. A while ago 
I tried to change virtio_console to support more than one console and hotplug 
and failed to find a proper solution that can handle all the subtle  console/tty 
register/unregister combinations. You dont want to adopt new code to fit to 
hvc_console - leave it in virtio_console...
