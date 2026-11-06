Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939157;
	b=YdJS5gTVUHC94rvcz6p80eBtcrvilppF/hhepWabsWZxU7Zs453K6jML0XdTSDl6JhM5
	 IcAW4ptdKiCGMp2pTubmM7woNX9Nu8Gc9w52vLghlBun49KYkKSW74JDVmY5zdla+HmDh
	 PQlpGFMy1Lz87TWzZ4YzsopfFiWkhYMWeuPlVoCSKHVvdtK40NI+4RAlT5q2ultN31+3x
	 H+9hrlxzYTHOboMjebscDsk+kYDgazMSm0eGk2ssBCalcToRLWurDaXWFvKSVAS6FUJLv
	 QLesJt/HaQDtzzLgdc+n/5IEh+VJTd7Nrdr4vLoWEwr0fOP3RavS8/oADwsBpHvp3cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qqKPGKgxzCnJl5Zf6W6XFm1IHi1NIK5zysMn+xDZUsU=;
	b=ZX8wQOJhnBC2OCNbyt89aFzpZI+Ku6aAuRwIKweIq7573W6TT2Ojz/5psceDfuGD9WWM
	 hqDfvMTDg04MbUSWDE9kUK733fVgrhkRD1Bt+VLJ/rw57BXuYZtD3emq4TOLKIfpb9UKQ
	 nFkp97Tkd7Ov8OpmmRE/rajPSy/z+ivjEadqxeHhn95ggof/tAmmqRfQk2zWUkhOzc6Pa
	 beMhhkU5yOGKIdLPO5wP1TUmNcuInOLGHmvHEqKc+U1lntfcJj0YvHbfWyoZapGHxzq3L
	 hbkb4+kjffBAZm7nlM4O9DTQ8HKBu4MLBknoqfom4uBYTMfyCzQ2s09T8oP/rwchajw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB80606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 04:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB80606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-990835cec4bso119159241.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 20:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939152; x=1794543952; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qqKPGKgxzCnJl5Zf6W6XFm1IHi1NIK5zysMn+xDZUsU=;
        b=gzlmd4xG0WBCoOyWcprbwWuIW7h/ZOyJDjZiA7GuOwcVBkwFBTF8B8tbwj6DLercUA
         Zn5WuC0i/pdDNY9cfrcWNX+vhPJYlqqeXUz2arIqdvAIFTc2ivAQao2g84WUT4SuMHBK
         hkoOzX2ayXCZl1wHBPwjWGPwLgi/zdMyX2iod35MwWhjcrLW7W6LdwzCdDnJ5/YhptGD
         z9dbXvVYt42dAwOa5mlmTHxl3U+iKV5RgSd+Tl62bxjc12ohj30myiyonad3uhqLflnO
         xUd6QBY1X8ujmbPvUBUlC4qXrADTa9UAZ/e1UXT2nLGZOJ61j/ovzg3dL02m9gu1UnaN
         ipZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939152; x=1794543952;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqKPGKgxzCnJl5Zf6W6XFm1IHi1NIK5zysMn+xDZUsU=;
        b=rvgQxXThtT8iGCQA50Gsy2GjQ6wgya6NxRBqN72XZ98Gf6u/3HnM6F3BIBShAlCOcp
         pYiR1JqU9pFKXNezsOhLz/E7/I/SO1vqP0kFWf1CxQknekZWSHgdz3rKeOvOP9/hwuqi
         hcQ62A/zS4hoA7s9gaNcaIxQYVpgY7TNfRLeS3vJZHJv3OqAAqQlIEhpZXzabb3GisMr
         kuVf7RKHW5Du4C6d6sxM6UrCmxLUos4iIjG50cH/t1Kjzn3Tu+nnx3dL9qglRPD0VxzM
         W8tODZtXnOrVdTyh2bEswCfNQ3IRmdmssGZuFuWtdr1QtfSJKZaug/Pe56G83KHh7bvu
         JRhQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2QneXpALjAS7rQnjs4oJ0/BZSjNJQl7eCvrC97zNxINzLDp9HqslkNrW07Ee6BAG375cOfDr6EVERCf4vhw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9KeOX12eBNCnUWPDxdMGj+LsEzeUoEfKUaf95891iUTFHChjty
	xbvBU3UScTK+KcWjXAeNsn6Ej/1LqgTIuJDsTBvtvAedN9CCP+/5uiYN
