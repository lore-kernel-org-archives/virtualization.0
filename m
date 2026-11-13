Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555030;
	b=PsQfiynkbLTJe7nFmJw69WP0lmwg0QQaDD7Nr1hKhtbzbvPAlB3EBbL2aGvNxPp3zNLv
	 bzJfk7AeaI4XKQQvhQVVLxv8ziIXj+wiYeYAfSdmkNFo2vhgcN8XZhlUKOukI8E3Bs3Fx
	 s1XNdO2bxBmg8wr2qYvfTlGO/QttPrYfv/WvIi0oPOY2sx5iYAzFGc+4AawHqh0PAOBf5
	 t2x2CEJ/QMp9wKKxnLBMMBJG63rnNIHshKjW+8eSY8bo861OGupKFam/rjpkuR35cDtAx
	 zuHAhKBkp6aCx+95K4+fQhhdoNOA3vUvG8BIWNoEu0Y5XSgPfpyniBeyxWhkYdmZaGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tcjISiTW+ME8I6K+YBWbrhXiodzSlI0tzVxZYx8t+KM=;
	b=RGWgv3+rmgyJSupBDUDWJgMoB24fZzzQF2XDO4l5dhOyITEzPPaQGOk9iTdpgV/JKta+
	 V45yNYzmn3Ek1ZC1J5v+SPYUfBqimMjaIrBZw2rIKyE3bO4iD1iB2hkv+r52VN41+QxAl
	 3sw0XE1VgQo1yB+/90LJSv6+WSQu5Y1xty5HvrbQGDrJwJ3pPeO9O2IvIxLPbzblsvFhR
	 1oPZmV+ZwU2h+yACSam0Ingonl1APC9BMkKjsB+AUM/cx4Ui8LRsgNn+6naHAd956N2Os
	 uM4dFQXLEM8EFf5OMqwxHqrJ1tw8I4OCtjea3aqZ7N1jnF5EQEWok33jj8VjKu6hSwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I4W5JkH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C56606A327;
	Fri, 13 Nov 2026 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4W5JkH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EC81F000C4;
	Fri, 13 Nov 2026 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794555030;
	bh=tcjISiTW+ME8I6K+YBWbrhXiodzSlI0tzVxZYx8t+KM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4W5JkH/uCwsaT+S6QsY3gSD5QkOza/UxOMTZkM59Szj7yuI1DCD3ABosjJpGvwvt
	 zYliG7KkVrvwMpSfgEGoQSGDUCuWuHXMLBB0FiPJGlqxj3dhy7eGYmvE1wGUSXrpbv
	 SKBvZ8A/Q9T1jdbj9r21Sdj/NBygCDQYHWJ40sTDw6fFBFUX+0oEU14xw0XchCGTCz
	 a4gbeDxDDrbIsO2GJw58XEus1u5FAvatULZaqpOYRMnQaAhLVj/xETfUlMqBNfjDEz
	 gmwAqSIA+31qj+kTgVuOTJ2FALxaYUGfZvteIv+En8a5dNt94l/htVp1tLfG41c3lK
	 YmO3JLmANIYLQ==
Message-ID: <sashiko-outbox-212350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 20/20] ALSA: virtio: reset the device when PCM state
 stays unknown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-20-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-20-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:30:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] ALSA: virtio: deadlock between virtsnd_pcm_prepare() and
  virtsnd_recover_work()
- [High] ALSA: virtio: missing recovery wait in open, hw_free, and
  virtsnd_pcm_sync_stop()
- [Medium] ALSA: virtio: pending recover_work timer triggers premature
  device reset
- [Medium] ALSA: virtio: virtsnd_recover_work() races with freeze/reset
  and restore
- [Medium] ALSA: virtio: virtsnd_reset_prepare() does not suspend PCM
  streams on reset
- [Medium] ALSA: virtio: snd_pcm_suspend_all() in recovery sends
  blocking requests
- [Medium] ALSA: virtio: recovery ordering and races break
  virtsnd_pcm_prepare() and virtsnd_pcm_hw_params()
- [Low] ALSA: virtio: double volatile read of jiffies in
  virtsnd_recover_work()
--

commit ab36d8f3f343747049667c96b153b488074305f1
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: reset the device when PCM state stays unknown

This commit adds a delayed recovery work item that suspends open PCM
streams and resets the VirtIO sound device when a PCM substream's device
state remains unknown or an I/O queue flush times out, disconnecting the
ALSA card if the transport reset fails.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 3f2242f274404..dd110fd7ad165 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c

