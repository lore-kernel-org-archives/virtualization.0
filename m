Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6A2DECA3
	for <virtualization@lists.linux.dev>; Sun,  1 Feb 2026 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936488; cv=none; b=f27PTEAU4Hq3VxSXBjHWh6ztNsmJJVMFLb+iIcugd9Sn6qNIfUa7dheqBiLo90tD5tbZGOPHSOHYtX3rlPgLA04JjdxrI96pQNH6b9GFmk+KPuuiLEcHJQ4NLItntW3rbCoP+nOZ1n3sh2LYx7/5XsFwUlA15Oaadvn6w1NP72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936488; c=relaxed/simple;
	bh=uLCjGvitM7MZI+iiZOhsAyamc3vLUAP3Bnzyj3zmxmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nv7EhDz/0RYUxqyfuz8yiEXB/BQH6ONbFUiuSGdTYh+R3eqiPulxk7MrJa5rXNKM4W12WbkYaZbUMI3rO+wIiUHOM4VSUQGiBSDZlZt31ARaoO5+RM9eycUyBAygTY/UaSS9xWBfKBEfRUXlesUMP51nIHxpuPN/ss36AiDrvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK9lUsSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK9lUsSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769936485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
	b=XK9lUsSgv5NmGKEW2yTbUcVZFlIN3gn6FVpOPZzTGj2iAkW6M30LRWxWBpmXbgMYy2zEx4
	UmOIm8j8nIfsLX05vipwZJ4njvGoLoJmOMchwA3pBhCJKiaE7YOXEPMnz0TBmZOaKHP1uf
	Gh9ewvy+u49vmQVe2LPZZ50PPddgPA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-_RJIRl0XPr-Ijgq2FmEudg-1; Sun, 01 Feb 2026 04:01:24 -0500
X-MC-Unique: _RJIRl0XPr-Ijgq2FmEudg-1
X-Mimecast-MFC-AGG-ID: _RJIRl0XPr-Ijgq2FmEudg_1769936483
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fe16b481so2252093f8f.3
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 01:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936483; x=1770541283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbdMtd8ZV0Hoqg/gvmWguCwsRV3oQaDigUGA5FFlPEw=;
        b=B8U5GuvGqoKvWBR8O4TRmdHa08G7+kKqi6RXtlkwOIjXpS2CbcSz+RVDt0/TW0tDjG
         Ot/apw3oMH4n3YmBX1NsggM3+6NIPfbluREhSQ3tllQAE1s+Iw0E5G9X+kzxAClANrLA
         takHhJ5v0ujwdrENDaN1JH0SP0fKYpFx57yFpAhYTSELT6rJ1BdMqhTn7IMjM74BAmhC
         iYBqlJIq2R0RSuHe5kzESbpJg1EmAEWTwI/x9w0YLL5cWzMt7E/4dR9pMFjlVQYOzG/h
         lybTl73VOpD5wyCLy7VVgsia4uPXH5wT9WgVwX9LjudlNVbxSEfNPQNQ6XkKp/4Jmp5J
         6RYg==
X-Forwarded-Encrypted: i=1; AJvYcCWWPi4hCA/NXBWifUIZeQaqZNhWDe5B4tvtDVZZfZtyG4hnvEd9Ds3Z/63e3KGeEMTxLvb/qy91PTaWT3Dktw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQIBz8Gk2ezLSCFaaxc8KjbP6DbsXnT/9nblSEonyFzpT21FEJ
	BOoFyvDumiNGkUy8fwJuJQyizMPIEVw11h/r6VXd+1FXzfEod7KBN9cUqIXpMXf4/08NlEs1oAv
	AtHH7BCcqYh6B8oOZMNpQSJd6OnivPW/3XcuN4jNTgFX63ZqQLQ6yFj6yTY68Vrqr93UI
X-Gm-Gg: AZuq6aLkDvksbv2D1flBCB34fjUfaohciQnVeun1gu0iFNTeMIRv5Pfx48L+Pw3boZs
	xCouIGwrfzpc6EH7mkKECNtc8AMdTEABm0DD/IfGmeNaeYVkVYAkV1O8qzNIG7fVsLSJ1fVUH3j
	omZRzcLv1wbTsBDXhVU5RBlsiqSNzy6frGRhnZj8zkW7dzSA3aSb15KFMTAU+Io82pN9CsmgmJV
	1c5+HVobwqKxnbBKChsLBBK1mL6Z1htZuR7uugMO+osugXKqizfjmyuWdwrN7ypE/qVVKG/yEYO
	xp4HrPzDe4oEbiRprW9bQzol7FoefcPA5TX4dupl6X+Q0qfqrh17pG97ZbaILZdmWnDIBM68e/z
	AuA5N43fIupgjqzeh9Dhga8dYtXkNGKHakw==
X-Received: by 2002:a05:6000:2883:b0:430:f742:fbb4 with SMTP id ffacd0b85a97d-435f3aaea5bmr11593868f8f.43.1769936482919;
        Sun, 01 Feb 2026 01:01:22 -0800 (PST)
X-Received: by 2002:a05:6000:2883:b0:430:f742:fbb4 with SMTP id ffacd0b85a97d-435f3aaea5bmr11593790f8f.43.1769936482295;
        Sun, 01 Feb 2026 01:01:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce70sm36590005f8f.27.2026.02.01.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:01:21 -0800 (PST)
Date: Sun, 1 Feb 2026 04:01:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 1/3] net: update commnets for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Message-ID: <20260201040043-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260131225510.2946-2-chia-yu.chang@nokia-bell-labs.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 64ZLhHqgnONTUivW9yy7T-AiU4s9OIfa-1eiZ8oC9Ig_1769936483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Jan 31, 2026 at 11:55:08PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.
> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Subject: comments?

> ---
>  include/linux/skbuff.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index e6bfe5d0c525..30a8dc4233ba 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,13 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. However, because
> +	 * the connection to which the segment belongs is not tracked to use
> +	 * RFC3168 or AccECN (RFC9768), and using RFC3168 ECN offload may clear
> +	 * ACE signal (CWR is one of it). Therefore, this cannot be used on Rx.
> +	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
> +	 */
>  	SKB_GSO_TCP_ECN = 1 << 2,
>  
>  	__SKB_GSO_TCP_FIXEDID = 1 << 3,
> @@ -706,6 +712,14 @@ enum {
>  
>  	SKB_GSO_FRAGLIST = 1 << 18,
>  
> +	/* For TX, this indicates the TCP segment uses the CWR flag as part of
> +	 * ACE signal, and the CWR flag is not modified in the skb. For RX, any
> +	 * CWR flagged segment must use SKB_GSO_TCP_ACCECN to ensure CWR flag
> +	 * is not cleared by any RFC3168 ECN offload, and thus keeping ACE
> +	 * signal of AccECN segments. This is particularly used for Rx of
> +	 * virtio_net driver in order to tell latter GSO Tx in a forwarding
> +	 * scenario that it is NOT ok to clean CWR flag from the 2nd segment.
> +	 */
>  	SKB_GSO_TCP_ACCECN = 1 << 19,
>  
>  	/* These indirectly map onto the same netdev feature.
> -- 
> 2.34.1

