From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/4] vsock/virtio: fix locking around 'the_virtio_vsock'
Date: Thu, 30 May 2019 12:27:40 +0200
Message-ID: <20190530102740.nyg6akggvy2asikt__19933.6918348976$1559212635$gmane$org@steredhat.homenet.telecomitalia.it>
References: <20190528105623.27983-1-sgarzare@redhat.com>
	<20190528105623.27983-2-sgarzare@redhat.com>
	<20190529.212852.1077585415381753122.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190529.212852.1077585415381753122.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2019 at 09:28:52PM -0700, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Tue, 28 May 2019 12:56:20 +0200
> 
> > @@ -68,7 +68,13 @@ struct virtio_vsock {
> >  
> >  static struct virtio_vsock *virtio_vsock_get(void)
> >  {
> > -	return the_virtio_vsock;
> > +	struct virtio_vsock *vsock;
> > +
> > +	mutex_lock(&the_virtio_vsock_mutex);
> > +	vsock = the_virtio_vsock;
> > +	mutex_unlock(&the_virtio_vsock_mutex);
> > +
> > +	return vsock;
> 
> This doesn't do anything as far as I can tell.
> 
> No matter what, you will either get the value before it's changed or
> after it's changed.
> 
> Since you should never publish the pointer by assigning it until the
> object is fully initialized, this can never be a problem even without
> the mutex being there.
> 
> Even if you sampled the the_virtio_sock value right before it's being
> set to NULL by the remove function, that still can happen with the
> mutex held too.

Yes, I found out when I was answering Jason's question [1]. :(

I proposed to use RCU to solve this issue, do you agree?
Let me know if there is a better way.

> 
> This function is also terribly named btw, it implies that a reference
> count is being taken.  But that's not what this function does, it
> just returns the pointer value as-is.

What do you think if I remove the function, using directly the_virtio_vsock?
(should be easier to use with RCU API)

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/20190529105832.oz3sagbne5teq3nt@steredhat
