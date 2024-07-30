Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81418E04C
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376483; cv=none; b=SbADpT2E/mzo74GdseaCI7qK1AFRYeRKxT2NmGtCraqAkB/+a0Lt4FiAgNlGzKBOpHguUsfZRK5KdXg/z5ijjBZdPk8ilcKsrTBgBzi0/nKcyYF3LYi3hKCPebjrZZ/KUApM2l+JnppdAG2MzmQUbWPfwyohhQqbhh19IiSCT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376483; c=relaxed/simple;
	bh=xFNqKNUZC3QPbCH+2C+qGCkgqdGmxd4GGQWFBPEVmcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HOLlX3X0CCCu0T4j+VF0gAxvEupF3YPkSyvku6bdDLLIHmPJIM2LZKZ0CTUUhLqr8hQs/H1d6U/NOZNDDunHDRjUKNLgH0p5bskYdOW/xArx8A0mwyZ/vxgPU2LP6JAOLWMObgqok29cTBHnl+selk9/epknf8RPRqfljo6UVnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IB5pgjF8; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB5pgjF8"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2D4C40B8A
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 21:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5qyTYzldwm4 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 21:54:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D0B92400E2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0B92400E2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IB5pgjF8
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0B92400E2
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722376479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiTAbji70C9FYBLGjSmfVHzEQNNemDMhCb/cI468cQs=;
	b=IB5pgjF8qrXd+y9toOmjyn+tHNf+65YeNYozfWElwd7Xw9nuni0Eywb+uJ/cXYlvD6aido
	ZbpjPv3kndEl6DvkJRYpGo8ChBakHHhVSa7cvIVVBbrWu46mDMgXsrPVZAdxhiaEU6+/34
	VbMybLLlRLRPcgtPTRqOD7E1G4RBf+A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-rypad-V5NHqosw3zQ7jq7w-1; Tue, 30 Jul 2024 17:54:38 -0400
X-MC-Unique: rypad-V5NHqosw3zQ7jq7w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a7b5bd019cso5003877a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 14:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722376477; x=1722981277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiTAbji70C9FYBLGjSmfVHzEQNNemDMhCb/cI468cQs=;
        b=jjKvpdM8whOSRr7n8S/HDmImd1FikFk0mIlNX7CfrRlXHvA+ZGPPoUJyQbLmKL8qLB
         ruVzUt0wIYwYoxNnsF9UIIer4mfi0gK4qc0e3UAWulXvnXaXT1L+96MA2rOEUQDhyFPw
         tQbN6Fn6tuK1SnjJez4Si3B55vha2atavhx1+4mPj3eoQf6YVIa/k7LjTFnO6IQo+WbS
         0Dd6qEYIRJpoEEGgUfaPGmsf72Duvb1oijO6GB4G2S1Y3DndsKf+Cjf9WMc0393btJXJ
         99Nm375WORD/ArzuFWmDxXnOJc2LZMV/xl0G36Nup83n4J0i4ot2d6jiSJ94XG4AI+/0
         e51A==
X-Forwarded-Encrypted: i=1; AJvYcCU7R2mm/elgtTpVAJjZiGZm6PHTHHp5xa9278kZiyNWCUt36c83q9hkFeLWcTUHBymEdoC4i6C3jDOWoxFAFU5P2Uaee1H25oUIKcweG9WBxkkO2VavoMiWag==
X-Gm-Message-State: AOJu0Yz8RCvPN1KAzaf++SKq7Dwo1ilOEhUqz6VhKV5CleHFC6HOxbUl
	+D9HKlNbHuOthaSI0+qp+QiBMFsUR5QvJ30cCdaQtP1Nmz/sV4MZrtMg9QIvZ4j9SsvFjVeUVzZ
	hUr6AC1WvBajXfaf6qI5WryLPpF25BBwXomFoTtyO8dYOsKNLEiib0JxZLuJh2oeXQtXHZpS64F
	/mdWM=
X-Received: by 2002:a50:9fc8:0:b0:5a4:6dec:cd41 with SMTP id 4fb4d7f45d1cf-5b021d2231cmr7849782a12.28.1722376476800;
        Tue, 30 Jul 2024 14:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBAMnTW+0ZR0faIaLVv8dqaI6j7fVqABVL6hy1VheVczujzgMg8WoKj65x/wzQERyVgM9dXw==
X-Received: by 2002:a50:9fc8:0:b0:5a4:6dec:cd41 with SMTP id 4fb4d7f45d1cf-5b021d2231cmr7849761a12.28.1722376476162;
        Tue, 30 Jul 2024 14:54:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:d5c3:625c:d5f0:e5f4:6579])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5afa605d81bsm6216832a12.74.2024.07.30.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:54:35 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:54:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1] MAINTAINERS: add me as reviewer of AF_VSOCK and
 virtio-vsock
Message-ID: <20240730175120-mutt-send-email-mst@kernel.org>
References: <20240728183325.1295283-1-avkrasnov@salutedevices.com>
 <20240730084707.72ff802c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240730084707.72ff802c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2024 at 08:47:07AM -0700, Jakub Kicinski wrote:
> On Sun, 28 Jul 2024 21:33:25 +0300 Arseniy Krasnov wrote:
> > I'm working on AF_VSOCK and virtio-vsock.
> 
> If you want to review the code perhaps you can use lore+lei
> and filter on the paths?
> 
> Adding people to MAINTAINERS is somewhat fraught.

Arseniy's not a newbie in vsock, but yes, I'd like to first
see some reviews before we make this formal ;)

