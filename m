From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Tue, 10 Apr 2018 00:15:23 +0200
Message-ID: <20180409221523.GH562__40361.9473138407$1523312050$gmane$org@lunn.ch>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
	<54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
	<20180404.133749.1802514210170809419.davem@davemloft.net>
	<CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
	<20180407031919.GB11029@lunn.ch>
	<CADGSJ211kA5ktADbwv2f4ma_ooBmYW4r7YwzGD2G_Gw5+wv5rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CADGSJ211kA5ktADbwv2f4ma_ooBmYW4r7YwzGD2G_Gw5+wv5rw@mail.gmail.com>
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

> No, implementation wise I'd avoid changing the class on the fly. What
> I'm looking to is a means to add a secondary class or class aliasing
> mechanism for netdevs that allows mapping for a kernel device
> namespace (/class/net-kernel) to userspace (/class/net). Imagine
> creating symlinks between these two namespaces as an analogy. All
> userspace visible netdevs today will have both a kernel name and a
> userspace visible name, having one (/class/net) referecing the other
> (/class/net-kernel) in its own namespace. The newly introduced
> IFF_AUTO_MANAGED device will have a kernel name only
> (/class/net-kernel). As a result, the existing applications using
> /class/net don't break, while we're adding the kernel namespace that
> allows IFF_AUTO_MANAGED devices which will not be exposed to userspace
> at all.

My gut feeling is this whole scheme will not fly. You really should be
talking to GregKH.

Anyway, please remember that IFF_AUTO_MANAGED will need to be dynamic.
A device can start out as a normal device, and will change to being
automatic later, when the user on top of it probes.

	Andrew
