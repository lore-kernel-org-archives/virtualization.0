Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17943BDDD
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267300; cv=none; b=FLTztiEu7lq3gVYWU2K1ebByi/Q25L5YfDLmlRMlinwg/jbzlmeFqMm8kaI8reS5E1g9jGXTwqM9VlbXmVBheQ/pFyEpbA6OUeIAKB4RwM4hVgaTaXhiBHCYPtFomoFAF2lJCf+n4hnQW1RZXcf8JX99EQxn5RMVSWmm2qdW1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267300; c=relaxed/simple;
	bh=3dlja/b3e7m0/rSiCguzm58DoaEHzx9KJvrwnhCaW64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKPBa+4IdpdurryRmnmoiwv03UjavZPW1xIA5zdPO3EY2G5o0SFIIBKVAEdIaTx/0srADaQVGtPteFcOC03idtv2rax4ZvmF40JSt3Eteq+RtLOQ7ErzzVCyhtUI+oo6nLjH3dTNnrLeIJcXcVuSYdUoJ6va+63Zlydw9jbf9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHuD+N5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHuD+N5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FC11F00893;
	Thu, 24 Sep 2026 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267298;
	bh=LcEPikKrC3AIYyjI/Na7cnH5L9J2kfl+0d3Z0F6oIv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZHuD+N5MZb4ZZUkF2vO+7o0zccnsFlSeArDj0xp85JeAFlYEbANIeDhosl7wq+zBd
	 ktoiTnS4x+TuRbEmkahF7xp+EaysE5gaxfHW1FBudmgF8n2cV07gSfyc0I25JqUEIT
	 o55EoEDgIWazYYcBO4EM04jUAkeet8NG8VG9BsRjs4kHwG3ZqJGt0tWU7ytnlXQOK1
	 ZRu4QlWtXYfq4iep8yioKHOOVwy2qdqv+QjbVcD7wsJZHKRCdGN4ausYeXv0tnO9BU
	 8OMQ+8/TVTe7aRTa+20wqpafc6wFScfpiGFM2BKl4jk0fnAEU3GO+j/rmtgM01/x09
	 AVswGunVJdClQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] virtio-usb: add device role (USB Device Controller)
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260924160907.145405-4-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-4-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:28:17 +0000
Message-Id: <20260924162818.74FC11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 14 potential issue=
(s) to consider:
- [Critical] usb: virtio_usb: Use-After-Free of vudc->veps array during asy=
nchronous UNBIND
- [Critical] usb: virtio_usb: NULL pointer dereference handling events on a=
 host-role port
- [Critical] usb: virtio_usb: Host-provided actual_length enables out-of-bo=
unds reads in gadget drivers
- [High] usb: virtio_usb: Use-After-Free of virtio command response buffer =
in virtio_usb_dc_get_frame()
- [High] usb: virtio_usb: Memory corruption from zeroing a refcounted struc=
t device
- [High] usb: virtio_usb: Invalid DMA mapping of .rodata for endpoint descr=
iptor
- [High] usb: virtio_usb: Scatter-gather list ignored if req->buf is popula=
ted
- [High] usb: virtio_usb: ABA pointer race in virtio_ep_dequeue causes Use-=
After-Free
- [High] usb: virtio_usb: Lockless req_queue mutation causes list corruptio=
n in teardown
- [High] usb: virtio_usb: Endpoint operations sleep in atomic context
- [High] usb: virtio_usb: TOCTOU race invokes setup() on an unloaded driver=
 module
- [Medium] usb: virtio_usb: Global namespace collision for multiple virtio-=
usb controllers
- [Medium] usb: virtio_usb: Unconditional NULL pointer dereference in virti=
o_usb_dc_dataq_stop_cb()
- [Medium] usb: virtio_usb: Memory leak of gadget name string during teardo=
wn
--

commit a6cc5b6e920b40a9b504189953adff7fa11229be
Author: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>

virtio-usb: add device role (USB Device Controller) support

This commit adds device (UDC) role support to the virtio-usb driver. It=20
implements the gadget and endpoint callback sets to interact with the UDC=20
core, passing lifecycle events and endpoint requests over virtqueues to the=
=20
host backend.

> diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/dev=
ice.c
> new file mode 100644
> index 0000000000000..798c265fb2d25
> --- /dev/null
> +++ b/drivers/usb/virtio_usb/device.c
> @@ -0,0 +1,1356 @@
[ ... ]
> +static void virtio_usb_dc_complete_req(struct virtio_usb_data *vreq)
> +{
> +	struct virtio_usb_response *response =3D virtio_usb_data_response(vreq);
> +	struct virtio_usb_dc_priv *priv =3D virtio_usb_data_priv(vreq);
> +	unsigned int status =3D le32_to_cpu(response->status);
> +	struct usb_request *req =3D &priv->req;
> +	struct virtio_usb_ep *vep =3D priv->vep;
> +	struct virtio_usb_dc *vudc =3D vep->vudc;
> +	struct virtio_usb_data *vreq_iter;
> +	unsigned int found =3D 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vudc->lock, flags);

