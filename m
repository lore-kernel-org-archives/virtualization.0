Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA9191F8E
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615437; cv=none; b=BJ+c4Ro3QVDWRuF8O+gWpyuQKgYgW0gPGYnDi8mlqzsy5zcywpjjYqVIzfaUvxoXJdu/lW8qKDU4BtS6yqlPsiKurYKbFnfKo/HHoLGI1U2jGxWDocU0JM65MgiRHufPtPn5tUciv9I9DBLY3smCsrutX2i0rBTXUECfleqJuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615437; c=relaxed/simple;
	bh=43DDJK4SeQY7M8v3PtNKvgwHxdoCohqLSGhU/xmdabo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=URkozw9v88mtisKi+5FkesjPP++lE1kr4ZKoxGlOcL4WMdOVFVeI4XGUaVC2XSbvDWAUGQ8rTsNjVx8RhBxg6eZJYMe/t4mTI+3ZP9vLU5xVbmjzAFnKE/1Pon5enYUfpKtYQYbQl56R4Y0YCfa+OCkyEv9EGf3USRc5FSK2+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiM4/0qg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiM4/0qg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720615435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/9lippDLEXmtWgWziQzdujSsOrakrUjnFWOu2HZ5zc=;
	b=DiM4/0qggXba+56ZPlmcdU+bfyzX3YC/hSfFcs/IXO57yoTw+c8knJZxN7RtJhqO4MPq/y
	9/gwofdusvxKysTnkCggn3INBxEyWG+eg7biwcF7ACwuln6vh+vVX7lDBMvcB4ZVdFi0yl
	sJoVe6BZs833OjGybjjUxlsF1Iyl8ks=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-E-5zoNiKO-G_sH5J8fySrw-1; Wed, 10 Jul 2024 08:43:53 -0400
X-MC-Unique: E-5zoNiKO-G_sH5J8fySrw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57c93227bbeso6014906a12.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720615432; x=1721220232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/9lippDLEXmtWgWziQzdujSsOrakrUjnFWOu2HZ5zc=;
        b=n+CNeuV2IpUmNf3EKKK4kywoaaiHKm3tx3vUKpjnnd6muBOjaNkvEGSEbcR07i0KIY
         4iilrXU5dXvD62dO8HWfrMzf+fDUA2r/lgIXu7oSVFpwKh8A7qXdPd7WhJbuJOgUrmmZ
         jxJbrbp4CKxjtRCLNdoG6NSaUK2gT5/uR5bo+hilOCQREl6kduQcOypZylQLFm5W0ULS
         EhSBDGbuN9RE50hb5ImAA/I0hG7BliGJ8BtjFCiWy5TAYmn6CFJWPeCCV+XVBTcecsMw
         uEUI3gX/FoZb+GDnGw8b5SupyYuFWtXrh7rMxSIZuo3pA3G11HxBtRkkA/AXadFu8IPv
         72kQ==
X-Gm-Message-State: AOJu0YwVWPO2Ke3u/n67/n0Bxmf98lGs3JfhDVZ1Cfvcq2gkhXs/G6b4
	y6vC8UJyOq12xL7xKpjFuT24iwVmwD1243fokcXEEMVxVoLFEP5PgO+RGibrXQN7PxnTx6HyDda
	Fy8LvOIwFdLnT56FvK+v8oewpV/DHnD7I5XGqKUZhC1Z9hc+eJiS56OyG+LapAf1WfA0k/nMs
X-Received: by 2002:a05:6402:270c:b0:58c:ccc1:17f7 with SMTP id 4fb4d7f45d1cf-594baf87f81mr3887202a12.15.1720615432394;
        Wed, 10 Jul 2024 05:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGizrLSJI1qs8JqxXWm1KqqiwDtq78ZjQ4fIt6a38oE7t7gbjWggSz07taF+RS8p94KE7RgCw==
X-Received: by 2002:a05:6402:270c:b0:58c:ccc1:17f7 with SMTP id 4fb4d7f45d1cf-594baf87f81mr3887184a12.15.1720615431778;
        Wed, 10 Jul 2024 05:43:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cc82sm2177127a12.23.2024.07.10.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:43:50 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:43:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] test/vsock: add install target
Message-ID: <e6oxt6gw36mhv54qbgc2bihcaym2xrquxtsjhyvm2u7wj76nu5@zneaxujp6oei>
References: <20240710122728.45044-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710122728.45044-1-peng.fan@oss.nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 10, 2024 at 08:27:28PM GMT, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Add install target for vsock to make Yocto easy to install the images.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---

LGTM! This is a net-next material, so next time better to specify it 
(e.g. [PATCH net-next]).

If not queued within a week, please resend specifying net-next.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>V2:
> Use VSOCK_INSTALL_PATH, drop INSTALL_PATH
>
> tools/testing/vsock/Makefile | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index a7f56a09ca9f..6e0b4e95e230 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -13,3 +13,16 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-p
> clean:
> 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
> -include *.d
>+
>+VSOCK_INSTALL_PATH ?=
>+
>+install: all
>+ifdef VSOCK_INSTALL_PATH
>+	mkdir -p $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_test $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_perf $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_diag_test $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_uring_test $(VSOCK_INSTALL_PATH)
>+else
>+	$(error Error: set VSOCK_INSTALL_PATH to use install)
>+endif
>-- 
>2.37.1
>

