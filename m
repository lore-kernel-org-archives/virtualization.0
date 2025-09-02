Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A42874F2
	for <virtualization@lists.linux.dev>; Tue,  2 Sep 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833011; cv=none; b=VZuq508sy2SE7XSXRfspeF3wF3jslnzoIcnnuj4qMhFEd/RmnTTdykLmMjQiYta+GQUFItBCBY6tkzA9NPjEXuk0Kt+ImAnl5CvMb7vxrKMlWAmASyfxbrk2MC607juDapGgMO6r4t8ZNyGVHvNoY1Ar8TBReJKp6w3xbRRRbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833011; c=relaxed/simple;
	bh=EF6aZqNIoSXa0kptmEVVRLVollrxdh2NWJJq1QCOmQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwIGksdHEI/kdu71i2fmMNf4tqyOZeaif4tQduNEME7IQo7BqyLC07Dv+DA2H1TWBtKrpklTfJu7IQeneSdiWqPxHm4S7lw6Cx1NbU/j8fXlKyUdaQ+nff/+r2Gyw8Q9C6esSoxE4/drc41S7+p2NPnXDmEywv0Gh9MaTRg4yJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b32W11Eh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b32W11Eh"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7724cacc32bso2133037b3a.0
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833009; x=1757437809; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihQjC9yJ1X4I7i2TJOoe7K1INvxzQRyYcVly+4F6YMQ=;
        b=b32W11EhrPrkdxi/EUCTa5jmLvIttqHwaxELxPIDMfAKR2Nc7c8NUa+MSxlG22d5Mt
         CAwzre0lFZKWC0nn3I3r+YJhNknnUzqYqVrxA8vtLCSvFN9rCfYxtN8dqSQZUVldIF/t
         HIzy3bj2lyuj220dliNDsQfCBlqgPTzo8RZrsvV90MQWXrcn7k8t8CVeu3DirguBXVoB
         zAOfjAn/aOk3KDeyGRSrzq14Un8rBOX0g1hC+pi4vkyascnN3qCRVmuAq3tQs1nYj38w
         sNkRcUHL7Bcaumy85bYhcHIuuf5JudFZeX5cwlr8ggFwWKPGF5U7R7wkbnZdftjr3FSL
         RA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833009; x=1757437809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihQjC9yJ1X4I7i2TJOoe7K1INvxzQRyYcVly+4F6YMQ=;
        b=S5Bz6/FWUyqPukkHEl4HeF1YOIWGiyEJq9CnsXEUFIYP2iweJHweMilAvE5esru6A0
         wr0mKlkNSb/MQbYWuRvJ1jXBMSlTykQPlLuH0wOjURUiHFZvjj6u3CtkQ9Ln5Xo00rFA
         aGYbu4XBn4BeFRk4kgKTSB18r+SiV3Nt1WMnCd9XnQe0hTxPAUVaTEUsnQOFCQ+ZSrdN
         Odp0HmD66ekG/7ISO0zxh99mnM7G/vnwTEQiTKjxZEmSyzu9pf2SJ3+eH0bwfCzQvb5v
         0Pb1Zal2Y2XXRIXrQebQfZgRI0qHMKbOvLmhZYguHAt/2WKvBJ7cViLphPPI6MO1MtKe
         wpIg==
X-Forwarded-Encrypted: i=1; AJvYcCXr2MpdjNrIRN+n9MuH7wzZQgpOQbW9MSGjB6oIKpFmPjXikDbOqDY2ddRtncnYnbla8t5vOYRv/JXDYTEEgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEpQR9PMx/4B3GrxMBxoQifNYQQ/+df7ItbTxyXaq4dzKfi5a+
	VA2KgzLgdRLNfmf6dGO5wAMny4RgkNQBEiKt55VvljdbCC84pFxECAvJB5UHPQt23o8=
X-Gm-Gg: ASbGnctVJV2hf+XPfN8d1kSUGeo24jTWTyYfOA+8K68pUJnkeLlMvYlr2GhMVoyqRrD
	GO1IsGIzYlufhNbHBAMkNJn0/2rpXDzjBovJHezUjw67LPWqHbjCSak4FjyYsZv07BwAeboVE+C
	/KD3GT7pjlAi1l4d9IKuh2fTaMicvTQvI0IGuhR5zSYzbHL25VHO6INpW+k1QijzUTTGrIOeEEQ
	dpXWX3lgg1X9NtWTaYipPPzeoh7vxesCIZy/LBl5vR2ytvp+4vaDW/kED0DjeGQTlFVLwQTKEl1
	9gS4DPd0JlHLgHH7IO7aQuaGZm00EJKHlCIGVC2djlP+YaSAR0bmAq9+amYV+g48K4xhP6RF1AV
	ndcsrzzFeNk63Uj/ByWXLnuKcnQeRYS12y2yDkMI/T+E=
X-Google-Smtp-Source: AGHT+IGyUUiPrfchRjHRX3crNHUYbFF9RNjkv+OcfvEakWvZRQN9OH2MzLTdAngcH4AMJjIzQ+3iyg==
X-Received: by 2002:a05:6a20:1093:b0:244:58:c159 with SMTP id adf61e73a8af0-2440058c3d1mr3642462637.22.1756833009146;
        Tue, 02 Sep 2025 10:10:09 -0700 (PDT)
