Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E263FB0D
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWDga/2J"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1E9A43713
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 11:18:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1E9A43713
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EWDga/2J
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLWcu2IXSvnt
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 11:18:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A77E436F2
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 11:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A77E436F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702552687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VaN6TC3I4TNZRPtVPtcTdPQQalk1XpMFkRRRirXd7I0=;
	b=EWDga/2JP0zUrH00LkWSF8z8SGIvb0jbZ/qNn+iP+G0OPUjjv0fhdbEIaf85IEwNbp5HFl
	Ee5wwvi+HxwkuUJRohdrV4URn6Eu3/N3h7Cf/vgWeKuDdI3fJuQSNzO8JN0iXuGwYGtO9V
	ZrNwsmNu7oQEqZEDtVGfsGe4t9SSb8o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ToCVrTiPOACT63po9ZfIwg-1; Thu, 14 Dec 2023 06:18:04 -0500
X-MC-Unique: ToCVrTiPOACT63po9ZfIwg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-55285349727so74445a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 03:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552683; x=1703157483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaN6TC3I4TNZRPtVPtcTdPQQalk1XpMFkRRRirXd7I0=;
        b=WqwMHZzAhB+frZOaSryfX8vAugmPl//f5E4fTPXL0rr/A0I3XCJPz0UO6/gYNACOlm
         VmIIFGoW1ocDOvR6dxh/mXGzZWT5kB2CdGgYwM0XKhH5ZJAY9RP24Jres+43U92/9Umo
         EWkQzcfPLFKms8L7mL4J0vuPH0+bZiSjBDT2jWUhefsia1DLlE4eyfcufrhGthA8rrYj
         /fCyECGaR2W1Mm6tK566r9UhrJsSZn6kpNxIox/OHmAMxeX0pf1ophx2+gvGJe8ytlX1
         VfxJnSO90tKXgYnfyCdFfK+IehAgvFMvnKGtzKUB82YlTalBamFF26o7cQ3ctUqmgvwz
         HDlg==
X-Gm-Message-State: AOJu0YzVZYyLQHZIcHbVNc28Z1z30b+Gm3zRtEvOAUAX5jk1YcdZIAKK
	mADAABAId1uNPiCn6CsDUDlXsLm0eCThgqxCiRo6Cre98mUnA2cJeq87hoJdFBvEA7SbQ0XCuPB
	BtDnVkRrOugIFh0RaRaMEjpoE73Yo4PAFRl6B2i4FPw==
X-Received: by 2002:a05:6402:2318:b0:551:76e6:afdb with SMTP id l24-20020a056402231800b0055176e6afdbmr2088868eda.77.1702552683022;
        Thu, 14 Dec 2023 03:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExaY3rnjXkKwpudV8D5zjSW1Nso5V7k/Hde8rQ0+0YKYqG4gygBYOpDhXTnB2wvb4N1mYL8Q==
X-Received: by 2002:a05:6402:2318:b0:551:76e6:afdb with SMTP id l24-20020a056402231800b0055176e6afdbmr2088851eda.77.1702552682642;
        Thu, 14 Dec 2023 03:18:02 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id dk4-20020a0564021d8400b005522eddd380sm1316992edb.34.2023.12.14.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:18:01 -0800 (PST)
Date: Thu, 14 Dec 2023 06:17:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v9 3/4] vsock: update SO_RCVLOWAT setting
 callback
Message-ID: <20231214061738-mutt-send-email-mst@kernel.org>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
 <20231214091947.395892-4-avkrasnov@salutedevices.com>
 <20231214052502-mutt-send-email-mst@kernel.org>
 <e0e601a9-6cb2-e484-eb70-f41e7ec69c65@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e0e601a9-6cb2-e484-eb70-f41e7ec69c65@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 01:52:50PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 14.12.2023 13:29, Michael S. Tsirkin wrote:
