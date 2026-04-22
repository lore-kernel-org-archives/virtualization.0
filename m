Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBD35A399
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850816; cv=none; b=GBNRehhh4e9g9AHjBvf3rVfRizGKd4EEe0iXbnlsaSg4HXzW2LqZcIt4v9nFKY47CMdzSYCqOCNEd7oc/1pKhi43DD1SPKwgjZClhvhviwCREN6MKz/rvpYJaX1LbCQlehbmiPE54XVQdKslOW45/uEa8jYUpSZtKlqUDXufOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850816; c=relaxed/simple;
	bh=zAkck15aRQTZ1Q05U2YBuMYW04iQrWlQkMLWra0PA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XAHgYja/uwcu7dmUpqN8XYRvUygtT6pCYVOjRbLbT7Ws4aEoTHVSfApOJMSpEv3LECRXWRU9DnLEhf8LCKGnjuKrYdtltD2c+BwUZ75apqHkCAnfuxJIl6R4VZ5j5wJZ1vs9ynY1XOwOlcKZPzUYlFAknG+Vm4Gj6ZNwHQZqF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnJQeff9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnJQeff9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776850814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
	b=GnJQeff97RfbWwXlQ0PrcQWBhgw5YC6NxJZwzWYdWm16E2OBX7CUwVrJfLS4r6d9Y347li
	pWUigBMYnVicUdPKocqrcArtuZ/6djfloipKPbq+V/uWGA0Xv26MHuuKJXArk0v3YaPCBK
	D9bihbClGHWtg3KFsfmccs5hhiteOag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-b6Cs1OXgPUiQO_sKNjIZjQ-1; Wed, 22 Apr 2026 05:40:11 -0400
X-MC-Unique: b6Cs1OXgPUiQO_sKNjIZjQ-1
X-Mimecast-MFC-AGG-ID: b6Cs1OXgPUiQO_sKNjIZjQ_1776850810
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso34506875e9.3
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 02:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850810; x=1777455610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cr/tWxIjPFzBjhqZCt4BN4Fwf/3ahvnB9QHJ9ZKhqw=;
        b=JxQN0AZqtG1AoZ3mEsRJKea+G4sNX4BAyhcsViVXXJpK+eDrcwE6lmDT1hLFu3A0aO
         Qy5hzm0vzjY3KdFK1OAUV908T4quJFQxDJN+FzJV8xpiftpY15NtiIMKmAxojpMzXqGM
         VZjbLr4TwCv8ZlEb17EgbyoOCTL/Xkyiu2AZyG027VTO99rcA+D8n3P5wnhkniw/YfoH
         vkXthNtfbCofR4EurwG9btiqFmzDTrBS7WX8Yaxhd/ArpFmDIYs5EZ+7bOcLvWBvNfC3
         jd8HGTfLKaKOhMt84HXBET3rrGsqk0DF0RQkqSXk4Ybo6YMOukaC30y688asPLVibL5W
         3tFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YSsg5W5Yeh0zbPZDgsm+mein6+7AIHdzVyOTxI7MU/VagJCCRla9txrk4o2HK1x+5o6b7OxFZIwEw6IxJ7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKnKGaZt6CeSvyAMJATZ17hBJLOmvLtoyMCyAoKSVAo/4s4o63
	xXKAMadC/M+3HB0JR5WgIBsEaTGkM4+4iYo/o7XeoWjmjKQYCCZ12zv1ETTtSz/T9EztqWMuYOK
	cAI+W+1dHUYwAAW5lnAU8vIBUkHtsmN3Yomf6h0ZQIbbjUgwvTVGJ7lkGZqsS4JPkbCDK
