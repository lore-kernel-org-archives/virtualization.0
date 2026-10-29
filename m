Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253888;
	b=YSaUapBvS5NzPrT9RtyZx93SZk4TVXVXV5n9099mlCthlqecC+YhxoPBSoj2l0bVWbqC
	 cGpLJjW3LqdR9gUeOw0ijpUHH4c90pKpjALA2v2dI0aKVjTrf5HcHS/S9nXrCGnjK25fJ
	 2mUnZtni5NgTy4KQU4t1fC48xoJTYhVEOnhfKwPsUbR0EIES1JixHRcLWBlJLtbDZy4Sd
	 Pe+aJr93caYLDIb0IIQr7PClpB/my7uK9jpZR4ZPSZ/7ZHzopnszqoxw4PYpLfp03cRFI
	 dcgkBR0BA2GdW+yHflzAxC0lYlM3cKe3RRRn+KEpBfupsENIRhpPz/Xsz8AMcsuJDSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253888;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AzGGPcNw5LzSJGH7OJce8tUXKI7AbuAtPe/a3RevD7E=;
	b=3v3wnhovKgkrA7+fYh9Sla/ZDba6Kmm3vrDHeVsobcxLrYvsR0+nOKkMQSNZDmxVjjjX
	 rYc4RlgEOLajjJcY22ZvrSiQIngdGYXkdNtZY3ngDBMXg9/fBeeChIFBOihiUgiNFcFIm
	 zZWKFdAw6xf2go8c5+80Jf+EqvJey4KjPOH7CNFZ85q5a46qdnDDIjWQL3tuuNotF0OCg
	 S/mMlfdGKpGOcD3ZQAiUx11hXxihX5RcsmuFDDqyyZql4vDSa/KEYStOt+HxdXZ0hkg4T
	 ufoxuLDhtMmc6yZA+oPruQs6lGv3MSV7HIWYttXckt2Sv4lZvR87ewhYzlkRnNHKZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoqNEA1s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF1606A31A;
	Thu, 29 Oct 2026 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoqNEA1s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6981F01825;
	Thu, 29 Oct 2026 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253887;
	bh=AzGGPcNw5LzSJGH7OJce8tUXKI7AbuAtPe/a3RevD7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoqNEA1s1fMazqQvpw6uUdmSWl+NB69BvHigL3/ayeb1tMRMoKzg/lBC/2cFHFZPZ
	 +MiMjJUPpo6ZhZ7qshQ4N5PzW+2EdhQ/GpKDsuziJRs0BIaG3Xd5i1yKLSyHaPcX0i
	 z7CJymGEOKJWiv+PqABF6V/loReIPtCo3gVSClQ6eoHTzXEaaOG0PfgdRBvvbXn0Xm
	 X/C+NLpmk9i56Ua0n/77OfX9y7QUgWj2npY8HGdoI35YWmE0TFK029z2olPwMQXBTv
	 XuF7CXoK+oGxYUD3eI7WmeFjH8ZecZMEM52BCybHdvmZwqKPbNZtnLPHbm08uZR/9L
	 rCnDVK25dzktw==
Message-ID: <sashiko-outbox-188788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/14] ALSA: pcm: stop paused streams before
 synchronizing teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-9-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:04:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ALSA: pcm: unbalanced STOP trigger from PAUSED in snd_pcm_do_stop()
--

commit 1209424a81e0273da5db98a8f56a0fd0d7015011
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: pcm: stop paused streams before synchronizing teardown

This commit updates snd_pcm_do_stop() to issue the SNDRV_PCM_TRIGGER_STOP
trigger and set stop_operating when a substream is in SNDRV_PCM_STATE_PAUSE=
D,
in addition to when it is running.

> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index a2ea44c3c1d29..2b18c5f5801f9 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1607,7 +1607,8 @@ static int snd_pcm_do_stop(struct snd_pcm_substream=
 *substream,
>  			   snd_pcm_state_t state)
>  {
>  	if (substream->runtime->trigger_master =3D=3D substream &&
> -	    snd_pcm_running(substream)) {
> +	    (snd_pcm_running(substream) ||
> +	     substream->runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED)) {
>  		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
>  		substream->runtime->stop_operating =3D true;
>  	}

[Severity: High]
Can calling substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP)
directly while in SNDRV_PCM_STATE_PAUSED cause regressions in drivers that
expect start-class triggers (START, RESUME, PAUSE_RELEASE) and stop-class
triggers (STOP, SUSPEND, PAUSE_PUSH) to be strictly paired?

