Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068920E6E7
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438739; cv=none; b=GT6s4SOJ9AtNMDaU1PWPF5fZa5Cz6qLI1F//nbGx7UzpOWv/balYJqzS6dsWlKi0quEWmJv/TxkOaCYZB0dEA5jdbnOKvGYxRtsC6wVSkbON9r8hZk1FvGJDFEqJkxDHKw56qbXGJeeVH0ExI2ygB6hjt0Ol/5ZjbIGGZ/r3MK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438739; c=relaxed/simple;
	bh=kNZDvEJf3qJnJsEpcSDOQdrXDI+7ntqzAaEqCJM8JY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y7SZfi1tLU+7g4vEVkZWb9LYizXHxMYSQHgUoI5SO94a5qxzpLi9sNMVjTMbIjzitXVYb+KDkhypRSthNYjPk9yFhZGlj3W5D3yh/WAdygN49zmAr4LYp8Gb22Cs9nhcer0VVDt8BigHevQIfmQAuXtMuSc2YbyK6OFl3q1anBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpC+1cHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpC+1cHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739438736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gODipQT1RJ6DR0/GMvEisYcVEgWaoya2b4Hn/2vB8dw=;
	b=LpC+1cHI5sfW/ui/1tBncX7KGX9dsW+iV00x1+2X8Mi5WOf3qfNRKpVOfBJ+59je+8uDzH
	lUsv+ojAKw+zGqgEw38/mtCYuA52wuLT7j0MdNGAONAN1xxcBjfL1K92/97fAp86ZHrZ0m
	GmZBSR5Df40h0moEc8ZNPb6V7tRy0iI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-NfnGYYKVNgqD5YSXIQeWzA-1; Thu, 13 Feb 2025 04:25:35 -0500
X-MC-Unique: NfnGYYKVNgqD5YSXIQeWzA-1
X-Mimecast-MFC-AGG-ID: NfnGYYKVNgqD5YSXIQeWzA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dc88ed9c0so314280f8f.1
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 01:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438734; x=1740043534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gODipQT1RJ6DR0/GMvEisYcVEgWaoya2b4Hn/2vB8dw=;
        b=MqKudqsFlUqf6NI/ZvuUQO30OcKdr+IjPLts7j/V/vTaJ2cL8SU97V1hKyPJRgWp3P
         WvdJ4/TAa4Jr204L4L1xYAXqQn0hl3P7QeU5YtZB9YZmPIidJuXMh+VoWJK4/evX/Yxo
         eJMzKlC6cdAxzKcnWukLkHNta/S1W8kI51d5yEdsl8iufYMnt21iPJlGQYbzNyf/yfyv
         N/oJo0PALG1Egey82tyO0HzciSx2jv+d+YuCXwiJCW+kRbAp20Z7/DcTyyXZ+y6NEYKp
         xQvpcuxHuU+V7cNxEzE/sHHt1v8SwbaLDOZL/pkHp7xgnDEXstUpl6Nlpl2t6GxKnM3F
         YWtA==
X-Forwarded-Encrypted: i=1; AJvYcCUBTcLxFq/LVU2wDDshm2idHMo+g1xByxa4bxFj4QSF4/o3Uh5cpteANbfQsNp2/p00YrS6yYXg7yEDhxW9UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIestbkwOPAjojHH3xq2drK/HL3Ke8Jf9yYs7cuwHQm6u0eItU
	S8tt+sMXLuX9d3wyprFm3NKJvda0ftOMQoX+pgsOv7plepJ7S5KeeQ0xmuJxMD+jZJjx3GTpLwS
	Z954fXQQJ29G3q14YFOjsznT0LTTZxUNMP3OZxkECDuGx7+x71I6JxJmR9ZDHO9ra
X-Gm-Gg: ASbGncvDrzT+acTZunbJzB3Gw2wEYQUuBRBdXQKWsQlF0y7XcKGBaO51eHCOlSSdVPM
	/RgvDEp9Ru8KT/eKP/mM861Ikwqw29lv+E6IKKakiyyPa1bVyM+oTnyLS0xls59nHB98CTQw5K9
	/xMraiyhxcVyMz0TqXORMbtFCnOGhAi93bvR2lCe1PNq2LwZuqlTF4fmc6LC+n2MY79Bmn0Y15S
	7K8BN7SWD/rlQolCGI4tfQvIW/qWV+69VGSb8fJjSWxTVmpnDcphCPyHKtLOySs6xU/m7SyM3vx
	nfjCNRpdukbjFdgqy2f0qGb4wnLgrgPw7RZJ1djpZcQ6ABJok344iw==
