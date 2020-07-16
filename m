From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Interesting qemu/virt-manager bug about the "rotational"
 attribute on virtio-blk disks
Date: Thu, 16 Jul 2020 11:33:44 +0200
Message-ID: <20200716093344.7molwklwco4sdtvs@steredhat>
References: <20200716080614.GA18456@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200716080614.GA18456@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-discuss@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

+Cc Michael, Stefan, virtualization@lists.linux-foundation.org

On Thu, Jul 16, 2020 at 09:06:14AM +0100, Richard W.M. Jones wrote:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1857515
> 
> A virtio-blk disk which is backed by a raw file on an SSD,
> inside the guest shows rotational = 1.
> 
> I assumed that qemu must have a "rotational" property for disks and
> this would be communicated by virtio to the guest, but qemu and virtio
> don't seem to have this.  Pretty surprising!  Is it called something
> other than "rotational"?
> 

I'm not sure if we need to add this property in QEMU, but in Linux
I found these flags (include/linux/blkdev.h) for the block queues:

    #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
    #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */

xen-blkfront driver is the only one that sets the QUEUE_FLAG_VIRT,
should we do the same in the virtio-blk driver regardless of the backend?

Thanks,
Stefano
