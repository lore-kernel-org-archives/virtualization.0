Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDA17B418
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858344; cv=none; b=BJwfCn5eKQTxgswFcFB6mbxgOhwDy55EAqpTCBj16kn3xAnLJ9cNRVRS6hbqt+ZGcZVa/RTp3pa6ZizVqCA7JPUE9cEDQhpj3/MxWMQD4cDohokbYt8MJrCVfhPwGN3JG29zZCQXQB/wQ1JGwRCg0cgt3Yw6yRPEisNhGQFpVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858344; c=relaxed/simple;
	bh=tgyI93DqO+iceJu24PzG+d1oFJs9Iucz7h4dqyH8ohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kSi5GczLH5TD4eOa3qohMfusjKeoyNeLuuDbvzjlmx1H1dyrY3VgI5PRg8CRf0pJx5Go4/HR/lFuTdeJU4Wiaf2N12r13CF8zfF8pxeHrbFHymwCLb7TRFSEeBAPEaZfWYIhtlw8pJQ06FtqSKZgh8elvd2849IqLgma5c+GJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsNWRZch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsNWRZch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750858341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fwu8mDntzdWYt27Qd6IJlpVfWUrdOeVJ2HfrSFGosU=;
	b=LsNWRZchiyBVgMaxE4dB6l6MEYVKQiJ/wDLXQv2b0TRAlQRaXRMePEBAjgrjKVb2dRRdRR
	dkVCoaZvgX6Fy7LqgehR5UwgPYZfBu0Y4LEV9EknUxLyvrOBR2ZcrK8bls9WsbOc5k1CAq
	a54Dz6pQ0q5DqhIdBGMZP7O9rT7rE50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-0IPnGXrUMTKzvJB3TZ_dmw-1; Wed, 25 Jun 2025 09:32:20 -0400
X-MC-Unique: 0IPnGXrUMTKzvJB3TZ_dmw-1
X-Mimecast-MFC-AGG-ID: 0IPnGXrUMTKzvJB3TZ_dmw_1750858339
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453817323afso6255055e9.1
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858339; x=1751463139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fwu8mDntzdWYt27Qd6IJlpVfWUrdOeVJ2HfrSFGosU=;
        b=MmLZL1DNzR2SkmS87D6hoABf3Jac+utaWMMq30A3O+VTu6bzifba3+4CgKHQRg5dl6
         mV9Y1A0NdPUJ91ogIyVaBYXF3i9+Af881ezKRvydleX2uW55+B++QBZu/TnBhPMj62Ed
         TItH7Sp8qO/dAXd5tvwRBjFh/xaqIfsOPasNHxOkPFuMJkM5kO6fW66Ueb0DaisAMk3C
         +EuOwOdcn8uxEQIF8rbPMLxd+bZ2XLB4MjT39ZnCkciegdgOh6VaUkN2iMwmao/BUc0J
         mI6Ei/k/SFg5pUXC4mWD5R+eOv/0WPbdQBNEEAfEwbWGg9FZ3vBoGZcphiE7rx6K1eXK
         Sytg==
X-Forwarded-Encrypted: i=1; AJvYcCXTi+4ojRPZlC5wjy5F6sebNDhu7ZlSmmliW2Uh/x83yDeDpBnGjO0vlA+yvfF1p6FxJf/Hf4DV/aI+b8I6JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzXU6Qf4pZTrUEbuzeMwP+4qeoE4aM48lQnBEzZnEMlJYpEg+k
	/J3uChdqHIqre6rfRfd0m7+LS8flMCj+RNeuu9kMVWvHSPSOMB8+CtUKsaex7IDA0YBMOvKOWmC
	be4WwtjQicXAeGfxD1v2fqQJJw6UF13qwKWlIOqSRZk8VEET8DMdeM1wA8077egRxH8t8
