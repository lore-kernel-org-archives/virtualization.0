Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125185;
	b=uGbLCNDpZF4ZVlYMeTDp8CwqwmfLW2oQMXx/xNRds6vw7NIb6U6uY1/Pf3/kU72jJ7d0
	 78VByzPGj8n5/e8NfHXuceXy5xUQFcZ6ScgjWMsGyJjP3r/Whknxa8aiwHHiN7nJYmX6v
	 nvzI2T6v/Gz6WgM4tn4qmokD2oGgCW+Gn5Hgtg69MNFvXyLFG0Y7C7AkdZyYfCqGshJR5
	 eIbLthcyFXIkpVt0NvVCzUepaY2ay0NyXpk4I6t6liTyTsMy4nroRM7UDZHz5TQeOCvWl
	 KGIy7glBnPnHF9zJXrGZFa5Biti7EO8xCm/t/Fn2sJ2Z9/dJ/x8ETwuX0fDBckMuyBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125185;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VIREaCQxVgG4GuY2CXZNqhO/7+HPS6cWwo1MkeUdS9w=;
	b=gbW6O2X0XLZDxCSqqplCpfdBFm8kddvH4txrnthkbzInFS1vs+hHvb9D9GkfyXE+tJcb
	 FnP/FzIauDUGpoVObM4YG5e86VoyEYbfCMsttI8cyUYrh++G1cPZYrG+vlP0lIP/YJX0a
	 au8uxhLAE7nCtoMGscKJtAltDroHbFxie9X7PFuGvQGzoVFSw9vq900YhkFDj9e3ePSlv
	 3zGqfiDhaykMI6yhHP1yU+ci3EG7Fij13GgvC9FswGJfUOczbBmdy5pINhNNrHpAEJL/L
	 O/0wv53wbivluYG7SdqQM3tbbPBy6s3McOPTOU5vcWNdIcZTfjgerX7nvcu0MNUGSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRNSujFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27966606A332;
	Thu, 19 Nov 2026 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRNSujFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E56A1F000C4;
	Thu, 19 Nov 2026 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795125185;
	bh=VIREaCQxVgG4GuY2CXZNqhO/7+HPS6cWwo1MkeUdS9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IRNSujFB/mk85hBO7/lbFdgtYK/se4Ugsoz1/kDhG6kSFHuZ7TC6chdH4bPmpWY0G
	 fsIjNqLXhKp/8eZu+P1akmDb+zC1rsAleXa6KB0r/pUDRMJmAYTWQW2SfuwUVKknch
	 S/tctxGRTgHWrRIMqFIDJAgjS5kr0QCFUZSmRZWf5LDA+n/sAO0XNB4d6wHrWsdPL3
	 umGVc7kvvn8fTVU8sRfyoXct/ghxMpz45hf7ZtPafYqqpZGt9sfWYtj10SauACOc2o
	 F/SUQQO21US8Jfzv6E650kk0KVRKxQgx/rPzHg3W2ZQdxyEQqkMhqRD8V/VgkKdLc+
	 8P9xmGwe8dlxA==
Date: Thu, 19 Nov 2026 13:53:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, "Eric
 Dumazet" <edumazet@kernel.org>, George Zhang <georgezhang@vmware.com>,
 "Andy King" <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <sargun@sargun.me>, <jlinbox@meta.com>
Subject: Re: [PATCH net-next v7 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <20261119135303.54642e8e@kernel.org>
In-Reply-To: <av807G4qhzToOIMT@devvm29614.prn0.facebook.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
	<20261118182846.4ab756d1@kernel.org>
	<av807G4qhzToOIMT@devvm29614.prn0.facebook.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 09:42:04 -0800 Bobby Eshleman wrote:
> On Wed, Nov 18, 2026 at 06:28:46PM -0800, Jakub Kicinski wrote:
> > On Tue, 17 Nov 2026 17:54:43 -0800 Bobby Eshleman wrote:  
> > > vsock network namespaces let a host put each VM in a namespace of its
> > > own. A guest has no equivalent yet. It has a single G2H device that
> > > cannot be assigned to a network namespace.  
> > 
> > PW says this did not apply at the time of posting, pls respin  
> 
> Ah I forgot to call out in the cover that this now depends on this fix in
> net:
> 
> https://lore.kernel.org/all/20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com/

If there's a dependency the posting has to be an RFC

> In that thread Paolo is also wondering if it is really an improvement
> rather than a fix, which is a fair take, so unless there are objections
> I'll just pull that patch into this series.

No need to repost that patch, we can apply it to net-next as is.
The blocker is lack of an ACK from the vsock maintainers from my PoV.
Please just wait for the net[-next] patch to settle, don't repost this.
Enough noise on the list.
