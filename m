Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DB13AA3C
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461158; cv=none; b=OFnLjivknaDAp2BJFLqG9sVx/Jz4p5PNr6PRstIlYkUY26ApijOq7aUSbwbT1ibiAntBaRlmU5geqRGRsfSCAhvbwuR6JUjMn6giu8xLw0SYpnbS910Ic7NPuS3t6r/0gbCnO83MDDElDsBlIy4mZx25UaY2hBP9lbosqr8Lv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461158; c=relaxed/simple;
	bh=+30TEOUWzw8uVDSprmsUuB0N4ph4VHKOtlgrAVTx4Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c5X0y0CFwyjtmsa+oWt/ZQcH9HR3kdJpruaFZDVd05abdCds+RoQR0grq3bldoYNzexEsz0VFR1bcfhCrEKUr+BOKj1x05WUhqz0sg834F2qHQNwHAaFRCSWyTYrnfxajxoQvL2x4Qwq8Vjs3nOx+Iu9pajHpkNOLKqSa8LA6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egt/+XLE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egt/+XLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juhsDEScRvI3YVyUAk4M5qNp/ka5CUgsay8JZp9KViI=;
	b=egt/+XLEWNWkDuIJ3VWPYzmrwmvUhcQcTBjZmoCA2DDl7tEqH3I7eFGoyFxh+/jZGw0qZb
	nf3f89hSmRqdb1LFA3cktkkKehfq9pn8F3vWBaymOuU5PwNABglzXAUvLOINJjRzFUgW+Z
	yZ+tYLpf9AkigMubR+AusAndsHyVI+U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-dduCaUOWOdSe0AjfQpaO7A-1; Thu, 23 May 2024 06:45:53 -0400
X-MC-Unique: dduCaUOWOdSe0AjfQpaO7A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-794a0288ddfso161751285a.1
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 03:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461153; x=1717065953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juhsDEScRvI3YVyUAk4M5qNp/ka5CUgsay8JZp9KViI=;
        b=g10I36IE/c5csW0kvYxyNOCck1KaUGBNIRrmE+2pXC8CQhHVepLYU5UUJ6nKp2429M
         LMYVxsx21+/LedsgSpKYyTmYbO4KySkTP0fgy44m30aWRkLpuh8/O8tmuWoS43OTndu2
         tUJlAh+W2uy5x4GKE6/5nKPdfz0YyXbJfEVOxeuqxe7oJAZYoLK6EZpwgTowr/tPcmwR
         u9/lqfflbUMQmTPSVY7y1hd4KfuneupifXnTZt0aRAMEg48HDsR+6PtiThuQLDFWJn/1
         Biq0EFJXb8Yzy7oOgZvrOED8a20QsZ3Hu9v36ariGRGg+ySsjDdFZwaFW6xEODHO+Icj
         JMng==
X-Forwarded-Encrypted: i=1; AJvYcCUN2cJ7et9LNGci9vDHboDtlwqiS6jHOlAk8L0PqreKYvoMhsndZeSvFn+axpHmfRhqsBsGRnQ0jOivdRM/IgDWd39BxM7oNXFphZy9RL4=
X-Gm-Message-State: AOJu0YzCJrq+Rz/BZwIhIu0hBFgXQ2v5S4TWcWLcNa3kDpoNwqJe8PGG
	HnDl7BuQ4G/tc2Eam3tcmdlM9QhA2IgAqWkEgZWCpsg217C7BZnXYXxRkm2goroJ0b6BzwL1fg4
	Yv4AOcioHpvr2Mvg1VuCt6WXktyKjpbthntNUJqxsJ+4uJi1gu0SOj7dv6Kgthevg
X-Received: by 2002:a05:620a:270b:b0:790:c15b:e192 with SMTP id af79cd13be357-794a0a2d290mr321635085a.32.1716461153421;
        Thu, 23 May 2024 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECiVS/3SMXiEgz7MPG9qy81SLUPLSxWskDIfwdUcbJG/sFDMV5fNyBeSkgTZeUX0rHbNuuqA==