X-Gm-Gg: AYBFou06sVPMZ1Vve60D160jMwKp4eNEZWu/VjE6DbSNbp+xZObIfCJ1mOrczkTQyF6
	LHJu3Ev3STD1dVAwWoqPRiEo8/oVQdC9f0xiDz0igPcSk/NpwbUhXwG4xQWRhRpqWTFPrXDMZQb
	QZ4dDEZ4kqfvpN1CirXxHpOyfpeU0hzhNaGzIkhTiYXkbO3ILBOWW4ytk89Y2xnOh/ySMHfoaG8
	xRRtF/C7jWJuMA3eaTCD/nx24PAVWa5m1rMjjKOmyVsisme1mSLFSFFXDi2uW29R+vapnzXAY3S
	Snd4CEdiXivQp9m9kaEOt9HsrJKT2FScESAqyNZ8bXXP97DwUXc5yuUaX2NsNTdMTcNNkk7EoZu
	NBOM/vKTuujL0t+vBMc3CWlwU/ZhlZ1zTg6xnKRxDIWDFhhM/uLXWr/wnG6GFVtwXIurSIKXRBc
	jLjigWOpBPv+kZ3Oj+WXb+TIeMvxcGUnYn25ekgTxnjUkWIIGAZg8HwCF/rLOHY6usVNLbsAla3
	Pq+uaWuJBMnFAVPscIjJqy1O6cWmXp/zrD/TK8clQ0eA0Kvwd0bTQjFTDczWcg0mBlmv5UmR8dR
	l+wWjDbqAyWT73ARFMj/T0EEV8oLu+aC4Nlgy8b0m3UpPDgKx/qHRtVW/uqjuhbShDJ0On7TqRO
	nu3kRov6GeMDTQ0C2BZR6Jk/nlFRzK0izM3V4F2VN7SAMtdKoap0ZGo8+kq4VSHgspT32KOM=
X-Received: by 2002:a05:6122:1d07:b0:5ea:c37b:450 with SMTP id 71dfb90a1353d-5ecc4428992mr843406e0c.20.1793939152230;
        Thu, 05 Nov 2026 20:25:52 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm576387e0c.3.2026.11.05.20.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:25:51 -0800 (PST)
Date: Thu, 05 Nov 2026 23:25:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.1374b4bb37bc5@gmail.com>
In-Reply-To: <20261105115715.1466924-7-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-7-edumazet@kernel.org>
Subject: Re: [PATCH net v3 6/8] selftests: net: tun: test UDP tunnel GSO on
 retyped devices
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Use TUNSETLINK to make the device type disagree with the tun/tap
> framing, and check that the outer headers of UDP tunnel GSO frames are
> still validated according to the framing:
> 
> - tun_vnet_udptnl_proto.outer_proto_link_type: tap device set to
>   ARPHRD_NONE. Frames with an NSH outer ethertype, with or without a
>   VLAN tag, are rejected. A valid outer IPv4 frame is accepted.
> - tun_vnet_udptnl_proto_l3.outer_proto_link_type: IFF_TUN device set
>   to ARPHRD_ETHER. An Ethernet frame behind the tun_pi header is
>   rejected.
> 
> Without the patch "net: virtio: do not use dev->type to find the outer
> L3 header", the frames expected to be rejected are accepted.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This TUNSETLINK ioctl is so odd. Changing dev->type but not really
changing the underlying link layer expectations, such as eth_type_trans.
