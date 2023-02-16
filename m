Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08ABC61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 10:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E0704023F;
	Thu, 16 Feb 2023 10:12:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E0704023F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IhP5V33a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id npEG5cx4zhnY; Thu, 16 Feb 2023 10:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6D5540297;
	Thu, 16 Feb 2023 10:12:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6D5540297
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 917DCC0032;
	Thu, 16 Feb 2023 10:12:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06CBDC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D629940297
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D629940297
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L53OZtKKDRhm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:12:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9595B4023F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9595B4023F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676542345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wLm8OV5SZ3K17LU2/PE/CsDcErtwY0pKaR4xgAdsEhE=;
 b=IhP5V33aVOsQ8ZKNFRgG+FoDHcOa0PcocLroDR4kVyMKDyx5AAZ2Lzcs+qIQ0kvKkJYt9+
 5hDrmXtQdpzeWfEH49WFGLAP5fZR5kPO0HVbaQ+qgoICwwYIcJ6yOH+ycWw43xIyTTFTh0
 yToUfZD4cUD41GW+qK07ZUgjEIKGp/4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-BXEyR2f9OFyzvTsFy0PgHQ-1; Thu, 16 Feb 2023 05:12:24 -0500
X-MC-Unique: BXEyR2f9OFyzvTsFy0PgHQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 o24-20020a05620a22d800b007389d2f57f3so875751qki.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 02:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLm8OV5SZ3K17LU2/PE/CsDcErtwY0pKaR4xgAdsEhE=;
 b=ghkwSxHomKL7ny4wTYYrh8z9b+hc/0DpL2ijkaDg5xE+mgASPjIwDjjWncU7BvccV8
 QIm0uvyz7lXAh1ud3yA+wygmoUOftblOK3McjGPhEmoB4dQArD5G9E59KEJ8IC2kurgY
 +AdhJdoY+GbE+iZG+l/RS2uB20xNJw7tt9njHhkUEk2tGoNwgC9cAV8RyW1GW/wWZCWT
 dBKUW8QqLn98aw47gFmrIgwKF8unmeETLh1yDAi7JKhbSw0oWWAd9uUAD9MwhMg23Vs3
 hdD/FQ6qJVic1ktYcknn4EuxzbkPxEqY0mx0JuLyUl72s0mG/nHKMc1+GCnJZXswq7qA
 wuIQ==
X-Gm-Message-State: AO0yUKXya6B5osFTWBbueeu6ENG3GhPGYSDvK21Z9oLg7epXHVCSQBnQ
 Q1O2TG7tRTC+/kjzS2naYLRk+EXZkNZ/ZQBjQuRzZYr7NaShE8NZkFOC59Q2Wd/Tz73bE4/Cc/u
 au79XI6cawSG9XHuPV4Attb1MF3RcHbxIF19lYho+bA==
X-Received: by 2002:a05:622a:4d4:b0:3b8:6b96:de6d with SMTP id
 q20-20020a05622a04d400b003b86b96de6dmr8781725qtx.18.1676542343703; 
 Thu, 16 Feb 2023 02:12:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/zE2Vo8IFiM5bi4CYFWFwpnz4WpLl7uD3E3+3LHHuXvGxuiCHVQXEZwLa/M9o96TnD3MRZ3w==
X-Received: by 2002:a05:622a:4d4:b0:3b8:6b96:de6d with SMTP id
 q20-20020a05622a04d400b003b86b96de6dmr8781680qtx.18.1676542343413; 
 Thu, 16 Feb 2023 02:12:23 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 o14-20020ac8554e000000b003b9e1d3a502sm453519qtr.54.2023.02.16.02.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 02:12:23 -0800 (PST)
Date: Thu, 16 Feb 2023 11:12:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 2/3] selftests/bpf: add vsock to vmtest.sh
Message-ID: <20230216101214.eor4myzdsvihjww3@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v2-0-58ffafde0965@bytedance.com>
 <20230118-support-vsock-sockmap-connectible-v2-2-58ffafde0965@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v2-2-58ffafde0965@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, hdanton@sina.com,
 cong.wang@bytedance.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, jakub@cloudflare.com,
 Daniel Borkmann <daniel@iogearbox.net>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jan 30, 2023 at 08:35:13PM -0800, Bobby Eshleman wrote:
>Add vsock loopback to the test kernel.
>
>This allows sockmap for vsock to be tested.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/selftests/bpf/config.aarch64 | 2 ++
> tools/testing/selftests/bpf/config.s390x   | 3 +++
> tools/testing/selftests/bpf/config.x86_64  | 3 +++
> 3 files changed, 8 insertions(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
>index 1f0437644186..253821494884 100644
>--- a/tools/testing/selftests/bpf/config.aarch64
>+++ b/tools/testing/selftests/bpf/config.aarch64
>@@ -176,6 +176,8 @@ CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> CONFIG_VIRTIO_MMIO=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
> CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_XFRM_USER=y
>diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
>index d49f6170e7bd..2ba92167be35 100644
>--- a/tools/testing/selftests/bpf/config.s390x
>+++ b/tools/testing/selftests/bpf/config.s390x
>@@ -140,5 +140,8 @@ CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_XFRM_USER=y
>diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
>index dd97d61d325c..b650b2e617b8 100644
>--- a/tools/testing/selftests/bpf/config.x86_64
>+++ b/tools/testing/selftests/bpf/config.x86_64
>@@ -234,7 +234,10 @@ CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_MSR=y
>
>-- 
>2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
