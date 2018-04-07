From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Sat, 7 Apr 2018 05:19:19 +0200
Message-ID: <20180407031919.GB11029@lunn.ch>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
	<54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
	<20180404.133749.1802514210170809419.davem@davemloft.net>
	<CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Hi Siwei

> I think everyone seems to agree not to fiddle with the ":" prefix, but
> rather have a new class of network subsystem under /sys/class thus a
> separate device namespace e.g. /sys/class/net-kernel for those
> auto-managed lower netdevs is needed.
 
How do you get a device into this new class? I don't know the Linux
driver model too well, but to get a device out of one class and into
another, i think you need to device_del(dev). modify dev->class and
then device_add(dev). However, device_add() says you are not allowed
to do this.

And i don't even see how this helps. Are you also not going to call
list_netdevice()? Are you going to add some other list for these
devices in a different class?

   Andrew
