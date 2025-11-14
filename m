Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F132863F
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158444; cv=none; b=aeEljkGTWYtgiE7vzgiPzgqQ6U7AaGYofoOFYgncZxtGfdN7Q1A/ekKt1QEOY0gajM+AsQtv0FGQ21Xs2olNH1K0BF0auS6rQXn+qA++hHQKJEYvsgMVCIQDI9m7/9bf8f9ZbvN3L1ORJrbnMmY4V9T9O041frpcCTol/pjCd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158444; c=relaxed/simple;
	bh=YFL5fxxxqEKSNlrulASCd7JeiIbvYBc7XWyMFO10QBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkTXPJ2V0G9nK14GuoQThHk/0FnHQtvmxs0bXvUo6huwlSGnJj8k3QATSbsA/uUpYcgfKEaR4GM4aT4/RjvmDmCF5cIAGWgHuLbu4OQbpK0LDLY6QhaUOb4xRCEy9Yvy/KkWO5ILRFgznB4oa/q7CvN2alTsUOOAIZbvWouq5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJuS1ehQ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJuS1ehQ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787d5555274so25918447b3.1
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158442; x=1763763242; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hykq0AZOv3Mcxta5MvKVi28KK2hR4lRzOujGk7TFas=;
        b=bJuS1ehQB45zcWo/REUmC/43tYJailVEmgdFOGPNcIlZ5GYEJTYXgQJ3eb4xk8EW0P
         kBDx7Ow2FoPQbCpUHTJPBtrn2bldyAdwyW5/J/wi6nyHhCwYszoKi7RGob44/TU5v5JG
         poggH9JWduPzwDbaTRaH3QsVPdHnzb8Mmzw+q2vGNZAH1ehKmMy/LfIpqDVfK6vnNv73
         LTEiJeJFBYv3vbg8cjLNn8JLTY5xU+f8qYn1b9fZ2ka/LOuUmhUqJG3Ja1sT2R9LWyfl
         ZUhTCS9Xa6kPB0hiPoZPDvuxk/qXBpGuWECdNuazwKdZY3EuR4lSwwHlUBAndEd+ogVk
         F5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158442; x=1763763242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hykq0AZOv3Mcxta5MvKVi28KK2hR4lRzOujGk7TFas=;
        b=Pg+o3fqeSSdHjkvacx26d6LEHU0fuDxbIVQRqWQW8naBFqBAWikQ2cvZVP4K8pP+E0
         fFm8rrDAGBQEv8Kc3saCTQ0/zkPYydQvMT+ygSWKu8kFKJbW4CP0jYZ2By8gwWxH7f5c
         h3VXLvXpBmf0Q04dMO/nD2CWv+aVF1Ohm2UJ4CW/lzzjNfWxM/4XJI0I+9kwuQkrw3AK
         Xw11t6wFuJsZX898f27k/RCo462MuJDjcjr0FWIZwbkOUj88ESzMxPh5HaGNySZ8Tel+
         oukfN7mvKZgNxLjexiWl0k7Kw1JH+0suHWIYFo7VYLPuzkEnsvQHeB+ozi1axlVh3Esd
         YpjA==
X-Forwarded-Encrypted: i=1; AJvYcCVYwYeYqyFw7afriqnZxHsCGfDG3WtFOwEr7jRWI1I5E3LHXLJTDuEYDojNUQT6LFp2zmKDVaWx+HpAo4LxHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNoSbL01YaCEp4aOtlBfPhNkqQzc8eaHLn1FtV3cyYtjgmco8v
	850/qdd1+nlbw1w+oaqrwiSztl9WE5R3b+qLgnmjBpNfnM9L4eRTlJM4
X-Gm-Gg: ASbGncsZXDFTctypNL7JqJS11ycGXAbTrpplYZHyA388/4i9ADsdjtpl7jAU44rrmDn
	Vt8RSU2KBkxrqgpynxN0xsedBSOMXs70nTEEn6+48yoWMONdgAg4R5LLRLuQOXnX7mhUkXcpaE+
	YWHx2GrxsHtkLiSiPcA1fWz3ao+Dd6DY4jPrTOK2ez5vLMV46rFNGR6z99ESetNBLsPrE+ifcXb
	9x/Uga9I3aV1GzRgE5BIeJbbmixuPCRUZrH2OOqSg+gZoFVw1IVMFdeAIgyo0mlakXM/LnhzYPB
	55snlIWMxSMBPDnqMhl6ue/gtlawxcTpJfWfRItpWZdSUA0pOxK0kMYI9kd5RThuUyvbU/9SVX5
	usl9Rfxq3QpFP53pgIU1u605fx4nE8mLAOLJo2nEW2kvaOAVkTj4CMugvJ+mb7ccXPKVuKfChuJ
	2AhPlNFqrz88Cp52vySur/ZDVIye/vfE8xFAD98zjiFbssEQ==
X-Google-Smtp-Source: AGHT+IGcJZO4HUiY70v/QCO/xzK+nTyMf7KdDebKqAftSKwEa0NHlBS6WCaAwow7uyA9ZmNwfg0Gcg==
X-Received: by 2002:a05:690c:7603:b0:788:ee99:f125 with SMTP id 00721157ae682-78929e0d4a5mr32556247b3.2.1763158441752;
        Fri, 14 Nov 2025 14:14:01 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822151d43sm19410627b3.46.2025.11.14.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:14:01 -0800 (PST)
Date: Fri, 14 Nov 2025 14:13:59 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <aRepp4Weuhaxgn6W@devvm11784.nha0.facebook.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
 <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
 <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
 <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>

