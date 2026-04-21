Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DDA38C42E
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791345; cv=none; b=BY5TVMY4hWKOj2luEqmJnFI0HrAzXMZcPp9IzoBurjuPw8QMMTQhS0D9daMd6I82NDJ+4ggHlWZdfcugTDOjeA4bApbkzdMW8nrsthZJgixRllLA5FJ6XvoliG4h4DEqeauHFVGBCG/N0ueQv9+J1Po69iIUP/h91pjn2MC53bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791345; c=relaxed/simple;
	bh=KF+hnFE5zemQkg6FfCpCa81pYbVb5pGGjG3G/qYokgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+VZ2mhTj3Lf5m0Pjmb/Ac+C14h6CmSOuuP30JQm7u8hMpz5oVbagoSyO3CiSfF+AYfVWO05lDwru9j2VglvtV1K0wJfRbHsMUG/9/Ba8SpFodr0YuddmFyA7UUBXYGC0FkGShAL35oUsASvbHs/LPpqRkD2JZFBaurhyDeyq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBTQxXdz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBTQxXdz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d87610513so51066451cf.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791343; x=1777396143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGNTr/JlJ9YLgvk3Bc7iOJPEjvIVMGi2qIs7qCWOT8Q=;
        b=iBTQxXdzIuxuhNz9TX9k5gBYQs5EqChR25TE90GsykqgPMHi8V044jR89qHLiKkPj5
         5M7gQ70aLCJfq5+TJzwjF1LiSLK+SBM0PFmi1vicAWAQS+bl0Ag2axfQHmcxQUPIhvzg
         e8pA1H7vjHH00w1f8Oh/orLBJPIBXhyM7Sfqz7Ule3C6SalQ5QhRAFYsfpDAolVaAmWY
         4P4PCall+VY2mALnRjzocHmfv2tE2pcBeAgyzd9aqb1oIGDw9z9t+q0QFKlvQN/u9rIm
         6p2wi8S0lCa0CQyNXjiIWCh2ICmYhNt5Xzg9+QNyrJDIbT0YsjODDdcdLQCTNiNckXdy
         k9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791343; x=1777396143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGNTr/JlJ9YLgvk3Bc7iOJPEjvIVMGi2qIs7qCWOT8Q=;
        b=fdnLM0MKmQ+Zemmt87aqbCLPukTYm0kzvBBXU/IRBavtAaP3VmXKe9IA/uE1zTYUKp
         IFSS4QWaws3iZQ4YhLfSwsrVQcwf41dD6VPuvq5iJ0S3eyrLCmzYZxEnXMUJcYYwly79
         tuQ7/jMD1Q7zLSCaq2pOwY4E9r0TaxFetnXNHgScNRO7LBd9YJOEH+ubScUf5duUiP6w
         4FZpWG9JNbBklN6OSforgBUthQuPf64sm6jZTSPdGaONfE2ut0+DWclmQ+OVgGTS25M7
         88XkdQ7+ZGBCSVbXA/RMbQuhjGAk9nHY3r52316kHMXWK+HeGfOr8lx2nyyuRPJ7tSoU
         RAeA==
X-Forwarded-Encrypted: i=1; AFNElJ/TSPVWItU0k5lqPlZPo4kvd4mpI5U3/Oaf/cw2KjBp7XHLo/OWy99tbCQY+8A/8Qj92Hd+KBTMJe819QxW5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLDvxe7eB+LAHSnDsV2/j9ekmTubqJtiC46Iuj+yfvYol6cP+m
	5GIjEQoilTh/8hobvD/s7gA9E08Z+t+If72waM26za5XpBznZrFLvxm8
X-Gm-Gg: AeBDiet53n6UQfWlwdytcznach0H4m0nSY6IWPzmcL/B5W+ZNUkg9fuP3kNUMzuDfx7
	4Dh6K1P+gBGacUnznQ8ysS3XtdPTpIRl2t7Dc8cllMRscsOvVmf5YOhO1ceLz8WsKlvJp0xQ96Q
	gcj6/C0jT65v1+lO17FtgXl1KmRZ3ZcfW6dcBklgQpEByqDQvKI7l4pm9gOnTh+Z+xhzfNCOfOM
	jI71xSMt0z3Z1XY36qFeVUwcJDlWxGPyEwTy0rt5XHy5FrM+bmTqrZbB6onRiYhC8IcnBT3GItz
	nlU3qv6kDG5qxV+W+wa3GbCkMupFYmevfNCkM6WUc1JEQk7ASdwcoAkVYElqooLbSU6+cseHMv9
	JI1pPnD/f+Xm87Z+xl3lqJozOwwA07TZr+sb1f/R+GmfhM5PQ1yQBBeP/3gnBtktnoBfCDZDlEn
	wgYYFLvOB/N/AunUrVRNeKw1RonaZDw62ci8h+Ak6AZIurUOuG3L5dpRLSzpvfGMTMpxrlge2ZW
	1DQTTO6QEl0t69ghgcWilB5PR4tUb3hQwNAM5XkKQ==
