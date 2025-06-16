Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49041FE474
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084243; cv=none; b=EnCCHcKbwh0WD5/2okBhRJOR5BjY5b1hiZYWZHJcucS8X9ETQN6MbINvgFTlwrjB6XSEz5K+LCzPqTNX2AU5jYqPj12xMgwOSTiKYny0Es4CytjzM1cl2IamVZTY0A/NluH/qhr7VU5k5JKWedkm8aJnC87hvMrgv8S/vmenfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084243; c=relaxed/simple;
	bh=cBkQGq+aQh2WGhSROw87npSAa+GCGQe8VqIRgDN9+3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OOgZfaBOzZUW94DxylZZ6odmBlIwd5e2wOTnTkxQTdNXDMZv/P1Pz4A9GM2YjmAeX773osHzoEVVSiN2tzmZlvL6Gy28SWet46na3VhD5zpeqLJA+0laQ8XBr9zuZvdKb7OhLDgqulzYoadS+RiZxaPGEoBfCPBDUC1xckmMSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4hfXkHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4hfXkHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750084240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b122cq18cIxKAeDyocwvAGBr6eAjHnsn2f9gGHRU4ls=;
	b=F4hfXkHnVDbTjLCqeAmrIyVFBdh2NOs2lOXBEg4ViYeuys7qTAdos+sJfd34RKO5uJLKVw
	6IiS2YJBigmnjuXUGNFRhYaWRDP1+4pxe9h5K0pCTXKCktbXO/2ur5s5RjKiSEM5OJtoMX
	x7mQaGR1F5mODCEHdYEQiLrlER1IwKU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-MF0bXNI1NQaYp2fEQPhsbg-1; Mon, 16 Jun 2025 10:30:37 -0400
X-MC-Unique: MF0bXNI1NQaYp2fEQPhsbg-1
X-Mimecast-MFC-AGG-ID: MF0bXNI1NQaYp2fEQPhsbg_1750084236
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so38218685e9.1
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 07:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084236; x=1750689036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b122cq18cIxKAeDyocwvAGBr6eAjHnsn2f9gGHRU4ls=;
        b=pFuKZ4geJx72alMYQ4Z20sST/sWDF/eSygn6pJXCtusU3nB05R6pwUQV/F6X3F1vOd
         G64ru/U4MkYZEwNrTIGBTz88QpBMRA5u5lCGi0kvWszYNiFhz7lQUYFlUeP5UCxnPRJP
         QkF1T7cdiD7nQ1Amzk929rGsExlOa0DC4rhI82681OsqLJAeAGAg6hcQOnFxj+m182ZI
         Plx6c6tzXDFJuUvhBMtmzzyi1KGbntpZAroyEH3BLeJZ6XFScj3yQvtb72Un1XmeolnA
         /2RLhogLVq2HVacN+F2j0EErbR/iSzwOpFqArZaVtQFH6y1moonG6aOsfMqMpnve8K69
         l9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCI4Za2GbNCyvk3yW60H2gakeqSHE+vv8HslPCsW1Z4OCHX/hHbywNCjRENKvQeUInCUAagynO5MJCF0nUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvtlRSewxVt2RV58GdQeEZTWU/NgP50Y9qBfgw6RfLXR2x7Jsj
	hRp3WcO+ujUW5d+wNY8JGsCiqZAx+cBMd/oyhnhX7YW6p22bFe0dbIG2yS7N0DBU1HSyCt8K/by
	lNMYTKlxgY96iEUe2FvvqRpwAgPQz0rnrpO6DXxNJQB7zM5MeR5W0ewowWTYgfa3gMbnZ
