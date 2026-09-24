Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D748390C8A
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234352; cv=none; b=Rk3Ne+zrZJF/TPKSK/6Ur5jHnnUyUKXjLa244bACnteKF/eujNBl/TXHjpHvlmaS3Zgjc8cIOEr1UNsJU48JQwH5bZXu/iuoQJ5+lg0PbVi8AICJxTXgoz8X1DKmhl8IFLe5q7L9dhG5phgPUqo/I3kg1eup76NCVf1gnuK1JxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234352; c=relaxed/simple;
	bh=c60Y7G8wxpg05m/hEkyI/YDtVOCmbT7s6F0I9E2bJw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGVY3tJcYLRRkpslgMHRhug+xz5n/UXZbVX/jXK8rYPhpbXb66tdXSDqrTu4wEJWsq0tuazYxkX5vKKWe17wJcP37aql4zQJvTMGyjb7gCFQZBZOFNNqtm1CFZjvQ4hmjgvQblLP7JlyIxGVU22vE5gN6NgpwAcpStE++xv08oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOJdiuin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOJdiuin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D91F0089E
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 07:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790234346;
	bh=ySEqHdJt2xdG4QEE87albVq7DFLm4YihCOV+eLWnj8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YOJdiuinrjvxqgcZGaWqy0zYnZuDnVY+mLMWyRxHodCsPTStgLhAHKoYTnNUoPA2z
	 Jk3zjn2/7wt98PnBUbyhDyG2Le2lwESjWGt97yzx78C+kC6vLHvDmeK4/i1GpS3HMA
	 Lrbj9QCMDYkxtDaaLA+wbm3fXm/v18uHF7nWriKAOc0h4UQAOMCF/fhO+vo3IQoTIO
	 FDfbf+qzCxm91vD3Xs3kwy0ch3A9BMbzvc2IOx1/It0d4d9ZidkDeDRI4w4211PMmM
	 klSGfrbTGml0tOIjm70sv2EZkeSTGjmfP82RRc5AVyW1xwEvO8ztdd939toIeDraq9
	 hOxBAV8vGQDlQ==
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa06e51bc3so2884858a12.2
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 00:19:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz7u0Q7wM/9SLQciUgdAJTb2bg8gBz23GNIsAzAUALGEpt7xkJzCroewkZeXzzBVePImoXDx3xSLv1BK5czMQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lQw+XQdGphp/Z/7OK/2clzjvRUoEkyjwztsXH6eOmfU4gqWecK
	hdqxohRUJfsBHxuM3I3evT7wVCinlgv/YpCqvaRURgCCgpm4bDwfjlkKLCrYLFLDu14kL0Yqnfk
	t1GGlzg8sZ7whDjZ8TBi9ewNn8udBK78=
X-Received: by 2002:a05:6402:4612:b0:6a7:f6cd:b402 with SMTP id
 4fb4d7f45d1cf-6aac90a11bamr1149328a12.20.1790234344829; Thu, 24 Sep 2026
 00:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916073735.541-1-baorliu@amd.com> <20260922090224.430-2-baorliu@amd.com>
In-Reply-To: <20260922090224.430-2-baorliu@amd.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Thu, 24 Sep 2026 00:18:53 -0700
X-Gmail-Original-Message-ID: <CACRMN=c2fB9Tvn4TFLVGdgSMYtopMOvoBH1E2Aicm-1oeQr-iw@mail.gmail.com>
X-Gm-Features: AclHuK_ItYJZF2ZY25CU-ZrMBVq-C2-n7cZVULXzF_VOcVG0tMvk60LVWl4J_NI
Message-ID: <CACRMN=c2fB9Tvn4TFLVGdgSMYtopMOvoBH1E2Aicm-1oeQr-iw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] cpufreq: virtio: add driver to report host
 frequency to guests
To: "Baorui.Liu" <baorliu@amd.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	saravanak@kernel.org, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:03=E2=80=AFAM Baorui.Liu <baorliu@amd.com> wrote:
>

