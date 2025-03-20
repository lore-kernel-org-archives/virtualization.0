Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F211EB9E3
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461695; cv=none; b=HsFhgW5whLumsHd5Gt0mG0y31gjNuN2ync/7tWruyZLCb/j36oOqjp0Mhh9STzQMDUpnN2qiGQbQaP7Zt2DKo3c7tqOrp1woxu/oq2b6Zhe3WgsR2HxEv/bH9RLij0jvo24N+zOx9H07FF7SxdnOtOiAg+Z8QdTtE2T9Kf69L0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461695; c=relaxed/simple;
	bh=5W1uHTX0JS3ybfrgNeMmG6TgEZd4dU4vl69eG6Vq4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i1nwFD94uT8qh0QbRGG9+0ogdlE9c1qy5Z0exPar6oxAmOTGcJGPDmIf/zFo8i4O2FvneeTjFjqYozhJFyZM8vKc8l8dQYJGQNg1MBf96S6Z8bNZMdrzv3Xdq1xsIKRHqHbMRqUkgmVVOotqN4hvdhihabkW+vp+6xMSSRzbmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeL8izHd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeL8izHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742461692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
	b=MeL8izHdJigzrCfOpwdqrWSJTT1G8I0xllPlitL5DEDiNx4hJFqEZCwSjzmEnlRcM4YSSt
	F4k7ejJZ7wulKhhJzacqbi5qveoVEooEGUxRvbxgYp2zqOxGnWzo3LKt9FKhar0n1ltphm
	vVgcGS+JAt730/YLpbBzjpvqrX02z8U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Uf_HQCkZP_acBCaInkEU0Q-1; Thu, 20 Mar 2025 05:08:11 -0400
X-MC-Unique: Uf_HQCkZP_acBCaInkEU0Q-1
X-Mimecast-MFC-AGG-ID: Uf_HQCkZP_acBCaInkEU0Q_1742461690
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5eb80d465b7so535055a12.3
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742461690; x=1743066490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTq60/uptS/vYIusNxJ/yOQlPzuUR9or0TJgSxpmhw=;
        b=DeuJoCO0ymL51iSLy10sDPwvXcyXVDvW30+hd30r9DZIvvcXSzNOQzBw5HfmWv/teo
         7sC6ATGsI2fMFINWIy7Ffm3rSEvKAcY6ZNw9NifAZVDFE5eofgRp75DIxN1YFidizMIE
         nAtARo7vRUYMydpkBvFuaBwd6ydLa3iobsxeZmAjw+kSd+eutVDbNi46wAnANH6HQsmG
         jkLli8Bi4gLQvksCaIFtKwhuJMn2a5dbFupFFocinTxVn2ZyymRRsqt8SyivDjitr/Cr
         QvBhw53g8xe5t8Sg1eJvqzI7jR1u+1trQ3MhVhjZ/8dJfj6Wc5mGEXSuSFtmFsg1/zAl
         rEZg==
X-Forwarded-Encrypted: i=1; AJvYcCU9tAhv/IV13/1dBTYkqLfd3DvmS9wXCd/INKh0xyRUa58LmdsEEedwCvTE56ce5UUtCVQ2Vw+0r5KcIZEcgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKXw2Mm1PWgQSSVFKazihX2Q3Jv7eaUy+iMGrVfZcDEftX5N4b
	iDn0fhmHgSYy8SEaDLovjNC+AaWdFecKqyRxsYUTGvXjcS9zl4NaZIInrzXd+FkpBIwY5QL3oz6
	66Dy4mBhsH+WW9Gjia52VmX+X8//IOmjiVx0nmWmCSjHAcXUkkoDtMyV0v8fOp0rA
X-Gm-Gg: ASbGnctQTqe8q4TigkUGkOA5PlNaFY4EctCcWjom15bCeB8h8WWIUDZTOnh06wBNE/U
	0Gle+U6tLMeV1KoUnpYmkduUe5H+HBi46JzlBkx5awmdj9zpuPlJmyfvKISPzYFVJ9s7u7wxDyb
	L0r3kc4+BbKbVpYr6ZKIys80qeq5BLRb88RuOv20IoIQjlpfoOKOwyjM7aB2x8fxgHFfAgqPR3L
	dPVwQ2nJdyqoHuH6PK8jj/e31TPni2mrYoZenN7Uo9J9QHQAYoeaghg98dPLq+mpD5iTvPsA+eO
	fB/zabcqMI/QIEh/SgnPkeAfT0O416hfFl+Dpc+GgVc0DQmp7Vi2QwBFgSSlEALf
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839737a12.4.1742461690260;
        Thu, 20 Mar 2025 02:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOQHfmcgMblKkiR1tHejD7TWeiNXKZXGZAyBKU76H5X4T1+QQ1dIB97fNyYdpVkDoNZIj46Q==
X-Received: by 2002:a05:6402:13cf:b0:5e7:c779:85db with SMTP id 4fb4d7f45d1cf-5eb80cdea32mr5839682a12.4.1742461689546;
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afeaabsm10004728a12.69.2025.03.20.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:08:09 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:08:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock-netns device
Message-ID: <nwksousz7f4pkzwefvrpbgmmq6bt5kimv4icdkvm7n2nlom6yu@e62c5gdzmamg>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <20250312-vsock-netns-v2-3-84bffa1aa97a@gmail.com>
 <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <09c84a94-85f3-4e28-8e7d-bdc227bf99ab@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hpTmExHYW8HFPp0N3_iuWb2xbVfOUIs1e5ticTpV0vA_1742461690
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 19, 2025 at 10:09:44PM +0100, Paolo Abeni wrote:
>On 3/12/25 9:59 PM, Bobby Eshleman wrote:
>> @@ -753,6 +783,8 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>>  	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>>
>>  	vhost_dev_cleanup(&vsock->dev);
>> +	if (vsock->net)
>> +		put_net(vsock->net);
>
>put_net() is a deprecated API, you should use put_net_track() instead.
>
>>  	kfree(vsock->dev.vqs);
>>  	vhost_vsock_free(vsock);
>>  	return 0;
>
>Also series introducing new features should also include the related
>self-tests.

Yes, I was thinking about testing as well, but to test this I think we 
need to run QEMU with Linux in it, is this feasible in self-tests?

We should start looking at that, because for now I have my own ansible 
script that runs tests (tools/testing/vsock/vsock_test) in nested VMs to 
test both host (vhost-vsock) and guest (virtio-vsock).

Thanks,
Stefano

