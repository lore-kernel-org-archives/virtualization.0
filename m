From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Sun, 19 Jun 2011 10:14:52 +0300
Message-ID: <20110619071452.GA7930@redhat.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 23, 2010 at 10:24:02PM +0100, Stefan Hajnoczi wrote:
> The virtio block device holds a lock during I/O request processing.
> Kicking the virtqueue while the lock is held results in long lock hold
> times and increases contention for the lock.
> 
> This patch modifies virtqueue_kick() to optionally release a lock while
> notifying the host.  Virtio block is modified to pass in its lock.  This
> allows other vcpus to queue I/O requests during the time spent servicing
> the virtqueue notify in the host.
> 
> The virtqueue_kick() function is modified to know about locking because
> it changes the state of the virtqueue and should execute with the lock
> held (it would not be correct for virtio block to release the lock
> before calling virtqueue_kick()).
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

While the optimization makes sense, the API's pretty hairy IMHO.
Why don't we split the kick functionality instead?
E.g.
	/* Report whether host notification is necessary. */
	bool virtqueue_kick_prepare(struct virtqueue *vq)
	/* Can be done in parallel with add_buf/get_buf */
	void virtqueue_kick_notify(struct virtqueue *vq)

And users can
	
	r = virtqueue_kick_prepare(vq);
	spin_unlock_irqrestore(...);
	if (r)
		virtqueue_kick_notify(struct virtqueue *vq)

-- 
MST
