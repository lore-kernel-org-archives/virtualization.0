Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA13403F4;
	Fri, 25 Sep 2026 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314230; cv=none; b=ehjotRy59Lj4O+KSlFAl8yo6cXDcuO2qBcbNaogd4HMsEOaqEJZelTKOcpR3KuqSBW5p47Nk0Ev36O2GR75P8LaMXu3grYdzOjYPjLuYxMFuBg8a6FXTrAb1/WOV95ORjm6Vs936HtP5ejzGP/7hO838jurDGp3Air9g7naDlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314230; c=relaxed/simple;
	bh=Qv/3g7Z7nvmQ7KWIb1f4sWbsg3hgQq7DhVhBa+Y0YbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPEEUFVGwzD/NpE/79k3YbAB3lmthNt2d/QaqVbH7SE0LFFnX/0uwbEjwwpI80YPB4FIHt0TmDEH/10/MFuY1jOgTLlL4s/TwLVmm6GLlZmQjt9LrV7cghBELEcVdfu1Yh2YR02Ejmvwx6owVHOG0nhWIN72cKnUcVSTx30OsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYqPzt3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYqPzt3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0321F000FF;
	Fri, 25 Sep 2026 05:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314229;
	bh=LEivK9rUCqycw+SeK/RTJrszzdVKsMBPwOEBeipUq+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PYqPzt3WdQgZ8tYiGB9ln8S3JUdKru2H2ECYaR5mCJ17oWUggeBGiXqLE5/11xJpx
	 ueivvxY9AsyCuRFzpYZoMWnD1F88objAgmGRipt214Uzi5XBqO4JDkZuPHIhVEti9z
	 bIKh9XYzs50KrVXldO9Yd2/TGSVuJzfLuMyHO7C4=
Date: Fri, 25 Sep 2026 07:18:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
	Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
	Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
	Trilok Soni <trilok.soni@oss.qualcomm.com>
Subject: Re: [PATCH 2/8] virtio-usb: add host role (USB Host Controller)
 support
Message-ID: <2026092531-giddy-annotate-7a58@gregkh>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-3-igor.skalkin@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924160907.145405-3-igor.skalkin@oss.qualcomm.com>

On Thu, Sep 24, 2026 at 06:09:01PM +0200, Igor Skalkin wrote:
> From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
> 
> Add the common virtqueue handling code (command, event and data
> queues) shared by every role, and the virtio-usb host controller
> (HCD) implementation, wiring it up as the host role of the dual-role
> driver on top of that common code.
> 
> Each host-role virtual port gets its own HS+SS usb_hcd pair and its
> own root hub (struct virtio_usb_hc_vp), with a fixed
> VIRTIO_USB_VP_MAX_PORTS (8) leaf slots pre-allocated at VP init time
> and reused across connect/disconnect - never dynamically alloc'd or
> freed. This lets the backend forward more than one physical socket -
> and, for host ports behind a physical hub, more than one leaf device
> per socket - as independent virtual ports from the start, instead of
> collapsing everything onto a single shared root hub and having to
> revisit that decision once more than one host-role port needs to
> exist at the same time.
> 
> virtio_usb_add_hcd() derives each VP's HCD bus_name from the parent
> virtio_device with devm_kasprintf() rather than a stack buffer, since
> usb_create_hcd()/usb_create_shared_hcd() store that pointer as-is in
> hcd->self.bus_name without copying it - it must outlive the HCD
> itself.
> 
> Every port is host-role for now, since no other role exists yet;
> vports[].role is populated unconditionally until later commits add
> device role and OTG-based role resolution.
> 
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
> Co-developed-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>
> Signed-off-by: Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>
> Co-developed-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
> Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
> ---
>  drivers/usb/virtio_usb/Makefile     |    4 
>  drivers/usb/virtio_usb/controller.c |  105 ++
>  drivers/usb/virtio_usb/controller.h |   35 
>  drivers/usb/virtio_usb/host.c       | 1335 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/virtio_usb/host.h       |  203 +++++
>  drivers/usb/virtio_usb/vq_common.c  |  740 +++++++++++++++++++
>  drivers/usb/virtio_usb/vq_common.h  |  163 ++++
>  include/uapi/linux/virtio_usb.h     |   16 
>  8 files changed, 2585 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/usb/virtio_usb/host.c
>  create mode 100644 drivers/usb/virtio_usb/host.h
>  create mode 100644 drivers/usb/virtio_usb/vq_common.c
>  create mode 100644 drivers/usb/virtio_usb/vq_common.h
> 
> diff --git a/drivers/usb/virtio_usb/controller.c b/drivers/usb/virtio_usb/controller.c
> index 2fc6f50..216edfc 100644
> --- a/drivers/usb/virtio_usb/controller.c
> +++ b/drivers/usb/virtio_usb/controller.c
> @@ -6,9 +6,16 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <uapi/linux/virtio_ids.h>
>  
>  #include "controller.h"
> +#include "host.h"
> +#include "vq_common.h"
> +
> +u32 virtio_usb_cmd_timeout_ms = MSEC_PER_SEC;
> +module_param_named(cmd_timeout_ms, virtio_usb_cmd_timeout_ms, uint, 0644);
> +MODULE_PARM_DESC(cmd_timeout_ms, "Command completion timeout in milliseconds");

This is not the 1990's, please do not add new module parameters.  Just
make it work without manual configuration at module load time.

If you really need a configuration option, make it per-device and use
the correct, modern, apis for it.

thanks,

greg k-h
