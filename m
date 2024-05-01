Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDB12FF78
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579978; cv=none; b=pV8VGiBrnqh7QtEKlkEKuZAXRkfEgMY1/GY2nUEap6uIo+JgYzCc5QJSiK/BW4fcSwmON2PYb59/DLe0Dlvr+Vfd6X8n4Xlv5g7qpc6787552ZxRFrgNc0aThJUQ8/Jau/0Dw60PpDda/0hqL2+UXuJ9i/Ibx4/gwO50v/mblNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579978; c=relaxed/simple;
	bh=hrRDPH5KmWRr+9x1RV6ps3o4KFAfIeKcj/QXwk73n2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rKwGBWTBQwfmW+zMAyT5R2ukFFFf0qvBqfUtrczDSrUHIj2QBy4LIhAWxDls3+ukMmuwKH9KJheShQwAMmjhECt07XTtvp1p2V7f87KfwJYXbLDRjkxr5BDeQ8Zqto0TipG1siH84RJNRWtH0GXz9/CY9yySh2bcNCq+UyBgt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ljq4EaLj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ljq4EaLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714579976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrRDPH5KmWRr+9x1RV6ps3o4KFAfIeKcj/QXwk73n2Y=;
	b=Ljq4EaLj6QrVg/rHfjD/I9E2Fvwoz/O0cSzImk2pLoKXV5om5Q7ZXrIE4R3dqh/WvzYLLA
	Sede2DhYuT3Yslf4FV2I6E8Ybo6yEgJKuirF58C8rlMjwIHCfRV5UuRTd/BhLFcj1g0QWX
	Eh9zA6lkGp0zaLbJajwrnYFI4vsvLZo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-LsyootOrMhi1MRCk6cdsGw-1; Wed, 01 May 2024 12:12:54 -0400
X-MC-Unique: LsyootOrMhi1MRCk6cdsGw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41b37ce2160so29337315e9.3
        for <virtualization@lists.linux.dev>; Wed, 01 May 2024 09:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579973; x=1715184773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrRDPH5KmWRr+9x1RV6ps3o4KFAfIeKcj/QXwk73n2Y=;
        b=qvCkMZuU2iSLUchY/IlWkbez+P4VdYDcOabfpJRLbYpchCKQt992g8+dzejOuYNoHY
         C5Qw8MgW/cG5Eyolpx5jwbiIvhlXGJiqht2SsTPncTuBR1AOM69folkySkUSO2U1IM59
         44SLxM+F+qmTmqHuaipJOkcC3B5rZsQBshzpg6iKsDEYrnWmvjeaeTLMHGv3D7z6hbAK
         oxM6zrcU5uyPoBUjBAhNW9NmwHu2xlWwXcBj3a5s13XRvwek/Yn+Bapli7ocqP8we25z
         DdFzRDzylz2Bs1ZlLM5O0wPEa1to3UfYzJi5q38O3IgFtlsAOwruxbkz/yOxUawfMVh1
         2d+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb71nUayBiQFrqhbbBYf7CXdq676w5PoCNbVDAWQDGchOzOCzhkxdGuGJdWrSX6KcxPH9F7vOf7YugDSBbOfcofb6a0Cx1uSgr2XOZ8ic=
X-Gm-Message-State: AOJu0Yw0a9NPtHuUr5pUAg9MPAVUE/gg/j3RZI8Zw5MlhrUocMotMj6t
	n2T743KJ71NW4czYoWqG9HYoI2pFPwR7MI3pRbiRr9zG9iJO18iW2YHidW/MP2tXV8OJxll2uy/
	ZbPvOaDhwfUjaz43mN3Ivu8bKvHVBEf6XtNCamDZSRCdxg4XdqR4sAPoT1Np/eCpg
X-Received: by 2002:a05:600c:3552:b0:41a:be63:afbc with SMTP id i18-20020a05600c355200b0041abe63afbcmr1920321wmq.28.1714579973248;
        Wed, 01 May 2024 09:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM9eMgnWpKr6MeblXMaPo1/itIFX2oETmSIeau52sprOYTLIeHS2zSDJpwo+oNvlucm1N6qQ==
X-Received: by 2002:a05:600c:3552:b0:41a:be63:afbc with SMTP id i18-20020a05600c355200b0041abe63afbcmr1920294wmq.28.1714579972623;
        Wed, 01 May 2024 09:12:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b0041c5151dc1csm2639208wms.29.2024.05.01.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:12:52 -0700 (PDT)
Date: Wed, 1 May 2024 12:12:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.christie@oracle.com, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read
 in vhost_task_fn
Message-ID: <20240501121200-mutt-send-email-mst@kernel.org>
References: <000000000000a9613006174c1c4c@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <000000000000a9613006174c1c4c@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git f138e94c1f0dbeae721917694fb2203446a68ea9

