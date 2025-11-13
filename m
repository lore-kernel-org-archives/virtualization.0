Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0E2F5A36
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047900; cv=none; b=GJILmcdTKJbB7sW+CHKF0esYtM1iV04Mr0ba9Mu+Upl41tzRtE6SFxwu+n8LLQ6Uc0w0oW/mmhGgZEMv23UKeyjcx/3f7fijQWni08cFhs0b3ULcFknvy3H7tC7aLSGsQUVmGSqOtp9cH52l1q7QvxBS4vQYq2eGh7uXWrhKtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047900; c=relaxed/simple;
	bh=cmUw5fQytCW5K8CgA+45UI+EqXpRzL3G2UrLV2MjQf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=g/+MV1RWZ77o6rMG8hXvoXlO8ZYOEqvvfsO9n0hOrg5gC1sExepH4DFu2Prvh7TnKVeb9dpr7C+d2ZS7uHjCvZKqUkqy4QbSx8C9sJZkH1z6IZnDaUHBiu+7iautQNB+MbIvkKeCNK8P68Yv6E3W11FCAQfr0d5ZSBAN9HXxueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWL+/Nrw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWL+/Nrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763047897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7XY31OsyOl8v7j52xmkmb5uEiW5I0tIphYxwIfznBM=;
	b=OWL+/NrwaO+TEyNnSsI7RiAmypE6mpsvyYCGA/2vNmcjxG3SIwsjcnPWTFY84MBVz3vWkH
	cEsVCgYw4FkQ7/Qg6jTGP8tPZKe9AM2tpPyNa/y+cDtXmFkY+trs38HRS46SJ+Kz0r+MjI
	zlqc2MmoarJM467CKHrEeSc4TE0pAEw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-A5PatvWlNMiAp1ajyL5uPw-1; Thu, 13 Nov 2025 10:31:36 -0500
X-MC-Unique: A5PatvWlNMiAp1ajyL5uPw-1
X-Mimecast-MFC-AGG-ID: A5PatvWlNMiAp1ajyL5uPw_1763047895
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70a978cd51so117670866b.3
        for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 07:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047895; x=1763652695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7XY31OsyOl8v7j52xmkmb5uEiW5I0tIphYxwIfznBM=;
        b=F40KjsvG4GxLZIuW12gm2czi3pAMWHeYfFSN26SQv1JnM7zjBjqd60ExnSRniiVu4V
         8VliFb1YKbImaRQm6X6DPBQ3ptcSYaZCSUhjHTlntW729boWoKMepXxfINggwIqtRE4X
         3YpmibSD23mUULg+fyVi34An6/TdQpVwXA8OzAFe8AYW2lIdzU5mmZGiYOsoSAvGrnX+
         +TapzAXKrnYkGTCgman9RLfeynyBG1yaNZscIkvH82sq+6K5GIU8qKN51ofiq4+VIPjd
         dWx6ciC7AXDOFydeDk4n9R9GUGrb17HNXTyagEjcimkpmzG9CJnTMDPiN3K9zbgaDy1T
         2ukg==
X-Forwarded-Encrypted: i=1; AJvYcCXeeyAlIxkV4cVZ3j88Lv4xiGFuxFn77ZXQ8eS3SxvzynrlCSaasGkYYmN95EqhGUYKRjLosXDlkpG29E7Z9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoeC1t8kdGC8e/A66DfYUcBwASx4cGtwHDv2rHCae9xvlUuAxU
	9hXsBSypITwl1eSwXWrM/lz9U1lt70Yu5RiO3rEF/SLzW0BDx29sMz1kIQ8bem7Huk5bvgm+XpS
	qOq/qDvjaUgBCxclF8OU24+0KEehDhQitjyyYSok+vkmhyvnkiI66zrKjwHiabpPQ0b5r
X-Gm-Gg: ASbGncvnbqnYdTyeiP2WDaaCH79QPdrNE/SuAn/4OHIZer50pZCu1ll3g2JxGkI8hHX
	mib+KnoWAcobh4iXyKQFszoUbsCwTJg+PtJK5ZW3Qyry6xU7fLE7luqJ+xWYgCnc3RQcx5ptnXH
	p3O5LImGhq3I4VUDiDU+wxReYKD3SCA0XKkA9mKJVq7h3ur0UnKlb+mpQ/y3TjoXJDuopIz+O5/
	Wh0Qzlli2tQUB+bP/znI/81CeBEBsIaen3gobLPyUSh+3UOQiBk3DtV0gsrSDQQKm2uMSGEuDXW
	N43dueWVazRmLvsBXAsyqzlU2gHQvYt99smIUjA51kzhYoHxJEKiCSev1GHetKRvh5rtq8gsvMW
	uxvbpXGiPtvq0VRpnx9Z2buIXoPQcs77RzeirjjuPZ1Gn9zTVbtg=
