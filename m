Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E68288C
	for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832263; cv=none; b=DSM6vvYdxeTwCqaGiltQWynBag8bzTsKKjy8jEO9irnTCvzuyQzugU4Od8idkI7wK/OxJGiw2hkySOB6XsXDjyqm8VZIU+qRjoBEcx1XSVlcILRxuRUaMGwQWJGUhiqbAFAYbdV+VeRFjvQTgf/bhKH+bXBDSd+lI7D0/BPT110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832263; c=relaxed/simple;
	bh=v7H2v+aBQQQLBDa/xPhBwsCdZvnTeVlc3DtFHbYiIsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YNhyjZ2i8G27tMGMS7VPKiVbWltGF1aJPtqwJhCrTsCB4TUZWHFw8OIedf6pVxNt85l4Avsf6bSLdSlq1AKYI6ohfIfaQru72Hky5PcO7Mpszf+i4uJdfmaMpoN5FQlqhIPN9MmHw20Xz+mfXEOh3FKJKeOAZxq0Rs3XJMywg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMz5fnqE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMz5fnqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723832260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w26DEP6I/1hWgkgvxN7UFiv+/Y1lgQMQcXbYEa3Fu2c=;
	b=KMz5fnqEbw2nqbcr/oE9MHLKAWacDMzj4a2JHiG32tmEUg0Qx9M8Hzbxqn0GvJXHJCN0PY
	ubC94CL/9mBU7N93cJ678W7LPRhcbI3Dlg7SaS2djlyRgTHtc8V4Xiq9p44V30IvuTP7KB
	7bQTtLDOBjThfo7riKl3noZcBBzhRjI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-sCCYIVjxPRGEarSPoGzt0g-1; Fri, 16 Aug 2024 14:17:39 -0400
X-MC-Unique: sCCYIVjxPRGEarSPoGzt0g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52f0108a53dso2955811e87.0
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 11:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832257; x=1724437057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w26DEP6I/1hWgkgvxN7UFiv+/Y1lgQMQcXbYEa3Fu2c=;
        b=aiPyBEE0MEV9YK/8P9F8/mP4SYATKTLPCKqFlAZ1nlRMMx/trmBRVbZF7K/acUVqyO
         1X97gGTYpLWzUx6zerotWFR+eKqyDixEbSu5I4TomY3Dv1hTFp8OEPE0+C1fcaT4AqQu
         U1gbLjz6Bm89ezA+lDHVcPB7hyq0Y8s+00coPlFYtPdn3Uy0b9kRa0C6Q5/ocY5l3gWO
         eVQJaJPf0AymLeZw5ZsQr15tMkTYRQBCGzjuwS9oXW0rYVUKcy6nPXJYXg4dmAPvN/6C
         LWez0d/xivsrazIzxmmes7+HPe7BmtiRfjFaIBJ33Pbf8Gh8bU1qAGC9IfAVKsi5GD0l
         9uzA==
X-Forwarded-Encrypted: i=1; AJvYcCVHKSC0ldXcOTyHRmHxjWLYIBzRxlCf4sy8XqstNgGQ6pHhJBveB9Zt/NcN/Q1oLN8gCnoMuctzQIhieOBRGTEgx4nBkW9paQtjKfNU0Xo=
X-Gm-Message-State: AOJu0Yy8rKvl1hHeKHGsTrUSyx5/9rIp8daPFWWLpq2jEkavXUu3oRMK
	cVlGBz5+PA0tksrn5zJeTPHr1pwaDQrRjko7xF7ek31e03iqstOlQjAOViK0e9mgIN6XPy5gGlq
	jZhMN1OkzyIEwQszz4O6oFW2Knyc1fPyGxsi/Zah0yovHZQpn/hBJI92AV8FDFQ2D
X-Received: by 2002:a05:6512:39c6:b0:52e:bdfc:1d09 with SMTP id 2adb3069b0e04-5331c69e8b3mr2425633e87.18.1723832257395;
        Fri, 16 Aug 2024 11:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxDJoZ5Qb2jeEyehNoICNOwZ2FOl92B7t2o0prXKfmYgWxwCynxbb3IvNph8kIMcufJQDgVA==
X-Received: by 2002:a05:6512:39c6:b0:52e:bdfc:1d09 with SMTP id 2adb3069b0e04-5331c69e8b3mr2425597e87.18.1723832256432;
        Fri, 16 Aug 2024 11:17:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:b635:69bf:864a:d81a:d278])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cf40csm288443666b.57.2024.08.16.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:17:35 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:17:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
	ebiederm@xmission.com, sgarzare@redhat.com, stefanha@redhat.com,
	brauner@kernel.org
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in
 __vhost_worker_flush
Message-ID: <20240816141505-mutt-send-email-mst@kernel.org>
References: <Zr-VGSRrn0PDafoF@google.com>
 <000000000000fd6343061fd0d012@google.com>
 <Zr-WGJtLd3eAJTTW@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zr-WGJtLd3eAJTTW@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 11:10:32AM -0700, Sean Christopherson wrote:
> On Fri, Aug 16, 2024, syzbot wrote:
> > > On Wed, May 29, 2024, syzbot wrote:
> > >> Hello,
> > >> 
> > >> syzbot found the following issue on:
> > >> 
> > >> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
> > >> git tree:       upstream
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> > >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > >> 
> > >> Unfortunately, I don't have any reproducer for this issue yet.
> > >> 
> > >> Downloadable assets:
> > >> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
> > >> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
> > >> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
> > >> 
> > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com
> > >
> > > #syz unset kvm
> > 
> > The following labels did not exist: kvm
> 
> Hrm, looks like there's no unset for a single subsytem, so:
> 
> #syz set subsystems: net,virt

Must be this patchset:

https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/

but I don't see anything obvious there to trigger it, and it's not
reproducible yet...

-- 
MST

