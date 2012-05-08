From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] virtio_console: link vq to port with a private pointer
	in struct virtqueue
Date: Tue, 08 May 2012 08:43:01 +0200
Message-ID: <4FA8C075.3030101@redhat.com>
References: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
	<87397be80k.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87397be80k.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 08/05/2012 04:11, Rusty Russell ha scritto:
>> > For virtio-scsi multiqueue support I would like to have an easy and
>> > fast way to go from a virtqueue to the internal struct for that
>> > queue.
>> > 
>> > It turns out that virtio-serial has the same need, but it gets
>> > by with a simple list walk.
>> > 
>> > This patch adds a pointer to struct virtqueue that is reserved for
>> > the virtio device, and uses it in virtio-serial.
> I ike the concept, but share Michael's concern with naming confusion.
> 
> How bad would be it to get rid of the current ->priv and use
> container_of() instead?  ie. have virtio_pci, virtio_mmio, lguest_bus
> and s390's kvm_virtio embed the struct virtqueue?

How bad is not the question, it would actually be pretty good... the
question is more how hard! :)

lguest and s390 are a bit different from the others because ->priv
points into a memory-mapped descriptor provided by the host; PCI and
MMIO have lots of similarities.

Looks doable...

Paolo
