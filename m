From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Tue, 23 Oct 2012 17:14:43 +0200
Message-ID: <20121023151442.GA27478@redhat.com>
References: <1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120906084526.GE17656@redhat.com>
	<87txvahfv3.fsf@rustcorp.com.au>
	<14037987.hiN6MSGY6z@tomlt1.ibmoffice.com>
	<87bohbdb0o.fsf@rustcorp.com.au> <5050679F.9030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5050679F.9030002@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Thomas Lendacky <tahm@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 12, 2012 at 12:44:47PM +0200, Sasha Levin wrote:
> On 09/12/2012 08:13 AM, Rusty Russell wrote:
> > The real question is now whether we'd want a separate indirect cache for
> > the 3 case (so num above should be a bitmap?), or reuse the same one, or
> > not use it at all?
> > 
> > Benchmarking will tell...
> 
> Since there are no specific decisions about actual values, I'll just modify the
> code to use cache per-vq instead of per-device.
> 
> 
> Thanks,
> Sasha

One wonders whether we can still use the slab caches
and improve the locality by aligning the size.
Something like the below - this passed basic testing but
didn't measure performance yet.

    virtio: align size for indirect buffers
    
    Improve locality for indirect buffer allocations
    and avoid false cache sharing by aligning
    allocations to cache line size.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2fc85f2..93e6c3a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -119,7 +119,8 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	unsigned head;
 	int i;
 
-	desc = kmalloc((out + in) * sizeof(struct vring_desc), GFP_ATOMIC);
+	desc = kmalloc(L1_CACHE_ALIGN((out + in) * sizeof(struct vring_desc)),
+		       GFP_ATOMIC);
 	if (!desc)
 		return vq->vring.num;