[ ... ]

> @@ -528,6 +530,190 @@ static int virtsnd_restore(struct virtio_device *vd=
ev)
> =20
>  	return 0;
>  }
> +
> +/* Minimum time between recovery resets of one device. */
> +#define VIRTSND_RECOVER_INTERVAL_MS	30000
> +
> +static bool virtsnd_recover_needed(struct virtio_snd *snd)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
> +		struct virtio_pcm_substream *vss =3D &snd->substreams[i];
> +
> +		guard(spinlock_irqsave)(&vss->lock);
> +		if (vss->resetting)
> +			continue;
> +		if (vss->control_uncertain ||
> +		    vss->pause_restart_state =3D=3D
> +		    VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
> +		    (vss->io_flush_failed && vss->msg_count))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * virtsnd_recover_work() - Reset the device when a PCM state stays unkn=
own.
> + * @work: Recovery work of the sound device.
> + *
> + * A control reply or released I/O request that never returns leaves its=
 PCM
> + * stream unusable. Suspend the open streams so applications prepare them
> + * again, then reset the device with the transport reset sequence.
> + *
> + * Context: Process context.
> + */
> +static void virtsnd_recover_work(struct work_struct *work)
> +{
> +	struct virtio_snd *snd =3D container_of(to_delayed_work(work),
> +					      struct virtio_snd, recover_work);
> +	struct virtio_device *vdev =3D snd->vdev;
> +	struct virtio_pcm *vpcm;
> +	unsigned int i;
> +	int rc;
> +
> +	if (!virtsnd_recover_needed(snd))
> +		return;
> +
> +	if (time_before(jiffies, snd->recover_next)) {
> +		queue_delayed_work(system_dfl_wq, &snd->recover_work,
> +				   snd->recover_next - jiffies);
> +		return;
> +	}

[Severity: Low]
Can snd->recover_next - jiffies underflow here?  jiffies is volatile and
read twice, so if it advances to or past snd->recover_next between
time_before() and the subtraction, the delay wraps around near ULONG_MAX
and prevents later queue_delayed_work() calls from scheduling recovery.

> +	snd->recover_next =3D jiffies +
> +			    msecs_to_jiffies(VIRTSND_RECOVER_INTERVAL_MS);
> +
> +	dev_warn(&vdev->dev, "PCM device state is unknown; resetting device\n");
> +
> +	WRITE_ONCE(snd->recovering, true);
> +	for (i =3D 0; i < snd->nsubstreams; ++i)
> +		wake_up_all(&snd->substreams[i].control_wait);
> +
> +	/* Applications observe -ESTRPIPE and prepare their streams again. */
> +	list_for_each_entry(vpcm, &snd->pcm_list, list)
> +		snd_pcm_suspend_all(vpcm->pcm);
> +
> +	rc =3D virtio_device_reset_prepare(vdev);

[Severity: Medium]
Does calling snd_pcm_suspend_all() before virtio_device_reset_prepare()
cause recovery to send new synchronous control requests and repeat flush
waits against the unresponsive device?

At this point vss->resetting is still false and control messages are not
blocked.  In virtsnd_pcm_control_settle(), virtsnd_pcm_control_settled()
is checked before READ_ONCE(vss->snd->recovering), so it returns 0 for any
substream where vss->control_uncertain is false (including streams being
recovered for vss->io_flush_failed or
VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED, as well as any other active
substream on the card).  During snd_pcm_suspend_all():

- snd_pcm_suspend() -> virtsnd_pcm_trigger(SNDRV_PCM_TRIGGER_SUSPEND)
  sends a synchronous VIRTIO_SND_R_PCM_STOP request and blocks for
  virtsnd_msg_timeout_ms.
- snd_pcm_sync_stop() -> virtsnd_pcm_release_locked() waits another
  virtsnd_msg_timeout_ms on vss->msg_empty, logs a duplicate warning, sets
  substream->runtime->stop_operating =3D true again, and calls
  virtsnd_pcm_flush_failed() to re-schedule snd->recover_work for another
  reset (or virtsnd_pcm_pause_restart_sync_stop() logs a duplicate error
  and calls virtsnd_recover_schedule(vss->snd, 0)).

> +	if (!rc)
> +		rc =3D virtio_device_reset_done(vdev);
> +	WRITE_ONCE(snd->recover_failed, !!rc);
> +	/* Publish the result before releasing configuration waiters. */
> +	smp_store_release(&snd->recovering, false);
> +	wake_up_all(&snd->recover_wait);
> +
> +	if (rc) {
> +		/*
> +		 * Wake configuration waiters before disconnect, which waits for
> +		 * their ALSA power references to be released.
> +		 */
> +		dev_err(&vdev->dev, "device recovery reset failed: %d; disconnecting\n=
",
> +			rc);
> +		snd_card_disconnect(snd->card);
> +	}
> +}
> +
> +/**
> + * virtsnd_recover_wait() - Wait until a recovery reset has finished.
> + * @snd: VirtIO sound device.
> + *
> + * Applications prepare their streams again as soon as recovery suspends
> + * them. Configuring a stream must wait until the reset has completed.
> + *
> + * Context: Process context. The caller must not hold the PCM open mutex=
 or
> + *          a substream lifecycle lock, which recovery takes.
> + * Return: 0, -ENODEV if recovery failed, or -ERESTARTSYS if killed.
> + */
> +int virtsnd_recover_wait(struct virtio_snd *snd)
> +{
> +	int rc;
> +
> +	rc =3D wait_event_killable(snd->recover_wait,
> +				 /* Pair with recovery's result publication. */
> +				 !smp_load_acquire(&snd->recovering));
> +	if (rc)
> +		return rc;
> +	return READ_ONCE(snd->recover_failed) ? -ENODEV : 0;
> +}

