Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F981AED40
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735404; cv=none; b=sayoPjHbdVTPTgVPzkRJRQkLy8lQa51EYaCq+c27JR+J8+1zk1I2JkyrtwiuYb3Ox/oKSogGQNxtpdbDGxoy2YzlUt3rDC6KczlsLx+YMFhRLWT8lIX0UOOC3ZWqVQ9bAbHBLGYHriGBjGnaf7/vTh7z9GBdUx1XNaonPgDvpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735404; c=relaxed/simple;
	bh=Z0PZF3iT3kmG4kVxpER+Pkc+8Vs70AzAJbTnaHohF+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gJfkwAK7h5VQRRGFC6WNo7m1WlvVRVb2Um9XwRUYYfcTBx2j/HamM8dMACowx39BDeaxwP2ot1JMRcpKz6jMgCtidN3n5355r2DndpcFtLFbTDfwbQufohmeHhbKz4NMdWlgtIvBu7h3aXrvss0plpelgT63LEBshUvjxEzTKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFQD0nev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFQD0nev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723735402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0PZF3iT3kmG4kVxpER+Pkc+8Vs70AzAJbTnaHohF+Q=;
	b=eFQD0nevqfO/haJ9/Ucomfn3UuNhzfJNzpIHMP6gaeReC9MKunvTd82n7Q6rbyFvjfSjGt
	UbRXmHIsOs8rJgHMP3jfluxZ8c8tsKve0iDVN2+bG+JNm+F1SDGvi+XtRf2Wa+qBhRotq/
	G+JQckSpTu+5gCmgId2vkEZU+5babXo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-gRtrRmvIPtSoQmX4M1Fd-A-1; Thu, 15 Aug 2024 11:23:20 -0400
X-MC-Unique: gRtrRmvIPtSoQmX4M1Fd-A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7bcaa94892so95387566b.0
        for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 08:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735399; x=1724340199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0PZF3iT3kmG4kVxpER+Pkc+8Vs70AzAJbTnaHohF+Q=;
        b=WjPUGEzkcumuc/HWM1lCEChUwBKTVsRSZqsQM/LFRsWDySc9kMXoNvX2RFr9kG/Tx3
         JynZ9mqWtW3hlHES/TuNTHWJEt2v5xszawY4FtYoN4eQrSeKdiz8AidXeShZOgwtHByU
         ag4cLSMEPhEGMouCFkr1BriLsTxkGLZfzyY7EcQdRRyzvZN6ZI/3CJgz4wSShV2cI/Oy
         8psuRPFJM99y5/nF9KH+iT2Obrv9YyS49ifmYG5bjYIuh6PX5oaDVoOMzG73CizWjp2G
         Kg5Z7h6PCg42DnG0F6+t3srrwqX1rqNMQpXzOeX8AmBQcuQPxPx7dbcNLDMLLCBGNYnA
         y9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVyX0f06o5/QWpfqgUj7O1nZNtrZN20frd85P+9ZU/gsLEsCMsbcOa1sQbRqTAAFFBq6XwoHP2qVLM798kpdOYTgkoyL1AeUqx9XNAInT0=
X-Gm-Message-State: AOJu0YwC5rCeNocL2dr4FFXggPbAZ6uc+vNT/0OHStuTkMkpNrTnW7ir
	lJ5hY0jK2suIs0lfqLFMKZaN7k9bHGwqobbQMN9Y4Es8wfeHq3/qPC4QMILp4iydo8naS6Bxij3
	SptFT8shbDJWfzhJr9/kVOt3T0lCgyndia47Et4poaQt7TNREzPLIxhmVB2jhrg8Q
X-Received: by 2002:a17:907:f782:b0:a7a:9f0f:ab14 with SMTP id a640c23a62f3a-a8366d7786fmr467851766b.33.1723735399595;
        Thu, 15 Aug 2024 08:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmfTaj56j9tYVD0QKL1sNvdoIgl/XRqpaSrAVLu8JRyiak502h9wKyYixOsF/EtaN1gS67Hg==
X-Received: by 2002:a17:907:f782:b0:a7a:9f0f:ab14 with SMTP id a640c23a62f3a-a8366d7786fmr467848466b.33.1723735398782;
        Thu, 15 Aug 2024 08:23:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65f2sm117028966b.29.2024.08.15.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:23:16 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:23:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240815112228-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 09:14:27AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> [side note: the message I have been replying to at least when downloaded
> from lore has two message-ids, one of them identical two a older
> message, which is why this looks odd in the lore archives:
> https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]

Sorry, could you clarify - which message has two message IDs?

