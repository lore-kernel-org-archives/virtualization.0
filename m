Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B447534D
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267437; cv=none; b=Psvx53m24WZIgElDBwbKC9WswEPVt1wpHHjyMVvTLfpG3qnbTUHlD2NhFsdUcMUP2CNFUPYBBxBki8RC3EEUagcGRzZTpEQdIQPvZJNEpmOl3qCqjH5O3yoHjAFu69xdAV8IYyCv339SrxXM1MsyDqY/4CxdqFKj08Nse9La93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267437; c=relaxed/simple;
	bh=W3x1v3xAmNecygtZ0f0lYNT28wlAcBv41K2MjaRbElY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V/6oB/d9ekhSbs2NL7/2Fy4pDDXCloKNO6T/pjiINPgb/9QXh0MRWK5SbXKndRY8sZfdUxdWbdGPx32NJR9gT3uRLhCFy1vdytK9ZJTrnkHUMRK4PZLSGoHLK1RjgiGu14OKxdx1BllyncZjLGqILrRXYRV00/jHLfJ1K2TDwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1q5Cp0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1q5Cp0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079961F000FF;
	Thu, 24 Sep 2026 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267435;
	bh=E1xwO5KKSuHUVc8x+29ubCgcvVayo4qH1+A/whtRjcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1q5Cp0bRxqdsEWUWJRttEOLm+kr+daNXMiDKJgpbwRRHvmFmcpsFh6C2bOEi5D1A
	 qwNkD6I3dw/S8xdyvpYY/aZUzyFyRYpdOUKAJtygAKcM8+h1f1T/Fl0RTeJxwc+zjL
	 FeUk9UwTv717tgqmtGMC5SkLj1QSyWUY8cE+yZE83andw3KzYt7myApyUUoiI3fCWt
	 qf+FHnuTsejvd/kPe3kQuyRLziHGGboL9TCMQJHqaMZOe+X35CRar+I+5FAHOXU8AQ
	 hjtZgZ0G/4jk/EP88llmLEbvYs53FGIJYFgt49jR7sj/qUEiZlTj1jKY45UNUUEMhy
	 QFMZNdbUlj4Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] virtio-usb: rework endpoint lifecycle to an async
 split-phase state machine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924160907.145405-7-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-7-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:30:34 +0000
Message-Id: <20260924163035.079961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] usb: virtio: DMA race and use-after-free due to fake early giv=
eback
- [Critical] usb: virtio: use-after-free of vudc->veps during device unbind
- [Critical] usb: virtio: use-after-free in async cancel work due to missin=
g refcount
- [Critical] usb: virtio: list corruption between do_real_queue() and ep_di=
sable
- [High] usb: virtio: sleep in atomic context in virtio_ep_disable()
- [High] usb: virtio: SETUP serialization fails due to un-checked pend_queue
- [High] usb: virtio: deadlock and double-free on queueing to halted endpoi=
nt
- [High] usb: virtio: vep_disable_work() disables wrong endpoint on host
- [High] usb: virtio: TOCTOU race queues requests after endpoint disable
- [High] usb: virtio: EP0 permanently hangs if enable_work is cancelled
--

commit e8d36f763a91b5d6a7067cc2771333012c0636ae
Author: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

virtio-usb: rework endpoint lifecycle to an async split-phase state machine

This commit changes the virtio-usb gadget driver's endpoint lifecycle to an
asynchronous state machine to avoid sleeping in atomic gadget callbacks.
Endpoint enable, disable, and queue operations now rely on workqueues and
split-phase request handling.

> diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/dev=
ice.c
> index 5ae0fc89bc287..9ee1f050019f1 100644
> --- a/drivers/usb/virtio_usb/device.c
> +++ b/drivers/usb/virtio_usb/device.c

[ ... ]

> +static bool virtio_usb_dc_req_queue_empty(struct virtio_usb_ep *vep)
> +{
> +	struct virtio_usb_dc *vudc =3D vep->vudc;
> +	unsigned long flags;
> +	bool empty;
> +
> +	spin_lock_irqsave(&vudc->lock, flags);
> +	empty =3D list_empty(&vep->req_queue);
> +	spin_unlock_irqrestore(&vudc->lock, flags);
> +
> +	return empty;
> +}

