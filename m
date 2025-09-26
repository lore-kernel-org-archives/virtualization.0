Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF071C32FF
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905795; cv=none; b=c1asUdmlchnCuMfelcVxoBErGFmLQN9v1Xuk8gs1M04jj4zDO4WNM+PCvnJeTlDmyKvsKHxP2MRbbjzs6AlNuC7cg84L9sr6GiAr9ah/uVKtYhIt+8E2VGK6CCOFfE2176dllhOZ5bxy6WQJ80MdfrNeQFl0y4+j4dzCa2Y3kNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905795; c=relaxed/simple;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFNeaeXn2bwPbTnKAtzyHh6/vo8j5CDpgEv3WB37quNHTIzk8DBggHDxEgr2K9P6ItZKSyuUTRg6dWi75m8gOUvzH3yEHfWr7PJ2jzNRKA70bBPnKT0K6FeOdkJgCreIXFqTOm0Qq4uI6j/wh3wqz1Ce25oomXFkyUMbeR6ty5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoWTEHTR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoWTEHTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
	b=CoWTEHTRcUr2vMLRYOgll24MCESPKgM8YVcuHG9vO4n8ybwBQdad2WOyTL1s8zgs8CEJB7
	dDdb8fbUXISwP1V3+6VltuYIkqZQ65Wt0bKsQgfBk0F02MOky+7aGE+o+goREUyQFaGMq/
	uAugh4RoT+k0yyiIakXVFC+fwU3Os3I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-JcPw45ZGMgirwPkuEa8bMA-1; Fri, 26 Sep 2025 12:56:32 -0400
X-MC-Unique: JcPw45ZGMgirwPkuEa8bMA-1
X-Mimecast-MFC-AGG-ID: JcPw45ZGMgirwPkuEa8bMA_1758905791
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2717049a91.0
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 09:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905791; x=1759510591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXbsgR7Ss1aZW3LlfLUf8FaVnZ9Gf2yLcMLB47EnsOc=;
        b=hy6j+dUa03idqxyC7n+nRALW1gProk23qyUh0DIrBfOgeI7uu0Q8lSU3v/kvZ9tZHD
         eJ1sbm9clSJgm77tbhnAGGe1ruzgoElRb5MFNgAKCEnc7k+r8XDm2GWb/1Yk6bvYe0bX
         Ey7kigWsdk4S0Ry2ZaKpZOt6rAkniQxPDnenyqfjFo8VrsJC6YdSdQywPpPB2pdhgRRI
         fh1OrWvIjBWVjjQSHJp3pI388gEUO1tu7/sxl+n0sUnymwn2qtpj7GTl66eHiJEvkuH9
         fFApnybNeafYOW3j2L6OAH6p4aCRU04A9cCT00s0n3EGG/wUhHRK/a2cfMZLKrrOoq6U
         frWA==
X-Forwarded-Encrypted: i=1; AJvYcCVcx7VN2QbxGWqAj0puTMy1aZ3A23FsJ6N+kA//P0LBZMD/coFP8YFbRg40kZGX41e9fqbcpCB+6fMROdU4cw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr2CEVLQadtgB8rj80HwPeQSYaOrpxcxtdu7L/KI28pGw/mBUz
	qVCtgNPdDujRBUizqEffRcEuw6DyqJKreWPib3dDPRiGLDOrPpbKmPjgG86YBhyIi/xaGNPACL8
	EI5NFtpiVSCqthPNwMbY+vGD6tv39dsd1d0dbPkuKU8ZN5UXg+ngYoiPLvUjuxvk+7/rfFC031B
	mFztAGbfOICCfOrEIolE3LgdNja6CHEh/+rYFtelkZh+c=
X-Gm-Gg: ASbGnctUCVPs3JCyVJjXMPdlYKNJWhYFBhqya1kjUAewkrRTqDUecaULrJzLDDoZpv0
	u9mobghscfR0YAqpUumA7cdRW/JJjGrKZreeecPCPwZ2eIpCZ8Yy0pNnco0wgnrAYWDgKzZC3Jl
	qTve810OLOu3b/7jhs
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-3342a2e3a0amr9010770a91.26.1758905790911;
        Fri, 26 Sep 2025 09:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/T2nb02ygPzWQlJc91OzCWfWy7tzKbeCqK0AzZtfTw4rJhgRJgzOCPPd+wuatdh/bS3alm4U9h9urtacQQ4=
X-Received: by 2002:a17:90b:1c8e:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-3342a2e3a0amr9010727a91.26.1758905790446; Fri, 26 Sep 2025
 09:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com> <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
In-Reply-To: <wcts7brlugr337mcdfbrz5vkhvjikcaql3pdzgke5ahuuut37v@mgcqyo2umu7w>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 26 Sep 2025 18:56:19 +0200
X-Gm-Features: AS18NWDruDib3lxkmBnMwisbhI6jtN_YtNKGNRjNW1-ckH59RRm0Bu1PSqLse0I
Message-ID: <CAGxU2F6pZ7Bp53M3fTpSGDQYnrfxrttQc5bDmQLQX0cseW2A_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/9] vsock: add namespace support to vhost-vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3OAFyk4hsbwqcdk9-QQrrEQ7vSBpAwmBz0m3idl76PQ_1758905791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 15:53, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Bobby,
>
> On Tue, Sep 16, 2025 at 04:43:44PM -0700, Bobby Eshleman wrote:
> >This series adds namespace support to vhost-vsock and loopback. It does
> >not add namespaces to any of the other guest transports (virtio-vsock,
> >hyperv, or vmci).
>
> Thanks for this new series and the patience!
> I've been a bit messed up after KVM Forum between personal stuff and
> other things. I'm starting to review and test today, so between this
> afternoon and Monday I hope to send you all my comments.

Okay, I reviewed most of them (I'll do the selftest patches on Monday)
and I think we are near :-)

Just a general suggestion, please spend more time on commit description.
All of them should explain better the reasoning behind. This it will
simplify the review, but also future debug.

Thanks and have a nice weekend!
Stefano

