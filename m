From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 2/5] vsock/virtio: fix locking for fwd_cnt and buf_alloc
Date: Sun, 02 Jun 2019 18:03:34 -0700 (PDT)
Message-ID: <20190602.180334.1932703293092139564.davem__17280.9755824105$1559523826$gmane$org@davemloft.net>
References: <20190531133954.122567-1-sgarzare@redhat.com>
	<20190531133954.122567-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190531133954.122567-3-sgarzare@redhat.com>
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
Date: Fri, 31 May 2019 15:39:51 +0200

> @@ -434,7 +434,9 @@ void virtio_transport_set_buffer_size(struct vsock_sock *vsk, u64 val)
>  	if (val > vvs->buf_size_max)
>  		vvs->buf_size_max = val;
>  	vvs->buf_size = val;
> +	spin_lock_bh(&vvs->rx_lock);
>  	vvs->buf_alloc = val;
> +	spin_unlock_bh(&vvs->rx_lock);

This locking doesn't do anything other than to strongly order the
buf_size store to occur before the buf_alloc one.

If you need a memory barrier, use one.
