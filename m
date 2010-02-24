From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] vhost: fix get_user_pages_fast error handling
Date: Tue, 23 Feb 2010 23:41:33 -0800 (PST)
Message-ID: <20100223.234133.85843944.davem@davemloft.net>
References: <20100224053737.GB27806@redhat.com>
	<20100223.230428.71578656.davem@davemloft.net>
	<20100224073424.GC27806@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100224073424.GC27806@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com
Cc: gleb@redhat.com, rusty@rustcorp.com.au, kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, markmc@redhat.com, herbert.xu@redhat.com, quintela@redhat.com, dlaor@redhat.com, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 24 Feb 2010 09:34:25 +0200

> Implicitly, I guess. He said "if there's an issue Michael Tsirkin is the
> best person to resolve it", this was wrt merging his virtio&lguest tree.
> He didn't mention vhost, I wrote all of vhost though, there shouldn't be
> an issue with that.

That's good enough for me.

Feel free to setup a tree for me to pull from.
