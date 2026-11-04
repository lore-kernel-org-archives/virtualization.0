Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785368;
	b=Rm5oqAVkFeh+ogLcTlUMFr8KkCDUSfEGuJvRvONyk8ghWUDQibIbtOiqhVEH7NHnby7P
	 sEZ2Mjy1YQxzjoBfxY69BwnaBaVday0W0fWajDAqbEhGgaCYBuBdldrBxoE1YobkgxbrD
	 YgAKJEs5gimjMx9S/uj0zmclAYqbR4lE3azfxK27KSHPJGbLCf/yjuaK8blJPFrJ3XFJc
	 xUzI8cGMMv5WwY7EBggGnqbu7ipPEAupSPPhpKTdofz42mwcE3pknESisx5HN+NFFFMbR
	 alRbdYG8v6I4MkNNPv+AUxwRHbpj32pqXVl7t4WOdxO0J7V7CrJG9pQ+SfezCXsV9RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785368;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
	b=Vfd/8n5LRb7ieJ20HWxDmgWgu6Ih6mHGavZrPDYt1COftgid8I5hPwW44hpjdGx2l4YQ
	 ZNKVdlFnLV/rrM6aKIQp99rHQLMLNcnVsro1Bj8b3isG0BGfQMeLJ68NVc7trLmaKbSDy
	 am+kAP4CsZOmmJm08SG4bpuzQfObYdugAWAvJkvXOCGwY7DqEPJQcgmSezkmoY7AFVh1E
	 qafqXgJ7wWCgQN+d9D9t4Y9vrUTvYaoGVWkck20yKJiMpehsJ7FWUL8a1jXPux+l3rk7b
	 F41cdhDctHw78f1FN0YMQE37mp/RUorTdEUaX6gramZFX5kwXG8HrEw/4SSdbmmsdmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXJafjbT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B85606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B85606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXJafjbT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793785367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
	b=aXJafjbT7H4OqzEMgsF1+yzcsgWy5doA494RWx0/MZN6rVyZ627kSbteQzoUbj1LGKZ1ZB
	GyMK1Yyc3d3QNeqs77H49a6hGNntABHrQgH0SIPrcbz4rc2R14r9Un/NhOuTm5cyKMos3I
	84AWRdkaSXPh0VwF0daByu3xyY8UjXw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ki9vpbaEOkKDfNxi76gEOQ-1; Wed, 04 Nov 2026 04:42:46 -0500
X-MC-Unique: ki9vpbaEOkKDfNxi76gEOQ-1
X-Mimecast-MFC-AGG-ID: ki9vpbaEOkKDfNxi76gEOQ_1793785365
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so4624325e9.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 01:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785365; x=1794390165;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MZsEByVFetaWVfcIa8bmUSPeNNMI6WT6JYcjMZoscw0=;
        b=cLcJ+rPMtmNvtQjKIYS1QzyYT6aWX5J6DztavNsSRiSMMmpNJEByH9pLQ+p/k+VSQs
         so5oAVBsVHuwdNYX/z6xapO3nKJtHzjgGjYJ+KqqfrAy/aTVLO4cDmtkJAZG0RAzP8B+
         hCYrM8d5Qob+uel+DhtHnZ/xjDf4OD25IxOXDtaf3QBIZD8ExRMSpDkuWCyesfoTCUEe
         ts8EpWAo07y/OPCyb5rk3cBPdldmdWm5AiQyijWZBj6a1Oi/aLNUXqI9lFqrQM8i3U0H
         ZfMQKktlNKKlgZgiynQolLFmnseNiN+Opwz2UyjkibDqupw7iJ6sF6VBDkP4n/m1Yfei
         yfxA==
X-Forwarded-Encrypted: i=1; AKwUvBy8+ml00d8CGFCfgfr8O7USWyDHK5Vtb1NamHqcIkHGuwTFMvx4bs9eZkUMd8WKqYJow+chxJnTO2XGZQcQ6w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9+qsobs0n8L7UWRD8lfkqzVE7HhufNixSf2r4neJQ/8gUcCaSM
	r0y4P2VmWL0mUk+4J2jDj1mi3o+9udWSp/5b5e/8FaZl+U5Tl/ObTX8szJ3M2lcnNfmJw5yZl8L
	pdPH5LGKDkKBaE/ozumY7KH5D/ZGig15INVZBE4CJ7WO3lvx9SopeTNJ9208ZQf25b8+e
X-Gm-Gg: AYBFou3lqCUYdtRqKUBdgPzH/mNv/KFLcHq5VAg6mRuRUg0LVFsCn243DUSwixPmXJ0
	2e3YaBQtGuMtEY5N+AewAvtql8+zaiFEOa1kwE6cUZOwPtZexXwg0dMUg+Dlzl9Fj14Ct4RdnzO
	W3O0R5qYtFsnKZk1czIj7TW2ocZqaHYPJtjOZBIPhN9/9ytlYk9PZnz9yfhSuNAAEHrvJ7Lw8Bq
	G/u9cQCucqBCmxWdVOgg+KlcIJBICBIybgfOpYMvaAZavF5kRvkWYaUNz6aOzod4yLfMnz6ibwY
	IVSrJUKhiRTLBNluGEIfoYFgyi4usMtsR0dOv7SyBGfOUF8rYSbVZeqLwlRYEsrbnj45y7zXZGp
	ghVZBs5hF8ByV2Ad/vOG6VYE5Y7dVOXSNBPd9ll6cNMVkfla1Kdmz
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr363922295e9.6.1793785364756;
        Wed, 04 Nov 2026 01:42:44 -0800 (PST)
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4ac16acd93cmr363921935e9.6.1793785364240;
        Wed, 04 Nov 2026 01:42:44 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm144133585e9.5.2026.11.04.01.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:42:43 -0800 (PST)
Date: Wed, 4 Nov 2026 10:42:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <aur96eHKMVO5zMml@sgarzare-redhat>
References: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FOVjGuF2gmRmlXgC1x4zll28KCIt0Mngd4POl1I11wA_1793785365
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>guest controls the descriptor length and hdr->len independently.
>
>A guest can therefore provide a 64 KiB descriptor while declaring a zero
>payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>remain unchanged, and only the fixed queue-entry budget limits retention.
>This is not a lifetime leak: the skb is freed when dequeued or at socket
>teardown.  Repeating this across connections can nevertheless exhaust host
>memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>a 262,144-byte receive buffer; a full-payload control retained 265,984
>bytes.
>
>Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>from the descriptor length, introducing the allocation-accounting mismatch.
>
>Copy the header into a stack object and validate hdr->len before allocating
>the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>capacity no longer determines queued memory.  Check payload_len against
>len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---

Oooops, I missed this, LGTM, thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