When a substream enters SNDRV_PCM_STATE_PAUSED via snd_pcm_do_pause(), the
driver has already received SNDRV_PCM_TRIGGER_PAUSE_PUSH. Reaching
snd_pcm_do_stop() while runtime->state is still SNDRV_PCM_STATE_PAUSED
delivers SNDRV_PCM_TRIGGER_STOP without an intervening
SNDRV_PCM_TRIGGER_PAUSE_RELEASE.

This path can be reached from userspace when:

1. __snd_pcm_xrun() -> snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN) runs on
   a paused stream without calling snd_pcm_pause(substream, false), such as
   when ops->ack() returns -EPIPE in pcm_lib_apply_appl_ptr() during write,
   read, rewind, forward, or SNDRV_PCM_IOCTL_SYNC_PTR, when avail reaches
   runtime->stop_threshold in snd_pcm_update_state(), or via a direct driver
   snd_pcm_stop() call.
2. snd_pcm_pause(substream, false) in snd_pcm_drop() or snd_pcm_prepare()
   fails (its return value is ignored), for example if the driver's
   SNDRV_PCM_TRIGGER_PAUSE_RELEASE trigger returns an error or if a linked
   substream is not in SNDRV_PCM_STATE_PAUSED so snd_pcm_pre_pause() returns
   -EBADFD.
3. snd_pcm_drop(), snd_pcm_prepare(), or snd_pcm_stop() is called on a
   non-paused substream that is linked to a paused substream.

Several in-tree drivers appear to rely on never receiving
SNDRV_PCM_TRIGGER_STOP after SNDRV_PCM_TRIGGER_PAUSE_PUSH without an
intervening release:

1. Clock enable_count underflow in sound/soc/qcom/lpass-cpu.c
   (lpass_cpu_daiops_trigger()) and sound/soc/spear/spdif_in.c
   (spdif_in_trigger()):

   sound/soc/qcom/lpass-cpu.c:lpass_cpu_daiops_trigger() {
       ...
       case SNDRV_PCM_TRIGGER_STOP:
       case SNDRV_PCM_TRIGGER_SUSPEND:
       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
           ...
           clk_disable(drvdata->mi2s_bit_clk[dai->driver->id]);
           break;
   }

   Receiving STOP while PAUSED calls clk_disable() a second time for a sing=
le
   clk_enable().

2. Runtime PM usage count underflow in sound/soc/samsung/i2s.c
   (i2s_trigger()):

   sound/soc/samsung/i2s.c:i2s_trigger() {
       ...
       case SNDRV_PCM_TRIGGER_STOP:
       case SNDRV_PCM_TRIGGER_SUSPEND:
       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
           ...
           pm_runtime_put(dai->dev);
           break;
   }

   Receiving STOP after PAUSE_PUSH calls pm_runtime_put(dai->dev) twice.

