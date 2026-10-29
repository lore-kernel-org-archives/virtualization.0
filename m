Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278830;
	b=S/LA6eEtK4RnzWKduZAZCvHrIsHem8PI8p133sfYUeZSIZ4Ixl+aQsxs5/+dO4qzSPcg
	 buRYm2jWSCo44dIjtqJ12Q+MWeQFQk7laGCOGoa1I6PZdTyo5MJolzdi5pq30hLQd2fKE
	 JDR4zGJlFr60WX+k58aUBreE+OuwPAQNfy6/t5w2rSaBIR3TzDKr+lWOU6ap0GdFKw2MI
	 xT5sBtrXu5OljRl/gT/y+cts3YjvRTS6KsVUfJMiu8uT1N1iGIPN4naX0NiJjqSTEfdNO
	 +vj8DTrjk3iK9/V5flTnzm3fIR9fi/0za8eyVnctBJG89NXZJesGRP9eUKVrl0kiExg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Kkkg6jPlAqHf3tLx8/4/vP1Z5Zy86DNq7J5ZhyB3ko=;
	b=HBQlpDgDN+cOkBl+OY1YHcq33AWyFMdYTX3tzEJ4Q7V5HJe4oCb797bdg3OGur1d1Av7
	 gCYTisjdIpLjz8fhMBiqQNJOHLaStizVjR/O5Q4Cl56ChbtiOK+EWELCdNdvFbeoHwrGx
	 c4MMCnGADmOflJyhXX6bj6JUaX6X4foG0IjvVbke/QKx64xiGsb1l5yG7M6IERcv76YvF
	 ZmegHvOvhjIfkfSBVvEhlvEosIoQR8fTwb797YkBdHFsPvDajJwtZ+4PbyJutsV229IQ5
	 jalEFTI9lbHWdOr83BWPHNKtnMuZVworUvF0FoQZGzHIyiyGYM6THxhRrkOttAL7G4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhXP+rbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91885606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhXP+rbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F381F01828;
	Thu, 29 Oct 2026 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793278830;
	bh=1Kkkg6jPlAqHf3tLx8/4/vP1Z5Zy86DNq7J5ZhyB3ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NhXP+rbJXYS+yqNJQZdzwn9mmbgVkLYvd0zSMAUIfpeT6sX2ljz1J0OnJrqXSlSwC
	 8sotMESew4HsWWhZG4jSIwibjMR/yvevaa/Y5m2EW1xfEDEeSpDgWB2hzNYMH7q1H1
	 Jg9iStUzBXsqYFXBxqx7RIWZWEXezusBQYMHm53U97q1/KlaNOEVNAqXOv6EiTzDSU
	 1j9R9juYbvPz3Blt7UlQNQrUAOuhkH8vU5MfThzvgZ8W5xgfmh1YSIZb5QS8ykuVNl
	 fkcJNmmHfUayos4HbaH+Ar4+2NUyyYzKjxi2XAabHsYdt7rfzuPIGfP7MeE3c2wjwz
	 ZVNYIDI6CxXog==
Message-ID: <sashiko-outbox-189341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rpmb: add a virtio RPMB device driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haruka Kuze" <harukak@zohomail.eu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029124132.2354314-3-harukak@zohomail.eu>
References: <20261029124132.2354314-1-harukak@zohomail.eu>
 <20261029124132.2354314-3-harukak@zohomail.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:00:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rpmb: virtio_rpmb: incorrect reliable_wr_count calculation in virt=
io_rpmb_probe()
- [High] rpmb: virtio_rpmb: race on virtqueue in virtio_rpmb_done()
- [Medium] virtio_rpmb: avoid duplicate del_vqs() in virtio_rpmb_del_vq() a=
fter failed restore
--

commit df2c2241a3933ce84e1976592ab925a107995087
Author: Haruka Kuze <harukak@zohomail.eu>

rpmb: add a virtio RPMB device driver