[Severity: High]
Does this logic ignore the pend_queue entirely?

If another endpoint is EP_ENABLING, EP0 requests are deferred into
pend_queue. Could virtio_usb_dc_wait_ep0_idle() mistakenly see an empty
req_queue and allow a new SETUP packet to overwrite the previous control
transfer state while it is still legitimately pending?

[ ... ]

> +static int do_real_queue(struct virtio_usb_ep *vep, struct usb_request *=
req)
> +{
[ ... ]
> +	rc =3D virtio_usb_data_send(vudc->vusb, vreq, out_sgs, in_sgs);
> +	if (rc) {
> +		spin_lock_irqsave(&vudc->lock, flags);
> +		list_del_init(&vreq->list);
> +		spin_unlock_irqrestore(&vudc->lock, flags);

[Severity: Critical]
Can this error path corrupt the list if it races with virtio_ep_disable()?

If virtio_usb_data_send() fails concurrently, virtio_ep_disable() might
have already moved vreq into a local stack list (giveback_inflight) and
dropped the lock to iterate over it locklessly. Calling list_del_init()
here on vreq->list would mutate the elements of that local list, destroying
the pointers.

[ ... ]

> +static void vep_disable_work(struct work_struct *work)
> +{
> +	struct virtio_usb_ep *vep =3D
> +		container_of(work, struct virtio_usb_ep, disable_work);
> +	struct virtio_usb_dc *vudc =3D vep->vudc;
> +	struct virtio_usb_cmd *cmd;
> +	struct virtio_usb_dev_cmd_hdr *hdr;
> +	u16 endpoint;
> +
> +	if (!READ_ONCE(vudc->driver) || !vudc->registered)
> +		return;

[Severity: Critical]
Is it possible for vep to be a dangling pointer here?

During device unbind (VIRTIO_USB_EVT_DEV_UNBIND), the driver calls
kfree(vudc->veps) after cancelling only enable_work. If a disable_work was
already queued, the workqueue could execute this function after vudc->veps
has been freed, resulting in a use-after-free.

> +	endpoint =3D vep->ep_id |
> +		   (usb_ep_dir_in(&vep->ep) ? VIRTIO_USB_EP_DIR_IN :
> +					      VIRTIO_USB_EP_DIR_OUT);

[Severity: High]
Can usb_ep_dir_in() safely calculate the direction here?

Gadget drivers generally clear ep->desc to NULL immediately after returning
from usb_ep_disable(). Because this block runs asynchronously, ep->desc
will likely be NULL, causing usb_ep_dir_in() to fall back to the OUT
direction (0). If the target was an IN endpoint, won't this send the disable
command for the wrong endpoint on the host?

[ ... ]

>  static int virtio_ep_disable(struct usb_ep *ep)
>  {
[ ... ]
> +	if (vep->state =3D=3D EP_ENABLING) {
> +		/*
> +		 * cancel_work_sync() can sleep and must not be called while
> +		 * holding vudc->lock: vep_enable_work() only re-acquires
> +		 * this same lock after its (possibly blocking) virtio
> +		 * command completes, so holding the lock here across
> +		 * cancel_work_sync() would deadlock against it.
> +		 */
> +		spin_unlock_irqrestore(&vudc->lock, flags);
> +		cancel_work_sync(&vep->enable_work);
> +		spin_lock_irqsave(&vudc->lock, flags);
> +	}

[Severity: High]
Is it safe to call cancel_work_sync() here?

The USB gadget API specifies that usb_ep_ops->disable is atomic and can be
called from interrupt context. Calling cancel_work_sync(), which can sleep,
violates this API contract and can trigger a scheduling while atomic bug.

[Severity: High]
Additionally, if enable_work is forcefully cancelled here, how do the EP0
requests deferred into pend_queue get flushed?

Does this leave EP0 permanently hung since virtio_usb_dc_flush_ep0_pend() is
never called to release the stranded requests?

[ ... ]

> +	/*
> +	 * in-flight requests - make early giveback, remove from req_queue,
> +	 * mark completed_early, but do not unref: unref will be in complete
> +	 * handler.
> +	 */
>  	list_for_each_entry_safe(vreq, vreq_tmp, &vep->req_queue, list) {
>  		priv =3D virtio_usb_data_priv(vreq);
> +		priv->req.status =3D -ESHUTDOWN;
> +		priv->completed_early =3D true;
> +		list_del_init(&vreq->list);
> +		list_add_tail(&vreq->list, &giveback_inflight);
>  	}
[ ... ]
> +	/* in-flight: giveback now, unref will be in complete_req */
> +	list_for_each_entry_safe(vreq, vreq_tmp, &giveback_inflight, list) {
> +		struct virtio_usb_dc_priv *p =3D virtio_usb_data_priv(vreq);
> =20
> -	rc =3D virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
> +		list_del_init(&vreq->list);
> +		usb_gadget_giveback_request(&vep->ep, &p->req);
> +	}

[Severity: Critical]
Could this early giveback result in immediate hardware memory corruption?

By handing the requests back to the gadget driver via
usb_gadget_giveback_request() before the hardware backend processes the
async disable command, the gadget driver may reuse or free the DMA buffers
while the virtqueue is still actively reading or writing to them.

[ ... ]

>  static int virtio_ep_queue(struct usb_ep *ep, struct usb_request *req,
>  			   gfp_t mem_flags)
>  {
[ ... ]
> +	case EP_ENABLED:
> +		if (!vep->ep_id && virtio_usb_dc_ep_enabling_locked(vudc)) {
[ ... ]
> +		}
> +		spin_unlock_irqrestore(&vudc->lock, flags);
> +		rc =3D do_real_queue(vep, req);
> +		/* if rc=3D=3D0 - unref will be in completion, on failure
> +		 * do_real_queue() has already dropped its own ref
> +		 */
> +		return rc;

[Severity: High]
Does this lock drop introduce a Time-of-Check to Time-of-Use race?

Because the lock is dropped before do_real_queue() re-acquires it to add
the request, a concurrent virtio_ep_disable() could mark the endpoint
disabled and flush the queues. The queued request would then be blindly
sent to the hardware anyway.

[ ... ]

> +	case EP_HALTED:
> +		spin_unlock_irqrestore(&vudc->lock, flags);
> +		req->status =3D vep->last_err ? vep->last_err : -EPIPE;
> +		usb_gadget_giveback_request(&vep->ep, req);
> +		return req->status;

[Severity: High]
Does returning an error code while also performing a giveback violate the
gadget API?

The USB gadget API expects that if queue() returns an error, the controller
did not take ownership and must not call the completion callback. The
synchronous giveback could cause a deadlock if it attempts to re-acquire the
caller's locks, and returning an error will likely cause the caller to free
the request, resulting in a double-free.

[ ... ]

>  static int virtio_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
>  {
[ ... ]
> -	if (rc)
> +	if (rc) // request not found in req_queue
>  		return rc;
> =20
> -	vreq =3D priv->vreq;
> +	schedule_work(&priv->cancel_work);
> =20
> -	cmd =3D virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_CANCEL,
> -				      GFP_KERNEL);

[Severity: Critical]
Does scheduling priv->cancel_work without taking a reference to vreq risk a
use-after-free?

If the hardware naturally completes the request before this async cancel
work executes, the completion handler will drop the final reference and the
gadget driver will free the request. When virtio_usb_dc_cancel_work() later
runs, it would access the freed priv memory.

[ ... ]

>  static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
>  {
[ ... ]
> +		if (vudc->veps) {
> +			unsigned int i;
> +
> +			for (i =3D 0; i < vudc->neps; i++)
> +				cancel_work_sync(&vudc->veps[i].enable_work);
> +			kfree(vudc->veps);
> +			vudc->veps =3D NULL;
> +		}

(For context with the dangling pointer concern in vep_disable_work)
This is where vudc->veps is freed during VIRTIO_USB_EVT_DEV_UNBIND without
cancelling disable_work or flushing ep_cmd_wq.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D6