[Severity: Critical]
Can this asynchronous completion race with the UNBIND event handler?
The UNBIND handler in virtio_usb_dc_event_process() frees the vudc->veps
array unconditionally without draining in-flight virtqueue data. If this
completion executes after the array is freed, dereferencing priv->vep to
access the lock and req_queue would result in a Use-After-Free.

[ ... ]
> +	if (req->status !=3D -ECONNRESET && req->status !=3D -ESHUTDOWN) {
> +		req->status =3D virtio_error_to_usb(status);
> +		if (!req->status)
> +			req->actual =3D le32_to_cpu(response->actual_length);

[Severity: Critical]
Is it possible for the host to provide an actual_length larger than the
original request length? Since req->actual is updated without bounds checki=
ng
against req->length, could a malicious host backend trick gadget drivers in=
to
reading out-of-bounds memory?

[ ... ]
> +static int virtio_ep_enable(struct usb_ep *ep,
> +			    const struct usb_endpoint_descriptor *desc)
> +{
[ ... ]
> +	cmd =3D virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_ENABLE,
> +				      GFP_ATOMIC);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	sg_init_one(psg_data, desc, sizeof(*desc));
> +	hdr =3D virtio_usb_cmd_request(cmd);
> +	hdr->endpoint =3D cpu_to_le16(endpoint);
> +
> +	rc =3D virtio_usb_cmd_send_sync(vudc->vusb, psg_data, NULL, cmd);

[Severity: High]
Does this map a static endpoint descriptor for DMA? Gadget drivers often
pass endpoint descriptors located in static const (.rodata) memory. The
DMA API does not permit mapping .rodata memory, so passing it to
sg_init_one() here could cause a BUG_ON or silent DMA corruption.

[ ... ]
> +static int virtio_ep_queue(struct usb_ep *ep, struct usb_request *req,
> +			   gfp_t mem_flags)
> +{
[ ... ]
> +	if (req->length && req->buf) {
> +		psg_data =3D &sg;
> +		sg_init_one(psg_data, req->buf, req->length);
> +	} else if (req->length && req->num_sgs > 0) {
> +		psg_data =3D req->sg;
> +	} else if (req->sg) {

[Severity: High]
Will multi-page scatter-gather transfers be silently ignored if a gadget
driver populates both req->buf (as a fallback) and req->sg? The first
condition matches if req->buf is present, breaking the scatter-gather
transfer logic.

[ ... ]
> +static int virtio_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
> +{
[ ... ]
> +	spin_unlock_irqrestore(&vudc->lock, flags);
> +
> +	if (rc)
> +		return rc;
> +
> +	vreq =3D priv->vreq;
> +
> +	cmd =3D virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_CANCEL,
> +				      GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	cancel =3D virtio_usb_cmd_request(cmd);
> +	cancel->hdr.endpoint =3D cpu_to_le16(endpoint);
> +	cancel->hdr.port =3D cpu_to_le16(vudc->port);
> +	cancel->tag =3D cpu_to_le64((uintptr_t)vreq);

[Severity: High]
Could priv be accessed after it is freed here? The vudc->lock is dropped
prior to accessing priv->vreq. If the completion handler concurrently gives
back the request and frees the associated vreq, this would result in a
Use-After-Free and cancel the wrong tag.

[ ... ]
> +static int virtio_ep_set_halt(struct usb_ep *ep, int value)
> +{
[ ... ]
> +	cmd =3D virtio_usb_dc_cmd_alloc(vudc, VIRTIO_USB_CMD_DEV_EP_SET_HALT,
> +				      GFP_ATOMIC);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	req =3D virtio_usb_cmd_request(cmd);
> +	req->value =3D cpu_to_le32(value);
> +	req->hdr.endpoint =3D cpu_to_le16(endpoint);
> +
> +	rc =3D virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);

[Severity: High]
Does virtio_usb_cmd_send_sync() sleep? The gadget API allows
usb_ep_set_halt() to be called in atomic context (e.g. from an interrupt
handler or while holding a spinlock). If virtio_usb_cmd_send_sync() blocks
waiting for a completion, this will trigger scheduling while atomic panics.

[ ... ]
> +static int virtio_usb_dc_get_frame(struct usb_gadget *gadget)
> +{
[ ... ]
> +	cmd =3D virtio_usb_dc_cmd_alloc(vudc, code, GFP_ATOMIC);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	rc =3D virtio_usb_cmd_send_sync(vudc->vusb, NULL, NULL, cmd);
> +	if (rc)
> +		return rc;
> +
> +	resp =3D virtio_usb_cmd_response(cmd);
> +	rc =3D le32_to_cpu(resp->frame_number);

[Severity: High]
Is the command buffer freed during virtio_usb_cmd_send_sync()? If the send
function drops the final reference and frees the message upon returning,
accessing resp->frame_number here would be a Use-After-Free.

[ ... ]
> +static int virtio_usb_dc_parent_create(struct virtio_usb_dc *vudc)
> +{
> +	int rc;
> +
> +	vudc->pdev =3D platform_device_alloc(GADGET_NAME, vudc->port);

[Severity: Medium]
Will this cause a sysfs naming conflict if multiple virtio-usb controllers
are present in the system? The port number is zero-indexed per controller,
so multiple instances could attempt to register devices with identical
names.

[ ... ]
> +static void virtio_usb_dc_event_process(struct virtio_usb_event *event)
> +{
[ ... ]
> +	unsigned short port_id =3D le16_to_cpu(evt->port);
> +
> +	if (!vusb->nports || port_id >=3D vusb->nports) {
> +		dev_err(&vusb->vdev->dev, "%s port[%d] index out of range\n",
> +			__func__, port_id);
> +		return;
> +	}
> +
> +	vudc =3D vusb->vports[port_id].vudc;
> +	driver =3D vudc->driver;

[Severity: Critical]
What happens if the host backend sends a device-role event for a host-role
port? Since virtio_usb_dc_init() is only called for device-role ports,
vudc will be NULL for host-role ports, resulting in a NULL pointer
dereference here.

[ ... ]
> +	switch (le32_to_cpu(evt->code)) {
> +	case VIRTIO_USB_EVT_DEV_BIND: {
> +		if (vudc->registered) {
> +			dev_err(&vusb->vdev->dev,
> +				"port %d: BIND while still registered, ignoring\n",
> +				port_id);
> +			rc =3D -EBUSY;
> +			break;
> +		}
> +
> +		memzero_explicit(&vudc->gadget, sizeof(struct usb_gadget));

[Severity: High]
Does zeroing the entire gadget structure destroy the active kobject state
if it is still refcounted? If a user-space process (like udev) still holds
an open sysfs reference from a previous BIND/UNBIND cycle, zeroing the
embedded struct device can cause kobject refcount corruption and kernel
panics.

[ ... ]
> +	case VIRTIO_USB_EVT_DEV_SETUP: {
> +		if (!driver)
> +			break;
> +
> +		vep =3D usb_ep_to_virtio_ep(vudc->gadget.ep0);
> +		setup_evt =3D virtio_usb_event_buf(event);
> +
> +		memcpy(&vep->setup, setup_evt->setup,
> +		       sizeof(struct usb_ctrlrequest));
> +
> +		rc =3D driver->setup(&vudc->gadget,
> +				   (struct usb_ctrlrequest *)setup_evt->setup);

[Severity: High]
Could the cached driver pointer point to an unloaded module here? If a
user removes the gadget driver concurrently with the host backend sending a
SETUP event, this could invoke setup() on an unloaded driver, causing a
kernel crash.

[ ... ]
> +int virtio_usb_dc_deinit(struct virtio_usb *vusb)
> +{
[ ... ]
> +		if (registered)
> +			usb_del_gadget_udc(&vudc->gadget);
> +
> +		kfree(vudc->veps);
> +		vudc->veps =3D NULL;

[Severity: Medium]
Should vudc->gadget.name be freed here? While the UNBIND event correctly
frees it, virtio_usb_dc_deinit() appears to omit the kfree(), leading to
a permanent memory leak of the kasprintf-allocated string.

[ ... ]
> +static void virtio_usb_dc_dataq_stop_cb(struct virtio_usb *vusb,
> +					struct virtio_usb_queue *dataq)
> +{
[ ... ]
> +		for (i =3D 0; i < vudc->neps; i++) {
> +			list_for_each_entry_safe(vreq, vreq_tmp,
> +						 &vudc->veps[i].req_queue,

[Severity: Medium]
Could vudc->veps be NULL here? If a BIND event fails or an UNBIND event
successfully completes, vudc->neps could be > 0 while vudc->veps is NULL,
resulting in a NULL pointer dereference when the module is unloaded.

[Severity: High]
Is it safe to mutate this linked list without acquiring the vudc->lock?
The gadget driver could be concurrently queuing or dequeuing requests.
Modifying the req_queue with list_del_init() locklessly could corrupt the
list and cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D3
