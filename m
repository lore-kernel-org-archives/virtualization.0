Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079433;
	b=OIoDw/yRc84DuYmCkPzZA7rF9ro+RsezIu7osMFuQTc/DDiduujZYHEGCcrQulMty5a2
	 cHoteAXRY7+msUeA5g1nEBkmr6FB8B9ukJxZtwlBqu6CEOhBbhS5Il3EE4KcG8UJe08ul
	 qYzYDNCBpilo8B+GAy/FpyPemWJpK27+diB7ovs6MMSTSEKhzUZJPp2H1YbZC3SG5Jo/3
	 i76cvqtCmkBkFrnSrsUBe/qXP+8ITAL1xxVjHs4KcQkctRwkzON6GsxZ9HLcR0uZKpVlO
	 YTShOCJ/4/aSMcTvTqvmanEfmN7ksgQCYDs03LOnuBGxVxRrANEk02jTmeR7rldRhrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079433;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
	b=IyEbZgNTIjVf3NQ6ovf1JTyojVxdJGQ93mDBxJ4NzJfKPzVTyEnNB/yk575VK4FM+/sU
	 gjpDEEmve+AcuFW0jGoeJEWEAyW1+I2UyUtTFUOX1OsFvIerzwUuT1nuQQlCnaFukZvNa
	 kN2AEUdABuQWwPioykegU/WUqj7QJKNG4ZA9/zLgyUrKx+oWj/PnjmuhDL2We29D+ecZd
	 HmOba7RMQQwK0+xO6sseu/Ma8FRu2i1VM3Qo5xQhRs6/eYRXLcbEw2EIsyzRzcdAN1afG
	 +yU2Z5aTNo/v0Bs6EddsXtqfcoBIyRKSfZLAquaV7sSOPLQPSWLkZCgCxOg3UJvOFNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="g/kdQTMZ";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFDA606A324
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 09:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBFDA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g/kdQTMZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795079431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
	b=g/kdQTMZZX6KtW4Oe3nUFdp9H7VZz6N3u5HPXH0OPbS594mo+3Tcd/+jc8VtQ1b37pKEu0
	W36aHrZFEaDAUUqNZQBxX5GlQ2DLZO7jlNCgkrA2A68wndANCYoT+R5GOaEjKRvUElS/WK
	HyEvQGtQPHsSPVPein3/awuyt0aPs2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-tab5ZPW6McOfSlg0rS3OAA-1; Thu, 19 Nov 2026 04:10:30 -0500
X-MC-Unique: tab5ZPW6McOfSlg0rS3OAA-1
X-Mimecast-MFC-AGG-ID: tab5ZPW6McOfSlg0rS3OAA_1795079429
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490d2ac331bso1889942f8f.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795079429; x=1795684229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuBOCCiH6AYUcrUIRQklRkNbz1Dojigm78BR7t4qnhM=;
        b=lahxtLzNk+Jr1MxBmkvGRrTBomAoEoe7iQC/r/cw1cycMqVkHa+c/RWWfXvHdcCia/
         pHc4FYqIXaoEfkPRerzYhbiZt6cW3fvdVpve6WKci58sVlWeeZi7/eTwhsn8HFGMbIVR
         7U2D9xGVafnIeY2hiFHO74XGw4ZYupu0Unw8nFk8W8V/+ahEoRRdvyxq5dagdnswuTB/
         NHlyruq2QmgCjCiGthXWwZmfOUpFVYacOeUErMWDfL2HJfTqJaclwC4EFAVgqlMhzfQl
         pmrbobZfBzXr7VBLu9g5zjwajdVJTCyXrziBi+9KFY1IxPxusqqUY1obrIeNC+7Tp2ZZ
         hXlw==
X-Forwarded-Encrypted: i=1; AL+hErFnb+M/wcXLKBneds5DNotF7Q4I55++ATIALNct2kK9B/hMO6NHOL/w/rBrzqj9mHzVRE8AS4DS9Wr0nmHfvg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jcqO8no/JWCqCvlp/o3UOUca/Nw2s2Ih37q0ID8UfyHjnY7qu
	/lx9F044q5XZRddsGCyxxDZW/pjQZBQpUNzteA+5gW7IgAMeq41DsC/n1HCxU96Ns+27ZUnUJJQ
	Su6xIK4LoVAupBUWHQPROSa/PsnkvdPtPcHn/E98BWV9Ax93MiZ7ecVnAVBfrmtyqm7b+
X-Gm-Gg: AZFdTZclrnTp4C7NhEHiLOIxRCXcvR2wM8QRnSI+cZadsrIBu/wtb5x+oeVZEUOZYZz
	6IK9Ym6oSMC5TGPw7vpTJh3fWwvCMxWRXcjlF90wUP/FgLFatA/F+xBjxb/kLsYtj6MxLhMMQrO
	ASCRsmDmtHJn2aRVJQ5u5FaYYktIgda4NztgGBNmauI5Pc4kuXg6kSTfo8+Nuz244SaxIkwTUq4
	OSEAKZ9JmEXUPnl8/qwsrk+HegvUT0TWPhU6OHdjesG7yjdXFebr3H5hbxE4ed65E5e3Pq5RSpw
	oqcNRvAc1Ep+y8zvVZzE9COc9y5kpUMPsbRVAHhgREEh/94o/QPhN5XJbXBiRXiuuYQLp8LdIn2
	mwlugUC/mFXk+7/jTkVAT3Mr9GDZq1R4YHYQQrpSVGWu3p+NxCUQuMw==
X-Received: by 2002:a05:6000:4812:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-4a63bea9888mr10985197f8f.39.1795079429136;
        Thu, 19 Nov 2026 01:10:29 -0800 (PST)
X-Received: by 2002:a05:6000:4812:b0:490:50c1:f359 with SMTP id ffacd0b85a97d-4a63bea9888mr10985146f8f.39.1795079428655;
        Thu, 19 Nov 2026 01:10:28 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655db6d45sm9145491f8f.33.2026.11.19.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:10:28 -0800 (PST)
Date: Thu, 19 Nov 2026 10:10:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <av682hncPM1ksJtf@sgarzare-redhat>
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K8Dcu5QOXQ96WWQxDixOwPCQSlBAsfY-OulK7VbffAA_1795079429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 17, 2026 at 08:01:52PM +0100, Sergio Lopez wrote:
>VMCI already rejects datagram sends from local network namespaces, but a
>datagram bind still creates a receive handle in VMCI's global port space.
>A VMCI sender outside the namespace can therefore deliver to the local
>socket. Its handle also prevents a global-namespace socket from binding
>the same port.
>
>Reject VMCI datagram binds in local namespaces. No namespace-local
>datagram transport exists, so EOPNOTSUPP reflects the available receive
>paths. Unbound datagram connect() and sendmsg() also return EOPNOTSUPP
>because both call vsock_auto_bind(). The receive callback rejects any
>local-mode socket as a defensive check.
>
>In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
>delivery and the global port collision before the fix. After the fix,
>local bind returns EOPNOTSUPP, the global bind succeeds, and a global
>VMCI datagram still reaches the global socket.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
>Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
>Signed-off-by: Sergio Lopez <slp@redhat.com>
>---
>Changes in v2:
>- Combine the VMCI receive checks and clarify the auto-bind effects on
>  datagram connect() and sendmsg() (thanks to Stefano Garzarella).
>- Carry Bobby Eshleman's Acked-by.
>- Link to v1: https://lore.kernel.org/r/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com
>---
> net/vmw_vsock/vmci_transport.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

