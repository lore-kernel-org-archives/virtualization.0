Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A952ED54
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066818; cv=none; b=CddOlM/U+VDj11szxGYpcYG1JplJpometMkkEx+SGRcSfgAQLNnRwcLPHu7FfSblU8J3ke3mk27PX7SE1ZQkr2fjxOVcBaiaIOG6Filj8so5we/5hCqOh+F/cdDP2Qa1vqn4c7xhqrHGZB5bTG6CtmMc7Hklm5RAjhBlYW/FL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066818; c=relaxed/simple;
	bh=hEj5nL9MRpMH+JX12YZNspzZFd1+3Fuf+CZGgePMxM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DZEvTbh83MzhWd23V6O+827pk9sEkP9d/H+z4oqmd46mKb6xPz5fjW+8ICR+UKtTuXb80Duv0afA3K8hfA9xXEuTo2sqPyiaem3k1mjfwqiT5/T32vD3OWmB2ldwUQE7Bi2R0ndH4cT3LaGLC/vve8xGVGAfsAdvkcRGC6yNEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPtBm7O5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPtBm7O5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790066816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
	b=PPtBm7O5J9SD12HP/tRvqumwwKrb2GaMHrA1THD7uzs1uzeGdvT+YtVVEomkLiG+dmdnUl
	jMQ6cThAO/9QcQBExBWKDP0pkDcUHbQqp0Hx6aFCf7mea7dtzs7QripU8kfQdra1V5pEjx
	tDxHqO04AyNKNOpa7C07D8vut8NCW+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-HmrmxY_yOE600CfNFDFXPg-1; Tue, 22 Sep 2026 04:46:54 -0400
X-MC-Unique: HmrmxY_yOE600CfNFDFXPg-1
X-Mimecast-MFC-AGG-ID: HmrmxY_yOE600CfNFDFXPg_1790066813
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso49783415e9.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066813; x=1790671613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
        b=VoCdxE9rgP+QO1qaOZ59rv3kS8Jn3v1Ace94Y0pCnZWGb0d4foZ5cu7m4eygYuYcxc
         L9ZpMS8dSuH5WXDFmOc9xi+B7EBwHQn+3PYWCU7R3cp6Ci9N1/FqsfaGrWiwqpv2FWCU
         ad6VZ5G8xNTQJpu0TbGwtrivnemjPUzXNeM6hd+vBpXwG0IBjlLmaJ/Ml77Xvc743bn/
         E2yLTCUdGW/8Q9n2CqJgC0V53z2XAkLjagyCAa9o2yLX/WuhWxAgXZHkDS8eg57Wf9M9
         IuXdikX4U3Op8WCk95I5L/uxEtHyrvbtb1BoH8rDqiAgGxynx+7HHMEd5MN7ooAEzuk3
         CP0g==
X-Forwarded-Encrypted: i=1; AKwUvBwakSyVajwrbhgwCuKGV3TrmE/+zMZhfCJiHnnat14MVQjJJj47eHl0RwsSTIabCs9wsqjwOYZcG8jC8pgVgQ==@lists.linux.dev
X-Gm-Message-State: AFuF++l9tED9JM6Gu02vdhBK9BHJa++2/fQ1Ur+n1JIYadmBqiwTrVry
	a0qfgM/N7z+CnKj6sZ7bL+xY7OadakIerI1TtBxpB7thgjMrV/NWHPFVG53jWSPQqk1JEwbnkkn
	1V3tvpju4pGv+L7H5bwn5mwIhiTB7Rv+VxqKx/YG00/QtvUTkOAxdNCsHZkW3uvu0PsWq
X-Gm-Gg: AYBFou0k59QS/l398XljB/DIxQuansk4znN4v4DJguSJcpnFus8xNg/ptFFiUGmO8KT
	Yi8ok8b5oIRAJhPqGO9A4SAPXQYzlV0EnZQKjZWD5ReMsOFDdrpIh3+7JL0/sRtAmmqW7EjeUwu
	Ilxt+5actlvI5P8U1PMTlydjhwBvhkI96tMqh63+t+9XGQgY2Ao3bRUWqziG5YxIwvVZcXXLqT5
	quKD/YCJb7AwpgN5RJF/V5ODRz1efcsQM3TM1MAOeQfiWu71r6T0MPXZ8udQiMg8ixrX8Xcs2se
	s/9yMZUn3LMd/z/77oaalx7YYSBFh62lVg5DkSO11GkP5zG8U7PIf8wuYlU+WwM/KfISf+C3Z0g
	epfoWC6cV5j4eXVklAD6qUyc=
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094955e9.13.1790066813200;
        Tue, 22 Sep 2026 01:46:53 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094445e9.13.1790066812661;
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm65246905e9.8.2026.09.22.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 04:46:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch, pablo@netfilter.org, fw@strlen.de,
	phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260922044627-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <20260922005353-mutt-send-email-mst@kernel.org>
 <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iJJ1z_VttF5ll8m2hwbvJuhd7kBivbxSY24oo70ahas_1790066813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2026 at 07:56:23AM +0200, Johannes Berg wrote:
> On Tue, 2026-09-22 at 01:14 -0400, Michael S. Tsirkin wrote:
> > 
> > >  
> > > +/*
> > > + * Return the L3 offset and protocol of an Ethernet frame starting at skb->data.
> > > + * The offset is unused without NEEDS_CSUM, so avoid parsing and return zero.
> > > + */
> > 
> > for networking code multiline comments:
> > 
> > /* always
> >  * look like this
> >  */
> > 
> > /*
> >  * never
> >  * like this
> >  */
> 
> This, for the record, is't really true any more - we dropped the special
> rule a few years ago.
> 
> johannes

Oh good to know. thanks!