[Severity: High]
Can virtsnd_recover_wait() called from virtsnd_pcm_prepare() deadlock with
virtsnd_recover_work() and snd_pcm_release()?

snd_pcm_prepare() -> snd_pcm_action_nonatomic() holds
down_read(&snd_pcm_link_rwsem) when it invokes virtsnd_pcm_prepare() ->
virtsnd_recover_wait().  Meanwhile, snd_pcm_release() holds
pcm->open_mutex and calls snd_pcm_release_substream() -> snd_pcm_unlink(),
which unconditionally takes down_write(&snd_pcm_link_rwsem) before
checking whether the substream is linked.  Because virtsnd_recover_work()
sets snd->recovering =3D true before taking pcm->open_mutex in
snd_pcm_suspend_all(), the three contexts can lock up:

CPU0                          CPU1                          kworker
----                          ----                          -------
                                                            virtsnd_recover=
_work()
                                                              snd->recoveri=
ng =3D true
snd_pcm_prepare()
  down_read(&snd_pcm_link_rwsem)
  virtsnd_pcm_prepare()
    virtsnd_recover_wait()
                              snd_pcm_release()
                                mutex_lock(&pcm->open_mutex)
                                snd_pcm_unlink()
                                  down_write(&snd_pcm_link_rwsem)
                                                            snd_pcm_suspend=
_all()
                                                              mutex_lock(&p=
cm->open_mutex)

 *** DEADLOCK ***

This wedges system_dfl_wq and the global snd_pcm_link_rwsem across all
sound cards.

> +
> +/**
> + * virtsnd_recover_schedule() - Request a recovery check.
> + * @snd: VirtIO sound device.
> + * @delay: Time before the check, in jiffies. Zero brings a pending check
> + *         forward.
> + *
> + * Context: Any context.
> + */
> +void virtsnd_recover_schedule(struct virtio_snd *snd, unsigned long dela=
y)
> +{
> +	if (delay)
> +		queue_delayed_work(system_dfl_wq, &snd->recover_work, delay);
> +	else
> +		mod_delayed_work(system_dfl_wq, &snd->recover_work, 0);
> +}

[Severity: Medium]
Can an already-pending snd->recover_work from an earlier event trigger a
premature device reset on a later timeout?

When a late control reply or I/O flush failure occurs at T1,
queue_delayed_work() schedules snd->recover_work for T1 + 5 timeouts.  If
that reply arrives and settles the substream (or the I/O queue drains),
snd->recover_work remains queued for T1 + 5 timeouts.  If another control
reply is late or an I/O flush fails at T2 < T1 + 5 timeouts,
queue_delayed_work() leaves the timer at T1 + 5 timeouts, and when
virtsnd_recover_work() runs at T1 + 5 timeouts, virtsnd_recover_needed()
sees vss->control_uncertain or (vss->io_flush_failed && vss->msg_count) set
and immediately resets the device before the second event's 4-timeout
settle window has elapsed.

