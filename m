From: Amit Shah <amit@infradead.org>
Subject: Re: [PATCH] virtio_console: remove vq buf while unpluging port
Date: Tue, 28 May 2019 14:59:46 +0200
Message-ID: <f8fccc5745755e92077306189577da2fe591f586.camel__25142.2641494841$1559048483$gmane$org@infradead.org>
References: <1556416204-30311-1-git-send-email-pizhenwei@bytedance.com>
	<20190524185132.GA10695@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190524185132.GA10695@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>, amit@kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2019-05-24 at 20:51 +0200, Greg KH wrote:
> On Sun, Apr 28, 2019 at 09:50:04AM +0800, zhenwei pi wrote:
> > A bug can be easily reproduced:
> > Host# cat guest-agent.xml
> > <channel type="unix">
> >   <source mode="bind" path="/var/lib/libvirt/qemu/stretch.agent"/>
> >   <target type="virtio" name="org.qemu.guest_agent.0"
> > state="connected"/>
> > </channel>
> > Host# virsh attach-device instance guest-agent.xml
> > Host# virsh detach-device instance guest-agent.xml
> > Host# virsh attach-device instance guest-agent.xml
> > 
> > and guest report: virtio-ports vport0p1: Error allocating inbufs
> > 
> > The reason is that the port is unplugged and the vq buf still
> > remained.
> > So, fix two cases in this patch:
> > 1, fix memory leak with attach-device/detach-device.
> > 2, fix logic bug with attach-device/detach-device/attach-device.

The "leak" happens because the host-side of the connection is still
connected.  This is by design -- if a guest has written data before
being unplugged, the port isn't released till the host connection goes
down to ensure a host process reads all the data out of the port.

Can you try similar, but also disconnecting the host side and see if
that fixes things?

> Amit, any ideas if this is valid or not and if this should be
> applied?

This had indeed been missed, thanks!


			Amit
