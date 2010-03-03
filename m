From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC][ PATCH 0/3] vhost-net: Add mergeable RX buffer support
	to vhost-net
Date: Wed, 3 Mar 2010 09:54:32 +0200
Message-ID: <20100303075432.GA14034@redhat.com>
References: <OF8B8E9FD7.1F227ED3-ON882576DA.008312B5-882576DB.0001D5AB@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OF8B8E9FD7.1F227ED3-ON882576DA.008312B5-882576DB.0001D5AB@us.ibm.com>
Sender: netdev-owner@vger.kernel.org
To: David Stevens <dlstevens@us.ibm.com>
Cc: rusty@rustcorp.com.au, netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 02, 2010 at 04:20:03PM -0800, David Stevens wrote:
> These patches add support for mergeable receive buffers to
> vhost-net, allowing it to use multiple virtio buffer heads for a single
> receive packet.
>                                         +-DLS
> 
> 
> Signed-off-by: David L Stevens <dlstevens@us.ibm.com>

Do you have performance numbers (both with and without mergeable buffers
in guest)?

-- 
MST