This commit adds a driver for virtio RPMB devices (virtio ID 28) and
registers them with the RPMB subsystem as RPMB_TYPE_EMMC so in-kernel users
such as OP-TEE can access them.

Link: https://lore.kernel.org/all/20220405093759.1126835-4-alex.bennee@lina=
ro.org/

> diff --git a/drivers/misc/virtio_rpmb.c b/drivers/misc/virtio_rpmb.c
> new file mode 100644
> index 0000000000000..4caca378fecc4
> --- /dev/null
> +++ b/drivers/misc/virtio_rpmb.c

[ ... ]

> +static void virtio_rpmb_done(struct virtqueue *vq)
> +{
> +	struct virtio_rpmb_req *req;
> +	unsigned int len;
> +
> +	while ((req =3D virtqueue_get_buf(vq, &len))) {
> +		req->len =3D len;
> +		complete(&req->done);
> +	}
> +}
> +
> +static int virtio_rpmb_xfer(struct virtio_rpmb *vr, void *out,
> +			    unsigned int out_len, void *in, unsigned int in_len)
> +{
> +	struct scatterlist out_sg, in_sg, *sgs[2] =3D { &out_sg, &in_sg };
> +	struct virtio_rpmb_req req;
> +	int ret;
> +
> +	sg_init_one(&out_sg, out, out_len);
> +	sg_init_one(&in_sg, in, in_len);
> +	init_completion(&req.done);
> +
> +	guard(mutex)(&vr->lock);
> +	if (!vr->vq)
> +		return -ENODEV;
> +
> +	ret =3D virtqueue_add_sgs(vr->vq, sgs, 1, 1, &req, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	virtqueue_kick(vr->vq);
> +	wait_for_completion(&req.done);
> +
> +	return req.len =3D=3D in_len ? 0 : -EIO;
> +}

[Severity: High]
Can virtio_rpmb_done() race with virtio_rpmb_xfer() on the virtqueue state?

In virtio_rpmb_done(), once complete(&req->done) is called on the first loop
iteration, the task waiting in virtio_rpmb_xfer() can wake up, exit the
function, and release vr->lock while virtio_rpmb_done() is still looping to
call virtqueue_get_buf(vq, &len) again:

CPU0                                    CPU1
virtio_rpmb_done()                      virtio_rpmb_xfer()
  req =3D virtqueue_get_buf(vq, &len);
  complete(&req->done);
                                          wait_for_completion(&req.done);
                                          /* releases vr->lock */
                                        virtio_rpmb_xfer()
                                          /* acquires vr->lock */
  virtqueue_get_buf(vq, &len);            virtqueue_add_sgs(vr->vq, ...);
                                          virtqueue_kick(vr->vq);

Additionally, because virtqueue_add_sgs() exposes the available descriptor
before returning, a polling host or spurious interrupt can trigger
virtio_rpmb_done() concurrently with virtqueue_add_sgs() or virtqueue_kick(=
).

Since virtio_ring requires callers to synchronize virtqueue_get_buf() again=
st
virtqueue_add_sgs() and virtqueue_kick(), could this corrupt virtqueue state
(such as vq->free_head, vq->vq.num_free, and vq->num_added) or trigger the
START_USE(vq) / END_USE(vq) checks in drivers/virtio/virtio_ring.c when DEB=
UG
is enabled?

[ ... ]

> +static void virtio_rpmb_del_vq(struct virtio_rpmb *vr)
> +{
> +	struct virtio_device *vdev =3D vr->vdev;
> +
> +	scoped_guard(mutex, &vr->lock)
> +		vr->vq =3D NULL;
> +
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +}

[Severity: Medium]
What happens if virtio_rpmb_restore() fails after virtio_rpmb_freeze() has
already torn down the virtqueue?

During suspend, virtio_rpmb_freeze() calls virtio_rpmb_del_vq(), which sets
vr->vq =3D NULL, resets the device, and calls vdev->config->del_vqs(vdev).

If virtio_rpmb_restore() -> virtio_rpmb_init_vq() -> virtio_find_single_vq()
later fails during resume, vr->vq remains NULL while the driver stays bound
to the device. When virtio_rpmb_remove() or a subsequent virtio_rpmb_freeze=
()
runs, virtio_rpmb_del_vq() will unconditionally call
vdev->config->del_vqs(vdev) a second time without a matching find_vqs(),
which on transports such as virtio_mmio calls free_irq() on an already-freed
interrupt.

Should virtio_rpmb_del_vq() return early if vr->vq is already NULL?

> +
> +static int virtio_rpmb_probe(struct virtio_device *vdev)
> +{
> +	struct rpmb_descr descr =3D {
> +		/* Frames and their semantics are that of eMMC */
> +		.type =3D RPMB_TYPE_EMMC,
> +		.route_frames =3D virtio_rpmb_route_frames,
> +		.dev_id =3D (u8 *)virtio_rpmb_dev_id,
> +		.dev_id_len =3D sizeof(virtio_rpmb_dev_id),
> +	};
> +	struct virtio_rpmb *vr;
> +	u8 capacity;
> +	int ret;
> +
> +	capacity =3D virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
> +						capacity));
> +	if (!capacity || capacity > 0x80)
> +		return dev_err_probe(&vdev->dev, -EINVAL,
> +				     "invalid capacity %u\n", capacity);
> +
> +	vr =3D devm_kzalloc(&vdev->dev, sizeof(*vr), GFP_KERNEL);
> +	if (!vr)
> +		return -ENOMEM;
> +
> +	vdev->priv =3D vr;
> +	vr->vdev =3D vdev;
> +	mutex_init(&vr->lock);
> +	vr->max_wr =3D virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
> +						  max_wr_cnt));
> +	vr->max_rd =3D virtio_cread8(vdev, offsetof(struct virtio_rpmb_config,
> +						  max_rd_cnt));
> +
> +	ret =3D virtio_rpmb_init_vq(vr);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * eMMC reports the reliable wr count in 512 byte sectors, but the devi=
ce
> +	 * limit is in 256 byte blocks.
> +	 */
> +	descr.capacity =3D capacity;
> +	descr.reliable_wr_count =3D (vr->max_wr ?: U8_MAX) / 2;

