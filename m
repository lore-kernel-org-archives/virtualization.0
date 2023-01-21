Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EFCC38A23
	for <virtualization@archiver.kernel.org>; Sat, 21 Jan 2023 19:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DAEF60B25;
	Sat, 21 Jan 2023 19:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DAEF60B25
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=blGf0rss
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Wwo9xQzS7YO; Sat, 21 Jan 2023 19:22:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5807C60B36;
	Sat, 21 Jan 2023 19:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5807C60B36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22955C0033;
	Sat, 21 Jan 2023 19:22:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE50C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Jan 2023 19:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7664C60B36
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Jan 2023 19:22:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7664C60B36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SEvwaDC77sIi
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Jan 2023 19:22:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC1D960B25
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC1D960B25
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Jan 2023 19:22:34 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 h3-20020a4ac443000000b004fb2954e7c3so1537333ooq.10
 for <virtualization@lists.linux-foundation.org>;
 Sat, 21 Jan 2023 11:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o445b1MnVY2xcczIeGhfEHs/6/N/MTgkwXpPKatAAvc=;
 b=blGf0rssVVm4/xsfLxsV1fJdJ18QG6trE/kND3h68y2KoRQZ7YJqp3Ug2tjGJtc/7C
 UIa94wgq+dllVnMbIEl45CyyUgycOLzfLCm/Gy8CwS+X82vAypOsKizt70EpHKmH35Cn
 eXEc9zjW5E4B3Qzv5HwgiO9plLXKZ1AgZ50JWCmAMizmIZ0LPLCDEZdfGNhrH3W4Nu5u
 pifwhrY8QR5QEvuKGRTWnGkd4zN7cGcM4cBrbXuNdE9Nz2zG1ea9YlqME+265CqNW4ky
 ds2QxNvIFt0WFifhuegALERmlghRRPVH8ypCEe/w9wYyMoPO8g4IJkiV0DEiirQoRZFN
 UluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o445b1MnVY2xcczIeGhfEHs/6/N/MTgkwXpPKatAAvc=;
 b=TnQRREt65lngmXyg88yQQrmH+cCLPyOmWnkBvAEPj71TMfuQ7mruupjy+w/Mt9u2pL
 tgF8/oxLd/ywq0mNQMdpM5Wa/h6hy7oT4QC6m/EBI+tjtLyAkbyOlV20P6Ibsw/AKBak
 Waxn5aRbZqzPmW+L6oCOjAC5OHnQRQZ1kveaQ+gLPCCeQJ11jNeCBJS6BlsNgJk1Merm
 DF9O5Co5OcdUho96zF8YR2ylw5kRJKrqz73miW/gNv2rUdCbMo9bMDbWzanYB60Cs6VQ
 +0ANY6bmA+LqLFfBgnlbDhNsdbMKcvfwR5Aims3h3nWJYijKH61eKORkT3CN7XLs6gnl
 B0tw==
X-Gm-Message-State: AFqh2krVc0SEPVXs97Mo92UvqoV6dWHKWVyAy/yndczcViksj0mlPLXS
 yY4qXG+dOpwY7460ltRDa24=
X-Google-Smtp-Source: AMrXdXsPJ0hrC7d2aVvmAOndVW+aw6x1kZCJgXCrvyj1ojnc8V7P1KkUOwesPpPFMQGd6vCCgvmGgw==
X-Received: by 2002:a4a:e68e:0:b0:4f5:200e:a1bf with SMTP id
 u14-20020a4ae68e000000b004f5200ea1bfmr8669367oot.1.1674328953754; 
 Sat, 21 Jan 2023 11:22:33 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:b306:d5d0:37ec:2fa])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a4a8d97000000b004a0ad937ccdsm10693131ook.1.2023.01.21.11.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jan 2023 11:22:32 -0800 (PST)
Date: Sat, 21 Jan 2023 11:22:31 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC 1/3] vsock: support sockmap
Message-ID: <Y8w7d+6UASP3jUHf@pop-os.localdomain>
References: <20230118-support-vsock-sockmap-connectible-v1-0-d47e6294827b@bytedance.com>
 <20230118-support-vsock-sockmap-connectible-v1-1-d47e6294827b@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v1-1-d47e6294827b@bytedance.com>
Cc: Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yhs@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 KP Singh <kpsingh@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Hao Luo <haoluo@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jan 18, 2023 at 12:27:39PM -0800, Bobby Eshleman wrote:
> +static int vsock_read_skb(struct sock *sk, skb_read_actor_t read_actor)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
> +	if (!vsk->transport)
> +		return -ENODEV;
> +
> +	if (!vsk->transport->read_skb)
> +		return -EOPNOTSUPP;

Can we move these two checks to sockmap update path? It would make
vsock_read_skb() faster.

> +
> +	return vsk->transport->read_skb(vsk, read_actor);
> +}

Essentially can be just this one line.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