3. Reference and active counter underflows or premature shared hardware
   shutdown in sound/soc/stm/stm32_i2s.c (stm32_i2s_trigger() decrementing
   i2s->refcount), sound/soc/rockchip/rockchip_i2s_tdm.c
   (rockchip_snd_txrxctrl() decrementing i2s_tdm->refcount),
   sound/soc/atmel/atmel-i2s.c (atmel_i2s_trigger() decrementing
   dev->clk_use_no), sound/soc/dwc/dwc-i2s.c (dw_i2s_trigger() decrementing
   dev->active), sound/soc/ti/omap-mcbsp.c (omap_mcbsp_dai_trigger()
   decrementing mcbsp->active), sound/soc/pxa/mmp-sspa.c
   (mmp_sspa_trigger()), sound/soc/bcm/cygnus-ssp.c (cygnus_ssp_trigger()),
   and sound/soc/fsl/imx-pcm-fiq.c (snd_imx_pcm_trigger() calling
   disable_fiq(imx_pcm_fiq) twice):

   sound/soc/stm/stm32_i2s.c:stm32_i2s_trigger() {
       ...
       case SNDRV_PCM_TRIGGER_STOP:
       case SNDRV_PCM_TRIGGER_SUSPEND:
       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
           ...
           scoped_guard(spinlock, &i2s->lock_fd) {
               i2s->refcount--;
   }

4. SOF IPC4 pipeline state leak in sound/soc/sof/ipc4-pcm.c:

   sound/soc/sof/ipc4-pcm.c:sof_ipc4_add_pipeline_to_trigger_list() {
       ...
       case SOF_IPC4_PIPE_RESET:
           /* RESET if the pipeline is neither running nor paused */
           if (!spipe->started_count && !spipe->paused_count)
               sof_ipc4_add_pipeline_by_priority(trigger_list, pipe_widget,=
 pipe_priority,
                                                 true);
           break;
       case SOF_IPC4_PIPE_PAUSED:
       case SOF_IPC4_PIPE_EOS:
           if (spipe->paused_count =3D=3D (spipe->started_count - 1))
               sof_ipc4_add_pipeline_by_priority(trigger_list, pipe_widget,=
 pipe_priority,
                                                 true);
           break;
   }

   When START is followed by PAUSE_PUSH, spipe->started_count is 1 and
   spipe->paused_count is 1. If SNDRV_PCM_TRIGGER_STOP is then issued while
   PAUSED, sof_ipc4_pcm_trigger() requests SOF_IPC4_PIPE_PAUSED, the check
   spipe->paused_count =3D=3D (spipe->started_count - 1) evaluates to false=
, and
   neither started_count nor paused_count is decremented (and
   sof_ipc4_update_pipeline_state() only decrements paused_count on
   SNDRV_PCM_TRIGGER_PAUSE_RELEASE). Subsequent sof_ipc4_pcm_hw_free() then
   skips SOF_IPC4_PIPE_RESET because started_count and paused_count remain
   non-zero.

5. Stuck hardware pause bits in sound/pci/cmipci.c (snd_cmipci_pcm_trigger(=
)),
   sound/pci/oxygen/oxygen_pcm.c (oxygen_trigger()), sound/pci/als300.c
   (snd_als300_trigger()), sound/pci/ens1370.c (snd_ensoniq_trigger()), and
   sound/pci/ice1712/ice1712.c (snd_ice1712_pcm_trigger()):

   sound/pci/cmipci.c:snd_cmipci_pcm_trigger() {
       ...
       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
       case SNDRV_PCM_TRIGGER_SUSPEND:
           cm->ctrl |=3D pause;
           snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
           break;
       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
       case SNDRV_PCM_TRIGGER_RESUME:
           cm->ctrl &=3D ~pause;
           snd_cmipci_write(cm, CM_REG_FUNCTRL0, cm->ctrl);
           break;
   }

   In these drivers, the pause bit is only cleared on PAUSE_RELEASE or RESU=
ME,
   not by SNDRV_PCM_TRIGGER_STOP or prepare().

6. Duplicate VIRTIO_SND_R_PCM_STOP in sound/virtio/virtio_pcm_ops.c
   (virtsnd_pcm_trigger()):

   sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_trigger() {
       ...
       case SNDRV_PCM_TRIGGER_STOP:
       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
           scoped_guard(spinlock_irqsave, &vss->lock) {
               if (command !=3D SNDRV_PCM_TRIGGER_PAUSE_PUSH)
                   vss->stopped =3D true;
               vss->xfer_enabled =3D false;
           }

           msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
                                           GFP_KERNEL);
           if (!msg)
               return -ENOMEM;

           return virtsnd_ctl_msg_send_sync(snd, msg);
   }

   Because SNDRV_PCM_TRIGGER_PAUSE_PUSH already sends VIRTIO_SND_R_PCM_STOP
   to the device, triggering SNDRV_PCM_TRIGGER_STOP from
   SNDRV_PCM_STATE_PAUSED sends a second VIRTIO_SND_R_PCM_STOP while the
   device stream is already stopped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D8
