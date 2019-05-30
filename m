From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] vsock/virtio: fix locking around 'the_virtio_vsock'
Date: Wed, 29 May 2019 21:28:52 -0700 (PDT)
Message-ID: <20190529.212852.1077585415381753122.davem__49032.567515836$1559191067$gmane$org@davemloft.net>
References: <20190528105623.27983-1-sgarzare@redhat.com>
	<20190528105623.27983-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190528105623.27983-2-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sgarzare@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 28 May 2019 12:56:20 +0200

> @@ -68,7 +68,13 @@ struct virtio_vsock {
>  
>  static struct virtio_vsock *virtio_vsock_get(void)
>  {
> -	return the_virtio_vsock;
> +	struct virtio_vsock *vsock;
> +
> +	mutex_lock(&the_virtio_vsock_mutex);
> +	vsock = the_virtio_vsock;
> +	mutex_unlock(&the_virtio_vsock_mutex);
> +
> +	return vsock;

This doesn't do anything as far as I can tell.

No matter what, you will either get the value before it's changed or
after it's changed.

Since you should never publish the pointer by assigning it until the
object is fully initialized, this can never be a problem even without
the mutex being there.

Even if you sampled the the_virtio_sock value right before it's being
set to NULL by the remove function, that still can happen with the
mutex held too.

This function is also terribly named btw, it implies that a reference
count is being taken.  But that's not what this function does, it
just returns the pointer value as-is.
