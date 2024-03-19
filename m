Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F57EEFD
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836994; cv=none; b=UwkO7WPVJPlVbFT/JMtHr3M3Ycv+MI13T6RdG3tmBuh0Yhus9xCBoKjbOhtCQHo5GTP5zB31DY/exSHCI30h1QdNpEeeUiu/LASwlIZ+Poxggxza6QroFzMNsdGo6IqMVhfy2EhUTEgIEy5vPnzymdg97I2aJCvcD0e1GoxdiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836994; c=relaxed/simple;
	bh=Uhw7X37ePZrOYI/rJry/tZ9rI468Mam9nGel7TLxUcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=omriMz2sltfSIfwC7oB2r329i5zdQsYWSRgq0JGr3+aNXpIZcUSVwVYPPjkMjdpiPDq8gHBtoeKONs6MdRJRQ2YSTe0bOv4oALPQl06GiRRI2p+qYHmN9rI1QnBjSsxD+4ZyqmHeAJ0LVZdv8WsQLn0yM/VEyCHvyRFLxxYJkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcxcOuzo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcxcOuzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710836992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bidhNprDIaXErWo++B8NK9gU1Mr0P973Tkk526SOsxc=;
	b=FcxcOuzoemSMBuXGWok5Vwk8Rkeju5r96bYwavJC59pBNI/unA2bnEtNUI8Ow2fHJYnRO0
	83W4p763FmSkCl5HsTYCHuBXpn8lQCDBQ4KBKfmZTFRZJcH7lBlZVJFwTRg10/tDKMcpaZ
	yUM3iDlSyHcQiAerZOeG499TkJ1zPh8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-qOYfzmWWPXGWhkNpXPAptw-1; Tue, 19 Mar 2024 04:29:50 -0400
X-MC-Unique: qOYfzmWWPXGWhkNpXPAptw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-513e45ab9a8so1696109e87.2
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 01:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710836989; x=1711441789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bidhNprDIaXErWo++B8NK9gU1Mr0P973Tkk526SOsxc=;
        b=Tjh3lpk2wv5NRSOY114pAnlpTOPSHuB97onzkGSVyRFNVzLTYhYM5TXmndofXNDlbv
         RfzyCwM1/vVGDe6mNk+5lJsYxtJFG768MdAZnLJhUrFESbxRjghFpmcn35AW/QWGnpDk
         PWtgo7VDOFqf1ieA6d2ZHBLa/xvcKJqfNJ3Dlere9mhFKkEHstGVFBbD8Jk2iyjfr0MJ
         4Hh70duzXEimd18t5y47OCVa6sg3wX3kX94734GhiY0qJlGLSkJNh8NP3iyeGn9h5aSI
         nVGOm1g8smtsX5nYRWJJDSS+GOmvbkViEJ5AFHgeHV5otXPRzFmXpR1bnPZTxwy+8nsg
         i8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Lj7VimlZhg1INFJ9cgpoeAqkRLacMni7K0aWBuXz/wtnAATqC19a9TM+Md8MHd1e88QL4l4au9ujTsZmnrZNfGxvwYj0fcyseyp5Htg=
X-Gm-Message-State: AOJu0YzIeBqGBDBONw2C+Q0vXjr42GK66Obng0ga7N0yL58BFqjE9Raa
	F0gOqZUHY8z0KZGGyHTXIOOiZBcvYKiqAzPkBK8XW4UjxS6Kmg+/DNEKhbJp7yZQjtqt20KX197
	uhCRNn9ZIOGnfsUPVPwUoRxbNQalwXk/Pqd1easlt3bwfPqGfsqA+uWU6qXk9Qrja
X-Received: by 2002:a05:6512:68c:b0:513:db96:2be9 with SMTP id t12-20020a056512068c00b00513db962be9mr10460588lfe.64.1710836988682;
        Tue, 19 Mar 2024 01:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2M46P0WU30p/kI4KM147xUw+jHFCsikBReD0bxprbCUbp1whXFumyfQAXLRkNAFtveWMugw==
X-Received: by 2002:a05:6512:68c:b0:513:db96:2be9 with SMTP id t12-20020a056512068c00b00513db962be9mr10460157lfe.64.1710836978279;
        Tue, 19 Mar 2024 01:29:38 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d540e000000b0033e95bf4796sm11737388wrv.27.2024.03.19.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:29:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240319042829-mutt-send-email-mst@kernel.org>
References: <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
 <20240314110649-mutt-send-email-mst@kernel.org>
 <84704.124031504335801509@us-mta-515.us.mimecast.lan>
 <20240315062839-mutt-send-email-mst@kernel.org>
 <b3fd680c675208370fc4560bb3b4d5b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b3fd680c675208370fc4560bb3b4d5b8@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 09:21:06AM +0100, Tobias Huschle wrote:
> On 2024-03-15 11:31, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 09:33:49AM +0100, Tobias Huschle wrote:
> > > On Thu, Mar 14, 2024 at 11:09:25AM -0400, Michael S. Tsirkin wrote:
> > > >
> > 
> > Could you remind me pls, what is the kworker doing specifically that
> > vhost is relying on?
> 
> The kworker is handling the actual data moving in memory if I'm not
> mistaking.

I think that is the vhost process itself. Maybe you mean the
guest thread versus the vhost thread then?

