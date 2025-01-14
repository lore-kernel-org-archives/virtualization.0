Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978C243334
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849833; cv=none; b=gAVj+7rxVukO1EYso2zBLfE+X6jIuxym/9KeFdeODC0GFC0Xmcr7LhcyOzWrw19bGzQoT4T7Lt9R0lkYrtg0ebRjWhQtmixybhHMp6AQseJiFGAcmI1QcsNehrhejNDRRvftHiUeWA3088YNPqTJ6EWkK2dXUaOLgAxqIzdKlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849833; c=relaxed/simple;
	bh=ypeaiYFtbSkX4QzSfRyoiNwjIzU0Sf3YPd0V+9Ugxi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cjMvuztFBI4NHVIIjRh7vHFhLuP+IMigAVsgBuWxGKBh0tUzx47K/RbN0iTPAk0B97tt+GRo25/ZzhI4uTFasgVORTrIvoXe/I2H5BUxKWxWmuJKL8jG3UsOiZTuy6jhZ4vEy3Bd8pic77ksuOV2j3Nq1NybcnNzgzUQGt1XVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahPXIm6t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahPXIm6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736849831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+mW3Tu9nGQ0HqpfC02Dq/7caIG1EhK/LPm3HcZUas=;
	b=ahPXIm6tdbkE614rLMXiCQHWcNV05sfmjbUAIAj60yQe8G9m2/sZYjkxsn+AmR7MRE3a0Q
	SphaGcrjI7DIAi5InYyc/YG4HzoHF4f/1CX1EM3fLuxlwZTFyhf1oS3xXlEgmB1xJzGKnc
	y5+lHUXQxVICTTpUo5AMcGp3zt0hsmw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-WWjzgAWNOrOa0uN3f1EyrA-1; Tue, 14 Jan 2025 05:17:07 -0500
X-MC-Unique: WWjzgAWNOrOa0uN3f1EyrA-1
X-Mimecast-MFC-AGG-ID: WWjzgAWNOrOa0uN3f1EyrA
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-467b19b5641so100553131cf.3
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 02:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849827; x=1737454627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW+mW3Tu9nGQ0HqpfC02Dq/7caIG1EhK/LPm3HcZUas=;
        b=edfDd5Jhlm29U1fxkAfiOw7KsJjRcN5y5gKlf4N+rnwnlzBt8xUmAtWW9GHk98uuRJ
         PQIJK7o3eKpwWPiTZx1iaqvnKepTJbBlgTNB2CwnQjBDkK8br7AapS8QUvi2GIQzBxS3
         4RH3W5Njtu/nJFwa2tUeVknQqgSgJzIgoSpE1cHKAS9DLRcxUXfI6C4uH7H3KedRSJOO
         PXLThOx7rIWdKbwJKKfNtP75lfmZx5jb7PLr+qQA3orwI2k8i0tOwGOw0dUGbnntibUl
         G82mhLJsXvzCp/gmLHsORaORucVkkJDgxg4uhsAFaO5as4WVdXZam0xXMIvPKRnB2Who
         OAuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Nj+hrn467Puo8wKPoZsPfpFu2CjfebfWBjj6SCY0xOpTjXdqa2sOnVmsSG/ZYeBtTdkUFPJ4DPFb498WuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU9xxZDIYdPnRPTplbGdPPN8QsMIvPWYiT0bxxQFQftUck7I83
	xK3USEiOYvTNzHWqPok2VHLqZChR8ThLRFJkJRcYrYCuHQc/0n0ZQv+a1dnBEq90dVWhUhZ0GMr
	OrqkeYlOgHUZfnWX0Ag0Ord81YhG6bMLsg+gwkwPndx1aTMtD9KGIPOij6Xt8pdXP
X-Gm-Gg: ASbGnctcQq7A0v0vNLCWyfC2K4OK/GUCUYqm+CQv3RqHfBzyRlSQYUSfNSDQM9h2y8O
	Eyhla2jW4J+9RT9HPGrMw4C/KpEaXA9nTtPzGW3roVSMu0TkxlI3xPZaN0sBWcxMuGQyrBgMUIX
	ZeHjg80EglrBhWxrFbN7ROi0oi0YwYM2o5ugFNc65n4U+nqXhW7xgxmdORWprd8iJNH99xF3nId
	ArjTQC8z09RMdqtpvtnx2sCKhVt2/dFgFtcP5vS0ZK/3KrpD8yHt1nrXXWA3wcFUwKe8O0I9fUX
	ibL6VQHeCEPCChxwioZ3dMuhyU3SQNtG
