Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF213F99E5
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267118; cv=none; b=XbnkrmRHnykKvbGH1TjtrrW2noRBtYHz/ZwVAYg3SZKR1d2uwFzujT3OIK1HDbK1onjYXPmaM1IZORwxd/6fAWFyZ63aBVIlwAokfLkFcg3ykv7HtlmyqaV9cIhGYREosxNgDiZWTZEUdMZYcOqok5GJnttM5aDXOysmn1h2jaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267118; c=relaxed/simple;
	bh=HiUHep/Mz1Evg4JW7d+QELe4sm1Wgi+sY/JrmwjiDo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIAasRJmNR0fF+O1zSKzl1OsV+4T/fF8/QHNvBbKswdbO84/LsclLWaCT1jfd25XH+M5p4s3VZ0OGuG9vT+B0dKNMgqvmCR1xygce3GUslRPpdK3Y/0BOoPSX3kNHA976BtxvJw6bqF7bmJVm+DRL7ZTcW2eTr2dYq5gxii/Lxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWpdjt1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWpdjt1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953671F00893;
	Thu, 24 Sep 2026 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267116;
	bh=oPZ3y7CqkxPYMUvA2el1HakrlYgeak/slB9HxW9NZ54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWpdjt1j09oTJE3jTE4kA2jR8vIEaMylUHDHFnedYSrKfrOsKq8/NaGLf3WFfTQT4
	 MTq3x94JMDKaV9xiHtsq48o73H9+YtV12thwKOrQggelMa2+hpURKeDnCUmdf4sqGX
	 TUkTdAOe99HIHpPzQdnQERyiev5Hlu9/LcZhRPKnohdFOSX4R06hR0x6a/hhcBV7V9
	 OUm0lnqfz+lzMhMJ5YaNludev4EcysIGd9WRFF0hmJC1D7yVOIscqX0gizIPBL98xk
	 wQxc9kw97JXUeOykUO3cP4W63bB0K8LnMk0JZpys5Latz/nzQiwYu+3EEVTH0tZTjC
	 bM4jVf34Ytcuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] virtio-usb: add host role (USB Host Controller)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924160907.145405-3-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-3-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:25:16 +0000
Message-Id: <20260924162516.953671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] virtio-usb: missing bounds check on actual_length enables OOB =
memory access
- [High] virtio-usb: host dataq cancel_work_sync() on uninitialized work_st=
ruct
- [High] virtio-usb: missing sg_mark_end() in virtio_usb_hc_set_urb_sgs()
- [High] virtio-usb: invalid sg_virt() on Highmem pages crashes DMA mapping
- [High] virtio-usb: virtqueue teardown before virtio_reset_device() causes=
 UAF
- [High] virtio-usb: virtio_usb_port_from_urb() misroutes URBs for devices =
behind hubs
- [High] virtio-usb: virtio_usb_data_send() enables interrupts in atomic co=
ntext
- [High] virtio-usb: leaking vurb heap address as tag breaks KASLR and caus=
es ABA
- [High] virtio-usb: heap overflow in virtio_usb_hub_control() when wLength=
 is small
- [Medium] virtio-usb: missing NULL check on events array causes panic duri=
ng init
- [Medium] virtio-usb: virtio_usb_evt_drain_stop_cb() leaks pending buffers=
 on teardown
- [Medium] virtio-usb: bitfield usage in port status breaks big-endian hosts
--

commit 89dd2308fe62a55b4cf51aa86800ab5c1ff53727
Author: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>

    virtio-usb: add host role (USB Host Controller) support

Adds common virtqueue handling code and the virtio-usb host controller
implementation. Host virtual ports are initialized with pre-allocated
leaf slots, and role resolution is initially hardcoded to the host role.

> diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb=
/controller.c
> index 2fc6f502b48f3..216edfcaa3c00 100644
> --- a/drivers/usb/virtio_usb/controller.c
> +++ b/drivers/usb/virtio_usb/controller.c
[ ... ]
> +static int virtio_usb_probe(struct virtio_device *vdev)
> +{
[ ... ]
> +	rc =3D virtio_usb_find_vqs(vusb);
> +	if (rc) {
> +		dev_err(&vdev->dev, "%s virtio_usb_find_vqs() error(%d)\n",
> +			__func__, rc);
> +		goto on_error;
> +	}
> +
> +	if (vusb->host_role) {
> +		INIT_WORK(&vusb->vq_host_data_rx_work, virtio_usb_hc_rx_work);

[Severity: High]
Does this code call cancel_work_sync() on an uninitialized work_struct if
probe fails?

If virtio_usb_find_vqs() returns an error, the driver jumps to the error pa=
th
and calls virtio_usb_remove(), which eventually invokes
virtio_usb_hc_dataq_stop_cb(). That function unconditionally calls
cancel_work_sync(&vusb->vq_host_data_rx_work). Since INIT_WORK hasn't been
called yet, could this trigger a kernel panic or lockdep warning?

[ ... ]
> +static void virtio_usb_remove(struct virtio_device *vdev)
> +{
> +	struct virtio_usb *vusb =3D vdev->priv;
> +	int i;
> +
> +	for (i =3D 0; i < vusb->nvqs; i++)
> +		vusb->vqueues[i].stop(vusb, &vusb->vqueues[i]);
> +
> +	if (vusb->host_role && vusb->vports) {
> +		for (i =3D 0; i < (int)vusb->nports; i++)
> +			virtio_usb_hc_vp_deinit(vusb, i);
> +	}
> +
> +	virtio_reset_device(vdev);

[Severity: High]
Can this order of operations cause a use-after-free?

The stop() callbacks (like virtio_usb_hc_dataq_stop_cb()) unlink all pending
URBs and free their associated memory while the virtio device is still acti=
ve.
Since virtio_reset_device() is called afterward, could the hardware
concurrently complete a pending request and DMA-write the response into the
just-freed memory?

> diff --git a/drivers/usb/virtio_usb/host.c b/drivers/usb/virtio_usb/host.c
> new file mode 100644
> index 0000000000000..9926e66bcc286
> --- /dev/null
> +++ b/drivers/usb/virtio_usb/host.c
[ ... ]
> +static int virtio_usb_hub_control(struct usb_hcd *hcd, u16 type, u16 wVa=
lue,
> +				  u16 wIndex, char *buffer, u16 wLength,
> +				  bool ss_mode)
> +{
> +	struct virtio_usb_hc_port *port;
> +	struct virtio_usb_hc_vp *vhcd_vp =3D vhcd_get(hcd);
> +
> +	switch (type) {
> +	case GetHubDescriptor: {
> +		struct usb_hub_descriptor *dsc =3D
> +			(struct usb_hub_descriptor *)buffer;
> +
> +		memset(dsc, 0, sizeof(struct usb_hub_descriptor));

[Severity: High]
Can this memset() overflow the provided buffer?

The buffer size is determined by the wLength parameter. If userspace submit=
s a
control transfer via usbfs with a wLength smaller than
sizeof(struct usb_hub_descriptor), will this unconditional memset() write p=
ast
the allocated buffer bounds?

[ ... ]
> +static void virtio_usb_hc_complete_urb(struct virtio_usb_data *vurb)
> +{
[ ... ]
> +	urb->actual_length =3D le32_to_cpu(response->actual_length);

[Severity: Critical]
Is it safe to trust the actual_length provided by the virtio device without
bounds checking?

If the untrusted response->actual_length exceeds urb->transfer_buffer_lengt=
h,
can subsequent USB class drivers use this value to read or write past the e=
nd
of the transfer buffer?

> +	if (urb->status =3D=3D -EINVAL)
[ ... ]
> +	if (usb_pipeisoc(urb->pipe)) {
> +		iso_urb_status =3D (void *)response + sizeof(*response);
> +
> +		for (i =3D 0; i < urb->number_of_packets; i++) {
> +			struct virtio_usb_iso_status *iso_status =3D
> +				&iso_urb_status[i];
> +			status =3D le32_to_cpu(iso_status->status);
> +
> +			urb->iso_frame_desc[i].actual_length =3D
> +				le32_to_cpu(iso_status->actual_length);

[Severity: Critical]
Does this code also need bounds checking against the expected isochronous
frame lengths to prevent out-of-bounds memory accesses?

[ ... ]
> +static struct scatterlist *
> +virtio_usb_hc_set_urb_sgs(struct virtio_usb_hc_priv *priv, gfp_t gfp)
> +{
[ ... ]
> +		for_each_sg(urb->sg, sg, nsgs, i) {
> +			sg_length =3D sg->length;
> +
> +			if (sg_length > buffer_length)
> +				sg_length =3D buffer_length;
> +
> +			sg_set_page(&sgs[i], sg_page(sg), sg_length,
> +				    sg->offset);
> +
> +			buffer_length -=3D sg_length;
> +			if (!buffer_length)
> +				break;
> +		}

[Severity: High]
When breaking early from this loop, does the code miss marking the end of t=
he
new scatterlist?

Without calling sg_mark_end(&sgs[i]), passing this array to
virtqueue_add_sgs() could cause the iterator to walk past the valid elements
into the zero-initialized remainder, leading to DMA mapping crashes.

[ ... ]
> +static struct virtio_usb_data *
> +virtio_usb_hc_data_alloc(struct virtio_usb_hc_port *port, struct urb *ur=
b,
> +			 gfp_t gfp)
> +{
[ ... ]
> +	request->tag =3D cpu_to_le64((uintptr_t)vurb);

[Severity: High]
Is it intended to expose a raw kernel heap address to the virtio backend?

Leaking this pointer breaks KASLR. Additionally, in virtio_usb_hc_dequeue(),
this same pointer is used as the cancellation tag. If the URB is concurrent=
ly
completed and its memory freed and reallocated for a new URB, could the
delayed cancel command erroneously cancel the new URB (the ABA problem)?

[ ... ]
> +static struct virtio_usb_hc_port *virtio_usb_port_from_urb(struct usb_hc=
d *hcd,
> +							   struct urb *urb)
> +{
> +	struct virtio_usb_hc_vp *vhcd_vp =3D vhcd_get(hcd);
> +	int slot =3D urb->dev->portnum - 1;
> +
> +	if (slot < 0 || slot >=3D VIRTIO_USB_VP_MAX_PORTS)
> +		return NULL;
> +	return &vhcd_vp->ports[slot];
> +}

[Severity: High]
Does this logic assume that all URBs target a device directly connected to =
the
root hub?

If a guest enumerates a USB hub, urb->dev->portnum would correspond to the
parent hub's port rather than the root hub. Could this misroute requests to
the wrong port slot on the virtio backend?

[ ... ]
> +static int virtio_usb_hc_enqueue(struct usb_hcd *hcd, struct urb *urb,
> +				 gfp_t mem_flags)
> +{
[ ... ]
> +	if (urb->transfer_buffer) {
> +		sg_init_one(psg_data, urb->transfer_buffer,
> +			    urb->transfer_buffer_length);
> +	} else if (urb->num_sgs > 1) {
> +		psg_data =3D virtio_usb_hc_set_urb_sgs(priv, mem_flags);
> +		if (!psg_data) {
> +			rc =3D -ENOMEM;
> +			goto on_exit;
> +		}
> +	} else if (urb->transfer_buffer_length && urb->sg) {
> +		sg_init_one(psg_data, sg_virt(urb->sg),
> +			    urb->transfer_buffer_length);
> +	} else {
> +		psg_data =3D NULL;
> +	}

[Severity: High]
Is it safe to use sg_virt() on an arbitrary scatterlist element here?

The USB core allows URB scatterlists to reference HIGHMEM pages, for which
page_address() returns NULL. In that case, sg_virt() would calculate an
invalid virtual address (NULL + offset), potentially crashing the system
during DMA mapping.

[ ... ]
> +int virtio_usb_hc_event_populate(struct virtio_usb *vusb)
> +{
[ ... ]
> +	struct virtio_usb_event *events;
> +
> +	events =3D virtio_usb_events_alloc(
> +		vusb, evt_queue, sizeof(struct virtio_usb_host_port_event));
> +
> +	return virtio_usb_events_populate(events);
> +}

[Severity: Medium]
Does this code dereference the events array without checking for NULL?

If virtio_usb_events_alloc() fails to allocate memory and returns NULL,
passing it directly to virtio_usb_events_populate() will cause a kernel pan=
ic
when the array is dereferenced.

> diff --git a/drivers/usb/virtio_usb/host.h b/drivers/usb/virtio_usb/host.h
> new file mode 100644
> index 0000000000000..8c5a233417f82
> --- /dev/null
> +++ b/drivers/usb/virtio_usb/host.h
[ ... ]
> +struct virtio_usb_port_hs_status {
> +	u16 connect : 1;
> +	u16 enable : 1;
> +	u16 suspend : 1;
> +	u16 over_current : 1;
> +	u16 reset : 1;
> +	u16 reserved0 : 3;
> +	u16 power : 1;
> +	u16 low_speed : 1;
> +	u16 high_speed : 1;
> +	u16 test_mode : 1;
> +	u16 indicator_control : 1;
> +	u16 reserved1 : 3;
> +};

[Severity: Medium]
Can this bitfield definition break hub emulation on big-endian architecture=
s?

Memory layout for C bitfields is implementation-defined and reversed on
big-endian systems. Since the values are written directly to a u16 buffer in
virtio_usb_hub_control(), could this cause the USB core to observe scrambled
port status bits?

> diff --git a/drivers/usb/virtio_usb/vq_common.c b/drivers/usb/virtio_usb/=
vq_common.c
> new file mode 100644
> index 0000000000000..baaf29db62f4d
> --- /dev/null
> +++ b/drivers/usb/virtio_usb/vq_common.c
[ ... ]
> +int virtio_usb_data_send(struct virtio_usb *vusb, struct virtio_usb_data=
 *data,
> +			 struct scatterlist *out_sgs,
> +			 struct scatterlist *in_sgs)
> +{
[ ... ]
> +	spin_lock_irq(&queue->lock);
> +	rc =3D virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, data,
> +			       GFP_ATOMIC);
> +	if (!rc)
> +		notify =3D virtqueue_kick_prepare(queue->vqueue);
> +	spin_unlock_irq(&queue->lock);

[Severity: High]
Does spin_unlock_irq() incorrectly re-enable hardware interrupts when called
from atomic context?

This function is invoked by virtio_usb_hc_enqueue() (the urb_enqueue HCD
callback), which is often executed in atomic hardirq context when USB drive=
rs
submit URBs from their completion handlers. Unconditionally enabling
interrupts here can lead to nested interrupts or stack overflows.

[ ... ]
> +void virtio_usb_evt_drain_stop_cb(struct virtio_usb_queue *vq,
> +				  struct work_struct *work)
> +{
[ ... ]
> +	spin_lock_irqsave(&vq->lock, flags);
> +	virtqueue_disable_cb(vq->vqueue);
> +	while ((buf =3D virtqueue_get_buf(vq->vqueue, &length)))
> +		;
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +}

[Severity: Medium]
Should this loop use virtqueue_detach_unused_buf() instead of
virtqueue_get_buf()?

Because virtqueue_get_buf() only returns buffers that have been completed by
the device, preallocated event buffers might remain stuck on the vring. When
the virtio core destroys the queues, it expects all buffers to be properly
detached, potentially leading to leaked descriptor slots and core warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D2
