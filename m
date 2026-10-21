Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575371;
	b=DS6wlvdqMynzZ/ZXU4ur1jR/oIOcLyb95R+D3ogjV4Z/joXx0H8GkhbfBcsycnorVoge
	 EwLuIYK32v/jclbPwjVEBlQZr8V74qzlimITfH6JmH3v+3mJ48wbIaDitWJE6/39fFK2B
	 AStG6AAVkCbdxuLfABqsv95tNSbGjX/7sTkk8IYk4HSEQuME0wzwbq2Y5dt2DFB+jovCI
	 +3ZHFlUSOCUMi6ngENA8cHiA3NmIxMWzr3f6l8uqYIpVLeyztloaP/7X8TRDE9W5hIhU8
	 rYN/SbKcqFIrp08LTxQ21lgYV34OMTs8I2Q9qSe88xfyjeJJRdWBKTIktkh0hmK58YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575371;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
	b=y9SHR0Y5nSx72ATB5iyYYWmeDxzIeLoaBY3cSxroZYZGbObrJUxdpLMyaoVKZWHTNrU7
	 D8IBQB3Bt4XMQgiZwKTSkipF5V+qZCtN4v9urNFLqP3qPupeLtRakRbRvT/Ci5xoJ6cCu
	 dgpPk70+3XSNuuDqKeYPsXy4oOSPjzsmx3qpgNvrK36LTbvgxhQh+x9+c82+WulM30X1X
	 YARdPI3tZEfnk8BAjE1g1Qg/WuddWs/WcyuhjePPDez2XHEJzagHV4fTqtOTaX/+uCDlT
	 ZO/JW6RjyljhBP7ipC7SloNsaO8voPazjHyoHfQxcTvtlqIHGDr0Ig8UJuTmRv+p4Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7TEVL3o;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F70606A31D
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F70606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7TEVL3o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792575370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
	b=D7TEVL3o75+0jU8IBI3o2sYnqv9zyGzsR8HVsFFqGNE0XsyXP7pYFATcqthBl59JGF/8dV
	kuzNPo7xe02uRodhNHvKZ0GwGEPq65mm82D9UcpnijsB7Kx1pbzaG5RJvqqHl8OvdHcinq
	s52gyfEuVr/6bdf9hyngt7lSwPHIoNk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-OcepGUxfP4mFy8tbpvUPSw-1; Wed, 21 Oct 2026 05:36:08 -0400
X-MC-Unique: OcepGUxfP4mFy8tbpvUPSw-1
X-Mimecast-MFC-AGG-ID: OcepGUxfP4mFy8tbpvUPSw_1792575367
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c46582442so295439f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 02:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575367; x=1793180167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
        b=2qacLiruyaX//1Q5g8lCF0uDQByynkNGNkf4cpQn4WRyPRBp8WS/oZb7FRtPbzZjto
         ArV7XQErX/J6mKPS0WQCWunZA3OkUJpABDZplyZYYQTKipUbOhSUdqEJ/pR5VFEHRDwn
         DzPRbv+0nKfHcKeM6Y+G3xDF9dfotYY9X5x/Ix2tAM3ZrNDOoWQdUPQPul1P6ko+m0z1
         j0evXyjWx2ifz1YFjPxF6CyWk3b3q9GvmjdaW7PcDa4bv3VH8Q4dTc7NzUd0hwyN4860
         tgGy4BQ+LXdF+QNK2kgTNnmkJUDF/wE4z6+lD1SnvXx0wI2DU/oOCEgiRY0ZfApfh0/e
         9kSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI+hp5YDV13nEwBhMDKYnvr0Lej/yHJURE90Ukq6t0y0b1DIUJQKXKWWuO5aopFB+9/eFmx4kwPlVk85uPmg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLocSHBHg+GT9WCabdv7SQeV4F/Fni7UtgBTLdFamkXG5Qb9/Zr
	Wo4CpBE079d6BeRk4QuWOw7bwVY9Nz9wXs7gMlGtjRoTGw3N52AEfOOOS3aRtm+bghIq85MIkJ6
	YVTwgngTDZBon4bihnipBYeIBRg5ow/E2sy36cEZnswQHdG381cIeIRZTWCBlvy12XWfC
X-Gm-Gg: AYBFou3rDiNRFzvB4tTJp7OSDfQDUVWt/GibDDleAUHaL9VOVRNwObWUaos78Vtki7p
	jAWpVP8ZM0YTFmZdgFwDiTHNWI6HUVjozE+88YL3wwnY3vJNurvTBLlj1joex/E2/CjU0lhEaLs
	45a9Q0OLaSTZvvPZH1UjcXfdRfHEf5tyJzvSO4IJfIqrgjU2YDUwYhKqYj1fVppPsDRUpajjWxa
	KUJUQlwpfw7VfZKjT96OhrPle2OohjpjV+50I/qJG1PxjWHe1Slv0XxSav+/Ux1v10mFKRT66Pz
	K5wKWNQMbC8u2MzWhcO3Rw2QoFpfmMgnCBka3pdaYPLIJ5kDyf6sRU8gofoa9gSAZjHOPDKf2c6
	KiZ6ABw==
X-Received: by 2002:a05:600c:1c09:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1fdb1f0demr32976715e9.15.1792575367150;
        Wed, 21 Oct 2026 02:36:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1c09:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1fdb1f0demr32976135e9.15.1792575366576;
        Wed, 21 Oct 2026 02:36:06 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d569d4sm145262265e9.10.2026.10.21.02.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:36:05 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:35:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] vsock: move SOL_SOCKET options to
 vsock_sol_socket_setsockopt()
Message-ID: <atiHbzuo3s6efCxW@sgarzare-redhat>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-2-devnexen@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261016132716.272018-2-devnexen@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eFAvsmn5K6PYKAqTZ3ZXnSQj18di-Kw_CgffgEMiMOA_1792575367
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 16, 2026 at 02:27:14PM +0100, David Carlier wrote:
>SO_ZEROCOPY is handled inline in vsock_connectible_setsockopt(). Move it
>to a helper with a switch on optname, so other SOL_SOCKET options can be
>added as new cases. The value parsing goes to its own helper too, so each
>option can do its own checks before it.
>
>No functional change.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 90 +++++++++++++++++++++++++++++-----------
> 1 file changed, 65 insertions(+), 25 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

