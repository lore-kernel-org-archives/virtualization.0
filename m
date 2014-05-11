From: Wilfried Klaebe <w-lkml@lebenslange-mailadresse.de>
Subject: Re: [PATCH] [resend] net: get rid of SET_ETHTOOL_OPS
Date: Sun, 11 May 2014 12:46:34 +0000
Message-ID: <20140511124633.GD7875__42624.6001072743$1399812610$gmane$org@kaos.lebenslange-mailadresse.de>
References: <20140511001231.GC7875@kaos.lebenslange-mailadresse.de>
	<CANKiNjV7qrx-556DJk0qcOopnBs4NnKy51POEeZ7LpbdjX35OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CANKiNjV7qrx-556DJk0qcOopnBs4NnKy51POEeZ7LpbdjX35OQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anish Khurana <anish.khurana130181@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, dev@openvswitch.org, xen-devel@lists.xenproject.org, linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acenic@sunsite.dk, trivial@kernel.org, e1000-devel@lists.sourceforge.net, bridge@lists.linux-foundation.org, devel@linuxdriverproject.org, nios2-dev@lists.rocketboards.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Am Sun, May 11, 2014 at 01:13:47PM +0530 schrieb Anish Khurana:
> SET_ETHTOOL_OPS is equivalent to :
> #define SET_ETHTOOL_OPS(netdev,ops) \
>     ( (netdev)->ethtool_ops = (ops) )
> 
> how it makes difference  removing this code and replacing with the
> code mentioned ?

It doesn't change anything in the resulting binaries. The whole point
is to remove the macro, which is something Dave wants to happen.

Kind regards,
Wilfried
