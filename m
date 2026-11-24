Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509840;
	b=4mKWcrGWy0/fgTP95SAk2fNOnNjEw6rt4dVUTROesRQlk1RsL71jY98XhiKCJg/sB5nX
	 /3v83dIB610QM0ZOAIrBuhuzmKG90Q7Tq+G9cnycO3Rle/EZvRswuKu5rQUsn5K9eqMWw
	 6gVmJSC7OlhFkR0JlW3YQFL5VFUrV9IoZxqabDEkaXz8N7Fn0Qx2fdlGfYXNQMykQVHBu
	 CW+UmvAZGDzNkYizwU1iXYDI5Fkjdu30jMICMpskjyREYe3tlimy3uvffXajDh2IOeQm9
	 XR+O7R5aWCjtnKUP/pgI3d0BYahmcdX0EEsiBhfkHSiQG2W1M1tUKIcdYGMossgqXvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509840;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
	b=fXDIxj5KG4zs9TWtWObTUzQywl0p7gfkoU59ojKSjM5VlcPx2pOjfbJds3QbckTYuaLp
	 s0zTS74pNSU5DZUXOk4SpHQxP89jH5dxl2uIRJFYUe6BIZBW1t2VcDqk5pqKreSUlvG0A
	 BVmr6HLJyKz6pJmJQVRqh/jaok/Kd+SqPec1LxogQSgL+ap4UKBbMnSIOJvuzAMbRG1Vj
	 GRCKbk9/WvKVCa7+YmFusrdDE9vHxopRdCIh6qeVzpyp02dE79hTRvvnwVk4ArsGjtINl
	 RScfg5hl2ciZa3M0LTGtO9serSTsaTs7iL0lEjnor9srbS7o7pK2PbO8sN2kHS6thtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAnHcKJq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A43606A332
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 08:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A43606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAnHcKJq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795509838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
	b=HAnHcKJqLqn+GmOd23f/AaT3loXDn/KN4f81J48EjELvs3zi41a8xQUTUo8Aa7sqaiGFdc
	j+6QLfLH8Z0mFqM2XIAsGmnFXOknwyfm2Db9IRBvQxwM65xBg2JbndMHnCWSH2Synqsonf
	ur7/7DRricEmMmlb8++z3PMjOhbnjoQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Km3GUECeNyyRfrCvn5xMwQ-1; Tue, 24 Nov 2026 08:43:55 +0000
X-MC-Unique: Km3GUECeNyyRfrCvn5xMwQ-1
X-Mimecast-MFC-AGG-ID: Km3GUECeNyyRfrCvn5xMwQ_1795509834
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso37573255e9.0
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 00:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509834; x=1796114634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80CiTGjH5Hdr3PjM7hQctIDbA2YeYVq6CaZ6FaFB58Q=;
        b=TqqY85xDwWofpiszodyTC1mC1mB/cflC2zMtxRArFhIuDi70jSoJGYOsoWXlXojwkW
         NRVSQ0Lo4Jh5iK65dUwLsquEVFVMy7Eo+vlXRXB2h1EcCvolDlBDyQqX7QV4O1NOf6H4
         NMIBVTw3uGZrL8hDSzdC0ezvJxhoxVJuEHefct6gAarNsTqVdgEqhZqAig6gzRlRWghd
         zqXjukzkhkWRhgZRMfjyzHphmOkwwsxiszIluiQWBLQbHV0F+mgydGbb5og07ZfYXJjV
         7eklQftwj2KzEkaT9KuMuroZMR628VkT/30BK/qZQhDDcz9fesUMr6LWG9UT+RDw/Y43
         lpTg==
X-Forwarded-Encrypted: i=1; AL+hErHx9n0V198eE+oOs73yG0Jc6Tn0PlegFU3kws4x/T29U0I67vUe4S97a+hYnYe0knLauDDBUHnjTL7+PANt8g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8d6AMrrNiJRE4T5XDeqsl7Zy9e9QoYTEHum3HfHplZN6wcdhId
	iciR7x/zzGg3EV3C4IDESNdqhz20XxgYTOTW4zbys+guLbIpXwEtIK5N3KT7ifgM9SNZXjbw+RC
	fAaS9G20D/EiHYmchBuy4YCepPhdhE7kbJok2CUrqWbokbCYvdmbucaDxtfbpZhrHIpG2
