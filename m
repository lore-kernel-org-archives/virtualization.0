From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] virtio-serial: A guest <-> host interface for simple
	communication
Date: Tue, 23 Jun 2009 15:16:13 +0100
Message-ID: <200906231516.15470.paul__5026.27526079795$1245767009$gmane$org@codesourcery.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906231355.53557.paul@codesourcery.com>
	<200906231558.33794.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906231558.33794.borntraeger@de.ibm.com>
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
To: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 23 June 2009, Christian Borntr=E4ger wrote:
> Am Dienstag 23 Juni 2009 14:55:52 schrieb Paul Brook:
> > > Here are two patches. One implements a virtio-serial device in qemu
> > > and the other is the driver for a guest kernel.
> >
> > So I'll ask again. Why is this separate from virtio-console?
>
> I did some work on virtio-console, since kvm on s390 does not provide any
> other. I dont think we should mix two different types of devices into one
> driver. The only thing that these drivers have in common, is the fact that
> there are two virtqueues, piping data (single bytes or larger chunks). So
> you could make the same argument with the first virtio_net driver (the one
> before GSO) - which is obviously wrong. The common part of the transport =
is
> already factored out to virtio_ring and the transports.

virtio-net is packet based, not stream based.

> In addition there are two ABIs involved: a userspace ABI (/dev/hvc0) and a
> guest/host ABI for this console. (and virtio was not meant to be a KVM-on=
ly
> interface, that we can change all the time). David A. Wheeler's 'SLOCCoun=
t'
> gives me 141 lines of code for virtio_console.c. I am quite confident that
> the saving we could achieve by merging these two drivers is not worth the
> hazzle.

AFAICS the functionality provided is exactly the same. The host API is =

identical, and the guest userspace API only has trivial differences (which =

could be eliminated with a simple udev rule). By my reading virtio-serial =

makes virtio-console entirely redundant.

> Discussion about merging the console code into this distracts from the ma=
in
> problem: To get the interface and functionality right before it becomes an
> ABI (is it /dev/ttyS, network like or is it something completely
> different?).

Ah, now that's a different question. I don't know what the requirements are =

for the higher level vmchannel interface. However I also don't care.

Paul
