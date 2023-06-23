Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810D9EB64DD
	for <virtualization@archiver.kernel.org>; Fri, 23 Jun 2023 08:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ED744200A;
	Fri, 23 Jun 2023 08:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0ED744200A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aW65jzpk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLOLOWwo-S8W; Fri, 23 Jun 2023 08:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 14FAF40984;
	Fri, 23 Jun 2023 08:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14FAF40984
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E14DBC0037;
	Fri, 23 Jun 2023 08:15:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E400DC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 08:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE4CA60AEE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 08:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE4CA60AEE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aW65jzpk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E6lgyMx4ih10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 08:15:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E83AF60AA7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E83AF60AA7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 08:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687508131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vvP94iL0b14tTM53kZ2sYxqnmPo54a4UlF6JdzA9tVs=;
 b=aW65jzpkXirMWxcmKr//NauzfCUq7esMDQ9Xp+Rhsx0rekXtC7TCdsfMu+NwJB7Qi69Q+n
 whDpH0m+Skyr6RRElKy9pZPHQ99FFK61i2aJ4qGQx5zdAVrrOtQezzrgPQ7p/DNCGyzOM6
 hyjbUEtfvKdMah6gYLRklZVSJOTDR+E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-V9VW9GWnMcGjOhxdGJMGoA-1; Fri, 23 Jun 2023 04:15:28 -0400
X-MC-Unique: V9VW9GWnMcGjOhxdGJMGoA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355cf318so27712066b.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jun 2023 01:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687508127; x=1690100127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvP94iL0b14tTM53kZ2sYxqnmPo54a4UlF6JdzA9tVs=;
 b=T+1UYuarzkcw7PSldhh3tLsGzt/i61aLuXapziYgSFW9Potw/8jEsE7BRhOLOi1HJj
 9YSw1ni4QaIGtoEBF7RIT7U5BL0cgaLcSTO5qd/zDrFWINd6z+ec4Uyp4g35TQ211Xlz
 SARtrb/Jybh66LWk2/Xijev0HfV3BD6X4w4q6ESMKWQJs9lpAxxschbrjhFoAMnPEBCf
 TGQcIPP8yLtNo34M25gHnMx+JoU4JsYkVuh/xNoibCDZ4qqGgTPgUSKx5iGvXX3iLaYR
 mnCo51YxxVjTlyDzBqPCx7xJNeenqD8HtFXtaqeAWnb/f/9GR3fkY6hQ/IcHS/H27wrT
 hLmA==
X-Gm-Message-State: AC+VfDwtysbJ76WsqQgOs71eO9BlZVliRr1MVlFaeZIe3pVN8M1IRwPA
 uQRxzPZd1NqGnFbtkvmK1KVIfsmVoT+0DhOGTXdEPIq5bpBWRHWb+Sp07zw4CRd3YBBhnwQjioN
 ia4xnu3+aX9Eghb32Rzopkto89IYBZMwpK5YP9spwKg==
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id
 hd31-20020a170907969f00b00947335f5a0dmr18564024ejc.62.1687508127031; 
 Fri, 23 Jun 2023 01:15:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sG50KKcb8/4d0k9Sa5DNa+zxv2rKJ2E9yej3gVqMAjHzgkvZGHjdevsBGJ9oYHGKr3rl2Pw==
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id
 hd31-20020a170907969f00b00947335f5a0dmr18563999ejc.62.1687508126768; 
 Fri, 23 Jun 2023 01:15:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 o11-20020a17090608cb00b00985ed2f1584sm5635492eje.187.2023.06.23.01.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 01:15:26 -0700 (PDT)
Date: Fri, 23 Jun 2023 10:15:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v4 4/8] vsock: make vsock bind reusable
Message-ID: <oq5c2c4snksklko6tmq44g73d6ihrbnqjyugsvfbhtdsnlrioi@hklfspvyjmad>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
 <p2tgn3wczd3t3dodyicczetr2nqnqpwcadz6ql5hpvg2cd2dxa@phheksxhxfna>
 <ZJTTx0XJ2LeITNh0@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZJTTx0XJ2LeITNh0@bullseye>
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

On Thu, Jun 22, 2023 at 11:05:43PM +0000, Bobby Eshleman wrote:
>On Thu, Jun 22, 2023 at 05:25:55PM +0200, Stefano Garzarella wrote:
>> On Sat, Jun 10, 2023 at 12:58:31AM +0000, Bobby Eshleman wrote:
>> > This commit makes the bind table management functions in vsock usable
>> > for different bind tables. For use by datagrams in a future patch.
>> >
>> > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > ---
>> > net/vmw_vsock/af_vsock.c | 33 ++++++++++++++++++++++++++-------
>> > 1 file changed, 26 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index ef86765f3765..7a3ca4270446 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -230,11 +230,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>> > 	sock_put(&vsk->sk);
>> > }
>> >
>> > -static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > +struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>> > +					    struct list_head *bind_table)
>> > {
>> > 	struct vsock_sock *vsk;
>> >
>> > -	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>> > +	list_for_each_entry(vsk, bind_table, bound_table) {
>> > 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>> > 			return sk_vsock(vsk);
>> >
>> > @@ -247,6 +248,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > 	return NULL;
>> > }
>> >
>> > +static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>> > +{
>> > +	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>> > +}
>> > +
>> > static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>> > 						  struct sockaddr_vm *dst)
>> > {
>> > @@ -646,12 +652,17 @@ static void vsock_pending_work(struct work_struct *work)
>> >
>> > /**** SOCKET OPERATIONS ****/
>> >
>> > -static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> > -				    struct sockaddr_vm *addr)
>> > +static int vsock_bind_common(struct vsock_sock *vsk,
>> > +			     struct sockaddr_vm *addr,
>> > +			     struct list_head *bind_table,
>> > +			     size_t table_size)
>> > {
>> > 	static u32 port;
>> > 	struct sockaddr_vm new_addr;
>> >
>> > +	if (table_size < VSOCK_HASH_SIZE)
>> > +		return -1;
>>
>> Why we need this check now?
>>
>
>If the table_size is not at least VSOCK_HASH_SIZE then the
>VSOCK_HASH(addr) used later could overflow the table.
>
>Maybe this really deserves a WARN() and a comment?

Yes, please WARN_ONCE() should be enough.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
