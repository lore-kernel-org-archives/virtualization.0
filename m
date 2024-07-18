Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA64145A16
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331556; cv=none; b=LuVrPjaLcpfeFKYfC9F28kmfcdnJ6d2cdn4k2k4J3Vuy7L9P6KRezw51Rh7WGxPwVLv3KvKpX8lO9IEEOufHdBFKf51xX7oq6tRvlwB3HN45EVXxWW/WqKi6r4Uo0QOPQlvURaPECFy1IwC8REy5SuDavutpOJ96YhKP1vlpf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331556; c=relaxed/simple;
	bh=YNdqwy7kCRnthAWGt25BAuPpmrM1cC32dACjVkXCQHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=knS4ALh2ZxThkDkntu7am0oPQngnqPPSzu/sD4eHNcOmJl9Ct67Lqh135IGDT5WpZTPdw5uPasQuQMLybr/725yileY5ajVSbAzKGvDtbvdbfbBMtZOc8+s7QaDAW78ju2I3Ed+68QsmboZmQIwWanDzNQbXPLs+nyzp3O5NCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/7V5UtS; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/7V5UtS"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A01CB40967
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 19:39:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WEt1hQEKIOIt for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Jul 2024 19:39:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B216240964
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B216240964
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/7V5UtS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B216240964
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721331551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+Nl6R9d4RbpOHYlmLt5JwqOfz9o9yrilMSlqF926WM=;
	b=N/7V5UtS4LoqENruXU7JIX6Oc0wqa01elx5CLPrZGR+cc8vhv+w+dXIEg1HAnSq88qK4ZK
	KubuZhC8nsd9ivgnqI22xgIkqo5iwPLAVeVWpLOAoaLAVQWCn2x1cnvUSpahDlwJ3USzMP
	0ID8V9hjgxx790z2TxVjos5eFARPxbA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-p1xXnKKeOCOdeo22TR6QjA-1; Thu, 18 Jul 2024 15:39:10 -0400
X-MC-Unique: p1xXnKKeOCOdeo22TR6QjA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57d3eca4c01so96008a12.0
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 12:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331548; x=1721936348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+Nl6R9d4RbpOHYlmLt5JwqOfz9o9yrilMSlqF926WM=;
        b=VoziqD6ToMCN2PlmrhODOLb5fTrTpHGfColxn01sLb70BOtOveZ6Dr/NatkYxmYEZw
         /7zdB293DpYk0ME1vla83RXGe8/dpzcheKfOUsXiUeNEMMYQnpTZpbhRQTt6m6ofNCbJ
         6ztBYzANtfhQRRw4ssCRaK5vte/UHDKF9m1SNU1pMDBGkwbcXgUEqVhlsUMyBpKD6mtR
         YhjAIeEdUXJ9RzbUGsSCWffwFCkuclGBi/KkDzsOBF9gxjCEuW4yL9EKAgcWT0cfmyp4
         zbqmx27i3mhsKf2WhodKGqxOiGCncucDtI6UimSlnBMODTeL5SfUbDB+/WvEYZ1a8cPQ
         62VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT196hPlcjpJRCric8KEWFaGRA3wkMsInq6f5bYe5UTT1PxEgYRdpQ0OM8hIg8U63t4s6E8TtLAG6zQ3oFTe8Ba0uNrfsOQ3TxLcnRq+MupBU6OC5FaYutjQ==
X-Gm-Message-State: AOJu0YwpzpvdaAyX3pakwkEGYYEzf3Jg3KvAggBkIz639aWwDbifkpiq
	5Vo0dNaMWPxFHp8EdVxM0cJZm8wlv1qs0oBS3XyuhIoxEupp6h98c8SDqNYJnR8YkzKP1kDbNDR
	0kPkzmrlbCqlZQwUz5tQv50Ktr/VQYtQlNtfHQHxyxaHtEqc9Laf7OqU8eRfyan2LjL0uZQa4lu
	NItlo=
X-Received: by 2002:a50:9e85:0:b0:5a1:6c50:a3d with SMTP id 4fb4d7f45d1cf-5a16c500aa5mr2188084a12.20.1721331548112;
        Thu, 18 Jul 2024 12:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaoGS44bEP46gwargFeZVeVI2AZznegXlDO8vExCziupfmD6LupuDU+NRqxyVgGi7d2vM86g==
X-Received: by 2002:a50:9e85:0:b0:5a1:6c50:a3d with SMTP id 4fb4d7f45d1cf-5a16c500aa5mr2188072a12.20.1721331547261;
        Thu, 18 Jul 2024 12:39:07 -0700 (PDT)
Received: from redhat.com (mob-5-90-112-15.net.vodafone.it. [5.90.112.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a2b8665941sm228569a12.86.2024.07.18.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:39:06 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V2 5/7] vhost-vdpa: VHOST_IOTLB_REMAP
Message-ID: <20240718153724-mutt-send-email-mst@kernel.org>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-6-git-send-email-steven.sistare@oracle.com>
 <CACGkMEurG88fXiThyainxbuzpgBUzzGkmvyQB5vuXsU7_6XBBw@mail.gmail.com>
 <d738a0e2-5a17-4323-9c86-b5a806066292@oracle.com>
 <CACGkMEuj-6EcEPo9xKkmuPSaQPQnH6zG+j2cqLRiScWUB4oqXw@mail.gmail.com>
 <5a1cfaaf-64aa-426a-b1b4-da84a66b362a@oracle.com>
 <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtuErg+nd96k6FkL9dfSxOv2o38L1HSsK9jU-xmmkv8oQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2024 at 08:45:31AM +0800, Jason Wang wrote:
> > > For example:
> > >
> > > 1) old owner pass fd to new owner which is another process
> > > 2) the new owner do VHOST_NEW_OWNER
> > > 3) new owner doesn't do remap correctly
> > >
> > > There's no way for the old owner to remove/unpin the mappings as we
> > > have the owner check in IOTLB_UPDATE. Looks like a potential way for
> > > DOS.
> >
> > This is a bug in the second cooperating process, not a DOS.  The application
> > must fix it.  Sometimes you cannot recover from an application bug at run time.
> >
> > BTW, at one time vfio enforced the concept of an owner, but Alex deleted it.
> > It adds no value, because possession of the fd is the key.
> >    ffed0518d871 ("vfio: remove useless judgement")
> 
> This seems to be a great relaxation of the ownership check. I would
> like to hear from Michael first.
> 
> Thanks

It could be that the ownership model is too restrictive.
But again, this is changing a security assumption.
Looks like yes another reason to tie this to the switch to iommufd.

-- 
MST

