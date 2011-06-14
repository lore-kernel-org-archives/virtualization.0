From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: virtio scsi host draft specification, v3
Date: Tue, 14 Jun 2011 16:53:46 +0100
Message-ID: <BANLkTimcXuLjhKrhdzRtELvqu9JMHS8vCQ__25523.0141025551$1308066870$gmane$org@mail.gmail.com>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<4DF71E28.6070009@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF71E28.6070009@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 14, 2011 at 9:39 AM, Hannes Reinecke <hare@suse.de> wrote:
> On 06/10/2011 04:35 PM, Paolo Bonzini wrote:
>>>
>>> If requests are placed on arbitrary queues you'll inevitably run on
>>> locking issues to ensure strict request ordering.
>>> I would add here:
>>>
>>> If a device uses more than one queue it is the responsibility of the
>>> device to ensure strict request ordering.
>>
>> Applied with s/device/guest/g.
>>
>>> Please do not rely in bus/target/lun here. These are leftovers from
>>> parallel SCSI and do not have any meaning on modern SCSI
>>> implementation (eg FC or SAS). Rephrase that to
>>>
>>> The lun field is the Logical Unit Number as defined in SAM.
>>
>> Ok.
>>
>>>> =A0 =A0 =A0The status byte is written by the device to be the SCSI sta=
tus
>>>> =A0 =A0 =A0code.
>>>
>>> ?? I doubt that exists. Make that:
>>>
>>> The status byte is written by the device to be the status code as
>>> defined in SAM.
>>
>> Ok.
>>
>>>> =A0 =A0 =A0The response byte is written by the device to be one of the
>>>> =A0 =A0 =A0following:
>>>>
>>>> =A0 =A0 =A0- VIRTIO_SCSI_S_OK when the request was completed and the
>>>> =A0 =A0 =A0status byte
>>>> =A0 =A0 =A0 =A0is filled with a SCSI status code (not necessarily "GOO=
D").
>>>>
>>>> =A0 =A0 =A0- VIRTIO_SCSI_S_UNDERRUN if the content of the CDB requires
>>>> =A0 =A0 =A0transferring
>>>> =A0 =A0 =A0 =A0more data than is available in the data buffers.
>>>>
>>>> =A0 =A0 =A0- VIRTIO_SCSI_S_ABORTED if the request was cancelled due to=
 a
>>>> =A0 =A0 =A0reset
>>>> =A0 =A0 =A0 =A0or another task management function.
>>>>
>>>> =A0 =A0 =A0- VIRTIO_SCSI_S_FAILURE for other host or guest error. In
>>>> =A0 =A0 =A0particular,
>>>> =A0 =A0 =A0 =A0if neither dataout nor datain is empty, and the
>>>> =A0 =A0 =A0 =A0VIRTIO_SCSI_F_INOUT
>>>> =A0 =A0 =A0 =A0feature has not been negotiated, the request will be
>>>> =A0 =A0 =A0 =A0immediately
>>>> =A0 =A0 =A0 =A0returned with a response equal to VIRTIO_SCSI_S_FAILURE.
>>>>
>>> And, of course:
>>>
>>> VIRTIO_SCSI_S_DISCONNECT if the request could not be processed due
>>> to a communication failure (eg device was removed or could not be
>>> reached).
>>
>> Ok.
>>
>>> This specification implies a strict one-to-one mapping between host
>>> and target. IE there is no way of specifying more than one target
>>> per host.
>>
>> Actually no, the intention is to use hierarchical LUNs to support
>> more than one target per host.
>>
> Can't.
>
> Hierarchical LUNs is a target-internal representation.
> The initiator (ie guest OS) should _not_ try to assume anything about the
> internal structure and just use the LUN as an opaque number.
>
> Reason being that the LUN addressing is not unique, and there are several
> choices on how to represent a given LUN.
> So the consensus here is that different LUN numbers represent
> different physical devices, regardless on the (internal) LUN representati=
on.
> Which in turn means we cannot use the LUN number to convey anything else
> than a device identification relative to a target.
>
> Cf SAM-3 paragraph 4.8:
>
> A logical unit number is a field (see 4.9) containing 64 bits that
> identifies the logical unit within a SCSI target device
> when accessed by a SCSI target port.
>
> IE the LUN is dependent on the target, but you cannot make assumptions on
> the target.
>
> Consequently, it's in the hosts' responsibility to figure out the targets=
 in
> the system. After that it invokes the 'scan' function from the SCSI
> midlayer.
> You can't start from a LUN and try to figure out the targets ...
>
> If you want to support more than on target per host you need some sort of
> enumeration/callback which allows the host to figure out
> the number of available targets.
> But in general the targets are referenced by the target port identifier as
> specified in the appropriate standard (eg FC or SAS).
> Sadly, we don't have any standard to fall back on for this.
>
> If, however, we decide to expose some details about the backend, we could=
 be
> using the values from the backend directly.
> EG we could be forwarding the SCSI target port identifier here
> (if backed by real hardware) or creating our own SAS-type
> identifier when backed by qemu block. Then we could just query
> the backend via a new command on the controlq
> (eg 'list target ports') and wouldn't have to worry about any protocol
> specific details here.

I think we want to be able to pass through one or more SCSI targets,
so we probably need a 'list target ports' control command.

Stefan
