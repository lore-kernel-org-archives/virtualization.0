Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08238FB8
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4fu2dXK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B490D612DE
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 23:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B490D612DE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4fu2dXK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7FEUQRckyvej
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 23:48:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CFC6A60D88
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 23:48:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFC6A60D88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699573736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SxbBnBy8wcp+DFoAqPelvZA1LQU0OFFn4SXuqEY8lc=;
	b=J4fu2dXKN6mpOWvYDtuUWYWqnqiAhGlso4OHerB5TI0O8saXl6k7LIarnVBNkL7P3uEf2K
	468CezVxqnM4k4LHi2IVjgWs1hE0xvS8wBerK2hG9V068n42+A2nikyYo//8aLqcARd66k
	t0DJojIJGRns9ZvvjLAD1vGPf5kNg3M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-HrIxIUllNMae20EwtgVr4A-1; Thu, 09 Nov 2023 18:48:53 -0500
X-MC-Unique: HrIxIUllNMae20EwtgVr4A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ddae43f3f7so111945666b.3
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 15:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699573732; x=1700178532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SxbBnBy8wcp+DFoAqPelvZA1LQU0OFFn4SXuqEY8lc=;
        b=tV1Lvvc21hmDQTe7DZuwSqbiDN9sYdfuQ+cNtwt9ymW4Zbf+glfD1El/p50yad2Ve0
         j8ssuLgxWDiNoL2ti38vncTm3UIQ7CoDnQL8jG8433nCG4Ar6wUdn/4TFWgLmcAU2+mQ
         0XxE1XQwlOCxZcL57HO57apIv11KrztS7j59dItwSiKedoLJ/+Cvx+Ke6BjYc10wpnwN
         Eh1Ea7mFXZB5npNJT6Tt/CvMFIDhaLVu2YLM1jEjnDiBfJX9phYVnHuh7VWEFmHF8BVi
         d+V8kEIKCOf16/n9IpdFIXd7nAJCIBaDoDxd2C1jqctyi6WAm434haItPVrOOUZBwOQL
         0m8Q==
X-Gm-Message-State: AOJu0Yx3uzySEZ9X1cgpuZY8TDhmhncMT0QYln9MFA/vxQngFsmYiVr5
	D2fiwSIaD+rZZ8PjAZ/R4NJGKRiOuwEmwrCog+MCn1WEWbDYah0N35ZVUs5guBL/iBP0YrWZlgl
	8MajWwwpmAdw09Uh/pE2YBfXYbf7ke9VG19TGzE+Wqw==
X-Received: by 2002:a17:907:25c4:b0:9e1:1996:f3d6 with SMTP id ae4-20020a17090725c400b009e11996f3d6mr6251177ejc.76.1699573732742;
        Thu, 09 Nov 2023 15:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKFgKEEunbjt3marXxbZibLU1JXnSLXyCS7/ojjJiN6MLuJ2Aa5uQPqet3dxVKkQKsLVJ/dA==
X-Received: by 2002:a17:907:25c4:b0:9e1:1996:f3d6 with SMTP id ae4-20020a17090725c400b009e11996f3d6mr6251167ejc.76.1699573732476;
        Thu, 09 Nov 2023 15:48:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b009737b8d47b6sm3126661ejb.203.2023.11.09.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:48:51 -0800 (PST)
Date: Thu, 9 Nov 2023 18:48:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231109183407-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
 <20231107092551-mutt-send-email-mst@kernel.org>
 <20231107155217.GQ4488@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231107155217.GQ4488@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2023 at 11:52:17AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 09:30:21AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> > > Big company's should take the responsibility to train and provide
> > > skill development for their own staff.
> > 
> > That would result in a beautiful cathedral of a patch. I know this is
> > how some companies work. We are doing more of a bazaar thing here,
> > though. In a bunch of subsystems it seems that you don't get the
> > necessary skills until you have been publically shouted at by
> > maintainers - better to start early ;). Not a nice environment for
> > novices, for sure.
> 
> In my view the "shouting from maintainers" is harmful to the people
> buidling skills and it is an unkind thing to dump employees into that
> kind of situation.
> 
> They should have help to establish the basic level of competence where
> they may do the wrong thing, but all the process and presentation of
> the wrong thing is top notch. You get a much better reception.
> 
> Jason

What - like e.g. mechanically fixing checkpatch warnings without
understanding? I actually very much dislike it when people take a bad
patch and just polish the presentation
- it is easier for me if I can judge patch quality quickly from the
presentation. Matter of taste I guess.

-- 
MST

