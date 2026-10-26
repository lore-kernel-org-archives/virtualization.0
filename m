Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021098;
	b=M7W8XvY93WU7rZKMZsLSLMWT4pZtt/jQIjy2JHYmpCP6ng85n+hnrjGMUmAy6RtEqDDh
	 vkm/bh+5mM8o9Nsnu4IsTMmNhd6KKWozJ5JubJsnn8ZH1tJPu0ptAXkwYYupirDdtswRt
	 xrTyiO8LJAi/IuRyMSaZ2C2h36un2mBYAZuRdhHRVLQRGMiircp0TDBNlXG7A/OfmgOks
	 Xh4y0oDwExN5NDTXAjYYbf/QDf82dbrJHJQu7mE7hHpdywmRjzh2tBM0lsB5W9+e5rSnr
	 Acm4pox4YDiTeitTUiZMv3dt96Ktacn9zEnDJmmwClQRokauNEgRczoLLjDVhS6HnPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RAZuT03HTn/udnmMaEZSmIRI0nqa8DRHM5i7rHrvtU0=;
	b=kKqiOWa/0a2+GKdLz2AN6/TJs2hJdjRqSlwlaoa5CP+vhoEsa/RE+iglFEF+A3HIIWwF
	 08hwSsaNeGttdT6Kzr0/JcTskJWCVX6E2TcNyBNKwdbl+ttbdlift3vMR4TLCpnmj2vr3
	 OCodAUGiID8BXf6HoNImWHlLlrkz/gJCRcP6L2Es2k/+GGVUATJ2VJXAqAa7669I3LbK9
	 1YdgOC0/3a1Fu4ebv6fnxRA0dFIK9yn1h8u6tfWvKWmFqL2mJL96HALEOsElTcdzw9OFx
	 JMXoXzSS55klJvCpUtTFztf25RAPJQzSik1RMiltjLP05IQzDPOb5mCFbj2un6mazfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgMNATh8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E83606A31A;
	Mon, 26 Oct 2026 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QgMNATh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F99F1F01825;
	Mon, 26 Oct 2026 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793021097;
	bh=RAZuT03HTn/udnmMaEZSmIRI0nqa8DRHM5i7rHrvtU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QgMNATh8tg8wne169TeOtGhgKlrqzOlUn5Cvm/NGxS+UvbssCOVmtL2DDqdIgPhvO
	 LrHEe4pPkrAuDhPmCCub6Z55oAVvUCsbSyBQ3QFATQDPztCH5YRkOyf9zojpLkyK86
	 7QjLhjwbnTgnr6FlyK4eOAbba5EX1pd0TdpuJzT2D2QqGhvomVcGicX7agrO4dQHB7
	 JqzDaErdCuy4JbgUtGMQGlbw27axYAm0rrQWLLbUYaz8kt9m5ULPg04P7fhkL7vB8q
	 JDmMFjKBcQPCGC/Bt91EjgFJpaU6A8HjShWoGMXjoLOVxPXch+zdtQUbwJpQ/nVWGE
	 fXzjPWJAQ99xQ==
Message-ID: <sashiko-outbox-185304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/23] drm/msm/dcp: Register DCP display pipeline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-17-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-17-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:24:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/msm/dcp: dcp_dpu_kms_cleanup_bridges() called under component_=
mutex
- [High] drm/msm/dcp: missing remote port check and sequential bridge lookup
- [High] drm/msm/dcp: race and runtime PM leak in dcp_dpu_kms_enable_commit=
()
- [High] drm/msm/dcp: unbalanced msm_kms and runtime PM teardown in dcp_dpu=
_kms_destroy()
- [High] drm/msm/dcp: dangling CRTC and drm_device pointers in dcp_dpu_kms_=
destroy()
- [Medium] drm/msm/dcp: invalid possible_crtcs mask when max_crtc_count is =
clamped
--

commit 5fc21d18f27dcbb7ac8d64f95bc52703e58d9984
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Register DCP display pipeline

This commit registers the DCP display pipeline using firmware capabilities
and the device-tree display graph, integrating runtime PM and IOMMU setup a=
nd
creating the DRM planes, CRTCs, encoders, bridges, and connectors.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/=
dcp/dcp_dpu_kms.c
> index 61a4d85653594..8a73a99b2c763 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c