X-Received: by 2002:a05:620a:270b:b0:790:c15b:e192 with SMTP id af79cd13be357-794a0a2d290mr321631485a.32.1716461153014;
        Thu, 23 May 2024 03:45:53 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e3818469csm103371101cf.55.2024.05.23.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:45:52 -0700 (PDT)
Date: Thu, 23 May 2024 12:45:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 5/5] vsock: Add an ioctl request to get all CIDs
Message-ID: <azemyxjihhrvjv6k3xufubo4wcujescrlpa5ucfbmora3cvfyv@2mi62ffijnj2>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
 <20240517144607.2595798-6-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240517144607.2595798-6-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, May 17, 2024 at 10:46:07PM GMT, Xuewei Niu wrote:
>The new request is called `IOCTL_VM_SOCKETS_GET_LOCAL_CIDS`. And the old
>one, `IOCTL_VM_SOCKETS_GET_LOCAL_CID` is retained.
>
>For the transport that supports multi-devices:
>
>* `IOCTL_VM_SOCKETS_GET_LOCAL_CID` returns "-1";

What about returning the default CID (lower prio)?

>* `IOCTL_VM_SOCKETS_GET_LOCAL_CIDS` returns a vector of CIDS. The usage 
>is
>shown as following.
>
>```
>struct vsock_local_cids local_cids;
>if ((ret = ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CIDS, &local_cids))) {
>    perror("failed to get cids");
>    exit(1);
>}
>for (i = 0; i<local_cids.nr; i++) {
>    if (i == (local_cids.nr - 1))
>        printf("%u", local_cids.data[i]);
>    else
>        printf("%u,", local_cids.data[i]);
>}
>```
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/net/af_vsock.h          |  7 +++++++
> include/uapi/linux/vm_sockets.h |  8 ++++++++
> net/vmw_vsock/af_vsock.c        | 19 +++++++++++++++++++
> 3 files changed, 34 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 25f7dc3d602d..2febc816e388 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -264,4 +264,11 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+/**** IOCTL ****/
>+/* Type of return value of IOCTL_VM_SOCKETS_GET_LOCAL_CIDS. */
>+struct vsock_local_cids {
>+	int nr;
>+	unsigned int data[MAX_VSOCK_NUM];
>+};
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index 36ca5023293a..01f73fb7af5a 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -195,8 +195,16 @@ struct sockaddr_vm {
>
> #define MAX_VSOCK_NUM 16

Okay, now I see why you need this in the UAPI, but pleace try to follow
other defines.

What about VM_SOCKETS_MAX_DEVS ?

>
>+/* Return actual context id if the transport not support vsock
>+ * multi-devices. Otherwise, return `-1U`.
>+ */
>+
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+/* Only available in transports that support multiple devices. */
>+
>+#define IOCTL_VM_SOCKETS_GET_LOCAL_CIDS     _IOR(7, 0xba, struct vsock_local_cids)
>+
> /* MSG_ZEROCOPY notifications are encoded in the standard error format,
>  * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
>  * kernel source tree for more details.
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 3b34be802bf2..2ea2ff52f15b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2454,6 +2454,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 	u32 __user *p = ptr;
> 	u32 cid = VMADDR_CID_ANY;
> 	int retval = 0;
>+	struct vsock_local_cids local_cids;
>
> 	switch (cmd) {
> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>@@ -2469,6 +2470,24 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 			retval = -EFAULT;
> 		break;
>
>+	case IOCTL_VM_SOCKETS_GET_LOCAL_CIDS:
>+		if (!transport_g2h || !transport_g2h->get_local_cids)
>+			goto fault;
>+
>+		rcu_read_lock();
>+		local_cids.nr = transport_g2h->get_local_cids(local_cids.data);
>+		rcu_read_unlock();
>+
>+		if (local_cids.nr < 0 ||
>+		    copy_to_user(p, &local_cids, sizeof(local_cids)))
>+			goto fault;
>+
>+		break;
>+
>+fault:
>+		retval = -EFAULT;
>+		break;
>+
> 	default:
> 		retval = -ENOIOCTLCMD;
> 	}
>-- 
>2.34.1
>

