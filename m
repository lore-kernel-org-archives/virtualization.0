Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC8364D9
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g63KfcVv"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83D7461474
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 12:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83D7461474
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g63KfcVv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXncQFsL8lbG
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 12:27:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A9F8060B7C
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 12:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9F8060B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701865633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KU4C0nBLzGaNCas9lIxFcej7tXPkCXsv/weoCaQosWM=;
	b=g63KfcVv56T8qC3OWrfe74XjoUwNuZl95MW+otlk4/gs0zzZuB+tbR7E9LJIbUwBCLU9KD
	nRLAXrha+IrOBk8OUs56UCc5pLhBAUm1yRA3A8Bcs/JKbY4G/2PMqWWSfEORr9Z6KovNeV
	bcxhlExDNhrEQG1z86/9aILVOZUYTCc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-GOgUe-71N46fPt5UHHQR_g-1; Wed, 06 Dec 2023 07:27:10 -0500
X-MC-Unique: GOgUe-71N46fPt5UHHQR_g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54cc7651e4eso195331a12.0
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 04:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865629; x=1702470429;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s34pD0g97ihvNhP+d7uc8e9tLFzVYhZt7dem/1oEr3U=;
        b=MUnDLDjLFIk5hy9cSkx3iXrivTkOFzZt8qy8yGB8ZgVPsfIzeDgSzRohJje4srrK4L
         HR/uzZcv/W7G7Om8MrozapUJv9c9URThIEh4Tn1RdofLwz8iHW7WTNGFRZEf1gdEPETZ
         RN97X1SNOeMUrKFuyzaKoyW9Xf7nMGnElEuuroMaMBoNZewqPWFDVaR/IEiKUtif+Ic/
         r/xGzudpU+6e/0/TZ66BhDjlRGVQ0yU+L5IwQyVU0UheEgaSf3a8H8yXugxMr+cZlRav
         DoXvCSMg24XxZb+BtbRzMGkCvw8T95sVQC7MNvQM7Pk655czFsmTgrgPhctWeEpi5uHs
         SGTg==
X-Gm-Message-State: AOJu0YzLMPAqYujrNuXHEHz18FphifZkxotq/VFU6m9QE81cC9JY5jkN
	BdaAI2N7h9NQ900x4xQoV1O3NXC4Kh21vruSyy77Kz6vVyWINE+a94czjKH8KEa/jB6+8c9GByF
	EMs0zQDXMv8u4CiJSBFUw186vRtg52U6YwC2WvZIz1w==
X-Received: by 2002:a05:6402:26c4:b0:54d:2efd:369e with SMTP id x4-20020a05640226c400b0054d2efd369emr1234941edd.1.1701865629302;
        Wed, 06 Dec 2023 04:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH881FLwuQ+1xk9Fvn62h3FiEQutCuBExRDXKtSbsKWDqWRzxUgCz0CGvLTs+2SDddZcOwsuA==
X-Received: by 2002:a05:6402:26c4:b0:54d:2efd:369e with SMTP id x4-20020a05640226c400b0054d2efd369emr1234915edd.1.1701865628893;
        Wed, 06 Dec 2023 04:27:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0054d486674d8sm1706726edb.45.2023.12.06.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:27:08 -0800 (PST)
Message-ID: <f36e686e13142d885a6e34f0a4dc2e33567ef287.camel@redhat.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd
 access
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
 mst@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com,
 edumazet@google.com,  davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org,  horms@kernel.org,
 xuanzhuo@linux.alibaba.com
Date: Wed, 06 Dec 2023 13:27:06 +0100
In-Reply-To: <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
	 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
	 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
	 <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-12-05 at 19:05 +0800, Heng Qi wrote:
>=20
> =E5=9C=A8 2023/12/5 =E4=B8=8B=E5=8D=884:35, Jason Wang =E5=86=99=E9=81=93=
:
> > On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> > > Currently access to ctrl cmd is globally protected via rtnl_lock and =
works
> > > fine. But if dim work's access to ctrl cmd also holds rtnl_lock, dead=
lock
> > > may occur due to cancel_work_sync for dim work.
> > Can you explain why?
>=20
> For example, during the bus unbind operation, the following call stack=20
> occurs:
> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close ->=
=20
> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occurs)=
.
>=20
> > > Therefore, treating
> > > ctrl cmd as a separate protection object of the lock is the solution =
and
> > > the basis for the next patch.
> > Let's don't do that. Reasons are:
> >=20
> > 1) virtnet_send_command() may wait for cvq commands for an indefinite t=
ime
>=20
> Yes, I took that into consideration. But ndo_set_rx_mode's need for an=20
> atomic
> environment rules out the mutex lock.
>=20
> > 2) hold locks may complicate the future hardening works around cvq
>=20
> Agree, but I don't seem to have thought of a better way besides passing=
=20
> the lock.
> Do you have any other better ideas or suggestions?

What about:

- using the rtnl lock only
- virtionet_close() invokes cancel_work(), without flushing the work
- virtnet_remove() calls flush_work() after unregister_netdev(),
outside the rtnl lock

Should prevent both the deadlock and the UaF.

Side note: for this specific case any functional test with a
CONFIG_LOCKDEP enabled build should suffice to catch the deadlock
scenario above.

Cheers,

Paolo