[ ... ]

> @@ -59,3 +78,609 @@ bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dc=
p_kms,
> =20
>  	return false;
>  }
> +
> +void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dcp_kms)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
> +		if (!dcp_kms->dsi_bridge[i])
> +			continue;
> +
> +		dcp_dsi_bridge_cleanup(dcp_kms->dsi_bridge[i]);
> +		dcp_kms->dsi_bridge[i] =3D NULL;
> +	}
> +}

[Severity: High]
Will calling dcp_dpu_kms_cleanup_bridges() from dcp_dpu_kms_setup_bridges(),
dcp_dpu_setup_pipeline(), or dcp_dpu_kms_destroy() deadlock on
component_mutex and break deferred probe retries?

Before registering the aggregate component master, dcp_component_register()
calls dcp_dpu_kms_init_dsi_bridges() -> dcp_dsi_bridge_init(), which
registers dsi_host_dev and mipi_dsi_host and adds each dsi_np to the
component match list. When the DSI panel attaches, dcp_dsi_host_attach()
calls component_add(&dsi_bridge->dsi_host_dev, &dcp_dsi_component_ops).

Once all components are added, drivers/base/component.c holds the non-
recursive component_mutex across both aggregate bind and unbind:

  try_to_bring_up_aggregate_device() [holds component_mutex]
    -> msm_drm_bind()
      -> msm_drm_init()
        -> msm_drm_kms_init()
          -> dcp_dpu_kms_hw_init()
            -> dcp_dpu_drm_obj_init()
              -> dcp_dpu_setup_pipeline()
                -> dcp_dpu_kms_setup_bridges()

  take_down_aggregate_device() [holds component_mutex]
    -> msm_drm_unbind()
      -> msm_drm_uninit()
        -> msm_drm_kms_uninit()
          -> dcp_dpu_kms_destroy()

When dcp_dpu_kms_cleanup_bridges() runs from any of those paths, it calls:

  dcp_dsi_bridge_cleanup()
    -> mipi_dsi_host_unregister()
      -> mipi_dsi_remove_device_fn()
        -> mipi_dsi_detach()
          -> dcp_dsi_host_detach()
            -> component_del(&dsi_bridge->dsi_host_dev, ...)

which tries to acquire component_mutex while it is already held by the
calling thread.

In addition, in msm_drm_uninit(), msm_drm_kms_uninit() runs before
component_unbind_all() and drm_dev_put(), so dcp_dpu_kms_destroy() tears do=
wn
the bridges and deletes dsi_host_dev while it is still bound as a component
and attached to encoder->bridge_chain. Destroying and clearing
dcp_kms->dsi_bridge[] on error or -EPROBE_DEFER in dcp_dpu_kms_setup_bridge=
s()
or dcp_dpu_setup_pipeline() also prevents any subsequent deferred probe ret=
ry
from succeeding because dcp_dpu_kms_init_dsi_bridges() only runs once before
component_master_add_with_match().

[ ... ]

> +static void dcp_dpu_kms_enable_commit(struct msm_kms *kms)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(kms);
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dcp_kms->pm_dev);
> +	if (ret < 0) {
> +		dcp_kms->commit_pm_active =3D false;
> +		drm_err_ratelimited(dcp_kms->dev,
> +				    "pm_runtime_resume_and_get failed: %d\n",
> +				    ret);
> +		return;
> +	}
> +
> +	dcp_kms->commit_pm_active =3D true;
> +}
> +
> +static void dcp_dpu_kms_disable_commit(struct msm_kms *kms)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(kms);
> +
> +	if (dcp_kms->commit_pm_active) {
> +		pm_runtime_put_autosuspend(dcp_kms->pm_dev);
> +		dcp_kms->commit_pm_active =3D false;
> +	}
> +}

[Severity: High]
Can overlapping commits race on dcp_kms->commit_pm_active and leak a runtime
PM reference on dcp_kms->pm_dev?

msm_atomic_commit_tail() calls kms->funcs->enable_commit(kms) before
lock_crtcs(kms, crtc_mask) and calls kms->funcs->disable_commit(kms) after
unlock_crtcs(kms, crtc_mask), while msm_atomic_async_commit() also calls
enable_commit() and disable_commit() from per-CRTC worker threads, and
commits on separate CRTCs execute concurrently.

