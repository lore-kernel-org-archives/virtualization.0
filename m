Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7335FC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 15:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08E1B40355;
	Wed,  1 Dec 2021 15:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETSZT-9hBYmh; Wed,  1 Dec 2021 15:21:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E5984038C;
	Wed,  1 Dec 2021 15:21:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 525B8C0012;
	Wed,  1 Dec 2021 15:21:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2E4BC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2DCF40359
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aBNO5PUMp15F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:21:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AC1D4038C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 15:21:26 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id w22so31355847ioa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 07:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MLUZwUEBzklOGib2Zk3PFAvxb+CbG+R1DuoQKaGE8gw=;
 b=ZuxaIRAQw9xvNctBz60Nfj9NhxbsQHjyNOETRPbMvYnh6f1pkkzEwYLKASKsQkDBsX
 cLxgvj4lcCVQwhetojQ9xZKtNbfvIHUUHXRXIUaDp7jCRfr9SAOQc+gyl9xFKXCnPeGQ
 H9NZep0ZvpgVihUy0KR8fIAAvJ1Mqn+ZN01E17kxyRlAXR/wrc5tVVh2RqcsrvC7lTt0
 TiyuS7VCsRmAr544lvRG/0BJNv1hD5xuPcyVZDknUo4F2sG8YNDlIhFfNWDQLJymasS6
 +009TxLuUtj/Vy51v2ws2aP4nFTf0va4FAhv8hFG4z4HZq3b5/zTF8SFjy9h4JUhyXM/
 l+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MLUZwUEBzklOGib2Zk3PFAvxb+CbG+R1DuoQKaGE8gw=;
 b=AAGPil1mcS+gA/3quWTnzgwnCL8T1ImUv1T3yq+oPQWuwWsa1kji0z/71z/VKu5Tv0
 tFNugNUIKhDtCdZW0o81pGN3yf0Ii1tade0VAnQvyw8kMQSDBMuuKBIKY56+CbKw/hhW
 ku/AYslBf3l/9+Yxb2TLJwjI4vX5kJMbLDEX10InVVstqz1pxFPltZbaDBHcakxmGonY
 WhIlb2+kL4lLR1ZUp3mwRxbSTfPPXtJyu6JxVtSzyUwIc3uU9c/5YTbGn10Lr/8LVQwo
 7mqllA/lY3LQ6QAVjXIo0ofVb2mocWX2Fy8vF2T51butaKlvZeu5pLAEJOiwU9MDUq5a
 X74g==
X-Gm-Message-State: AOAM5327oI8u8bzRF83o21D5+AyTsbjN8xSLC5/0iszh7Plvc1IglK1c
 3Ierzu+0vk1r/GeVis6vX9Kx+g==
X-Google-Smtp-Source: ABdhPJxtrTLI1AMMf1O0aIqny9q8Vj3DCKNibLPnD2qvc7DdypU9Rl593ilbA+ms0w9jlf6eGN7WkA==
X-Received: by 2002:a05:6638:3711:: with SMTP id
 k17mr10967372jav.72.1638372085289; 
 Wed, 01 Dec 2021 07:21:25 -0800 (PST)
Received: from [192.168.1.173]
 (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
 by smtp.googlemail.com with ESMTPSA id y15sm117996iow.44.2021.12.01.07.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Dec 2021 07:21:24 -0800 (PST)
Message-ID: <8f9faf42-8a78-f383-3b93-a17fab4ed79b@mojatatu.com>
Date: Wed, 1 Dec 2021 10:21:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP stats
Content-Language: en-US
To: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <alexandr.lobakin@intel.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211130155612.594688-1-alexandr.lobakin@intel.com>
 <20211130081207.228f42ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211130163454.595897-1-alexandr.lobakin@intel.com>
 <20211130090449.58a8327d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <18655462-c72e-1d26-5b59-d03eb993d832@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <18655462-c72e-1d26-5b59-d03eb993d832@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Andrei Vagin <avagin@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Noam Dagan <ndagan@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Yonghong Song <yhs@fb.com>, Shay Agroskin <shayagr@amazon.com>,
 Marcin Wojtas <mw@semihalf.com>, Leon Romanovsky <leon@kernel.org>,
 David Arinzon <darinzon@amazon.com>, David Ahern <dsahern@kernel.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
 Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2021-11-30 12:38, David Ahern wrote:
> Today, stats are sent as a struct so skipping stats whose value is 0 is
> not an option. When using individual attributes for the counters this
> becomes an option. Given there is no value in sending '0' why do it?
> 
> Is your pushback that there should be a uapi to opt-in to this behavior?

A filter in the netlink request should help pick what is user-preferred.
You can default to not sending zeros.

cheers,
jamal
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
