Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025112;
	b=3+s5RW8dw0EtxWKMRhMJJT6UMB5zC+3nrWULgr2hNlqK6GJl4gc7JUKk6Z4/6V60DbYK
	 r+OBb7LCz6MQEm1wH/GwnVg9TI8gx4YTAlDDu2r1+LSC28QcUS1NAhInqIPtgln7emsiz
	 um3M0qhnNoIepNJo+1CbZquHpgwPNUdTsO7SZsuVlhshfBXj11Ybp+MQGwFa9wnpLqGK4
	 iXvqzLVPIPV7hKftEUIL6fmrwZXKXvhaRcWrjZruwJUSDlhr1V47HaVVHH3dyrFZr55PR
	 qbt5aNXeLIKLgBNN0OV8b5QqcTDQI1y6h09v4mimWvJPi/p3n1LS3A7CMtiewmMO3MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lzsfPF0hJzZOwl0x64Udzfk2hRT5PuH9mo5tt00Sfp4=;
	b=fclSH32bGQb7TlNUtAFC1QF1rI7w1v5WELOGfsjJDLomErXOuRmmJrI2G3aI3lsbSbAK
	 XlZVyZTkr8FiL/EW/wr5uRjSWzUbF+NDy9b96BfLUa196MdtfBEQEihnoGI51O2zuD0Fj
	 3zs9nVi/Oga1n0a9gt3vK172sRLiPAc5HJ1+GB9CAQRu5w1LH0Wpu5OyH70tnGbIwj/F5
	 O3aYCGzSJwY9VlUiv5N/lLsMI9VnU0t5WuG+15tFwETiEQVGnL9tXyoa2FnHj0AodfK+1
	 cgmIk31QmToMQK33jpyNb2y57llCbMhNxQYB6vtEKvRlJbM4mslOxwhM3JUGgTdwwLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihpNKxlg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307B606A321;
	Mon, 26 Oct 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihpNKxlg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C8B1F01828;
	Mon, 26 Oct 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025111;
	bh=lzsfPF0hJzZOwl0x64Udzfk2hRT5PuH9mo5tt00Sfp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihpNKxlgE1WULU7VSnHCaYr4MG6GyEhBQjo7bQXWmvm3r0d21HYBGcoCbu82ObIdt
	 edEz2mSIZ6zUJDsUj8jSuU/rt7ZcQNbVxZyruncHG669tw5O4g4GNuzEEjaVzEpZWO
	 C5IxJSmr+HdPL9LlWf9j7e0E81bLMpP1tew7srgFo+Qs7IuVnkzncC6bjrnCuU/l/g
	 Cn3j8NL0ITTiIIh63Rvx3iXjtj/OFcrYiQasGzI8+MSOlVBIDr1k34U3Y6sXxOun4n
	 bZFHgkRsxtq1jp3mvF4oRnoP2VHcMdyOIvCYsOCE4qzXolPYSVcUjJpuou63q9oy7k
	 Sx7/TgXEJRk3g==
Message-ID: <sashiko-outbox-185401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/23] drm/msm/dcp: Add DCP VirtIO driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-20-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-20-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:31:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] drm/msm/dcp: workqueue/kthread leak and UAF from msm_kms_init() in=
 dcp_virtio_probe()
- [High] drm/msm/dcp: missing virtio_driver freeze() and restore() callback=
s break resume
- [High] drm/msm/dcp: component_mutex self-deadlock on bridge cleanup durin=
g unbind
- [High] drm/msm/dcp: missing GPU split and match checks in dcp_component_r=
egister()
- [High] drm/msm/dcp: teardown race in dcp_virtio_hfi_cleanup() allows work=
 re-queue
- [High] drm/msm/dcp: unserialized concurrent virtqueue operations on resp_=
vq
- [Medium] drm/msm/dcp: missing HFI stop and device reset in dcp_virtio_shu=
tdown()
- [Medium] drm/msm/dcp: unbalanced pm_runtime_disable() on dcp_subsystem_dev
- [Medium] drm/msm/dcp: missing 64-bit DMA mask setup in dcp_subsystem_dev_=
init()
- [Medium] drm/msm/dcp: OF node reference leak in dcp_dsi_bridge_init() err=
or path
--