X-Gm-Gg: ASbGncu6ZX8TOabq6k9C0FHtEsiuQZ8AVD2ABXI8MLsqNPEqxpL+MFaCXTTTDQJVZDT
	N+aL8Qf+ZpAIJS8wYgHrOCf6x0QQAGPXF5zdsO5OCVgXQlretK6pnCisnDlA63AQ3VtTiCKnGzc
	eRDoyef+PcSyMgh3jQ0SLXl7WyRxU1YHfdAUBCFfrME9YbD48eh8X8jvIn2nrN1IAvW4fT690ar
	jD/H9cnky5Lq7RTIns6Hpa2lqHFTs5B9u3JMqRNOSL6iRUVG6fKXLNSFfBu7TFf/OQfv6LgDwpf
	RFJezEfMbfm3nLt3aS4DLHNakwOt
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr3103795e9.6.1750858338484;
        Wed, 25 Jun 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY//pCRPoC2EFYGzFZ4umPjaocK1G0vDEhyvr5hVoQgUAHwK1E7Yy9rAocwNi9NP80rjw6AQ==
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr3101355e9.6.1750858336283;
        Wed, 25 Jun 2025 06:32:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2a4csm4708245f8f.65.2025.06.25.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:32:15 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:32:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Xuewei Niu <niuxuewei97@gmail.com>, KY Srinivasan <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"leonardi@redhat.com" <leonardi@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "fupan.lfp@antgroup.com" <fupan.lfp@antgroup.com>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 1/3] vsock: Add support for
 SIOCINQ ioctl
Message-ID: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
 <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
 <BL1PR21MB31158AE6980AF18E769A4E65BF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BL1PR21MB31158AE6980AF18E769A4E65BF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NzDWq2yWF6WRj75XoRIUvyI3HAhr-k5iwEa5HTSZCHQ_1750858339
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 25, 2025 at 08:03:00AM +0000, Dexuan Cui wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Tuesday, June 17, 2025 7:39 AM
>>  ...
>> Now looks better to me, I just checked transports: vmci and virtio/vhost
>> returns what we want, but for hyperv we have:
>>
>> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> 	{
>> 		struct hvsock *hvs = vsk->trans;
>> 		s64 ret;
>>
>> 		if (hvs->recv_data_len > 0)
>> 			return 1;
>>
>> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
>
>Sorry for the late response!  This is the complete code of the function:
>
>static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>{
>        struct hvsock *hvs = vsk->trans;
>        s64 ret;
>
>        if (hvs->recv_data_len > 0)
>                return 1;
>
>        switch (hvs_channel_readable_payload(hvs->chan)) {
>        case 1:
>                ret = 1;
>                break;
>        case 0:
>                vsk->peer_shutdown |= SEND_SHUTDOWN;
>                ret = 0;
>                break;
>        default: /* -1 */
>                ret = 0;
>                break;
>        }
>
>        return ret;
>}
>
>If (hvs->recv_data_len > 0), I think we can return hvs->recv_data_len here.
>
>If hvs->recv_data_len is 0, and hvs_channel_readable_payload(hvs->chan)
>returns 1, we should not return hvs->recv_data_len (which is 0 here), 
>and it's
>not very easy to find how many bytes of payload in total is available right now:
>each host-to-guest "packet" in the VMBus channel ringbuffer has a header
>(which is not part of the payload data) and a trailing padding field, and we
>would have to iterate on all the "packets" (or at least the next
>"packet"?) to find the exact bytes of pending payload. Please see
>hvs_stream_dequeue() for details.
>
>Ideally hvs_stream_has_data() should return the exact length of pending
>readable payload, but when the hv_sock code was written in 2017,
>vsock_stream_has_data() -> ... -> hvs_stream_has_data() basically only needs
>to know whether there is any data or not, i.e. it's kind of a boolean variable, so
>hvs_stream_has_data() was written to return 1 or 0 for simplicity. :-)

Yeah, I see, thanks for the details! :-)

>
>I can post the patch below (not tested yet) to fix hvs_stream_has_data() by
>returning the payload length of the next single "packet".  Does it look good
>to you?

Yep, LGTM! Can be a best effort IMO.

Maybe when you have it tested, post it here as proper patch, and Xuewei 
can include it in the next version of this series (of course with you as 
author, etc.). In this way will be easy to test/merge, since they are 
related.

@Xuewei @Dexuan Is it okay for you?

Thanks,
Stefano

>
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> {
>        struct hvsock *hvs = vsk->trans;
>+       bool need_refill = !hvs->recv_desc;
>        s64 ret;
>
>        if (hvs->recv_data_len > 0)
>-               return 1;
>+               return hvs->recv_data_len;
>
>        switch (hvs_channel_readable_payload(hvs->chan)) {
>        case 1:
>-               ret = 1;
>-               break;
>+               if (!need_refill)
>+                       return -EIO;
>+
>+               hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>+               if (!hvs->recv_desc)
>+                       return -ENOBUFS;
>+
>+               ret = hvs_update_recv_data(hvs);
>+               if (ret)
>+                       return ret;
>+               return hvs->recv_data_len;
>        case 0:
>                vsk->peer_shutdown |= SEND_SHUTDOWN;
>                ret = 0;
>
>Thanks,
>Dexuan
>

