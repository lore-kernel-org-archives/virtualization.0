From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
Date: Thu, 23 May 2019 15:41:18 +0100
Message-ID: <CAJSP0QWSZXT3OJAc=abagD40xZ7DWWrcP_+AwVBuqQyQNgaOEg@mail.gmail.com>
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<20190523115950.GH26632@stefanha-x1.localdomain>
	<41d64b8971a097d1568f947517b45d09c156ccc8.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <41d64b8971a097d1568f947517b45d09c156ccc8.camel@sipsolutions.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ido@wizery.com, linux-um@lists.infradead.org, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 23, 2019 at 3:25 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> Not sure I understand why there's all this stuff about multiple FDs,
> once you have access to the guest's memory, why do you still need a
> second (or more) FDs?

The memory regions could be different files (maybe additional RAM was
hotplugged later).

> Also, not sure I understand how the client is started?

The vhost-user device backend can be launched before QEMU.  QEMU is
started with the UNIX domain socket path so it can connect.

QEMU itself doesn't fork+exec the vhost-user device backend.  It's
expected that the user or the management stack has already launched
the vhost-user device backend.

> Once we have a connection, I guess as a client I'd at the very least
> have to handle
>  * VHOST_USER_GET_FEATURES and reply with the features, obviously, which
>    is in this case just VHOST_USER_F_PROTOCOL_FEATURES?
>
>  * VHOST_USER_SET_FEATURES - not sure, what would that do? the master
>    sends VHOST_USER_GET_PROTOCOL_FEATURES which is with this feature
>    bit? Especially since it says: "Slave that reported
>    VHOST_USER_F_PROTOCOL_FEATURES must support this message even before
>    VHOST_USER_SET_FEATURES was called."
>
>  * VHOST_USER_GET_PROTOCOL_FEATURES - looking at the list, most I don't
>    really need here, but OK
>
>  * VHOST_USER_SET_OWNER - ??
>
>  * VHOST_USER_RESET_OWNER - ignore
>
>  * VHOST_USER_SET_MEM_TABLE - store the data/FDs for later use, I guess
>
>  * VHOST_USER_SET_VRING_NUM - store the data for later use
>  * VHOST_USER_SET_VRING_ADDR - dito
>  * VHOST_USER_SET_VRING_BASE - dito
>  * VHOST_USER_SET_VRING_KICK - start epoll on the FD (assuming there is
>                                one, give up if not?) - well, if ring is
>                                enabled?
>  * VHOST_USER_SET_VRING_CALL - ...
>
> I guess there might be better documentation on the ioctl interfaces?
>
>
> Do you know if there's a sample client/server somewhere?

See contrib/libvhost-user in the QEMU source tree as well as the
vhost-user-blk and vhost-user-scsi examples in the contrib/ directory.

Stefan
