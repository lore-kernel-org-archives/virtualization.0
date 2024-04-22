Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E61509B9
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795655; cv=none; b=oc70umGHr1a9uTaTqaBKudDLTEEKR05s4ofDzilEnJnvTavY0IzJO5Y4jagjNYRe5uLt6XmQWP3aHRI06B2spXkxSGXwhAEeNqTksEkh4wO3y1OH/eNIh2VaVVHhGnPRSj9aNESA5Ba2M5Wohyh2k4j9UOGsIIPzYxY4l1m6eCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795655; c=relaxed/simple;
	bh=/kXm2iITa7mixbm/BI6s4K3kvavVlcOxT5iq3POX+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CEbQGbB78DcA1GXrgw0ojIhgX1ICMZKEOehqC2JQrokjZyqMW9OIe7T3I9NdWMj8aDfAumDcq23Zjv/oGnPlIJbsQ4dYFdVOdN0Dk8OrVuaF7g14IcuZSs9NFFgHBCWoyeGfHzJn9CRI/HfJAVmQsyfd7k/x7riFaB4xC652NZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvIbJIEN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvIbJIEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713795653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6+FiyOvOBZ7UuUE5Up8WqG0I1zHgf4s1LLzpA3im1U=;
	b=fvIbJIENdn/FdOpJjYdxQsHpx9vST9BhneujySDbwOk1VFaIc8UFNU+mZkJ0AMBjq8349d
	SlcfnQ/vbSqlBG7/GbwTqpp0+o47GSVMDGcD+8lJP4lBKVWt25xyWG546dtLEz9mfeyg+R
	a7G26TPYadbPVi5zKVJnZ2Q5P/EPf0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-HADbWjtQMdSxG0JymGRKqQ-1; Mon, 22 Apr 2024 10:20:50 -0400
X-MC-Unique: HADbWjtQMdSxG0JymGRKqQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so2845562f8f.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795649; x=1714400449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6+FiyOvOBZ7UuUE5Up8WqG0I1zHgf4s1LLzpA3im1U=;
        b=b8OGy0OXYvs1lx1NbrgJvAKxlzbMXXsi+wDahfq/4PirPSEpfc4/wZAA4nDkdAmMeb
         PWZnas9ktZqLibNozirSjq+OwFWXHgaBRKxjg7dRTMOqedobDB5GT5V/usIxNuGsuyZk
         Zn+7TyTLGrDC1fHlGBtypUCudZs0wY17JTOEdsXI9pRLN6r+bSAVx18lp10uZeUjAVAZ
         Bzb1gkVcc4OfhGlMqAvFSpJICJlvtD1qS3RSHD3SdNdUzQYezPQuKkeo0qC6wdn2KD70
         Gw0LyP0rIIDtnlhqVh7LZSD5vvK5qgxSoAgFfNw06qGxtCrr07Hbyv29igR3fjtEAYZm
         2GcA==
X-Forwarded-Encrypted: i=1; AJvYcCUTdsEzz052XWr18YSs3kGbGxzI70libYvyaLX4cH+1M6RPmtHMAdHJ6rp1EI3UlYC53KIoPohL0OT0M3t4sojFshlj+pNhFKoVfHFvhhc=
X-Gm-Message-State: AOJu0YxeuMGs74fzRdtoGglQlvKJet1WhkjnlRHEIujLP9bSwztw+8XT
	ZXf2msoq043/xxCQC3SrpiJg0aQDe19XboIVupA9fELFSAnF4T+KxuLserm+9ac2tYG/fVcOUfu
	i0e3BgjzfAaC58s97hq97N72SgY4fJi2QdEUEnZ4TjwsVIpRpsLY02q8WGtmMjAyd
X-Received: by 2002:a5d:63cf:0:b0:343:eb6c:ae80 with SMTP id c15-20020a5d63cf000000b00343eb6cae80mr6747961wrw.28.1713795649153;
        Mon, 22 Apr 2024 07:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbTr9mNnSCZAdnGEG64hBhgMW1R+/LrCJEgrrihxGXhKjlIV3VfLADvpLX4fg/B6JyXt4zGg==
X-Received: by 2002:a5d:63cf:0:b0:343:eb6c:ae80 with SMTP id c15-20020a5d63cf000000b00343eb6cae80mr6747923wrw.28.1713795648480;
        Mon, 22 Apr 2024 07:20:48 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d5612000000b0034a62e51429sm9041921wrv.112.2024.04.22.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:20:48 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:20:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jeongjun Park <aha310510@gmail.com>, jasowang@redhat.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgarzare@redhat.com,
	syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH virt] virt: fix uninit-value in vhost_vsock_dev_open
Message-ID: <20240422100010-mutt-send-email-mst@kernel.org>
References: <20240420060450-mutt-send-email-mst@kernel.org>
 <20240421030606.80385-1-aha310510@gmail.com>
 <20240422130031.GA77895@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240422130031.GA77895@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 22, 2024 at 09:00:31AM -0400, Stefan Hajnoczi wrote:
> On Sun, Apr 21, 2024 at 12:06:06PM +0900, Jeongjun Park wrote:
> > static bool vhost_transport_seqpacket_allow(u32 remote_cid)
> > {
> > ....
> > 	vsock = vhost_vsock_get(remote_cid);
> > 
> > 	if (vsock)
> > 		seqpacket_allow = vsock->seqpacket_allow;
> > ....
> > }
> > 
> > I think this is due to reading a previously created uninitialized 
> > vsock->seqpacket_allow inside vhost_transport_seqpacket_allow(), 
> > which is executed by the function pointer present in the if statement.
> 
> CCing Arseny, author of commit ced7b713711f ("vhost/vsock: support
> SEQPACKET for transport").
> 
> Looks like a genuine bug in the commit. vhost_vsock_set_features() sets
> seqpacket_allow to true when the feature is negotiated. The assumption
> is that the field defaults to false.
> 
> The rest of the vhost_vsock.ko code is written to initialize the
> vhost_vsock fields, so you could argue seqpacket_allow should just be
> explicitly initialized to false.
> 
> However, eliminating this class of errors by zeroing seems reasonable in
> this code path. vhost_vsock_dev_open() is not performance-critical.
> 
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>



But now that it's explained, the bugfix as proposed is incomplete:
userspace can set features twice and the second time will leak
old VIRTIO_VSOCK_F_SEQPACKET bit value.

And I am pretty sure the Fixes tag is wrong.

So I wrote this, but I actually don't have a set for
seqpacket to test this. Arseny could you help test maybe?
Thanks!


commit bcc17a060d93b198d8a17a9b87b593f41337ee28
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Mon Apr 22 10:03:13 2024 -0400

vhost/vsock: always initialize seqpacket_allow

There are two issues around seqpacket_allow:
1. seqpacket_allow is not initialized when socket is
created. Thus if features are never set, it will be
read uninitialized.
2. if VIRTIO_VSOCK_F_SEQPACKET is set and then cleared,
then seqpacket_allow will not be cleared appropriately
(existing apps I know about don't usually do this but
it's legal and there's no way to be sure no one relies
on this).

To fix:
    - initialize seqpacket_allow after allocation
    - set it unconditionally in set_features

Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: ced7b713711f ("vhost/vsock: support SEQPACKET for transport").
Cc: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..bf664ec9341b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -667,6 +667,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
+	vsock->seqpacket_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -810,8 +811,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 			goto err;
 	}
 
-	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
+	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

