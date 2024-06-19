Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9E58AB9
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785418; cv=none; b=kmYb/SAgrC9rseb1jgFYTIWFNCcmOqWoPYqzt3ydwJQL5MxKc36wJ9/SV3wpUssNctL+pU8RY70O8fMazs7Sb+7avU84YObP7jmHkjNtlRm5FldECDGF4BNfW69FSZGkRTvEjyPAFvvCmGchbly6px3WXd2WJyY6JsyS8knFqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785418; c=relaxed/simple;
	bh=1r2r1mo809XHPfX4nFBHYA2qqwgkRP6qRQkzKgL3468=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SqeKmoo6rw6HKJwEbvMsIeLuHq1dAc2kPN4sqe7vI1Dyf/ZdIRIQ4Xa07JVfc54YA5BM9kZq29/zGqGWi0T4otZykXcL6SMR4q6JLEZk+EHIJ+lKAvP6ncscsYznKTKSYOwcGrcKUAZCgRCO9zM4524eu6vO4OkbE+JBQS8mEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnRNtjmP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnRNtjmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mv+7UUQxiQBs1YPoD5zt8EOL8V4BVjDfcl2HJp8+ARY=;
	b=EnRNtjmPRoIqnj6lrcOyjyoqO1AmPZ11AD13RGtGgI99D1E7InSAb7gF9GzF/FJeypCP5c
	0wknxIMI8rBc9Cl1SbSEuxK86o1xxdYb2zj8CxkN4SJxS5VhnimtsKrW6Emj2SsZ6/os73
	gr/yUrMlWwjc3I8GHMvpNV3IgUnNK3I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-eOejxN5lOmG1ejUgSfEB9A-1; Wed, 19 Jun 2024 04:23:34 -0400
X-MC-Unique: eOejxN5lOmG1ejUgSfEB9A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec2c6af13aso22133191fa.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 01:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785412; x=1719390212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv+7UUQxiQBs1YPoD5zt8EOL8V4BVjDfcl2HJp8+ARY=;
        b=Z+zor707pf2WLyDeZJyxXPX6bYmJHuPqvWz4HQlSv2jOrc/2bamGwve9xFnmB0oUD6
         l8aqnbRpPeS20kQW94S9OfYEXwFg53lmWbwa+xcnxBUh+IY45iVCCS8vFr8ZKxdWbxo3
         KL2+XezacQjrQZpmlPDQSxWa39CrADZ7nQksBQQAtkMRWcP/Umk11yKkMEV517cd+621
         kQtvksJwyxg01UTjp0+ZQ86KmIeSM753CChYU7z2FC4PZeggQ8hYAtBCW8Is1a8iYSnW
         Z5eco22K+ymKbV7PbOPYqBJIMTTZdP7QXxT1DPlBDEMghDeScApBmXI6+BYc3a9i4lmI
         Yk9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7TlsSTsY1+7RcjfWuAHiWmL0Mxb/tuPiFAugUmGpZGD4IbyjvhTUxD5l3GEMu/9JdP2f1+FVMV+KP478GBNd59CwFDP7lCejz+j42d6E=
X-Gm-Message-State: AOJu0Ywj/d0PhrWuxG8V3CRPphOtefVViNk5XR3ORuK6gq1JTgdvq1cF
	2yiwDhNWXiCsaHgScz98VmMeGOI4LihdqH80ef/9nFkYVdkN11XkTytSHx5K4pNYfGeePveHB7m
	1/d6ps/FwtcboUxVDJM5/VPL0gdavj0E3WTDoEn4XoKQW5DVgYaL28M0pUrysmWAO
X-Received: by 2002:a2e:7d0a:0:b0:2ec:2a57:aee2 with SMTP id 38308e7fff4ca-2ec3cffe7b8mr13011011fa.52.1718785412562;
        Wed, 19 Jun 2024 01:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhobomt5nQneEV52RdktjcK4sr2LisHRIHFSb0MJ/6597zjHdM0Q2o7umWKIPsMzzOnHq9Og==
X-Received: by 2002:a2e:7d0a:0:b0:2ec:2a57:aee2 with SMTP id 38308e7fff4ca-2ec3cffe7b8mr13010391fa.52.1718785410630;
        Wed, 19 Jun 2024 01:23:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm257535715e9.7.2024.06.19.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:23:29 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:23:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240619041846-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
> >Oh. Right of course. Worth a comment maybe? Just to make sure
> >we remember not to call __free_old_xmit twice in a row
> >without reinitializing stats.
> >Or move the initialization into __free_old_xmit to make it
> >self-contained ..
> 
> Well, the initialization happens in the caller by {0}, Wouldn't
> memset in __free_old_xmit() add an extra overhead? IDK.


Well if I did the below the binary is a bit smaller.

If you have to respin you can include it.
If not I can submit separately.

----


virtio-net: cleanup __free_old_xmit

Two call sites of __free_old_xmit zero-initialize stats,
doing it inside __free_old_xmit seems to make compiler's
job a bit easier:

$ size /tmp/orig/virtio_net.o 
   text    data     bss     dec     hex filename
  65857    3892     100   69849   110d9 /tmp/orig/virtio_net.o
$ size /tmp/new/virtio_net.o 
   text    data     bss     dec     hex filename
  65760    3892     100   69752   11078 /tmp/new/virtio_net.o

Couldn't measure any performance impact, unsurprizingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 283b34d50296..c2ce8de340f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	unsigned int len;
 	void *ptr;
 
+	stats->bytes = stats->packets = 0;
+
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 
 	__free_old_xmit(sq, in_napi, &stats);
 
@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;

