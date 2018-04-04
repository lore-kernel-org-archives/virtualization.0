From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Wed, 04 Apr 2018 13:37:49 -0400 (EDT)
Message-ID: <20180404.133749.1802514210170809419.davem__13875.5531902008$1522863354$gmane$org@davemloft.net>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
	<54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dsahern@gmail.com
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, si-wei.liu@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: David Ahern <dsahern@gmail.com>
Date: Wed, 4 Apr 2018 11:21:54 -0600

> It is a netdev so there is no reason to have a separate ip command to
> inspect it. 'ip link' is the right place.

I agree on this.

What I really don't understand still is the use case... really.

So there are control netdevs, what exactly is the problem with that?

Are we not exporting enough information for applications to handle
these devices sanely?  If so, then's let add that information.

We can set netdev->type to ETH_P_LINUXCONTROL or something like that.

Another alternative is to add an interface flag like IFF_CONTROL or
similar, and that probably is much nicer.

Hiding the devices means that we acknowledge that applications are
currently broken with control netdevs... and we want them to stay
broken!

That doesn't sound like a good plan to me.

So let's fix handling of control netdevs instead of hiding them.

Thanks.
