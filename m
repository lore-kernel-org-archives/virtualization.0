Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C67C433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 02:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD01340480;
	Tue, 30 Nov 2021 02:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzHigtZTgfCt; Tue, 30 Nov 2021 02:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7E27B4037B;
	Tue, 30 Nov 2021 02:36:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C23BC001C;
	Tue, 30 Nov 2021 02:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02291C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 02:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C857240163
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 02:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0HU4rLw5G7WV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 02:36:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 672BA40155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 02:36:51 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 47-20020a9d0332000000b005798ac20d72so28208007otv.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=D5Qw61WmuAj/yZDhi/A0/VNyCBrtN87SU10VbO44er4=;
 b=SLylTV1/Dr/0glxOCuNvB4fRMnD9BGxXeIIOHxWZK64w7G3XgItLJqZdpP+qSZmfSD
 S5dkB6jiCPz+DppG6cti58VcdaW8vVdhxPFOVUcAetqVc0Hni3wi0MowxGUNY27+JOMG
 owALRhUgLgmswLCPVu0sQYwGG4Qv540iZZ49Oj8UbQxyffuonqioQvCtE+2EjqR/qsfT
 AQWD3Vj7qbOZa0z41HMkSvsdVPC4qqUYxOqcSi9QOK2Tiy0Y35+YcJY6IaneYO/RpcC4
 jGrj5IOfY5tAaK/I+/FLlQw4m7pgFfSxGktcaPLugOvQM5YTMY5rEQa7bgjEKlfWbkut
 4Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=D5Qw61WmuAj/yZDhi/A0/VNyCBrtN87SU10VbO44er4=;
 b=A+cObR3nlUdVb4dbc24Z+LFYr69+uJeffapYEgkZrVbhh42xqUugIKb4Bj/ivXLElQ
 T/RTDSe+jwWYQ1iuax7qpNtCTNMlQEahbEYayRy5pFjqaQ62wvgalMMf7XvEcDoA6WiZ
 ZDNKXIzMKTwhp2rwW6gwWIzTOQlFMxmGnUlVeG+lPsqj70eH7TORzpdCjc/PyrqflZHG
 XhSCPCWiKZ1xhRsAQHfCqRE1GiSP+FlPYMs5FPeYxpG7WYsDoe0OjUE8aFh+A9V9wIyx
 LNMOdmOxh3DfR/e/hagBPRT3uDcGFa8Y5WD7M0JYXe3vitj3NY0LE4mwLoqQhThKER4Y
 PGkg==
X-Gm-Message-State: AOAM533p2qrx5IkRoJDQuaZ0oITWK/CSoCBHEFYR2OttlwIV8MX56GJj
 ZDwW3so4XnrwA+dKbdAWg8A=
X-Google-Smtp-Source: ABdhPJwAB8aer13liJpqkRyfHbeZSflBDN+Fnw2AzwkjsdSAtn1sPGJsHlQ3ZEokrCc1yFs+5fXVgA==
X-Received: by 2002:a9d:6084:: with SMTP id m4mr35205706otj.324.1638239810501; 
 Mon, 29 Nov 2021 18:36:50 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id s9sm3056211otg.42.2021.11.29.18.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Nov 2021 18:36:49 -0800 (PST)
Message-ID: <a4602b15-25b1-c388-73b4-1f97f6f0e555@gmail.com>
Date: Mon, 29 Nov 2021 19:36:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v2 net-next 01/26] rtnetlink: introduce generic XDP
 statistics
Content-Language: en-US
To: Alexander Lobakin <alexandr.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-2-alexandr.lobakin@intel.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211123163955.154512-2-alexandr.lobakin@intel.com>
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrei Vagin <avagin@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Noam Dagan <ndagan@amazon.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Arthur Kiyanovski <akiyano@amazon.com>,
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
 Edward Cree <ecree.xilinx@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
 netdev@vger.kernel.org, Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Martin KaFai Lau <kafai@fb.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 11/23/21 9:39 AM, Alexander Lobakin wrote:
> +static bool rtnl_get_xdp_stats_xdpxsk(struct sk_buff *skb, u32 ch,
> +				      const void *attr_data)
> +{
> +	const struct ifla_xdp_stats *xstats = attr_data;
> +
> +	xstats += ch;
> +
> +	if (nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_PACKETS, xstats->packets,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_BYTES, xstats->bytes,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_ERRORS, xstats->errors,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_ABORTED, xstats->aborted,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_DROP, xstats->drop,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_INVALID, xstats->invalid,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_PASS, xstats->pass,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_REDIRECT, xstats->redirect,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_REDIRECT_ERRORS,
> +			      xstats->redirect_errors,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_TX, xstats->tx,
> +			      IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_TX_ERRORS,
> +			      xstats->tx_errors, IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_XMIT_PACKETS,
> +			      xstats->xmit_packets, IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_XMIT_BYTES,
> +			      xstats->xmit_bytes, IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_XMIT_ERRORS,
> +			      xstats->xmit_errors, IFLA_XDP_XSTATS_UNSPEC) ||
> +	    nla_put_u64_64bit(skb, IFLA_XDP_XSTATS_XMIT_FULL,
> +			      xstats->xmit_full, IFLA_XDP_XSTATS_UNSPEC))
> +		return false;
> +
> +	return true;
> +}
> +

Another thought on this patch: with individual attributes you could save
some overhead by not sending 0 counters to userspace. e.g., define a
helper that does:

static inline int nla_put_u64_if_set(struct sk_buff *skb, int attrtype,
                                     u64 value, int padattr)
{
	if (value)
		return nla_put_u64_64bit(skb, attrtype, value, padattr);

	return 0;
}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
