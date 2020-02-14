From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Date: Fri, 14 Feb 2020 08:33:49 +0100
Message-ID: <e11ba53c-a5fa-0518-2e06-9296897ed529@de.ibm.com>
References: <20200107042401-mutt-send-email-mst@kernel.org>
 <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
 <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
 <20200206171349-mutt-send-email-mst@kernel.org>
 <5c860fa1-cef5-b389-4ebf-99a62afa0fe8@de.ibm.com>
 <20200207025806-mutt-send-email-mst@kernel.org>
 <97c93d38-ef07-e321-d133-18483d54c0c0@de.ibm.com>
 <CAJaqyWfngzP4d01B6+Sqt8FXN6jX7kGegjx8ie4no_1Er3igQA@mail.gmail.com>
 <43a5dbaa-9129-e220-8483-45c60a82c945@de.ibm.com>
 <e299afca8e22044916abbf9fbbd0bff6b0ee9e13.camel@redhat.com>
 <4c3f70b7-723a-8b0f-ac49-babef1bcc180@de.ibm.com>
 <50a79c3491ac483583c97df2fac29e2c3248fdea.camel@redhat.com>
 <8fbbfb49-99d1-7fee-e713-d6d5790fe866@de.ibm.com>
 <2364d0728c3bb4bcc0c13b591f774109a9274a30.camel@redhat.com>
 <bb9fb726-306c-5330-05aa-a86bd1b18097@de.ibm.com>
 <468983fad50a5e74a739f71487f0ea11e8d4dfd1.camel@redhat.com>
 <2dc1df65-1431-3917-40e5-c2b12096e2a7@de.ibm.com>
 <bd9c9b4d99abd20d5420583af5a4954ea1cf4618.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <bd9c9b4d99abd20d5420583af5a4954ea1cf4618.camel@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

I did 
ping -c 20 -f ... ; reboot 
twice

The ping after the first reboot showed .......E 

this was on the host console

[   55.951885] CPU: 34 PID: 1908 Comm: CPU 0/KVM Not tainted 5.5.0+ #21
[   55.951891] Hardware name: IBM 3906 M04 704 (LPAR)
[   55.951892] Call Trace:
[   55.951902]  [<0000001ede114132>] show_stack+0x8a/0xd0 
[   55.951906]  [<0000001edeb0672a>] dump_stack+0x8a/0xb8 
[   55.951915]  [<000003ff803736a6>] vhost_vring_ioctl+0x6fe/0x858 [vhost] 
[   55.951919]  [<000003ff8042a608>] vhost_net_ioctl+0x510/0x570 [vhost_net] 
[   55.951924]  [<0000001ede3c4dd8>] do_vfs_ioctl+0x430/0x6f8 
[   55.951926]  [<0000001ede3c5124>] ksys_ioctl+0x84/0xb0 
[   55.951927]  [<0000001ede3c51ba>] __s390x_sys_ioctl+0x2a/0x38 
[   55.951931]  [<0000001edeb27f72>] system_call+0x2a6/0x2c8 
[   55.951949] CPU: 34 PID: 1908 Comm: CPU 0/KVM Not tainted 5.5.0+ #21
[   55.951950] Hardware name: IBM 3906 M04 704 (LPAR)
[   55.951951] Call Trace:
[   55.951952]  [<0000001ede114132>] show_stack+0x8a/0xd0 
[   55.951954]  [<0000001edeb0672a>] dump_stack+0x8a/0xb8 
[   55.951956]  [<000003ff803736a6>] vhost_vring_ioctl+0x6fe/0x858 [vhost] 
[   55.951958]  [<000003ff8042a608>] vhost_net_ioctl+0x510/0x570 [vhost_net] 
[   55.951959]  [<0000001ede3c4dd8>] do_vfs_ioctl+0x430/0x6f8 
[   55.951961]  [<0000001ede3c5124>] ksys_ioctl+0x84/0xb0 
[   55.951962]  [<0000001ede3c51ba>] __s390x_sys_ioctl+0x2a/0x38 
[   55.951964]  [<0000001edeb27f72>] system_call+0x2a6/0x2c8 
[   55.951997] Guest moved vq 0000000063d896c6 used index from 44 to 0
[   56.609831] unexpected descriptor format for RX: out 0, in 0
[   86.540460] CPU: 6 PID: 1908 Comm: CPU 0/KVM Not tainted 5.5.0+ #21
[   86.540464] Hardware name: IBM 3906 M04 704 (LPAR)
[   86.540466] Call Trace:
[   86.540473]  [<0000001ede114132>] show_stack+0x8a/0xd0 
[   86.540477]  [<0000001edeb0672a>] dump_stack+0x8a/0xb8 
[   86.540486]  [<000003ff803736a6>] vhost_vring_ioctl+0x6fe/0x858 [vhost] 
[   86.540490]  [<000003ff8042a608>] vhost_net_ioctl+0x510/0x570 [vhost_net] 
[   86.540494]  [<0000001ede3c4dd8>] do_vfs_ioctl+0x430/0x6f8 
[   86.540496]  [<0000001ede3c5124>] ksys_ioctl+0x84/0xb0 
[   86.540498]  [<0000001ede3c51ba>] __s390x_sys_ioctl+0x2a/0x38 
[   86.540501]  [<0000001edeb27f72>] system_call+0x2a6/0x2c8 
[   86.540524] CPU: 6 PID: 1908 Comm: CPU 0/KVM Not tainted 5.5.0+ #21
[   86.540525] Hardware name: IBM 3906 M04 704 (LPAR)
[   86.540526] Call Trace:
[   86.540527]  [<0000001ede114132>] show_stack+0x8a/0xd0 
[   86.540528]  [<0000001edeb0672a>] dump_stack+0x8a/0xb8 
[   86.540531]  [<000003ff803736a6>] vhost_vring_ioctl+0x6fe/0x858 [vhost] 
[   86.540532]  [<000003ff8042a608>] vhost_net_ioctl+0x510/0x570 [vhost_net] 
[   86.540534]  [<0000001ede3c4dd8>] do_vfs_ioctl+0x430/0x6f8 
[   86.540536]  [<0000001ede3c5124>] ksys_ioctl+0x84/0xb0 
[   86.540537]  [<0000001ede3c51ba>] __s390x_sys_ioctl+0x2a/0x38 
[   86.540538]  [<0000001edeb27f72>] system_call+0x2a6/0x2c8 
[   86.540570] unexpected descriptor format for RX: out 0, in 0
[   86.540577] Unexpected header len for TX: 0 expected 0