X-Gm-Gg: AeBDieuSLJsCK7Cx/nWDSEMTZFK92lFq8eywxfHsT+Alzn9hw7gpQZK4eUpEwhlH+BO
	IEWX4nRnkrjQ4SaOANZHFefwqu3HfZN8dbLhcQTAA+HKLWLS9WwhAJRW4qJj1+VvLNL5Jq7795u
	bACc4a7aB3V0+SMsPmGY1aDz3zx/KoOv6hHTMWePVudjwxQnS8+Iekdg+eh7guL8bApO5mZejAe
	yPmdTivwhnjN2PvDVGvi7Li/9X+G7dTNOCFEwcH5gsAbAVMD0JPdA/FlAt0P3XHauMoasOgnhhY
	2vo3zalFsaLeQL8HMraGvpY0jRmlvMoPYlLQtwsm2z86l0paXQgy/ObXFMZ2ex67yRqUXMjLvZG
	h0iy9iZYqpvSgSh9MqAYbSmPa6zDvScu1LC8gjaVYBsj87j2PoZkAK1ZrKzPJzhaOO76WMQe3V2
	Xv8JukyQ==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr82211705e9.7.1776850809634;
        Wed, 22 Apr 2026 02:40:09 -0700 (PDT)
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr82211215e9.7.1776850809081;
        Wed, 22 Apr 2026 02:40:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm396567715e9.8.2026.04.22.02.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:40:08 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:40:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] hv_sock: Return -EIO for malformed/short packets
Message-ID: <aeiEsYqcKumplu5P@sgarzare-redhat>
References: <20260421174931.1152238-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260421174931.1152238-1-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tlEmIimgpvkfTkgPt4GyyevzRL-q8Ncy_cynsGsrtjI_1776850810
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 21, 2026 at 10:49:31AM -0700, Dexuan Cui wrote:
>Commit f63152958994 fixes a regression, however it fails to report an
>error for malformed/short packets -- normally we should never see such
>packets, but let's report an error for them just in case.
>
>Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
>Cc: stable@vger.kernel.org
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Commit f63152958994 is currently only in net.git's master branch.
>
> net/vmw_vsock/hyperv_transport.c | 29 +++++++++++++++++++----------
> 1 file changed, 19 insertions(+), 10 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 76e78c83fdbc..8faaa14bccda 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -704,18 +704,27 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> 		if (hvs->recv_desc) {
> 			/* Here hvs->recv_data_len is 0, so hvs->recv_desc must
> 			 * be NULL unless it points to the 0-byte-payload FIN
>-			 * packet: see hvs_update_recv_data().
>+			 * packet or a malformed/short packet: see
>+			 * hvs_update_recv_data().
> 			 *
>-			 * Here all the payload has been dequeued, but
>-			 * hvs_channel_readable_payload() still returns 1,
>-			 * because the VMBus ringbuffer's read_index is not
>-			 * updated for the FIN packet: hvs_stream_dequeue() ->
>-			 * hv_pkt_iter_next() updates the cached priv_read_index
>-			 * but has no opportunity to update the read_index in
>-			 * hv_pkt_iter_close() as hvs_stream_has_data() returns
>-			 * 0 for the FIN packet, so it won't get dequeued.
>+			 * If hvs->recv_desc points to the FIN packet, here all
>+			 * the payload has been dequeued and the peer_shutdown
>+			 * flag is set, but hvs_channel_readable_payload() still
>+			 * returns 1, because the VMBus ringbuffer's read_index
>+			 * is not updated for the FIN packet:
>+			 * hvs_stream_dequeue() -> hv_pkt_iter_next() updates
>+			 * the cached priv_read_index but has no opportunity to
>+			 * update the read_index in hv_pkt_iter_close() as
>+			 * hvs_stream_has_data() returns 0 for the FIN packet,
>+			 * so it won't get dequeued.
>+			 *
>+			 * In case hvs->recv_desc points to a malformed/short
>+			 * packet, return -EIO.
> 			 */
>-			return 0;
>+			if (hvs->vsk->peer_shutdown & SEND_SHUTDOWN)

We can access `vsk` directly, I mean `vsk->peer_shutdown`.

>+				return 0;
>+			else

nit: we usually avoid the `else` if the other branch returns early, and 
maybe have the error returned first, so it's more clear when reading the 
comment on top.  I mean something like this:

			if (!(vsk->peer_shutdown & SEND_SHUTDOWN))
				return -EIO;

			return 0;

BTW, not a strong opinion on that.

The rest, LGTM!

Thanks,
Stefano

