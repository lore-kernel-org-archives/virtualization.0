From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Mon, 15 Dec 2008 15:10:44 -0800 (PST)
Message-ID: <20081215.151044.262451532.davem__38793.2188729339$1229382864$gmane$org@davemloft.net>
References: <4946C1AA.4080404@codemonkey.ws>
	<20081215.142918.190909950.davem@davemloft.net>
	<4946E1BA.80206@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4946E1BA.80206@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: anthony@codemonkey.ws
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Anthony Liguori <anthony@codemonkey.ws>
Date: Mon, 15 Dec 2008 17:01:14 -0600

> No, TCP falls under the not simple category because it requires the
> backend to have access to a TCP/IP stack.

I'm at a loss for words if you need TCP in the hypervisor, if that's
what you're implying here.

You only need it in the guest and the host, which you already have,
in the Linux kernel.  Just transport that over virtio or whatever
and be done with it.