If two commits overlap between dcp_dpu_kms_enable_commit() and
dcp_dpu_kms_disable_commit():

1. Both commits call pm_runtime_resume_and_get(dcp_kms->pm_dev) and set the
   single shared boolean dcp_kms->commit_pm_active =3D true.
2. When the first commit finishes and calls dcp_dpu_kms_disable_commit(), it
   calls pm_runtime_put_autosuspend(dcp_kms->pm_dev) once and sets
   dcp_kms->commit_pm_active =3D false.
3. The second in-flight commit then sees !dcp_kms->commit_pm_active in
   dcp_crtc_atomic_begin() (failing the commit with cstate->hfi_error =3D -=
EIO),
   and when it reaches dcp_dpu_kms_disable_commit() it sees
   dcp_kms->commit_pm_active =3D=3D false and skips
   pm_runtime_put_autosuspend(dcp_kms->pm_dev), leaking its runtime PM usage
   count.

[ ... ]

> +static void dcp_dpu_kms_destroy(struct msm_kms *kms)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(kms);
> +
> +	dcp_dpu_kms_cleanup_bridges(dcp_kms);
> +
> +	if (kms->vm) {
> +		struct msm_gem_vm *msm_vm =3D to_msm_vm(kms->vm);
> +
> +		if (msm_vm->mmu && msm_vm->mmu->funcs->detach) {
> +			drm_dbg_driver(dcp_kms->dev,
> +				       "detaching IOMMU domain from dcp-dpus\n");
> +			msm_vm->mmu->funcs->detach(msm_vm->mmu);
> +		}
> +
> +		drm_gpuvm_put(kms->vm);
> +		kms->vm =3D NULL;
> +	}
> +
> +	if (dcp_kms->rpm_enabled) {
> +		pm_runtime_disable(dcp_kms->pm_dev);
> +		dcp_kms->rpm_enabled =3D false;
> +	}
> +
> +	msm_kms_destroy(&dcp_kms->base);
> +}

[Severity: High]
Is the teardown in dcp_dpu_kms_destroy() balanced with dcp_kms_init() across
deferred probe or component rebind?

In msm_drm_init(), msm_drm_kms_init() calls priv->kms_init(ddev)
(dcp_kms_init()) and kms->funcs->hw_init(kms) (dcp_dpu_kms_hw_init()). If
msm_drm_kms_init() fails (for instance with -EPROBE_DEFER when a panel is n=
ot
ready in dcp_dpu_kms_setup_bridges()) or when the aggregate device unbinds,
msm_drm_uninit() calls msm_drm_kms_uninit(), which flushes kms->wq and calls
dcp_dpu_kms_destroy().

However, msm_kms_init(&dcp_kms->base, &dcp_dpu_kms_funcs) and
pm_runtime_enable(&drv->dcp_subsystem_dev->dev) are only called once during
virtio probe (in dcp_virtio_probe() and dcp_subsystem_dev_init()), not in
dcp_kms_init(). When dcp_dpu_kms_destroy() runs:

- pm_runtime_disable(dcp_kms->pm_dev) disables runtime PM on pm_dev (and on
  driver removal, dcp_subsystem_dev_deinit() calls pm_runtime_disable() a
  second time on the same device).
- msm_kms_destroy(&dcp_kms->base) destroys kms->wq and kms->pending_timers[=
],
  leaving kms->wq as a dangling pointer that will be flushed and destroyed
  again on a subsequent bind attempt or uninit.

[Severity: High]
Does dcp_dpu_kms_destroy() (and the error path in dcp_dpu_setup_pipeline())
leave dangling CRTC and drm_device pointers reachable from HFI event
callbacks?

dcp_kms_init() sets dcp_kms->dev =3D ddev and drv->kms =3D dcp_kms, and
dcp_dpu_setup_pipeline() populates dcp_kms->crtcs[] with CRTCs allocated via
drmm_kzalloc(ddev, ...) in dcp_crtc_init() and increments dcp_kms->num_crtc=
s.

