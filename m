Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FF382380
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054896; cv=none; b=mp9M4Q79TQls/sftDwfUFFhivxXy7CZddAFDog/wPUllRmMxsE4mlx58qYLSD4YwCYz+HVjbK3/JdwPlvxWoKdneAHoO0/ixf8uUypkv6cgsqqZn9Ebs4vMwn6P9KO8P1VBfBLC1QUyhBsuaIP1M/OTKlIUEm15LJLzbFRRJBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054896; c=relaxed/simple;
	bh=L/5x8vasanva/HhgUz7beKEPCoiqOfWlzd3OFM9SHJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M++iXeFORz84+IAfr+j9io42yb4s9SMRJJ/WHEiIPcZ57HMcUkP7qhg81vW3bHgzzFPfeqijlWzxAoZ3oprvlNk+ZnRvHVqXIry5oa+3qqZJ0VwNJQ7/XqUCFp1ALo44q9865Y4YKjIzCTXlxO+MGBf93M2bW9mh6V/uKE+5ZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ratatoskr.pengutronix.de (unknown [IPv6:2a00:1f:f805:4b01:1e0e:d42d:4ec8:33b2])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8C544200F4C;
	Tue, 22 Sep 2026 07:28:10 +0200 (CEST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Richard Cochran
 <richardcochran@gmail.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  virtualization@lists.linux.dev,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/2] virtio-net: add flow filter for receive
 timestamps
In-Reply-To: <willemdebruijn.kernel.2e1c6881ed336@gmail.com>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
	<willemdebruijn.kernel.2e1c6881ed336@gmail.com>
User-Agent: mu4e 1.14.3; emacs 31.1
Date: Tue, 22 Sep 2026 07:28:09 +0200
Message-ID: <87se31j1na.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed

On 2026-09-21 at 21:31 -04, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Steffen Trumtrar wrote:
> > This series tries to pick up the work on the virtio-net timestamping
> > feature from Willem de Bruijn.
> > 
> > Original series
> >     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
> >     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
> >     tx-tstamp and tx-time
> >     From: Willem de Bruijn <willemb@google.com>
> > 
> >     RFC for four new features to the virtio network device:
> > 
> >     1. pass tx flow state to host, for routing + telemetry
> >     2. pass rx tstamp to guest, for better RTT estimation
> >     3. pass tx tstamp to guest, idem
> >     3. pass tx delivery time to host, for accurate pacing
> > 
> >     All would introduce an extension to the virtio spec.
> > 
> > The changes in this series are to the driver side. For the changes to qemu see:
> >     https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps    
> 
> What is the plan wrt the virtio spec? +1 on demonstrating working code
> first for feasibility.
> 
> Does this now also need a spec proposal to virtio-comment@lists.linux.dev?

If this shows to be the right direction, I'd create the spec proposal. I find writing the code and see if it works much easier ;)


Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
