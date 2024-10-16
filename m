Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225320E027
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099640; cv=none; b=Bk6XF/+qUlKUO6SH0+SQslRavjt64zq4tvogs3BztUiiyq4dx3LcDjWkBYxnc4DvOX3Xq4CguhMyyOr/DG8/bLxwnmX2/IaHGPLKq+3Z5KXQeGuhKDproLqIMZCeQ0LOGZDZeU03+NKz9fOWeHQwtDKSh6cLu0DmQ0jVJur1jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099640; c=relaxed/simple;
	bh=fzLmjTYv50o4SO1uhihHDhxEFGjJN+CktGLAz3N15Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fHt3ZrWnNRW/BHQJz8YvHbazC7sHq8+1dDrKyIuQou2xXDoVbuY/gmnMcZsgOsQVbXoaPnTyKd2XVQ4Z6XY6xEB9ICXksfWF8ZrqCPi03HAtgpjbkV35BlM1o7FSHcVtLo8uvc6fup8T99sWF1AhMn1JtiH3ukSY34a53Gy1zIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4w0ooKv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4w0ooKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729099635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mm9TWMoNEKmC5/H75qa50GgVA8uFrq/T9r2miRc0UHg=;
	b=L4w0ooKvrJV5AwcbpVN2baAVa3XLMBAbzcbJJQQMhhspVxKhd5cTtuGugFXigS8c6RrPwT
	QUQXSEXXokpkMOr6vXyAAgO24hoJSlx91ZIJWWfEg6vTsj061InVJdWSo1qa5VBy87riBy
	ADFXaF+V9nPdB4eA57iRFWMsauS1g8M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-YwKH7gZ7OGer_GoD_H0PaA-1; Wed, 16 Oct 2024 13:27:14 -0400
X-MC-Unique: YwKH7gZ7OGer_GoD_H0PaA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so3207946f8f.3
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 10:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099633; x=1729704433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mm9TWMoNEKmC5/H75qa50GgVA8uFrq/T9r2miRc0UHg=;
        b=w3gw18Wup5gGzkYs6E6gvOzi+gDM7zBnPMyM9PMCyQhokj8w4F+5prrFTB7qe++rsT
         tOdu5pkFm6jZBrtKsrIhP0fbNIxwNecV9k3qum/QSBYUZNxnYbx5N5Ub6zjQ3Hsw58jo
         3u4CG7ZU7TXC0gBUsJBWy0zWB0zxlt5upD1SXV0qklx6TCmgdtsqQR/mTpXHd9PFsKjU
         X54sHJJCzfa+rlnqSyrDOHDlOZ+vhwcYyiAKU5xPQBc794zUyHsLkqj9vND67+SRDwLz
         5vrpndEUsqRvecFNJqKqC4PcsQ//ritgkJD8gCFfCFgaqTOhLxPzNmXhgVQ/krZj+bei
         zJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgQ3cnZsIjuayvv5AF9UQiY9Fod5su7wFjYOMdZfMD8kSfYKMSozR689xREddvaQXH8xtgukrdQMJpdMgEUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBpDdMxAWToEukO4vaYjgrP0D3WUS6nMErL0J2k3S89y74UTFD
	OpHfeMcrnBYORvPqzEbt9ziHUISctQ/ToYvVKz8RJTq+qcQ6AEPDtpwLhtz3uJu7YogOtzHofTB
	7K8CnF510FY0rN70If3YSUuwtsXhp4HaABZRm37WiZmVImuLTMaPH1+z4OzjgD252
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr12804138f8f.26.1729099633372;
        Wed, 16 Oct 2024 10:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2kqVFlb2DtsXVfaMvtF8YMmP+fSHaEOFSLeUgaj7tCoSNI0g7YeZxeafsJNPE7r4ODqUXg==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr12804117f8f.26.1729099632938;
        Wed, 16 Oct 2024 10:27:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:b9f1:592:644a:6aa0:615c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4832875f8f.113.2024.10.16.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:27:12 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:27:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Colin King (gmail)" <colin.i.king@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: fix integer overflow in stats
Message-ID: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Static analysis on linux-next has detected the following issue
in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :

        if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
                queue_type = VIRTNET_Q_TYPE_CQ;
                ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
                ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
                ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
        }

ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:

include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL << 32)

..and hence the bit-wise or operation won't set any bits in ctx->bitmap
because 1ULL < 32 is too wide for a u32.

In fact, the field is read into a u64:

       u64 offset, bitmap;
....
       bitmap = ctx->bitmap[queue_type];

so to fix, it is enough to make bitmap an array of u64.

Fixes: 941168f8b40e5 ("virtio_net: support device stats")
Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..b950d24b1ffa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4112,7 +4112,7 @@ struct virtnet_stats_ctx {
 	u32 desc_num[3];
 
 	/* The actual supported stat types. */
-	u32 bitmap[3];
+	u64 bitmap[3];
 
 	/* Used to calculate the reply buffer size. */
 	u32 size[3];
-- 
MST

