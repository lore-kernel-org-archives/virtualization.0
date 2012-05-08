From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH] virtio_console: link vq to port with a private
	pointer in struct virtqueue
Date: Tue, 08 May 2012 11:41:55 +0930
Message-ID: <87397be80k.fsf@rustcorp.com.au>
References: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 18 Apr 2012 15:33:33 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
> For virtio-scsi multiqueue support I would like to have an easy and
> fast way to go from a virtqueue to the internal struct for that
> queue.
> 
> It turns out that virtio-serial has the same need, but it gets
> by with a simple list walk.
> 
> This patch adds a pointer to struct virtqueue that is reserved for
> the virtio device, and uses it in virtio-serial.

I ike the concept, but share Michael's concern with naming confusion.

How bad would be it to get rid of the current ->priv and use
container_of() instead?  ie. have virtio_pci, virtio_mmio, lguest_bus
and s390's kvm_virtio embed the struct virtqueue?

Thanks,
Rusty.
