Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164DE3793A6
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626543; cv=none; b=KbxJf0vINTeXCppCnfiLfyu11XJBluHROkijvsIciDe5IJoY4KEbSv+CgJY2EfJXh5+j9z0O5P8yvSE4ZVKYqhanjBwLRx4v2rGaZ0R7odcuRlOtP+HM9+cOvdEtOkBP+1o2x5xYWgGFrKPC3uGPHzhmX247re8PkgTVC6h1mKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626543; c=relaxed/simple;
	bh=UFc5NYkNHpWBb0ABwv4btzCtbc/6m2TSiIZHIWB4Gls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldWU80XZCYiRvBOrTwxT/WIZCX62cQh5AIZLE8kjTh9wWHeSOErEK7RXQz1vDFO2CGtw6XkWITXmlr9Kvx5spQXOgbbSoolaWxZkpirmD062AmoFc96kCfLmuoomYu47BgPe08SH7Eyj6KdzzGzxQIYssAM9NF2GwHI/8Qh45+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqs9JlqX; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqs9JlqX"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a1160a2c42so183172eaf.0
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626541; x=1784231341; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/r3c0ypjapIfRHS5El1n40WfDRGvPfw2APfHzflGpQ=;
        b=mqs9JlqXhCMxw+ruUiAinUjoACirJ413Q7BGBejRqytR0gq1j4u0aoSfAyDdRLBQGW
         anoIqWOkWqrgdkuVx/A+DLlF7Hw25nbUo3vm96ZO/G3ZJAsUOACNWCa/gXomUFQtG8d1
         SoUOAooYPe7BDyaquwl2dYo9hUNKRyWdb9CPHZ3lTqPzgbcAj/eX7sQ9wK8IUNmrzk33
         IVqlGd2YnO5sJaotK2rdrHpx6Z8fDFlv1ix99kti+UUg0n5UaxlVwxhX0OfMcGutFL/p
         /wJn6qKkuhDMTpqU+65xD3GRK5c8ETfTe0IJNeyRi39r61UPzg4GV+C2iBQwxzy19yll
         FkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626541; x=1784231341;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/r3c0ypjapIfRHS5El1n40WfDRGvPfw2APfHzflGpQ=;
        b=nYs5shzwO5EUxSsAJOx/dGXD1Loe3x/fJKP0E/N+cEVP+cLiBKLEPhba7Z7OzSMgOV
         aQ0uqhkzdg0v0xD2j4jMKAfhCU0AVf8T/qLAnQtAmuWV82tCsEu2nJnoLinpKyG0q73H
         yVuWh5hTt//Q4l6OiZUUv44bIuCfpY4dNYCU8yofB40grBL1QFHsdo8r639h9SFvnAR/
         vOO7IgAccFPDQ5fhq6wghWVzcEeMISwzGQiq2xe3KZ8T5zle7js/Bs4Oz4Hq0tCYcGcf
         Wk+i+qAulAP1Pas1E4Cp5rsJ06tIGyGvOjTGWM+fDegPkP1jCiZX+HDt1sGisIAJOpS9
         fvCg==
X-Forwarded-Encrypted: i=1; AFNElJ8WJ9WvLBmqxORUEBIB2RPmpGk1JK5Ft1jLzdMnEiajfrDCfSdEJ8jzuiHeEcs1IgKzrrKpUJDXajtEGvBzww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoL9+cVddsyFGvEGZwkys6Bt35g+EUUJkaQ87DQdiEbzNGbUMQ
	mo8T33ny+/WeVfdilHC8hIB7s8VXGhbLH1ZBki160b3CDFEQW9e6cbbq
X-Gm-Gg: AfdE7cmsIcl4zKCQ/uWO3Yq4SpvdEhVZj0cQsmCrDdhACVPi7FBt2sr0WFRcb7ZcWoQ
	hzLOkhICc+PKlxGhOH7WEbonSb6sywQxPwCaagDvRqnNQ2JktC+PhrXHyrFOXl7hScdxuDEnlVG
	mhSE8HUMc2O206FtG5s7HRzLbpOWm8Tr8cnOQZbCo5PKPNbjKNfGazroyLoeh6Dul1glUvRYyH2
	xHe5d/0FTEEllnlQawtcYRnJIvUSLazpxYvc4aRt6OCflKXxN/XB7ALK9qaYSRCHiIL9JYAaRyt
	qee2HuyQzsbilHXPCnHyWn2dIwvy9n3qLg1SWYudtoaRr8cm3LL93Ins/OA2Els0KPA43lLg9+0
	15eJ5L5ryJn17oqlralMFZpnE+oGMKedJqWL1IQ6+4eyWFq2WAO/HSEEMnTdOfzCkF3jqjbrJke
	Tx3Gii+kx6wUxS2yd6MERoxm/A9DHb4gi5
X-Received: by 2002:a05:6820:992:b0:69e:97da:285a with SMTP id 006d021491bc7-6a36d98dd7dmr6355429eaf.29.1783626540946;
        Thu, 09 Jul 2026 12:49:00 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a66b668sm4932299eaf.8.2026.07.09.12.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:49:00 -0700 (PDT)
Date: Thu, 9 Jul 2026 12:48:57 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <ak/7KFNi7CJzgbX6@devvm29614.prn0.facebook.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708102904.50732-3-sgarzare@redhat.com>

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
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
