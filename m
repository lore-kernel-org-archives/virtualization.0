Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE1322A
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082048; cv=none; b=q2MJGkvL6ZADBANnt8cHAZN6njr/4RumkPi36gfHrOyb4tsv735jPWgRak2gQFDDXFxdX5ronItqp52/t+rxRTtRtMBGaFQiHFTU15ndibtIRYkQKXCesFofP+YtYwXhdyNI4s+LcFmTf4hJdMWt4+zshgwMXbN+ongjCB0jxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082048; c=relaxed/simple;
	bh=ALufLifN8ET5GUUo9VdmBMb2kiTd+JEXg3vJP9CcLJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uwM55N7czeftb9AgU9iHtDq34n+crvgxePxdBB0P0yoSEzHqthsQmgimY6wYeSXKoPfs2rV4pJYr8f263Bp64SKcHhZDbYLMYlBLMQ4lHknXcNA2XhzxXBRRSC5JlvQUw6XU77XQsUkSk3Uk3daayk6n646QM6jgOD003ZM6ECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKsPWt/a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKsPWt/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750082046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXRSgHsBoykaoCkGaODkCk80Pz+wKzFt/0k3tccKi30=;
	b=SKsPWt/auj94o3oxociEKTbn3gyiqW6mIYADHOlH/C0fFTvvFQkZcCS05YkwAP5egfpy5E
	eZH2/uCV13bZ35J1WHzpHrrzhTSr0VMeNkc/VZJL2+v5c7qn3+PjoVHdqSjQB6/j4J1+8a
	er05MbLCm1RFQ/1ocpWWQFcBdxht4NU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-lCs63DgwNbKBLVCoW3Cm8w-1; Mon, 16 Jun 2025 09:54:02 -0400
X-MC-Unique: lCs63DgwNbKBLVCoW3Cm8w-1
X-Mimecast-MFC-AGG-ID: lCs63DgwNbKBLVCoW3Cm8w_1750082041
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso2180848f8f.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 06:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082041; x=1750686841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXRSgHsBoykaoCkGaODkCk80Pz+wKzFt/0k3tccKi30=;
        b=hrjD62whacYB2/OfKBqJqWfvKX+OaCxnHp8BW0CAjsD0cxBBgQOLIT2Ka101QbqRyv
         qWog4eDpx4aZcyO2V9NWj+yZWwLPv8yNgKftEvo0m9cVLheLYXj+6ao8qaKfb7SYuiPQ
         tZgola/5YwlUUWF4x2vLp9Pi27SOZu+WmRNb+Lg+OtsUQwLJSGW/wF42oEXVDHURRPIn
         U1ps0UX2B3SHSLBo19F9xAfv0/vItIViJ4uHmbtA6BjbBTlvpEikNUdIMfCbH1uiQ1Sd
         FSFm31p00wYcShum7O+WN1SvHTLvei23iSo2G5wD7l85qK9+X7m3lhFqgmelQSW06eiq
         AYiw==
X-Forwarded-Encrypted: i=1; AJvYcCV6NO56GNJf5VGS1WPqAP6PRASa2MaOy3dFoBlJUDnrY/nM3ZJni7S1KcAD/4EX0M1m6tHG+O+XfTOTibV4SA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzvoyno7+RF6Pr+CrOe9j1kiJaj+H5gIQsvxuq538nZTHuPqF4J
	rzFfdheFmZdVdllmOXfBprv5748lJSJlAVULPPR9gTu9fhClGxuhegNXWukViOV7j3xL3x6KA8P
	y17gdMAz2PctpfSFW4mqwf1RcwDFwH2A+O7qveAVWxxO0U3GvT/+Xk3gbtxFSBWQ+zZy4
X-Gm-Gg: ASbGncuAwyrNGWuoUapQRsafk04K2mkzIkk4DHcgLG9LkLnPDgGLMCkijPUdYPjHu1r
	jTTiosmwlOVdAgXMTdIXF1AvPhRjogEEvMkSoxzD3mGOTyU5S0omgFhV0rVRvUYOnYD+NWppt9w
	YxiDOnETuP56z7dRRfQt/8xIYbYyysjJEBTQEjkwoPE1pl5/DoVBkIGAdEdK9Ih6l8X9J5PIOLR
	o7mm4db6Nq+XlIYwbRapkReZ3+mCLywSJJI/dAzJwhTC/QLwTi8CCVny+eSoqLQgI26BXy+lWZf
	hrasS7UtkN8X7Iyj95NHqTjgiH4=
X-Received: by 2002:a5d:5f8d:0:b0:3a4:fa6a:9174 with SMTP id ffacd0b85a97d-3a5723a36b1mr7744976f8f.33.1750082041412;
        Mon, 16 Jun 2025 06:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9KK52CE4TM7xQev5LOLheuW7Ek08zbqpia8Xus0jUc0uv2rsRw4izzQxnWbncAFqkbNkuqg==
X-Received: by 2002:a5d:5f8d:0:b0:3a4:fa6a:9174 with SMTP id ffacd0b85a97d-3a5723a36b1mr7744946f8f.33.1750082040864;
        Mon, 16 Jun 2025 06:54:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.202.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b403b4sm10933571f8f.80.2025.06.16.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:00 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:53:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <xshb6hrotqilacvkemcraz3xdqcdhuxp3co6u3jz3heea3sxfi@eeys5zdpcfxb>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
 <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ldU3zLnqdFy4DICOCVsqodoUCVzuWMVYuxiJ0pKiIc_1750082041
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
>This patch adds support for SIOCINQ ioctl, which returns the number of
>bytes unread in the socket.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 2 files changed, 24 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d56e6e135158..723a886253ba 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -171,6 +171,8 @@ struct vsock_transport {
>
> 	/* SIOCOUTQ ioctl */
> 	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
>+	/* SIOCINQ ioctl */
>+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);

Instead of adding a new callback, can we just use 
`vsock_stream_has_data()` ?

Maybe adjusting it or changing something in the transports, but for 
virtio-vsock, it seems to me it does exactly what the new 
`virtio_transport_unread_bytes()` does, right?

Thanks,
Stefano

>
> 	/* Shutdown. */
> 	int (*shutdown)(struct vsock_sock *, int);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..466b1ebadbbc 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport || !vsk->transport->unread_bytes) {
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
>+		n_bytes = vsk->transport->unread_bytes(vsk);
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

