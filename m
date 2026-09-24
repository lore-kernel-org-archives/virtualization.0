Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75133CF673
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267087; cv=none; b=NLic3COt6xmURH0PXrhyLzrh9kO7kEEmiyVv4jLSCUBKEjampFCmJrNkOFlYQ0T27rdwL46vSKKl61250aKBbrl3UdMmRva17g4XNbwucucWZqfsplpXia8l/IyxBn5lsQxgwTYqE1Ttb3PW2tKsX5RVNat+2/0FC06Y9Th17dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267087; c=relaxed/simple;
	bh=cnsSM8DxGVO2ThXMvTw6tcI810XlCFwrb4J5oCHjmqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sph9zrPI6tkh6EM3lRePAwzYB6Dd1grHuk/dzDIj3eT9LFnR5ufXBCpVMosUacXYtdA1GYrc6HYZG5fUyk+7W/MqGfJ2YYvR5VnJ6ovbTYn5LOSGUcqtRH2Itob/OuKs75eSo6LkX0T/5gzFTn6DL6pCLtAGc8srGHCfHvC8WDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuJC5kdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuJC5kdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8F91F000FF;
	Thu, 24 Sep 2026 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267085;
	bh=rtrri1spI013xhyuGfNo/7U9MA4/ALDiFXyZxfEjK4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VuJC5kdvIpgt9fsyGnv+OJJfUvwtzHlf6NCklN02fXK8QDxbcEQ9Lm5PLigf9xVMv
	 /eJ42YnSjuHdLJtE4R2/LsRx2RiGFA/mohlOWEiicx14yDw653RRZm1zt3j7zcrRHJ
	 BKTlLWw743BJHldkODi4IYVZD0KdhBpPld3lKjeocfmZsAKqH2TPS8+ugX6kJr02D7
	 WE33N8XADnztzqdvWsblDdg/6f+NsRDZl65BzokhhGh0yAlJIbue5sa3a1WARa1OXw
	 dr0Tika9RoQ+qXvAjSdiUrjhEYSjqaKaMB8VG8NwiCkdZdQKu0Qmpp3mw4425/D1mb
	 eP+TseKUdxNHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] virtio-usb: add USB On-The-Go role-switching
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260924160907.145405-6-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-6-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:24:44 +0000
Message-Id: <20260924162445.3C8F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] usb: virtio_usb: unbounded memory leak of devm-managed structures =
on OTG switch
- [High] usb: virtio_usb: race in otg_vports_deinit causes UAF of otg port =
structures
- [High] usb: virtio_usb: missing bounds check on port_id allows OOB access=
 from untrusted backend
- [High] usb: virtio_usb: race between event processing and deinit causes U=
AF on usb_hcd
- [High] usb: virtio_usb: premature publication of vhc pointer exposes unin=
itialized HCDs
- [Medium] usb: virtio_usb: sysfs name collision prevents probing multiple =
OTG controllers
- [Medium] usb: virtio_usb: missing NULL check for kasprintf leads to fallb=
ack name collision
--

commit 43ad38d6c9bfbe93bb71ee47b756c85a12c14c6b
Author: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

virtio-usb: add USB On-The-Go role-switching support

This commit adds runtime role-switching (OTG) support to virtio-usb. It
negotiates VIRTIO_USB_F_SWITCH_ROLE, registers a USB Role Switch class
device, and processes VIRTIO_USB_EVT_OTG_CHANGE_ROLE events.

> diff --git a/drivers/usb/virtio_usb/host.c b/drivers/usb/virtio_usb/host.c
> index 9926e66bcc286..5dc47f3d4baa7 100644
> --- a/drivers/usb/virtio_usb/host.c
> +++ b/drivers/usb/virtio_usb/host.c
> @@ -1013,12 +1013,16 @@ int virtio_usb_hc_vp_init(struct virtio_usb *vusb=
, unsigned int vp_idx)
>  		vhcd_vp->hcqs[i] =3D &vusb->vqueues[vusb->host_vq_base + i];
> =20
>  	/* Install into the port before add_hcd so vhcd_vp->vusb is set */
> +	spin_lock(&vusb->vports[vp_idx].vhc_lock);
>  	vusb->vports[vp_idx].vhc =3D vhcd_vp;
> +	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
> =20
>  	/* Add HCDs first so hs/ss are valid before any PORT_CONNECTED event */
>  	rc =3D virtio_usb_add_hcd(vusb, vhcd_vp);

