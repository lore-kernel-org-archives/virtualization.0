Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443C3793C1
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253245; cv=none; b=HTFqX1JZHbPJDSlx1/gPIzlev+3m1pyv3hZsgEeC58hhw95FU2LbhnN5KwD8eYWRu8HlOZG5cViHLSqManjlMFVP439DhgrOVlD4hX9z20s8GyAp569prBe7HMpPjxQkiZDnvcOda4pyvcRPmRBqRLiiWRFz6nPFGJrpdOKYmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253245; c=relaxed/simple;
	bh=PembD3LExuC+fspVh61O0I7G8DlT5QWiK4JovfG/VAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V5OMAu4XRAHTKZdNQ7H+MvFJvF44+zG8xBBQqRMtza7FAbCDzElu4HZ6aqsvxXb4jJukqfmx53a1V011DvN8VNiX2yQ1wuVJIkRc3UqeVeadMd4YfhURbFpU2zrgeBHF7jcR4NSnMEq5HvzyZuPycdK5S3tjV8Cc/IJML4uWy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xd5Tlc9V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd5Tlc9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776253243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJVw6SswfwNiSg/u5NKKpPiwjKwfGIHglemFq4Sz4Hw=;
	b=Xd5Tlc9VLhDmU9HNTYog6+O695ZQ9/DMiPMHitX3T2V5m9SXDPIQSxDhPZlhCapHRY0Z3a
	cKTFEWQULm4gIEAkHqyNTOOHwY1FOreckVbJ3m7oEeZZWWVu11p6ipAScGq0VoMdjg5Eep
	ez90qVOx6vuXCXVx0nTS7jZ0x3Sj6zo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-6O_Xii0eOYyxW-QbKfPjiA-1; Wed, 15 Apr 2026 07:40:42 -0400
X-MC-Unique: 6O_Xii0eOYyxW-QbKfPjiA-1
X-Mimecast-MFC-AGG-ID: 6O_Xii0eOYyxW-QbKfPjiA_1776253239
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483786a09b1so70748845e9.3
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 04:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776253239; x=1776858039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJVw6SswfwNiSg/u5NKKpPiwjKwfGIHglemFq4Sz4Hw=;
        b=YWKmdQIWxp3tNaodQjg+9Zf5FWL+0UztEobdfi/sgo0V39BzlnkkHKVr7Q+BCus3xW
         G4sNDJhfgSyy+qLo3ICyEaQCsB2SEYCZ6Avny3fQEDtAXNQ1zAZuPDacKe+kpYUdS/rp
         JkQCAB2jIJf7RDXc+T20NB65xWV6RbcYDhYrexjNMfuZ/ddFxHFs9kgHrOAHDiglByDO
         eWRXV+oLGNH4b92hULnXhI617q7DYaFPxoTitjO7mdoRZ5v3WAnzSd4GD0CHHCaOZV/Y
         6F5IcKQ7M6AL8YKL1yW46M3kMtmAJ2nJTYWdD77+u9JPCOgwwDTlcebGwtACI8HdVvHl
         J0bA==
X-Forwarded-Encrypted: i=1; AFNElJ+/MaBjQxz10FE8Z60hfiHsvB51ayNZ0Hzc3x/X/u8vqk9Jlabe8N02oHl5+HUzhGXjzA3JiqR3TPWFp8ZUGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJMtFQCsUMzcRh5ASTliNA1In8g8wBkDJPbeP5Tf8U2DtPjdA8
	+L7R2gyr4PHURIbgDZagnsVFWG3G2zaaM2V303h51XFPcdBTKZ+u2sEI+yjbe+cts9E2QkwBn7g
	1E9WYP7L6kNzNfJpEnPNaR9SxmGbAzac2CqXXrAE58sJDTys+84yQIB/GhV4xUc+9v4ry
X-Gm-Gg: AeBDiesCwuyzfuw+uKhvc7nGcAVi+eh3kCTCV4FSA7DFt7rpYf0ga44A8sUkWTZnreE
	Axm0q85TkpolLTYk0EoUeRtf4+bX6OkBkSy3HDXW10rahDLu04pKYq4wktsAskJFLG7Co2zcgrX
	OiJcucxwpamXj0ow+aUm0P085D2hSFRCStBwBuSiXXSEEM58VjgmZEr3Ef4VZM1GieBP99rLKml
	Z/pLGFh52ADQitXQ72MDQUEeNRqWsloGotwf/oKz+bH6igFQo8kDYZojOtgBw0yenOx+eGVeLzw
	1efUcF+xYwHf3N3nn3Rzs2cGGxfzwWETh+DEeEnOC78SPBpgXGu1qAkJRqkvblvJpt81SrbD/Y1
	8j6WbZLQdOoxQru8OAFiBTy3whYORLdnjUOKhVbM6O/GOIPlgA2dMxG5iM6rJv2OA9fEy3Dp6dD
	vtFzgp4g==
X-Received: by 2002:a05:600c:8218:b0:488:a14d:3d81 with SMTP id 5b1f17b1804b1-488d67c7034mr353013475e9.2.1776253238743;
        Wed, 15 Apr 2026 04:40:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8218:b0:488:a14d:3d81 with SMTP id 5b1f17b1804b1-488d67c7034mr353012825e9.2.1776253238219;
        Wed, 15 Apr 2026 04:40:38 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm4762846f8f.20.2026.04.15.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:40:37 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:40:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Message-ID: <ad93HtBWQqz980Ym@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260414-fix_peek-v3-3-e7daead49f83@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ibI_913fgCqz3seXO8bLGrvPbcKQ4BPUumA3pVojrdc_1776253239
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 14, 2026 at 06:10:23PM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the
>`virtio_transport_stream_do_peek()` when computing the number of bytes to
>copy: After a partial read, the peek function didn't take into
>consideration the number of bytes that were already read. So peeking the
>whole buffer would cause an out-of-bounds read, that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.

nit: I think it's better to mention also that we are re-using
test_stream_msg_peek_client() also for this test.

>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 37 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bdb0754965df..ab387a13f0ae 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,38 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
>+	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf_normal, 1, 0, 1);
>+
>+	/* Ask more bytes than available */

nit:	/* Peek with a buffer larger than the remaining data */

>+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek) - 1);
>+
>+	/* Recv rest of the data */

nit:	/* Consume the remaining data */

>+	recv_buf(fd, buf_normal, sizeof(buf_normal) - 1, 0, sizeof(buf_normal) - 1);
>+
>+	/* Compare full peek and normal read. */
>+	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek) - 1)) {
>+		fprintf(stderr, "Full peek data mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2509,6 +2541,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_msg_peek_client,
>+		.run_server = test_stream_peek_after_recv_server,

I left just minor comments, the test LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

