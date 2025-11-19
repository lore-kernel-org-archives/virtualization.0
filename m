Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B22BE646
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538298; cv=none; b=TTsyZpCZAHAtsmDW5INLkfNPWE950O75fReXxT21pCePD+onSRyZ+U6yMPhha4lOqJ0c6j6bw0D/qYlClh0c343qkjthFozkDOH6fANu6pTLIt4a2R7gyvd/W+EFREcRcTH0hbAlNCkqDuvoUEjID8l8s9ylcYVe/OffjIMvEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538298; c=relaxed/simple;
	bh=iuSZl31cNfDpjFGTCAraDYIGCIdU76ltAKtrCane9BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TmvuXedBFcJnyul9+xxLGah/2r8i39OClQX82Ha98AB7dOBDsYEf+BKMoc/uF1dl3MoViEY40ql0p8LDzqgQQYz7L7fFcJTWC8vB1ubqCj2WGjnY7VF2LqDNg+hej4GrEu5LdygyiF2r79eELyFS0Uj5Ol+h8IGa825JAzGgFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoZVh1P2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoZVh1P2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0lOA/3gST8Mqd9BJA+pnAxs8ONfmdiHTJHfsZRHtys=;
	b=LoZVh1P2khYhEzKtx2uzWaHx0WmqdTSnPcr6e/qQ6gwncXG6/pfRiBxdONpuTynCtog2Qa
	Xy0PMxAW3gWZEsnOHgs+PaVYMQA0PKTsfnkSrhwrMLgP4t03RGCvki7MY/B/hjQPeXQmFh
	gQM/sELbU6/rWUf84WojaW54rILsvgg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-6n5z50hDNY-ETLCtTwHBrg-1; Wed, 19 Nov 2025 02:44:54 -0500
X-MC-Unique: 6n5z50hDNY-ETLCtTwHBrg-1
X-Mimecast-MFC-AGG-ID: 6n5z50hDNY-ETLCtTwHBrg_1763538293
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b56125e77so3225741f8f.3
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538293; x=1764143093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0lOA/3gST8Mqd9BJA+pnAxs8ONfmdiHTJHfsZRHtys=;
        b=AtXZOSvInnYyKQfAE3mteuuz4H905l/1/vEYkAA30ue/MJUgsVZ1VusxrSDD8uvbFe
         98W6Auh0nhdpt8lXPPpS5wajRfSvnh8WU/ULQjks+XBs58pXCSWoKyeY1Uly29DMU0Eq
         Yb3KusErJF4y2U1cxXpEULVTCAQe5GzDnL4yq2N5M3hkWdzOT2DKWH13aXcYViSxd9HF
         iKUEGHmN+Z3eaGyaAvViJqjyAJ+or4Y7RDbv2x0Jv7fXDnajX45F/mcO2YhowOLq1Fqd
         r5e0bfxuuC4NqPRMGW8EeITmSJ4CRbGgZjgN4AAI1MpT7ufcqKm/zIpbqZg0XhIQNrI2
         fkMA==
X-Forwarded-Encrypted: i=1; AJvYcCUyDl8qUNLtvbz3Nhv590Oc9fvL9pmaNGyvJNzY/k424yLX8gUCJPkwCorMEOzE1wulQTOSkMBXbgJ3uGnTmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX2rTogiiDwU6NP/wVMfMTBV28IEZFDlDTNylZdEnusjR98LY5
	y4oZcnKsaD6msJPXK/1CZH+SpY4cn0+9lWJx5+ER4k3gliakAduZd65DQgTQ0SATjiSNTVUX0l0
	5i3/It0pGcn7vmXYez5eNaDm6SQXCh7APnQLtqHQuxemHF9kD3KpWWKUzTQWdiKnq6DBD
X-Gm-Gg: ASbGncsy/ThGdwQapNKdFIJGclCFiMvEN/RiDIbiLdUVmk0RtQOD89Ze5GdajOzUghj
	Ehlzo1RzTsyviUECkHKA8Qc/UNLfNsUcFEac6rck/ZaiaDuk2bdvFwwvDmYlfb0XqO5PWYQQm/4
	v5Og8DotF+PoX6E5HH18M8wUY7Pj8k6+rRLLYBnX/G0C1hJQLiftZ8C40wQv2zMbFh1f8NV/0WN
	dsGUCUORsGMx8QjdU8SP2tLiL5NCfDYwvKQj0K7DwMbpDW5NE6XE7E9GgfexCeWGJ+qGvJ4cthU
	/tGJakmq3vgtQ81gmmQ4oNg/8G4VLfyik9DWQYenPmoynNhWnCk0synvzAsu4l+QkdWc7tdgnlh
	DY1rdVzsE1b99HUI+cP97mHO9m+0kNA==
X-Received: by 2002:a05:6000:2dca:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b5959eb99mr20019759f8f.58.1763538293216;
        Tue, 18 Nov 2025 23:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ3KY8fQWjUFd8SZEAKxtk7NCRnw14euQYQO/Wu+mrmA7H+k9ezFKlDwa1hXnBT1QcYNK6ow==
X-Received: by 2002:a05:6000:2dca:b0:429:b1e4:1f79 with SMTP id ffacd0b85a97d-42b5959eb99mr20019727f8f.58.1763538292694;
        Tue, 18 Nov 2025 23:44:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae47sm35263724f8f.4.2025.11.18.23.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:44:52 -0800 (PST)
Date: Wed, 19 Nov 2025 02:44:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251119024442-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-11-danielj@nvidia.com>
 <20251118164400-mutt-send-email-mst@kernel.org>
 <b49d6c7b-ba39-4f9e-9e75-b3f186fe8e0c@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b49d6c7b-ba39-4f9e-9e75-b3f186fe8e0c@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hJsUk8qDK1ykXui2ly27Gc54rO9TrxquGOTtu09SBpM_1763538293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:35:37AM -0600, Dan Jurgens wrote:
> On 11/18/25 3:45 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:39:00AM -0600, Daniel Jurgens wrote:
> >> Implement support for IPV6_USER_FLOW type rules.
> >>
> >> Example:
> >> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
> >> Added rule with ID 0
> >>
> >> The example rule will forward packets with the specified source and
> >> destination IP addresses to RX ring 3.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > 
> > 
> > I find it weird that this does not modify setup_eth_hdr_key_mask
> > 
> > So it still hardcodes ETH_P_IP for all IP flows?
> > For IPv6, should it not use ETH_P_IPV6 instead?
> > 
> > how does it work?
> > 
> 
> Your right, it's works because our controller use that field. Will fix it.

you mean does not use.