On Fri, Nov 14, 2025 at 10:33:42AM +0100, Stefano Garzarella wrote:
> On Thu, Nov 13, 2025 at 10:26:04AM -0800, Bobby Eshleman wrote:
> > On Thu, Nov 13, 2025 at 04:24:44PM +0100, Stefano Garzarella wrote:
> > > On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
> > > > On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
> > > > > On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
> > > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > > >
> > > > > > Add NS support to vsock loopback. Sockets in a global mode netns
> > > > > > communicate with each other, regardless of namespace. Sockets in a local
> > > > > > mode netns may only communicate with other sockets within the same
> > > > > > namespace.
> > > > > >
> > > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > [...]
> > 
> > > > > > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
> > > > > > 		 */
> > > > > > 		virtio_transport_consume_skb_sent(skb, false);
> > > > > > 		virtio_transport_deliver_tap_pkt(skb);
> > > > > > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
> > > > > > +
> > > > > > +		/* In the case of virtio_transport_reset_no_sock(), the skb
> > > > > > +		 * does not hold a reference on the socket, and so does not
> > > > > > +		 * transitively hold a reference on the net.
> > > > > > +		 *
> > > > > > +		 * There is an ABA race condition in this sequence:
> > > > > > +		 * 1. the sender sends a packet
> > > > > > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
> > > > > > +		 *    sender's net
> > > > > > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
> > > > > > +		 *    sender's net
> > > > > > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
> > > > > > +		 *    reference to the socket
> > > > > > +		 * 5. the socket closes, frees its reference to the net
> > > > > > +		 * 6. Finally, the worker for the second t->send_pkt() call
> > > > > > +		 *    processes the skb, and uses the now stale net pointer for
> > > > > > +		 *    socket lookups.
> > > > > > +		 *
> > > > > > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
> > > > > > +		 * and hold it until virtio_transport_recv_pkt() completes.
> > > > > > +		 *
> > > > > > +		 * Additionally, we must grab a reference on the skb before
> > > > > > +		 * calling virtio_transport_recv_pkt() to prevent it from
> > > > > > +		 * freeing the skb before we have a chance to release the net.
> > > > > > +		 */
> > > > > > +		net_mode = virtio_vsock_skb_net_mode(skb);
> > > > > > +		net = virtio_vsock_skb_net(skb);
> > > > >
> > > > > Wait, we are adding those just for loopback (in theory used only for
> > > > > testing/debugging)? And only to support virtio_transport_reset_no_sock() use
> > > > > case?
> > > >
> > > > Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
> > > > for vhost-vsock because vhost_vsock holds a net reference, and it
> > > > doesn't exist for non-reset_no_sock calls because after looking up the
> > > > socket we transfer skb ownership to it, which holds down the skb -> sk ->
> > > > net reference chain.
> > > >
> > > > >
> > > > > Honestly I don't like this, do we have any alternative?
> > > > >
> > > > > I'll also try to think something else.
> > > > >
> > > > > Stefano
> > > >
> > > >
> > > > I've been thinking about this all morning... maybe
> > > > we can do something like this:
> > > >
> > > > ```
> > > >
> > > > virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
> > > >
> > > > virtio_transport_reset_no_sock(..., reply_sk)
> > > > {
> > > > 	if (reply_sk)
> > > > 		skb_set_owner_sk_safe(reply, reply_sk)
> > > 
> > > Interesting, but what about if we call skb_set_owner_sk_safe() in
> > > vsock_loopback.c just before calling virtio_transport_recv_pkt() for every
> > > skb?
> > 
> > I think the issue with this is that at the time vsock_loopback calls
> > virtio_transport_recv_pkt() the reply skb hasn't yet been allocated by
> > virtio_transport_reset_no_sock() and we can't wait for it to return
> > because the original skb may be freed by then.
> 
> Right!
> 
> > 
> > We might be able to keep it all in vsock_loopback if we removed the need
> > to use the original skb or sk by just using the net. But to do that we
> > would need to add a netns_tracker per net somewhere. I guess that would
> > end up in a list or hashmap in struct vsock_loopback.
> > 
> > Another option that does simplify a little, but unfortunately still doesn't keep
> > everything in loopback:
> > 
> > @@ -1205,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > 	if (!reply)
> > 		return -ENOMEM;
> > 
> > -	return t->send_pkt(reply, net, net_mode);
> > +	return t->send_pkt(reply, net, net_mode, skb->sk);
> > }
> > 
> > @@ -27,11 +27,16 @@ static u32 vsock_loopback_get_local_cid(void)
> > }
> > 
> > static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
> > -				   enum vsock_net_mode net_mode)
> > +				   enum vsock_net_mode net_mode,
> > +				   struct sock *rst_owner)
> > {
> > 	struct vsock_loopback *vsock = &the_vsock_loopback;
> > 	int len = skb->len;
> > 
> > +	if (!skb->sk && rst_owner)
> > +		WARN_ONCE(!skb_set_owner_sk_safe(skb, rst_owner),
> > +			  "loopback socket has sk_refcnt == 0\n");
> > +
> 
> This doesn't seem too bad IMO, but at this point, why we can't do that
> in virtio_transport_reset_no_sock() for any kind of transport?
> 
> I mean, in any case the RST packet should be handled by the same net of the
> "sender", no?
> 
> At this point, can we just put the `vsk` of the sender in the `info` and
> virtio_transport_alloc_skb() will already do that.
> 
> WDYT?
> Am I missing something?

This is the right answer... I'm pretty sure this works out-of-the-box
for all transports.

I'll implement it and report back with a new rev if all good or come
back to this thread to discuss if any issues arise.

Have a good weekend!

Best,
Bobby
