Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEE3DABE5
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630705; cv=none; b=TILIhJq7j6pqhxEEAZXwR5r3Pgk2yLh7bHXu8qgtNiaCg/6032UMkEK4VHPuPT0leFy15PZ4Le1GMotWyIVMMKj9dyQj31+EV6cM2kL2HJaVhlrAxI1gX6XTKHXTdFr06Eo2HcAfzR2lL7cm/91G8QPClTslp6eYb2CcC9HuVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630705; c=relaxed/simple;
	bh=UffNg64kltXiNMQy07YaTpOg7r4pBCC49Y6FPB+maXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d4ptT0ZH6gtIQLz6z3IN87ffbLcuLxGbtcfs/EF4du12lDOK+nO6oWlMmn1rnsGjirUXdBuyuyIqyG1BPgZMcj9KgJg3igOzvZFweqtt+wZ0N2G0892xPT3jAWzltNPjeI+EMC1WywJFzZoECSril6DSHsSTpxirAmDrOyaZ8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0QSnAJT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0QSnAJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718630702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gNdwNvulKIO4JOfhW5zSdvn5q7O0IrSkNwM4LbWgZA4=;
	b=I0QSnAJT6vYXtZA7AVTv8eToMQce1tWMb0WK/+ORo2+MDsAK6+nAv3mUvAot1aWKmh3jrX
	D3q3dyqcEijx/qFCL3R/otL4Ku2QYzZpW9MlrtvA8jvBUJo+JbNNE+jllS8FKyFIWmBOu6
	tEZIgVrTzj1mQy0mIYh8sCHb/nqF2uk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-AnrWj2-LM1upyI0-JtofWw-1; Mon, 17 Jun 2024 09:25:00 -0400
X-MC-Unique: AnrWj2-LM1upyI0-JtofWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f2030f868so3158167f8f.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 06:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718630699; x=1719235499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNdwNvulKIO4JOfhW5zSdvn5q7O0IrSkNwM4LbWgZA4=;
        b=GXRCMUkRj5l6J3RA4XR2cVHjfmSF72nJ8Tkl+rh5X7ZBqsLB2JFlmo9xX+Mt3C/nvq
         A09S4++2LgQ/GQHyqkKlx8WbGhVSmLNcKJ9DX0OHgBxRwB4kXgeTqz72mu4nbplzKEe2
         vx2dBXr3WPuzH/3KafUc1z49zM9RZ/1xnJbjT2qiXZCd1CwUGrrWG3D7ccqQuj+t4Ca/
         s0NyR00t2oLkofQsl9REPsZlf/QEbmZhKDN7gg51748k+FH4z8vFo9/DNo3IfxDBOrZ8
         f1d9p0R0AIrtBbx6grYUS4IPwxci5+mvCn3v5drtxrYu+mWfPqxmPcMdHlBmEuZEDRDn
         OqZg==
X-Forwarded-Encrypted: i=1; AJvYcCWgM+9NbyZd2HtKzHoyC2YL7tf7DwcIWSoehCEfYTuIs7gcNMK/lB9KsvIN1A6wzL/lc/o5hzkiVVKk2XTo1aI0Pca38wwGHfAcbPvR4jo=
X-Gm-Message-State: AOJu0YxFeuLDvt0sKUECJ36C/Uktl3tL6zq0e+ot8PBJAysWxP2fsXtJ
	v7qern2kITxaIZ38URehwEiZpnphwyP4KXuox+TAMeLur1Z1I/ulFP3xNAcUmCKhEjza4KtAoHk
	/9i/lNzXiTNl0QepYpVRee6mjxe8DjlCNq/QEypa6SZL8clLZQCgvZzJC/SNLzk8/
X-Received: by 2002:a5d:46c6:0:b0:360:9a04:57ba with SMTP id ffacd0b85a97d-3609a04587dmr1509643f8f.31.1718630699512;
        Mon, 17 Jun 2024 06:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRxoRznz4bsF2t8WDRmKhi4N1xEAy+HXiK9JIkYxIFPdtbiwxr4Y2KaDbSLkoIb3poAiSTrQ==
X-Received: by 2002:a5d:46c6:0:b0:360:9a04:57ba with SMTP id ffacd0b85a97d-3609a04587dmr1509626f8f.31.1718630699176;
        Mon, 17 Jun 2024 06:24:59 -0700 (PDT)
Received: from fedora (lmontsouris-659-1-55-176.w193-248.abo.wanadoo.fr. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093499sm12071989f8f.8.2024.06.17.06.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:24:58 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:24:56 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: sgarzare@redhat.com, edumazet@google.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, 
	stefanha@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next 2/2] vsock/virtio: avoid enqueue packets when
 work queue is empty
Message-ID: <jjewa7jiltjnoauat3nnaeezhtcwi6k4xf5mkllykcqw4gyfgi@glwzqxp5r76q>
References: <20240614135543.31515-1-luigi.leonardi@outlook.com>
 <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AS2P194MB21706E349197C1466937052C9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

thanks for working on this! I have some minor thoughts.

On Fri, Jun 14, 2024 at 03:55:43PM +0200, Luigi Leonardi wrote:
> From: Marco Pinna <marco.pinn95@gmail.com>
> 
> This introduces an optimization in virtio_transport_send_pkt:
> when the work queue (send_pkt_queue) is empty the packet is
> put directly in the virtqueue reducing latency.
> 
> In the following benchmark (pingpong mode) the host sends
> a payload to the guest and waits for the same payload back.
> 
> Tool: Fio version 3.37-56
> Env: Phys host + L1 Guest
> Payload: 4k
> Runtime-per-test: 50s
> Mode: pingpong (h-g-h)
> Test runs: 50
> Type: SOCK_STREAM
> 
> Before (Linux 6.8.11)
> ------
> mean(1st percentile):     722.45 ns
> mean(overall):           1686.23 ns
> mean(99th percentile):  35379.27 ns
> 
> After
> ------
> mean(1st percentile):     602.62 ns
> mean(overall):           1248.83 ns
> mean(99th percentile):  17557.33 ns
> 

I think It would be interesting to know what exactly the test does, and,
if the test is triggering the improvement, i.e., the better results are
due to enqueuing packets directly to the virtqueue instead of letting
the worker does it. If I understand correctly, this patch focuses on the
case in which the worker queue is empty. I think the test can always
send packets at a frequency so the worker queue is always empty, but
maybe, this is a corner case and most of the time the worker queue is
not empty in a non-testing environment.

Matias