commit c14944800f78cc1aa467fd751736b4f2706040b6
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP VirtIO driver

This commit adds the DCP VirtIO function driver to set up the DCP DMA and
IOMMU identity, initialize the VirtIO and HFI transport, register the MSM
DRM component master, and manage suspend, resume, remove, and shutdown.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/=
dcp_drv.c
> new file mode 100644
> index 0000000000000..8c38de883bf68
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c

[ ... ]

> @@ -0,0 +1,191 @@
> +int dcp_subsystem_dev_init(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev =3D drv->vdev;
> +	struct device_node *dcp_subsystem_node;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	char busid[32];
> +	bool iommu_mapped;
> +	int ret;
> +
> +	dcp_subsystem_node =3D of_node_get(vdev->dev.of_node);
> +	if (!dcp_subsystem_node) {
> +		dev_err(&vdev->dev, "no DCP subsystem DT node\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(busid, sizeof(busid), "dcp-subsystem.%s", dev_name(vdev->dev.p=
arent));
> +
> +	/*
> +	 * DCP is discovered through VirtIO, but display/HFI buffers must be
> +	 * mapped through the dcp-subsystem node's DMA/IOMMU identity. Create a
> +	 * platform device for that DT node so DMA API and msm_kms_init_vm() use
> +	 * the display function's IOMMU domain.
> +	 */
> +	pdev =3D of_platform_device_create(dcp_subsystem_node, busid, vdev->dev=
.parent);
> +	if (!pdev) {
> +		dev_err(&vdev->dev, "dcp_subsystem_dev creation failed\n");
> +		of_node_put(dcp_subsystem_node);
> +		return -ENODEV;
> +	}
> +	dev =3D &pdev->dev;
> +
> +	dev->dma_parms =3D &drv->dcp_subsystem_dma_parms;
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
> +	ret =3D of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
> +	if (ret) {
> +		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
> +		goto err_destroy;
> +	}

[Severity: Medium]
Should dcp_subsystem_dev_init() also call dma_set_mask_and_coherent(dev, ~0)
after of_dma_configure_id()?

of_platform_device_create() initializes pdev->dev.coherent_dma_mask to
DMA_BIT_MASK(32) and sets pdev->dev.dma_mask to point to it, and
of_dma_configure_id() only bitwise-ANDs those masks without widening them.

Other MSM KMS master devices go through msm_drv_probe() in
drivers/gpu/drm/msm/msm_drv.c:

    ret =3D dma_set_mask_and_coherent(master_dev, ~0);
    if (ret)
        return ret;

Without widening the mask on dcp_subsystem_dev->dev (which becomes ddev->dev
and drm_dev_dma_dev(ddev)), DMA operations such as dma_map_sgtable() in
sync_for_device() in drivers/gpu/drm/msm/msm_gem.c or PRIME imports are
restricted to 32-bit addressing, causing SWIOTLB bounce buffering or mapping
failures for 2 MiB THP GEM folios above 4 GiB when passthrough DMA is used,
and limiting default-domain IOVA allocations to 32 bits under iommu-dma.

[ ... ]

> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
> +{
> +	if (!drv->dcp_subsystem_dev)
> +		return;
> +
> +	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
> +	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
> +	of_node_put(drv->dcp_subsystem_node);
> +	drv->dcp_subsystem_dev =3D NULL;
> +}

[Severity: Medium]
Does this result in an unbalanced pm_runtime_disable() on
drv->dcp_subsystem_dev->dev?

In dcp_subsystem_dev_init(), pm_runtime_enable(dev) is called once on
&drv->dcp_subsystem_dev->dev. Later, dcp_virtio_probe() sets
dcp_kms->pm_dev =3D &drv->dcp_subsystem_dev->dev and dcp_kms->rpm_enabled =
=3D true
without a matching pm_runtime_enable() call.

When the DRM component master is torn down via dcp_component_unregister() ->
component_master_del() -> msm_drm_unbind() -> msm_drm_uninit() ->
msm_drm_kms_uninit() -> dcp_dpu_kms_destroy() in
drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c:

    if (dcp_kms->rpm_enabled) {
        pm_runtime_disable(dcp_kms->pm_dev);
        dcp_kms->rpm_enabled =3D false;
    }

dcp_dpu_kms_destroy() disables runtime PM on dcp_kms->pm_dev, and then
dcp_subsystem_dev_deinit() calls pm_runtime_disable() a second time on the
same device.

In addition, if a subordinate component unbinds (or if msm_drm_init() fails
after component_bind_all() during a deferred bind), dcp_dpu_kms_destroy()
disables runtime PM on dcp_subsystem_dev->dev and clears
dcp_kms->rpm_enabled, causing any subsequent bind attempt to fail in
dcp_dpu_kms_hw_init() -> pm_runtime_resume_and_get() with -EACCES.

[ ... ]

> +int dcp_component_register(struct dcp_drv *drv)
> +{
> +	struct device *dev =3D &drv->dcp_subsystem_dev->dev;
> +	struct component_match *match =3D NULL;
> +	int ret;
> +
> +	ret =3D dcp_dpu_kms_init_dsi_bridges(drv->kms, &match);
> +	if (ret) {
> +		dev_err(dev, "DSI host initialization failed: %d\n", ret);
> +		dcp_dpu_kms_cleanup_bridges(drv->kms);
> +		return ret;
> +	}

[Severity: Medium]
Can dcp_dpu_kms_init_dsi_bridges() -> dcp_dsi_bridge_init() leak the
dcp_np device_node reference on error?

In drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c, dcp_dsi_bridge_init() takes a
reference with dsi_bridge->dcp_np =3D of_node_get(dcp_np). If a subsequent
dma_alloc_coherent(), device_add(), or mipi_dsi_host_register() call fails,
it jumps to err_unwind_dma:

err_unwind_dma:
    if (dsi_bridge->dcs_rx_buf) {
        dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
                  dsi_bridge->dcs_rx_buf,
                  dsi_bridge->dcs_rx_iova);
    }
    if (dsi_bridge->dcs_tx_buf) {
        dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
                  dsi_bridge->dcs_tx_buf,
                  dsi_bridge->dcs_tx_iova);
    }
    cancel_work_sync(&dsi_bridge->power_control_work);
    mutex_destroy(&dsi_bridge->session_lock);
    mutex_destroy(&dsi_bridge->dcs_lock);
    return ERR_PTR(ret);

