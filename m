Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1F7EB64DA
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 14:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E10E34086D;
	Mon, 26 Jun 2023 14:50:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E10E34086D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFYnI3dt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y71YtB9YTjh8; Mon, 26 Jun 2023 14:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D50EA4086E;
	Mon, 26 Jun 2023 14:50:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D50EA4086E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFC57C007A;
	Mon, 26 Jun 2023 14:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66A0DC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 14:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33B964156F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 14:50:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33B964156F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AFYnI3dt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cCLy8Ilby1wi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 14:50:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F367440BEB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F367440BEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687791039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5+kCdPQqZvUN049y0wQiq4t+E5gwWas2OhKvBA5CYQ=;
 b=AFYnI3dtnKohIJrZ9ghR0iwLfkQAYftNjEVjhUuqC62Wj+TR1dBwiJC3dT8Ls/HDMcByj1
 2gkwzUQ1arm2LY1U++ucwOwatfLve31cbfL5SknbRNtuR6r/wo7vgoSf3q4nu0oB+UU0lH
 0a8+Obp5TgbdxbVQaeeHElohEMPDt0M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-4buaAO2-NGmZtSxELywFjA-1; Mon, 26 Jun 2023 10:50:33 -0400
X-MC-Unique: 4buaAO2-NGmZtSxELywFjA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62f9986d687so34606906d6.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687791032; x=1690383032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5+kCdPQqZvUN049y0wQiq4t+E5gwWas2OhKvBA5CYQ=;
 b=SjJkTAGMww59xjxltICCfQbxx8cdvO79nxTdow0ZdMCMs/TpuYbiUDPIYz2GR0wkcE
 VyGqiPpOjDHwEgCTgntynyxTibsJJ9hp2AygQ5MbBdY1AwZV43cVuGxGprh3awYdPb6c
 ORfwEDNwom0X7IuqWp5KDz7jODqrutWwus5QgnYnU+/DK87jrse5nU1KmSJzRVoQWCIf
 5frcQfhzGHRWVuT59YxUq+ucTkSXvkkpxMB2IdurncfBtW3RCWaUIbCVjD/ggaD1O93N
 zPWxNWkoaNcxDkwsiQHVpnbBWOOOvlyl9MuPJRcQMBXWY3CV4wMJZ/YokQdT1T8idI1k
 bSAA==
X-Gm-Message-State: AC+VfDzg12XJbNfIHZPFEdg8BCq7gs1ZzX1Uynm5vHAZoT8aZCkx16Tl
 /A7UOsZza6gNbCgND0gJI0Iv44pd2OwS/vnLtPCVfuEKOJPwx4dIDrJBDE5DnikC9/wUlig6ifa
 yj5soiJkznovfUkiAuOt0cjf78MMDgzj704e22zfo+Q==
X-Received: by 2002:a05:6214:29e4:b0:635:e696:b314 with SMTP id
 jv4-20020a05621429e400b00635e696b314mr1005721qvb.58.1687791032279; 
 Mon, 26 Jun 2023 07:50:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TmnUDHDdLDrYwlG8x2M9rK8Vc0auOUbahtUoqXs378EEmUDgmMHtci3th6fKJraKyUyH9eA==
X-Received: by 2002:a05:6214:29e4:b0:635:e696:b314 with SMTP id
 jv4-20020a05621429e400b00635e696b314mr1005704qvb.58.1687791031954; 
 Mon, 26 Jun 2023 07:50:31 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 dp8-20020a05621409c800b0062ff179a538sm2315271qvb.123.2023.06.26.07.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 07:50:31 -0700 (PDT)
Date: Mon, 26 Jun 2023 16:50:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v4 3/8] vsock: support multi-transport
 datagrams
Message-ID: <zp6jvoddzjquq2bngujpy5wnameuopou7jonqvm2vexebrbr5k@lh4imo4zyi4k>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-3-0cebbb2ae899@bytedance.com>
 <tngyeva5by3aldrhlixajjin2hqmcl6uruvuoed7hyrndlesfd@bbv7aphqye2q>
 <ZJUIWcgg13F7DNBm@bullseye> <ZJUKi+NtOajbplQg@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZJUKi+NtOajbplQg@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
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