When msm_drm_uninit() runs on init failure, component unbind, or during
dcp_virtio_remove() -> dcp_component_unregister() before
dcp_virtio_hfi_cleanup() stops the VirtIO queues, drm_dev_put(ddev) frees
ddev and all drmm-managed dcp_crtc instances while dcp_kms and drv remain
allocated. Because neither dcp_dpu_kms_destroy() nor
dcp_dpu_setup_pipeline()'s error path clears dcp_kms->num_crtcs,
dcp_kms->crtcs[], dcp_kms->dev, or drv->kms, an incoming
HFI_COMMAND_DISPLAY_EVENT_VSYNC or
HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE message in
dcp_hfi_resp_callback() will invoke dcp_crtc_hfi_vblank_cb() or
dcp_crtc_hfi_frame_done_cb() and dereference the freed dcp_crtc or drm_devi=
ce.

[ ... ]

> +int dcp_dpu_kms_init_dsi_bridges(struct dcp_dpu_kms *dcp_kms,
> +				 struct component_match **matchptr)
> +{
> +	struct device_node *dpu_np =3D dcp_kms->dpus_np;
> +	struct device_node *ep_np, *dsi_np, *child_np;
> +	struct of_endpoint ep;
> +	int ret;
> +
> +	for_each_of_graph_port(dpu_np, port_np) {
> +		u32 dsi_idx, fw_display_id;
> +		struct drm_bridge *bridge;
> +
> +		ep_np =3D of_get_next_child(port_np, NULL);
> +		if (!ep_np)
> +			continue;
> +
> +		ret =3D of_graph_parse_endpoint(ep_np, &ep);
> +		of_node_put(ep_np);
> +		if (ret)
> +			continue;
> +
> +		dsi_idx =3D ep.port;
> +		if (dsi_idx >=3D ARRAY_SIZE(dcp_kms->dsi_bridge))
> +			return -E2BIG;
> +
> +		if (dcp_kms->dsi_bridge[dsi_idx])
> +			continue;
> +
> +		dsi_np =3D NULL;
> +		for_each_available_child_of_node(dpu_np, child_np) {
> +			u32 reg;
> +
> +			if (!of_node_name_prefix(child_np, "dsi") ||
> +			    of_property_read_u32(child_np, "reg", &reg) ||
> +			    reg !=3D dsi_idx)
> +				continue;
> +
> +			dsi_np =3D of_node_get(child_np);
> +			break;
> +		}
> +		of_node_put(child_np);
> +		if (!dsi_np)
> +			return -ENODEV;
> +
> +		fw_display_id =3D
> +			dcp_dpu_kms_resolve_fw_display_id(dcp_kms, dsi_idx);
> +		if (fw_display_id =3D=3D U32_MAX) {
> +			of_node_put(dsi_np);
> +			return -EINVAL;
> +		}
> +
> +		bridge =3D dcp_dsi_bridge_init(dcp_kms, dsi_np, dpu_np,
> +					     ep.port, dsi_idx, fw_display_id);
> +		if (IS_ERR(bridge)) {
> +			ret =3D PTR_ERR(bridge);
> +			of_node_put(dsi_np);
> +			return ret;
> +		}
> +
> +		dcp_kms->dsi_bridge[dsi_idx] =3D to_dcp_dsi_bridge(bridge);
> +		drm_of_component_match_add(dcp_kms->pm_dev, matchptr,
> +					   component_compare_of, dsi_np);
> +		of_node_put(dsi_np);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int dcp_dpu_setup_pipeline(struct dcp_dpu_kms *dcp_kms,
> +				  struct device_node *dpu_np)
> +{

[ ... ]

> +	dcp_kms->num_crtcs =3D 0;
> +	for (i =3D 0; i < max_crtc_count; i++) {
> +		u32 display_id;
> +
> +		if (!dcp_kms->dsi_bridge[i]) {
> +			drm_err(dev, "missing DSI bridge for CRTC%u\n", i);
> +			ret =3D -ENODEV;
> +			goto err_cleanup_bridges;
> +		}
> +
> +		display_id =3D dcp_kms->dsi_bridge[i]->fw_display_id;

[Severity: High]
What happens if a DT graph port has no available remote panel or if port@0 =
is
omitted or disabled while port@1 is active?

First, dcp_dpu_kms_setup_bridges() checks of_graph_get_remote_port_parent()
and of_device_is_available(remote_np) and skips ports without an available
panel, but dcp_dpu_kms_init_dsi_bridges() does not perform this check before
creating dcp_kms->dsi_bridge[dsi_idx] and adding dsi_np to matchptr via
drm_of_component_match_add(). Because component_add() is only called from
dcp_dsi_host_attach() when a panel driver attaches to the DSI host, any
unpopulated or disabled panel endpoint in DT will prevent the component
master from ever binding.

Second, both dcp_dpu_kms_init_dsi_bridges() and dcp_dpu_kms_setup_bridges()
index dcp_kms->dsi_bridge[] by ep.port, whereas dcp_dpu_setup_pipeline()
loops from i =3D 0 to max_crtc_count - 1 and looks up dcp_kms->dsi_bridge[i]
using the sequential CRTC index i. If port@0 is absent or disabled and only
port@1 is active, dcp_kms->dsi_bridge[1] holds the active bridge while
max_crtc_count is 1, so dcp_dpu_setup_pipeline() checks
dcp_kms->dsi_bridge[0] and either fails with -ENODEV or binds CRTC 0 to the
wrong bridge's fw_display_id.

> +		if (dcp_dpu_kms_get_crtc(dcp_kms, display_id)) {
> +			drm_err(dev, "duplicate firmware display ID %u\n",
> +				display_id);
> +			ret =3D -EINVAL;
> +			goto err_cleanup_bridges;
> +		}
> +
> +		crtc =3D dcp_crtc_init(dcp_kms, primary_planes[i],
> +				     display_id);
> +		if (IS_ERR(crtc)) {
> +			ret =3D PTR_ERR(crtc);
> +			drm_err(dev, "CRTC init failed: %d\n", ret);
> +			goto err_cleanup_bridges;
> +		}
> +		dcp_kms->crtcs[dcp_kms->num_crtcs].crtc =3D crtc;
> +		dcp_kms->crtcs[dcp_kms->num_crtcs++].display_id =3D display_id;
> +	}
> +
> +	return 0;
> +
> +err_cleanup_bridges:
> +	dcp_dpu_kms_cleanup_bridges(dcp_kms);
> +	return ret;
> +}
> +
> +int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms)
> +{
> +	struct drm_device *dev =3D dcp_kms->dev;
> +	struct device_node *dpus_np =3D dcp_kms->dpus_np;
> +	struct drm_encoder *encoder;
> +	int enc_idx =3D 0;
> +	int ret;
> +
> +	if (!dpus_np) {
> +		drm_err(dev, "no DCP subsystem node =E2=80=94 cannot create DRM object=
s\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D dcp_dpu_setup_pipeline(dcp_kms, dpus_np);
> +	if (ret)
> +		return dev_err_probe(dev->dev, ret, "pipeline setup failed\n");
> +
> +	/* v1 - Encoders map one-to-one to CRTCs; cloning is unsupported. */
> +	drm_for_each_encoder(encoder, dev) {
> +		encoder->possible_crtcs =3D BIT(enc_idx);
> +		encoder->possible_clones =3D 0;
> +		enc_idx++;
> +	}

[Severity: Medium]
Can plane and encoder possible_crtcs masks reference non-existent CRTCs when
max_crtc_count is clamped in dcp_dpu_setup_pipeline()?

In dcp_dpu_setup_pipeline(), dcp_dpu_kms_setup_bridges() creates an encoder
for each active DSI port before CRTC and plane limits are applied:

  max_crtc_count =3D min(max_crtc_count, DCP_DPU_MAX_CRTCS);
  max_crtc_count =3D min_t(int, max_crtc_count,
                         dcp_kms->caps->num_displays);
  max_crtc_count =3D min_t(int, max_crtc_count,
                         ARRAY_SIZE(dcp_kms->dsi_bridge));

Then, during plane creation, possible_crtcs is computed from max_crtc_count
before max_crtc_count is clamped again to min(max_crtc_count, primary_idx).
Finally, in dcp_dpu_drm_obj_init(), every created encoder is assigned
encoder->possible_crtcs =3D BIT(enc_idx).

If caps->num_displays or total_planes clamps the number of created CRTCs
below the number of encoders, planes and encoders will have possible_crtcs
bits set for CRTC indices that do not exist, triggering a WARN() in
validate_encoder_possible_crtcs() during drm_mode_config_validate().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D17