On 14.02.20 08:06, Eugenio Pérez wrote:
> Hi Christian.
> 
> Sorry, that was meant to be applied over previous debug patch.
> 
> Here I inline the one meant to be applied over eccb852f1fe6bede630e2e4f1a121a81e34354ab.
> 
> Thanks!
> 
> From d978ace99e4844b49b794d768385db3d128a4cc0 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
> Date: Fri, 14 Feb 2020 08:02:26 +0100
> Subject: [PATCH] vhost: disable all features and trace last_avail_idx and
>  ioctl calls
> 
> ---
>  drivers/vhost/net.c   | 20 +++++++++++++++++---
>  drivers/vhost/vhost.c | 25 +++++++++++++++++++++++--
>  drivers/vhost/vhost.h | 10 +++++-----
>  3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index e158159671fa..e4d5f843f9c0 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1505,10 +1505,13 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  
>  	mutex_lock(&n->dev.mutex);
>  	r = vhost_dev_check_owner(&n->dev);
> -	if (r)
> +	if (r) {
> +		pr_debug("vhost_dev_check_owner index=%u fd=%d rc r=%d", index, fd, r);
>  		goto err;
> +	}
>  
>  	if (index >= VHOST_NET_VQ_MAX) {
> +		pr_debug("vhost_dev_check_owner index=%u fd=%d MAX=%d", index, fd, VHOST_NET_VQ_MAX);
>  		r = -ENOBUFS;
>  		goto err;
>  	}
> @@ -1518,22 +1521,26 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  
>  	/* Verify that ring has been setup correctly. */
>  	if (!vhost_vq_access_ok(vq)) {
> +		pr_debug("vhost_net_set_backend index=%u fd=%d !vhost_vq_access_ok", index, fd);
>  		r = -EFAULT;
>  		goto err_vq;
>  	}
>  	sock = get_socket(fd);
>  	if (IS_ERR(sock)) {
>  		r = PTR_ERR(sock);
> +		pr_debug("vhost_net_set_backend index=%u fd=%d get_socket err r=%d", index, fd, r);
>  		goto err_vq;
>  	}
>  
>  	/* start polling new socket */
>  	oldsock = vq->private_data;
>  	if (sock != oldsock) {
> +		pr_debug("sock=%p != oldsock=%p index=%u fd=%d vq=%p", sock, oldsock, index, fd, vq);
>  		ubufs = vhost_net_ubuf_alloc(vq,
>  					     sock && vhost_sock_zcopy(sock));
>  		if (IS_ERR(ubufs)) {
>  			r = PTR_ERR(ubufs);
> +			pr_debug("ubufs index=%u fd=%d err r=%d vq=%p", index, fd, r, vq);
>  			goto err_ubufs;
>  		}
>  
> @@ -1541,11 +1548,15 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  		vq->private_data = sock;
>  		vhost_net_buf_unproduce(nvq);
>  		r = vhost_vq_init_access(vq);
> -		if (r)
> +		if (r) {
> +			pr_debug("init_access index=%u fd=%d r=%d vq=%p", index, fd, r, vq);
>  			goto err_used;
> +		}
>  		r = vhost_net_enable_vq(n, vq);
> -		if (r)
> +		if (r) {
> +			pr_debug("enable_vq index=%u fd=%d r=%d vq=%p", index, fd, r, vq);
>  			goto err_used;
> +		}
>  		if (index == VHOST_NET_VQ_RX)
>  			nvq->rx_ring = get_tap_ptr_ring(fd);
>  
> @@ -1559,6 +1570,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  
>  	mutex_unlock(&vq->mutex);
>  
> +	pr_debug("sock=%p", sock);
> +
>  	if (oldubufs) {
>  		vhost_net_ubuf_put_wait_and_free(oldubufs);
>  		mutex_lock(&vq->mutex);
> @@ -1710,6 +1723,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  
>  	switch (ioctl) {
>  	case VHOST_NET_SET_BACKEND:
> +		pr_debug("VHOST_NET_SET_BACKEND");
>  		if (copy_from_user(&backend, argp, sizeof backend))
>  			return -EFAULT;
>  		return vhost_net_set_backend(n, backend.index, backend.fd);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b5a51b1f2e79..ec25ba32fe81 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1642,15 +1642,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  			r = -EINVAL;
>  			break;
>  		}
> +
> +		if (vq->last_avail_idx || vq->avail_idx) {
> +			pr_debug(
> +				"strange VHOST_SET_VRING_BASE [vq=%p][s.index=%u][s.num=%u]",
> +				vq, s.index, s.num);
> +			dump_stack();
> +			r = 0;
> +			break;
> +		}
>  		vq->last_avail_idx = s.num;
>  		/* Forget the cached index value. */
>  		vq->avail_idx = vq->last_avail_idx;
> +		pr_debug(
> +			"VHOST_SET_VRING_BASE [vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][s.index=%u][s.num=%u]",
> +			vq, vq->last_avail_idx, vq->avail_idx, s.index, s.num);
>  		break;
>  	case VHOST_GET_VRING_BASE:
>  		s.index = idx;
>  		s.num = vq->last_avail_idx;
>  		if (copy_to_user(argp, &s, sizeof s))
>  			r = -EFAULT;
> +		pr_debug(
> +			"VHOST_GET_VRING_BASE [vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][s.index=%u][s.num=%u]",
> +			vq, vq->last_avail_idx, vq->avail_idx, s.index, s.num);
>  		break;
>  	case VHOST_SET_VRING_KICK:
>  		if (copy_from_user(&f, argp, sizeof f)) {
> @@ -2239,8 +2254,8 @@ static int fetch_buf(struct vhost_virtqueue *vq)
>  		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
>  		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
> -			vq_err(vq, "Guest moved used index from %u to %u",
> -				last_avail_idx, vq->avail_idx);
> +			vq_err(vq, "Guest moved vq %p used index from %u to %u",
> +				vq, last_avail_idx, vq->avail_idx);
>  			return -EFAULT;
>  		}
>  
> @@ -2316,6 +2331,9 @@ static int fetch_buf(struct vhost_virtqueue *vq)
>  	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
>  
>  	/* On success, increment avail index. */
> +	pr_debug(
> +		"[vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][vq->ndescs=%d][vq->first_desc=%d]",
> +		vq, vq->last_avail_idx, vq->avail_idx, vq->ndescs, vq->first_desc);
>  	vq->last_avail_idx++;
>  
>  	return 0;
> @@ -2432,6 +2450,9 @@ EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
>  /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
>  void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
>  {
> +	pr_debug(
> +		"DISCARD [vq=%p][vq->last_avail_idx=%u][vq->avail_idx=%u][n=%d]",
> +		vq, vq->last_avail_idx, vq->avail_idx, n);
>  	vq->last_avail_idx -= n;
>  }
>  EXPORT_SYMBOL_GPL(vhost_discard_vq_desc);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 661088ae6dc7..08f6d2ccb697 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -250,11 +250,11 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled);
>  	} while (0)
>  
>  enum {
> -	VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
> -			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
> -			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
> -			 (1ULL << VHOST_F_LOG_ALL) |
> -			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
> +	VHOST_FEATURES = /* (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) | */
> +			 /* (1ULL << VIRTIO_RING_F_INDIRECT_DESC) | */
> +			 /* (1ULL << VIRTIO_RING_F_EVENT_IDX) | */
> +			 /* (1ULL << VHOST_F_LOG_ALL) | */
> +			 /* (1ULL << VIRTIO_F_ANY_LAYOUT) | */
>  			 (1ULL << VIRTIO_F_VERSION_1)
>  };
>  
> 
