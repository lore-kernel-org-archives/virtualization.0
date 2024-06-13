Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571BE137758
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261378; cv=none; b=E4mldn577wBCitCcV/r3Hega8VCJ+Lrj/+H/w1Hf2sdCN/pigsJL8hGKgLu1mVH/zjrXxA2okZFUSaYYBcsdonzkHUVSot72mHQw+owJ4b4uBMzoiEFuP9r+gaNPcOWh1sRtX83SMj8e2qUaP26gFOqLzZqJkXQyqZ56wtU2gqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261378; c=relaxed/simple;
	bh=nOI9j21ZgI3I0MQ5EhathzuyzKyOMxQisKyvdWlhhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SkpdmgMbjkB7Xulok9SifUfDqPuY+sw2veLPVusnSdwHumuN2IKNGidAegXs2e70Mzju5hV/avL1bE4sSQ5lii1Rs/5UnnHdvZWtHPkISHZXThVJVgfGD1LBNHFNlZP/40WpOV9gUdTRtUFe/J2kKqwFzhHN+uriNhkWRgpByOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAffOl26; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAffOl26"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D475660B59
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:49:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJJq6cHd0ZEr for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 06:49:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 09BA660684
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09BA660684
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JAffOl26
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09BA660684
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CbSxasg15SB+kyQXKy/dPIg+1PKI2NcVPeH5mNpLbA=;
	b=JAffOl269TqDfcdCVMEl9mMaX4/Y/V5+XOSNi2FY23W+XCGFd0ZN/XO9eIe5FJa9wXhMT2
	LBrV/MjOD8l3DcDA+gyv0g+/U/43EsvuAeXPfC3UEvNnzrhpT5NdRhOYa2BJChZBTuUu7Q
	22PTrZXgca60oqlrbMXM2NkJtfNy0S4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-1UO4rs9LOm6eGiO4Lc8QIg-1; Thu, 13 Jun 2024 02:49:32 -0400
X-MC-Unique: 1UO4rs9LOm6eGiO4Lc8QIg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421f43ddc2aso4755135e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 23:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261371; x=1718866171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CbSxasg15SB+kyQXKy/dPIg+1PKI2NcVPeH5mNpLbA=;
        b=IJEQ0NiOs5MIiMi1SlW/RHgdTvLy0XfuJoXRNBIFPYluVA2ICewcHIJkKGU17QgbEX
         jTv43zGcoeAe6LfdZHCdjafguW46DagYqM3LHMLXHXFszGSpSlYPgiBt/k034xWLANym
         xP4lUfoI5oVt9blnzQ9ScBMgW8tIS90p0fPDBWEkh5QI1f9kJt5iQxd3Ks4i8ob4qX78
         GdszWfF2R1Q88hIkEuTQE2CbH9wLhmMipeKNHZNj2FS47NWdDDrmElzWmGXSa7kiye2G
         onDD6wBzQ7GHNM8EDQBaUfeLN0EGIPiTaeLLM39d6uGRQtJ284iTw7a2GO6RJUVqU9Wh
         eZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS7Ho3TaaSpx9gA90wXrIY1UT+k5HZsLF8noIalYJAtKq5AgChVgIHsZOWQ/S1dm7zRIe00gUcfen5ikqN6V/RV7ddkgWV3/2snhYYHx8Wp5Vqq2BoM8jzBQ==
X-Gm-Message-State: AOJu0YyyCHPUIdorA2wP8KTr+I2ZZnwGlTHIAiQwcBOBO55GwR0L3Mxc
	6xoWytYDFrzNa3cFJlTRmOJ/qKDC3Av2aBbBzByIXZVbQTsWnhITVSpKOo/QWsYCzl8J2ic8hqY
	xw+RQBKpdOrKy//fwJ/pBCtvkldVqXdQ1g4IzR6fUyk29J7gCUCSw2bGlZTSyyQ/nLLbkHNyAYo
	tocsE=
X-Received: by 2002:a5d:4ac3:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-35fdf7ae574mr2690495f8f.41.1718261371371;
        Wed, 12 Jun 2024 23:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zc9YTuq67HAYl0S1ZCAGfDX9FHmtCsB3op2ROZqV+XTOIEDmRzmfD9lHK2sqlkU4bC7xmQ==
X-Received: by 2002:a5d:4ac3:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-35fdf7ae574mr2690467f8f.41.1718261370362;
        Wed, 12 Jun 2024 23:49:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:5539:9b1a:2e49:4aac:204e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c89dsm764954f8f.25.2024.06.12.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:49:29 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:49:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613024756-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZmlMuGGY2po6LLCY@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> Add new UAPI to support the mac address from vdpa tool
> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> >> MAC address from the vdpa tool and then set it to the device.
> >> >> 
> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >> >
> >> >Why don't you use devlink?
> >> 
> >> Fair question. Why does vdpa-specific uapi even exist? To have
> >> driver-specific uapi Does not make any sense to me :/
> >
> >I am not sure which uapi do you refer to? The one this patch proposes or
> >the existing one?
> 
> Sure, I'm sure pointing out, that devlink should have been the answer
> instead of vdpa netlink introduction. That ship is sailed,

> now we have
> unfortunate api duplication which leads to questions like Jakub's one.
> That's all :/



Yea there's no point to argue now, there were arguments this and that
way.  I don't think we currently have a lot
of duplication, do we?

-- 
MST

