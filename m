Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A52EAD15
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217088; cv=none; b=c+Z8TNlB6sV44hBAHOAEnQzSgWm2ReGYx2fbvzdReC5l8Tm59RIdwtZ5K3ZuQBZrkR0kdobxejyzSLY4nyHQiQq0uFInDWr8wz+2Il+ZCseVlNh+wOTHUItK8vJCFaHSXdaTFGnR7Oa0bHCKNXx2fMn/DTQ3m+x/Pepl4iiC83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217088; c=relaxed/simple;
	bh=Pqhe1/gUDvPffZ3kxx5/azyvzD1TsrTgTISNWYyFtgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LTFfNtQYlcC2y8fSPVTxZ8K4DEHtHCN19xbYXW0zpXSg2cDpiX9uveiiK3n/Gj51V1JZnNc7vEngNTJzzvv6aBGEEDsTUiMCzNDPJ0j2Qqr/l2IqhKJd3DMQKTpltuyeYAoqUQzYQEAGMJHaZRhDoQNz27nZ9QYbBgsUFM8FMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4NbgwUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4NbgwUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787217086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
	b=D4NbgwUUs/pXKuIFSlZ5dG+KCqAHk1OvNz3vw/TtUZN6KJk47b1H15C6NoApb1eW1eBEni
	sXCxSDSCOVyLAHVnGYIFCD9NxiovqvGpcxgwm4T1aYcX/Yd/EoJmPrDsVkmxVcWUpTthtO
	piqD+wGfL8TovAVWuvgNRqXvBtGoJUA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-5tUKZaYPNlS_iZt5myMPtw-1; Thu, 20 Aug 2026 05:11:24 -0400
X-MC-Unique: 5tUKZaYPNlS_iZt5myMPtw-1
X-Mimecast-MFC-AGG-ID: 5tUKZaYPNlS_iZt5myMPtw_1787217083
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso1802308f8f.0
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 02:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217083; x=1787821883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3/buro2KkWnv5c3F843d2AiVyWVMTzzCYjAgiddcY8=;
        b=D1Os3VyDJgg8g1Qu/5g8xvAByb33w2eVj6LlhnkEptbPakepK1QBC9v28fffQg3MqI
         sKNivbjEq8IWX9kILKHvYNqgVBKzBUIV18xwDiuX2Agk6YVP5ts2jYy+gFZ1NBA8mbxn
         GH6YZqBgtEv7C++vpNDgLX984QgzPUXlWZ9Ma7p9H6R7Q9oNEAem5WmoRvAGK5Jf5k0H
         X7fHN0XRNM/tgbrA7DwDCaSIcoAfe5cNDS6NYk6O3iT9rndGgv7rUZrYvMZcLPrGeens
         NGMqvEzwWzAIcAlcgW5n0t93aWHnK3EhOANb+szME4JAzb99yznBKXAdh6L2N2afPuW/
         sAhw==
X-Forwarded-Encrypted: i=1; AHgh+RreXWSadW/8jjcFYJgsuhKIlDWQS2+fxUEoWsb99uFIIiAldNUSj9s51Tm8Y29O7s7+uZ3ORy3cJMpUWqWBIg==@lists.linux.dev
X-Gm-Message-State: AFuF++mrP6iHNv/39eyxdoccXy+Jd6l2GJgO8QXw9W4w18nhZs3ZMp66
	Hl8JTiAPGH3aWEbTAWg/aD95JtkF1HlSBewBb2icTju4rfYUmkbuDwut4s09echdLrE+HkYch2w
	btb9g2oUqFGYPVgU4lT/UT5fUPERmDRUQYaP7U1Sge81WvxkaR2ms8CwC3L+SwZxz1Vb7w3ze9R
	WE
X-Gm-Gg: AR+sD10RW40JVbxgpi9hxj9qRHtRrjXJy7cNwInCbdjZmrkO+CWCFXHD9ikbPAd0uSP
	r+oX4DZ5xNdItrGqjy70YhXDFkCODjBvTW47OaU9YvpyqrRCR7B+5HEiMUA+0hKZgnMBwmQA0Bh
	8KS6Sly94qgc5JrAvR7gUffrpd9y8O4m3G5BXl+Q4n6RMdmtxcODO9FUPy7/8OHtogK594jjdoH
	+YKqYxK5wYq/zy+WjdTtvpbqZzdotEd7bbnKVFpMF5JwWxtKONuxF1RDUOvkIhn3M80TbI3Fcrs
	jebwft292agDQgnR7jfzeQC6IkdXtKIajeG18Ms40T4/wvFPb5Zm6wHTUX8bS5u4J0i1MEi+jST
	g9+TOecxnADVVckbr4+3t1GEX00LtEczWngt0s/nq6v/YiZ69II7R
