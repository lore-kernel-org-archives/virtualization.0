Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792477859;
	b=CRW3QFh12UX5AayxwYDoWvzzcsOfuTzPz48kWZ58tBU0myQqevWjrKwPhjNxTFGTjmZi
	 xa2TuSmbG14h7CpNTXOkwAl8ph4fftGtWJOfFD6bCeugNeibNZQ5ZbeJSddn84DQDfJJz
	 bZFTNp5wh9UqDR4PTG+pN4oiknx7GuoHolf/qHHoROLfPRRDoBkyE9SZqZY8ZPIhxRrts
	 2P38zn5spaAmMVFpPkG3xyy/ssaf6mFJvmFoVCKOeuFHMw+YV7McLJ0GS8f4Olts7fKA5
	 ZwjapzmwAezTpIDD/ccP5ujU8UUNQqhlxyLwDt6zKBT8J4DScnGUfHyaq15pj00/LJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477859;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
	b=bfgMZjoUmpDe9wzjODICQX+MR+YmFKBqrrUuLWGa8lc95xRpxkWefZzFFthl6m/geQlz
	 jWLqKLki8d1GcZUztabOUJTE1DBHpi2D6Nn1vNDlpTvWoeMgGNsTtF4JHMVH/2Rg7nwPV
	 wR/E7nr4JS7V7NSOBa4pQVLxJOOdblMp45ykO9b1st2I0OEY5gU/w4XHkvJvkRTUn85Ag
	 DCnyCJgO/kdB2TdwYHutqtC/bTO4Q/9V0gThKFzMgroEza2xZjJFUD+O5p6b9TttYkyoE
	 Titzcx81KmVCk/UfVVuKLJ2FgpWQvp9aQs0XaG32s9d2QoQz9VAoCiCwHVaaAFa0Png==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhI7KWPz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C2606A31C
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 06:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhI7KWPz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792477857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
	b=XhI7KWPzn3rZCb7U5nGPq24YgfwALBIyc3VjY/9o3Mm3jgozhVCI5xokUixdbPffByC2gL
	/5gUIDNi716A22//Id5uGaIw1u+tZ4RtIQK70eLW5UtwOy6UpMT9mZaA8pvK4PyOYI8t7z
	zPyJ9AJ5JNxujgBKvdCm8SEqJAtFdBA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-F6JE4_0oNp2bAkxKM5LgjA-1; Tue, 20 Oct 2026 06:30:56 +0000
X-MC-Unique: F6JE4_0oNp2bAkxKM5LgjA-1
X-Mimecast-MFC-AGG-ID: F6JE4_0oNp2bAkxKM5LgjA_1792477855
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af5a07314so1844482f8f.2
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 23:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792477855; x=1793082655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
        b=ZgtH3VgbLSM34nDuZQDeta2m8NCgxMReE+ptG0i+7vHSCHM8woNAdZE7DPnfKg6KTP
         P4zc1JMe+jLLcq8pwG3QIINx9Gnsn3txLEtnvOBVNLyUmDQS6Ae6/irT8lawCsspyPpM
         +ou8arq+9+uC7T5xaPNNwCrLNTLy86MpoA5hfJWAVRqY5FeDAMUD9Wg8IrCZqxKK7RZZ
         f0JztaMA34oy5r+0LvETQIP9iLZBsw/z7ncgChzVWbd0pA4hq7uTk5HXbjyUy1Tyg5ZY
         CS3qmTchFRFnpBIR6nHCadONLSnn4bHz/9Jlo3KMOlxsyxTIHM/ddu73GIm03Au5YfA/
         dfLQ==
