Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E443BB57
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 04:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359424; cv=none; b=NrGi18uNhJh9P8TJbSFD1MEer7sqtOrKqlGbH11X4EKvWMklcpTryS57KPL65LG41bfQnqhaFcEYAQwQbO/WHgNUX8sc/D9BVAXyUcou/jH+KEhTW/6HMyeAUfzHl+tT4y4g81UjT7S618nnHX98v/VJUClyJ7vohDL2OkUUCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359424; c=relaxed/simple;
	bh=9+gYk4lvYl5e7LJeprnkyyF220jh01B6TpAIB38YI3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AXoocU/qX8dTQ2D63zH0B5OOFDDlUeWct7s8QmC3MijQcodiMiY5bLDB/qLvyFOy0QCdFUswpeONXhHmGIdcnBuAIufzVlis4zhZ2uq90Hm5ejGUsKL84U5h8DN2kZwhLx+BlJHy+mlC3xeka4deHAZJRzs0FWzVbYBrmCqsLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwSvWCe/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwSvWCe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258821F000FF;
	Mon, 14 Sep 2026 04:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789359422;
	bh=OgWCFn6WuAIusZFsQ21/9QqUfRtl8TKZzctdGmecg8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwSvWCe/Inl+wu0G4Wl+n1jZN62qeM7i+qEgag4bRYehKpOFOgJQuMTPRuGr7GGW0
	 S8/1bPOvuOjmBsxHvv/TzrbvPr9k06kqF0gvj5fY0OZ1hqjBD4rjqmlbZgI0n040Wt
	 HV82alS9QC0YOYeiC+8yn5jKp3te+cOugNROJlPe55xRND6jiadQJwiL2KgE5v9xlx
	 l/iOS1Hag7ieQetpGXgVLDCLCE4y4FyRNQyC1+o076mGuyAhyJZeQzCTqWtOFWDOya
	 sEx1st9xHhG6+GljeyvntX46UxjPN1wKgJ8ksAuEOi+HPwGHes26t4bMlYDxpAOYWQ
	 KWKg0kmRS2z6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vdpa/octeon_ep: Fix race condition in device
 deletion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260914040332.1892175-1-oss.patchbox@gmail.com>
References: <20260914040332.1892175-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 04:17:01 +0000
Message-Id: <20260914041702.258821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Incorrect teardown ordering in `octep_vdpa_remove_vf` allows hardw=
are interrupts to re-queue the event worker after it has been cancelled, le=
ading to a Use-After-Free of `mgmt_dev`.
- [High] The lockless `atomic_cmpxchg` synchronization introduced in `octep=
_vdpa_dev_del` is vulnerable to an ABA problem, allowing a Use-After-Free o=
f a stale `vdpa_device` pointer.
- [High] Early return in `octep_vdpa_dev_del` silently skips unregistering =
devices if multiple vDPA devices are mistakenly attached, leading to a perm=
anent device leak.
- [Medium] Calling `cancel_work_sync()` on a potentially uninitialized work=
 struct triggers a kernel warning (`WARN_ON(!work->func)`).

Pre-existing issues:
- [High] The worker thread `octep_event_work` directly invokes vDPA subsyst=
em registration routines without holding the mandatory `vdpa_dev_lock`, cau=
sing lockdep assertions and data races.
--

commit b72e8cd6cc3fa52be059d7ac0ebe059c31816e52
Author: Yuho Choi <oss.patchbox@gmail.com>
vdpa/octeon_ep: Fix race condition in device deletion

This patch addresses a race condition in device deletion where hardware
deletion events could race with userspace management deletions, triggering
a double release. It introduces atomic operations to claim ownership and
safely read the device pointer before unregistering.

> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index 85a3d35ea1e47..e29647bcf196d 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -523,14 +523,16 @@ static void octep_vdpa_remove_vf(struct pci_dev *pd=
ev)
>  	int status;
> =20
>  	oct_hw =3D &mgmt_dev->oct_hw;
> -	status =3D atomic_read(&mgmt_dev->status);
> -	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_UNINIT);
> -
>  	cancel_work_sync(&mgmt_dev->setup_task);
> +	cancel_work_sync(&mgmt_dev->event_wk.work);

[Severity: High]
Can hardware interrupts re-queue the event worker after this cancellation?

In octep_vdpa_remove_vf(), event_wk.work is cancelled here, but hardware
interrupts are not yet masked or freed until octep_free_irqs(oct_hw) is cal=
led
later in the function.

If a hardware interrupt fires in this window, the interrupt handler can exe=
cute
schedule_work(&mgmt_dev->event_wk.work). After teardown finishes, devres fr=
ees
mgmt_dev. The scheduled work then executes, accessing the freed memory and
causing a use-after-free.

[Severity: Medium]
Will this unconditional cancellation trigger a kernel warning if the work
struct is uninitialized?

The mgmt_dev structure is allocated with devm_kzalloc(), which
zero-initializes event_wk.work. The initialization of this work struct
happens asynchronously at the end of octep_vdpa_setup_task().

