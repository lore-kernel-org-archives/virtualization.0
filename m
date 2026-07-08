Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262942E8C3
	for <virtualization@lists.linux.dev>; Wed,  8 Jul 2026 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508396; cv=none; b=X65LKDnU2QcMZ+a1xbI46JQlpfPMuucYHGrAQ6UkJzplNEIxSkDBNdF87AtLODS8iof//IzZRKja5rAuDWT66nM+MUmxCf2QIeP7rjFtGpEPxhXoXJROMcHdYSdutz4DX6PRQjrTkYfkdepkkjIg1YCq/fm6FRsL6IhcCegneyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508396; c=relaxed/simple;
	bh=Wxh1h5TWAdT1dv/JQYXllO6752pAMRojLLF30bzxwcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dpxQ6XNDfO/9Pqp3ywzCH0USQqOkaQUEGMDmx0l42moXTPOta6o8IeYyuugRSPRk6HwbbG+yQBRP3jHPH0ETixLWJJ7NQdBc2XvPQod9VrszXGzGWeGUzPgdwMPn4plbTlBKw7r9nn7MADdmiVYPKEqDiST3DrT/IHDhTYcO9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSIgkP4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSIgkP4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
	b=fSIgkP4aB8vRI30T8/D1IVgLDQMg6UJqNGmESanK4fH0qws8UEKVIfwGBMmTBnmHqstjvg
	GJz/YUzukx5WzVeKEEVnQxjmjelT5/6q38jJ3UB91pbDQ0jdT0GuIvTBQJKj02Em0H+e/I
	4XpsKnuzjanPWBwPABMAXzyQZmtZfUA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Ku5YcqbMMTeXlsEJzq1PIw-1; Wed, 08 Jul 2026 06:59:46 -0400
X-MC-Unique: Ku5YcqbMMTeXlsEJzq1PIw-1
X-Mimecast-MFC-AGG-ID: Ku5YcqbMMTeXlsEJzq1PIw_1783508385
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473bc66c837so874319f8f.0
        for <virtualization@lists.linux.dev>; Wed, 08 Jul 2026 03:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508385; x=1784113185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
        b=gY/0YO0kVC0lguGSAWx3U5AvBvBFsIJ9A9si8z672VDU0amMc7a4NjvonF3FuKKfHy
         AIvHDWQOUwtAaXNszvHp3+HL2kUURcRYTs+ge5COHvu3WA9Lz0plCuvcrhZHrNuWJBip
         J7ShgZXkj6zPH3/utzKeIu/fPpyXaQQOyVcC2SV4e3eXv6Vro/6UZFLXgD+DmrHxQimz
         soA92QGyA3Yi2giY59F6OIr4Sw9fqOOI+EgBUfl1/5l25QmXpKNmsPOuFY2jjvMtQwpp
         xTy52bL3tBz11YDzRpu0oHS9lv7oyzvdWGEfEhkzkDSFkPCyldV198iOrDFY6sNK4ze1
         bo1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqOcLRrOmTiIYABG0fpRZ2qZYEQrlajeLo0UKb7LLBxYXjKHtNb0o2YG4I43F43SCW4mJ1vxkgrkXcJGSRdRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMcO9nTD/Tgb4xFq0LJffGBIsmSbA73Ol4RNzT40iK2hjhBwA8
	pPnbqit715D3IrixTDmT87IGUcfA/tuokOCms8R86tlh708SAVXZ6p+ZuO6pyKMMX7ozCQFrLO0
	yLDSv0ABpBIxMxHbADcz/5GuhwOB14RXUe+sQ7riY1ZNYzYhuNOU4fdcDho6Qvs2XzdL2
X-Gm-Gg: AfdE7clp571GGh+DxgwCjGMuA9Meg0zFrTx3v5i89j1zTu8cS/p+Ie0K+A9rrY5QL8K
	2NlgY0mae+9EXA3YVxHjlqKzZA0IIDoB2IdEqF4DOpleZTkQiwiPg0juhGq0j57Od5QpDTRBG7Q
	pKAkP6OdFDydIMOw7JbCHawv7fvmsstYHe9NLG4HRd1M4GdoE6FGjLWSAmf0NolP270CBLfFKz+
	mOW9TWGx9qho9dknylIGkdp2EGxZFrpPD209fp8YON6Wc44k1wsRLifh3cjUiQ5c/u3hSN9IqLX
	p6LA9lvrwObXZCAu7KQWV+qybq3tI+rE9MwdM0aFyttmu21Bru1hOdlT5XFIlu1QDi6n1/stOnV
	bdf0GhVucDyUU0MLo5+dhxruVNRmi75Kq
X-Received: by 2002:a5d:5f42:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47df075a119mr2128513f8f.16.1783508385280;
        Wed, 08 Jul 2026 03:59:45 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47df075a119mr2128475f8f.16.1783508384801;
        Wed, 08 Jul 2026 03:59:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43295235f8f.2.2026.07.08.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:59:44 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:59:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <20260708065853-mutt-send-email-mst@kernel.org>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260708102904.50732-3-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5dH3pW4ScpjOH2H1tO-ODhfJ2boxNnX5pnVhOA88u1A_1783508385
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add a test that sends 2 MB of data using randomly sized small packets
> (129-512 bytes) over a SOCK_STREAM connection. Packets above
> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
> forcing each one into its own skb.
> 
> Without receive queue collapsing, the per-skb overhead eventually
> exceeds buf_alloc and the connection is reset. The test verifies
> that all data arrives and that content integrity is preserved.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
trigger?

anyway

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 76be0e4a7f0e..b4ff9f946565 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>  	close(fd);
>  }
>  
> +/* Test that many small packets don't cause a connection reset under pressure
> + * and that data integrity is preserved.  Packet sizes vary randomly between
> + * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
> + * in recv_enqueue, forcing each one into its own skb.  Without receive queue
> + * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
> + * connection is reset.
> + */
> +#define COLLAPSE_PKT_MIN 129
> +#define COLLAPSE_PKT_MAX 512
> +#define COLLAPSE_TOTAL (2 * 1024 * 1024)
> +
> +static void test_stream_collapse_client(const struct test_opts *opts)
> +{
> +	unsigned char *data;
> +	unsigned long hash;
> +	size_t offset = 0;
> +	int i, fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < COLLAPSE_TOTAL; i++)
> +		data[i] = rand() & 0xff;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	while (offset < COLLAPSE_TOTAL) {
> +		size_t pkt_size = COLLAPSE_PKT_MIN +
> +			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
> +
> +		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
> +
> +		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
> +		offset += pkt_size;
> +	}
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	control_writeulong(hash);
> +
> +	free(data);
> +	close(fd);
> +}
> +
> +static void test_stream_collapse_server(const struct test_opts *opts)
> +{
> +	unsigned long hash, remote_hash;
> +	unsigned char *data;
> +	int fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	remote_hash = control_readulong();
> +	if (hash != remote_hash) {
> +		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
> +			hash, remote_hash);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	free(data);
> +	close(fd);
> +}
> +
>  static struct test_case test_cases[] = {
>  	{
>  		.name = "SOCK_STREAM connection reset",
> @@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
>  		.run_client = test_stream_msg_peek_client,
>  		.run_server = test_stream_peek_after_recv_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM small packets backpressure",
> +		.run_client = test_stream_collapse_client,
> +		.run_server = test_stream_collapse_server,
> +	},
>  	{},
>  };
>  
> -- 
> 2.55.0