X-Gm-Gg: AZFdTZcWqq45QcD2Ily825AickkyfDqWhcV+GW3RULOkaX9GEL6kP9cLjtojl0uE6Q8
	AMX89+C7KZSKwwipQQWc7wpBQyOvI6EKFijxRWuBlQLYGF+t1FmXjL7lD7JOc5LK9WhLEZt1rjO
	0W0HoguG7iWrTxwh4NZP7n7XeBOTStY+DfwOgFKa7++0Ki88bo9GzOpYcdfiNA5xh4H/EnHSfKh
	sC9O0NCk6rrGCOaLHAyCsOVkAYTHqj+Dgn85E1TopEPBHtU0ww/HBNEBDKPxXdJ6pArBUAQXPVb
	GvPuAMcuBCNz6k0wWgqab2908jQnz+cstRG8mmKEss7UEmptBXIDE4qj13bn0NyDIlYGrBuOPPV
	FP1aeTiCiXfrL6xUprpSftAdgEd+UgvIystxKk8euDy/KsyKNcUG3WQ==
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id 5b1f17b1804b1-4bb88804d35mr314618265e9.10.1795509833923;
        Tue, 24 Nov 2026 00:43:53 -0800 (PST)
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id 5b1f17b1804b1-4bb88804d35mr314617705e9.10.1795509833526;
        Tue, 24 Nov 2026 00:43:53 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm472636285e9.12.2026.11.24.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:43:51 -0800 (PST)
Date: Tue, 24 Nov 2026 09:43:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <awVNJ4gXA7ZxvZcb@sgarzare-redhat>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <awQJo8WE5Gn4nYHp@sgarzare-redhat>
 <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
 <awQ5xzF8P0NJiCsv@sgarzare-redhat>
 <awRnZ9S+3B996VqJ@devvm29614.prn0.facebook.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <awRnZ9S+3B996VqJ@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xWek-stRKL42Xo-4veyJMRUvCa9nJp-RRFIfCGYuhhI_1795509834
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 23, 2026 at 08:18:47AM -0800, Bobby Eshleman wrote:
>On Mon, Nov 23, 2026 at 02:17:54PM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 23, 2026 at 12:58:38PM +0100, Paolo Abeni wrote:
>> > On 11/23/26 10:43, Stefano Garzarella wrote:
>> > > On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
>> > > > vsock_deliver_tap() clones every packet to every vsockmon device on the
>> > > > system. Creating one needs only CAP_NET_ADMIN in the owning user
>> > > > namespace, so an unprivileged user can capture the traffic of local mode
>> > > > namespaces.
>> > > >
>> > > > Pass the packet's netns to vsock_deliver_tap() and only deliver to
>> > > > devices that pass vsock_net_check_mode(), the same rule socket lookups
>> > > > use. vhost passes the vhost_vsock netns, loopback the sending socket's
>> > > > netns, and virtio-vsock NULL (global mode).
>> > >
>> > > For local namespaces I think we are fine, but what about global?
>> > >
>> > > Is it okay that a namespace with global can capture all the packets of other global namespaces?
>> > >
>> > > Asking because at this point the CAP_NET_ADMIN is useless, since an user on a global namespace, without CAP_NET_ADMIN, can just create a namespace to have CAP_NET_ADMIN and access all the traffic. Should we fix also that?
>> > My take is that the above question is quite orthogonal to the current patch
>> > and may impact old applications relying on the legacy behavior.
>>
>> True, but I'm not sure that behavior was correct since the beginning.
>> E.g., what is the point of having CAP_NET_ADMIN requirement if an
>> unprivileged user can just crate a new namespace and get it?
>>
>> Anyway, it's eventually pre-existing netns support in vsock, so it should be
>> fixed with a followup.
>>
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Thanks,
>> Stefano
>>
>
>Its a fair point and I agree we should take it up in a follow up. My
>current instinct is that CAP_NET_ADMIN probably shouldn't be enforced
>for some (all?) of these global-mode paths.

Why not?

I should take a closer look at what’s going on with the NICs, what 
permissions does someone intercepting traffic need to have?

Ideally, even though the addressing is global, maybe we should set it up 
so that within a namespace, you can only observe traffic generated by 
that namespace or its children.

But honestly, I don’t know how complicated that is. In fact, if you want 
isolation, you have to enable “local,” and at that point, with this 
patch, we’re all set.

Thanks,
Stefano