As you stated in the v1 cover letter, there's already a MMIO based
driver. Why can't we use that? Why not add a MMIO CPUfreq device?

It's been a while, so I don't remember all the details. But we did
consider virtio for this but then decided against it for a few
reasons:
1. The overhead is much higher than MMIO
2. Doesn't allow the fastswitch mode that's super useful with
schedutil. IIRC AMD prefers schedutil.
3. Didn't want to add a vitrio device just for this.
4. Since Virtio is built on top of PCI (IIRC/IIUC), it was also adding
a limitation on how early we can have this driver working and also how
it'd affect the suspend/resume path if we wanted to change the cpufreq
after PCI is suspended inside the VM.

I'd really really prefer if you went with the MMIO option.


-Saravana



> Some virtualization stacks pin each vCPU to a pCPU. Guest software
> still needs the current host frequency for energy accounting, but
> the guest cannot access host sysfs.
>
> Add a virtio frontend that queries the host for the frequency of
> the mapped pCPU and exposes it through the cpufreq .get() callback.
>
> Fix build on current linux-pm: cpufreq_generic_attr no longer
> exists; use cpufreq_freq_attr_scaling_available_freqs instead.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609191437.OaXd0Blz-lkp@i=
ntel.com/
> Signed-off-by: Baorui.Liu <baorliu@amd.com>
> ---
>  drivers/cpufreq/Kconfig          |  14 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/virtio-cpufreq.c | 240 +++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h  |   1 +
>  4 files changed, 256 insertions(+)
>  create mode 100644 drivers/cpufreq/virtio-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index db83f3365698..ba0e38f5dce5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -242,6 +242,20 @@ config CPUFREQ_VIRT
>
>           If in doubt, say N.
>
> +config CPUFREQ_VIRTIO
> +       tristate "Virtio CPU frequency driver"
> +       depends on VIRTIO
> +       help
> +         This option adds a virtio cpufreq frontend. The guest sends a
> +         vCPU id to the host backend and receives the mapped physical
> +         CPU frequency in kHz through the cpufreq .get() callback.
> +
> +         This is intended for virtualization stacks (for example Xen)
> +         that pin each vCPU to a pCPU and expose host frequency to the
> +         guest. It does not change the host frequency.
> +
> +         If in doubt, say N.
> +
>  config CPUFREQ_DT_PLATDEV
>         bool "Generic DT based cpufreq platdev driver"
>         depends on OF
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 6c7a39b7f8d2..9d9bb7ea1300 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_CPUFREQ_DT)              +=3D cpufreq-dt.o
>  obj-$(CONFIG_CPUFREQ_DT_RUST)          +=3D rcpufreq_dt.o
>  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       +=3D cpufreq-dt-platdev.o
>  obj-$(CONFIG_CPUFREQ_VIRT)             +=3D virtual-cpufreq.o
> +obj-$(CONFIG_CPUFREQ_VIRTIO)           +=3D virtio-cpufreq.o
>
>  # Traces
>  CFLAGS_amd-pstate-trace.o               :=3D -I$(src)
> diff --git a/drivers/cpufreq/virtio-cpufreq.c b/drivers/cpufreq/virtio-cp=
ufreq.c
> new file mode 100644
> index 000000000000..aa04fd7fd343
> --- /dev/null
> +++ b/drivers/cpufreq/virtio-cpufreq.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Virtio cpufreq frontend
> + *
> + * Query the host for the frequency of the pCPU that currently runs a
> + * given vCPU. Used when the guest cannot read host cpufreq sysfs, for
> + * example a Xen domain that needs the value for energy accounting.
> + *
> + * The on-wire protocol is a packed { cpu_id, freq_khz } request that
> + * must match the QEMU virtio-cpufreq backend.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ids.h>
> +
> +#define DRV_NAME "virtio-cpufreq"
> +
> +struct virtio_cpufreq_req {
> +       __le32 cpu_id;
> +       __le32 freq_khz;
> +} __packed;
> +
> +struct virtio_cpufreq {
> +       struct virtio_device *vdev;
> +       struct virtqueue *vq;
> +       struct mutex lock; /* serializes virtqueue requests */
> +};
> +
> +static struct virtio_cpufreq *virtio_cpufreq_dev;
> +
> +/*
> + * Placeholder OPPs so cpufreq has a table. Real platforms should
> + * populate this from the host or from firmware. Values match the
> + * existing QEMU/Android backend used for bring-up.
> + */
> +static struct cpufreq_frequency_table virtio_freq_table[] =3D {
> +       { .frequency =3D 1400000 },
> +       { .frequency =3D 1700000 },
> +       { .frequency =3D 3000000 },
> +       { .frequency =3D CPUFREQ_TABLE_END },
> +};
> +
> +static int virtio_cpufreq_init_policy(struct cpufreq_policy *policy)
> +{
> +       cpumask_clear(policy->cpus);
> +       cpumask_set_cpu(policy->cpu, policy->cpus);
> +
> +       policy->freq_table =3D virtio_freq_table;
> +       policy->cpuinfo.min_freq =3D 1400000;
> +       policy->cpuinfo.max_freq =3D 3000000;
> +       policy->cpuinfo.transition_latency =3D 0;
> +
> +       return 0;
> +}
> +
> +static int virtio_cpufreq_target_index(struct cpufreq_policy *policy,
> +                                      unsigned int index)
> +{
> +       struct cpufreq_freqs freqs;
> +
> +       freqs.old =3D policy->cur;
> +       freqs.new =3D policy->freq_table[index].frequency;
> +
> +       /*
> +        * This frontend does not change host frequency. It only keeps
> +        * the cpufreq core in sync so userspace can observe values.
> +        */
> +       cpufreq_freq_transition_begin(policy, &freqs);
> +       cpufreq_freq_transition_end(policy, &freqs, 0);
> +
> +       return 0;
> +}
> +
> +static unsigned int virtio_cpufreq_fallback(unsigned int cpu)
> +{
> +       struct cpufreq_policy *policy;
> +       unsigned int freq =3D 0;
> +
> +       policy =3D cpufreq_cpu_get(cpu);
> +       if (policy) {
> +               freq =3D policy->cur;
> +               cpufreq_cpu_put(policy);
> +       }
> +
> +       return freq;
> +}
> +
> +static void virtio_cpufreq_vq_cb(struct virtqueue *vq)
> +{
> +       struct completion *done;
> +       unsigned int len;
> +
> +       while ((done =3D virtqueue_get_buf(vq, &len)) !=3D NULL)
> +               complete(done);
> +}
> +
> +static unsigned int virtio_cpufreq_get(unsigned int cpu)
> +{
> +       struct virtio_cpufreq *vc =3D virtio_cpufreq_dev;
> +       struct virtio_cpufreq_req *req;
> +       struct scatterlist out_sg, in_sg, *sgs[2];
> +       struct completion done;
> +       unsigned int freq_khz;
> +       int ret;
> +
> +       if (!vc || !vc->vq)
> +               return virtio_cpufreq_fallback(cpu);
> +
> +       req =3D kzalloc_obj(*req, GFP_KERNEL);
> +       if (!req)
> +               return virtio_cpufreq_fallback(cpu);
> +
> +       req->cpu_id =3D cpu_to_le32(cpu);
> +
> +       init_completion(&done);
> +       sg_init_one(&out_sg, req, sizeof(*req));
> +       sg_init_one(&in_sg, req, sizeof(*req));
> +       sgs[0] =3D &out_sg;
> +       sgs[1] =3D &in_sg;
> +
> +       mutex_lock(&vc->lock);
> +       ret =3D virtqueue_add_sgs(vc->vq, sgs, 1, 1, &done, GFP_KERNEL);
> +       if (ret) {
> +               mutex_unlock(&vc->lock);
> +               kfree(req);
> +               return virtio_cpufreq_fallback(cpu);
> +       }
> +
> +       virtqueue_kick(vc->vq);
> +       ret =3D wait_for_completion_timeout(&done, msecs_to_jiffies(1000)=
);
> +       mutex_unlock(&vc->lock);
> +
> +       if (!ret) {
> +               /*
> +                * The buffer may still be on the virtqueue. Leak it
> +                * rather than freeing while the host may still write.
> +                */
> +               return virtio_cpufreq_fallback(cpu);
> +       }
> +
> +       freq_khz =3D le32_to_cpu(req->freq_khz);
> +       kfree(req);
> +
> +       if (!freq_khz)
> +               return virtio_cpufreq_fallback(cpu);
> +
> +       return freq_khz;
> +}
> +
> +static struct freq_attr *virtio_cpufreq_attr[] =3D {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};
> +
> +static struct cpufreq_driver virtio_cpufreq_driver =3D {
> +       .name           =3D DRV_NAME,
> +       .flags          =3D CPUFREQ_CONST_LOOPS,
> +       .init           =3D virtio_cpufreq_init_policy,
> +       .verify         =3D cpufreq_generic_frequency_table_verify,
> +       .target_index   =3D virtio_cpufreq_target_index,
> +       .get            =3D virtio_cpufreq_get,
> +       .attr           =3D virtio_cpufreq_attr,
> +};
> +
> +static int virtio_cpufreq_probe(struct virtio_device *vdev)
> +{
> +       struct virtio_cpufreq *vc;
> +       struct virtqueue *vq;
> +       int ret;
> +
> +       vc =3D devm_kzalloc(&vdev->dev, sizeof(*vc), GFP_KERNEL);
> +       if (!vc)
> +               return -ENOMEM;
> +
> +       mutex_init(&vc->lock);
> +       vc->vdev =3D vdev;
> +
> +       vq =3D virtio_find_single_vq(vdev, virtio_cpufreq_vq_cb, "request=
s");
> +       if (IS_ERR(vq))
> +               return PTR_ERR(vq);
> +
> +       vc->vq =3D vq;
> +       vdev->priv =3D vc;
> +       virtio_cpufreq_dev =3D vc;
> +       virtio_device_ready(vdev);
> +
> +       ret =3D cpufreq_register_driver(&virtio_cpufreq_driver);
> +       if (ret) {
> +               vdev->config->del_vqs(vdev);
> +               virtio_cpufreq_dev =3D NULL;
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static void virtio_cpufreq_remove(struct virtio_device *vdev)
> +{
> +       cpufreq_unregister_driver(&virtio_cpufreq_driver);
> +       virtio_cpufreq_dev =3D NULL;
> +       vdev->config->del_vqs(vdev);
> +}
> +
> +static const struct virtio_device_id id_table[] =3D {
> +       { VIRTIO_ID_CPUFREQ, VIRTIO_DEV_ANY_ID },
> +       { 0 },
> +};
> +
> +static struct virtio_driver virtio_cpufreq_virtio_driver =3D {
> +       .driver.name    =3D DRV_NAME,
> +       .driver.owner   =3D THIS_MODULE,
> +       .id_table       =3D id_table,
> +       .probe          =3D virtio_cpufreq_probe,
> +       .remove         =3D virtio_cpufreq_remove,
> +};
> +
> +static int __init virtio_cpufreq_mod_init(void)
> +{
> +       return register_virtio_driver(&virtio_cpufreq_virtio_driver);
> +}
> +
> +static void __exit virtio_cpufreq_mod_exit(void)
> +{
> +       unregister_virtio_driver(&virtio_cpufreq_virtio_driver);
> +}
> +
> +module_init(virtio_cpufreq_mod_init);
> +module_exit(virtio_cpufreq_mod_exit);
> +
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio cpufreq frontend");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_=
ids.h
> index f9056af0c622..f7e357f3bf94 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY         39 /* virtio audio policy */
>  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> +#define VIRTIO_ID_CPUFREQ              42 /* virtio cpufreq */
>  #define VIRTIO_ID_SPI                  45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA                        48 /* virtio media */
>
> --
> 2.34.1
>
