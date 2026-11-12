Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523983;
	b=0wzBw8zanlzRxtrcZD/TAQEI6RO9wlQgcxJIncmRU+MGwAlZvvWhDiHOOCDLm3hk4snj
	 TC9uwAy2KUaeRv+8IWs/1sGUt4qW/xAnz+aK6HB3vCqMjADfPmoZX1+LPfg3puSG4Uqj7
	 05EXw4W6iN2F1WB/Xqo9F+TZbmVmiC+B+8tO6DaPwAp80AGpmYBWCg1KcKX8NhQxYJ0Ke
	 LMZ/dyl0XmOQe3nH49Op1RE/xu3ahdAr4u7DDagapCRDR1OmJQDrbk4BQQm95c659pc66
	 VYADsBjfcFxNnUu345b7JKVfLinB1eNXpRMyVlwCXhb69SM9uf3VuiS7rcC399EuQcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523983;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
	b=JS+7t/JFijAchng2JX5cvTGRiP6eZLGQ4qTbMt+r2VjgOvN36Dq9gKZGjDQZwgyJXtys
	 WSD8T13itbI6YLUReAKEMLPFx8j6CWb3UgAlOaLa3V0IlnvpdWCK+iR7bxkcbzPQF4ltU
	 e9Rl85tA9WWqjMOvpxBJaj6SHltCQ7V8/dOkCK8KJw4csHS5qkd/g5x8qhF26WGTmFCAf
	 UOrq5dio4MyoROhEsHB8KGNtLgcXlGIgMp2c33tqksihUlJaZakF0jBOYqtNhOTc/MGrO
	 YVPGOG7b4v4OtUlWJkkOswlxB5o/cr8RdxRf9j2YAYK02+0rfhZ/eq3hh3pQwcbHoiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYpb2wR+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586E606A327
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 22:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E586E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYpb2wR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794523981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
	b=hYpb2wR+264idlXsYGkCZXwIXCtetnWNQ/++wxLAfQDsmjUSVH8BC31HDabe86HHe2Ux4X
	o0SRdTwWaEykOUdTujSxPUS18FtL7sKdzVoBFSo7RB23ksOCK4AZoef9vjTdlJzT9BQ1Ie
	ZLlyiiF3NUgW+qN3+nn5gv+alVb78LE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-aFxFuohoMXi1sCYFOER39A-1; Thu, 12 Nov 2026 17:53:00 -0500
X-MC-Unique: aFxFuohoMXi1sCYFOER39A-1
X-Mimecast-MFC-AGG-ID: aFxFuohoMXi1sCYFOER39A_1794523979
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-499ca65ae87so167564f8f.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 14:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523979; x=1795128779;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WwAITWmdbZGC70BWRrDzhQCdxo59dHOpJmNv4zDF21c=;
        b=TZcYcQ+c7yO6tbdwpEZkz1GVwXkZMEux1+bvC1R7k+7jHXbMLQvWS706KyljU3t4w4
         1DHh9RPxwGOEjAEUSOoKU/jOfhs48WOjNCmzw87RUv63e41u0W543fa+Fe2k9N3PNdcX
         6uW4iSIhShnKv6vLOxlUM25pKXQuqlzKX+xxODTyaOxo0ucfMxqhbL7fZNucGEFmWYIa
         oJgihBd4YUnsVJRlAVqmqdKkBn2IXCdcKBfp/WJoAGnZgpeUvEhRErr2Son/Utw+8dXe
         j/N8newi1KbT5+esqcU3fJ9n1jAEFOOtCU7kyvPlLPzAjfwGiZUaBhmrUm0hsMNFDqZ9
         wmFg==
X-Forwarded-Encrypted: i=1; AL+hErEjFnXdr+6wx+irPpcF1nFJqeGG3RPTEv7VvTDO2UXy9OsjfJEAeNUxzbMK+W+/xPwQ1Nm8e6g4lIon6F6h7A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+bp7DSSg0Z5vRtb3FvnJp+ZYHxr5RnwpEwdEYlNKgXtvs8pPKM
	KgixnpGtSpSpVt9lyr5hssCtTLIEOaSdiaWNVTJId4OGXbMD0oG90BwtXxRK2vl2t9jx01OctUN
	JCUNcNq53LPhv+WxL1dfqmxD93fdE9K9TyjjoFt1nYK9sw+hBYTB+flJgIihkbpCpQktl
X-Gm-Gg: AYBFou1HK1LjcPKfn6WBDgYqr+WMj8mvp/g4EUd5BUvnXyqhjdbq71WuV1QgW2RXDx7
	O1aRAvsT1WoA9V/7y6+fQ+4ZmBvvcQclYareGUsuFZ4KmWPbzCudiXjWi3VaNipb46494sXXAys
	txPIyU4051AtXsFvRzZsI3ezsEft//sU9Ylxv3i5ds5SnrXiX5KBs+pUu9IdMQk/If2pzKGAlGh
	SK4RjGb5P8pDk8lrL0OwcMMpAciVDqNxl5MvlcvNsbi3mSZVBM1HRDiGmbdaV2OO02l1Xv2HLpe
	58LaQ8w2QSgR5JyEllrTy7NV7rT4uS9NvAH9EOn08Q1N78vtp7vS2jE9G1Bi/kYcivsOJwryOLN
	v6u6CaeSTMgAd/S8ZNUaeLq+yK6jUMlTjs+nZ2p7lfA==
X-Received: by 2002:a05:6000:3cd:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-49b01734c32mr10021214f8f.7.1794523978950;
        Thu, 12 Nov 2026 14:52:58 -0800 (PST)
X-Received: by 2002:a05:6000:3cd:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-49b01734c32mr10021143f8f.7.1794523978200;
        Thu, 12 Nov 2026 14:52:58 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c602dsm1590908f8f.46.2026.11.12.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:52:56 -0800 (PST)
Date: Thu, 12 Nov 2026 17:52:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 3/3] virtio_net: add rx_timeouts per-queue statistic
Message-ID: <20261112175235-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-4-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261109094310.103979-4-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: duz05LuUAYu17XqKVeamY5xlAdJsxhJQXxNtkCFvk4Y_1794523979
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 05:43:10PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> Add an rx_timeouts field to the per-queue RX statistics and expose it
> via ethtool. Whenever an RX queue gets stuck, the NAPI poll increments
> rx_timeouts, so it counts RX queue stuck events.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec7c248080c5..feb6bfbb1c5a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -135,6 +135,7 @@ struct virtnet_rq_stats {
>  	u64_stats_t xdp_redirects;
>  	u64_stats_t xdp_drops;
>  	u64_stats_t kicks;
> +	u64_stats_t rx_timeouts;
>  };
>  
>  #define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
> @@ -168,6 +169,7 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
>  	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
>  	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
>  	VIRTNET_RQ_STAT("kicks",         kicks),
> +	VIRTNET_RQ_STAT("rx_timeouts",   rx_timeouts),
>  };
>

Is this consistent with any other hardware?
  
>  static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
> @@ -2983,6 +2985,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		u64_stats_add(item, u64_stats_read(src));
>  	}
>  
> +	/* Count a stall recovered by this poll. */
> +	if (rq->watchdog.stalled) {
> +		u64_stats_inc(&rq->stats.rx_timeouts);
> +		rq->watchdog.stalled = false;
> +	}
> +
>  	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
>  	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
>  	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));
> -- 
> 2.51.0

