Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C5211A11
	for <virtualization@lists.linux.dev>; Thu, 27 Mar 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074472; cv=none; b=lMXgjva5s52qPUJ82ODAewYszyFefg91shLwJjFV8ESYyVYt7A/Cy3FxZfilz/u8zEZVvHRZShWHq6jPyezP+shrH/fHGCwxu4/T6dU9FKdgiIar/VMEin4GIzOQqKe4gfUeacj+n+FqoPvKksbt2M0ld2hxZzCYQednqODWG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074472; c=relaxed/simple;
	bh=3ZrnUp9Fhn9UaUnyyfKY5MriRafswzCPAWMuIe6cdA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YPazWnHk4zl9CZT9W5RWWJOiWpC8iAixZXeKtUxUNTkrR2UGjof6tAjCy0NiPTSYgIpaE8hrsT3XlmUbguSykxJpWtDZttc2usS3aPdXyGU8s/lyoT2VIXTtem2xiUWdaBNLmzyWwh45cXeVrZ2Xz7RmX4DznKQmkfndYnroYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1RHGQLr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1RHGQLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743074470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRX5KdSGkfJSEr/WHGFbdRRh0ujs8cABCCjOijR+WkE=;
	b=C1RHGQLrDgDFe/32jw/tUggPRDvs7FySunAFbTgjMXUbqHUD5/NJ7KWLga7+i6N7550jht
	3Qxl/TQ1jw1+ASdsWNafM7BBCLaIVlcP4w5d3JEFJsFtmyhpA0O5kQrVPPJ4cwoxP+4ez2
	xJQSKKPJGnrndLpTlQvofumBfV1lB8w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-9NmCtDeRMDKe55GiogSscA-1; Thu, 27 Mar 2025 07:21:08 -0400
X-MC-Unique: 9NmCtDeRMDKe55GiogSscA-1
X-Mimecast-MFC-AGG-ID: 9NmCtDeRMDKe55GiogSscA_1743074468
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39142ce2151so397907f8f.1
        for <virtualization@lists.linux.dev>; Thu, 27 Mar 2025 04:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074467; x=1743679267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRX5KdSGkfJSEr/WHGFbdRRh0ujs8cABCCjOijR+WkE=;
        b=wwWdvoCGftix7pvKteXURqGdCU/Gx2HhvNftvj4Mzl/S4ZRICod6FZSMxhTWpkP0m7
         R8TfD1oCjz4rKLXH9UnpTk0+Yz6U/wELgoiTqQh14LiOicsPY1XOc1x45mOu1HNweJf9
         CVvT42LKlMxdNO3DvuIWwK5xsccZAmY6OkPu14TbF2yJFDeJKcvqLSLGJW/oYgNbbOQW
         t+ZHSAyXllpu/icIlJrVSyMYfRs6ek4X3RceoHPuQc/krBSBuTh/WZ7Ddn+DPI/F8hhz
         RCbdVenSaoBVx8j81SR48wrJW1NEfpOYMwE5len3Z+0SoCmL5xl4OnLXUZ/GB+TBVtnx
         DhQg==
X-Forwarded-Encrypted: i=1; AJvYcCWnJH+4IERZugRd1gux4y6bkre4Xl6q+wiJWPtP95xchkGtd98IIcoR2H1Zt1HkunDwbJGxjaQ9TQSyXQguHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg8TlN2cc4xMVhePumvBmQ3bcNkhbf1+W1qAtgMPpU7A2GvY+d
	VPyRVM4vX9MXAZaJJLOREVHjid/uXq941LhbGFZpgjk3SGvTAj1M/+z59Kl75K5L4Kk03k1XmVu
	ok4iOJExng/Q0fBWnuQYGKYqwLNhZNLtYYBnJeSMAAm76nfP/LjESA5qKytdaAXQb
