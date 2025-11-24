Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0721FF30
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005351; cv=none; b=BGn+Scim4P5iaXVXug8GGwiS/Tt52wtEq97zEAr46IDNL9GCWXYYhZWnpU7p+7bwi4lkPuFyojpuwnpQ43Xg3RhhAkOTKo31NnkRLSGfKOoVaJgqPK4YzPQfdBmS8PmektvYkpbiR24NWKK3Xddj9sCsfBs5M5Y4a++VklLxCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005351; c=relaxed/simple;
	bh=3qLHJf58X1rJfwubqdevEmvmYGbazTZQfyknMon5N6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR+xXcOJ3+vsMDJD5dGJiCuknNGoyQ6CyHbeVa9ImWnGauHMRYh1muR8oKFaFmNokTXL2P8nkW82V+AkjEmaPXBiKkka7w03achid39hKX+M06gazFOsO8fkDdaMI0mcQ63SdOQcMvJhdotGexrVSqoaG6u+UwikBLWpfp8I950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj1uuk5r; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj1uuk5r"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-642f3bab0c8so3181696d50.0
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764005348; x=1764610148; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htvUcTUPA56KhF8RfozM4+oaK1XLvT7ELpBPdkeAVFU=;
        b=dj1uuk5rz2nrHBXVu4qrpl4r0rh3JKoMH2jHk2FkCDeZo85AG+BX3ge6tEW2hyhDqq
         C1BTw15vsprSAgMQaY2wZmuCE/c4nhOfPa7PSCShAgzBgDuzXGMLzxGRZHfAVSFnxr6k
         b7XRHDr1GO3tDqllgJ8Z6z3Y5hQ1vy80dGUn7jXJY0KlO3mLSlp/QQWkRlB7Lt0ltb6Q
         VfoDYm5azfFRJDJnS03hUPASE27jjdw7t3WZwaZp/NLHhQH7xLeEz544cnVEtH6D2MPp
         TKVuQMgZjtWRyRWCGXs70hiyKEZE4suKItCTgKkp4/qP0jbnEjdg46B5TSCWwjPsT/5f
         X3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005348; x=1764610148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htvUcTUPA56KhF8RfozM4+oaK1XLvT7ELpBPdkeAVFU=;
        b=VWseHafqQlu3n7aLkpVu/YxVIDfX8kJKKoiLkvQnYfqbKoJ3aHZhxfwnMDuJkzxjay
         BImW6ajW3QijSznfCWq8YLoSTlXwjxPWKpbZ4Ncu6DYoZTd7wiVTV/bssJJMlLAT+i6i
         yJk7ri1ISj+11Gvv8MSUbAMQdD3IxZm1mrhU3MDe0PIuBLu7HSKNObeRfetG9zvRNdD6
         uletRdkzbpYZFdN6nzkyEHPGrqBiUofOv8cppAfqB+Jo4upi8rSihg6/RIeB4729TsOY
         m+QIkU4m2obyiaaetQflelD3ZuzvUgytPa4FhItVq0eEh+Y+MDxqrzRI+1IVJraSMPVl
         QkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQEyAcqP5afMy3IH/xHNqMdnR5i5+ejlxqtEiu+Pda7sUVTaZBidnv1uKtrDDIMA9c0LCqbs8DVn+wVO3AkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/gF/4P579mJmSM3juzwWGd2obWnYi47UXsKuvbEHYbRk96daG
	d7SckJBHGKmQ6BaZhBzV6bBT3aZg8LOIRoIIaziKCRhxythu63JZX27w