X-Forwarded-Encrypted: i=1; AKwUvBykMljbQAOmCxUTRvNzQ+VXI031i6YpViqnxjDDw/1+WU2vggkUNkP937sr9SQB/ysQWo4OM6RgFZBSC3beWw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJBoI/UXgTTi/GB7+PspFT4e3pw5C2hDkHF31Ji02MwCec9dUzh
	sxPjAqSoz4lQwsGq/bDDw1FNBNowLg0gaFfq8kV3n4krxtLucbVm0GUvX5hRrUReLPp1GmKTiJb
	Hz7Y3X0guHQk1Q/9tWEg4Z8h5F9GMD4MU5vUopCUvQ9Ajlbh4IuDUMAUyKK29CwKVvqDw
X-Gm-Gg: AYBFou3rxhI9xlJ1HJeLhfBDg84rdOTUtQyqygLlIU8Z7rG03YjLsLTVx5h76YwBOz7
	ueauTU6QfVoTRkwPe1AzmMX2mKXUwHAoR+zf5VlNuVxZ3xUMAL45xYg94tszLRhlG2WKfjtEPBl
	8Hg4acuPAzM4daPL7MRpO8XnxcP4We/DOcF9mB19aQTWWZv0rHritFalysH1KqRxq50jMFbZK1A
	1BRpf1+EGEFJ18GoRsUgXp9PG3/RtyAF2IsAXWI6YieLgxmnHmwYN1UmOq1fY6QIiW/ZIq3S1Wb
	qEkXAkwBer9HdyFOOEwlPEC+Wz2dMHyVCr5WRekk2c1Wrs/5nR4g2gA85jtBR29Q4CpZOQ==
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e07978bfcmr21309159f8f.7.1792477854578;
        Mon, 19 Oct 2026 23:30:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e07978bfcmr21309119f8f.7.1792477854028;
        Mon, 19 Oct 2026 23:30:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214e1sm3912561f8f.37.2026.10.19.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:30:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 02:30:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: torvalds@linuxfoundation.org, jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020021924-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fkc2y4W1KQYmn6Wjh71g8ObVHte7tfylv9-lol4nfXM_1792477855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> Eugenio previously offered some additional suggestions in reply to
> my patch email. Should these also be addressed?

The following seems to work for me. Testing would be appreciated.

From: Michael S. Tsirkin <mst@redhat.com>
Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path

getu16_iotlb()/putu16_iotlb() pass the address produced by
iotlb_translate() straight to __get_user()/__put_user(),
without access_ok checked anywhere. Not good.

Switch to get_user()/put_user(), which are always
correct, and safer.

But the fact is that accessing user memory like this
will sometimes (rarely) race with page being swapped
out, trigger EFAULT, and it should be retried
from a worker, and vdpa_sim currently does not do this.

Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Notes (changelog):
v1->v2:
    Use get_user()/put_user() wrapped in pagefault_disable() instead of
    access_ok() followed by __get_user()/__put_user(); the helpers are
    reached from BH-disabled sections, and __get_user() is not a valid
    way around that (David Laight, Linus Torvalds)

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
 drivers/vhost/vringh.c               | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 76dd5b0828d7..325ec8f0ab85 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 			smp_wmb();
 
 			local_bh_disable();
+			pagefault_disable();
 			if (vringh_need_notify_iotlb(&vq->vring) > 0)
 				vringh_notify(&vq->vring);
+			pagefault_enable();
 			local_bh_enable();
 
 			if (++reqs > 4) {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index a6514b5ccd86..964cdf422467 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
 	smp_wmb();
 
 	local_bh_disable();
+	pagefault_disable();
 	if (vringh_need_notify_iotlb(&vq->vring) > 0)
 		vringh_notify(&vq->vring);
+	pagefault_enable();
 	local_bh_enable();
 }
 
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..74836eb60c7a 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 		return ret;

 	if (vrh->use_va) {
-		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		ret = get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
 		if (ret)
 			return ret;
 	} else {
@@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	tmp = cpu_to_vringh16(vrh, val);

 	if (vrh->use_va) {
-		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		ret = put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
 		if (ret)
 			return ret;
 	} else {

