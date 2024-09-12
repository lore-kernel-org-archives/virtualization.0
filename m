Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DB1F947
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106431; cv=none; b=n+3b4qAyEkoNkJCWQFqpA6WV5S/Cq/SkuEJSbBJl++RmPerdfKMTOcsTxbkSAjq4G5/KIG7Idd3P2fvAHTshESzHzGsNqF/6JVE04fu2vIhhVrwTrZTDOrwEhaEdQvHryVNvHcsA8EweK+EoZjrH+8KA1wfPOp5NVxkrMEuaOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106431; c=relaxed/simple;
	bh=RyfVw4JlB9dX3F6lBs7Z0O6/mcYHQlGC2ZnZAUdz/h0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=nd1fC2O6ZdWimwCA+4VSlvDIqRdv0OcaUSlWqi2ePiwbEefhx2/gjWON7pHYYJwJYuYmaLSHN+51Hd5rkwAi3Vlq98vpI8bLEjjDFT3sF0Fy5DLElTRauRGxdLKu6DNHbMvNz6TMsQTkpUbbva7ew/5DXBtdI6aSNWr7lYmiBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E2TOlzz8; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E2TOlzz8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726106421; h=Message-ID:Subject:Date:From:To;
	bh=vzkNLYPu+Av9SBxAfLReDSvS44iM2OzibjEnsrfCDEc=;
	b=E2TOlzz8WeUcAzfCSgjUCJPmVfmd3rLJ0iPXOE8pHq0SfBE8bL49cyW0b1L7BohZ2NKWyklToA2+uQE3Hey/6oBfZ96w34BzsutzKqByHiloqc7JvMRRDJzYrKNpb/Vndni9vJmWPp7Le8hBWOIRX9jXjz8XCc2BtKycXtwJcfk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEpaJDd_1726106419)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 10:00:20 +0800
Message-ID: <1726105750.1529129-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/3] Revert "virtio_net: rx enable premapped mode by default"
Date: Thu, 12 Sep 2024 09:49:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Si-Wei Liu" <si-wei.liu@oracle.com>
Cc: virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
 <20240910081147-mutt-send-email-mst@kernel.org>
 <m2ed5qnui8.fsf@oracle.com>
 <20240911102106-mutt-send-email-mst@kernel.org>
 <29017a97-7a5c-49eb-b866-e6b22fd8baea@oracle.com>
In-Reply-To: <29017a97-7a5c-49eb-b866-e6b22fd8baea@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 11 Sep 2024 12:30:49 -0700, "Si-Wei Liu" <si-wei.liu@oracle.com> wrote:
>
>
> On 9/11/2024 7:22 AM, Michael S. Tsirkin wrote:
> > Thanks a lot!
> > Could you retest Xuan Zhuo original patch
> Which one? I thought Darren already did so?


This one[1].

Now, we revert these patches to disable premapped mode by default.
But the bug still exists, if we enable the premapped mode manually,
the bug works again.

[1] was attempted to correct the bug. However, Darren reported that it did not
work. On the other hand, Jason, Takero, and me tested it and found that
it worked for we.

So I ask Darren to retest [1] if he has the time.

 [1].http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com

Thanks.


>
> -Siwei
> >   just to make sure it does
> > not fix the issue?
> >
> > On Wed, Sep 11, 2024 at 03:18:55PM +0100, Darren Kenny wrote:
> >> For the record, I got a chance to test these changes and confirmed that
> >> they resolved the issue for me when applied on 6.11-rc7.
> >>
> >> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> >>
> >> Thanks,
> >>
> >> Darren.
> >>
> >> PS - I'll try get to looking at the other potential fix when I have time.
> >>
> >> On Tuesday, 2024-09-10 at 08:12:06 -04, Michael S. Tsirkin wrote:
> >>> On Fri, Sep 06, 2024 at 08:31:34PM +0800, Xuan Zhuo wrote:
> >>>> Regression: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >>>>
> >>>> I still think that the patch can fix the problem, I hope Darren can re-test it
> >>>> or give me more info.
> >>>>
> >>>>      http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >>>>
> >>>> If that can not work or Darren can not reply in time, Michael you can try this
> >>>> patch set.
> >>> Just making sure netdev maintainers see this, this patch is for net.
> >>>
> >>>> Thanks.
> >>>>
> >>>> Xuan Zhuo (3):
> >>>>    Revert "virtio_net: rx remove premapped failover code"
> >>>>    Revert "virtio_net: big mode skip the unmap check"
> >>>>    virtio_net: disable premapped mode by default
> >>>>
> >>>>   drivers/net/virtio_net.c | 95 +++++++++++++++++++---------------------
> >>>>   1 file changed, 46 insertions(+), 49 deletions(-)
> >>>>
> >>>> --
> >>>> 2.32.0.3.g01195cf9f
>
