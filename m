Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B603EFD34
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184183; cv=none; b=BhRVzagYUBYdbSXLLaF7rfrBQqLZIZ0z/ovp9Z8OzHVLIG28Pt90P/3ctgcr3Pdgz3oeQWUjH8R06//307GGNtCd/Gn+mQRV/1R1utvzRKPDgsJLGK5lW/xOA7QLJus3Rx/j7rYoYbWcGAGOPBtHrh/tPoQOXi6X7tY4Af94yME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184183; c=relaxed/simple;
	bh=A3kYDVRcCv+l5IYdjIvqMz4NtZd1ehaoUU/Tc+OxqTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kh0WZLn9Hjk61NCE0DIOmHtreI6nSeKMl/26RHmqI+bZqQLP5KCFDb7VICqd2CEdouzIAnPJIKvzlcGV+PixPurNt+4yJsqG2W9JzHG1cg5C8sEV847kD9NyEqzHPtvHhWkWrHGTWscqBg4W2f4WPiEiRnVi8X4HAylx0yMRDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0heET/Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0heET/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779184180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zj2k4OlZU7xwNJcXmWQpbVh/b6JWeCsbljlDYkhC2cc=;
	b=M0heET/Z+kggfrXdhnLXocESv95SAULrGRU/fv1PkQbnrjuCmgnH82QMx7zKT9peOFNgRV
	pVxLxrC3lL6g/btH61xXctxGcbiNKZJsycRCjzJcRsrLV+ihihH7CsdOu4oMv7o5AOq3kR
	O4K7aoKXn2lFsgTnzZdHNFFuDp1Ya4U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-l5H9Qs8XPm-hLDU8yQGB2w-1; Tue, 19 May 2026 05:49:39 -0400
X-MC-Unique: l5H9Qs8XPm-hLDU8yQGB2w-1
X-Mimecast-MFC-AGG-ID: l5H9Qs8XPm-hLDU8yQGB2w_1779184178
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fdca5c638so27004985e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 02:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184178; x=1779788978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj2k4OlZU7xwNJcXmWQpbVh/b6JWeCsbljlDYkhC2cc=;
        b=fn9utJtEIXhJjdbvq56x1/mV9B9BF8WIG3wrZJZZo2I345KUaGDynWMsIuqb9AM5h3
         UT9h5L0XK6fKyiv2ey9QRE1xY6F/Rm2zd5m6gHrFww2GBzD3m89M89asBZ5iKTYgKE/o
         PbiO2tI0uLgSlI2UdBi1ZIrYEG89XhVxZ/6pcNl97UPQQxGz151dCMlQ9pV1udNMYv48
         sbGhE4o2qw4TyFkkJr4OBwv1c17UNh8Psbs9ctZKbvncehguDEUYNgKiNdYdF8+Eh8pp
         0BvPsmK00HCU6nR+4lCNtLGv/ur9+NbxUoa1dAM0vrodTdCb8trKlDDb0jrMJ2KNZZbS
         GQvw==
X-Forwarded-Encrypted: i=1; AFNElJ8UkLgjo/y/AgywC7yY2nNHaaIJE+STsNtckTSJwy/zOZ/sFWV+C5SLMpP4yA7vwypc2/izGm7mq3m27cQftg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9NWgpRlPxvp6PgMEJaWttl8d977gYhXTEt1uvmfUW/+rsOKJs
	fyzeKHNjtKvUooqO4JpUiDJYZRkUG8tZWCZg7rg+nxpjwpWjVuPLbF/tXgWLqsujooHGz/BUYmI
	m12ObOpcNaxYktehiCzQMQQ/Q0NX8ssiMmswDkCnJcGIf62H8ucBoZyWQzwZK0UV4ckRR
X-Gm-Gg: Acq92OEdZPI1YUC0DDniik2NkVrud3TU1Q1yussHY0L0y8mOeGoZfZl096MmAqyir/i
	Q9kYsJnC3QWMHE8gtNyOKEN1qf447OP2U7gdnmVrqAv6CvHnWP2ItfyOfioxj/Zv3nSt6EW5iNy
	qinb5v+94n2+FQCpDMsJi1SDfvkKs4fcv04YKIvS1L3D23tnjb+Cr3STWo19NSBlJnGlMWHRMDa
	ilVAvwGpt7xMbTWv0+pLkufChHq9A03VaGZWocUdgExzfdAmC8hjxAsQPMFVLjM851hgl5mzwBv
	KyUGawJXoDM+uPS8iiI062o+ly3+11an+C6ajJ4GsEPoY9RdtHM43MyKXTTJXcMYi4AZikuOfEp
	CPVuxUPz/jvE1qiMu2DfRNKUzkPwMx3J2J6Lbl++aL1DMB+XTVWPUt2bqwCSlqN33GW/xhfDeo2
	t3jAFj4eZW
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr285210385e9.5.1779184178098;
        Tue, 19 May 2026 02:49:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr285209745e9.5.1779184177542;
        Tue, 19 May 2026 02:49:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm334163125e9.12.2026.05.19.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:49:36 -0700 (PDT)
