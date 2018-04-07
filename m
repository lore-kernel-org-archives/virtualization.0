From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Fri, 6 Apr 2018 19:32:05 -0700
Message-ID: <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
References: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<CADGSJ23Zr7_CLMr1W9qhcWux59+aCvFdTg_nQ7Mmp5B-FWL8=Q@mail.gmail.com>
	<54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
	<20180404.133749.1802514210170809419.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180404.133749.1802514210170809419.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, si-wei liu <si-wei.liu@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 4, 2018 at 10:37 AM, David Miller <davem@davemloft.net> wrote:
> From: David Ahern <dsahern@gmail.com>
> Date: Wed, 4 Apr 2018 11:21:54 -0600
>
>> It is a netdev so there is no reason to have a separate ip command to
>> inspect it. 'ip link' is the right place.
>
> I agree on this.

I'm completely fine of having an API for inspection purpose. The thing
is that we'd perhaps need to go for the namespace approach, for which
I think everyone seems to agree not to fiddle with the ":" prefix, but
rather have a new class of network subsystem under /sys/class thus a
separate device namespace e.g. /sys/class/net-kernel for those
auto-managed lower netdevs is needed.

And I assume everyone here understands the use case for live migration
(in the context of providing cloud service) is very different, and we
have to hide the netdevs. If not, I'm more than happy to clarify.

With that in mind, if having a new class of net-kernel namespace, we
can name the kernel device elaborately which is not neccessarily equal
to the device name exposed to userspace. For example, we can use
driver name as the prefix as opposed to "eth" or ":eth". And we don't
need to have auto-managed netdevs locked into the ":" prefix at all (I
intentionally left it out in the this RFC patch to ask for comments on
the namespace solution which is much cleaner). That said, an userpsace
named device through udev may call something like ens3 and
switch1-port2, but in the kernel-net namespace, it may look like
ixgbevf0 and mlxsw1p2.

So if we all agree introducing a new namespace is the rigth thing to
do, `ip link' will no longer serve the purpose of displaying the
information for kernel-net devnames for the sake of avoiding ambiguity
and namespace collision: it's entirely possible the ip link name could
collide with a kernel-net devname, it's become unclear which name of a
netdev object the command is expected to operate on. That's why I
thought showing the kernel-only netdevs using a separate subcommand
makes more sense.

Thoughts and comments? Please let me know.

Thanks,
-Siwei

>
> What I really don't understand still is the use case... really.
>
> So there are control netdevs, what exactly is the problem with that?
>
> Are we not exporting enough information for applications to handle
> these devices sanely?  If so, then's let add that information.
>
> We can set netdev->type to ETH_P_LINUXCONTROL or something like that.
>
> Another alternative is to add an interface flag like IFF_CONTROL or
> similar, and that probably is much nicer.
>
> Hiding the devices means that we acknowledge that applications are
> currently broken with control netdevs... and we want them to stay
> broken!
>
> That doesn't sound like a good plan to me.
>
> So let's fix handling of control netdevs instead of hiding them.
>
> Thanks.