> +
> +/*
> + * Transport resets and driver recovery use the freeze and restore seque=
nce.
> + * Recovery calls these callbacks from its own work item.
> + */
> +static int virtsnd_reset_prepare(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd =3D vdev->priv;
> +
> +	if (current_work() !=3D &snd->recover_work.work)
> +		disable_delayed_work_sync(&snd->recover_work);
> +	virtsnd_quiesce(snd);
> +
> +	return 0;
> +}
> +
> +static int virtsnd_reset_done(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd =3D vdev->priv;
> +	int rc;
> +
> +	rc =3D virtsnd_restart(snd);
> +	if (current_work() !=3D &snd->recover_work.work)
> +		enable_delayed_work(&snd->recover_work);
> +
> +	return rc;
> +}

[Severity: Medium]
On a transport-initiated reset (where current_work() !=3D
&snd->recover_work.work), does virtsnd_reset_prepare() leave open ALSA PCM
streams in their active states instead of suspending them?

During system sleep, the PM core suspends child PCM devices before calling
virtsnd_freeze(), and virtsnd_recover_work() calls snd_pcm_suspend_all()
before virtio_device_reset_prepare().  A transport-initiated reset calls
virtsnd_reset_prepare() directly without setting snd->recovering or
calling snd_pcm_suspend_all(), so virtsnd_quiesce() detaches all virtqueue
buffers and sets vss->prepared =3D false and vss->suspended =3D true while
leaving substream->runtime->state in RUNNING, PREPARED, or PAUSED, causing
blocked readers/writers to hang until timeout (-EIO) instead of observing
-ESTRPIPE and subsequent triggers to fail with -EBADFD.  In addition, if
virtsnd_restart() fails in virtsnd_reset_done(), it still re-enables
snd->recover_work and does not set snd->recover_failed or disconnect the
card.

> +
> +#ifdef CONFIG_PM_SLEEP
> +/**
> + * virtsnd_freeze() - Suspend device.
> + * @vdev: VirtIO parent device.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_freeze(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd =3D vdev->priv;
> +
> +	disable_delayed_work_sync(&snd->recover_work);
> +	virtsnd_quiesce(snd);
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_restore() - Resume device.
> + * @vdev: VirtIO parent device.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_restore(struct virtio_device *vdev)
> +{
> +	struct virtio_snd *snd =3D vdev->priv;
> +	int rc;
> +
> +	rc =3D virtsnd_restart(snd);
> +	enable_delayed_work(&snd->recover_work);
> +
> +	return rc;
> +}

[Severity: Medium]
Can virtsnd_recover_work() race with virtio_device_freeze() or a
transport-initiated virtio_device_reset_prepare(), and can
virtsnd_restore() or virtsnd_reset_done() revive a card that was already
disconnected after a failed recovery?

virtio_device_freeze() and virtio_device_reset_prepare() call
virtio_config_core_disable(vdev) before invoking the driver callback:

CPU0                                  kworker
----                                  -------
virtio_device_freeze(vdev)            virtsnd_recover_work()
  virtio_config_core_disable(vdev)
  virtsnd_freeze(vdev)
    disable_delayed_work_sync(...)
                                        virtio_device_reset_done(vdev)
                                          virtio_device_restore_priv(vdev)
                                            virtio_config_core_enable(vdev)
    virtsnd_quiesce(snd)  <-- vdev->config_core_enabled left true

Furthermore, if virtsnd_recover_work() fails its reset, sets
snd->recover_failed =3D true, and disconnects snd->card, a subsequent
virtsnd_restore() or transport-initiated virtsnd_reset_done() does not
check snd->recover_failed and unconditionally calls virtsnd_restart() and
enable_delayed_work(&snd->recover_work), re-initializing virtqueues and
enabling event dispatch on a disconnected card.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 15d4473f4c0a0..dcce428d704c7 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -661,6 +706,9 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_subst=
ream *substream,
>  	u64 epoch;
>  	int rc;
> =20
> +	rc =3D virtsnd_recover_wait(vss->snd);
> +	if (rc)
> +		return rc;
>  	guard(mutex)(&vss->lifecycle_lock);

[Severity: High]
Why don't virtsnd_pcm_open(), virtsnd_pcm_hw_free(), and
virtsnd_pcm_sync_stop() also wait for an in-progress recovery reset?

The commit message notes that open and hw_free do not wait because they
run under pcm->open_mutex, which recovery takes to suspend the streams.
However:

1. virtsnd_recover_work() only holds pcm->open_mutex inside
   snd_pcm_suspend_all() and releases it before calling
   virtio_device_reset_prepare() and virtio_device_reset_done(), so
   pcm->open_mutex is not held while vss->resetting and snd->recovering
   are true.
2. SNDRV_PCM_IOCTL_HW_FREE (snd_pcm_hw_free()) and the error path of
   snd_pcm_hw_params() only take runtime->buffer_mutex, never
   pcm->open_mutex.

As a result, during recovery virtsnd_pcm_open() fails with -ECANCELED or
-EIO; virtsnd_pcm_hw_free() on close returns -EIO or -ECANCELED from
virtsnd_pcm_sync_stop_locked() before virtsnd_reset_vqs() detaches pending
buffers, causing !virtsnd_pcm_msg_pending_num(vss) to be false and skipping
virtsnd_pcm_msg_free(vss) so vss->msgs and vss->dma_pages remain allocated;
and when snd_pcm_hw_params() or snd_pcm_do_prepare() calls
snd_pcm_sync_stop() before invoking ops->hw_params() or ops->prepare(),
virtsnd_pcm_sync_stop() sees vss->resetting =3D=3D true and sets
substream->runtime->stop_operating =3D true again before
virtsnd_recover_wait() runs.

[ ... ]

> @@ -933,6 +982,10 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substr=
eam *substream)
> =20
>  	int rc;
> =20
> +	/* Applications prepare again as soon as recovery suspends the stream. =
*/
> +	rc =3D virtsnd_recover_wait(vss->snd);
> +	if (rc)
> +		return rc;
>  	guard(mutex)(&vss->lifecycle_lock);
>  	rc =3D virtsnd_pcm_prepare_locked(substream);

