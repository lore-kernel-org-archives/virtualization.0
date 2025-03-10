Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36111DED43
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637686; cv=none; b=DK+ZyH+d5F1tRzgV9sFS4Pf1bHCQNbDE1ejZYINuGfJg76Rz4r6ejDKL0V0bIll3JuY3aJBAiaG/cVL+vnSDRpn65XsG9U8s5fKOb6QM3HgeHVvDV9MPOwOms0YfqZZWltGT3Cfc3WrKP0Cuj8RaFHs4nU/1+lEtVoFzUnNT3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637686; c=relaxed/simple;
	bh=8iEcHXkc9LSURdsHe2A+6jQjFaaSOLr9zyyzvR4j+oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrmXPoUolPeefnS4HuC0MQB0NQls5AwM9YBu3adFMCpbvpPTJYa3h592eRpQEkD1JOw/c5Cd5vnF5opC1S14eLp1DIBj/oEg5noYsb0Y33BtNxEfdjRLl9Etp+wfuyvCwYGdKwyku+kZhQ9qfn6IJx2rJZRsNS3NDexC5pJ5x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGV6FWMs; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGV6FWMs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A7EB40527
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 20:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdMmMcyY3YtL for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 20:14:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3BD2A40024
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BD2A40024
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SGV6FWMs
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BD2A40024
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 20:14:42 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso7700176a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741637681; x=1742242481; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8VCJDvDifH6QKwricJgYOLTAKH9PbYZJOyD+3nB9w8A=;
        b=SGV6FWMsXQOTc3Fd0TP5AOUZXd0zCO2Pe/jpa0M7cR/G0yNVvC4XWEpU1QCdOej0FV
         HnIm0iPiV04Tu6MZb4ptfXqDVXwbBui5Htd36gIe3Ur0s2g1YMpvEGrmhUxinutJBQrE
         mjlflW5W7Lrrh6Q/l1gVCV5T416FTJF0fbO3fptKCyiWS4cJe+Bye3rI76NH4pVdnwKC
         dXog+b/gS8czi+lS2l9KPZOm/4R7BePWboqd67+ECImvfB6Eg7+O6NVUqys/+xgNFBr7
         MFxuOO4oPBE+oBAfeSWV5Vbi3lt4yKtGwOHQaTbzBUfBscFojNLD6L9TDBTo4QyWhigE
         ljOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637681; x=1742242481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VCJDvDifH6QKwricJgYOLTAKH9PbYZJOyD+3nB9w8A=;
        b=bQfef+8lqUpmmhsBNhHRYk5jzIslvuTR2lgnNOHNBwQTG+L+YS1WzKfSWBD5Fyp2V1
         a6vkBFfdNjNgXaH/Gsue3VCt4A8eEAUBmAstceyH1UE2Kld8UmogMZRVfLO7Nydnzq/o
         AZEh/ZAQ7Ijxefnb3p+LYd3CQLzlOC21tPWJRp0OLNbmHu8Q9vdRkj6sYEKDrwo5O68b
         /M8QW6lCAHRAyGy9kpkwNdA5NQGmcxrPjk0WmcJtZhzw0LvrVQ304xKOLHZ8We+ZX1OW
         PSjA8u7GtFqgDZwhCV/8Ur6ZY2t8HqPkqkXSqY+llYRAg2MjzsjxWUAN6JWjih1xGnGQ
         VD+A==
X-Forwarded-Encrypted: i=1; AJvYcCUlV5R3f+rzR5RvCm8h/TtdtS065No/nepjP8dzarIij0O8r/wFQ6xVQysN+A+/bpJlTJ/RLW8MAOKz4+Ldnw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzLz7FmhGXxS3fd0vYkHpJy2Kd2C/LQMlYcXeZ9vowluzRVySNt
	n/7FeYCxC/NyiL5CLs5FWAJ20KrqMkPhsnhitbBZc/33r0pGYt8a
X-Gm-Gg: ASbGncsXG+wer4CAYRIAiWnsDR6Kdnblwr2i5LS4gs+Z+VjDfO4igYw2mPVJcq836bN
	bzy89FjMoZ5pwikoABHxuql8qbNFg+itqujGbe+Z3fRCGIRLxKUMLu3883N6QQRt0xAVaOnivN+
	Rq/NwRwV6Dk80iCE3dkWHs0zFZdTsSNLEtgyCvHZnswCHiuBEgOM9qX0bYuR955OrVhjJA9MJU+
	1/1ZBj2AUPnNL0CiMFqTRogg2mOv6k4CwOj9pqpUsr3KhfYHQ45mrco4p2eJ8Lmp6rh5Q3IfE+0
	V7m/bt47yEHl7iOwM7zGAb4ku1jy/bo03+Bzd7mmKI1jpRYZKYtGAu3BrqfOLxJRKw==
X-Google-Smtp-Source: AGHT+IGGtgGnLtHGp5hJ/nBMAaLcHC95KiwN+PXL01qiy3ZPgyM0bcKKidXs9guWID/UnTwOCCd32g==
X-Received: by 2002:a17:90b:1a86:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2ff7ce59755mr22191888a91.5.1741637681325;
        Mon, 10 Mar 2025 13:14:41 -0700 (PDT)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30102709b6asm26289a91.1.2025.03.10.13.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:14:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:14:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <Z89ILjEUU12CuVwk@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
 <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
 <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>

On Wed, Mar 05, 2025 at 01:46:54PM +0800, Jason Wang wrote:
> On Wed, Mar 5, 2025 at 8:39 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> >
> > WRT netdev, do we foresee big gains beyond just leveraging the netdev's
> > namespace?
> 
> It's a leverage of the network subsystem (netdevice, steering, uAPI,
> tracing, probably a lot of others), not only its namespace. It can
> avoid duplicating existing mechanisms in a vsock specific way. If we
> manage to do that, namespace support will be a "byproduct".
> 
[...]
> 
> Yes, it can. I think we need to evaluate both approaches (that's why I
> raise the approach of reusing netdevice). We can hear from others.
> 

I agree it is worth evaluating. If netdev is being considered, then it
is probably also worth considering your suggestion from a few years back
to add these capabilities by building vsock on top of virtio-net [1].

[1] https://lore.kernel.org/all/2747ac1f-390e-99f9-b24e-f179af79a9da@redhat.com/

Considering that the current vsock protocol will only ever be able to
enjoy a restricted feature set of these other net subsystems due to its
lack of tolerance for packet loss (e.g., no multiqueue steering, no
packet scheduling), I wonder if it would be best to a) wait until a user
requires these capabilities, and b) at that point extend vsock to tolerate
packet loss (add a seqnum)?

> >
> > Some other thoughts I had: netdev's flow control features would all have
> > to be ignored or disabled somehow (I think dev_direct_xmit()?), because
> > queueing introduces packet loss and the vsock protocol is unable to
> > survive packet loss.
> 
> Or just allow it and then configuring a qdisc that may drop packets
> could be treated as a misconfiguration.
> 

That is possible, but when I was playing with vsock qdisc the only one
that worked was pfifo_fast/pfifo, as the others that I tested async drop
packets.

Thanks,
Bobby