If the driver is unbound before the setup task reaches INIT_WORK(), or if t=
he
setup task encounters an error and aborts, event_wk.work remains
zero-initialized. Calling cancel_work_sync() detects the NULL work->func and
triggers a WARN_ON(!work->func).

> +
> +	status =3D atomic_read(&mgmt_dev->status);
>  	if ((status =3D=3D OCTEP_VDPA_DEV_STATUS_READY) || (status =3D=3D OCTEP=
_VDPA_DEV_STATUS_ADDED) ||
>  	    (status =3D=3D OCTEP_VDPA_DEV_STATUS_REMOVED))
>  		vdpa_mgmtdev_unregister(&mgmt_dev->mdev);

[ ... ]

> @@ -619,8 +622,13 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *=
mdev, const char *name,
>  static void octep_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_d=
evice *vdpa_dev)
>  {
>  	struct octep_vdpa_mgmt_dev *mgmt_dev =3D container_of(mdev, struct octe=
p_vdpa_mgmt_dev, mdev);
> +
> +	if (atomic_cmpxchg(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_ADDED,
> +			   OCTEP_VDPA_DEV_STATUS_REMOVED) !=3D OCTEP_VDPA_DEV_STATUS_ADDED)
> +		return;

[Severity: High]
Does this early return silently skip unregistering devices if multiple vDPA
devices are mistakenly attached?

octep_vdpa_dev_add() allows userspace to repeatedly create vDPA devices on =
the
same mgmt_dev, blindly overwriting mgmt_dev->oct_vdpa and setting
status =3D ADDED.

When userspace deletes the first device, octep_vdpa_dev_del() executes, the
cmpxchg succeeds, and the device is unregistered. When userspace attempts to
delete the second device, the cmpxchg from ADDED to REMOVED fails. The
function returns early without unregistering the second device, permanently
leaking it.

> +
>  	_vdpa_unregister_device(vdpa_dev);

[Severity: High]
This is a pre-existing issue, but does calling _vdpa_unregister_device() fr=
om
the asynchronous workqueue violate the vDPA bus locking requirements?

octep_event_work() responds to hardware events by invoking
octep_vdpa_dev_del() directly, which in turn calls _vdpa_unregister_device(=
).
The vDPA core strictly requires vdpa_dev_lock to be held when invoking this
underscored variant.

Since the asynchronous workqueue does not acquire this lock, it uncondition=
ally
triggers lockdep splats (lockdep_assert_held(&vdpa_dev_lock)) and corrupts =
the
vDPA bus device list when racing with concurrent netlink operations. (The s=
ame
applies to _vdpa_register_device() in octep_vdpa_dev_add()).

> -	atomic_set(&mgmt_dev->status, OCTEP_VDPA_DEV_STATUS_REMOVED);
> +	mgmt_dev->oct_vdpa =3D NULL;
>  }
> =20
>  static const struct vdpa_mgmtdev_ops octep_vdpa_mgmt_dev_ops =3D {

[ ... ]

> @@ -653,6 +661,7 @@ static void octep_event_work(struct work_struct *work)
>  	u8 event =3D readb(addr + OCTEP_VF_EVENT_REG(0));
>  	struct vdpa_dev_set_config config =3D {0};
>  	char name[OCTEP_VDPA_NAME_BUFSIZE];
> +	struct octep_vdpa *oct_vdpa;
>  	int ret =3D 0;
> =20
>  	switch (event) {
> @@ -663,8 +672,9 @@ static void octep_event_work(struct work_struct *work)
>  		}
>  		break;
>  	case OCTEP_VDPA_DEV_DEL_EVENT:
> -		if (atomic_read(&mgmt_dev->status) =3D=3D OCTEP_VDPA_DEV_STATUS_ADDED)
> -			octep_vdpa_dev_del(&mgmt_dev->mdev, &mgmt_dev->oct_vdpa->vdpa);
> +		oct_vdpa =3D READ_ONCE(mgmt_dev->oct_vdpa);
> +		if (atomic_read(&mgmt_dev->status) =3D=3D OCTEP_VDPA_DEV_STATUS_ADDED =
&& oct_vdpa)
> +			octep_vdpa_dev_del(&mgmt_dev->mdev, &oct_vdpa->vdpa);

[Severity: High]
Is this lockless synchronization vulnerable to an ABA problem that allows a
use-after-free?

In octep_event_work(), mgmt_dev->oct_vdpa is cached locally. If the thread =
is
preempted:

1. A concurrent netlink command calls octep_vdpa_dev_del(), successfully
setting status to REMOVED and unregistering the device.

2. A subsequent netlink command adds a new device, allocating a new object =
and
setting status to ADDED.

3. When octep_event_work() resumes, it sees status =3D=3D ADDED and calls
octep_vdpa_dev_del() with the STALE pointer.

The atomic_cmpxchg() in octep_vdpa_dev_del() succeeds because the status is
ADDED (for the new device), but it blindly unregisters the stale device pas=
sed
to it.

>  		break;
>  	default:
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914040332.1892=
175-1-oss.patchbox@gmail.com?part=3D1
