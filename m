Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E013CABF
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265071; cv=none; b=kiwwkiQkBuT4BiTfrPR5R1ELpHyP+lu+b+f5vrcqpR4pZUm9JxF/fCc/8t14gYJIML5h0s1TQO1VZvFrVHuvv/rbFg9XlaYZn4w6mLny9aI/KKi6wfKUpK5DYB3nS3E53PFb2vYvnuL3ANuG+Kgwu6EQDiB8cOrOnbuAxN3TRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265071; c=relaxed/simple;
	bh=GFIcxWXQwNCRH03Z9cLHboBcOBzSFyWQjvAxn613bA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tbcBrVS3VkktV0WgiGEKxD+cC/EFzzJ8WJB8rKuzWEEM5vDykXAkXlyhzLVjHZsCJVMMZ2LRu/RjCZgDFvUvBExnZG3/1HUgHN3RzvrjutOkc1ZsWz2JOBnxC8Iz0LY484TlNH0hviGN4J0pgZjRdmDrfGnSHzUqmStPDEGfPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsBHTJKS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsBHTJKS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 005456078C
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:51:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqb1MotwgCYh for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 07:51:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7EFBC6083E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EFBC6083E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsBHTJKS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7EFBC6083E
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718265067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/n+AhuyhqSsJr+vWl3tvLtoPgeLWQoTZ3U+G+ztgvo=;
	b=bsBHTJKSab5vyxARrVYEkE0NmQuDatcGMXaAaKJoo15ih9SDrqsfq2YT63gZm3Scfa84rd
	p7mx1n7QXkyO/5ye0UI/ldh4mdD35HtU3h+BqqWD3oVhhYdmsgMxrQdnIoB1vJsrDejFdg
	MCNDtz5c7vAiD3mje3u27NTMzEeulVc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-ygIWk_92Os-nqI5hgwqtTQ-1; Thu, 13 Jun 2024 03:51:05 -0400
X-MC-Unique: ygIWk_92Os-nqI5hgwqtTQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36073b9e266so246147f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 00:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265064; x=1718869864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/n+AhuyhqSsJr+vWl3tvLtoPgeLWQoTZ3U+G+ztgvo=;
        b=JHaaoKEP5j3OTj27zFmYtBKx3dgPxJtlAziY3e6SVKmY1RQST53rLRMl3aupPnw1/q
         Cw/pf8ihFG5wlmmB0udKRu57rOhcJUZAoBhxP8TavwSHwgsBlxOicWvu4j/UYb8TIhRE
         F1lO1OGY7LLwkX7caj0PcGpzPujcf5qLb3wE3/4ca3NiobrtjTiOgCzalOlrzOopQwvZ
         DEWZbJhFidLos6vqo3yO36Hj5uw1o70/zpJfQCP+GOngIfscGQoyjck0xv8SN5B0jPFd
         Tu74dLjBOrKsqq3Bnzl11hcDTtmxMW1/3SEXNdJBxNgpaObAUB3NpJrFuhNCXzQ0cERx
         AN2A==
X-Forwarded-Encrypted: i=1; AJvYcCXfeV3Mq6EfgBnomhP7haRkkpBmZ7Qc2BALGJNYhQkNLrNli5C9JykJ+Z/t8QyajjfN07qyFsx7KkC6F98NhlPohVHdJ0j6iQNmcHzu90oPKlbaX5SwTT0Llw==
X-Gm-Message-State: AOJu0Yz87tPvlxI9gaQOeRJ5X6TZx0M6DcV/goN+Y+tUNHjqkWicK3hB
	aZ8hsfDiVdO70Rlvz71sjSqj8bVeGIBo29dw02uaxwzl+KW6ie64WFUmHdKblXAD6yDYS7XIeyQ
	4lDmsqoG5KIdrdd+j8xnt+ryg2t2Wps/8p3utOdCFv/t1NzVAvvtMhljnfM1QpIak94/gW4YDRR
	LkkI0=
X-Received: by 2002:a05:6000:d:b0:360:75b3:2cd9 with SMTP id ffacd0b85a97d-36075b32d48mr830149f8f.65.1718265063716;
        Thu, 13 Jun 2024 00:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGecT5yUVKpC78rMOjYPpZNfe8ITqSuJs063PFj3s8mFpH0gfLFXFffpfByk9P/e9suAjpbJA==
X-Received: by 2002:a05:6000:d:b0:360:75b3:2cd9 with SMTP id ffacd0b85a97d-36075b32d48mr830121f8f.65.1718265063171;
        Thu, 13 Jun 2024 00:51:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d58sm894451f8f.4.2024.06.13.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:51:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 03:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613034647-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
 <Zmqd45TnVVZYPwp8@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zmqd45TnVVZYPwp8@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2024 at 09:21:07AM +0200, Jiri Pirko wrote:
> Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
> >> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
> >> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> >> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> >> Add new UAPI to support the mac address from vdpa tool
> >> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> >> >> MAC address from the vdpa tool and then set it to the device.
> >> >> >> 
> >> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >> >> >
> >> >> >Why don't you use devlink?
> >> >> 
> >> >> Fair question. Why does vdpa-specific uapi even exist? To have
> >> >> driver-specific uapi Does not make any sense to me :/
> >> >
> >> >I am not sure which uapi do you refer to? The one this patch proposes or
> >> >the existing one?
> >> 
> >> Sure, I'm sure pointing out, that devlink should have been the answer
> >> instead of vdpa netlink introduction. That ship is sailed,
> >
> >> now we have
> >> unfortunate api duplication which leads to questions like Jakub's one.
> >> That's all :/
> >
> >
> >
> >Yea there's no point to argue now, there were arguments this and that
> >way.  I don't think we currently have a lot
> >of duplication, do we?
> 
> True. I think it would be good to establish guidelines for api
> extensions in this area.
> 
> >
> >-- 
> >MST
> >


Guidelines are good, are there existing examples of such guidelines in
Linux to follow though? Specifically after reviewing this some more, I
think what Cindy is trying to do is actually provisioning as opposed to
programming.

-- 
MST