[Severity: Medium]
Can ordering races between virtsnd_pcm_control_settle(),
virtsnd_recover_work(), and virtsnd_recover_wait() cause
snd_pcm_prepare() and snd_pcm_hw_params() to fail with -EIO or -ESTRPIPE
instead of waiting for recovery?

Two sequences can happen when recovery starts:

1. In snd_pcm_do_prepare() and snd_pcm_hw_params(), ALSA core calls
   snd_pcm_sync_stop() before ops->prepare() or ops->hw_params().  When
   vss->control_uncertain is true and runtime->stop_operating is set,
   snd_pcm_sync_stop() -> virtsnd_pcm_control_settle() waits 4 timeouts,
   calls virtsnd_recover_schedule(vss->snd, 0), and returns -EIO (which
   snd_pcm_sync_stop() ignores).  Because virtsnd_recover_schedule() only
   queues snd->recover_work without setting snd->recovering =3D true,
   virtsnd_recover_wait() in virtsnd_pcm_prepare() or
   virtsnd_pcm_hw_params() sees snd->recovering =3D=3D false and returns 0
   immediately.  virtsnd_pcm_prepare_locked() or virtsnd_pcm_hw_params()
   then enters virtsnd_pcm_control_settle() a second time, which either
   returns -EIO as soon as virtsnd_recover_work() sets snd->recovering =3D
   true (leaving runtime->state in SNDRV_PCM_STATE_SETUP, which
   snd_pcm_suspend_all() then skips with -EBUSY) or waits another 4
   timeouts if rate-limited by snd->recover_next.
2. In virtsnd_recover_work(), WRITE_ONCE(snd->recovering, true) runs
   before snd_pcm_suspend_all().  If a thread enters snd_pcm_prepare() on
   a stream in PREPARED or XRUN state after snd->recovering becomes true
   and sleeps in virtsnd_recover_wait() before snd_pcm_suspend_all()
   suspends that substream, snd_pcm_suspend_all() sets runtime->state to
   SNDRV_PCM_STATE_SUSPENDED while the thread is sleeping.  After the
   reset completes, virtsnd_pcm_prepare_locked() configures and prepares
   the reset device, but snd_pcm_finish_prepare() then sees
   runtime->state =3D=3D SNDRV_PCM_STATE_SUSPENDED, cancels the completed
   prepare via virtsnd_pcm_prepare_complete(s, false), and returns
   -ESTRPIPE:

sound/core/pcm_native.c:snd_pcm_finish_prepare() {
	if (runtime->state =3D=3D SNDRV_PCM_STATE_SUSPENDED) {
		snd_pcm_Substream_ops_prepare_complete(substream, false);
		return -ESTRPIPE;
	}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D20
