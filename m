Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08B449B33
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544958; cv=none; b=CO13LXzKMiEEhw0Ygyj6U6OQHudKaEH3tbD0kP1g8WAj4894eekaYasZi4ZSmKJMzXFQkA8ksVDY/KoEh95I3MrSacCdXECBkB/k82I9XsB3Lqy2cBpdi1n7N//sarnCJIg2t0Ajtc9tXwe+EmKnBNx0SZnhWU1b8cn1257jsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544958; c=relaxed/simple;
	bh=TDzloGk4CUJ5aL62B/8gcJQd+UOfVCavS4YjdZwhBBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htKya3pc/+ce6lrZTaiiSILokeERc/7i6Rmg6Ro7zJD04j6N+KPEq/dKZM6jPRvd6LJwnOPPW4naczfB9BXo8lthlNAd+yEE6+9xumUyupmemLEa2Meuyy9STqeupfRl1zJxtAbXsP5TXx14cI7V1IHzxIF6Z9rN6b0fy2lm7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5Z5MI7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5Z5MI7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DC01F0089E;
	Wed, 16 Sep 2026 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789544944;
	bh=amhIRom9+39IK+XsSgIqhz27blI0W6DxmHHTJX9gA1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5Z5MI7/LXZv2seMvXM9amgJe9Gqy+Zm03FgL0aoBuxxrrpt+BV33QZpe9z7rJo7b
	 b/ZTG7IUqdFVQpBfjaRRfcXM97CcNB0McbmjR1DCtwDEHa7S79bng8HQfHztSeT0pE
	 uHLJd6no7Kby7NBm82sx3tRzdXeRVxqsYwFm1KrzVCHO32BsjET/c9rD6GNmWkhbWR
	 pWp+Ah7CHpzAqzMcci0d1XD8+e0Ru2KnBurEkmj/hG/Rttm8ZSaBFGPa8lCZJ5aD8i
	 aAZtXfADjjdcerPcrlMAQO7cAKsF/1FjqjN+LWxRUasyXYnLE2xBWKnz0FJaJUdkth
	 pWSZxsolu4xfA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/1] cpufreq: virtio: add driver to report host
 frequency to guests
Reply-To: sashiko-reviews@lists.linux.dev
To: Baorui.Liu <baorliu@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260916073735.541-2-baorliu@amd.com>
References: <20260916073735.541-1-baorliu@amd.com>
 <20260916073735.541-2-baorliu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:49:03 +0000
Message-Id: <20260916074904.01DC01F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] core: stack use-after-free on virtqueue timeout
- [High] virtio: overlapping IN/OUT scatterlist mappings cause DMA aliasing
- [High] virtio: missing virtio_reset_device() before deleting virtqueues
- [High] cpufreq: self-deadlock in .target_index due to double transition_b=
egin
- [High] virtio: concurrent virtqueue modification due to missing IRQ-safe =
locking
- [Medium] cpufreq: global pointer clobbering breaks active device on probe=
 failure
- [Medium] virtio: premature allocation of unassigned device ID in UAPI
- [Medium] cpufreq: mutex held across blocking timeout serializes all CPUs
--

commit e9a0cf53064fc73cd4797ce5c61c255c2aef1ee7
Author: Baorui.Liu <baorliu@amd.com>

cpufreq: virtio: add driver to report host frequency to guests
   =20
Some virtualization stacks pin each vCPU to a pCPU. Guest software
still needs the current host frequency for energy accounting, but
the guest cannot access host sysfs.

Add a virtio frontend that queries the host for the frequency of
the mapped pCPU and exposes it through the cpufreq .get() callback.

> diff --git a/drivers/cpufreq/virtio-cpufreq.c b/drivers/cpufreq/virtio-cp=
ufreq.c
> new file mode 100644
> index 0000000000000..23fde862a3137
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
> +	cpufreq_freq_transition_end(policy, &freqs, 0);

