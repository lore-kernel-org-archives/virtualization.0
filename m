From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Mon, 15 Dec 2008 14:29:18 -0800 (PST)
Message-ID: <20081215.142918.190909950.davem__26074.9254761778$1229380270$gmane$org@davemloft.net>
References: <4946717F.2090809@codemonkey.ws>
	<20081215.114315.165733593.davem@davemloft.net>
	<4946C1AA.4080404@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4946C1AA.4080404@codemonkey.ws>
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
Date: Mon, 15 Dec 2008 14:44:26 -0600

> We want this communication mechanism to be simple and reliable as we
> want to implement the backends drivers in the host userspace with
> minimum mess.

One implication of your statement here is that TCP is unreliable.
That's absolutely not true.

> Within the guest, we need the interface to be always available and
> we need an addressing scheme that is hypervisor specific.  Yes, we
> can build this all on top of TCP/IP.  We could even build it on top
> of a serial port.  Both have their down-sides wrt reliability and
> complexity.

I don't know of any zero-copy through the hypervisor mechanisms for
serial ports, but I know we do that with the various virtualization
network devices.

> Do you have another recommendation?

I don't have to make alternative recommendations until you can
show that what we have can't solve the problem acceptably, and
TCP emphatically can.