X-Gm-Gg: ASbGncu3n1wxpJxP0zndwRApzQiCWDwkl8GD+Ekypz3ApaifmUolMy2pr8D/ayoqAZh
	tp4JX/Z2ecCCp7HfyUMiBUv8TVPICFvjh+cp/bfyQqLzfJBjQJTIC0g2bAb+jykhQ2RIEzmJ2FR
	VysM3RbI3z36yHeEF4lBos1AlHi1jGtIL3Xm0v3ZDGe0mg4Td/r9bHbYZ+eDIbjk4FGzhL3Xy7n
	jpfzJCyKLs3GtgDfXszmaCq5EmOz8g8/WMkLPMBzyMRgJ/PliYKW+WyPKpB3UhnBZH2PIuKpfCH
	7IJwovw3qD45B2bYHJ8lgUfCS8wwHRp87ilVnFtlpoVs5t/e3LmhYmLUbsE4b74tf0O4kzhteoy
	19AXSHKyUTI3atrLP1uVjgvmYi/HCNWqjYzvGYOJB1ZmpjbYs5hjo7QY4rBdTfaoZV+KDbOVJbj
	LHW5S/kbhValTv1NJtrwmpfqKNZ9OIFUN7KlQVLPyuKMkbKw==
X-Google-Smtp-Source: AGHT+IFYxI8+kC4SMzaSmWEIUBq/nX6leHMHPY4z9dnG9Xg+5o4fzvBdNWYf/WnztH/joMxi+JejpA==
X-Received: by 2002:a05:690e:1482:b0:640:c9c1:a329 with SMTP id 956f58d0204a3-64302a66b95mr8027675d50.32.1764005347883;
        Mon, 24 Nov 2025 09:29:07 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7987f4e0sm47087047b3.4.2025.11.24.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:29:07 -0800 (PST)
Date: Mon, 24 Nov 2025 09:29:05 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 03/13] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <aSSV4RlRcW+uGy+n@devvm11784.nha0.facebook.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
 <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>
 <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>
 <g4xir3lupnjybh7fqig6xonp32ubotdf3emmrozdm52tpaxvxn@2t4ueynb7hqr>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g4xir3lupnjybh7fqig6xonp32ubotdf3emmrozdm52tpaxvxn@2t4ueynb7hqr>

