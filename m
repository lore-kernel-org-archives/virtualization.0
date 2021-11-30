Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3413C4332F
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 17:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5147260704;
	Tue, 30 Nov 2021 17:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5W_aN7jbf61v; Tue, 30 Nov 2021 17:45:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AD75605C8;
	Tue, 30 Nov 2021 17:45:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFE4FC001C;
	Tue, 30 Nov 2021 17:45:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCF4EC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97E5040306
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DAs9GoTrMIXG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:45:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F384B40301
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 17:45:56 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id bf8so42783538oib.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XQDjVUqMHzhsaLSX72FpGvCv4WfW3bJNSIFmp2dV73Y=;
 b=i6RIwWLgsrCTl7jGOwupWsLU63T4N22hibLuzIctrW/RPwt8MAAmE3hpHlxS62fgGH
 yf83zD2tYKiIL0uvvLSDiG/MtLgPVRNVam85g9P/LDl4DDIA5IKrUdVngb3C4BM6U7/N
 /rbGn3p9sWO4MfjS9kGWlInpqhsIu+Te3zIhSXlyHUoreFE77oEecisKbn+41TXA8Xih
 W8JQjZKx2NIInNntdipij+O9RiUv1fWvXzCc2qhJm8Xa+X5oYxUMNFiFojIII9cxydFm
 J3jvQ1ur3a7M/6jYdHRPkXQ5JA5eeNR0ZuEqNY7/UeJarOJmzBVPDihzZaDtBl8lLAzi
 ELRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XQDjVUqMHzhsaLSX72FpGvCv4WfW3bJNSIFmp2dV73Y=;
 b=7xRnzcI5inndUJjcBwOKnq/R7L6bXfhQCTclQZHmV3Al61dileUNBYgkY4xqPNs9Mn
 dHuM+tbpf5R7QugX+KSlCGgoqVdE0CO9fl/KzYVb788Fc6GBK6RPipwmt/xaZyacDKjf
 aJ2QcYOdb92M18HzEonhHOBTCPqVbWbgxdL2rhb4Q+agYr6qDX/heCWOGfKGah8SWjfQ
 pI/aWPXNbMaSgIjRkIPqhHY4MCkK9e3egwLnVyjtcxBqfkjDDg03/EKIiV1GSQHRqoMq
 Fwaycdbdbh8a/lkqE86uHJY0NyOgBPzQK9uxIUY1SKfqrwbcnmX1vF5wvZyLYWEpOCHC
 T+Ow==
X-Gm-Message-State: AOAM530iJx813n/CrFNOTvafB9cHTO1Q8zUVDpxwZW//+RoExTk7QXkG
 FkFz3lLqz/sTOEeghefTpQc=
X-Google-Smtp-Source: ABdhPJzn1aa/vW8m1o9/rqJ9jY1Q1riv+YPz8e4+I2zQ9i+vkgbHrskkZ/2npSiRO579znJxNKX/mA==
X-Received: by 2002:a54:4614:: with SMTP id p20mr385770oip.39.1638294356099;
 Tue, 30 Nov 2021 09:45:56 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
 by smtp.googlemail.com with ESMTPSA id a17sm3858966oiw.43.2021.11.30.09.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Nov 2021 09:45:55 -0800 (PST)
Message-ID: <85d2b974-f596-f36e-099f-a698b6be464e@gmail.com>
Date: Tue, 30 Nov 2021 10:45:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP stats
Content-Language: en-US
To: Alexander Lobakin <alexandr.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211130155612.594688-1-alexandr.lobakin@intel.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20211130155612.594688-1-alexandr.lobakin@intel.com>
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

On 11/30/21 8:56 AM, Alexander Lobakin wrote:
> Rest:
>  - don't create a separate `ip` command and report under `-s`;

Reporting XDP stats under 'ip -s' is not going to be scalable from a
readability perspective.

ifstat (misc/ifstat.c) has support for extended stats which is where you
are adding these.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
