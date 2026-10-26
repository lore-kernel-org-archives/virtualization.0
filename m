Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009275;
	b=aZIui4RjCw1Cuo3wUkC/WOE0pzV3WQ2WLPdXdG53SnFPc1q2hy/wGmwHqiodVJdSA4VV
	 +MoPjTunrzymod2OAarSIRBvjl6vuwTSQFJIWm8wlpe0laNaCIO248iOOhcWCiMBX5WqN
	 bg2g2TDBvbICXvIYoopc8n3wrR6goK3NetUau8oXUUs3xsbzb7KBb0ws3c6v6jb4dukNo
	 kaBb4WwFxs+lq6ruZuFOIW/SRja4i61V6NsFPa0nrSQE+97hbx4U7FW+XvarOBMoR15b9
	 oGwAxmQjs+X2iQwO9hZhpzkJLs/Rq22Rk3ovFSK4MhvPghAZeCZQOrUcV3Zw6Sl9pXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qGhuJAQVJEBM4TXuDaLiV7OS+6IfjFMqlLL810xwEAQ=;
	b=tM91Tk5GqLKPr6r226SGDE7bbqom2Im4EPKuGkt26A1Y3GJeUBaObnDU34A9PQscaGr+
	 nqn8TE2YL0qHL/6K8yafU0nzT+BUvEIY8WoP4kRwRXzLtiFQdVcs+G7is8hKh3PUPmLYO
	 PHJX1v61JPMpzFODi9qm23Qwd3HZ32dp6yhA1po+Etf2xzlqB8EhWnlY4pnZUQJzstw8m
	 4ZLrbfQ80yoVT4SleKYPX/4Wxp1yPgHzl4V/C+SuDT6bFpGtdifr0yvAugbqlCwDRd7ai
	 vLoeedMbfC6fRZmV9MwuL2bM6caubAccVVavObGrKYHxkE2rBWnTFtVko6CmKIUWQLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+z6IHjk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDD606A31A;
	Mon, 26 Oct 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+z6IHjk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF61F01282;
	Mon, 26 Oct 2026 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009275;
	bh=qGhuJAQVJEBM4TXuDaLiV7OS+6IfjFMqlLL810xwEAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+z6IHjkAf1u7DOIPbdEqKR7MU4bUIbyHNosP4henqyUpVRDkZ/Cdq5KyCTUJp1FS
	 S18MULRcND2e5KTUl4wbZRCpBV/1TW+UWt1vtWp5mQOBm45vrDzSIMOTYaR6G53ctJ
	 JZUMlLpgYvFC4oGQPoi0mAB3IIT6o6vnwSbCHKQeo+C5/CE0bGYZtWHHhp9jwexDpO
	 Pr306dXexo7Kb2FK8+GcPPnfWnWtRfZ90D2KRQX8y8cTtZotp4ailgm7cP7OlK2/Jt
	 B51uy32rVdbBGSeYHKz2AZzinEaldIidpZ75cHiwQpW5RIxmRG2J5OP2nRenk1tzyt
	 6By9Zjq0VKEPg==
Message-ID: <sashiko-outbox-184880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/23] drm/msm/dcp: Add HFI VirtIO transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-6-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-6-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:07:54 +0000
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
- [Critical] drm/msm/dcp: stack use-after-free on timeout in dcp_hfi_send_s=
ync_on_vq()
- [High] drm/msm/dcp: unsynchronized virtqueue callbacks and work re-arming=
 on teardown
- [Medium] drm/msm/dcp: double-fetch from shared DMA buffer in dcp_hfi_resp=
_callback()
--

commit 250b478306210e9e3849c522be712bc686a63c4b
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI VirtIO transport

This commit implements the HFI transport over VirtIO between Linux and the =
DCP
firmware, managing DMA command and response buffers, VirtIO queue callbacks,
synchronous and asynchronous command submission, and teardown synchronizati=
on.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm=
/dcp/dcp_hfi_core.c
> new file mode 100644
> index 0000000000000..9f7ac798e13c4
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c

[ ... ]