[Severity: High]
Does publishing this vhc pointer here expose uninitialized HCDs?

If a concurrent VIRTIO_USB_EVT_HOST_PORT_CONNECTED event is processed by
virtio_usb_hc_evt_process_one() after vhc is set but before
virtio_usb_add_hcd() finishes, the event handler will see the published
pointer and attempt to access uninitialized HCDs.

Could this pointer be published only after the HCDs are fully initialized?

>  	if (rc) {
> +		spin_lock(&vusb->vports[vp_idx].vhc_lock);
>  		vusb->vports[vp_idx].vhc =3D NULL;
> +		spin_unlock(&vusb->vports[vp_idx].vhc_lock);
>  		return rc;
>  	}

[ ... ]

> @@ -1032,7 +1036,11 @@ int virtio_usb_hc_vp_init(struct virtio_usb *vusb,=
 unsigned int vp_idx)
>   */
>  int virtio_usb_hc_vp_deinit(struct virtio_usb *vusb, unsigned int vp_idx)
>  {
> -	struct virtio_usb_hc_vp *vhcd_vp =3D vusb->vports[vp_idx].vhc;
> +	struct virtio_usb_hc_vp *vhcd_vp;
> +
> +	spin_lock(&vusb->vports[vp_idx].vhc_lock);
> +	vhcd_vp =3D vusb->vports[vp_idx].vhc;
> +	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
> =20
>  	if (!vhcd_vp)
>  		return 0;
> @@ -1045,7 +1053,9 @@ int virtio_usb_hc_vp_deinit(struct virtio_usb *vusb=
, unsigned int vp_idx)
>  	vhcd_vp->ss =3D NULL;
>  	vhcd_vp->hs =3D NULL;
> =20
> +	spin_lock(&vusb->vports[vp_idx].vhc_lock);
>  	vusb->vports[vp_idx].vhc =3D NULL;
> +	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
>  	return 0;
>  }

[Severity: High]
Does this deinit path leak devm-allocated structures during OTG role switch=
es?

The dynamic OTG role switching from device to host calls
virtio_usb_hc_vp_init(), which uses devm_kzalloc() and devm_kasprintf() to
allocate vhcd_vp and its name string.

When switching back to device role, this deinit function is called but does
not free these devres-managed objects.

Since the devm allocations are tied to the parent virtio device's lifetime,
repeatedly toggling the role will indefinitely consume memory until the who=
le
driver is unbound.

Should these structures be explicitly freed or managed differently?

[ ... ]

