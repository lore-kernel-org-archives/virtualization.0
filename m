Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784065;
	b=1U6+D2JLpcLnFd20l3kZsbrLWUy3Hd04c96pUIzNTL6zKY7UPKs6nHwBGC2ZnyQoLpdP
	 7QcSwx68vu5Qy4AO7qJYlSncdFLUV3YlGWA6Fgk+OEMGz2Y7BTAIfZYCo8Nt1e7y3l2pE
	 Ou1aQE1u6shjueWXCQ25/L8s5EOJ8d7wR60W6lQ0ST7OmNeUUP4PXtIVb9lAtGSimjZlp
	 xSo+qe3FaS6scyiDB1QNcgm3F0hwn1ZuYH2ob1w7oeNdj1srhXTzfA29sO2Zzbl8AKMM7
	 fQXfLKzgaaOmK0laAjoJP1M9vynbfuMpcYXb/WeYghkkjsA1zBgls4syiryo7iUnwhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784065;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=qSuk1jbsdV+iZEtNlLpPi3t1jVjwwjZENkNYPa18BIE=;
	b=fimCPhkafYcUDIdGVQYHxEAhISnA8mED2X0yOVsiAW5oTacLIF4BaDvGPplUuUF/8GN2
	 50YHw9GH5baV5+E1qwKdbBhhATtaaE05iBVGvC15XkLr6iNNV7PuHW6vKdxX/dffm8jqp
	 NXx9zxopTFEJApoWKWZ88oX2scFjA1UmEDC0TpyOghrNZDe87ODUynlC98h8RgUx/5XvU
	 h26FyW/cB+Bvz0f9d6T4VKMCp8ib43nHd1QPWzQGWjJ8FYuj2fUO8/V/S9UWE4aEY1Qoi
	 v6OCznABm3V88UsQrm4bWPjy9oi8/zK7PM+oPU3CjUjlAj4+F3chOsKtxP6OuvI1IzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZwaK02Gi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB8606A882
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 23:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56FB8606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZwaK02Gi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794784062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSuk1jbsdV+iZEtNlLpPi3t1jVjwwjZENkNYPa18BIE=;
	b=ZwaK02GiuylODvQ5bnPr2xb8/x1Q9YHXKnwy5iHl4pr8axLvyZB7lJGOQg4arxXo+kyvWv
	dd6wehp8HU9LQ7F0DxygCKIImxv46nBwi+ETDdl6oCL4GNJ/FIZiXDIOovb7eVLhUe6pNi
	ef4bP11lJYgIjpXvXu6JDbtxRzwA2aM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-sfUS_sjaOhCvHpJ6b6ojjQ-1; Sun, 15 Nov 2026 18:07:40 -0500
X-MC-Unique: sfUS_sjaOhCvHpJ6b6ojjQ-1
X-Mimecast-MFC-AGG-ID: sfUS_sjaOhCvHpJ6b6ojjQ_1794784059
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso23132585e9.2
        for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 15:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794784059; x=1795388859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSuk1jbsdV+iZEtNlLpPi3t1jVjwwjZENkNYPa18BIE=;
        b=ND0WXVH3uvHlc+yvv11GbXQ6lq/SsLZ/JOmaRHVJ7nBDzmv5F54KKb7R4V/bRIc87T
         UFFU+hAqck1hWVQP4FnuJug2eWP4rMKOZe1VhNXHrFyCB+Yzuh/wTmab8+T6xQ7eNYl5
         J4DK6/UXIrg+JV37cTOlLrhApQOXjUS5yucS4rUifYCV8dtWoV47yjBslTPRp6vr+rWx
         QNg53hOORT5oQy3sARyRPAIu7Pq2lyaviaQ7h0of9ybwsbP9eJgGZsXCJPI2DldZCSmN
         koxhZMiTJpYlyG46h3Bpsa9XKymm2XtICpjnZ81rDhS0q2Ilo6QbiGnuQP+pBofcYj6k
         ulpg==