X-Received: by 2002:a05:6000:310f:b0:480:ca53:280f with SMTP id ffacd0b85a97d-482b1e844cfmr18067511f8f.2.1787217083016;
        Thu, 20 Aug 2026 02:11:23 -0700 (PDT)
X-Received: by 2002:a05:6000:310f:b0:480:ca53:280f with SMTP id ffacd0b85a97d-482b1e844cfmr18067399f8f.2.1787217082530;
        Thu, 20 Aug 2026 02:11:22 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8038sm10520293f8f.20.2026.08.20.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:11:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:11:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB
 transitions
Message-ID: <aobCds-JDgs3BiSp@sgarzare-redhat>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260820080332.313933-2-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gwt7CyO-eRNuL8YMXQB__OKzosC-S5ixILjeBcYPb24_1787217083
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 20, 2026 at 04:03:30PM +0800, Jia Jia wrote:
>When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
>used change meaning with the address space. Clear the cached vring access
>state when the device IOTLB is installed or removed so stale IOVAs cannot
>be reused as direct userspace addresses.
>
>Keep device IOTLB initialization idempotent and apply the mode change even
>when a virtqueue backend is attached. Drop the device-wide IOTLB first,
>then clear each VQ state under its own mutex, and keep the old table alive
>until every VQ has completed the handoff.
>
>A successful live mode change leaves the backend attached but invalidates
>the cached vring addresses. Userspace must configure the vring addresses
>for the new address mode before data processing can resume.
>
>Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 53 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 14637cff0bd4..31fff9800045 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
> 		vq->meta_iotlb[j] = NULL;
> }
>
>+/* Caller must hold the virtqueue mutex. */
>+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
>+{
>+	vq->desc = NULL;
>+	vq->avail = NULL;
>+	vq->used = NULL;
>+	vq->log_used = false;
>+	vq->log_addr = -1ull;
>+	__vhost_vq_meta_reset(vq);
>+}
>+
> static void vhost_vq_meta_reset(struct vhost_dev *d)
> {
> 	int i;
>@@ -1918,6 +1929,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
> {
> 	unsigned int num = vq->num;
>
>+	if (!vq->desc || !vq->avail || !vq->used)
>+		return 0;
>+
> 	if (!vq->iotlb)
> 		return 1;
>
>@@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
>+/* Caller must hold the device mutex. */
>+void vhost_clear_device_iotlb(struct vhost_dev *d)

Is this the right patch where introduce this function?

IMO should be introduced when we use it.

About that I'm not sure if it is better to squash the other 2 patches 
with this one, otherwise will be this bisectable?
I mean with just this patch applied (and without the other 2) who is 
going to free the old iotlb?

>+{
>+	struct vhost_iotlb *iotlb;
>+	int i;
>+
>+	iotlb = d->iotlb;
>+	if (!iotlb)
>+		return;
>+
>+	/*
>+	 * Drop the device-wide view first.  Each VQ then drops its
>+	 * per-VQ view and its cached ring access under its own mutex.
>+	 * Keep the old table alive until every VQ has completed this
>+	 * handoff, since a worker may still be using it while waiting
>+	 * for its VQ mutex.
>+	 */
>+	d->iotlb = NULL;
>+
>+	for (i = 0; i < d->nvqs; ++i) {
>+		struct vhost_virtqueue *vq = d->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vq->iotlb = NULL;
>+		vhost_vq_invalidate_access(vq);
>+		mutex_unlock(&vq->mutex);
>+	}
>+
>+	vhost_clear_msg(d);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
>+}
>+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
>+
> int vhost_init_device_iotlb(struct vhost_dev *d)
> {
> 	struct vhost_iotlb *niotlb, *oiotlb;
> 	int i;
>
>+	if (d->iotlb)
>+		return 0;
>+

IIUC after this patch `oiotlb` is always NULL, can we remove it?

Thanks,
Stefano

> 	if (max_iotlb_entries <= 0)
> 		return -EINVAL;
>
>@@ -2307,7 +2358,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
>
> 		mutex_lock(&vq->mutex);
> 		vq->iotlb = niotlb;
>-		__vhost_vq_meta_reset(vq);
>+		vhost_vq_invalidate_access(vq);
> 		mutex_unlock(&vq->mutex);
> 	}
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0192ade6e749..3c75e8089373 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
> 			    int noblock);
> ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> 			     struct iov_iter *from);
>+void vhost_clear_device_iotlb(struct vhost_dev *d);
> int vhost_init_device_iotlb(struct vhost_dev *d);
>
> void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>-- 
>2.34.1
>