> @@ -1085,7 +1095,18 @@ static void virtio_usb_hc_evt_process_one(struct v=
irtio_usb_event *uevent)
>  		return;
>  	}
> =20
> +	/* vhc can be concurrently init/deinit'd by an OTG role switch
> +	 * (virtio_usb_otg_event_process() runs on its own workqueue) -
> +	 * vhc_lock protects only the pointer read itself; the vhcd_vp it
> +	 * points to remains valid for as long as we hold a reference to
> +	 * it here, since virtio_usb_hc_vp_deinit() only clears the
> +	 * vports[vp_idx].vhc pointer under the same lock, it does not
> +	 * free vhcd_vp itself (devm-managed, freed at device teardown).
> +	 */
> +	spin_lock(&vusb->vports[vp_idx].vhc_lock);
>  	vhcd_vp =3D vusb->vports[vp_idx].vhc;
> +	spin_unlock(&vusb->vports[vp_idx].vhc_lock);
> +
>  	if (!vhcd_vp) {
>  		dev_err_ratelimited(

[Severity: High]
Does dropping vhc_lock here open a race window that leads to a use-after-fr=
ee
on the usb_hcd pointer?

While the comment notes that vhcd_vp itself won't be freed because it is
devm-managed, virtio_usb_hc_vp_deinit() can be executed concurrently and wi=
ll
call usb_remove_hcd() and usb_put_hcd() to dynamically free the HCDs.

Later in virtio_usb_hc_evt_process_one(), the code calls:

    if (hcd)
        usb_hcd_poll_rh_status(hcd);

If deinit frees the HCD while this event processing thread is running, pass=
ing
it to usb_hcd_poll_rh_status() will dereference freed memory.

Is an extended lock or refcount needed to protect the HCD?

> diff --git a/drivers/usb/virtio_usb/otg.c b/drivers/usb/virtio_usb/otg.c
> index 557dfae8302c6..f0f390fdea1a5 100644
> --- a/drivers/usb/virtio_usb/otg.c
> +++ b/drivers/usb/virtio_usb/otg.c
> @@ -7,11 +7,238 @@
> =20
>  #include <linux/mutex.h>
>  #include "controller.h"
> +#include "host.h"
>  #include "otg.h"
>  #include "vq_common.h"
> =20

[ ... ]

> +static void virtio_usb_otg_event_process(struct virtio_usb_event *event)
> +{
> +	struct virtio_usb *vusb =3D event->vusb;
> +	struct virtio_usb_otg_event *evt =3D virtio_usb_event_buf(event);
> +	int port_id =3D le32_to_cpu(evt->port);
> +	struct virtio_usb_port *vport =3D &vusb->vports[port_id];

[Severity: High]
Does this missing bounds check on port_id allow out-of-bounds array accesse=
s?

The port_id is extracted from the untrusted virtio event buffer and immedia=
tely
used to index the vusb->vports[] array.

If a buggy or malicious virtio backend provides a port_id greater than or
equal to vusb->nports, this will lead to out-of-bounds pointer reads and
writes.

[ ... ]

> +static void otg_vports_deinit(struct virtio_usb *vusb)
> +{
> +	if (!vusb->vports)
> +		return;
> +
> +	for (int i =3D 0; i < vusb->nports; ++i) {
> +		struct virtio_usb_port *vport =3D &vusb->vports[i];
> +		/* is_otg is set before otg_sysfs_init() runs (which is
> +		 * where vport->otg actually gets allocated) - a probe
> +		 * failure in between the two would otherwise leave
> +		 * is_otg true but otg still NULL here.
> +		 */
> +		if (!vport->is_otg || !vport->otg)
> +			continue;
> +
> +		cancel_work_sync(&vport->otg->set_role_work);
> +		usb_role_switch_unregister(vport->otg->sw);

[Severity: High]
Does cancelling the work before unregistering the sysfs interface cause a
use-after-free race?

If a concurrent sysfs write to the switch's role file occurs after
cancel_work_sync() returns but before usb_role_switch_unregister() finishes,
vusb_set_role_cb() will schedule set_role_work anew.

Once the teardown completes and frees vport->otg, the re-queued work could
execute and dereference the freed memory.

Should the sysfs interface be unregistered first to prevent new requests fr=
om
being scheduled?

[ ... ]

> +static int otg_vport_init(struct virtio_usb *vusb, int port_id)
> +{
> +	struct device *dev =3D &vusb->vdev->dev;
> +	struct virtio_usb_port *vport =3D &vusb->vports[port_id];
> +	struct virtio_usb_port_otg *vport_otg;
> +	struct usb_role_switch_desc desc =3D { 0 };
> +
> +	vport_otg =3D devm_kzalloc(dev, sizeof(*vport_otg), GFP_KERNEL);
> +	if (!vport_otg)
> +		return -ENOMEM;
> +
> +	vport_otg->vusb =3D vusb;
> +	vport_otg->port_id =3D port_id;
> +	vport_otg->sysfs_name =3D kasprintf(GFP_KERNEL, "port%u", port_id);

[Severity: Medium]
Will this hardcoded naming scheme cause a sysfs name collision if multiple
virtio-usb controllers with OTG support are probed?

The static name format "port%u" is registered directly to the
/sys/class/usb_role/ global namespace.

The second device probed will fail with -EEXIST.

Could the name be scoped by the parent device name (e.g., %s-port%u) to ens=
ure
uniqueness?

[Severity: Medium]
Does the lack of a NULL check on kasprintf() here lead to fallback name
collisions?

If kasprintf() fails under memory pressure, it returns NULL which is then
assigned to desc.name.

The USB role switch core will detect the NULL name and fallback to using the
parent device's name.

If a second port on the same controller also fails allocation, it will also
fallback to the parent name, causing an -EEXIST conflict.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D5
