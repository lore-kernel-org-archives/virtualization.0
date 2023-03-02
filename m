Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E84BC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 09:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCF7C813F0;
	Thu,  2 Mar 2023 09:54:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCF7C813F0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gzdALdWR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-VpRCOak7TJ; Thu,  2 Mar 2023 09:54:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F2E981490;
	Thu,  2 Mar 2023 09:54:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F2E981490
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CB3C0035;
	Thu,  2 Mar 2023 09:54:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3196C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 991E181443
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 991E181443
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OFLds_u8BSX6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:54:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7C00813F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E7C00813F0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677750838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAanRdQ6lew74x0O2AW3iUiZVFolX1emAfL8FQaMI/4=;
 b=gzdALdWRMqb33PVvMB16FhKgqS4hEYbt8grKWAckL6CvyLN6dpP6UYdSCIaxhIJ+nlzrF1
 xOY65khD392eWjv2syXp32y83CKeH2NgJuLN1LquoXNXmYvcvKMCenM172bo6dtywgvacF
 uCYCO6rWYNHFckmr0E1jVmOtjTGx9XY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-CQnx40t-NF6mqzQY1OHOZA-1; Thu, 02 Mar 2023 04:53:57 -0500
X-MC-Unique: CQnx40t-NF6mqzQY1OHOZA-1
Received: by mail-qv1-f72.google.com with SMTP id
 pm17-20020ad446d1000000b0057256b237b9so8585741qvb.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 01:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677750837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAanRdQ6lew74x0O2AW3iUiZVFolX1emAfL8FQaMI/4=;
 b=e/RcsslufMgzqbt11NbPADl7dNQQZMc6g87yj9bXhct6Y8YDcgO4MC4j6enbPvomMd
 Wlef/ZMdj84yYZufvGbhfE69wIVhf7imnIoLgfAmVNp0ZWvVag8OrWBFscbztCDFhDn4
 uqPySgDVFU3dxSKwIUHmA6W8AnnB3wYW/iwv94vadwfkSkGJqFPa9PxzDHoAu1yy78+i
 EMfMhKWDpAJTtV5uXmVQjIL2DTvp4Cw+a3dWCkzYrvSd/OQtcspqEGb3w2vp23mQQfl2
 fh/Tspu0JOfd5huCdmvk6i1LVAxMABqCk6ByKbP7U24m+PjfImNXYzHgO2ff4abfTdXo
 aqcQ==
X-Gm-Message-State: AO0yUKUGzcaHSNQCzcoitomaQ4WnTiyTsfLArhFX1wOwyBYmg2zvHlfO
 6FM5gT9ObkOR/vYT+IAS6iXgBJj/clh/d2TkHL+VZxbYV8A037TkyUW/wVcmLEtRn5mmI8hBxmQ
 GxeZTGzxEX91qdc0myDTnm8eZW6fqG9IPJh0Uu4FylA==
X-Received: by 2002:ac8:7c4e:0:b0:3bf:c431:ea6e with SMTP id
 o14-20020ac87c4e000000b003bfc431ea6emr16382400qtv.3.1677750837185; 
 Thu, 02 Mar 2023 01:53:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+D27uSWXYnYHncolI/Nj6QVQLpZyQycFGgRCQpd47EnoDoYamAUXMK1mc3+TkNw/RjY6KEew==
X-Received: by 2002:ac8:7c4e:0:b0:3bf:c431:ea6e with SMTP id
 o14-20020ac87c4e000000b003bfc431ea6emr16382365qtv.3.1677750836940; 
 Thu, 02 Mar 2023 01:53:56 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 x7-20020ac87007000000b003c00573aaffsm676414qtm.3.2023.03.02.01.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 01:53:56 -0800 (PST)
Date: Thu, 2 Mar 2023 10:53:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v3 2/3] selftests/bpf: add vsock to vmtest.sh
Message-ID: <20230302095346.rbu6s3os4kz2bnbr@sgarzare-redhat>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-2-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-2-7e7f4ce623ee@bytedance.com>
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

On Tue, Feb 28, 2023 at 07:04:35PM +0000, Bobby Eshleman wrote:
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

I already acked this in the v2, please bring them between versions if 
there are no changes.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