> +void dcp_hfi_resp_callback(struct virtqueue *vq)
> +{
> +	struct dcp_drv *drv =3D vq->vdev->priv;
> +	struct dcp_hfi *hfi =3D drv ? drv->hfi : NULL;
> +	struct dcp_hfi_buf *buf;
> +	unsigned int len;
> +	unsigned long drain_flags;
> +
> +	if (!hfi || atomic_read(&hfi->shutdown_in_progress))
> +		return;
> +
> +	spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
> +	virtqueue_disable_cb(vq);
> +	for (;;) {
> +		while ((buf =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> +			struct hfi_cmd_buff_hdl hdl;
> +			struct hfi_header_info hdr_info;
> +			struct hfi_packet_info pkt_info;
> +			u32 pkt_num;
> +			int rc;
> +
> +			spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
> +
> +			if (unlikely(len < sizeof(struct hfi_header) ||
> +				     len > DCP_HFI_BUF_SIZE)) {
> +				dev_warn_ratelimited(hfi->dev,
> +						     "HFI resp: short buffer len=3D%u (min=3D%zu) =E2=80=94 skippi=
ng\n",
> +						     len, sizeof(struct hfi_header));
> +				goto repost;
> +			}
> +
> +			hdl.cmd_buffer =3D buf->data;
> +			hdl.size =3D (u32)len;
> +			rc =3D hfi_unpacker_get_header_info(&hdl, &hdr_info);
> +			if (rc) {
> +				dev_warn_ratelimited(hfi->dev,
> +						     "HFI resp: invalid header (rc=3D%d) len=3D%u\n",
> +					     rc, len);
> +				print_hex_dump(KERN_WARNING, "HFI resp raw: ",
> +					       DUMP_PREFIX_OFFSET, 16, 4,
> +					       buf->data, min_t(u32, len, 64), false);
> +				goto repost;
> +			}
> +
> +			for (pkt_num =3D 1; pkt_num <=3D hdr_info.num_packets; pkt_num++) {
> +				memset(&pkt_info, 0, sizeof(pkt_info));
> +				rc =3D hfi_unpacker_get_packet_info(&hdl, pkt_num,
> +								  &pkt_info);

[Severity: Medium]
Does unpacking directly from the coherent DMA buffer in
dcp_hfi_resp_callback() expose the parser to a double-fetch if the firmware=
 or
VirtIO backend modifies the shared buffer concurrently?

In dcp_hfi_init(), the buffers in hfi->resp_pool are allocated with
dma_alloc_coherent() and premapped into hfi->resp_vq, so buf->data remains =
in
shared DMA memory writable by the device.

When hfi_unpacker_get_packet_info() runs on buf->data, it first validates t=
he
buffer through hfi_sanitize_cmd_buff(), and then re-reads packet->payload_i=
nfo
in hfi_packet_at() and GET_PACKET_SIZE(packet->payload_info):

drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c:hfi_unpacker_get_packet_info() {
	hdr =3D cmd_buf_hdl->cmd_buffer;
	if (GET_HEADER_SIZE(hdr->cmd_buff_info) > cmd_buf_hdl->size ||
	    packet_num > hdr->num_packets || hfi_sanitize_cmd_buff(hdr))
		return -EINVAL;

	packet =3D hfi_packet_at(hdr, packet_num);
	packet_size =3D GET_PACKET_SIZE(packet->payload_info);
	...
	packet_info->payload_size =3D packet_size - sizeof(*packet);
	packet_info->payload_ptr =3D packet_info->payload_size ?
		(void *)(packet + 1) : NULL;
}

If hdr->cmd_buff_info or packet->payload_info changes in shared memory after
hfi_sanitize_cmd_buff() returns, hfi_packet_at() can walk past the buffer or
packet_size can become smaller than sizeof(*packet) (underflowing
packet_info->payload_size) before dcp_hfi_complete_pending() calls memcpy()=
 on
pkt_info->payload_ptr.

Should dcp_hfi_resp_callback() copy the received len bytes out of buf->data
into a non-shared kernel buffer before validating and unpacking the packets?

[ ... ]

> +static int dcp_hfi_send_sync_on_vq(struct dcp_hfi *hfi,
> +				   struct virtqueue *vq __maybe_unused,
> +				   u32 cmd,
> +				   enum hfi_cmd_buff_type cmd_type,
> +				   u32 object_id,
> +				   enum hfi_packet_payload_type payload_type,
> +				   void *payload,
> +				   u32 payload_size,
> +				   u32 tx_flags,
> +				   void *resp_data,
> +				   size_t resp_len,
> +				   unsigned int timeout_ms)
> +{
> +	struct dcp_hfi_buf *buf;
> +	struct dcp_hfi_completion comp;

[ ... ]

> +	ret =3D dcp_hfi_send_cmd_async(hfi, buf,
> +				     hfi_get_header_size(&hdl), &comp);
> +	if (ret)
> +		return ret;
> +
> +	if (!wait_for_completion_timeout(&comp.done, msecs_to_jiffies(timeout_m=
s))) {
> +		dev_err(hfi->dev,
> +			"HFI cmd=3D0x%x buf_type=3D%s object_id=3D%u timed out after %ums (pk=
t_id=3D%u)\n",
> +			cmd, dcp_hfi_cmd_buff_type_name(cmd_type), object_id,
> +			timeout_ms, packet_id);
> +		spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +		dcp_hfi_pending_find(hfi, packet_id);
> +		spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return comp.status;
> +}

[Severity: Critical]
Can a timeout racing with response completion cause a stack use-after-free =
of
comp and the caller's resp_data buffer in dcp_hfi_send_sync_on_vq()?

In dcp_hfi_resp_callback(), hfi->resp_drain_lock is dropped before unpacking
the response and calling dcp_hfi_complete_pending():

dcp_hfi_resp_callback()
  spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
  ...
  dcp_hfi_complete_pending()
    comp =3D dcp_hfi_pending_find(hfi, pkt_info->packet_id);
      spin_lock_irqsave(&hfi->pending_lock, flags);
      comp =3D xa_erase(&hfi->pending_xa, packet_id);
      spin_unlock_irqrestore(&hfi->pending_lock, flags);
    if (!status && comp->resp_data && comp->resp_len &&
        pkt_info->payload_size) {
        n =3D min_t(size_t, comp->resp_len, pkt_info->payload_size);
        memcpy(comp->resp_data, pkt_info->payload_ptr, n);
    }
    comp->status =3D status;
    complete(&comp->done);

If wait_for_completion_timeout() expires right after dcp_hfi_pending_find()=
 in
dcp_hfi_complete_pending() erases comp from hfi->pending_xa, acquiring
hfi->resp_drain_lock on the timeout path does not wait for
dcp_hfi_complete_pending() because neither resp_drain_lock nor pending_lock=
 is
held during the memcpy(), status assignment, and complete() calls.

The timeout path's dcp_hfi_pending_find(hfi, packet_id) then returns NULL, =
and
dcp_hfi_send_sync_on_vq() immediately returns -ETIMEDOUT while
dcp_hfi_complete_pending() on the other CPU is still writing to the stack-
allocated comp and comp->resp_data.

Should the completion update be serialized under a lock held across the loo=
kup
and memcpy()/complete(), or should the timeout path wait on
wait_for_completion(&comp.done) when dcp_hfi_pending_find() returns NULL?

[ ... ]

> +void dcp_hfi_stop(struct dcp_hfi *hfi)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hfi->cmd_lock, flags);
> +	atomic_set(&hfi->shutdown_in_progress, 1);
> +	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
> +
> +	cancel_delayed_work_sync(&hfi->resp_repost_work);
> +	dcp_hfi_cancel_pending(hfi, -ENODEV);
> +}
> +
> +void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +	if (hfi->cmd_vq)
> +		virtqueue_disable_cb(hfi->cmd_vq);
> +	if (hfi->resp_vq)
> +		virtqueue_disable_cb(hfi->resp_vq);
> +	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +
> +	if (hfi->cmd_vq)
> +		while (virtqueue_detach_unused_buf(hfi->cmd_vq))
> +			;
> +	if (hfi->resp_vq)
> +		while (virtqueue_detach_unused_buf(hfi->resp_vq))
> +			;
> +}
> +
> +void dcp_hfi_deinit(struct dcp_hfi *hfi)
> +{
> +	xa_destroy(&hfi->pending_xa);
> +
> +	dcp_hfi_free_pool(hfi, hfi->cmd_pool, DCP_HFI_CMD_POOL_SIZE);
> +	dcp_hfi_free_pool(hfi, hfi->resp_pool, DCP_HFI_RESP_POOL_SIZE);
> +}

[Severity: High]
How are in-flight dcp_hfi_resp_callback() and dcp_hfi_cmd_callback() calls
synchronized with dcp_hfi_stop(), dcp_hfi_quiesce_queues(), and
dcp_hfi_deinit() during teardown?

In dcp_hfi_resp_callback(), hfi->shutdown_in_progress is only checked once =
at
entry before acquiring hfi->resp_drain_lock, and hfi->resp_drain_lock is
released while unpacking each buffer before being re-acquired at repost:

dcp_hfi_resp_callback() {
	if (!hfi || atomic_read(&hfi->shutdown_in_progress))
		return;

	spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
	...
			spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
			...
repost:
			spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
			dcp_hfi_buf_init_sg(buf, DCP_HFI_BUF_SIZE);
			if (virtqueue_add_inbuf_premapped(vq, &buf->sg, 1, buf,
							  NULL, GFP_ATOMIC)) {
				list_add_tail(&buf->node, &hfi->resp_repost_list);
				schedule_delayed_work(&hfi->resp_repost_work,
						      msecs_to_jiffies(20));
			}
		}

		if (virtqueue_kick_prepare(vq))
			virtqueue_notify(vq);
		if (virtqueue_enable_cb(vq))
			break;
}

If dcp_hfi_stop() runs while dcp_hfi_resp_callback() has dropped
hfi->resp_drain_lock, dcp_hfi_stop() sets shutdown_in_progress =3D 1 and ca=
lls
cancel_delayed_work_sync(&hfi->resp_repost_work), after which
dcp_hfi_resp_callback() can reach repost:, re-add the buffer to vq, re-arm
hfi->resp_repost_work, and call virtqueue_enable_cb(vq).

Similarly, in dcp_hfi_cmd_callback(), shutdown_in_progress is checked before
acquiring hfi->cmd_lock, and in dcp_hfi_quiesce_queues(),
virtqueue_disable_cb(hfi->cmd_vq) is called under hfi->resp_drain_lock inst=
ead
of hfi->cmd_lock while virtqueue_detach_unused_buf() is called on both queu=
es
without holding cmd_lock or resp_drain_lock and without waiting for an
in-flight dcp_hfi_resp_callback() to finish using buf->data before
dcp_hfi_deinit() frees the pools.

Should the callbacks re-check shutdown_in_progress under their respective
locks, and should teardown synchronize with in-flight callbacks before
canceling the delayed work, detaching virtqueue buffers, and freeing the DMA
pools?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D6
