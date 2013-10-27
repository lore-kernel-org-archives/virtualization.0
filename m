From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V2 RFC 1/9] virtio_ring: change host notification API
Date: Mon, 28 Oct 2013 09:57:47 +1030
Message-ID: <871u36i9ak.fsf@rustcorp.com.au>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1382628200-42956-2-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-2-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> Currently a host kick error is silently ignored and not reflected in
> the virtqueue of a particular virtio device.
>
> Changing the notify API for guest->host notification seems to be one
> prerequisite in order to be able to handle such errors in the context
> where the kick is triggered.
>
> This patch changes the notify API. The notify function must return a
> negative int return value in case the host notification failed.

I think we need a bool here:

> -	kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, config->address);
> +	rc = kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, config->address);
> +	if (rc < 0)
> +		return rc;
> +	return 0;
>  }

I have no idea what this hypercall returns on failure...

> -static void virtio_ccw_kvm_notify(struct virtqueue *vq)
> +static int virtio_ccw_kvm_notify(struct virtqueue *vq)
>  {
>  	struct virtio_ccw_vq_info *info = vq->priv;
>  	struct virtio_ccw_device *vcdev;
> @@ -384,6 +384,9 @@ static void virtio_ccw_kvm_notify(struct virtqueue *vq)
>  	vcdev = to_vc_device(info->vq->vdev);
>  	ccw_device_get_schid(vcdev->cdev, &schid);
>  	info->cookie = do_kvm_notify(schid, vq->index, info->cookie);
> +	if (info->cookie < 0)
> +		return info->cookie;
> +	return 0;

Nor this one.

Since the caller can't really use the return value, I think a bool is
correct.

Cheers,
Rusty.