Because dcp_dsi_bridge_init() returns ERR_PTR(ret) before the bridge is
stored in dcp_kms->dsi_bridge[dsi_idx], dcp_dpu_kms_cleanup_bridges() will
not clean it up, and err_unwind_dma never calls
of_node_put(dsi_bridge->dcp_np).

> +
> +	/* A GPU is optional for the DCP display-only DRM device. */
> +	msm_add_gpu_components(dev, &match);
> +
> +	ret =3D component_master_add_with_match(dev, &msm_drm_ops, match);
> +	if (ret) {
> +		dev_err(dev, "component_master_add_with_match failed: %d\n",
> +			ret);
> +		dcp_dpu_kms_cleanup_bridges(drv->kms);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
What happens in dcp_component_register() when msm_separate_gpu_kms_componen=
ts()
is true, or when match is NULL or an error pointer?

First, msm_drv_probe() in drivers/gpu/drm/msm/msm_drv.c guards
msm_add_gpu_components() with:

    if (!msm_separate_gpu_kms_components()) {
        ret =3D msm_add_gpu_components(master_dev, &match);
        if (ret)
            return ret;
    }

When msm_separate_gpu_kms_components() returns true (for example, when
separate_gpu_kms=3D1 is set or in multi-GPU configurations), adreno_probe()=
 in
drivers/gpu/drm/msm/adreno/adreno_device.c probes the GPU as a standalone D=
RM
device via msm_gpu_probe() instead of calling component_add(). Calling
msm_add_gpu_components() unconditionally here adds a GPU component to match
that will never be registered, preventing the DCP DRM master from ever
binding.

Second, drm_of_component_match_add() -> __component_match_add() sets
*matchptr =3D ERR_PTR(-ENOMEM) on allocation failure while
dcp_dpu_kms_init_dsi_bridges() and msm_add_gpu_components() still return 0,
and match remains NULL if neither DSI bridges nor GPU components are matche=
d.
Passing a NULL or ERR_PTR(match) to component_master_add_with_match() in
drivers/base/component.c immediately dereferences match->num:

    ret =3D component_match_realloc(match, match->num);

> +
> +void dcp_component_unregister(struct dcp_drv *drv)
> +{
> +	struct device *dev =3D &drv->dcp_subsystem_dev->dev;
> +
> +	component_master_del(dev, &msm_drm_ops);
> +	dcp_dpu_kms_cleanup_bridges(drv->kms);
> +}

[Severity: High]
Won't component_master_del() self-deadlock on component_mutex when a MIPI D=
SI
device is attached to the DCP DSI host?

During probe, dcp_dpu_kms_init_dsi_bridges() registers the MIPI DSI host, a=
nd
when a DSI panel attaches, dcp_dsi_host_attach() in
drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c calls component_add() and sets
dsi_bridge->component_added =3D true.

On removal (or if msm_drm_init() fails after component_bind_all() and unwin=
ds
through msm_drm_uninit()), component_master_del() acquires component_mutex =
in
drivers/base/component.c and runs the following call chain while holding
component_mutex:

    component_master_del() [locks component_mutex]
      -> take_down_aggregate_device()
        -> msm_drm_unbind()
          -> msm_drm_uninit()
            -> msm_drm_kms_uninit()
              -> dcp_dpu_kms_destroy()
                -> dcp_dpu_kms_cleanup_bridges()
                  -> dcp_dsi_bridge_cleanup()
                    -> mipi_dsi_host_unregister()
                      -> mipi_dsi_remove_device_fn()
                        -> mipi_dsi_detach()
                          -> dcp_dsi_host_detach()
                            -> component_del() [locks component_mutex]

Because component_del() attempts to acquire component_mutex on the same
thread, this deadlocks deterministically. Additionally, msm_drm_kms_uninit()
runs before component_unbind_all() in msm_drm_uninit(), so
dcp_dsi_bridge_cleanup() calls device_del(&dsi_bridge->dsi_host_dev) and
put_device(&dsi_bridge->dsi_host_dev) while the component is still bound.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/d=
cp/dcp_virtio.c
> new file mode 100644
> index 0000000000000..15d5caf02ff58
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c

[ ... ]

> @@ -0,0 +1,258 @@
> +static int dcp_virtio_probe(struct virtio_device *vdev)
> +{

[ ... ]

> +	ret =3D dcp_hfi_init(drv, vdev, vqs[DCP_VQ_CMD], vqs[DCP_VQ_RESP],
> +			   vdev->dev.parent);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI init failed: %d\n", ret);
> +		goto err_del_vqs;
> +	}
> +
> +	dcp_ipcc_set_resp_vq(drv->ipcc, vqs[DCP_VQ_RESP]);
> +
> +	/*
> +	 * Keep the device unready until HFI state and virtqueues are initializ=
ed.
> +	 * KMS registration below depends on synchronous firmware initializatio=
n.
> +	 */
> +	virtio_device_ready(vdev);
> +	virtqueue_kick(drv->hfi->resp_vq);

[Severity: High]
Is access to drv->hfi->resp_vq properly serialized across dcp_virtio_probe(=
),
dcp_ipcc_handle_rx(), and dcp_hfi_resp_callback()?

Here in dcp_virtio_probe(), dcp_ipcc_set_resp_vq() publishes resp_vq to the
IPCC interrupt/RX handler and virtio_device_ready() enables virtqueue
callbacks before virtqueue_kick(drv->hfi->resp_vq) is called without holding
any lock.

In drivers/gpu/drm/msm/dcp/dcp_hfi_core.c, dcp_hfi_resp_callback() and
dcp_hfi_resp_repost_work() serialize resp_vq operations under
hfi->resp_drain_lock, whereas dcp_ipcc_handle_rx() in
drivers/gpu/drm/msm/dcp/dcp_ipcc.c calls virtqueue_kick_prepare(ipcc->resp_=
vq)
under ipcc->state_lock without acquiring hfi->resp_drain_lock:

    complete(&ipcc->power_notify_done);
    if (ipcc->resp_vq && virtqueue_kick_prepare(ipcc->resp_vq))
        virtqueue_notify(ipcc->resp_vq);

Can concurrent calls to virtqueue_kick_prepare() and
virtqueue_add_inbuf_premapped() / virtqueue_get_buf() / virtqueue_enable_cb=
()
on resp_vq corrupt vq->num_added in virtio_ring.c or trigger START_USE(vq)
assertions?

[ ... ]

> +	dcp_kms =3D devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dcp_kms)=
, GFP_KERNEL);
> +	if (!dcp_kms) {
> +		ret =3D -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	dcp_kms->drv       =3D drv;
> +	dcp_kms->pm_dev    =3D &drv->dcp_subsystem_dev->dev;
> +	dcp_kms->hfi       =3D drv->hfi;
> +	dcp_kms->caps      =3D &drv->caps;
> +	dcp_kms->dpus_np   =3D drv->dcp_subsystem_node;
> +	dcp_kms->iommu_dev =3D &drv->dcp_subsystem_dev->dev;
> +	drv->kms        =3D dcp_kms;
> +
> +	ret =3D msm_kms_init(&dcp_kms->base, &dcp_dpu_kms_funcs);
> +	if (ret) {
> +		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv =3D devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_=
KERNEL);
> +	if (!priv) {
> +		ret =3D -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv->kms      =3D &dcp_kms->base;
> +	priv->kms_init =3D dcp_kms_init;
> +	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
> +	dcp_kms->rpm_enabled =3D true;
> +
> +	/* Component binding now sees initialized HFI, capabilities, and IOMMU =
state. */
> +	ret =3D dcp_component_register(drv);
> +	if (ret) {
> +		dev_err_probe(&vdev->dev, ret, "component register failed\n");
> +		goto err_hfi_deinit;
> +	}

[Severity: High]
Does jumping to err_hfi_deinit after msm_kms_init() (or removing the driver
in dcp_virtio_remove() when the component master never bound) leak kms->wq
and the pending_timers kthreads, and cause a use-after-free on dcp_kms?

msm_kms_init() in drivers/gpu/drm/msm/msm_kms.h allocates the ordered "msm"
workqueue (kms->wq) and initializes kms->pending_timers[] via
msm_atomic_init_pending_timer(), which spawns real-time kthread_worker
threads holding pointers into dcp_kms->base.

However, msm_kms_destroy(&dcp_kms->base) is only called from
dcp_dpu_kms_destroy() when a bound DRM aggregate device is torn down via
msm_drm_uninit(). If allocating priv or calling dcp_component_register(drv)
fails in dcp_virtio_probe(), or if dcp_virtio_remove() runs while component
binding is still pending or deferred, dcp_subsystem_dev_deinit() destroys
drv->dcp_subsystem_dev via of_platform_device_destroy() and frees the
devm-allocated dcp_kms while kms->wq and the atomic-worker kthreads/hrtimers
remain active.

> +
> +	dcp_panic_notifier_register(drv);
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO probe complete\n");
> +	return 0;
> +
> +err_hfi_deinit:
> +	dcp_virtio_hfi_cleanup(drv);
> +	goto err_fn_dev;
> +err_del_vqs:
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +err_fn_dev:
> +	dcp_subsystem_dev_deinit(drv);
> +	return ret;
> +}
> +
> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev =3D drv->vdev;
> +
> +	if (!drv->hfi)
> +		return;
> +
> +	dcp_ipcc_set_resp_vq(drv->ipcc, NULL);
> +
> +	dcp_hfi_stop(drv->hfi);
> +	virtio_reset_device(vdev);
> +	virtio_synchronize_cbs(vdev);
> +	dcp_hfi_quiesce_queues(drv->hfi);
> +	vdev->config->del_vqs(vdev);
> +	dcp_hfi_deinit(drv->hfi);
> +}

