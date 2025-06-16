Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432811BC3F
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084933; cv=none; b=rQbaK86H/0IEkIpjSQj4ll5QplfUUnkEASb2iOrYaQthLzrs3eZe8UqP1LJBvC/AuFzRyGTSYI2oLdBxZNRMijrge+g9EQTmI8vbTsQo9vk+yDOZG2N79fyyJDO9oqcjD5R0sqzGXXc0JrQAl9WlGHzbP32AiPM2S1xLKYhXBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084933; c=relaxed/simple;
	bh=pK0+u7cNcOH3UoJCPFzMHWZ+PCQvSBPMj8pEU5KTMIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bIdd4CkTaNz3zdt/Xya3T1cM6NWhHEWHyUZpBR/avM8/dsUPZX8vobeLGKeGtNsv5Zfg5+9E8arUU1W+28SMAmlIh+X+JCi7w5qag8zOSJset5ZJwb/V8OyaOcaIiaL7OfyLx4IPkVhMxXVud+Aw8BxEmyZYjMfdOMcp5/7Oxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNAohZUj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNAohZUj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso3402327b3a.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084932; x=1750689732; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv34W5VjxfJqW+QLhtik14kbds+hW6UbOSuF3KILzuY=;
        b=mNAohZUj08nnIEYLwMqOM814m1MgLC9eaZh87UIMo8fU8+T9NW0+WSHILF6tyIl0tD
         8pWKM6OpHe0OLW5QohwO9nQ0wR8+rUgue+b6vsTx60ZZOjcyHj4Y+JbX2WbkYhJBSKUG
         3JuzcWuAGaqYPPQVpn59DQKyrIhyx5V8uxyGMtiawz1PJ/4zXVzCGvnC+cy9EIvJmiTs
         tkc1H4DAnHFjsGHJ9QlcKn0uJSOUbkhUR6QG8fjfAD9OPAeerXsKgBkDG/7PzdkK9nbS
         MTnBM7Z5iRqLY1BiscmKe+5dlh2IpFLhdcAorPJzwJSU1tH9m7qKaeUlUmm5HraklH4+
         tVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084932; x=1750689732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv34W5VjxfJqW+QLhtik14kbds+hW6UbOSuF3KILzuY=;
        b=Mqfnd9VMG2ba2ELqu++Hv1ckS3IDN/vpkXUs0LBLFEDxjz5VitI25I3ccL3tNcD6D/
         NLKrYK9mE+3Nal/fMItYiIwRv+Mir0YuXKZp4iaYVFvIiRvlCv9juMugRNCmVklIobNZ
         ZZUGx9lVBFf2zuMNyqZZQDTiVhp8qzduDkbDdg71FV2ykEN0tDNwfbncoPTkMvzyfaLD
         5Z/k+x44rwDYamTXcN/WRA0wliEwZiHzpI+oBvdZI39YOOZVdKQq1pCmPFz6g83dySfU
         ohJfaPyKdxqNfdYObSTuwbEb3IfS/fCSEkBKAsA8AAoTm5gd8ObPvWIm5DAhXN2bWYGa
         DfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIdahqga69NHBRmmbktyw8O993MKlYDxqmNJKeo3nXgSPDDfuw8kKS1mlTVqG27AAhZ9HUuOqE23gFNjd1eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznL+5v4Jj7Ew6oChvbAQV36yxRU/uSmkaAHD+D8hs6Tr8SaVAK
	gCjzNFvrqDGYw72vugMsErGVRLwXDPYLVlLw9gNd7sfnc6KZsjLJ9IPHIUt48AfAAoh0u+Pb
X-Gm-Gg: ASbGncsRD7VF9t8Z2szUMar0G7qHtOeiqIRoz7PSVg7wQYe4mmfAwH8pY999XWx1jRN
	vJpY7PgeIb26oWc5d7bcbspy2i+nusv41OzfrMtupXO4O5UkUbM6z1A1AoRPQSiPWzH96VGsD/a
	wGJ0JjtHUlSnLHZ1sOUPcXG/wYInuFi2wRmsQqMq6kk0MBmdANg4bhs9ukf5dRTfhHEwo+yHsFG
	1Zrn8Bo2k/EzLZPYoZrLwdx4gXZzHpA9jXLGFkVdx1afX1jUcLaIhkoba7Sa4iI5W0aXfQBrfa0
	AGE78nlQoeKl2glnbZCWcoCqfZEWgOjzpXqUhKrggiSjWfp778XfZoE3qIPvvYE78Qt7wNRqugX
	NZflulwJI