Received: from devvm6216.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726a0e7cb8sm3845860b3a.58.2025.09.02.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:10:08 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:10:00 -0700
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
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/9] vsock: add netns to vsock core
Message-ID: <aLck6IIS3AiDJZPg@devvm6216.cco0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-3-0ba580bede5b@meta.com>
 <gncp3ynz3inufzex64sla2ia3stjsen2n3hwhfuykdhmpuuegu@7hk5q2hjfxkv>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gncp3ynz3inufzex64sla2ia3stjsen2n3hwhfuykdhmpuuegu@7hk5q2hjfxkv>

On Tue, Sep 02, 2025 at 05:39:10PM +0200, Stefano Garzarella wrote:
> On Wed, Aug 27, 2025 at 05:31:31PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>

...

> > {
> > 	enum vsock_net_mode ret;
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 0538948d5fd9..68a8875c8106 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -83,6 +83,24 @@
> >  *   TCP_ESTABLISHED - connected
> >  *   TCP_CLOSING - disconnecting
> >  *   TCP_LISTEN - listening
> > + *
> > + * - Namespaces in vsock support two different modes configured
> > + *   through /proc/sys/net/vsock/ns_mode. The modes are "local" and "global".
> > + *   Each mode defines how the namespace interacts with CIDs.
> > + *   /proc/sys/net/vsock/ns_mode is write-once, so that it may be configured
> > + *   and locked down by a namespace manager. The default is "global". The mode
> > + *   is set per-namespace.
> > + *
> > + *   The modes affect the allocation and accessibility of CIDs as follows:
> > + *   - global - aka fully public
> > + *      - CID allocation draws from the public pool
> > + *      - AF_VSOCK sockets may reach any CID allocated from the public pool
> > + *      - AF_VSOCK sockets may not reach CIDs allocated from private
> > pools
> 
> Should we define what public and private pools are?
> 
> What I found difficult to understand was the allocation of CIDs, meaning I
> had to reread it two or three times to perhaps understand it.
> 
> IIUC, netns with mode=global can only allocate public CIDs, while netns with
> mode=local can only allocate private CIDs, right?
> 

Correct.

> Perhaps we should first better define how CIDs are allocated and then
> explain the interaction between them.
> 

Makes sense, I'll clarify that.

> > + *
> > + *   - local - aka fully private
> > + *     - CID allocation draws only from the private pool, does not affect public pool
> > + *     - AF_VSOCK sockets may only reach CIDs from the private pool
> > + *     - AF_VSOCK sockets may not reach CIDs allocated from outside the pool
> 
> Why using "may" ? I mean, can be cases when this is not true?
> 


Good point, will change to stronger language since it is always true.

[...]

> > 
> > @@ -2636,6 +2670,137 @@ static struct miscdevice vsock_device = {
> > 	.fops		= &vsock_device_ops,
> > };
> > 
> > +#define VSOCK_NET_MODE_STRING_MAX 7
> > +
> > +static int vsock_net_mode_string(const struct ctl_table *table, int write,
> > +				 void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +	char buf[VSOCK_NET_MODE_STRING_MAX] = {0};
> 
> Can we change `buf` name?
> 
> I find it confusing to have both a `buffer` variable and a `buf` variable in
> the same function.
> 

Makes sense, will do.

> > +	enum vsock_net_mode mode;
> > +	struct ctl_table tmp;
> > +	struct net *net;
> > +	const char *p;
> 
> Can we move `p` declaration in the `if (!write) {` block?
> 

yes.

> > +	int ret;
> > +
> > +	if (!table->data || !table->maxlen || !*lenp) {
> > +		*lenp = 0;
> > +		return 0;
> > +	}
> > +
> > +	net = current->nsproxy->net_ns;
> > +	tmp = *table;
> > +	tmp.data = buf;
> > +
> > +	if (!write) {
> > +		mode = vsock_net_mode(net);
> > +
> > +		if (mode == VSOCK_NET_MODE_GLOBAL) {
> > +			p = "global";
> > +		} else if (mode == VSOCK_NET_MODE_LOCAL) {
> > +			p = "local";
> > +		} else {
> > +			WARN_ONCE(true, "netns has invalid vsock mode");
> > +			*lenp = 0;
> > +			return 0;
> > +		}
> > +
> > +		strscpy(buf, p, sizeof(buf));
> > +		tmp.maxlen = strlen(p);
> > +	}
> > +
> > +	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (write) {
> > +		if (!strncmp(buffer, "global", 6))
> 
> Are we sure that the `buffer` is at least 6 bytes long and NULL-terminated?
> 
> Maybe we can just check that `lenp <= sizeof(buf)`...
> 
> Should we add macros for "global" and "local" ?
> 

That all sounds reasonable. IIRC I tested with some garbage writes, but might
as well err on the side of caution.

> 
> > +			mode = VSOCK_NET_MODE_GLOBAL;
> > +		else if (!strncmp(buffer, "local", 5))
> > +			mode = VSOCK_NET_MODE_LOCAL;
> > +		else
> > +			return -EINVAL;
> > +
> > +		if (!vsock_net_write_mode(net, mode))
> > +			return -EPERM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +

...


Thanks for the review!

Best,
Bobby
