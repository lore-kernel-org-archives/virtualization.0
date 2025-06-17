Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FF194124
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171176; cv=none; b=gOV33o7+jnn23T4FREMpFzUCkRs9jAvyoLKoj6M+Ntt10ZfQWx7iex7tRRm3ScbXHHRPRrrQ4j7pUchxB//d8aeYSM2sW8sPO/7VM+EyAGQMOwxUM+HqeTUBN3Y84TCnCyqbh1yrSurr4m2JJpIe1BBz7J6oHr/P1Lo9nzAwFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171176; c=relaxed/simple;
	bh=P0TmBh/SuinKvkwSU9wHk7cmF2i1xnwgWli/nKJV0Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M/UGy3HkbzuV1ejq+GpgGve8BpJeclPmKYCbRjm9I192MF8tO17+t1X//9OaVrowJF/sM0OTh+9Vz3NvUwgMCrrRViw4OLUZsbfWSa8R6uqaJ410kojSyXsvg9zw73iGfK+Xo8DNHqm+Tk91dMTCtvnrpSiy0GVEGDDEF3qLgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd0L0RU9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd0L0RU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750171174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPUJBR9Qf9kVxYZQYZ6+G9JwWB7GoNLWWQDEXWeJq2c=;
	b=Dd0L0RU9WSfnIGyKWY/8gz92slapCugP0zHXjwsN+Gpg2aSkiHPJvJ/jtwoPWjDjGJ4MT5
	hL4gCzj4PCbyYNJcPiH+72TYVX0PwCFncQ7rWWirghFB+qDzrpXaX+ZP0HySmI2nygoY+/
	BhfHJauwIR023Slt4qoiMC1jR0eRevQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-OXrFCuhWM7CjtEXS03Kndg-1; Tue, 17 Jun 2025 10:39:32 -0400
X-MC-Unique: OXrFCuhWM7CjtEXS03Kndg-1
X-Mimecast-MFC-AGG-ID: OXrFCuhWM7CjtEXS03Kndg_1750171172
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451dda846a0so45355845e9.2
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 07:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171172; x=1750775972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPUJBR9Qf9kVxYZQYZ6+G9JwWB7GoNLWWQDEXWeJq2c=;
        b=YcMVes2qn6dZ+BbQnF6rJx+usrv7ZJkxDSZ7KHKJXH9odL5HJ9L5VBHxipkeCV8nEb
         Iq7fokgcdgowRDXLThgCYWIi0WnF7mYUDLfRjgcnCIJI9UMzy/uWfUq/LHgskrMWuIzY
         WDn0hBu03IVjc5IBFE9bMsXPQgWkMWQwCqNq5isHt+nn3hnJSGwmqVPg7cKs5fNkGTYB
         HRg64PNzEebtZ/0vj5lYoJdHrwTknR1I3rMM/gku84cDTtS4T0AuH9+S8OMezuk5A62m
         kh5E6YEq0G7cOkL0XHTOKDHkKX2jjseh8vn8XimLWLaFRpLEmmZ9xeCmsaMygdgkyOV1
         +9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV9zGKPYsUSK6cVxOuelAPBAwKzTH1OxX9AYrN/DrOtvo3/Kvfg0FwWzTqoVB76jnMJCUo9RsVMRUZ3AbAXQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP7Zarv9duOmczwisex6CIOzX7Yw5SD/AFy/J4wmZM/3/rzHc2
	bfcKsUbcKM1iGolNjrGRhvgYyyrgcblTYfzjQGOE3lGqjCbMSuFc7A1ht9TLZSqxiefpQ9PND8g
	dAs7vBaY8RKBSe6sWKp+WSQmv7rX+HdnGvpiuAZOX6Y6zGzb2ROIXe4//EmENJGUDnwZx
X-Gm-Gg: ASbGncviV38VAHWo5VrXPFIogBAssdFbfg91jWlzci07vRKj99KN6iOPLBLHk6TR7v7
	NrBq4zCjFCtqoMg+FcM2A6FvkTMznC61QqX/3Co5DhdvMhivLLGk7bWT9I+BxuwF7cdjsOWkiU6
	FERO2a9YshHAHcRC/O+CK21GtN+49LE19J7ujXUZ7+s+CuJ1dglf2KWYtvXHyZ1XDFkR3JlRA9T
	CL8a+OB4HbUGNafvzgJkJ7Mtu4CEdvm0c982ZW17zBkyx6LnegZmsALYWp7ln8/fXYLJYQyQt3e
	fyscF7IREJoJWQJOMfJkdzvNinEX
X-Received: by 2002:a05:600d:13:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-45344d8f6d6mr71096335e9.32.1750171171560;
        Tue, 17 Jun 2025 07:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNxFUr/RsjSCEdxIvQ1nYZxg2/GHtiJcbK0+y2FBpHGRW3fR6k2TfEm1PQ2vYeyp/yl4Cmrg==
X-Received: by 2002:a05:600d:13:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-45344d8f6d6mr71095955e9.32.1750171171029;
        Tue, 17 Jun 2025 07:39:31 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e241b70sm175740145e9.18.2025.06.17.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:39:30 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:39:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -0s8U10gN6h1gmSjAcC-H-e-7l6_0pV0wntcNFlyr30_1750171172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

CCin hyper-v maintainers and list since I have a question about hyperv 
transport.

On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..bae6b89bb5fb 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsock_stream_has_data(vsk);

Now looks better to me, I just checked transports: vmci and virtio/vhost 
returns what we want, but for hyperv we have:

	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
	{
		struct hvsock *hvs = vsk->trans;
		s64 ret;

		if (hvs->recv_data_len > 0)
			return 1;

@Hyper-v maintainers: do you know why we don't return `recv_data_len`?
Do you think we can do that to support this new feature?

Thanks,
Stefano

>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>-- 
>2.34.1
>

