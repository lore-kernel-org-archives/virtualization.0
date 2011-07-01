From: Hannes Reinecke <hare@suse.de>
Subject: Re: virtio scsi host draft specification, v3
Date: Fri, 01 Jul 2011 09:14:12 +0200
Message-ID: <4E0D73C4.5090608__48789.6767132499$1309504502$gmane$org@suse.de>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>	<4DF71E28.6070009@suse.de>	<4E0AE36B.9010500@redhat.com>
	<BANLkTik2AXXkWvV23OP1eDdLirP2N0PC3A@mail.gmail.com>
	<4E0D6C08.1040201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E0D6C08.1040201@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/01/2011 08:41 AM, Paolo Bonzini wrote:
> On 06/29/2011 11:39 AM, Stefan Hajnoczi wrote:
>> > > Of course, when doing so we would be lose the ability to
>> freely remap
>> > > LUNs. But then remapping LUNs doesn't gain you much imho.
>> > > Plus you could always use qemu block backend here if you want
>> > > to hide the details.
>> >
>> > And you could always use the QEMU block backend with
>> > scsi-generic if you want to remap LUNs, instead of true
 >> > passthrough via the kernel target.
>>
>> IIUC the in-kernel target always does remapping. It passes through
>> individual LUNs rather than entire targets and you pick LU Numbers to
>> map to the backing storage (which may or may not be a SCSI
>> pass-through device). Nicholas Bellinger can confirm whether this is
>> correct.
>
> But then I don't understand. If you pick LU numbers both with the
> in-kernel target and with QEMU, you do not need to use e.g. WWPNs
> with fiber channel, because we are not passing through the details
> of the transport protocol (one day we might have virtio-fc, but more
> likely not). So the LUNs you use might as well be represented by
> hierarchical LUNs.
>

Actually, the kernel does _not_ do a LUN remapping. It just so =

happens that most storage arrays will present the LUN starting with =

0, so normally you wouldn't notice.

However, some arrays have an array-wide LUN range, so you start =

seeing LUNs at odd places:

[3:0:5:0]    disk    LSI      INF-01-00        0750  /dev/sdw
[3:0:5:7]    disk    LSI      Universal Xport  0750  /dev/sdx

> Using NPIV with KVM would be done by mapping the same virtual N_Port
> ID in the host(s) to the same LU number in the guest. You might
> already do this now with virtio-blk, in fact.
>
The point here is not the mapping. The point is rescanning.

You can map existing NPIV devices already. But you _cannot_ rescan
the host/device whatever _from the guest_ to detect if new devices
are present.
That is the problem I'm trying to describe here.

To be more explicit:
Currently you have to map existing devices directly as individual =

block or scsi devices to the guest.
And rescan within the guest can only be sent to that device, so the =

only information you will get able to gather is if the device itself =

is still present.
You are unable to detect if there are other devices attached to your =

guest which you should connect to.

So we have to have an enclosing instance (ie the equivalent of a =

SCSI target), which is capable of telling us exactly this.

> Put in another way: the virtio-scsi device is itself a SCSI target,
> so yes, there is a single target port identifier in virtio-scsi. But
> this SCSI target just passes requests down to multiple real targets,
> and so will let you do ALUA and all that.
>
Argl. No way. The virtio-scsi device has to map to a single LUN.

I thought I mentioned this already, but I'd better clarify this again:

The SCSI spec itself only deals with LUNs, so anything you'll read =

in there obviously will only handle the interaction between the =

initiator (read: host) and the LUN itself. However, the actual =

command is send via an intermediat target, hence you'll always see =

the reference to the ITL (initiator-target-lun) nexus.
The SCSI spec details discovery of the individual LUNs presented by =

a given target, it does _NOT_ detail the discovery of the targets =

themselves.
That is being delegated to the underlying transport, in most cases =

SAS or FibreChannel.
For the same reason the SCSI spec can afford to disdain any =

reference to path failure, device hot-plugging etc; all of these =

things are being delegated to the transport.

In our context the virtio-scsi device should map to the LUN, and the =

virtio-scsi _host_ backend should map to the target.
The virtio-scsi _guest_ driver will then map to the initiator.

So we should be able to attach more than one device to the backend,
which then will be presented to the initiator.

In the case of NPIV it would make sense to map the virtual SCSI host =

to the backend, so that all devices presented to the virtual SCSI =

host will be presented to the backend, too.
However, when doing so these devices will normally be referenced by =

their original LUN, as these will be presented to the guest via eg =

'REPORT LUNS'.

The above thread now tries to figure out if we should remap those =

LUN numbers or just expose them as they are.
If we decide on remapping, we have to emulate _all_ commands =

referring explicitely to those LUN numbers (persistent reservations, =

anyone?). If we don't, we would expose some hardware detail to the =

guest, but would save us _a lot_ of processing.

I'm all for the latter.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
