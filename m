Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F9194A68
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617176; cv=none; b=Da0JD28eh3FrBlFTsE6voRUTcq1sKwVUwsPrplpHppwsSSDDBPrH6+p2ARZ+rqersOYFFQqZP3y+eSVdubdF2LrIBuXGncDb4LUwMIF60DKJ2s4fx7aPckXCfAuRHMMiz7CZ+yBSl+SeKnK/mLVwIWryJv36bG58fYsDnOemob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617176; c=relaxed/simple;
	bh=w6euua8DdAndSBqtwxLw75oNhUUVr0fLiGLrdXsOKIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GObgajUK8BchzGMovNKKcwotuoGal9sZ3Z9qjMQ2Aoheq8Y4tJ5hKoV5jQy7a0j4HHXLjnUBkLvzE0Y8gLqYBjeJl/amAOqlC3ITqjoVUV4A9F1ekWYigLKw8sMAcDTMqn3LvmZd5mFravcPtNf6nS1qRUSx+Kt9XPySTp+fFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LBcOEgV4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LBcOEgV4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20A9D402C8
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 09:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0NUrVqs42j6 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 09:39:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 05DDE4094D
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05DDE4094D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LBcOEgV4
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05DDE4094D
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 09:39:31 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-57c923e03caso4706858a12.3
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718617169; x=1719221969; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jWyeWccl/2aEbivUkA2fQdZreCyT8NBDVsWDIMF7kK0=;
        b=LBcOEgV41DIhn+9XRz1okSvwvLopBxxi3C2KcWBxUzwPyiVcKXcPI0n544NFNydkW5
         xzoSTBTTX9Ar3zH4GfU0DhrATp0v6FShhL2KonTtHvQM44wLUwY+g5n48lRmtTtziSHd
         ncE1BBzKXQZgQwBwvwsws7Bd4rQoir2nIOvF1k9vM07xYV3jp6nS78/71ioqk6Z0/rwf
         LsryuVGhPQ+DSbtRAX9zmlJ1drMDNen2QrNEFPK9MR3ZrVxnpfr5v/Y75dlXisimlFcx
         wILmnT3G3PsknUuaGbeLnrhEHh1wh3KMkRWule07HSxkoqcLDDlAJ6MG3UOZIq61a48M
         TJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617169; x=1719221969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWyeWccl/2aEbivUkA2fQdZreCyT8NBDVsWDIMF7kK0=;
        b=beMIKDChlBKIADT1Y76UvlO1XfTepUitbqwPdiZXHgF+OdyjISIoNSlo+nt6RE96jx
         ptEipCIcK/Lmw38giJRYLedJZk1f7j4gwE7JzAaGm0HVKB1b7eYmw52/Z2gV+LaVEMUA
         pXjdZFLokjK0yssuN+w36mhdEcFaCUZge+w409MFa5SRsradvl1S8EWlyXyNv3ZCJ3DT
         wr6aHGbyCxH8l92zvvIB0BXcnfS7AAmV40P7y4xnZnxhE2Tq7WKZY6x/SVMM43H/BmYH
         ScCzIPQHSnpinSl6GtagRwJwyc/NYIotJsfnjrsBBf/GVCreqc727BBVXeEMPj1L0e0q
         hJew==
X-Forwarded-Encrypted: i=1; AJvYcCW2Jr1Ho0prpwMsmvdlEjtzSg0zVMVL3aG/F5VaRVhKorZ4S1iNq28h6Y+4rMpLPslExJt/g9gveenYZ56hUqwWEfRFqggqOhAYzDmmSZPU+nwU4oxjK5kMVA==
X-Gm-Message-State: AOJu0YwZAghGJdbrTuDQZL52caThHZZf0T6zranOgiv4OQ9bgzgCEbs9
	8NQNV+bFFGF3WxGCZVLHfevK/ByWC6StqK7v/eqxdny38FH0GU4k057Tcx/XrH8=
X-Google-Smtp-Source: AGHT+IGp6uk6Ht7TdfIqqo0ajPFbRj2WbXpaBM2/Fev0ZqRwXqgcuvLouIHuUc2CjEsT4jUPUz2Q/Q==
X-Received: by 2002:a50:a458:0:b0:57a:322c:b1a5 with SMTP id 4fb4d7f45d1cf-57cbd6a6d1dmr5264380a12.38.1718617169052;
        Mon, 17 Jun 2024 02:39:29 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce12fsm6169015a12.7.2024.06.17.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:39:28 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:39:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Cindy Lu <lulu@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZnAETXPWG2BvyqSc@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
>
>
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Monday, June 17, 2024 7:18 AM
>> 
>> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >
>> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> > >> Add new UAPI to support the mac address from vdpa tool Function
>> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address from the
>> > >> vdpa tool and then set it to the device.
>> > >>
>> > >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> > >
>> > >Why don't you use devlink?
>> >
>> > Fair question. Why does vdpa-specific uapi even exist? To have
>> > driver-specific uapi Does not make any sense to me :/
>> 
>> It came with devlink first actually, but switched to a dedicated uAPI.
>> 
>> Parav(cced) may explain more here.
>> 
>Devlink configures function level mac that applies to all protocol devices (vdpa, rdma, netdev) etc.
>Additionally, vdpa device level mac can be different (an additional one) to apply to only vdpa traffic.
>Hence dedicated uAPI was added.

There is 1:1 relation between vdpa instance and devlink port, isn't it?
Then we have:
       devlink port function set DEV/PORT_INDEX hw_addr ADDR

Which does exactly what you need, configure function hw address (mac).

When you say VDPA traffic, do you suggest there might be VDPA instance
and netdev running on the same VF in parallel. If yes, do we have 2
eswitch port representors to be separately used to steer the traffic?
If no, how is that supposed to be working?
