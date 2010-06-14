From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: potential race in virtio ring?
Date: Mon, 14 Jun 2010 16:59:12 +0300
Message-ID: <20100614135912.GA25015__36703.6030548208$1276524362$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Jiri Pirko <jpirko@redhat.com>, Shirley Ma <xma@us.ibm.com>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!
I was going over the vring code and noticed, that
the ring has this check:

irqreturn_t vring_interrupt(int irq, void *_vq)
{
        struct vring_virtqueue *vq = to_vvq(_vq);
        
        if (!more_used(vq)) {
                pr_debug("virtqueue interrupt with no work for %p\n", vq);
                return IRQ_NONE;


static inline bool more_used(const struct vring_virtqueue *vq)
{               
        return vq->last_used_idx != vq->vring.used->idx;
}               

My concern is that with virtio net, more_used is called
on a CPU different from the one that polls the vq.
This might mean that last_used_idx value might be stale.
Could this lead to a missed interrupt?

Thanks,

-- 
MST