X-Gm-Gg: ASbGncuRVMcoUFtx9VNYVUt4e+sY7K8wcsOWJoyBUOTpszuAG1pDtfqWfHZ/2LMlhKT
	s4VQeB9ikkVG+3ariWcepMWJK8DpaeAM6QpABYH8NlprEa0sX5l9W4YOYkLefYSicq58zsUNkD8
	UHDEoz5FbflUvk0RB0MP2rsoK62mTHLVRy9k8+HOv1+gZQlRvggEUVhAhevZqviULglJzR6ZPVx
	vllmdUl/g6GqWRdpBAd4YmEbq/LFftEiAjY/XshbsZLG8ae2AlJ4OpYJoCD2uMHn7s179ps/h9K
	H9eh6xAaVnoVtNrceZ4dansxjix29eXzkitbnaFGaTxofHx5EOXjY6RdNIR0DNT1
X-Received: by 2002:a05:6000:2d82:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-39ad1787adfmr2287622f8f.43.1743074467493;
        Thu, 27 Mar 2025 04:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2h7ayPlB4Kss3y5VeCbbDdjXM4BImGSUtzVmo6fk6xKoLcS1gfkg1jwqkOYe+guaCoI3pLg==
X-Received: by 2002:a05:6000:2d82:b0:390:e158:a1b8 with SMTP id ffacd0b85a97d-39ad1787adfmr2287591f8f.43.1743074467014;
        Thu, 27 Mar 2025 04:21:07 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac80e6814sm8150600f8f.56.2025.03.27.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:21:06 -0700 (PDT)
Date: Thu, 27 Mar 2025 12:21:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, oleg@redhat.com, ebiederm@xmission.com, stefanha@redhat.com, 
	brauner@kernel.org
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in
 __vhost_worker_flush
Message-ID: <fd77ljndgwznty4e45t7o55sbyfdlxfl7otly5ib7mjlnsxcwb@ve45z34reswm>
References: <Zr-VGSRrn0PDafoF@google.com>
 <000000000000fd6343061fd0d012@google.com>
 <Zr-WGJtLd3eAJTTW@google.com>
 <20240816141505-mutt-send-email-mst@kernel.org>
 <02862261-b7cf-44c1-8437-5e128cfd1201@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <02862261-b7cf-44c1-8437-5e128cfd1201@oracle.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: vMegLwGXQ88X6VvYOq5qAdjtB1LxsW7dYZDhkyIB_bk_1743074468
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Aug 19, 2024 at 10:19:44AM -0500, Mike Christie wrote:
>On 8/16/24 1:17 PM, Michael S. Tsirkin wrote:
>> On Fri, Aug 16, 2024 at 11:10:32AM -0700, Sean Christopherson wrote:
>>> On Fri, Aug 16, 2024, syzbot wrote:
>>>>> On Wed, May 29, 2024, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzbot found the following issue on:
>>>>>>
>>>>>> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
>>>>>> git tree:       upstream
>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
>>>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>>>
>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>
>>>>>> Downloadable assets:
>>>>>> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
>>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
>>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
>>>>>>
>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com
>>>>>
>>>>> #syz unset kvm
>>>>
>>>> The following labels did not exist: kvm
>>>
>>> Hrm, looks like there's no unset for a single subsytem, so:
>>>
>>> #syz set subsystems: net,virt
>>
>> Must be this patchset:
>>
>> https://lore.kernel.org/all/20240316004707.45557-1-michael.christie@oracle.com/
>>
>> but I don't see anything obvious there to trigger it, and it's not
>> reproducible yet...
>>
>
>Sorry, I missed the original post from May.
>
>I'm trying to replicate it now, but am not seeing it.
>
>The only time I've seen something similar is when the flush is actually waiting
>for a work item to complete, but I don't think the sysbot tests that for vsock.
>So, I think I'm hitting a race that I'm just not seeing yet. I'm just getting
>back from vacation, and will do some more testing/review this week.

Hi Mike,
looking at the syzbot virt monthly report I saw this issuse still open 
and with crashes:

   https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990

Have you had a chance to take a look?

Thanks,
Stefano

