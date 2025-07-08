Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648382D9EC9
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971984; cv=none; b=NDe6bt5EnAVxBr36eQ0lgjowbKb6wwXV08fGNOHOTu2kMh1oc41+m9Q6o9EVBNDpqYYqHuQgwdH02mta5iRN2TvbqFjWe/PPUnygC52uuFLQwFrzO3ZPZriX0DL7WdXpn75On3NOSdaGUDo3Os4ts4bcv4G263CaTLol/zr0WBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971984; c=relaxed/simple;
	bh=1un7ouFwyBTSYIMY4zpatIXNYHrEz24iVPhqyQXJbbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iKYJ3659N6uRjnt4NEA7RbEr7/4WHGJtTE2TxGUMcp/rVLDyLLgI/AHcYBW0J7DPiZzBYcy+mqNsjuHT5o1LzEDnpCZ66XggF6uZrWzae6+S4joxeT2sK6SUzXSvWCzU1a+klkKl7FxGP+XLWyPRKccyhfa2J2hZgKoKoxPKauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGyi8GX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGyi8GX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751971981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=315fIenJWHN1D0z1wGXcALO7wPGrPSPVrNC7//PcDEU=;
	b=XGyi8GX/BAF+tOmfHqd+RUxlCdsxzRVbD05HGxZ4kjHqn77OVe3cH1oDFRK3iEp19O6miC
	2iYcWQ5gEJbkXmhZcZg5rxFWU3tGzHXpC+KHzOz5S7HI46bCAzBuyNEOWIDBOcmME0ehI0
	4hpTPjKK1AOxhEM86Axbj1IeOsakvVs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-f36WKUNNO2yQHcfHjkFTMQ-1; Tue, 08 Jul 2025 06:53:00 -0400
X-MC-Unique: f36WKUNNO2yQHcfHjkFTMQ-1
X-Mimecast-MFC-AGG-ID: f36WKUNNO2yQHcfHjkFTMQ_1751971980
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a58f455cdbso56592221cf.3
        for <virtualization@lists.linux.dev>; Tue, 08 Jul 2025 03:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971980; x=1752576780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=315fIenJWHN1D0z1wGXcALO7wPGrPSPVrNC7//PcDEU=;
        b=hTfOyT5pV/Uhf2VezExfXCN4vUg+Phuvh2cdonVuiIuf9JJmGFgBOeKJm7+BCOokar
         c3eVitn1lM+/hQRZRubGo5qMnr5oDTRUf9BQlvJwWUkbJs6sgO1PjOS2/oTugOXpdAZl
         8J0RWwCvOCyFOZIRFBAdbmACnFH1e7jPoevhHAliJwxNhvXYEcJkXAK9Q30aQKBNW/1w
         iFg2BnoHmK67L/evxLShBeKNNWnwvdqbHmYFkoj6xy4Wa1ki7iVEoW8F2MqEYGQnwX8G
         nNZZiAdgM/zatcZch4KIUvzX+TxkkipdLhF4YEvHmZnY9lh7lFANRs/X8Rp5pL0kvBI9
         VNQA==
X-Forwarded-Encrypted: i=1; AJvYcCUzZWFZ7zqa6my5aeq2RklEVff/8ELx7nCh6lhQNGYd7cH3JomlKXWbz9hFCtHL8ilkETVaJ7QgGZiJcVZ0cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF2cqg2GiUOmk9qiZ9//l7TqWmh8DYBOqyRmVOMxlwKt4vVT+x
	HxDtNNYnYe5CdzSemxMokzlIbzC6+stPsyM6PkRGQBselgCRNhPvlnD+gU6MCT025hP6jAT8UEg
	dJyHmzLn0nyyTSardPjGMk9jjfmS3HuXK5mDcWTaKzLYqEMxTxtbb8O/s8pUQ2F4trvfY
X-Gm-Gg: ASbGncvEkmx8LO2SvwghIuFFrLHZ5ezh6zGQS4v0F8z5uWEjCCBM8BVqxJgYFDVfunG
	YQYYD7Ed1Q1EaUa8sk/MqYE+oSN8BuYF2zD8WKxAv9oQ1P+SPwbDgu1UBaOG2XwRZbY7re5dwYj
	xQ4ENborQyCASsbPeULUccKsP/yQEXFSAeVMRD7huvZkse5WjpzelrlZVkQVWT+ipDaIqYoPgKs
	OrUO27pD0z2I+eFG1P5wowNzwPmj2ltENSdg+krYa9YB/R3jriw/wu1rq6A/LsLhxOaMZ9pHYD/
	u1MoC0v3UEG7cWD0O8VlrG7GUYAq
X-Received: by 2002:ac8:7f95:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ae5afc23mr175966971cf.47.1751971979602;
        Tue, 08 Jul 2025 03:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvc7u8j+WEd/fQJxoq873TigcJMGy49ozcWVyaqRVCjfg4qBqi9tMZtBOChGJAAMzAMDFrQ==
X-Received: by 2002:ac8:7f95:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ae5afc23mr175966551cf.47.1751971979134;
        Tue, 08 Jul 2025 03:52:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994aa85edsm77449631cf.74.2025.07.08.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:52:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:52:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Message-ID: <lh5vti5lmcxddhnfsz5pjhu7oepcbxcflqkyhlpwnwqzbe7tku@yw7bwfgafcby>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _rSerVU07QGofQrSimCwjDU6l99LJwy-HJRl0Cau-vw_1751971980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 08, 2025 at 02:36:12PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
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
>
>-- 
>2.34.1
>