On Fri, Jun 23, 2023 at 02:59:23AM +0000, Bobby Eshleman wrote:
>On Fri, Jun 23, 2023 at 02:50:01AM +0000, Bobby Eshleman wrote:
>> On Thu, Jun 22, 2023 at 05:19:08PM +0200, Stefano Garzarella wrote:
>> > On Sat, Jun 10, 2023 at 12:58:30AM +0000, Bobby Eshleman wrote:
>> > > This patch adds support for multi-transport datagrams.
>> > >
>> > > This includes:
>> > > - Per-packet lookup of transports when using sendto(sockaddr_vm)
>> > > - Selecting H2G or G2H transport using VMADDR_FLAG_TO_HOST and CID in
>> > >  sockaddr_vm
>> > >
>> > > To preserve backwards compatibility with VMCI, some important changes
>> > > were made. The "transport_dgram" / VSOCK_TRANSPORT_F_DGRAM is changed to
>> > > be used for dgrams iff there is not yet a g2h or h2g transport that has
>> >
>> > s/iff/if
>> >
>> > > been registered that can transmit the packet. If there is a g2h/h2g
>> > > transport for that remote address, then that transport will be used and
>> > > not "transport_dgram". This essentially makes "transport_dgram" a
>> > > fallback transport for when h2g/g2h has not yet gone online, which
>> > > appears to be the exact use case for VMCI.
>> > >
>> > > This design makes sense, because there is no reason that the
>> > > transport_{g2h,h2g} cannot also service datagrams, which makes the role
>> > > of transport_dgram difficult to understand outside of the VMCI context.
>> > >
>> > > The logic around "transport_dgram" had to be retained to prevent
>> > > breaking VMCI:
>> > >
>> > > 1) VMCI datagrams appear to function outside of the h2g/g2h
>> > >   paradigm. When the vmci transport becomes online, it registers itself
>> > >   with the DGRAM feature, but not H2G/G2H. Only later when the
>> > >   transport has more information about its environment does it register
>> > >   H2G or G2H. In the case that a datagram socket becomes active
>> > >   after DGRAM registration but before G2H/H2G registration, the
>> > >   "transport_dgram" transport needs to be used.
>> >
>> > IIRC we did this, because at that time only VMCI supported DGRAM. Now that
>> > there are more transports, maybe DGRAM can follow the h2g/g2h paradigm.
>> >
>>
>> Totally makes sense. I'll add the detail above that the prior design was
>> a result of chronology.
>>
>> > >
>> > > 2) VMCI seems to require special message be sent by the transport when a
>> > >   datagram socket calls bind(). Under the h2g/g2h model, the transport
>> > >   is selected using the remote_addr which is set by connect(). At
>> > >   bind time there is no remote_addr because often no connect() has been
>> > >   called yet: the transport is null. Therefore, with a null transport
>> > >   there doesn't seem to be any good way for a datagram socket a tell the
>> > >   VMCI transport that it has just had bind() called upon it.
>> >
>> > @Vishnu, @Bryan do you think we can avoid this in some way?
>> >
>> > >
>> > > Only transports with a special datagram fallback use-case such as VMCI
>> > > need to register VSOCK_TRANSPORT_F_DGRAM.
>> >
>> > Maybe we should rename it in VSOCK_TRANSPORT_F_DGRAM_FALLBACK or
>> > something like that.
>> >
>> > In any case, we definitely need to update the comment in
>> > include/net/af_vsock.h on top of VSOCK_TRANSPORT_F_DGRAM mentioning
>> > this.
>> >
>>
>> Agreed. I'll rename to VSOCK_TRANSPORT_F_DGRAM_FALLBACK, unless we find
>> there is a better way altogether.
>>
>> > >
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > > drivers/vhost/vsock.c                   |  1 -
>> > > include/linux/virtio_vsock.h            |  2 -
>> > > net/vmw_vsock/af_vsock.c                | 78 +++++++++++++++++++++++++--------
>> > > net/vmw_vsock/hyperv_transport.c        |  6 ---
>> > > net/vmw_vsock/virtio_transport.c        |  1 -
>> > > net/vmw_vsock/virtio_transport_common.c |  7 ---
>> > > net/vmw_vsock/vsock_loopback.c          |  1 -
>> > > 7 files changed, 60 insertions(+), 36 deletions(-)
>> > >
>> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > > index c8201c070b4b..8f0082da5e70 100644
>> > > --- a/drivers/vhost/vsock.c
>> > > +++ b/drivers/vhost/vsock.c
>> > > @@ -410,7 +410,6 @@ static struct virtio_transport vhost_transport = {
>> > > 		.cancel_pkt               = vhost_transport_cancel_pkt,
>> > >
>> > > 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
>> > > -		.dgram_bind               = virtio_transport_dgram_bind,
>> > > 		.dgram_allow              = virtio_transport_dgram_allow,
>> > > 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
>> > > 		.dgram_get_port		  = virtio_transport_dgram_get_port,
>> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > > index 23521a318cf0..73afa09f4585 100644
>> > > --- a/include/linux/virtio_vsock.h
>> > > +++ b/include/linux/virtio_vsock.h
>> > > @@ -216,8 +216,6 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
>> > > u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
>> > > bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
>> > > bool virtio_transport_stream_allow(u32 cid, u32 port);
>> > > -int virtio_transport_dgram_bind(struct vsock_sock *vsk,
>> > > -				struct sockaddr_vm *addr);
>> > > bool virtio_transport_dgram_allow(u32 cid, u32 port);
>> > > int virtio_transport_dgram_get_cid(struct sk_buff *skb, unsigned int *cid);
>> > > int virtio_transport_dgram_get_port(struct sk_buff *skb, unsigned int *port);
>> > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > > index 74358f0b47fa..ef86765f3765 100644
>> > > --- a/net/vmw_vsock/af_vsock.c
>> > > +++ b/net/vmw_vsock/af_vsock.c
>> > > @@ -438,6 +438,18 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
>> > > 	return transport;
>> > > }
>> > >
>> > > +static const struct vsock_transport *
>> > > +vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
>> > > +{
>> > > +	const struct vsock_transport *transport;
>> > > +
>> > > +	transport = vsock_connectible_lookup_transport(cid, flags);
>> > > +	if (transport)
>> > > +		return transport;
>> > > +
>> > > +	return transport_dgram;
>> > > +}
>> > > +
>> > > /* Assign a transport to a socket and call the .init transport callback.
>> > >  *
>> > >  * Note: for connection oriented socket this must be called when vsk->remote_addr
>> > > @@ -474,7 +486,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> > >
>> > > 	switch (sk->sk_type) {
>> > > 	case SOCK_DGRAM:
>> > > -		new_transport = transport_dgram;
>> > > +		new_transport = vsock_dgram_lookup_transport(remote_cid,
>> > > +							     remote_flags);
>> > > 		break;
>> > > 	case SOCK_STREAM:
>> > > 	case SOCK_SEQPACKET:
>> > > @@ -691,6 +704,9 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> > > static int __vsock_bind_dgram(struct vsock_sock *vsk,
>> > > 			      struct sockaddr_vm *addr)
>> > > {
>> > > +	if (!vsk->transport || !vsk->transport->dgram_bind)
>> > > +		return -EINVAL;
>> > > +
>> > > 	return vsk->transport->dgram_bind(vsk, addr);
>> > > }
>> > >
>> > > @@ -1172,19 +1188,24 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>> > >
>> > > 	lock_sock(sk);
>> > >
>> > > -	transport = vsk->transport;
>> > > -
>> > > -	err = vsock_auto_bind(vsk);
>> > > -	if (err)
>> > > -		goto out;
>> > > -
>> > > -
>> > > 	/* If the provided message contains an address, use that.  Otherwise
>> > > 	 * fall back on the socket's remote handle (if it has been connected).
>> > > 	 */
>> > > 	if (msg->msg_name &&
>> > > 	    vsock_addr_cast(msg->msg_name, msg->msg_namelen,
>> > > 			    &remote_addr) == 0) {
>> > > +		transport = vsock_dgram_lookup_transport(remote_addr->svm_cid,
>> > > +							 remote_addr->svm_flags);
>> > > +		if (!transport) {
>> > > +			err = -EINVAL;
>> > > +			goto out;
>> > > +		}
>> > > +
>> > > +		if (!try_module_get(transport->module)) {
>> > > +			err = -ENODEV;
>> > > +			goto out;
>> > > +		}
>> > > +
>> > > 		/* Ensure this address is of the right type and is a valid
>> > > 		 * destination.
>> > > 		 */
>> > > @@ -1193,11 +1214,27 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>> > > 			remote_addr->svm_cid = transport->get_local_cid();
>> > >
>> >
>> > From here ...
>> >
>> > > 		if (!vsock_addr_bound(remote_addr)) {
>> > > +			module_put(transport->module);
>> > > +			err = -EINVAL;
>> > > +			goto out;
>> > > +		}
>> > > +
>> > > +		if (!transport->dgram_allow(remote_addr->svm_cid,
>> > > +					    remote_addr->svm_port)) {
>> > > +			module_put(transport->module);
>> > > 			err = -EINVAL;
>> > > 			goto out;
>> > > 		}
>> > > +
>> > > +		err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
>> >
>> > ... to here, looks like duplicate code, can we get it out of the if block?
>> >
>>
>> Yes, I think using something like this:
>>
>> [...]
>> 	bool module_got = false;
>>
>> [...]
>> 		if (!try_module_get(transport->module)) {
>> 			err = -ENODEV;
>> 			goto out;
>> 		}
>> 		module_got = true;
>>
>> [...]
>>
>> out:
>> 	if (likely(transport && !err && module_got))
>
>Actually, just...
>
>	if (module_got)
>

Yep, I think it should work ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