X-Received: by 2002:a05:622a:190d:b0:467:8734:994f with SMTP id d75a77b69052e-46c70eb036fmr352574041cf.0.1736849827288;
        Tue, 14 Jan 2025 02:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLaAzZkEVaIW8hnYA/mhsZiNuV3ut2W+7fORTaO+OQ8XSFW5VqRIMMDm+j9GPuo6wkgSZShQ==
X-Received: by 2002:a05:622a:190d:b0:467:8734:994f with SMTP id d75a77b69052e-46c70eb036fmr352573511cf.0.1736849826374;
        Tue, 14 Jan 2025 02:17:06 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c8732f9e8sm51362431cf.19.2025.01.14.02.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:17:05 -0800 (PST)
Date: Tue, 14 Jan 2025 11:16:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <n2itoh23kikzszzgmyejfwe3mdf6fmxzwbtyo5ahtxpaco3euq@osupldmckz7p>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
 <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
 <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
 <7de34054-10cf-45d0-a869-adebb77ad913@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7de34054-10cf-45d0-a869-adebb77ad913@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aofDlcCwVZBP43vTMo7uVi__zdnq2-zR2iF8JT5hbvs_1736849827
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 14, 2025 at 01:09:24AM +0100, Michal Luczaj wrote:
>On 1/13/25 16:01, Stefano Garzarella wrote:
>> On Mon, Jan 13, 2025 at 02:51:58PM +0100, Michal Luczaj wrote:
>>> On 1/13/25 12:05, Stefano Garzarella wrote:
>>>> ...
>>>> An alternative approach, which would perhaps allow us to avoid all this,
>>>> is to re-insert the socket in the unbound list after calling release()
>>>> when we deassign the transport.
>>>>
>>>> WDYT?
>>>
>>> If we can't keep the old state (sk_state, transport, etc) on failed
>>> re-connect() then reverting back to initial state sounds, uhh, like an
>>> option :) I'm not sure how well this aligns with (user's expectations of)
>>> good ol' socket API, but maybe that train has already left.
>>
>> We really want to behave as similar as possible with the other sockets,
>> like AF_INET, so I would try to continue toward that train.
>
>I was worried that such connect()/transport error handling may have some
>user visible side effects, but I guess I was wrong. I mean you can still
>reach a sk_state=TCP_LISTEN with a transport assigned[1], but perhaps
>that's a different issue.
>
>I've tried your suggestion on top of this series. Passes the tests.

Great, thanks!

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fa9d1b49599b..4718fe86689d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -492,6 +492,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
>
>+		vsock_addr_unbind(&vsk->local_addr);
>+		vsock_addr_unbind(&vsk->remote_addr);

My only doubt is that if a user did a specific bind() before the
connect, this way we're resetting everything, is that right?

Maybe we need to look better at the release, and prevent it from
removing the socket from the lists as you suggested, maybe adding a
function in af_vsock.c that all transports can call.

Thanks,
Stefano

>+		vsock_insert_unbound(vsk);
>+
> 		/* transport's release() and destruct() can touch some socket
> 		 * state, since we are reassigning the socket to a new transport
> 		 * during vsock_connect(), let's reset these fields to have a
>
>>> Another possibility would be to simply brick the socket on failed (re)connect.
>>
>> I see, though, this is not the behavior of AF_INET for example, right?
>
>Right.
>
>> Do you have time to investigate/fix this problem?
>> If not, I'll try to look into it in the next few days, maybe next week.
>
>I'm happy to help, but it's not like I have any better ideas.
>
>Michal
>
>[1]: E.g. this way:
>```
>from socket import *
>
>MAX_PORT_RETRIES = 24 # net/vmw_vsock/af_vsock.c
>VMADDR_CID_LOCAL = 1
>VMADDR_PORT_ANY = -1
>hold = []
>
>def take_port(port):
>	s = socket(AF_VSOCK, SOCK_SEQPACKET)
>	s.bind((VMADDR_CID_LOCAL, port))
>	hold.append(s)
>	return s
>
>s = take_port(VMADDR_PORT_ANY)
>_, port = s.getsockname()
>for _ in range(MAX_PORT_RETRIES):
>	port += 1
>	take_port(port);
>
>s = socket(AF_VSOCK, SOCK_SEQPACKET)
>err = s.connect_ex((VMADDR_CID_LOCAL, port))
>assert err != 0
>print("ok, connect failed; transport set")
>
>s.bind((VMADDR_CID_LOCAL, port+1))
>s.listen(16)
>```
>

