Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391B7C004D4
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 10:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A430D41944;
	Thu, 19 Jan 2023 10:44:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A430D41944
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GVWpfmPW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aEn0EUDorXcU; Thu, 19 Jan 2023 10:44:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D092241919;
	Thu, 19 Jan 2023 10:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D092241919
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E0D0C0033;
	Thu, 19 Jan 2023 10:44:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 462F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 134EC41937
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 134EC41937
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZR4jECFnho_J
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:44:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BD2E41919
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BD2E41919
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674125072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+rsSgztQ7EWmwAvYLqBC5Ld6bcZTyulRlKIF/tHgxw=;
 b=GVWpfmPW6PGg6G8RCsK/xiq4GUePfP0xUBaesvIDGAWC3DZzRSOpfVn+HpDFZmMug6yKqI
 eLlPNmXPfa90+lZchynS55CXqU4hjdqOXc4LrqjziOBFFArq0f8kDNnF/VUf4PVrb3YJXh
 5UUayXBZ05SHwU+lHiDXsEUKshTjO5k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-9emMsCAvO7iyJOGc725D3w-1; Thu, 19 Jan 2023 05:44:29 -0500
X-MC-Unique: 9emMsCAvO7iyJOGc725D3w-1
Received: by mail-qv1-f72.google.com with SMTP id
 r10-20020ad4522a000000b004d28fcbfe17so795152qvq.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 02:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+rsSgztQ7EWmwAvYLqBC5Ld6bcZTyulRlKIF/tHgxw=;
 b=Pi979k2pwtDkNNS8WO/SdZWmQWofv/AawoUYQb2a7ed+XzlRulzVCohnKi8Qd+2idx
 2R3yanc/AR3G2a/ZU2AVuEelOhv/aGIhusGqOTylF8FaguXmbc+mrn3VzMqJ+h7/T2Ka
 1jcw8lc0nKsljFmp056OY330WgSFm3g5wV09tx4jkrsVmKIH3n49Jm9KYOpQmUbb5+rc
 B30lHwKkbPzcox0Qn+sGSS0K0nMExd7TqYUMz0nMmLmOC4TSVIlfbrmCTtSKiz/dGke5
 SMAWHnEKlTkQiaWSWNlUbLUSdegspDH6f8L+87zbgxUD4xnAxZ4MPClQHUagSj5X8naB
 DvUQ==
X-Gm-Message-State: AFqh2kqlG7quPWoYXdc9jfKMAruDHmeI9xrulT3hAiQsnrvZXPyj8MZY
 MfkllqikMPo4DYzbPMyfbC0qOmVzWwRH1g4GmU8Is/TefcuNRQ2emJ8pvkFrlHqb5FiND33Q0+5
 ENpZ51q8bsIqIGsv+/wd6O829yyDLkX2/ecEV1u4fbA==
X-Received: by 2002:ac8:7744:0:b0:3b6:8d60:5592 with SMTP id
 g4-20020ac87744000000b003b68d605592mr3210996qtu.31.1674125068980; 
 Thu, 19 Jan 2023 02:44:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt56lwLvt+Kskuqb+X5HjTgsyzo+boetrR2WDxNvxNZ9GSgS9LJR4o6YNIEF845qyhok47Yug==
X-Received: by 2002:ac8:7744:0:b0:3b6:8d60:5592 with SMTP id
 g4-20020ac87744000000b003b68d605592mr3210954qtu.31.1674125068722; 
 Thu, 19 Jan 2023 02:44:28 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-245.retail.telecomitalia.it.
 [82.57.51.245]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05622a198c00b003ade7d4ad7asm15109712qtc.10.2023.01.19.02.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jan 2023 02:44:28 -0800 (PST)
Date: Thu, 19 Jan 2023 11:44:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC 2/3] selftests/bpf: add vsock to vmtest.sh
Message-ID: <20230119104420.jxooiua5fchw55qa@sgarzare-redhat>
References: <20230118-support-vsock-sockmap-connectible-v1-0-d47e6294827b@bytedance.com>
 <20230118-support-vsock-sockmap-connectible-v1-2-d47e6294827b@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230118-support-vsock-sockmap-connectible-v1-2-d47e6294827b@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 18, 2023 at 12:27:40PM -0800, Bobby Eshleman wrote:
>Add the ability to use vsock in the vmtest.sh script and
>the test kernel config.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/selftests/bpf/config.x86_64 | 4 ++++
> tools/testing/selftests/bpf/vmtest.sh     | 1 +
> 2 files changed, 5 insertions(+)
>
>diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
>index dd97d61d325ca..db5e6b9a91711 100644
>--- a/tools/testing/selftests/bpf/config.x86_64
>+++ b/tools/testing/selftests/bpf/config.x86_64
>@@ -234,7 +234,11 @@ CONFIG_VIRTIO_BLK=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_VIRTIO_NET=y
> CONFIG_VIRTIO_PCI=y
>+CONFIG_VIRTIO_VSOCKETS=y
>+CONFIG_VIRTIO_VSOCKETS_COMMON=y
> CONFIG_VLAN_8021Q=y
>+CONFIG_VSOCKETS=y
>+CONFIG_VSOCKETS_LOOPBACK=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_CPUID=y
> CONFIG_X86_MSR=y
>diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
>index 316a56d680f25..aad27ffd4ec68 100755
>--- a/tools/testing/selftests/bpf/vmtest.sh
>+++ b/tools/testing/selftests/bpf/vmtest.sh
>@@ -250,6 +250,7 @@ EOF
> 		-enable-kvm \
> 		-m 4G \
> 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
>+		-device vhost-vsock-pci,guest-cid=1234 \

I'm not sure if this will work with qemu-system-s390x and 
qemu-system-aarch64.

Maybe the "virt" machine of qemu-system-aarch64 supports PCI, but IIRC 
s390x doesn't support it and we should use the vhost-vsock-ccw device.

In addition, we are changing only config.x86_64, so maybe we should add 
the vhost-vsock-pci device only for x86_64 (maybe in the QEMU_FLAGS or a 
new VSOCK_DEV variable), and run the tests only for that architecture.

Thanks,
Stefano

> 		-kernel "${kernel_bzimage}" \
> 		-append "root=/dev/vda rw console=${QEMU_CONSOLE}"
> }
>
>-- 
>2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
