From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Thu, 9 Feb 2017 16:48:53 +0100
Message-ID: <cc075b18-0913-ef89-96a8-a29869abd73e@redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com>
	<20170208214435-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170208214435-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 08/02/2017 20:59, Michael S. Tsirkin wrote:
> We couldn't decide what's better for everyone in 1.0 days and I doubt
> we'll be able to now, but yes, benchmarking is needed to make
> sire it's required. Very easy to remove or not to use/support in
> drivers/devices though.

Fair enough, but of course then we must specify that devices MUST
support either VRING_DESC_F_NEXT or VRING_DESC_F_INDIRECT, and drivers
SHOULD support both (or use neither).

The drivers' part adds to the implementation burden, which is why I
wanted to remove it.  Alternatively we can say that indirect is
mandatory for both devices and drivers (and save a feature bit), while
VRING_DESC_F_NEXT is optional.

>>> * Non power-of-2 ring sizes
>>>
>>> As the ring simply wraps around, there's no reason to
>>> require ring size to be power of two.
>>> It can be made a separate feature though.
>>
>> Power of 2 ring sizes are required in order to ignore the high bits of
>> the indices.  With non-power-of-2 sizes you are forced to keep the
>> indices less than the ring size.
> 
> Right. So
> 
> 	if (unlikely(idx++ > size))
> 		idx = 0;
> 
> OTOH ring size that's twice larger than necessary
> because of power of two requirements wastes cache.

I don't know.  Power of 2 ring size is pretty standard, I'd rather avoid
the complication and the gratuitous difference with 1.0.

If batching is mostly advisory (with exceptions such as mrg-rxbuf) I
don't have any problem with it.

Paolo
