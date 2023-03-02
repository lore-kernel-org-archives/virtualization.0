Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B523AC678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 09:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4373C60BFE;
	Thu,  2 Mar 2023 09:20:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4373C60BFE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUMnoJru
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewyIp4LMAN_x; Thu,  2 Mar 2023 09:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95F9760B77;
	Thu,  2 Mar 2023 09:20:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95F9760B77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70707C0035;
	Thu,  2 Mar 2023 09:20:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B42C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A03EB81FB8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:20:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A03EB81FB8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cUMnoJru
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mlf8f7RUE7MS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86C3D81FB1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86C3D81FB1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677748820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNAh7WwsaV0kOk2ITHv/T/MFdHkpYUKS8lAASyQo12s=;
 b=cUMnoJruM/FiQCbLzYKR+v1jwYiCKkN3NTRfoYKkw4UnUWf7wmcVJ9Rk9KbKuYm0isTBie
 zvG1Ajk9oaaty4OL7koiRtxLXpJPwmP204GZ4gxLS1l4/EuJPes5SeEAO+P6pTKssBW+YN
 1eULUJeiyfH2N9o7LJaUAiOpTw8f/sM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-FOwbDlnoOt6q0GqQwFE2Yw-1; Thu, 02 Mar 2023 04:20:19 -0500
X-MC-Unique: FOwbDlnoOt6q0GqQwFE2Yw-1
Received: by mail-wr1-f72.google.com with SMTP id
 a7-20020a056000188700b002cdd0562b11so645973wri.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 01:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677748818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNAh7WwsaV0kOk2ITHv/T/MFdHkpYUKS8lAASyQo12s=;
 b=FSSx/bZaOAgv8BvIzI3soUff2pT12GkySzoyvUIJaCEYP++doSVbwFQebuRRZ2CIMi
 vNVcghAhE/3sBs0b7I2kffRrIzoyqq1egKR4vsR3a5JSJkxIngV0+vGtMOKSpuDapnGF
 HnTUBSi+qI8e7CSl1I2Z54VmZ/4bd8FDfdvy/CRMESAuBR0k0O8vfsob8LqpBO5xY6IC
 zKJT5fOL7Amfssl/lP7g6bK7LqsREt32JYN6N6qAEojRriqI+UZese6Gz5MC79GUEUBZ
 AfnufufcHp/6rVpP6BbFT1SqlqM8WmVZS3h61YgSvVaCew2UFcleMxEapZqpPkgR4pUc
 cyEQ==
X-Gm-Message-State: AO0yUKXKGjPQVoRLiuE/d8JUwviWiJVELjNihQ8uBGVj6ojoFZAKDb2k
 NwtQgNSN8VKuazpyZIhkgt207+AIumqaEwRG6/1Z5Y371KmGsyD+TQP8Ien1G/81BBi4vRf4LjT
 5n6l2d/yIc/QAGyh+s1VVJQvppzdLPikGn2ZGuzb91g==
X-Received: by 2002:adf:ce09:0:b0:2c5:52c3:3f05 with SMTP id
 p9-20020adfce09000000b002c552c33f05mr6913067wrn.37.1677748818283; 
 Thu, 02 Mar 2023 01:20:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9PN/kdkIqrGoMb6UfHqEwEV9RSL6zdzJVeFnieVx1t6UmihOxwNslkLjNRDZls5mCSN7BIMA==
X-Received: by 2002:adf:ce09:0:b0:2c5:52c3:3f05 with SMTP id
 p9-20020adfce09000000b002c552c33f05mr6913041wrn.37.1677748818002; 
 Thu, 02 Mar 2023 01:20:18 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a5d54d0000000b002c71703876bsm14635935wrv.14.2023.03.02.01.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 01:20:17 -0800 (PST)
Date: Thu, 2 Mar 2023 10:20:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] vsock: support sockmap
Message-ID: <20230302092009.xohos3cvowrrykck@sgarzare-redhat>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-1-7e7f4ce623ee@bytedance.com>
 <20230228163518-mutt-send-email-mst@kernel.org>
 <Y/B9ddkfQw6Ae/lY@bullseye>
MIME-Version: 1.0
In-Reply-To: <Y/B9ddkfQw6Ae/lY@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, KP Singh <kpsingh@kernel.org>,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Stanislav Fomichev <sdf@google.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
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

On Sat, Feb 18, 2023 at 07:25:41AM +0000, Bobby Eshleman wrote:
>On Tue, Feb 28, 2023 at 04:36:22PM -0500, Michael S. Tsirkin wrote:
>> On Tue, Feb 28, 2023 at 07:04:34PM +0000, Bobby Eshleman wrote:
>> > @@ -1241,19 +1252,34 @@ static int vsock_dgram_connect(struct socket *sock,
>> >
>> >  	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
>> >  	sock->state = SS_CONNECTED;
>> > +	sk->sk_state = TCP_ESTABLISHED;
>> >
>> >  out:
>> >  	release_sock(sk);
>> >  	return err;
>> >  }
>>
>>
>> How is this related? Maybe add a comment to explain? Does
>> TCP_ESTABLISHED make sense for all types of sockets?
>>
>
>Hey Michael, definitely, I can leave a comment.

I agree, since I had the same doubt in previous versions, I think it's 
worth putting a comment in the code to explain why.

Since there may be a v4, I'll leave some small comments in a separate 
email.

Thanks,
Stefano

>
>The real reason is due to this piece of logic in sockmap:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/sock_map.c?h=v6.2#n531
>
>And because of it, you see the same thing in (for example)
>unix_dgram_connect():
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/unix/af_unix.c?h=v6.2#n1394
>
>I believe it makes sense for these other socket types.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
