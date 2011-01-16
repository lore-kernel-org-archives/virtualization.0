From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Flow Control and Port Mirroring Revisited
Date: Mon, 17 Jan 2011 10:26:25 +1030
Message-ID: <201101171026.26213.rusty@rustcorp.com.au>
References: <20110106124439.GA17004@verge.net.au> <20110114065415.GA30300@redhat.com> <20110116223728.GA6279@verge.net.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20110116223728.GA6279@verge.net.au>
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jesse Gross <jesse@nicira.com>, Eric Dumazet <eric.dumazet@gmail.com>, virtualization@lists.linux-foundation.org, dev@openvswitch.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 17 Jan 2011 09:07:30 am Simon Horman wrote:

[snip]

I've been away, but what concerns me is that socket buffer limits are
bypassed in various configurations, due to skb cloning.  We should probably
drop such limits altogether, or fix them to be consistent.

Simple fix is as someone suggested here, to attach the clone.  That might
seriously reduce your sk limit, though.  I haven't thought about it hard,
but might it make sense to move ownership into skb_shared_info; ie. the
data, rather than the skb head?

Cheers,
Rusty.
