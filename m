Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04C195388
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624389; cv=none; b=dcYvUHAEIMYE9cOx7VQ9xWj/fbv2dnOxgxiTRsSMfldJTMUYJo3eaF35foPhG4Os46lgLT5aERNNgdj7tToz34d5akWp7E64eeUS/Ns9tZyErkh/nkCTZOTn2g0G5VYAezB/ohE9YEgKZaOBf8XHUT+bwL7TaoYauWRzHCup1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624389; c=relaxed/simple;
	bh=2MVBMXKtEV+SoW1Is/b02YaJ/oeQaKdapE1m/LyMP+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXBTIcJdeVmcVeVB87V7DkYAe7xAu4Hgb81aJ7IgXgX5QqYZCzW4ygBEw3L77RLSpDdDPLRfas3UhvReYGzIYGJ5wzLH30o2lru+eNK/Iv05dWwHBenuy45S9o6fm6L6p4AXdz3+d/mAhZDm2AcF9BnIQdLacaf6W61H3lVjwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WasITGw+; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WasITGw+"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28FC240468
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 11:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBTwzf-YeyXM for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 11:39:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2E16B4074E
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E16B4074E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=WasITGw+
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E16B4074E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 11:39:43 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-42108856c33so32502925e9.1
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718624382; x=1719229182; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vk6dtPNyyVj6zzyAjgfNu0JAJ1s5tHyI8dGBafB3rOw=;
        b=WasITGw+IitBEezMzOtueJf/ZBx+8jDtOJTNwvcttE7a3vA7KG5wBTgExQcmdhcZtO
         vIaz9VyjLyh8GGFO2QAe4Pg1FM6k1P8yAAeZSv/DxOciPI+iWbQzdfq+cjuCIGNeNEP2
         ZanUtZMejdPLpgibaIc0rYgnU12kzt9jBrfAn3Pq8s0FZj0z5VUH5d0uGzcNYkQ4RDql
         kZeBHe6FDijyiyxkzZ2dgDeqFGn1K6oKWJemVQ1gn2Mr/kHkX9OSsm2iEAb5Gq6CHhaM
         kQNl8ZHhhW7w9VnNX9BDaVoMECl0RfwEPbLqesQqEdWx0rYQ5ZIRFo4wIhjULj3yLrIi
         xdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718624382; x=1719229182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vk6dtPNyyVj6zzyAjgfNu0JAJ1s5tHyI8dGBafB3rOw=;
        b=dXRCba6gdYi+VNxsU4wRYIHneeUYQOF3qcPtYeji4I2RAmh1Y7LA2rec2BD6oGZL4I
         i0ZKyS/Hnnu63tOEf/Ealq4J07JXi6jaQW+J56bUw5Ue3fNPJHFeDLciNvRQSazGex6P
         GFcrpR5Q1gJWBbQCQzmI8Cvl27/KJEFjN8yPOFFZnuDGBanyK9B0nu2NNHsgraGkL5nX
         z41LIbflD07QrFSqY6SJ6Q6TnquZHitU1P1+1kFhpYNm4mPi8QbsruVqgX5DxPAFth5g
         MJ/nxJoc118qxSfgRxu9cQlER0/xrpD7cAvwmvdMSOvo/3eYL5hMugb71MtyQ7/QsN77
         rv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQacYia1AioB1l0L5B8N0J5uNj6VH15ldoIbK9c3p/iWPdNmcgH0dEP+BmdJDNOUhbixDv4pv81jt27RRyMRaD2jjcOZL8DbhhKScihYL+xNFIuUD3wazzkw==
X-Gm-Message-State: AOJu0YxdEhmf7kPSW/ySLAgRcZuywGgu8ixwspw0xuJGyxcEXtJWKlR5
	a/gMTOXSzCmB1Wr3F3b6KusLQxL2whWy7FvOar+6s0l/pxxQyLFMG3Rnxh8Lkhw=
X-Google-Smtp-Source: AGHT+IFVRuTLn45QZm+qYSRfTY8AFzPm0Gs8GMkMeMyMJm8QfZBwXB8YbsDOfaj/yQR/DXrCVERX1Q==
X-Received: by 2002:a05:600c:5110:b0:421:7f07:92ce with SMTP id 5b1f17b1804b1-4230481bc6fmr93604225e9.3.1718624381698;
        Mon, 17 Jun 2024 04:39:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6419e38sm159155415e9.39.2024.06.17.04.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:39:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:39:37 +0200
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
Message-ID: <ZnAgefA1ge11bbFp@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Jun 17, 2024 at 11:44:53AM CEST, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, June 17, 2024 3:09 PM
>> 
>> Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
>> >
>> >
>> >> From: Jason Wang <jasowang@redhat.com>
>> >> Sent: Monday, June 17, 2024 7:18 AM
>> >>
>> >> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >
>> >> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> > >> Add new UAPI to support the mac address from vdpa tool Function
>> >> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address from
>> >> > >> the vdpa tool and then set it to the device.
>> >> > >>
>> >> > >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >> > >
>> >> > >Why don't you use devlink?
>> >> >
>> >> > Fair question. Why does vdpa-specific uapi even exist? To have
>> >> > driver-specific uapi Does not make any sense to me :/
>> >>
>> >> It came with devlink first actually, but switched to a dedicated uAPI.
>> >>
>> >> Parav(cced) may explain more here.
>> >>
>> >Devlink configures function level mac that applies to all protocol devices
>> (vdpa, rdma, netdev) etc.
>> >Additionally, vdpa device level mac can be different (an additional one) to
>> apply to only vdpa traffic.
>> >Hence dedicated uAPI was added.
>> 
>> There is 1:1 relation between vdpa instance and devlink port, isn't it?
>> Then we have:
>>        devlink port function set DEV/PORT_INDEX hw_addr ADDR
>> 
>Above command is privilege command done by the hypervisor on the port function.
>Vpda level setting the mac is similar to a function owner driver setting the mac on the self netdev (even though devlink side has configured some mac for it).
>For example,
>$ ip link set dev wlan1 address 00:11:22:33:44:55

Hmm, under what sceratio exacly this is needed? I mean, the VM that has
VDPA device can actually do that too. That is the actual function owner.


>
>> Which does exactly what you need, configure function hw address (mac).
>> 
>> When you say VDPA traffic, do you suggest there might be VDPA instance and
>> netdev running on the same VF in parallel. If yes, do we have 2 eswitch port
>> representors to be separately used to steer the traffic?
>> If no, how is that supposed to be working?
>A eswitch may allow incoming and outgoing traffic from multiple mac addresses left to the tc rules to decide.
>It does not need two eswitch ports.

Ugh.