[Severity: High]
Can an in-flight dcp_hfi_resp_callback() re-queue resource_vote_work or
resp_repost_work after dcp_hfi_stop() has cancelled them in
dcp_virtio_hfi_cleanup()?

In dcp_virtio_hfi_cleanup(), dcp_hfi_stop() sets hfi->shutdown_in_progress =
=3D 1
and calls cancel_work_sync(&hfi->resource_vote_work) and
cancel_delayed_work_sync(&hfi->resp_repost_work) before virtio_reset_device=
()
and virtio_synchronize_cbs() have finished draining running virtqueue
callbacks.

If dcp_hfi_resp_callback() in drivers/gpu/drm/msm/dcp/dcp_hfi_core.c already
passed its initial atomic_read(&hfi->shutdown_in_progress) check on another
CPU, it drops hfi->resp_drain_lock while parsing packets and can schedule
hfi->resource_vote_work or hfi->resp_repost_work after dcp_hfi_stop()
returned. Because neither dcp_hfi_quiesce_queues() nor dcp_hfi_deinit()
cancels those work items after virtio_synchronize_cbs(), can those work ite=
ms
remain pending in freed struct dcp_hfi memory?

[ ... ]

> +/* KMS shutdown must complete while the firmware transport is available.=
 */
> +static void dcp_virtio_shutdown(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv =3D vdev->priv;
> +
> +	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
> +	msm_kms_shutdown(drv->dcp_subsystem_dev);
> +	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
> +}

