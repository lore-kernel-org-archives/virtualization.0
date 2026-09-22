Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAE31282F
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068386; cv=none; b=nG9Mlir0kI5DUagpZn+BG6FJoRE7WKhBrNGfpxKeuzN/1gYweGvMbj/xNA9N1/I2bR2nCNmx5RNzGoNxcNa6yqVdlJTRCkln9iOT0mAxo8uDROdmGIQgw8xR05Yj+g1VPVFkdN+dSaFra/ULJTpPCWVxJlHFkkiRTM08q/x3FB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068386; c=relaxed/simple;
	bh=8Q4gM0McMjESHxjUzbPBWqlqB5yQLJclDgBSkLIsmYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhsskTQMdG7cS/eWY82XvsIdvkBuh6EdygTQHwGfUXH+CDnvMTy9t8luH9cmMjLT/N5/Ec9MvkNU8sXLy21GYKlhRvCRDYmrjUHvPQVQVWfAUROznUdmpQWOpm/qbsKHJZw8hZVRkaO34mUNFgeF3LRgf8Z17zY8i0e7H5RJOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbA7qR5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbA7qR5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A41F000FF;
	Tue, 22 Sep 2026 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790068384;
	bh=OGNJDAQJgH5SCP52S6rTDIGwz7lWq3gikYuEnLLi5dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jbA7qR5mp2V+IX3cryo0ZdrultK6IrBh5rbPS4oSGr5RVMsaQ8tnc/HEy+sSmxYsj
	 2Qy4X7bsEhCkhZaYyzZVPFKPV1L3OP5DbnTIoyJBAfvJl3K7AbXlDbKNVaUT34jBDh
	 Cqum+ikjD0gVGoKqCJLldrB0eke+MdiRJR4a7OPD5Xov4whyuesesVa4KAej9zff/W
	 kfdPMbddULfMyV9mIBhrC+uX5SooutRIGAbsnmPz/qR8WurZPgkP7vuTx5eK5RyZxG
	 Egg8+AptgoA98P4mYsgc4rZPCJYpuNhQmVuW8XK3w7kuVYqcSWQgcMPmtVe1ewSMph
	 2f0N0LNKs7iEA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/1] cpufreq: virtio: add driver to report host
 frequency to guests
Reply-To: sashiko-reviews@lists.linux.dev
To: Baorui.Liu <baorliu@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260922090224.430-2-baorliu@amd.com>
References: <20260916073735.541-1-baorliu@amd.com>
 <20260922090224.430-2-baorliu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:13:04 +0000
Message-Id: <20260922091304.9A4A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] virtio: stack use-after-free of completion struct on timeout
- [High] virtio: DMA API violation by mapping same buffer for IN and OUT
- [High] virtio: global virtio_cpufreq_dev clobbered on secondary device pr=
obe
- [High] virtio: missing virtio_reset_device() before deleting virtqueues
- [High] virtio: data race in virtqueue access between IRQ handler and get()
- [High] cpufreq: explicit transition begin inside target_index causes dead=
lock
--

commit e9d1547c4f482aad7a2452a1f8c4a163f33031fa
Author: Baorui.Liu <baorliu@amd.com>

    cpufreq: virtio: add driver to report host frequency to guests

    Add a virtio frontend that queries the host for the frequency of the ma=
pped
    pCPU and exposes it through the cpufreq .get() callback.

    Link: https://lore.kernel.org/oe-kbuild-all/202609191437.OaXd0Blz-lkp@i=
ntel.com/

> diff --git a/drivers/cpufreq/virtio-cpufreq.c b/drivers/cpufreq/virtio-cp=
ufreq.c
> new file mode 100644
> index 0000000000000..aa04fd7fd3436
> --- /dev/null
> +++ b/drivers/cpufreq/virtio-cpufreq.c

[ ... ]

> +static int virtio_cpufreq_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_freqs freqs;
> +
> +	freqs.old =3D policy->cur;
> +	freqs.new =3D policy->freq_table[index].frequency;
> +
> +	/*
> +	 * This frontend does not change host frequency. It only keeps
> +	 * the cpufreq core in sync so userspace can observe values.
> +	 */
> +	cpufreq_freq_transition_begin(policy, &freqs);

[Severity: High]
Does this explicit call to cpufreq_freq_transition_begin() cause a deadlock?

The cpufreq core already handles frequency transitions by setting
policy->transition_ongoing and invoking cpufreq_freq_transition_begin()
prior to calling .target_index(). Calling it again here will hit a true
transition_ongoing flag and block forever on wait_event() inside the transi=
tion
begin sequence.

> +	cpufreq_freq_transition_end(policy, &freqs, 0);
> +
> +	return 0;
> +}

[ ... ]