[Severity: High]
Should descr.reliable_wr_count be set without dividing vr->max_wr by 2 here?

Each 256-byte RPMB data block is carried inside a single 512-byte
virtio_rpmb_frame (one 512-byte eMMC sector per 256-byte RPMB data payload).
In virtio_rpmb_route_frames(), vr->max_wr is checked directly against the
number of 512-byte frames:

drivers/misc/virtio_rpmb.c:virtio_rpmb_route_frames() {
	...
	case VIRTIO_RPMB_REQ_DATA_WRITE:
		if (req_len % VIRTIO_RPMB_FRAME_SIZE ||
		    resp_len !=3D VIRTIO_RPMB_FRAME_SIZE)
			return -EINVAL;
		if (vr->max_wr && req_len / VIRTIO_RPMB_FRAME_SIZE > vr->max_wr)
			return -EINVAL;
	...
}

In the RPMB subsystem, descr.reliable_wr_count is also the number of RPMB
frames (256-byte data blocks) per write request, matching mmc_blk_rpmb_add()
in drivers/mmc/core/block.c:

drivers/mmc/core/block.c:mmc_blk_rpmb_add() {
	...
	struct rpmb_descr descr =3D {
		.type =3D RPMB_TYPE_EMMC,
		.route_frames =3D mmc_route_rpmb_frames,
		.reliable_wr_count =3D card->ext_csd.enhanced_rpmb_supported ?
				     2 : 32,
	...
}

Dividing by 2 in virtio_rpmb_probe() halves the advertised write count, and
when a device reports max_wr_cnt =3D=3D 1, integer division truncates
descr.reliable_wr_count to 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029124132.2354=
314-1-harukak@zohomail.eu?part=3D2