X-Forwarded-Encrypted: i=1; AL+hErFwmQAhE4qCMIbbjWD8ZiiN/fvQy0UxxvJZvQeZpjHStlKUCcVg0HqPiJHei+Xj95lNSnWwSm71neLbQ13brA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8hx8W9+g8gBUUHbe8lql3p3s6i+FysPZmeXg8a206JlYARZCJ7
	Hag/e2BBdURWsm3X9Eu/VBJv2NCZrY2/1Mrxx7n2a1DZuF5SAc+8htTgjdsdwvVb7BpcrqsnLrO
	16q2fmumWahuYvxmkWPMzCc7Rd3MyWUdSPN2BpUitz2aOyo3AZ4SQ+P8ID99HA/GPHcYB
X-Gm-Gg: AYBFou1Ec4EelArKnStotCp8KUiDCefxj5c96WKvxt0RT0fjfpX3GVneubo84Ggx+P0
	nnZYVtpG+kguWOAkpTrIsZqk6xwPgL/rThRPhejKoRp3SGkSquUnxNOGU7QYfXFuMqAlxG/1HqD
	+3g/9ki/mH9/tefecT38Nycrxokyr2s0PBitEcniVWRzbSQHVuGLt7bUofVa+3/TYVHeZAO0FSA
	aQg3EaWbVkEnSeGy5uO0nwO/mLOoas/VLK4KSvD027Tvtd3KM5RbcldALRDC7gvIf+CbvdC6Sig
	HQsDA00Zc0PylSkEMxtYMA7r+g95ZZxa8yPRgL1wNGmKJAUmontqICZmpXSQhv0cAt+CJ1aoR3y
	kWeYKCsbU6vIGt53pJ2/0s/lHQc028Wz4LZGTbnblxA==
X-Received: by 2002:a05:600c:8b6c:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb649d4148mr97699765e9.28.1794784059307;
        Sun, 15 Nov 2026 15:07:39 -0800 (PST)
X-Received: by 2002:a05:600c:8b6c:b0:4a3:5a7b:6002 with SMTP id 5b1f17b1804b1-4bb649d4148mr97699295e9.28.1794784058388;
        Sun, 15 Nov 2026 15:07:38 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5b4a3fcdsm213451595e9.0.2026.11.15.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 15:07:37 -0800 (PST)
Date: Sun, 15 Nov 2026 18:07:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: netdev@vger.kernel.org, jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] virtio_net: RX stall caused by masking callbacks after
 NAPI ownership release
Message-ID: <20261115175445-mutt-send-email-mst@kernel.org>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vGbJ9VteZRf4ci5vCBr7cACSKRDJ_Gx5frSnLbb2HSM_1794784059
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2026 at 09:36:10PM +0800, Congjie Zhou wrote:
> Hello,
> 
> I observed a persistent virtio-net RX stall on Linux 6.18.58 during a
> multi-threaded TCP receive workload. After the stall, the RX virtqueue
> contained unconsumed used entries, but its NAPI instance had no owner,
> the NAPI timer was inactive and virtqueue notifications were disabled.
> The receiving TCP threads remained blocked waiting for data.


Played with it a bit since. I think the below should do it?
Can you confirm?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe7..7bc7306231521 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -740,6 +740,8 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 			return true;
 	} else {
 		virtqueue_disable_cb(vq);
+		if (!napi_is_deferred(napi) && !napi_is_scheduled(napi))
+			napi_schedule(napi);
 	}
 
 	return false;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442c4344b..2199750825d4f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -22,6 +22,7 @@
 #define _LINUX_NETDEVICE_H
 
 #include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
@@ -553,6 +554,21 @@ static inline bool napi_is_scheduled(struct napi_struct *n)
 	return test_bit(NAPI_STATE_SCHED, &n->state);
 }
 
+/**
+ * napi_is_deferred - test if the NAPI timer is armed and will schedule NAPI
+ * @n: NAPI context
+ *
+ * A true answer guarantees NAPI will be polled again without driver
+ * action.  A false answer is "best-effort": the timer can be armed
+ * right after the check.
+ *
+ * Return: True if timer is armed, False otherwise.
+ */
+static inline bool napi_is_deferred(struct napi_struct *n)
+{
+	return hrtimer_active(&n->timer);
+}
+
 bool napi_schedule_prep(struct napi_struct *n);
 
 /**

