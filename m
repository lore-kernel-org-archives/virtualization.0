Received: from mail-oi2-f16.google.com (mail-oi2-f16.google.com [74.125.231.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696C46EC9E
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593850; cv=none; b=pLkUadUDwhRJt7pEljbyluf6r/f+kGB+Bb6yZAQr3GKFVKbs5MRsgGHyniFBn3Y/KS4QgghdD9IwUjlBHhv1wG9tmNFHtmPel6s9DfbYWZ4Ip2gaqYBJeR2IoK4iVIGJFC8K5L0ZMRpaOj/6zBypnf9erTi1kTqCaxjae/iHP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593850; c=relaxed/simple;
	bh=2UIZhQGNlp0yvgPj2bp76HRBxinSpLpWqq5nZWfgdJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmhSYVT/KVckrJL5HTxa1/F0RNSKJ05INcysSTGyIT2SVJ1m3xjp8q6c97erpc23LoFUOvbhQv8LbDQECKbomaWC9uFkq3KuyxkL2EvKJm9bkm2ySDa66B8dzsH61UJtbpNV97LBHYhP4w5zhnsRknICsGrwtuzqyWwKmhKvnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA9PKu0Q; arc=none smtp.client-ip=74.125.231.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA9PKu0Q"
Received: by mail-oi2-f16.google.com with SMTP id 46e09a7af769-7f4f0c89e35so112982a34.2
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593833; x=1790198633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XSIk8tJbuXToHcbml5dyAhA+YFmm4IR2Ghd4XhDQSyI=;
        b=kA9PKu0QofeA4aVdQY0a4E9wSmnY/VUv6q7+M9exK9XZIk0g56dRGlYJ78M/F3dIn+
         uE6qbcVP7ht9bnBfxueuxY+mYqkTEw4/2w4dB0iUDUaLwZ+eXFiqoQS0gMRiKDzivpoz
         N1cvQy17/8IbtY7SW13M38MIAhX0Xk2HdQ9GWGQhgjwU8QEK1A0oLvKLB5oN+q+ezapj
         PQcOMkmctKt/x5QlcchH0Pbg3RJFO0LGrNidw9SR29F2FW12QkoN+Nco0/qP6JirffUz
         uCskMTiNRl/OPi0hXCKQwswNaMFgaOFfohnU5wOZ38W9aV/NXuKpILFHKBvStiTNJVxl
         CbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593833; x=1790198633;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSIk8tJbuXToHcbml5dyAhA+YFmm4IR2Ghd4XhDQSyI=;
        b=SDGUBq0x1TeE2soq/ce7Qa/iAKBWadtsDG5WtVZbk3n6lIz4M8olow3fxYt+1tdenv
         kh+xx/6pC/Hdz0viyy+DkCKjos73TEjgIl3MmtX3Z08s5Npu2kAW0sq49lu/CR57Vb2K
         odqLQeDVaxbJfniX451WTUQwd5VmkWpx3fTVFde8glgLuunRD7hEY4vpdlT/2QhyG8ug
         /yDDfaz3fd78tcdD1gaWDkb3c4p5qlbXykNnQBNLG8HJEZsnh3xSsvRssr5pw7deLYhs
         QhZzvG+Mcm2WdOGl6Kk8Co6gL152B4RLdQm6UOQ5UFOJNMDj7fFayiYgE71vMzWPLXlw
         erjg==
X-Forwarded-Encrypted: i=1; AKwUvBw7zfuAWcqaJuZd3HuXRyyTmIWoVAjieJL9Nl1kt91C/wFu2HcW+KuSzGdEnmuFzDlArNR6ZQAcDMZtRZXtsw==@lists.linux.dev
X-Gm-Message-State: AFuF++mx+IlxIinRsbVSowjCwYQ7fHl9SXbBQGLzP+lj7Mniod6Hs6gs
	kCNKpsaAoj+Qo434t6Sv3T8ismHol7TEakwIKRs3EbEJIUMj6p245pQr
X-Gm-Gg: AYBFou0m9QuNr/oqNgGq4dKVbT84VVvpGRMHGUkIv1r8c7KfhbRN/63E7rg3NuUa2Jf
	YKjxV7rRezQ1gIzdUo3hcEPRoFO6uOPChlwDQ5yuBLPN7QSm6ENdERxfDFnCYq5JR4P8au5B+fH
	yR/mV7IMHVgP2nKxZNkER+bhGF3HBL+pVPxth89rryXva8c5MUPQ2mSxK/CjzPScLdnUezZirv7
	4l3FszrNttIbaiAOlTAGrhNBTtJblrsJ9yq5KU9lkwwiNKopDTKDntjmCOY+ask9oDJMDVyFCKL
	2kDSFmCXLsX4MDldTNHxgVblFJ10nybL2IdIvyw2bUSfS4GRmF5KrKlSFHYrpWyebyigbj2ITeP
	Jkg52LEDzIEarX7bG7Fv23TCAR6Cl8sPk+YYMsN105j/Ygi1+8lPDB7qThVuPCJKefcAOwj08ki
	3gNv4/IftL9XhWvVFEe4kxebmC2B+NP4gMfZ11V6bN2GLGRLBTDVWgpNhlYU6eiW6cZgfDJQvD7
	RF+kWVe6KLuwRtYlbGP
X-Received: by 2002:a05:6830:6017:b0:7e6:ef1d:4aeb with SMTP id 46e09a7af769-80b2e0576bemr4670574a34.15.1789593833101;
        Wed, 16 Sep 2026 14:23:53 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c466a2dcesm1059784a34.11.2026.09.16.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:23:52 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:23:48 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Message-ID: <aqsI5BXRB96dkIHm@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
 <aqlTlFvQL34-WViB@sgarzare-redhat>
 <aqmTYoCMmzx1BM1v@devvm29614.prn0.facebook.com>
 <aqqPXr2LNJUM4yMW@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqPXr2LNJUM4yMW@sgarzare-redhat>

On Wed, Sep 16, 2026 at 02:57:43PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 11:50:10AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 15, 2026 at 05:28:25PM +0200, Stefano Garzarella wrote:
> > > On Wed, Sep 02, 2026 at 04:00:48PM -0700, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > Namespaces let a host isolate a VM's vsock traffic to a specific
> > > > namespace, but in a guest vsock traffic cannot be isolated to a
> > > > namespace. The vsock device is hardcoded to global mode and can't be
> > > > moved into a local-mode namespace.
> > > >
> > > > Introduce ioctl IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS on /dev/vsock that
> > > 
> > > We already discussed about netlink, but I'm not sure how much work can
> > > take, here just another alternative, what about adding
> > > /proc/sys/net/vsock/g2h_owner sysctl that can be read/write where:
> > > 0 - no owner
> > > 1 - owner
> > > 
> > > 0 -> 1 transition, move the device in the new nets
> > > 1 -> 0 transition, reset back to init_ns
> > 
> > That seems reasonable, but if multi-device support ever lands, this
> > might be harder to adapt cleanly?
> 
> I see, but maybe we can have a dev0/ dev1/ subfolders in that case.
> 
> > 
> > > 
> > > > gives userspace a way to move the device to the calling pid's namespace.
> > > > The call requires CAP_NET_ADMIN in the root user namespace. A privileged
> > > > user wishing to "unassign" the device can move it to the init_netns,
> > > > which is hardcoded to global mode (so no unassign call is necessary).
> > > >
> > > > A getter to read the current assignment back was considered, returning
> > > > either the namespace's net_cookie or its nsfs inode number, but neither
> > > > seemed useful enough to bake into the uAPI now. It can be added later if
> > > > a user turns up that needs it.
> > > >
> > > > Add a transport hook to indicate support for guest namespacing, so that
> > > > transports may opt in/out. A transport that opts out keeps the
> > > > reachability rules it had before this ioctl existed.
> > > >
> > > > Sockets are reset when the underlying device moves to a different
> > > > namespace, so as to prevent reachability from the previous and now
> > > > disallowed namespace.
> > > >
> > > > Following the approach of netdevs, the device returns to init_net when
> > > > its namespace is removed. Care is taken to not break flows when the
> > > > device is inside a global namespace that is being torn down and alive
> > > > sockets are in a different global namespace. In this scenario, the
> > > > device's netns getter pre-emptively falls back to the init_net (always
> > > > global) so that these flows are not disrupted. If init_netns ever
> > > > supports local-mode in the future, this logic will have to be changed.
> > > >
> > > > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > ---
> > > > Documentation/admin-guide/sysctl/net.rst |  18 +++
> > > > include/net/af_vsock.h                   |   7 ++
> > > > include/uapi/linux/vm_sockets.h          |   6 +
> > > > net/vmw_vsock/af_vsock.c                 | 198 ++++++++++++++++++++++++++++++-
> > > > 4 files changed, 228 insertions(+), 1 deletion(-)
> > > >
> 
> [...]
> 
> > > > +
> > > > +static void vsock_reset_unreachable_sock(struct sock *sk)
> > > > +{
> > > > +	if (vsock_g2h_net_reachable(sock_net(sk)))
> > > > +		return;
> > > > +
> > > > +	sk->sk_state = TCP_CLOSE;
> > > > +	sk->sk_err = ECONNRESET;
> > > > +	sk_error_report(sk);
> > > 
> > > Should we send the reset to the other peer too?
> > > 
> > > Or avoid to set TCP_CLOSE, so the user will see the error and close it?
> > 
> > Sending the reset sounds good. At least the peer won't be waiting around
> > forever. Will work that into v2.
> 
> If it's too much of work, we can skip it, it's not a strong opinion on my
> side. It was more a question of what we should do ;-)
> 
> > 
> > > 
> > > > +}
> > > > +
> > > > +/* Move the g2h device to @net. Returns -ENODEV if no g2h transport is loaded
> > > > + * and -EOPNOTSUPP if the loaded one cannot be moved.
> > > > + */
> > > > +static int vsock_g2h_net_assign(struct net *net)
> > > > +{
> > > > +	int ret = 0;
> > > > +
> > > > +	mutex_lock(&vsock_register_mutex);
> > > > +	if (!transport_g2h) {
> > > > +		ret = -ENODEV;
> > > > +	} else if (!vsock_g2h_netns_assignable()) {
> > > > +		ret = -EOPNOTSUPP;
> > > > +	} else {
> > > > +		/* See vsock_maybe_set_connected() comment about synchronizing
> > > > +		 * with connecting sockets.
> > > > +		 */
> > > > +		rcu_assign_pointer(vsock_g2h_net, net);
> > > > +		vsock_for_each_connected_socket(transport_g2h,
> > > > +						vsock_reset_unreachable_sock);
> > > > +	}
> > > > +	mutex_unlock(&vsock_register_mutex);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/* Move the g2h device back to init_net if it lives in @net, which is about to
> > > > + * be destroyed.
> > > > + */
> > > > +static void vsock_g2h_net_reset(struct net *net)
> > > > +{
> > > > +	bool reset = false;
> > > > +
> > > > +	/* Avoid taking the mutex if the namespaces don't match. */
> > > > +	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
> > > > +		return;
> > > > +
> > > > +	mutex_lock(&vsock_register_mutex);
> > > > +	if (rcu_access_pointer(vsock_g2h_net) == net) {
> > > > +		rcu_assign_pointer(vsock_g2h_net, &init_net);
> > > > +		reset = true;
> > > > +	}
> > > > +	mutex_unlock(&vsock_register_mutex);
> > > > +
> > > > +	if (reset)
> > > > +		synchronize_rcu();
> > > > +}
> > > > +
> > > > static struct sock *vsock_dequeue_accept(struct sock *listener)
> > > > {
> > > > 	struct vsock_sock *vlistener;
> > > > @@ -2745,6 +2920,15 @@ static long vsock_dev_do_ioctl(struct file *filp,
> > > > 			retval = -EFAULT;
> > > > 		break;
> > > >
> > > > +	case IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS:
> > > > +		if (!capable(CAP_NET_ADMIN)) {
> > > > +			retval = -EPERM;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		retval = vsock_g2h_net_assign(current->nsproxy->net_ns);
> > > > +		break;
> > > > +
> > > > 	default:
> > > > 		retval = -ENOIOCTLCMD;
> > > > 	}
> > > > @@ -2978,6 +3162,7 @@ static __net_init int vsock_sysctl_init_net(struct net *net)
> > > >
> > > > static __net_exit void vsock_sysctl_exit_net(struct net *net)
> > > > {
> > > > +	vsock_g2h_net_reset(net);
> > > 
> > > Why calling this in the sysctl_exit ?
> > 
> > Should we add another pernet_operations? I agree the name of
> > vsock_sysctl_ops does not really fit as a general "do all per-net
> > operations here" location.
> 
> Aaaaa, it's not really related to sysctl.
> 
> Maybe we can rename it or add another pernet_operations.
> 
> > 
> > > 
> > > > 	vsock_sysctl_unregister(net);
> > > > }
> > > >
> > > > @@ -3104,13 +3289,21 @@ EXPORT_SYMBOL_GPL(vsock_core_register);
> > > >
> > > > void vsock_core_unregister(const struct vsock_transport *t)
> > > > {
> > > > +	bool g2h_net_reset = false;
> > > > +
> > > > 	mutex_lock(&vsock_register_mutex);
> > > >
> > > > 	if (transport_h2g == t)
> > > > 		transport_h2g = NULL;
> > > >
> > > > -	if (transport_g2h == t)
> > > > +	if (transport_g2h == t) {
> > > > 		transport_g2h = NULL;
> > > > +		/* The device is gone, so is its namespace assignment. */
> > > > +		if (rcu_access_pointer(vsock_g2h_net) != &init_net) {
> > > > +			rcu_assign_pointer(vsock_g2h_net, &init_net);
> > > > +			g2h_net_reset = true;
> > > > +		}
> > > > +	}
> > > >
> > > > 	if (transport_dgram == t)
> > > > 		transport_dgram = NULL;
> > > > @@ -3119,6 +3312,9 @@ void vsock_core_unregister(const struct vsock_transport *t)
> > > > 		transport_local = NULL;
> > > >
> > > > 	mutex_unlock(&vsock_register_mutex);
> > > > +
> > > > +	if (g2h_net_reset)
> > > > +		synchronize_rcu();
> > > 
> > > Why we need this? (I'd add also a comment with the reason)
> > 
> > We might actually be able to drop it... I do think we need to keep it in
> > vsock_g2h_net_reset() because it makes sure that vsock_g2h_net_get()
> > doesn't dereference a destroyed net.
> > 
> > vsock_core_unregister() isn't on the teardown path, so even if we
> > re-assign to init_net the previous net is still alive.
> 
> Agree.
> 
> > 
> > 
> > One thing I realized when answering your uAPI questions and looking at
> > the code is that IOCTL_VM_SOCKETS_GET_LOCAL_CID is not namespace aware,
> > but I think it probably should be? I remember for host ns we strived for
> > truly strong isolation.
> 
> Can you elabore a bit more?
> 

I'm wondering if IOCTL_VM_SOCKETS_GET_LOCAL_CID should not reveal the
CID of the g2h device if the device has been moved to an inaccessible
namespace? In this case, fallback to the results of h2g/local and
through to returning VMADDR_CID_ANY if neither of those transports are
loaded.

I also considered whether or not /dev/vsock should even be visible from
within an inaccessible namespace in order to not leak even the mere
presence of the vsock device, but it seems to me that /dev/vsock's
presence doesn't leak anything besides the presence of the vsock module.

Best,
Bobby
