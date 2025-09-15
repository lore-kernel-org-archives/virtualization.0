Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487323D7CE
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952210; cv=none; b=P16mWXBKhJ4ncEWjWSAeJJAHo27LK+lbBtbxlviB4o/VNuD99hFu4pxrCUPCWf6aX0voXFzgFjLs4lBF8G4O0GyTj53Sv2Ywag95ClfX/Khz/e2Id2uR0W2mJRkJowdLzbczoDFMq2P4ml3wh18CmeIBUqhUu1nZsPijP7k0oiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952210; c=relaxed/simple;
	bh=BAS0GBMKCDtwydPahpuw2HyfF0E/Y0qQ4Zq/+5p3ac8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UqHFyApFcgj0l8PfFNgPY/fGLQjUyhb8r2q2wBBsO7Cy+oWFw7M1GTfx0UxDgsOgntLQ9d3Xbnrc083puGRTdIWDs6sfZT/YsWHaGkTz79P92iDwtUw/YMzYkq+pK4dkYpEyugiFEJLFewMhc40X5FQcDL107c4d5OFTVM4hoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgrCjP5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgrCjP5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMxsZvyoTV3G/hm1yNnpqqa9WqA68QAPsx4b+ZiU9Ys=;
	b=JgrCjP5FIRnDZmRBEzRCAS45ljjKhhL/ykRg7IVvCFXJNQo6IglMnv4u81RHHyBqpr4kR2
	PXHW+R0mvCmJS78TJiPn/HcYhlfAL9LMSsfjKAIsbScblntbIGgSl5PRaW7nw4okGA4ecF
	5izbNlLm5lav5Zf3cMNOiG/8YDhTGQI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-hQIDRZlOPgmzaWOdFEmMHQ-1; Mon, 15 Sep 2025 12:03:26 -0400
X-MC-Unique: hQIDRZlOPgmzaWOdFEmMHQ-1
X-Mimecast-MFC-AGG-ID: hQIDRZlOPgmzaWOdFEmMHQ_1757952206
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b0ccfdab405so231708966b.2
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952205; x=1758557005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMxsZvyoTV3G/hm1yNnpqqa9WqA68QAPsx4b+ZiU9Ys=;
        b=cziFY/T3HohPwTbH7AYhKpJiqItItCgqha7F0+EH+VOHtUTW/qzLyK5RIqzZ29Hj7z
         mJ1qGDUtMLOKf+AW0aigzJ8aq3EZ6CJ3h/2KaYHfh7D2YhrG5J0SJvcKb/aQZ88Z/J/B
         skEiZVLJaGYw0dkT5nxGvgH9D/wFVdDL+bN2h7AjYlrPfJ7Il+fcFqdSnn/2zPRHSMhl
         XrLY+dRsRLNwKfecDvYVCpmmfW7LjjgKSf0HyUws+bq8lnI1tRKlndUt1uB7WqQiMNhP
         J/1G9ImeoG/tZATB34z5epHRNYYTn5eT2lm7+WowGNBQfV2rvdfEdWscT/jcZu+x77DJ
         r9PA==
X-Forwarded-Encrypted: i=1; AJvYcCX9akHvJtQNeO2PQYpUC8jU2ee322hcJjEw3gRtG2fmHohhy8kGKatokWzh1hoqicqFYQgoDo821SPyVpDA/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS6NjIrIZqcKglXOgsXm1eAdcebU1fuuQ9aUa425amrxDzcQJY
	D6m60IrK1Fwf/4kaLyPuzgCceD7rBtmZp05Qhfz9YCmM6tjTEZoiAeDS8YwMnpM6FMM0qwyw7kk
	REjBqXc0KcbMHcycpYMYlwoRyku/BnAsa7Ba2VoJRzVh1qo191001YfPHITP8HmtJElNB
X-Gm-Gg: ASbGncsxUWJ0eSh4dwKWnOQFKcZwESHywnDEK4CX1vz8WZmEIUeS27hxx5p0/fiKcwS
	BKNuqm34QK/B1iekZVSLGpz5TReIzheSB51G6D4dUVdfwNxsJn3mFRu4HzLKFbZGpKsPzcoKSiG
	GfK38zC5URW/dqj4p+lt7eeA5Q3/ESpIoClIYbrlQ2MUCGxbnxLOvvGyLYJqvc/B6JZ0IaA/+OW
	N2cuTZy4LDskG2xXURDqlD0ib8oEVvKVvoEI72CjPNV6/z4S1bYLXAvVvz9j1mc5dIjRgOC2dv2
	XGTilrBaSHf10RFyO1qdcHrSC6A4
X-Received: by 2002:a17:907:9408:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b07c3867766mr1173786266b.44.1757952205425;
        Mon, 15 Sep 2025 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMAUdK5dLnmNqeaAzIQ4sLNIVdJ/bLJv6BqI8ieVrFaCmiktbN+iyKUpr58pZivx2Iqu/CNg==
X-Received: by 2002:a17:907:9408:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b07c3867766mr1173783066b.44.1757952204919;
        Mon, 15 Sep 2025 09:03:24 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b2e7a35dsm1001013466b.0.2025.09.15.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, stable@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jonah Palmer <jonah.palmer@oracle.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/3] vhost-net: unbreak busy polling
Message-ID: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
References: <cover.1757951612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1757951612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C51wsWV-BJgYt03r3M5MMbCXBMW-lJk1fFPYXirN_To_1757952206
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Jason Wang <jasowang@redhat.com>

Commit 67a873df0c41 ("vhost: basic in order support") pass the number
of used elem to vhost_net_rx_peek_head_len() to make sure it can
signal the used correctly before trying to do busy polling. But it
forgets to clear the count, this would cause the count run out of sync
with handle_rx() and break the busy polling.

Fixing this by passing the pointer of the count and clearing it after
the signaling the used.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 67a873df0c41 ("vhost: basic in order support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20250915024703.2206-1-jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6508fe0d5c8..16e39f3ab956 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 }
 
 static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
-				      bool *busyloop_intr, unsigned int count)
+				      bool *busyloop_intr, unsigned int *count)
 {
 	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
 	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
@@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && rvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_net_signal_used(rnvq, count);
+		vhost_net_signal_used(rnvq, *count);
+		*count = 0;
 		/* Both tx vq and rx socket were polled here */
 		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
 
@@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
-						      &busyloop_intr, count);
+						      &busyloop_intr, &count);
 		if (!sock_len)
 			break;
 		sock_len += sock_hlen;
-- 
MST

