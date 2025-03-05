Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93271E7C24
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159648; cv=none; b=H1dED1ZEM9TASTzjJYwQAiH+J4+cZGxq08KBo482wKB1ri0bpWx6BVRpmoMyYvUFby4vSrhxKW9Hz5fC+3iWAqkq908l/LKmoYbgwyASY2AArXq2EacN4GJMXtZw9Cdx0BNNOKhuQbgr26oQ6oCIjBws5GXKU4IXvM84gj4hOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159648; c=relaxed/simple;
	bh=ggBjNt/KlzNhbq7zUAZEYyviD7fOL0zcgpYxjiglnLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nWQShh/dUsDh04/nCqFIjZOjbDlCMSZJsh74CDkE2IZTV/5uxauA2KWFJtJL9h+ycRDSSYAn9cYXL6+9n2Ep4TCKTiOtGmUO53DNUPkWg4j6AjS32lLh26P1/8fjNEqKkzUKMlbFW7dUA5xEIqGTuNUP+6SZkd22r3cI0mQkfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUJM1t/4; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUJM1t/4"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50EB981774
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 07:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wxLW4y6qlo0e for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 07:27:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8EE8780D7B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EE8780D7B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LUJM1t/4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EE8780D7B
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741159644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
	b=LUJM1t/4XEucZCaa+mwMXl4r+sdHCfQ/+pgUKdWF5vnvBtfAoMSmDI7aYxeyCzL5Qmq8sQ
	KdBA5RqraR47GbXhf0RK2fup6HNEkZjuTYy4esAYZcTviUWwpGhcmI71juFNkxHgse0DP4
	bvCz3Tv8yK+AZxP85dYe64tzqAoyHZ4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-F-0CBfcUMOuhL6oZXc2jeA-1; Wed, 05 Mar 2025 02:27:17 -0500
X-MC-Unique: F-0CBfcUMOuhL6oZXc2jeA-1
X-Mimecast-MFC-AGG-ID: F-0CBfcUMOuhL6oZXc2jeA_1741159636
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f6aa50c5so2874625f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Mar 2025 23:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159636; x=1741764436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gqpuh7OkhW6l3/SGFe53202mdgSid6lnY8KI4KHLQM=;
        b=pSUcnb/z79a5S/LENEM8vFp4sIydzL83B5rdaSfQB3Tp4zjm9AHtP5jaWO9vsio0Ba
         wJrUwnp8xOKQW06tdJIUtYRAk84GT2+JprOS8FpsrcsChiPIpNCbfaCByUybWZ73640N
         r7h+CFvwIVUo7wTCnEuWsTvpc19uGB0N24UjWdzCMwDLvwAgNjGb1kGP3gX579guutom
         TffnuGItct22VU11WwO+cBWVZUOCwktgAipBzDsd8gmKmYuJNKEaz4hmTpOThXF6ouob
         1ede/HMruHLuecZ+ACJ878PKE9azSzU9I8Uf1JLXwwzN3/+4cf7mhOQjk3zcm738Fqay
         6uNA==
X-Forwarded-Encrypted: i=1; AJvYcCXIZMuBuBMExBzySUgL9jBjqA5WEy2f7fS4dZpWm0ksKoENN4Jj42c4dA75f7dTyYkOqihINIFkxLhjX3fH/Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyUBwyuxjZoCwMGLhI6VrZKjQpxg6DMRrMpRGPzOAaFDIm6SSFf
	si7TzXNaZOxdTFaBmxxyT3olzhRIfqTDW62kdMpO4Q4Sr7HCM0Ii2v62FKcEEkZkri+6LVAYpjo
	Zm1JKuK0k2DtGKH9kwVl77Sn/H5LFHXtAPV5DIKmgR+AhuS8N/PiTEKYUdartxGadJqDxqzj/OQ
	jUsgA=
X-Gm-Gg: ASbGncvcnzZVcxi6Q4adm8fv04Eh2pfxiZJOOhK7rA4Jyvp5CwCfLYpc+XNCJM6ghd8
	5aRW/N7mc79ixtaVbeJukxcGCxRwF7JcStKFkEyiY0RYD/uT15qMy4fc98UoNWTu4TNR1MWK4VM
	049v4EsNmPo2kRImrbXb//jg1+D75zsRehU4M5UMZC5qh7HqR7Rv1S8HuEb4HQKeNejwIj8gB+7
	q5huBBGFFDXkz/GtyjGR52EOIgMoRn0mf7Wy+mO4c5PUwFMNG83TafB18tZS4leCYyRkDq6TB/T
	4WmQlSe3sA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100774f8f.49.1741159636299;
        Tue, 04 Mar 2025 23:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFSwg2gbLwAPlPAn2L1vg/ffvpbpIN3dglqIqZN8294KCbPeBfUkyQP4He1JGn832GdDHxeA==
X-Received: by 2002:a5d:588c:0:b0:391:1222:b459 with SMTP id ffacd0b85a97d-3911f7bd7b9mr1100756f8f.49.1741159635943;
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm19898221f8f.40.2025.03.04.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:27:15 -0800 (PST)
Date: Wed, 5 Mar 2025 02:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20250305022248-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dfE4052fg-IgP-Wkwxp3BhPxLXUIQDMPNuxvGnMTcok_1741159636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself? I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Ugh.

Guys, let's remember what vsock is.

It's a replacement for the serial device with an interface
that's easier for userspace to consume, as you get
the demultiplexing by the port number.

The whole point of vsock is that people do not want
any firewalling, filtering, or management on it.

It needs to work with no configuration even if networking is
misconfigured or blocked.

-- 
MST

