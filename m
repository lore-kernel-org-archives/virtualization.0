From: Hannes Reinecke <hare@suse.de>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 12:23:38 +0200
Message-ID: <4E0AFD2A.80102__6992.02157925374$1309343059$gmane$org@suse.de>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<4DF71E28.6070009@suse.de> <4E0AE36B.9010500@redhat.com>
	<BANLkTik2AXXkWvV23OP1eDdLirP2N0PC3A@mail.gmail.com>
	<20110629100752.GA27744@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110629100752.GA27744@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/29/2011 12:07 PM, Christoph Hellwig wrote:
> On Wed, Jun 29, 2011 at 10:39:42AM +0100, Stefan Hajnoczi wrote:
>> I think we're missing a level of addressing.  We need the ability to
>> talk to multiple target ports in order for "list target ports" to make
>> sense.  Right now there is one implicit target that handles all
>> commands.  That means there is one fixed I_T Nexus.
>>
>> If we introduce "list target ports" we also need a way to say "This
>> CDB is destined for target port #0".  Then it is possible to enumerate
>> target ports and address targets independently of the LUN field in the
>> CDB.
>>
>> I'm pretty sure this is also how SAS and other transports work.  In
>> their framing they include the target port.
>
> Yes, exactly.  Hierachial LUNs are a nasty fringe feature that we should
> avoid as much as possible, that is for everything but IBM vSCSI which is
> braindead enough to force them.
>
Yep.

>> The question is whether we really need to support multiple targets on
>> a virtio-scsi adapter or not.  If you are selectively mapping LUNs
>> that the guest may access, then multiple targets are not necessary.
>> If we want to do pass-through of the entire SCSI bus then we need
>> multiple targets but I'm not sure if there are other challenges like
>> dependencies on the transport (Fibre Channel, SAS, etc) which make it
>> impossible to pass through bus-level access?
>
> I don't think bus-level pass through is either easily possible nor
> desirable.  What multiple targets are useful for is allowing more
> virtual disks than we have virtual PCI slots.  We could do this by
> supporting multiple LUNs, but given that many SCSI ressources are
> target-based doing multiple targets most likely is the more scabale
> and more logical variant.  E.g. we could much more easily have one
> virtqueue per target than per LUN.
>
The general idea here is that we can support NPIV.
With NPIV we'll have several scsi_hosts, each of which is assigned a =

different set of LUNs by the array.
With virtio we need to able to react on LUN remapping on the array =

side, ie we need to be able to issue a 'REPORT LUNS' command and =

add/remove LUNs on the fly. This means we have to expose the =

scsi_host in some way via virtio.

This is impossible with a one-to-one mapping between targets and =

LUNs. The actual bus-level pass-through will be just on the SCSI =

layer, ie 'REPORT LUNS' should be possible. If and how we do a LUN =

remapping internally on the host is a totally different matter.
Same goes for the transport details; I doubt we will expose all the =

dingy details of the various transports, but rather restrict =

ourselves to an abstract transport.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
