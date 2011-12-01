From: Hannes Reinecke <hare@suse.de>
Subject: Re: virtio-scsi spec (was Re: [PATCH] Add virtio-scsi to the virtio
	spec)
Date: Thu, 01 Dec 2011 10:52:20 +0100
Message-ID: <4ED74E54.3070303@suse.de>
References: <1322661042-28191-1-git-send-email-pbonzini@redhat.com>
	<1322661042-28191-2-git-send-email-pbonzini@redhat.com>
	<4ED63AE1.8090105@suse.de> <4ED65BA4.3000003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4ED65BA4.3000003@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi <linux-scsi@redhat.com>, virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/30/2011 05:36 PM, Paolo Bonzini wrote:
> On 11/30/2011 03:17 PM, Hannes Reinecke wrote:
>>> seg_max is the maximum number of segments that can be in a
>>> command. A bidirectional command can include seg_max input
>>> segments and seg_max output segments.
>>>
>> I would like to have the other request_queue limitations exposed
>> here, too.
>> Most notably we're missing the maximum size of an individual segment
>> and the maximum size of the overall I/O request.
>
> The virtio transport does not put any limit, as far as I know.
>
Virtio doesn't, but the underlying device/driver might.
And if we don't expose these values we cannot format the request correctly.

>> As this is the host specification I really would like to see an host
>> identifier somewhere in there.
>> Otherwise we won't be able to reliably identify a virtio SCSI host.
>
> I thought about it, but I couldn't figure out exactly how to use it. If
> it's just allocating 64 bits in the configuration space (with the
> stipulation that they could be zero), let's do it now. Otherwise a
> controlq command is indeed better, and it can come later.
>
> But even if it's just a 64-bit value, then: 1) where would you place it
> in sysfs for userspace? I can make up a random name, but existing user
> tools won't find it and that's against the design of virtio-scsi. 2) How
> would it be encoded as a transport ID? Is it FC, or firewire, or SAS, or
> what?
>
I was thinking of something along the lines of the TransportID as =

defined in SPC.
Main idea is to have a unique ID by which we can identify a given =

virtio-scsi host. Admittedly it might not be useful in general, so it =

might be an idea to delegate this to another controlq command.

>> Plus you can't calculate the ITL nexus information, making
>> Persistent Reservations impossible.
>
> They are not impossible, only some features such as SPEC_I_PT. If you
> use NPIV or iSCSI in the host, then the persistent reservations will
> already get the correct initiator port. If not, much more work is needed.
>
Yes, for a a shared (physical) SCSI host persistent reservations will be =

tricky.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
