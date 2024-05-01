Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369013048D
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579463; cv=none; b=EW9ONkuut6AY5sEuDLhRgYUpO4lRFzTjJcAMUIg0acIVvcUrAh5jGAXEQdC+9fqhJXm/O/Q0MFGKUfGNKikYbaTJP/d/7QvGXtnlZxY8SgbR+Tk9DWNqbWnAj81rCiH3zKaLZaSt+xf/U+tjsViGlkF/8N1j9Bv6V8t4lxqZ1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579463; c=relaxed/simple;
	bh=P6d5RLZ9VJEKer0SyZETamUjQ9ajSGTTh3YaOmyXPww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EtVSCLTC4oWHUb1T4S4WaJujYYZAortuPWXUzss4urdRd+Guh+brIVTVdRHbnLTZ1JBsnRlrEqjxvNHirmc8deVFa0bQwznbPL0nlfjdidht4HFuMYwhTOg9ixi67GMqeGDFg+AeBqOWOUTcpaKpMO4E53oKcddymq+HXSMnjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGtN5lXQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGtN5lXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714579460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/YklrOhByKuNoE3Hpyt5F0lLjn7VOok73FuSFdcLv0=;
	b=WGtN5lXQ7E/JAdIbRhdIfk2esgD2YMUukdAAAjaXWVeicRskYQM8EQWPQ6+5VpyAUHJCYW
	Ifmevg0B7/DFDGIdc2G9BXY7U95v+qmPatQRFRM6mzA31ZXwvTMFi7gbbs3PfxwfIJVpQF
	3eEJE2Ax3g9pQvRNA0KtdLjOxWrkYEY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-37RaX_jtOISYGN5aA801Pg-1; Wed, 01 May 2024 12:04:17 -0400
X-MC-Unique: 37RaX_jtOISYGN5aA801Pg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-572a866721dso467625a12.1
        for <virtualization@lists.linux.dev>; Wed, 01 May 2024 09:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579456; x=1715184256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/YklrOhByKuNoE3Hpyt5F0lLjn7VOok73FuSFdcLv0=;
        b=EJzFzvprHVCw+SQe8YUXKhP/h/ifHLI+hTtWJRHHbzE4lw8ZsGXCqpbflHTI1/yLc1
         XoEpai0qN91AzHjgqW2KXqPuCoqwo/eg4z3uG3+5TjtY8ESH3T/H4Ad9hoBr8peWWk+n
         /hwCYklkdcCsqBRJZp/g+6oQjUsXUTnEHhFsrvY78PN4T7fjVGTKyoXhAStUVNaPPWr2
         as0rCLmXzkpPzRaz//DaJAIJSUZAT5yJ3seaN95xELiypbg3Ba2IkSil+qjmDb7nWld6
         3oicG1fTzJidnHI8hMl8JkToWpmnbClAQbtwLFT1ZIFMSZWWlZOERkBcu9Scpxg++Eal
         t4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW0/Zv5mg9x9wmTHOLX1nAwhKFZziYMLuG0bIIQvBxqR6H96IVpK06dKpd1oKyrKyaJczHYGkhHgjYXGckIRg678aPsOY9b3SiP8PjsqY=
X-Gm-Message-State: AOJu0Yw8J9mkOEvlWVN3zcKiw13uYoTRnD6YrpbUdNNUmY2XrWm0lWnc
	1QGP/G+lF6k4+5jDiUY+JxyWutSGD/o55QhxTbteaAkelJNnnkS6KCH2dZkDoysRtEhFqsx91vP
	NM/iFk6aqVFr5+Rdq/2RHPFrYioIDa8IU9dc2aaBfI710iVzmT32CWBX4QouKxt4b
X-Received: by 2002:a50:cdd3:0:b0:572:78e4:c6bd with SMTP id h19-20020a50cdd3000000b0057278e4c6bdmr1674045edj.27.1714579456054;
        Wed, 01 May 2024 09:04:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaaihY3p6Ul/xzJhWWgryIS8flkyjApL+P4BpRyfoZzyU2F773yPksS0yIyST2HX5jxGzdFA==
X-Received: by 2002:a50:cdd3:0:b0:572:78e4:c6bd with SMTP id h19-20020a50cdd3000000b0057278e4c6bdmr1674022edj.27.1714579455443;
        Wed, 01 May 2024 09:04:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id et10-20020a056402378a00b005725ffd7305sm5542574edb.75.2024.05.01.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:04:14 -0700 (PDT)
Date: Wed, 1 May 2024 12:04:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501120023-mutt-send-email-mst@kernel.org>
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

Two points:
- I do not want bisect broken. If you depend on this patch either I pick
  it too before your patch, or we defer until 1dd1eff161bd55968d3d46bc36def62d71fb4785
  is merged. You can also ask for that patch to be merged in this cycle.
- Do not assume - pls push somewhere a hash based on vhost that syzbot can test
  and confirm all is well. Thanks!