[Severity: High]
Is it possible this leads to a self-deadlock?

For drivers without the CPUFREQ_ASYNC_NOTIFICATION flag, the cpufreq core
automatically invokes cpufreq_freq_transition_begin() on their behalf before
calling the .target_index() callback.

Calling it a second time here might trigger a double-invocation warning in =
the
core and cause the current task to wait on itself forever.

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
> +		complete(done);

[Severity: High]
Does virtqueue_get_buf() need to be protected by an IRQ-safe spinlock?

Since virtqueue_add_sgs() modifies the virtqueue from process context in
virtio_cpufreq_get(), and this IRQ callback modifies the same state here,
could they race and corrupt the virtqueue structures if an interrupt fires
on the same or another CPU?

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
Does using the exact same buffer and size for both input and output scatter=
lists
cause DMA aliasing?

Since virtqueue_add_sgs() maps these simultaneously as DMA_TO_DEVICE and
DMA_FROM_DEVICE, could this violate the DMA API? On systems relying on SWIO=
TLB
or non-coherent caches, cache operations might trample each other and cause
data corruption.

Should the request fields be split into separate, non-overlapping buffers
(for example, mapping &req->cpu_id for output and &req->freq_khz for input)?

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

[Severity: Medium]
Does holding the mutex across the blocking wait_for_completion_timeout() ca=
ll
serialize all CPUs?

By holding vc->lock while waiting for up to 1000ms, does this block all
other CPUs from submitting frequency queries, potentially causing latency s=
pikes
globally across the system?

[Severity: Critical]
Can a timeout lead to a stack use-after-free?

When wait_for_completion_timeout() times out, this function returns immedia=
tely
and abandons the request in the virtqueue. Since the completion token is
allocated on the local stack, could the hard IRQ callback virtio_cpufreq_vq=
_cb()
write to deallocated stack memory when the device eventually completes the
request?

> +
> +	if (!ret) {
> +		/*
> +		 * The buffer may still be on the virtqueue. Leak it
> +		 * rather than freeing while the host may still write.
> +		 */
> +		return virtio_cpufreq_fallback(cpu);
> +	}
> +
> +	freq_khz =3D le32_to_cpu(req->freq_khz);
> +	kfree(req);
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
> +	virtio_device_ready(vdev);
> +
> +	ret =3D cpufreq_register_driver(&virtio_cpufreq_driver);
> +	if (ret) {
> +		vdev->config->del_vqs(vdev);
> +		virtio_cpufreq_dev =3D NULL;

[Severity: Medium]
Could this unconditional assignment break an already active device if a sec=
ond
probe fails?

If a second virtio-cpufreq device is probed, it overwrites the global
virtio_cpufreq_dev pointer. When cpufreq_register_driver() fails with -EEXI=
ST,
the error path sets virtio_cpufreq_dev to NULL, destroying the global point=
er
for the first successfully probed device.

[Severity: High]
Does the device need to be stopped with virtio_reset_device(vdev) before
deleting its virtqueues?

Since virtio_device_ready(vdev) has already enabled the device, could
deleting the queues without resetting the device first cause hypervisor cra=
shes
or memory corruption if the device is still attempting to access memory or =
raise
IRQs?

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
Is a call to virtio_reset_device(vdev) missing here before freeing the queu=
es?

The virtio specification and driver model generally require that the device
is stopped prior to deleting its virtqueues.

> +}
[ ... ]
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_=
ids.h
> index f9056af0c6223..f7e357f3bf946 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
>  #define VIRTIO_ID_BT			40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
> +#define VIRTIO_ID_CPUFREQ		42 /* virtio cpufreq */

[Severity: Medium]
Is it premature to add an unallocated device ID into the UAPI headers?

Since the commit message notes this ID is not yet allocated by the virtio
specification, including it here might freeze the ABI and risk collisions if
the standard assigns 42 to a different device type in the future.

>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916073735.541-=
2-baorliu@amd.com?part=3D1
