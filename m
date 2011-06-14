From: Hannes Reinecke <hare@suse.de>
Subject: Re: virtio scsi host draft specification, v3
Date: Tue, 14 Jun 2011 17:30:24 +0200
Message-ID: <4DF77E90.4080409__41080.4040068344$1308065496$gmane$org@suse.de>
References: <4DEE2B15.4090809@redhat.com> <4DF21447.6090005@suse.de>
	<20110612075140.GB11941@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110612075140.GB11941@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 06/12/2011 09:51 AM, Michael S. Tsirkin wrote:
> On Fri, Jun 10, 2011 at 02:55:35PM +0200, Hannes Reinecke wrote:
>>> Device operation: request queues
>>> --------------------------------
>>>
>>> The driver queues requests to an arbitrary request queue, and they are
>>> used by the device on that same queue.
>>>
>> What about request ordering?
>> If requests are placed on arbitrary queues you'll inevitably run on
>> locking issues to ensure strict request ordering.
>> I would add here:
>>
>> If a device uses more than one queue it is the responsibility of the
>> device to ensure strict request ordering.
>
> Maybe I misunderstand - how can this be the responsibility of
> the device if the device does not get the information about
> the original ordering of the requests?
>
> For example, if the driver is crazy enough to put
> all write requests on one queue and all barriers
> on another one, how is the device supposed to ensure
> ordering?
>
Which is exactly the problem I was referring to.
When using more than one channel the request ordering
_as seen by the initiator_ has to be preserved.

This is quite hard to do from a device's perspective;
it might be able to process the requests _in the order_ they've =

arrived, but it won't be able to figure out the latency of each =

request, ie how it'll take the request to be delivered to the initiator.

What we need to do here is to ensure that virtio will deliver
the requests in-order across all virtqueues. Not sure whether it =

does this already.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