> > On Thu, Dec 14, 2023 at 12:19:46PM +0300, Arseniy Krasnov wrote:
> >> Do not return if transport callback for SO_RCVLOWAT is set (only in
> >> error case). In this case we don't need to set 'sk_rcvlowat' field in
> >> each transport - only in 'vsock_set_rcvlowat()'. Also, if 'sk_rcvlowat'
> >> is now set only in af_vsock.c, change callback name from 'set_rcvlowat'
> >> to 'notify_set_rcvlowat'.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Maybe squash this with patch 2/4?
> 
> You mean just do 'git squash' without updating commit message manually?
> 
> Thanks, Arseniy

commit message should reflect all that patch does.

> > 
> >> ---
> >>  Changelog:
> >>  v3 -> v4:
> >>   * Rename 'set_rcvlowat' to 'notify_set_rcvlowat'.
> >>   * Commit message updated.
> >>
> >>  include/net/af_vsock.h           | 2 +-
> >>  net/vmw_vsock/af_vsock.c         | 9 +++++++--
> >>  net/vmw_vsock/hyperv_transport.c | 4 ++--
> >>  3 files changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >> index e302c0e804d0..535701efc1e5 100644
> >> --- a/include/net/af_vsock.h
> >> +++ b/include/net/af_vsock.h
> >> @@ -137,7 +137,6 @@ struct vsock_transport {
> >>  	u64 (*stream_rcvhiwat)(struct vsock_sock *);
> >>  	bool (*stream_is_active)(struct vsock_sock *);
> >>  	bool (*stream_allow)(u32 cid, u32 port);
> >> -	int (*set_rcvlowat)(struct vsock_sock *vsk, int val);
> >>  
> >>  	/* SEQ_PACKET. */
> >>  	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> >> @@ -168,6 +167,7 @@ struct vsock_transport {
> >>  		struct vsock_transport_send_notify_data *);
> >>  	/* sk_lock held by the caller */
> >>  	void (*notify_buffer_size)(struct vsock_sock *, u64 *);
> >> +	int (*notify_set_rcvlowat)(struct vsock_sock *vsk, int val);
> >>  
> >>  	/* Shutdown. */
> >>  	int (*shutdown)(struct vsock_sock *, int);
> >> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> index 816725af281f..54ba7316f808 100644
> >> --- a/net/vmw_vsock/af_vsock.c
> >> +++ b/net/vmw_vsock/af_vsock.c
> >> @@ -2264,8 +2264,13 @@ static int vsock_set_rcvlowat(struct sock *sk, int val)
> >>  
> >>  	transport = vsk->transport;
> >>  
> >> -	if (transport && transport->set_rcvlowat)
> >> -		return transport->set_rcvlowat(vsk, val);
> >> +	if (transport && transport->notify_set_rcvlowat) {
> >> +		int err;
> >> +
> >> +		err = transport->notify_set_rcvlowat(vsk, val);
> >> +		if (err)
> >> +			return err;
> >> +	}
> >>  
> >>  	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
> >>  	return 0;
> > 
> > 
> > 
> > I would s
> > 
> >> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> >> index 7cb1a9d2cdb4..e2157e387217 100644
> >> --- a/net/vmw_vsock/hyperv_transport.c
> >> +++ b/net/vmw_vsock/hyperv_transport.c
> >> @@ -816,7 +816,7 @@ int hvs_notify_send_post_enqueue(struct vsock_sock *vsk, ssize_t written,
> >>  }
> >>  
> >>  static
> >> -int hvs_set_rcvlowat(struct vsock_sock *vsk, int val)
> >> +int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
> >>  {
> >>  	return -EOPNOTSUPP;
> >>  }
> >> @@ -856,7 +856,7 @@ static struct vsock_transport hvs_transport = {
> >>  	.notify_send_pre_enqueue  = hvs_notify_send_pre_enqueue,
> >>  	.notify_send_post_enqueue = hvs_notify_send_post_enqueue,
> >>  
> >> -	.set_rcvlowat             = hvs_set_rcvlowat
> >> +	.notify_set_rcvlowat      = hvs_notify_set_rcvlowat
> >>  };
> >>  
> >>  static bool hvs_check_transport(struct vsock_sock *vsk)
> >> -- 
> >> 2.25.1
> > 