X-Received: by 2002:a05:622a:98e:b0:50d:7fe9:aa8a with SMTP id d75a77b69052e-50e36e9c3c8mr292927801cf.31.1776791341751;
        Tue, 21 Apr 2026 10:09:01 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm13134471cf.5.2026.04.21.10.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:09:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 2/2] Bluetooth: virtio_bt: validate rx pkt_type header length
Date: Tue, 21 Apr 2026 13:08:45 -0400
Message-ID: <20260421170845.3469513-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421170845.3469513-1-michael.bommarito@gmail.com>
References: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
 <20260421170845.3469513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtbt_rx_handle() reads the leading pkt_type byte from the RX skb
and forwards the remainder to hci_recv_frame() for every
event/ACL/SCO/ISO type, without checking that the remaining payload
is at least the fixed HCI header for that type.

After the preceding patch bounds the backend-supplied used.len to
[1, VIRTBT_RX_BUF_SIZE], a one-byte completion still reaches
hci_recv_frame() with skb->len already pulled to 0. If the byte
happened to be HCI_ACLDATA_PKT, the ACL-vs-ISO classification
fast-path in hci_dev_classify_pkt_type() dereferences
hci_acl_hdr(skb)->handle whenever the HCI device has an active
CIS_LINK, BIS_LINK, or PA_LINK connection, reading two bytes of
uninitialized RX-buffer data. The same hazard exists for every
packet type the driver accepts because none of the switch cases in
virtbt_rx_handle() check skb->len against the per-type minimum HCI
header size before handing the frame to the core.

After stripping pkt_type, require skb->len to cover the fixed
header size for the selected type (event 2, ACL 4, SCO 3, ISO 4)
before calling hci_recv_frame(); drop ratelimited otherwise.
Unknown pkt_type values still take the original kfree_skb() default
path.

Use bt_dev_err_ratelimited() because both the length and pkt_type
values come from an untrusted backend that can otherwise flood the
kernel log.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v3:
- new patch, split out of the v2 commit per Luiz's request on
  the v2 thread so the per-pkt-type header-length check can be
  reviewed on its own

Changes in v2:
- in virtbt_rx_handle(), require skb->len to cover the fixed HCI
  header size for the selected pkt_type (event 2, ACL 4, SCO 3,
  ISO 4) before calling hci_recv_frame(); this prevents a one-byte
  HCI_ACLDATA_PKT completion from reaching
  hci_dev_classify_pkt_type() and dereferencing hci_acl_hdr(skb)
  over uninitialized RX buffer data when CIS/BIS/PA connections
  are present
- switch the error log to bt_dev_err_ratelimited() because the
  length and pkt_type values come from an untrusted backend that
  can otherwise flood the kernel log

 drivers/bluetooth/virtio_bt.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 2c5c39356a1c..140ab55c9fc5 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -198,6 +198,7 @@ static int virtbt_shutdown_generic(struct hci_dev *hdev)
 
 static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 {
+	size_t min_hdr;
 	__u8 pkt_type;
 
 	pkt_type = *((__u8 *) skb->data);
@@ -205,16 +206,32 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 
 	switch (pkt_type) {
 	case HCI_EVENT_PKT:
+		min_hdr = sizeof(struct hci_event_hdr);
+		break;
 	case HCI_ACLDATA_PKT:
+		min_hdr = sizeof(struct hci_acl_hdr);
+		break;
 	case HCI_SCODATA_PKT:
+		min_hdr = sizeof(struct hci_sco_hdr);
+		break;
 	case HCI_ISODATA_PKT:
-		hci_skb_pkt_type(skb) = pkt_type;
-		hci_recv_frame(vbt->hdev, skb);
+		min_hdr = sizeof(struct hci_iso_hdr);
 		break;
 	default:
 		kfree_skb(skb);
-		break;
+		return;
 	}
+
+	if (skb->len < min_hdr) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx pkt_type 0x%02x payload %u < hdr %zu\n",
+				       pkt_type, skb->len, min_hdr);
+		kfree_skb(skb);
+		return;
+	}
+
+	hci_skb_pkt_type(skb) = pkt_type;
+	hci_recv_frame(vbt->hdev, skb);
 }
 
 static void virtbt_rx_work(struct work_struct *work)
-- 
2.53.0