Date: Tue, 19 May 2026 11:49:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agwwxuQlIWjwXtMN@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
 <20260518053223-mutt-send-email-mst@kernel.org>
 <agrg1GVzoJWtNuSd@sgarzare-redhat>
 <20260518115005.5f13bd2b@pumpkin>
 <20260519053951.1C60440015@mx4.sberdevices.ru>
 <aea2227c-3011-4457-b909-d16de1596a6d@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aea2227c-3011-4457-b909-d16de1596a6d@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4D-B_qJrbBIv-X15t_dNDBPJwbrYvIn_FKlPqiB2KCk_1779184178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 19, 2026 at 09:37:23AM +0300, Arseniy Krasnov wrote:
>On 18/05/2026 14:08, Stefano Garzarella wrote:
>> On Mon, May 18, 2026 at 11:50:05AM +0100, David Laight wrote:
>>> On Mon, 18 May 2026 11:54:19 +0200
>>> Stefano Garzarella <sgarzare@redhat.com> wrote:

[...]

>
>Hi guys! Just some replies after quick look:
>
>>>> >> > Surely that block should only be done if can_zcopy is true?
>
>I guess no, since TCP also allocates uarg even if zerocopy is impossible -
>it just sets uarg_to_msgzc(uarg)->zerocopy = 0;
>
>>>> >> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>
>Hm, we can't enter block 'if (info->msg) {' when 'info->op' is not equal to 'VIRTIO_VSOCK_OP_RW',
>because 'msg' is not NULL only for 'VIRTIO_VSOCK_OP_RW'. But anyway You point to right thing - check for
>'VIRTIO_VSOCK_OP_RW' could be removed here. Just with comment why.
>
>>>> >> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>
>Here I guess it is better to follow TCP way to make same behaviour, because exact
>logic for MSG_ZEROCOPY is not documented. TCP also returns error and stops tx loop.
>
>>>> >> >
>>>> >> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>>>> >> > The caller has already requested a callback - and you can't add another.
>
>In TCP implementation if 'msg_ubuf' is set they just use it and check for zerocopy in
>the same way as 'msg_ubuf' is NULL.
>
>>>> >> >
>>>> >> > In any case by the end of this can_zcopy and have_uref are really the same flag.
>>>> >>
>
>Need to check it more. But 'can_zcopy' means that we fill frags in skb, have_uref means that we
>allocated completion (but it could be reported with not set 'SO_EE_CODE_ZEROCOPY_COPIED' if
>'can_zcopy' was false).
>
>
>@Stefano, I guess current implementation differs from TCP in two cases (at least from first
>view):
>1) When 'msg_ubuf' is set: in TCP, already set 'msg_ubuf' is passed to 'skb_zerocopy_iter_stream()'
>   (if zerocopy is possible) where it is used as in vsock in call 'skb_zcopy_set()'. In vsock case if
>   'msg_ubuf' is not NULL we will pass just NULL to 'skb_zcopy_set()'. Yes this is will be
>   no-effect call today (due to checks in 'skb_zcopy_set()'), but anyway - in future may be not.
>2) Also i see that 'skb_zerocopy_iter_stream()' in TCP version has some 
>extra checks which are
>   missed in vsock - we only just call '__zerocopy_sg_from_iter()' to fill skb in zerocopy way.
>
>But, I think, instead of trying to compare vsock and TCP versions best way is to just copy
>current TCP flow as close as possible:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/net/ipv4/tcp.c#n1144
>1) Use same flow of checks for 'msg_flags', 'msg_ubuf', SOCK_ZEROCOPY etc.
>2) To copy data we can use 'skb_zerocopy_iter_stream()'.
>3) The only thing that we don't need in vsock is dev mem related code from TCP implementation.
>
>I can take this task, but pls need some time - may be two/three weeks due to another tasks.
>
>What do You think?

If you can work on it, please go head. They seems all pre-existing, so 
2/3 weeks are fine. Please let me know if you can't and I'll try to 
allocate some time.

Thanks for the help!

Stefano