On Mon, Nov 24, 2025 at 11:10:19AM +0100, Stefano Garzarella wrote:
> On Fri, Nov 21, 2025 at 11:01:53AM -0800, Bobby Eshleman wrote:
> > On Fri, Nov 21, 2025 at 03:24:25PM +0100, Stefano Garzarella wrote:
> > > On Thu, Nov 20, 2025 at 09:44:35PM -0800, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
> > > > is operational. Additionally, reject G2H transport registration if there
> > > > already exists a namespace in local mode.
> > > >
> > > > G2H sockets break in local mode because the G2H transports don't support
> > > > namespacing yet. The current approach is to coerce packets coming out of
> > > > G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
> > > > to coerce sockets in the same way because it cannot be deduced which
> > > > transport will be used by the socket. Specifically, when bound to
> > > > VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
> > > > until a packet is received and matched to the bound socket that we
> > > > assign the transport. This presents a chicken-and-egg problem, because
> > > > we need the namespace to lookup the socket and resolve the transport,
> > > > but we need the transport to know how to use the namespace during
> > > > lookup.
> > > >
> > > > For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
> > > > used on systems that support G2H, even nested systems that also have H2G
> > > > transports.
> > > >
> > > > Local mode is blocked based on detecting the presence of G2H devices
> > > > (when possible, as hyperv is special). This means that a host kernel
> > > > with G2H support compiled in (or has the module loaded), will still
> > > > support local mode if there is no G2H (e.g., virtio-vsock) device
> > > > detected. This enables using the same kernel in the host and in the
> > > > guest, as we do in kselftest.
> > > >
> > > > Systems with only namespace-aware transports (vhost-vsock, loopback) can
> > > > still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
> > > > intended.
> > > >
> > > > Add supports_local_mode() transport callback to indicate
> > > > transport-specific local mode support.
> > > >
> > > > These restrictions can be lifted in a future patch series when G2H
> > > > transports gain namespace support.
> > > >
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > ---
> > > > Changes in v11:
> > > > - vhost_transport_supports_local_mode() returns false to keep things
> > > >  disabled until support comes online (Stefano)
> > > > - add comment above supports_local_mode() cb to clarify (Stefano)
> > > > - Remove redundant `ret = 0` initialization in vsock_net_mode_string()
> > > >  (Stefano)
> > > > - Refactor vsock_net_mode_string() to separate parsing from validation
> > > >  (Stefano)
> > > > - vmci returns false for supports_local_mode(), with comment
> > > >
> > > > Changes in v10:
> > > > - move this patch before any transports bring online namespacing (Stefano)
> > > > - move vsock_net_mode_string into critical section (Stefano)
> > > > - add ->supports_local_mode() callback to transports (Stefano)
> > > > ---
> > > > drivers/vhost/vsock.c            |  6 ++++++
> > > > include/net/af_vsock.h           | 11 +++++++++++
> > > > net/vmw_vsock/af_vsock.c         | 32 ++++++++++++++++++++++++++++++++
> > > > net/vmw_vsock/hyperv_transport.c |  6 ++++++
> > > > net/vmw_vsock/virtio_transport.c | 13 +++++++++++++
> > > > net/vmw_vsock/vmci_transport.c   | 12 ++++++++++++
> > > > net/vmw_vsock/vsock_loopback.c   |  6 ++++++
> > > > 7 files changed, 86 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 69074656263d..4e3856aa2479 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
> > > > 	return VHOST_VSOCK_DEFAULT_HOST_CID;
> > > > }
> > > >
> > > > +static bool vhost_transport_supports_local_mode(void)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > /* Callers that dereference the return value must hold vhost_vsock_mutex or the
> > > >  * RCU read lock.
> > > >  */
> > > > @@ -412,6 +417,7 @@ static struct virtio_transport vhost_transport = {
> > > > 		.module                   = THIS_MODULE,
> > > >
> > > > 		.get_local_cid            = vhost_transport_get_local_cid,
> > > > +		.supports_local_mode	  = vhost_transport_supports_local_mode,
> > > >
> > > > 		.init                     = virtio_transport_do_socket_init,
> > > > 		.destruct                 = virtio_transport_destruct,
> > > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > > index 59d97a143204..e24ef1d9fe02 100644
> > > > --- a/include/net/af_vsock.h
> > > > +++ b/include/net/af_vsock.h
> > > > @@ -180,6 +180,17 @@ struct vsock_transport {
> > > > 	/* Addressing. */
> > > > 	u32 (*get_local_cid)(void);
> > > >
> > > > +	/* Return true if the transport is compatible with
> > > > +	 * VSOCK_NET_MODE_LOCAL. Otherwise, return false.
> > > > +	 *
> > > > +	 * Transports should return false if they lack local-mode namespace
> > > > +	 * support (e.g., G2H transports like hyperv-vsock and vmci-vsock).
> > > > +	 * virtio-vsock returns true only if no device is present in order to
> > > > +	 * enable local mode in nested scenarios in which virtio-vsock is
> > > > +	 * loaded or built-in, but nonetheless unusable by sockets.
> > > > +	 */
> > > > +	bool (*supports_local_mode)(void);
> > > > +
> > > > 	/* Read a single skb */
> > > > 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
> > > >
> > > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > > index 243c0d588682..120adb9dad9f 100644
> > > > --- a/net/vmw_vsock/af_vsock.c
> > > > +++ b/net/vmw_vsock/af_vsock.c
> > > > @@ -91,6 +91,12 @@
> > > >  *   and locked down by a namespace manager. The default is "global". The mode
> > > >  *   is set per-namespace.
> > > >  *
> > > > + *   Note: LOCAL mode is only supported when using namespace-aware transports
> > > > + *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
> > > > + *   hyperv-vsock, vmci-vsock) is operational, attempts to set LOCAL mode will
> > > > + *   fail with EOPNOTSUPP, as these transports do not support per-namespace
> > > > + *   isolation.
> > > > + *
> > > >  *   The modes affect the allocation and accessibility of CIDs as follows:
> > > >  *
> > > >  *   - global - access and allocation are all system-wide
> > > > @@ -2794,6 +2800,15 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> > > > 	else
> > > > 		return -EINVAL;
> > > >
> > > > +	mutex_lock(&vsock_register_mutex);
> > > > +	if (mode == VSOCK_NET_MODE_LOCAL &&
> > > > +	    transport_g2h && transport_g2h->supports_local_mode &&
> > > > +	    !transport_g2h->supports_local_mode()) {
> > > > +		mutex_unlock(&vsock_register_mutex);
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +	mutex_unlock(&vsock_register_mutex);
> > > 
> > > Wait, I think we already discussed about this, vsock_net_write_mode() must
> > > be called with the lock held.
> > > 
> > > See
> > > https://lore.kernel.org/netdev/aRTTwuuXSz5CvNjt@devvm11784.nha0.facebook.com/
> > > 
> > 
> > Ah right, oversight on my part.
> > 
> > > Since I guess we need another version of this patch, can you check the
> > > commit description to see if it reflects what we are doing now
> > > (e.g vhost is not enabled)?
> > > 
> > > Also I don't understand why for vhost we will enable it later, but for
> > > virtio_transport and vsock_loopback we are enabling it now, also if this
> > > patch is before the support on that transports. I'm a bit confused.
> > > 
> > > If something is unclear, let's discuss it before sending a new version.
> > > 
> > > 
> > > What I had in mind was, add this patch and explain why we need this new
> > > callback (like you did), but enable the support in the patches that
> > > really enable it for any transport. But maybe what is not clear to me is
> > > that we need this only for G2H. But now I'm confused about the discussion
> > > around vmci H2G. We decided to discard also that one, but here we are not
> > > checking that?
> > > I mean here we are calling supports_local_mode() only on G2H IIUC.
> > 
> > Ah right, VMCI broke my original mental model of only needing this check
> > for G2H (originally I didn't realize VMCI was H2G too).
> > 
> > I think now, we actually need to do this check for all of the transports
> > no? Including h2g, g2h, local, and dgram?
> > 
> > Additionally, the commit description needs to be updated to reflect that.
> 
> Let's take a step back, though, because I tried to understand the problem
> better and I'm confused.
> 
> For example, in vmci (G2H side), when a packet arrives, we always use
> vsock_find_connected_socket(), which only searches in GLOBAL. So connections
> originating from the host can only reach global sockets in the guest. In
> this direction (host -> guest), we should be fine, right?
> 
> Now let's consider the other direction, from guest to host, so the
> connection should be generated via vsock_connect().
> Here I see that we are not doing anything with regard to the source
> namespace. At this point, my question is whether we should modify
> vsock_assign_transport() or transport->stream_allow() to do this for each
> stream, and not prevent loading a G2H module a priori.
> 
> For example, stream_allow() could check that the socket namespace is
> supported by the assigned transport. E.g., vmci can check that if the
> namespace mode is not GLOBAL, then it returns false. (Same thing in
> virtio-vsock, I mean the G2H driver).
> 
> This should solve the guest -> host direction, but at this point I wonder if
> I'm missing something.

For the G2H connect case that is true, but the situation gets a little
fuzzier on the G2H RX side w/ VMADDR_CID_ANY listeners.

Let's say we have a nested system w/ both virtio-vsock and vhost-vsock.
We have a listener in namespace local on VMADDR_CID_ANY. So far, no
transport is assigned, so we can't call t->stream_allow() yet.
virtio-vsock only knows of global mode, so its lookup will fail (unless
we hack in some special case to virtio_transport_recv_pkt() to scan
local namespaces). vhost-vsock will work as expected. Letting local mode
sockets be silently unreachable by virtio-vsock seems potentially
confusing for users. If the system were not nested, we can pre-resolve
VMADDR_CID_ANY in bind() and handle things upfront as well. Rejecting
local mode outright is just a broad guardrail.

If we're trying to find a less heavy-handed option, we might be able to
do the following:

- change bind(cid) w/ cid != VMADDR_CID_ANY to directly assign the transport
  for all socket types (not just SOCK_DGRAM)

- vsock_assign_transport() can outright fail if !t->supports_local_mode()
  and sock_net(sk) has mode local

- bind(VMADDR_CID_ANY) can maybe print (once) to dmesg a warning that
  only the H2G transport will land on VMADDR_CID_ANY sockets.

I'm certainly open to other suggestions.

Best,
Bobby