X-Received: by 2002:a17:907:c06:b0:b70:6d3a:a08b with SMTP id a640c23a62f3a-b733192f5c5mr808715366b.10.1763047895407;
        Thu, 13 Nov 2025 07:31:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8lpe22E3h1TC8hEnHCzisPSR4qLMl80qiAEbaySsAUvtzhvgQRLYBeX2TaGg4WnRojfXASw==
X-Received: by 2002:a17:907:c06:b0:b70:6d3a:a08b with SMTP id a640c23a62f3a-b733192f5c5mr808708566b.10.1763047894844;
        Thu, 13 Nov 2025 07:31:34 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad3edasm184936266b.17.2025.11.13.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:31:34 -0800 (PST)
Date: Thu, 13 Nov 2025 16:31:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 03/14] vsock/virtio: add netns support to
 virtio transport and virtio common
Message-ID: <ym7us45wytkmibod5fkxoyss3nl4kxzehlchdm4pqnvvnzreey@dvuwn7olusc2>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>
 <cah4sqsqbdp52byutxngl3ko44kduesbhan6luhk3ukzml7bs6@hlv4ckunx7jj>
 <aRSyPqNo1LhqGLBq@devvm11784.nha0.facebook.com>
 <bhc6s7anskmnnrnpp2r3xzjbesadsex24kmyi5tvsgup7c2rfi@arj4iw5ndnr3>
 <aRTg4/HyOOhYYMzp@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aRTg4/HyOOhYYMzp@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tjAdrEJHvC1YlXl2nHiflu9JGnUkPm7rWoBNMXIrJ8Y_1763047895
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 12, 2025 at 11:32:51AM -0800, Bobby Eshleman wrote:
>On Wed, Nov 12, 2025 at 06:39:22PM +0100, Stefano Garzarella wrote:
>> On Wed, Nov 12, 2025 at 08:13:50AM -0800, Bobby Eshleman wrote:
>> > On Wed, Nov 12, 2025 at 03:18:42PM +0100, Stefano Garzarella wrote:
>> > > On Tue, Nov 11, 2025 at 10:54:45PM -0800, Bobby Eshleman wrote:
>> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>[...]
>
>> > > If it simplifies, I think we can eventually merge all changes to transports
>> > > that depends on virtio_transport_common in a single commit.
>> > > IMO is better to have working commits than better split.
>> >
>> > That would be so much easier. Much of this patch is just me trying to
>> > find a way to keep total patch size reasonably small for review... if
>> > having them all in one commit is preferred then that makes life easier.
>> >
>> > The answer to all of the above is that I was just trying to make the
>> > virtio_common changes in one place, but not break bisect/build by
>> > failing to update the transport-level call sites. So the placeholder
>> > values are primarily there to compile.
>>
>> In theory, they should compile, but they should also properly behave.
>>
>> BTW I strongly believe that having separate commits is a great thing, but we
>> shouldn't take things to extremes and complicate our lives when things are
>> too closely related, as in this case.
>>
>> There is a clear dependency between these patches, so IMO, if the patch
>> doesn't become huge, it's better to have everything together. (I mean
>> between dependencies with virtio_transport_common).
>
>Sounds good, let's give the combined commit a go, I think the
>transport-specific pieces are small enough for it to not balloon?

Yeah, I think so.

>
>> What we could perhaps do is have an initial commit where you make the
>> changes, but the behavior remains unchanged (continue to use global
>> everywhere, as for virtio_transport.c in this patch), and then specific
>> commits to just enable support for local/global.
>>
>> Not sure if it's doable, but I'd like to remove the placeholders if
>> possibile. Let's discuss more about it if there are issues.
>
>Sounds good, I'll come back to this thread if the combined commit
>approach above balloons. For the combined commit, should the change log
>start at "Changes in v10" with any new changes, mention combining +
>links to the v9 patches that were combined?

Yep, that would be great. Plus exaplaining why we decided to do that (I 
mean just in the changelog).

Thanks,
Stefano