X-Google-Smtp-Source: AGHT+IHEPg4+O4ApNZgch6q2sKZcGIKUpH2RyzdU/+t4+DW38f/ZmE8sPSN34Sk/ocqhx4evU3kalg==
X-Received: by 2002:a05:6a00:398b:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7489ce012bdmr12266799b3a.5.1750084931399;
        Mon, 16 Jun 2025 07:42:11 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b374csm7104331b3a.137.2025.06.16.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:42:11 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: leonardi@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v2 1/3] vsock: Add support for SIOCINQ ioctl
Date: Mon, 16 Jun 2025 22:42:00 +0800
Message-Id: <20250616144200.1187793-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <mrib74zhrw47v4juifp67phnm6tffb7qgfm3xmtcuw5maminlv@4i7z36hg3554>
References: <mrib74zhrw47v4juifp67phnm6tffb7qgfm3xmtcuw5maminlv@4i7z36hg3554>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, Jun 16, 2025 at 03:42:53PM +0200, Luigi Leonardi wrote:
> >On Fri, Jun 13, 2025 at 11:11:50AM +0800, Xuewei Niu wrote:
> >>This patch adds support for SIOCINQ ioctl, which returns the number of
> >>bytes unread in the socket.
> >>
> >>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >>---
> >>include/net/af_vsock.h   |  2 ++
> >>net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> >>2 files changed, 24 insertions(+)
> >>
> >>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >>index d56e6e135158..723a886253ba 100644
> >>--- a/include/net/af_vsock.h
> >>+++ b/include/net/af_vsock.h
> >>@@ -171,6 +171,8 @@ struct vsock_transport {
> >>
> >>	/* SIOCOUTQ ioctl */
> >>	ssize_t (*unsent_bytes)(struct vsock_sock *vsk);
> >>+	/* SIOCINQ ioctl */
> >>+	ssize_t (*unread_bytes)(struct vsock_sock *vsk);
> >>
> >>	/* Shutdown. */
> >>	int (*shutdown)(struct vsock_sock *, int);
> >>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >>index 2e7a3034e965..466b1ebadbbc 100644
> >>--- a/net/vmw_vsock/af_vsock.c
> >>+++ b/net/vmw_vsock/af_vsock.c
> >>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> >>	vsk = vsock_sk(sk);
> >>
> >>	switch (cmd) {
> >>+	case SIOCINQ: {
> >>+		ssize_t n_bytes;
> >>+
> >>+		if (!vsk->transport || !vsk->transport->unread_bytes) {
> >>+			ret = -EOPNOTSUPP;
> >>+			break;
> >>+		}
> >>+
> >>+		if (sock_type_connectible(sk->sk_type) &&
> >>+		    sk->sk_state == TCP_LISTEN) {
> >>+			ret = -EINVAL;
> >>+			break;
> >>+		}
> >>+
> >>+		n_bytes = vsk->transport->unread_bytes(vsk);
> >>+		if (n_bytes < 0) {
> >>+			ret = n_bytes;
> >>+			break;
> >>+		}
> >>+		ret = put_user(n_bytes, arg);
> >>+		break;
> >>+	}
> >>	case SIOCOUTQ: {
> >>		ssize_t n_bytes;
> >>
> >>-- 
> >>2.34.1
> >>
> >
> >Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
> 
> Stefano is totally right, reusing `virtio_transport_unread_bytes` is a 
> good idea.
> 
> nit: commit message should use 'imperative' language [1]. "This patch 
> adds" should be avoided.
> 
> Sorry for the confusion.
> 
> Thanks,
> Luigi
> 
> [1]https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Thanks for pointing out. I'll update the commit message following the
guidelines.

Thanks,
Xuewei
