Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3494AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Dec 2021 01:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9732A40158;
	Wed, 29 Dec 2021 01:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jh8YQMTkMFF2; Wed, 29 Dec 2021 01:33:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD6124016F;
	Wed, 29 Dec 2021 01:33:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C910C001E;
	Wed, 29 Dec 2021 01:33:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AAD4C0012;
 Wed, 29 Dec 2021 01:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 277448188A;
 Wed, 29 Dec 2021 01:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8f2olkUAx5aX; Wed, 29 Dec 2021 01:33:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FEFC8184F;
 Wed, 29 Dec 2021 01:33:50 +0000 (UTC)
Received: by mail-vk1-xa2f.google.com with SMTP id s1so11220729vks.9;
 Tue, 28 Dec 2021 17:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IBcil9O+VRrBlwSK9WQFnnXvi87jfhzw0Yvv4tQzzQ4=;
 b=noDIEQ8P8sUYyX/OE18Q5FGCEdOtXRbYUWogiKJXUl19FWceFTLSzy33NO7370WsVb
 xNtywJS1aHmXYo/ZkLPfxpKAuLKxK4YE+eVz8VTkizITqKtfycFbgYZ8mkgMJWEJt21+
 SNTUf5JrpwvWrXhCSoo6DxEmJYz1lYAcgrZn5Siak7Xevszf8m10NCTaN+zXiqI+KIS/
 Eu3eNT4oCfEFd0fiD/WXOlhQ5EblQr9RpaZdLMvylKbA5ymBdmZHyFsCK1nxmVisoAn9
 uYVylo+Wo6Qmr7pTJyQxMeOn82Ns+dOHizKeng6bH3WIfBKj/q/NPdRFTbbgDlFIWhAW
 0Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=IBcil9O+VRrBlwSK9WQFnnXvi87jfhzw0Yvv4tQzzQ4=;
 b=U7aBYpDAnVFVdL9U4nqoB5Vw6EOJVjLtfZjJo0ygJA1kMBjrLHqMCLBWhBYSHn3Dun
 WByNl7ut1uR0195LRANVPPURb6kVEvdEMaC4+wqx3QyYYBANs2QwS8z22FpYSI9PEg4m
 YerYsTZAmx4x/Cgd9Q3uAwMkad/sz3rkZnqQaqH0bX/GI78S9dUmiOlq50rHT8nnciZT
 evVtGF8yjjPUKFClAvLqmfYDH47LpuFqc7KVI+IcDla5seEdnbtVEIc2C+RD83wyBjcM
 9QXnnafq5cX551cHA+riXR0ESTBYnfByKvbC4va8u1d68EkPartMaWDbW8CsNMDOgZH1
 WoPA==
X-Gm-Message-State: AOAM530i8y66F41o1kk3SaUdXRpEStTxEmGAS8o1q52+cjgv0bvPN+7e
 wlwqUGTps4a4M0Qst7iwEcs=
X-Google-Smtp-Source: ABdhPJwKKoiH34wYig8kLDUOCk3RH8x02XOvCc3/C+ewf+rsM//1r3lSXc1Bk8D6hTuZbPILWEIFJw==
X-Received: by 2002:a1f:9f04:: with SMTP id i4mr7411735vke.33.1640741629056;
 Tue, 28 Dec 2021 17:33:49 -0800 (PST)
Received: from [10.230.2.158] ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id d15sm3964460vsb.18.2021.12.28.17.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Dec 2021 17:33:48 -0800 (PST)
Message-ID: <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
Date: Tue, 28 Dec 2021 17:33:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v2] net: don't include filter.h from net/sock.h
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, ast@kernel.org, daniel@iogearbox.net
References: <20211229004913.513372-1-kuba@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Cc: andrew@lunn.ch, mustafa.ismail@intel.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, pablo@netfilter.org, andrii@kernel.org,
 george.mccollister@gmail.com, anthony.l.nguyen@intel.com, ralf@linux-mips.org,
 linux-hams@vger.kernel.org, hawk@kernel.org, steffen.klassert@secunet.com,
 linux-s390@vger.kernel.org, pkshih@realtek.com, herbert@gondor.apana.org.au,
 leon@kernel.org, linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org,
 bridge@lists.linux-foundation.org, john.fastabend@gmail.com,
 kadlec@netfilter.org, jgg@ziepe.ca, dledford@redhat.com,
 coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, nikolay@nvidia.com,
 habetsm.xilinx@gmail.com, yzaikin@google.com, vivien.didelot@gmail.com,
 wg@grandegger.com, woojung.huh@microchip.com, johan.hedberg@gmail.com,
 arnd@arndb.de, marcel@holtmann.org, jhs@mojatatu.com,
 linux-can@vger.kernel.org, wenjia@linux.ibm.com,
 Marc Kleine-Budde <mkl@pengutronix.de>, viro@zeniv.linux.org.uk,
 luiz.dentz@gmail.com, jiri@nvidia.com, xiyou.wangcong@gmail.com,
 michael.chan@broadcom.com, virtualization@lists.linux-foundation.org,
 shiraz.saleem@intel.com, trond.myklebust@hammerspace.com, kvalo@codeaurora.org,
 linux-nfs@vger.kernel.org, wintera@linux.ibm.com, keescook@chromium.org,
 netdev@vger.kernel.org, dsahern@kernel.org,
 linux-decnet-user@lists.sourceforge.net, fw@strlen.de, tariqt@nvidia.com,
 kgraul@linux.ibm.com, ecree.xilinx@gmail.com, mcgrof@kernel.org,
 netfilter-devel@vger.kernel.org, jreuter@yaina.de,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com,
 saeedm@nvidia.com, anna.schumaker@netapp.com, ap420073@gmail.com
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



On 12/28/2021 4:49 PM, Jakub Kicinski wrote:
> sock.h is pretty heavily used (5k objects rebuilt on x86 after
> it's touched). We can drop the include of filter.h from it and
> add a forward declaration of struct sk_filter instead.
> This decreases the number of rebuilt objects when bpf.h
> is touched from ~5k to ~1k.
> 
> There's a lot of missing includes this was masking. Primarily
> in networking tho, this time.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

It would be nice if we used the number of files rebuilt because of a 
header file change as another metric that the kernel is evaluated with 
from release to release (or even on a commit by commit basis). Food for 
thought.
-- 
Florian
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
