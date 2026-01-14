Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4022346798
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418465; cv=none; b=dtN9os19teGNQeHXEWzV+AHuU1qEazyhj/rJhUJf0NjfJ3NlHRkox4G0mJjlgLrELmEwibJWUJygCYCCADgBOdSOjkpxmkRD2KyKVpCYiJ8lxub8I7lXOA5GNqYqsmmt86SNwtp5GnwEAjKdwdDGZ1xA+Zqqr1A6nTbs/tYHw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418465; c=relaxed/simple;
	bh=QKRezXrA3bG4ArDBbT58+S8c1CtyAn6iBKaQozySKZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEtxtrFONaCG/kEvOBkiBx+Y7FbUvNkKhscjbf+yKCQtPecuv/jO9n7Le+NXHJ3KhTKNDVfcQtFMRUpLleeg4duxxvZr+YZAHtBlA9h1VrU5e0ABJrfMn5oH1q7caN/2Tcl/z7uRh/ap5Cw+CFdD4t3ricrE2ysU6pxTabDwbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGUd6BsN; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGUd6BsN"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ef2561e395so93352137.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768418463; x=1769023263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=fGUd6BsNtkR3D8c1iZV+8fbIrpG+Hi0H4Qx2kUozJhBjgCjPO08Gm+uv8rf66gDzCK
         a5cNXTMrEZxNnzr7VVnykiGilMIXHfyUu1lSLQ4NAJMGfg1JP46Obm9RPhkh/vhpt4iN
         rnn63Yb8CyA8DuXkGgK2aalXlkWMRxXWjuFaP1mgAiag3EILnbwgKBU/wsYmGZ9bY3jY
         bKfG1DBdgwO/lR5BTz5+1OXm1cTvUD7sfsdj1P9Q3EeZoMYpdi3PrpcTlwQD2GyMLNf1
         zoOmuT5aPwYSEyNSREJzDk7jURlPDv8L70abKMeJE4ZyJMOCskilSo4pyfFrFDFPz94j
         hhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768418463; x=1769023263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUpDNPxjIqi9ICJXtc+mfMuxEexyo061EqFw5Nyb8q0=;
        b=jcqqOV1C19vs3AlZqiahlGlyuBfCDb7F5nayHd0BGjQzFGjLlf+kzTCS55B+DynmY5
         fpyZ9t8QL/bDbeSkVptO72a6bTGbaIT9foFJTqmjGFIY53VRmnrVxGo/BW4HBH27OgVc
         XQH0KWZ8lKul05on6CHSfxPF5Dt3WUEOlrnMeMHCT2fMkvbrIRLDNZyigPDHJ1ZRR7jv
         jHc7LJqZf1hGOanxQxqwxFH/DJL58JidhvE4KqyZsi0PHimaue45AGfum3rancj5ZWof
         o7tv85wUsc6EAQED4FvOx/646hSYF3eO6zGnq53u7LhNZ2uKjxXr8xglXa8+XkLj0oN+
         H+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUDtblloODi1SVe0wTbm8cbzg3jj0KV2y7f8jp5+OVfv34aiZCc/Y99tXSq8bPSoqEBhGPSCyYBLFqUwhBNaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKFXyC/aj5gvldKZuZZVKUt1z/juUWHx4uZE8eSEN38gQ+9SOG
	ThEu7Mt+HK7HZSeAQlGHt3VhCN4j0rcROvdsFVSFjDY2kyWi77XOKat68EmI+Q==
X-Gm-Gg: AY/fxX49NlZvfdfdLY9EP9m7VsGgxce7QKNNQnL1aHTcVoILNhTT83GTolwcaTVLZ0j
	kk8vfyKgGMfiIMbvpyTfCd9potBzWUka2USHdiUkFAdFwjkVUN6SBJBVh2H68DrRHFtLYDJpagP
	epS1FbpKoo7iX9ZbxeNvcNq1yU4NNPcqwyx72+/DaHiDk4z18DKl9lKcPEZ3P1G8FqvSGmPudMf
	hTNfYteSnEmSlth0R03+Ax9ZQ0R1OlQDhhYNEBPcphf2gXapIA7Fbw+VkWOJbV9D4E7qyilrp4u
	T0b5F8bdD4oRd1L1Oi+sEwXLcPvPKK3oULrjLxd4u7+5VvKwsfv5brM113IOLE02oy6QNTYbwQW
	03wd4c1WlI9IwyG72PY6+eaSKpO5oIQXAxRrhNzif4CsIckFmHNucITd2mAOE3yVLZm7K/8xhgy
	9+ZGRQTsYlbcqWfkxEzZF9r5bJGPWchbxHPw==
X-Received: by 2002:a05:690e:1c06:b0:646:eb06:f2e2 with SMTP id 956f58d0204a3-64903b513d2mr1973243d50.73.1768411311135;
        Wed, 14 Jan 2026 09:21:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6e12ffsm92418037b3.53.2026.01.14.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:21:50 -0800 (PST)
Date: Wed, 14 Jan 2026 09:21:49 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Long Li <longli@microsoft.com>, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWfQrS1oNcXwcXu3@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <202601140749.5TXm5gpl-lkp@intel.com>
 <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F45q7CWy3O_QhYj0Y2Bt84vA=eaTeBTu+TvEmFm0_E7Jw@mail.gmail.com>

On Wed, Jan 14, 2026 at 04:54:15PM +0100, Stefano Garzarella wrote:
> On Wed, 14 Jan 2026 at 00:13, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Bobby,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
> > patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
> > config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)
> 
> Bobby can you check this report?
> 
> Could be related to `__net_initdata` annotation of `vsock_sysctl_ops` ?
> Why we need that?
> 
> Thanks,
> Stefano
> 

Yep, no problem.

Best,
Bobby
