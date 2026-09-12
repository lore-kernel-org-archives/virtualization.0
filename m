Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46567311597
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789210277; cv=none; b=HLtfbep6BcWLBgkSveHD7zVxDWkTlH21epRygeSW3Re3896I1p5F764juVMjEr/wzscAfzwUSL41mKr0sk2WCPEGasaVDPbnxZ54CRDhd6LIgmyF9w3nrwmMiqDKLyNrIBsH2sdcrZG30EXwZGFHxqPwrwIHeeD5a9QbL1aCV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789210277; c=relaxed/simple;
	bh=ONXXz+nNK1f3+umzkIhAV/qNCySMBpvKgS2AKY1j7QU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIHsP2A2K7/XoxuP3P2aEprUjmKe75PmwhFA7RrOOYBSqNaT05qxaBZYmvePnuUZVAcIokFdybJGJtTF/nHB2oD0cJ8d9c8J1h/ifkg6WpYxWIeDMsokPUED8J3tMpVd38ZDGM2Y8nL13aLB/eTmKeLm48RHM/x4VSXO+LltsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4CjP4c1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4CjP4c1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D21F00893;
	Sat, 12 Sep 2026 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789210276;
	bh=tnejrhgbQLnwcCcwz3EyzXdTpPBRha/FY69rke1hqzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M4CjP4c1zU/blB/tSMlfblXFs/EIcGd823HoRxznhFNAIwpppc2g+CVWPUhhNDyNL
	 9CCKSfo4THdsxWLa/1mkWpuHxYbpzh1LKRQTY2tKkSzcapbYFGU4Jkl9rjgmOopvPb
	 AxQIogpb0YEPsaQ+nuPssVD/5SlBIsldpBUPeOTYCf+H15WS7bXCOEMYUVW5ZwXwSH
	 VoUZRYiQvRWOyVzNi9gpIWSAlpLJaaOUOAGJEkCxuMza5nxWmYjUTpyBhEYNNPHrFt
	 FSoA2XdyQWa3uAHT/NhCziK/crMAHBw5p9GYZjBw1Z53MgR+NbFd8S6MCNSAhjluVy
	 fJDzlAiHkcWTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] virtio_pci_modern: move avq cleanup from reset
 to del_vqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <21fe35ad7b66e2c30dbdba6fe4df4824d1c0db66.1789204858.git.mst@redhat.com>
References: <cover.1789204858.git.mst@redhat.com>
 <21fe35ad7b66e2c30dbdba6fe4df4824d1c0db66.1789204858.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:51:15 +0000
Message-Id: <20260912105115.C40D21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Surprise removal of the PF device while a VF is executing an admin=
 command leads to an unresolvable deadlock.
--

commit 77107fdcf13b9589fc326075af29c2e63cc3478d
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_pci_modern: move avq cleanup from reset to del_vqs

This commit moves the admin virtqueue cleanup from the device reset path
to the virtqueue deletion path to prevent a race condition with the interru=
pt
handler.

Link: https://lore.kernel.org/virtualization/20260911125745.E0A2F1F00899@sm=
tp.kernel.org/

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 6d8ae2a6a8caf..b4249afd7f580 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c

[ ... ]

> @@ -364,6 +364,12 @@ static void vp_modern_avq_cleanup(struct virtio_devi=
ce *vdev)
>  	}
>  }
> =20
> +static void vp_modern_del_vqs(struct virtio_device *vdev)
> +{
> +	vp_modern_avq_cleanup(vdev);

[Severity: High]
This isn't a bug introduced by this patch, but could this architecture still
lead to an unresolvable deadlock during a surprise removal of the PF device?

If a VF driver executes an admin command, the thread blocks uninterruptibly
in virtqueue_exec_admin_cmd() waiting for the command to complete.

If a surprise removal of the PF occurs while the VF is blocked, the PF
driver calls virtio_pci_remove(), which then calls pci_disable_sriov() to
wait for all VFs to unbind.

However, the VF unbind is blocked because the VF thread is stuck in
wait_for_completion(). Because pci_disable_sriov() never returns, the PF
removal never reaches unregister_virtio_device() and thus never calls this
vp_modern_del_vqs() function to detach the unused buffers and unblock the
VF thread.

Is there a way to abort the pending admin commands earlier in the PF surpri=
se
removal path, before it blocks on disabling SRIOV?

> +	vp_del_vqs(vdev);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789204858.gi=
t.mst@redhat.com?part=3D2