[Severity: Medium]
Should dcp_virtio_shutdown() also stop HFI activity, clear ipcc->resp_vq, a=
nd
reset/quiesce the VirtIO device after msm_kms_shutdown()?

In drivers/virtio/virtio.c, virtio_dev_shutdown() skips the default
virtio_device_shutdown(dev) path whenever a driver provides its own
.shutdown callback:

    /* If the driver has its own shutdown method, use that. */
    if (drv->shutdown) {
        drv->shutdown(dev);
        return;
    }

    virtio_device_shutdown(dev);

Because dcp_virtio_shutdown() only runs msm_kms_shutdown(), it returns
without clearing ipcc->resp_vq via dcp_ipcc_set_resp_vq(drv->ipcc, NULL),
without calling dcp_hfi_stop(drv->hfi) to cancel resource_vote_work and
resp_repost_work, and without calling virtio_device_shutdown(vdev) (or
breaking and resetting the virtqueues), leaving the VirtIO DMA rings and
pre-posted HFI response buffers active while downstream SMMU shutdown
disables translation.

> +
> +static const struct virtio_device_id dcp_virtio_id_table[] =3D {
> +	{ VIRTIO_ID_QPSFI, VIRTIO_VENDOR_ID_DCP_HFI },
> +	{ 0 },
> +};
> +MODULE_DEVICE_TABLE(virtio, dcp_virtio_id_table);
> +
> +static const struct dev_pm_ops dcp_virtio_pm_ops =3D {
> +	.prepare =3D dcp_pm_prepare,
> +	.complete =3D dcp_pm_complete,
> +};
> +
> +static struct virtio_driver dcp_virtio_driver =3D {
> +	.driver =3D {
> +		.name  =3D "qcom-dcp-hfi",
> +		.owner =3D THIS_MODULE,
> +		.pm    =3D &dcp_virtio_pm_ops,
> +	},
> +	.id_table           =3D dcp_virtio_id_table,
> +	.feature_table      =3D dcp_virtio_features,
> +	.feature_table_size =3D ARRAY_SIZE(dcp_virtio_features),
> +	.probe              =3D dcp_virtio_probe,
> +	.remove             =3D dcp_virtio_remove,
> +	.shutdown           =3D dcp_virtio_shutdown,
> +};

[Severity: High]
How are virtqueues and HFI state preserved across system suspend and resume
without .freeze and .restore callbacks on dcp_virtio_driver?

In drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c,
dcp_virtio_transport_suspend() calls virtio_device_freeze(&transport->vdev)
and dcp_virtio_transport_resume() calls
virtio_device_restore(&transport->vdev).

In drivers/virtio/virtio.c, virtio_device_freeze() invokes drv->freeze(dev)
to quiesce driver activity and delete virtqueues before sleep, and
virtio_device_restore_priv() unconditionally calls virtio_reset_device(dev)
(which calls dcp_virtio_reset() and writes 0 to VIRTIO_MMIO_STATUS, resetti=
ng
hardware queue state) before invoking drv->restore(dev) to recreate the
virtqueues.

With .freeze and .restore left NULL on dcp_virtio_driver, HFI work items and
virtqueues are not torn down during suspend, and on resume the VirtIO MMIO
device is reset without recreating cmd_vq and resp_vq or reposting HFI
response buffers, leaving the virtqueues unusable when dcp_pm_complete()
resumes KMS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D20