> +static void virtio_cpufreq_vq_cb(struct virtqueue *vq)
> +{
> +	struct completion *done;
> +	unsigned int len;
> +
> +	while ((done =3D virtqueue_get_buf(vq, &len)) !=3D NULL)

[Severity: High]
Can this lockless access to the virtqueue in the IRQ handler race with
virtqueue_add_sgs() in virtio_cpufreq_get()?

If a timeout occurs in virtio_cpufreq_get(), the mutex is dropped, allowing
a new request to start. A delayed host reply can cause virtqueue_get_buf()
to execute concurrently with a new virtqueue_add_sgs() request, corrupting
the virtqueue free list.

> +		complete(done);

[Severity: Critical]
Does this write to a destroyed stack frame if a timeout occurred?

When virtio_cpufreq_get() times out, it returns and destroys the stack-allo=
cated
struct completion done. However, the pointer remains queued in the virtqueu=
e.
When the host eventually responds, the IRQ handler extracts the dangling po=
inter
and executes complete(done), causing stack memory corruption.

> +}
> +
> +static unsigned int virtio_cpufreq_get(unsigned int cpu)
> +{
> +	struct virtio_cpufreq *vc =3D virtio_cpufreq_dev;
> +	struct virtio_cpufreq_req *req;
> +	struct scatterlist out_sg, in_sg, *sgs[2];
> +	struct completion done;
> +	unsigned int freq_khz;
> +	int ret;
> +
> +	if (!vc || !vc->vq)
> +		return virtio_cpufreq_fallback(cpu);
> +
> +	req =3D kzalloc_obj(*req, GFP_KERNEL);
> +	if (!req)
> +		return virtio_cpufreq_fallback(cpu);
> +
> +	req->cpu_id =3D cpu_to_le32(cpu);
> +
> +	init_completion(&done);
> +	sg_init_one(&out_sg, req, sizeof(*req));
> +	sg_init_one(&in_sg, req, sizeof(*req));

[Severity: High]
Is it a violation of the DMA API to map the exact same buffer (req) for both
the OUT and IN scatterlists?

This causes the underlying DMA API to map the same memory with DMA_TO_DEVICE
and DMA_FROM_DEVICE concurrently, violating ownership rules and causing
bounce buffer (SWIOTLB) cache corruption. It also directly violates the
Virtio specification against descriptors containing both device-readable
and device-writable memory.

> +	sgs[0] =3D &out_sg;
> +	sgs[1] =3D &in_sg;
> +
> +	mutex_lock(&vc->lock);
> +	ret =3D virtqueue_add_sgs(vc->vq, sgs, 1, 1, &done, GFP_KERNEL);
> +	if (ret) {
> +		mutex_unlock(&vc->lock);
> +		kfree(req);
> +		return virtio_cpufreq_fallback(cpu);
> +	}
> +
> +	virtqueue_kick(vc->vq);
> +	ret =3D wait_for_completion_timeout(&done, msecs_to_jiffies(1000));
> +	mutex_unlock(&vc->lock);

[Severity: High]
Does dropping the mutex on timeout allow virtio_cpufreq_vq_cb() to race with
a new request?

> +
> +	if (!ret) {
> +		/*
> +		 * The buffer may still be on the virtqueue. Leak it
> +		 * rather than freeing while the host may still write.
> +		 */
> +		return virtio_cpufreq_fallback(cpu);

[Severity: Critical]
Does returning here abandon the stack-allocated struct completion done while
it is still in the virtqueue?

The function returns on timeout without removing the request from the
virtqueue. When the host eventually responds, virtio_cpufreq_vq_cb() will
call complete(done) on a destroyed stack frame.

> +	}

[ ... ]

> +static int virtio_cpufreq_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_cpufreq *vc;
> +	struct virtqueue *vq;
> +	int ret;
> +
> +	vc =3D devm_kzalloc(&vdev->dev, sizeof(*vc), GFP_KERNEL);
> +	if (!vc)
> +		return -ENOMEM;
> +
> +	mutex_init(&vc->lock);
> +	vc->vdev =3D vdev;
> +
> +	vq =3D virtio_find_single_vq(vdev, virtio_cpufreq_vq_cb, "requests");
> +	if (IS_ERR(vq))
> +		return PTR_ERR(vq);
> +
> +	vc->vq =3D vq;
> +	vdev->priv =3D vc;
> +	virtio_cpufreq_dev =3D vc;

[Severity: High]
Does this unconditional assignment clobber the global pointer if a second
device is probed?

If a second device is probed, it overwrites the active virtio_cpufreq_dev
pointer. Registration of the second cpufreq driver fails with -EEXIST,
causing the error path to set the global pointer to NULL. This severs the
first, still-active device permanently, causing all subsequent .get()
callbacks to fail.

> +	virtio_device_ready(vdev);
> +
> +	ret =3D cpufreq_register_driver(&virtio_cpufreq_driver);
> +	if (ret) {
> +		vdev->config->del_vqs(vdev);

[Severity: High]
Is it safe to delete virtqueues while the device is in the READY state
without calling virtio_reset_device() first?

Because virtio_reset_device() is not called first to stop the device,
the host may still actively process requests or DMA into the rings,
causing a use-after-free corruption of kernel heap memory.

> +		virtio_cpufreq_dev =3D NULL;

[Severity: High]
Does nulling the global pointer on a failed secondary probe break the prima=
ry
active device?

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void virtio_cpufreq_remove(struct virtio_device *vdev)
> +{
> +	cpufreq_unregister_driver(&virtio_cpufreq_driver);
> +	virtio_cpufreq_dev =3D NULL;
> +	vdev->config->del_vqs(vdev);

[Severity: High]
Are virtqueues being deleted without first calling virtio_reset_device()?

Allowing the virtqueues to be freed while the device is fully active could
lead to the host continuing to actively process requests or DMA into the
rings, causing a use-after-free corruption.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922090224.430-=
1-baorliu@amd.com?part=3D1