X-Received: by 2002:a5d:5984:0:b0:38f:2350:7f70 with SMTP id ffacd0b85a97d-38f235080e6mr2406587f8f.24.1739438733953;
        Thu, 13 Feb 2025 01:25:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoCVYCjHVfohwpNNaQmSzmtARyIP61OU3BHF6Vls4lswHDEoUel/X9vFTBA8VTVIJQ/jGE9g==
X-Received: by 2002:a5d:5984:0:b0:38f:2350:7f70 with SMTP id ffacd0b85a97d-38f235080e6mr2406531f8f.24.1739438733293;
        Thu, 13 Feb 2025 01:25:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm1280846f8f.89.2025.02.13.01.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:25:32 -0800 (PST)
Date: Thu, 13 Feb 2025 10:25:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, 
	ying123.xu@samsung.com
Subject: Re: [Patch net 1/2] vsock/virtio: initialize rx_buf_nr and
 rx_buf_max_nr when resuming
Message-ID: <4n2lobgp2wb7v5vywbkuxwyd5cxldd2g4lxb6ox3qomphra2gd@zhrnboczbrbw>
References: <gr5rqfwb4qgc23dadpfwe74jvsq37udpeqwhpokhnvvin6biv2@6v5npbxf6kbn>
 <CGME20250213012722epcas5p23e1c903b7ef0711441514c5efb635ee8@epcas5p2.samsung.com>
 <20250213012805.2379064-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250213012805.2379064-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rJS8RBcXPjgSMFxmnDM54udvOiFRJHeImGLvtmaXyXo_1739438734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Feb 13, 2025 at 09:28:05AM +0800, Junnan Wu wrote:
>>You need to update the title now that you're moving also queued_replies.
>>
>
>Well, I will update the title in V3 version.
>
>>On Tue, Feb 11, 2025 at 03:19:21PM +0800, Junnan Wu wrote:
>>>When executing suspend to ram twice in a row,
>>>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
>>>Then after virtqueue_get_buf and `rx_buf_nr` decreased
>>>in function virtio_transport_rx_work,
>>>the condition to fill rx buffer
>>>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
>>>
>>>It is because that `rx_buf_nr` and `rx_buf_max_nr`
>>>are initialized only in virtio_vsock_probe(),
>>>but they should be reset whenever virtqueues are recreated,
>>>like after a suspend/resume.
>>>
>>>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
>>>virtio_vsock_vqs_init(), so we are sure that they are properly
>>>initialized, every time we initialize the virtqueues, either when we
>>>load the driver or after a suspend/resume.
>>>At the same time, also move `queued_replies`.
>>
>>Why?
>>
>>As I mentioned the commit description should explain why the changes are
>>being made for both reviewers and future references to this patch.
>>
>
>After your kindly remind, I have double checked all locations where `queued_replies`
>used, and we think for order to prevent erroneous atomic load operations
>on the `queued_replies` in the virtio_transport_send_pkt_work() function
>which may disrupt the scheduling of vsock->rx_work
>when transmitting reply-required socket packets,
>this atomic variable must undergo synchronized initialization
>alongside the preceding two variables after a suspend/resume.

Yes, that was my concern!

>
>If we reach agreement on it, I will add this description in V3 version.

Yes, please, I just wanted to point out that we need to add an 
explanation in the commit description.

And in the title, in this case though listing all the variables would 
get too long, so you can do something like that:

     vsock/virtio: fix variables initialization during resuming

Thanks,
Stefano

>
>BRs
>Junnan Wu
>
>>The rest LGTM.
>>
>>Stefano
>>
>>>
>>>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>>>Co-developed-by: Ying Gao <ying01.gao@samsung.com>
>>>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>>>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>>>---
>>> net/vmw_vsock/virtio_transport.c | 10 +++++++---
>>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>>index b58c3818f284..f0e48e6911fc 100644
>>>--- a/net/vmw_vsock/virtio_transport.c
>>>+++ b/net/vmw_vsock/virtio_transport.c
>>>@@ -670,6 +670,13 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>>> 	};
>>> 	int ret;
>>>
>>>+	mutex_lock(&vsock->rx_lock);
>>>+	vsock->rx_buf_nr = 0;
>>>+	vsock->rx_buf_max_nr = 0;
>>>+	mutex_unlock(&vsock->rx_lock);
>>>+
>>>+	atomic_set(&vsock->queued_replies, 0);
>>>+
>>> 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>>> 	if (ret < 0)
>>> 		return ret;
>>>@@ -779,9 +786,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>>>
>>> 	vsock->vdev = vdev;
>>>
>>>-	vsock->rx_buf_nr = 0;
>>>-	vsock->rx_buf_max_nr = 0;
>>>-	atomic_set(&vsock->queued_replies, 0);
>>>
>>> 	mutex_init(&vsock->tx_lock);
>>> 	mutex_init(&vsock->rx_lock);
>>>--
>>>2.34.1
>>>
>

