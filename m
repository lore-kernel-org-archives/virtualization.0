Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156F285C86
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081384; cv=none; b=LOfANYirVvLQQH0rpJydyTSwXF2taXTynwzikFHkRnDRRL7Fg0Z3e2+knN1+xI9mPYQgdEQRoYdgWzgEA0pSTvVgLsETw23Hei9GZmEZO1kjpeQcLl3xSO3BxHTxQme6tMtT+aqp7J+ZhZl89CjAGGk9Hl31udAMBRh16xyJJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081384; c=relaxed/simple;
	bh=VnrsqW0cFhf4bv6MzZGMbjFwbnVzVssH5gqIsZDw+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tDh7CVRGdqR0d9od496ZavjPuJsaFp/VhakxaD2wCIYKUlUCcbLwWexTT7gKlgIQSsVtNbPJxMeQfI9Vff67FMPsqzhL21aRckPygyW3NU9gNn0Sws+vR8Gt7Mc9f46B4yl15meLH6jpGHtsoY7M1p4mo20wOMZDb+TLs3J3OuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0GsoDLU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0GsoDLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750081378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYooHu95agsZ2B7UMKycranS7g+0oNMg2oTlfmTsJ8A=;
	b=K0GsoDLUDVgGX3b2oKbs+xemBFwKPLBp7FWkp201YGUkLKAnkydz+9hQSgwbl8StSoxi0/
	QH+DshQzdxsb1IAjno7ILO1Mn6pAFqq+hfGHy680NnZkyDDUZjkYuMFH+gvSbM2RJLto2k
	xXh8nqBW/GWGildMDZwyEBb5K2j8Gsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-pG9Afrl6MYmFW-TpobVMxg-1; Mon, 16 Jun 2025 09:42:57 -0400
X-MC-Unique: pG9Afrl6MYmFW-TpobVMxg-1
X-Mimecast-MFC-AGG-ID: pG9Afrl6MYmFW-TpobVMxg_1750081376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451deff247cso28087745e9.1
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750081376; x=1750686176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYooHu95agsZ2B7UMKycranS7g+0oNMg2oTlfmTsJ8A=;
        b=aUHDLGv+3uO3Hr5A5e+Mms6sN1eQWDAPnTqPVu7R8sBcrb9PCpjB1O5jNjiMNR/ZNj
         SmaM2vWbDfre0L6ywxsIj6rgGK07Q4Zm/3AXTaiRP5WO1qVL15oTTKw4eXd503KzTiZw
         CDatFxsC+kPNl3iBBkmnM6iz4B7R6qhejf6YDUGtETadWSE4DSmurkg9nSoe0mNoewis
         +Z7t6G/5LcTxp9BEGNyC/bpwqMp3xUHBokR/4h0VSQ5bjbAsZi+NarhdHhF3+1BbJRhO
         iKAAdhE9kd+M/AUMfYJJOgXVJWdFrmUTR+JQXnOlEPTv97et8qCP2XGvAO7qtjl7SALe
         eWng==
X-Forwarded-Encrypted: i=1; AJvYcCWOHXrgsoonNvSSFW74NHEI7ZYwJgbRzufOK0mX/k0Iu5Pa06ur5j7w1Yn+2ULUrCL2OQ33WL85JCBjHfOZzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXodL63YA0971SiE8jViC6VsjVZC8LGSpa7snIu/j7F69HdtPu
	7Nh3j4blfq7BkgkePicNiLdnC2ngfk7Bca83b90NGpSzlOXWeIUHTI1FQOKb17o/IvVovOandlO
	WV7c0g4xfhMr65elGyXz1ed9ApPNtOL3eRUXWXfbQVkeO18pp2i2u+vZtlix8zrT1CTCm
X-Gm-Gg: ASbGnct3nbQqJSBeCuvciWLqO7Ci2H/ca2UnFq6+LWxQ/XrJHbJ6jyYymFj0FuIHgcz
	Ro5ewv0lXjK4Q7iweM5E7A2WPkZDWU/THpf0t+QegEocUXTrRLD9doECpTgycUVtv9pYRJVv4D5
	kFJVGnm95Kx8hopNQmSJRVKDQRPqMOSyxzhOYZNIzqRGFEAc3bYdOOXZiStS31L/Whwjp0fjRI/
	VtFvKF5gyMZ3tGSxuPGy57l66OgFLgdgeyY6UfOdQQQLZ7leq4K6x+sPkOLi41VyFvJh28Rmczf
	17+mhFM3m1+P8hyW/c00pi/woWA=
X-Received: by 2002:a05:600d:d:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-45345f19d92mr48060935e9.14.1750081376138;
        Mon, 16 Jun 2025 06:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9QG30mvjeJ1Ut+tifvz1DPhVeIM1Fgs5sS6gUqPYjMUgSgqJf6605Ua8bVmyMnHzNApbnvg==
X-Received: by 2002:a05:600d:d:b0:453:45f1:9c96 with SMTP id 5b1f17b1804b1-45345f19d92mr48060675e9.14.1750081375726;
        Mon, 16 Jun 2025 06:42:55 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1b1asm148612515e9.14.2025.06.16.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:42:55 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:42:53 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, pabeni@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	netdev@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <2bsvomi4vmkfn3w6ej4x3lafueergftigs32gdn7letgroffsf@huncf2veibjy>
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
X-Mimecast-MFC-PROC-ID: vU0aWA9ixWRmdmiK8Flf_KxAz3cop-TJag8T0eI_OkE_1750081376
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

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

