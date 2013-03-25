From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [RFC qemu PATCH] only writing out the last byte of
	MAC makes it have effect
Date: Mon, 25 Mar 2013 08:58:49 +0200
Message-ID: <20130325065848.GB32581@redhat.com>
References: <1363834956-9409-1-git-send-email-akong@redhat.com>
	<1363848290-30344-1-git-send-email-akong@redhat.com>
	<20130321105152.GB30874@redhat.com>
	<87hak4ffxu.fsf@rustcorp.com.au>
	<20130325022357.GA2899@t430s.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130325022357.GA2899@t430s.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 25, 2013 at 10:23:57AM +0800, Amos Kong wrote:
> On Fri, Mar 22, 2013 at 10:45:09AM +1030, Rusty Russell wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > On Thu, Mar 21, 2013 at 02:44:50PM +0800, Amos Kong wrote:
> > >> The lengcy guests don't have mac programming command, we don't know when
> > >> it's safe to use MAC. This patch changed qemu to makes MAC change effect
> > >> when the last byte of MAC is written to config space.
> > >> 
> > >> MAC address takes first 6 bytes of config space of virtio-net, the addr
> > >> is 5 when the last byte is written in virtio_config_writeb().
> > >> 
> > >> MAC change will effect when n->mac is updated in virtio_net_set_config().
> > >> 
> > >> Signed-off-by: Amos Kong <akong@redhat.com>
> > >
> > > Let's see what Rusty says about the spec change.
> > 
> > Implementation notes like this belong as a footnote, eg:
> > 
> >         For older systems, it is recommended and typical that the device
> >         write byte 5 of the mac address last, so devices can use that as
> >         a trigger to commit the mac address change.
> > 
> > Now, is this a real, or theoretical issue?  Have we seen this problem in
> > practice, or should we continue to ignore it?
> 
> Hi Rusty, Michael
> 
> I didn't touch any problem. MST, and you?
> 
> In Linux guest, we should disable the interface before changing mac address.
>  ifconfig eth0 down
>  ifconfig eth0 hw ether 10:12:13:14:15:16
>  ifconfig eth0 up
>  
> In Windows 7 guest, after changing mac address in register table,
> re-enabling interface to make it effect.
>  reg add HKLM SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0001] /v NetworkAddress /d 0123456789AB
>  netsh interface set interface "Local Area Connection" DISABLED
>  netsh interface set interface "Local Area Connection" ENABLED
> 
> 
> So when we change the mac address, guest os always disable interface
> to receive all packages. It seems the theoretical issue doesn't exist?
> 
> > Cheers,
> > Rusty.
> > 
> 
> -- 
> 			Amos.

Nope. Looks like no spec change is necessary. We already say it's
not atomic and it looks like guests expect exactly that
and disable link to prevent strange issues.

-- 
MST
