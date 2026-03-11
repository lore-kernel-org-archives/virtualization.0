Received: from out30-71.freemail.mail.aliyun.com (out30-71.freemail.mail.aliyun.com [115.124.30.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8302F616B
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199211; cv=none; b=ZEVhXiIOlA1mCgQkKoOPiWF0Y8QA9N4WddtTknRL9Zh7QaqgjieYFIFBTv/Z1//jFdl/cbohmh1iWRaolLRZrkWmcrM/dSFUFFLxvcMpgBI1fZNzdJJsriAcSGLo+EpHWvL869Mb/fMVxFp8b2/kL97B+AEiuk3rsEBsAWJYwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199211; c=relaxed/simple;
	bh=nb/Yf3FNbqaQwk/mdsPKERX8YO4lqQotDGHFGRd+LQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXH5iNh3vbk0P+oPY/hoavs+E4QDJRr293qFU0vRWFT9pCEzVU6kSrcA3mcE/qNo1RYkvKeN2Igwxj+6gJVeaVZqXSEhca16QITTtsEdrQVUqdsxGNmn0mNvAgy1l7qaykucyZkJyZHgdYPAt2TZfygMyquUhHZ33uFsljc8new=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=u39a1NKG; arc=none smtp.client-ip=115.124.30.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="u39a1NKG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1773199207; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=EfJ5n2c9DbB4LYKvdv51Z+iKfoqFlsFVqspAs7le1d0=;
	b=u39a1NKGlmy4iKQyyHdmIbx1OB/UlteQGTmoznvKWaaYuAcE80dDZzEP2ys8V7Ub8vJTmG4wDggKAUFVnGLpiUjXvgMIP8skznq4iI+9htHbAhO+LzQdcS63v6TedHqW1cCyIfc0Bc4yeFf9mKJ2CTrf1QtRnHJz+9S7GghLrOQ=
Received: from wdhh66@aliyun.com(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X-iG1N-_1773199201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Mar 2026 11:20:06 +0800
Date: Wed, 11 Mar 2026 11:20:01 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtio_ring: Fix data races in
 virtqueue_enable_cb_delayed_split()
Message-ID: <abDfYT4OFzvxrUzL@wdhh66@aliyun.com>
References: <20260306022448.216131-1-wdhh6@aliyun.com>
 <20260306045629-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306045629-mutt-send-email-mst@kernel.org>

On Fri, Mar 06, 2026 at 05:04:11AM -0500, Michael S. Tsirkin wrote:
> here's how I would put it:
> 
> KCSAN reports .....
> this is because ....
> 
> 
> This is not a real issue, because ....
> To disable the KCSAN warning, use READ_ONCE to read vq->split.vring.used->idx.
> 
> 
> 
> 
> On Fri, Mar 06, 2026 at 10:24:48AM +0800, Chaohai Chen wrote:
> > Add READ_ONCE when fetching vq->split.vring.used->idx
> > without synchronization.
> 
> it's with synchronization, of course
> 
> > KCSAN detected
> 
> detected -> incorrectly reported
> 
> > data races when accessing the split virtqueue's
> > used ring, which is shared memory concurrently accessed by both the CPU
> > and the virtio device (hypervisor).
> > 
> > Example KCSAN report:
> > 
> > [  109.277250] ==================================================================
> > [  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split+0x10f/0x170
> > 
> > [  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of 2 bytes by interrupt on cpu 1:
> > [  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
> > [  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
> > [  109.318852]  start_xmit+0x315/0x860 [virtio_net]
> > [  109.324532]  dev_hard_start_xmit+0x85/0x380
> > [  109.329993]  sch_direct_xmit+0xd3/0x680
> > [  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
> > [  109.340568]  __dev_queue_xmit+0x560/0xe00
> > [  109.345701]  ip_finish_output2+0x49a/0x9b0
> > [  109.350743]  __ip_finish_output+0x131/0x250
> > [  109.355789]  ip_finish_output+0x28/0x180
> > [  109.360712]  ip_output+0xa0/0x1c0
> > [  109.365479]  __ip_queue_xmit+0x68d/0x9e0
> > [  109.370156]  ip_queue_xmit+0x33/0x40
> > [  109.374783]  __tcp_transmit_skb+0x1703/0x1970
> > [  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
> > ...
> > [  109.499585]  do_idle+0x7a/0xe0
> > [  109.502979]  cpu_startup_entry+0x25/0x30
> > [  109.506481]  start_secondary+0x116/0x150
> > [  109.509930]  common_startup_64+0x13e/0x141
> > 
> > [  109.516626] value changed: 0x0029 -> 0x002a
> > ================================================================================
> > 
> > Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
> 
> 
> 
> I'd like to see code size before/after compared, and included in
> the log. Does this make the compiler's work much harder?
> 
I found the code size is the same. And virtio_store_mb() can do sync.
Perhaps we don't need to modify the code here, but rather fix KCSAN.
