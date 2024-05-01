Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9428130495
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580117; cv=none; b=YzsCQAv6c+0jfzSIQnqJ4+1xO7Cn+cGtOl++W+zUQF7uH7FulE2zDR3kRIvC+y5sdGUQGu2NCRSzWcPwckJeEFeIPHnAj/VPhXfjq9izvV4N96ymjNc+woj/TdPajrt1oEOPu92r84OImUtFJaTiVtJVyeTMym17tdwYpMcUAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580117; c=relaxed/simple;
	bh=4JZobKXvCAkKEuBLtHUYjgoYsuv0NHezNKIZozxI+3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iaaDvsn7qYpt9xDXBDwYHUS+46UIWgbXDFgGtLOm/PbndC7Da6YH1Y6AJFOZZ1zoFN1zdd+61vu31BPy05gUghS4fxzM8qSQKBfymtYLrrs0QYdmDq6FzLO3/zsWGl/shwT/Nvf4WFRjmp8BZBcyoqxyYDDVUoStMAzAnH6Rs2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ae/5TlCs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae/5TlCs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714580115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7mWrcXve95zg3d/M8fss24W5lX0LbUL9bKvtgV/1yg=;
	b=Ae/5TlCsgdMXKhKk+CL5dus93c13PsDWTSOZncDnJVVLnuuPdBOzbu9HnNBV6eAaD4o35W
	UTgu2VAwq6zP/Rmj4Axs8DPF8M0RD+KI4cINf1yNk4y5XAAIUfh2ybP/kV0AOjRDWH+gz9
	2mUq6VuBkRjecZHZCdF0hn4XHkb0XFg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-USG0jfG4OJ-FA-C8GBHkQg-1; Wed, 01 May 2024 12:15:09 -0400
X-MC-Unique: USG0jfG4OJ-FA-C8GBHkQg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d9deebf38so921757f8f.1
        for <virtualization@lists.linux.dev>; Wed, 01 May 2024 09:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580109; x=1715184909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7mWrcXve95zg3d/M8fss24W5lX0LbUL9bKvtgV/1yg=;
        b=S1tC6bybz1ZMVRV5mIKMe7pq333Nhah4aAqMCWC+QXU74ftht5qaMPYI3zNk3pAd97
         73lAwr8oGXRHMmt7MbXTccUHdtTQBv7DiNyxzhmxWLuX2UgOs1i5a6kunSXWrvQRuzk+
         c57Zql9oOzrdGQXwZ6Ji89ERu8Tby495ysDr7zusEqx+xqvzRRjz8niK0CshUOrXfuQQ
         prEWQx6wa2ixG8YI8sK0vpAcKUPuGe01mHVdScVWIuMZnHsKMLYHB2t97Q8Pl5qdvjid
         1WhRwpj9HIbzojsJUWkPHVpCmhn641Pb/UNyOYURMN/0lZACV9NJRQERiryTWkR8tKsm
         VJfw==
X-Forwarded-Encrypted: i=1; AJvYcCVGI2sKgKdFNHndG8bNj//tBvQyK4RnSnmRzFTtqpyXoL87kCE5OPSLLTvarIFK7xhwkoFHi+EbGhQNNRSiUOpSxRm7coAmFRyrF8x0VZA=
X-Gm-Message-State: AOJu0Ywx9tgrDFopqDnwgm9FLiXui6dxR8Xjy9GSWt644YJtYCD6749D
	0UpeiodQUQyk7pFRfvPDZ3tmoWnsZsYuXTrUiutdxxkQ7jnKRfQlBsTm58QppzdGuDsBL9LRir0
	dPWGj7yFV8OzK5JDul8cS6TaVUoBL4fYLEH0RS1K1anypqkssUjUeNkeHsDZIDzq6
X-Received: by 2002:a5d:4528:0:b0:343:751e:8ef7 with SMTP id j8-20020a5d4528000000b00343751e8ef7mr3142434wra.51.1714580108380;
        Wed, 01 May 2024 09:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyKzGL84l2usjgV0H/flDoMX0zRy6ou0wp/1X1uaRyOtrwrWRor6D2o1DQAe7+oMIVOR8snA==
X-Received: by 2002:a5d:4528:0:b0:343:751e:8ef7 with SMTP id j8-20020a5d4528000000b00343751e8ef7mr3142404wra.51.1714580107826;
        Wed, 01 May 2024 09:15:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id bs21-20020a056000071500b0034ddf05a3e6sm1509266wrb.76.2024.05.01.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:15:07 -0700 (PDT)
Date: Wed, 1 May 2024 12:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501121411-mutt-send-email-mst@kernel.org>
References: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
 <20240501001544.1606-1-hdanton@sina.com>
 <20240501075057.1670-1-hdanton@sina.com>
 <6971427a-d3ab-41c8-b34b-be84a594e40b@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6971427a-d3ab-41c8-b34b-be84a594e40b@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2024 at 10:57:38AM -0500, Mike Christie wrote:
> On 5/1/24 2:50 AM, Hillf Danton wrote:
> > On Wed, 1 May 2024 02:01:20 -0400 Michael S. Tsirkin <mst@redhat.com>
> >>
> >> and then it failed testing.
> >>
> > So did my patch [1] but then the reason was spotted [2,3]
> > 
> > [1] https://lore.kernel.org/lkml/20240430110209.4310-1-hdanton@sina.com/
> > [2] https://lore.kernel.org/lkml/20240430225005.4368-1-hdanton@sina.com/
> > [3] https://lore.kernel.org/lkml/000000000000a7f8470617589ff2@google.com/
> 
> Just to make sure I understand the conclusion.
> 
> Edward's patch that just swaps the order of the calls:
> 
> https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
> 
> fixes the UAF. I tested the same in my setup. However, when you guys tested it
> with sysbot, it also triggered a softirq/RCU warning.
> 
> The softirq/RCU part of the issue is fixed with this commit:
> 
> https://lore.kernel.org/all/20240427102808.29356-1-qiang.zhang1211@gmail.com/
> 
> commit 1dd1eff161bd55968d3d46bc36def62d71fb4785
> Author: Zqiang <qiang.zhang1211@gmail.com>
> Date:   Sat Apr 27 18:28:08 2024 +0800
> 
>     softirq: Fix suspicious RCU usage in __do_softirq()
> 
> The problem was that I was testing with -next master which has that patch.
> It looks like you guys were testing against bb7a2467e6be which didn't have
> the patch, and so that's why you guys still hit the softirq/RCU issue. Later
> when you added that patch to your patch, it worked with syzbot.
> 
> So is it safe to assume that the softirq/RCU patch above will be upstream
> when the vhost changes go in or is there a tag I need to add to my patches?

That patch is upstream now. I rebased and asked syzbot to test
https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
on top.

If that passes I will squash.