X-Gm-Gg: ASbGnct0rwlum6jyRoU0gqdCKMp+I+TeZwyLT52JK4o2PQp7rf6Jl5FK0VAu5mgXZjY
	A8TzC6o6kBT0iiJEXQ+qXeJj0LeePR8qY2qoTGL46cnjYEWQejPi9mqVk6QaFRcXrZ5j7XarmYe
	fIvpEPlcFMKJviHe85E0Offx29/PBh4LjEhfAhXEsnXvv2uS5sY9JxxcyRnVEWUS6QQq8sNGoAU
	be86psFK+viiYfUgtEiXoCW+il7AlZxATOlCMdz0xXIt+5MyoFWgCHjlPFNxfFRimnb/HMIWnID
	dySpbKnFnmec076MAOn1kch7eqM=
X-Received: by 2002:a05:6000:4211:b0:3a4:dc42:a0ac with SMTP id ffacd0b85a97d-3a572e4b6eemr8077939f8f.49.1750084235901;
        Mon, 16 Jun 2025 07:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsnkYIGAr+qs47yOUuIjHINelBcn/kxEeTN9OXZQ0z3+Yj1yvrInii/mr9eol6osEokceKog==
X-Received: by 2002:a05:6000:4211:b0:3a4:dc42:a0ac with SMTP id ffacd0b85a97d-3a572e4b6eemr8077892f8f.49.1750084235405;
        Mon, 16 Jun 2025 07:30:35 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2371bsm11346666f8f.70.2025.06.16.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:30:35 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:30:32 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, pabeni@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	netdev@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <mrib74zhrw47v4juifp67phnm6tffb7qgfm3xmtcuw5maminlv@4i7z36hg3554>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
 <20250613031152.1076725-2-niuxuewei.nxw@antgroup.com>
 <2bsvomi4vmkfn3w6ej4x3lafueergftigs32gdn7letgroffsf@huncf2veibjy>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2bsvomi4vmkfn3w6ej4x3lafueergftigs32gdn7letgroffsf@huncf2veibjy>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BfczSDI0sPa2OfhpQoCo2ZnozIr9rly2adUZOPt0N_M_1750084236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 16, 2025 at 03:42:53PM +0200, Luigi Leonardi wrote:
>On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
>>This patch adds support for SIOCINQ ioctl, which returns the number of
>>bytes unread in the socket.
>>
>>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>>---
>>include/net/af_vsock.h   |  2 ++
>>net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
>>2 files changed, 24 insertions(+)
>>
>>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>index d56e6e135158..723a886253ba 100644
>>--- a/include/net/af_vsock.h
>>+++ b/include/net/af_vsock.h
>>@@ -171,6 +171,8 @@ struct vsock_transport {
>>
>>	/* SIOCOUTQ ioctl */
>>	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
>>+	/* SIOCINQ ioctl */
>>+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);
>>
>>	/* Shutdown. */
>>	int (*shutdown)(struct vsock_sock *, int);
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 2e7a3034e965..466b1ebadbbc 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>>	vsk = vsock_sk(sk);
>>
>>	switch (cmd) {
>>+	case SIOCINQ: {
>>+		ssize_t n_bytes;
>>+
>>+		if (!vsk->transport || !vsk->transport->unread_bytes) {
>>+			ret = -EOPNOTSUPP;
>>+			break;
>>+		}
>>+
>>+		if (sock_type_connectible(sk->sk_type) &&
>>+		    sk->sk_state == TCP_LISTEN) {
>>+			ret = -EINVAL;
>>+			break;
>>+		}
>>+
>>+		n_bytes = vsk->transport->unread_bytes(vsk);
>>+		if (n_bytes < 0) {
>>+			ret = n_bytes;
>>+			break;
>>+		}
>>+		ret = put_user(n_bytes, arg);
>>+		break;
>>+	}
>>	case SIOCOUTQ: {
>>		ssize_t n_bytes;
>>
>>-- 
>>2.34.1
>>
>
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Stefano is totally right, reusing `virtio_transport_unread_bytes` is a 
good idea.

nit: commit message should use 'imperative' language [1]. "This patch 
adds" should be avoided.

Sorry for the confusion.

Thanks,
Luigi

[1]https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

