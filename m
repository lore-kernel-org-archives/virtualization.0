From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/1] Add virtio-input driver.
Date: Thu, 19 Mar 2015 17:33:11 +0100
Message-ID: <20150319164311-mutt-send-email-mst@redhat.com>
References: <1426756391-26585-1-git-send-email-kraxel@redhat.com>
	<20150319141302-mutt-send-email-mst@redhat.com>
	<1426776404.10990.10.camel@nilsson.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1426776404.10990.10.camel@nilsson.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2015 at 03:46:44PM +0100, Gerd Hoffmann wrote:
> On Do, 2015-03-19 at 14:35 +0100, Michael S. Tsirkin wrote:
> > On Thu, Mar 19, 2015 at 10:13:10AM +0100, Gerd Hoffmann wrote:
> > >   Hi,
> > > 
> > > This patch adds a virtio driver for input devices.
> > > 
> > > Specification:
> > >   https://www.kraxel.org/cgit/virtio-spec/log/?h=virtio-input
> > >   https://www.kraxel.org/virtio/virtio-v1.0-csprd03-virtio-input.html#x1-2640007
> > 
> > 
> > OK, I don't know which thread should I use for spec discussions.
> > Referring to that:
> > 
> > 	"See file:///usr/include/linux/input.h."
> > 
> > Is likely not present on many systems, or might not include
> > the info you refer to.
> 
> Dunno what the best way to deal with it is.  Link to the version online
> @ kernel.org instead maybe?
> 
> >  "type, code and value are filled according to the linux input layer
> >  (evdev) interface"
> > 
> > Which version?
> 
> Latest.  As far I know there never ever have been incompatible changes
> to the interface, and given this is userspace/kernel abi I don't expect
> that to happen in the future.

More events are added though, are they not? And distros backport rundom
subsets.
So I worry: what happens e.g. if you migrate between hosts which expose
slightly different subsets of events?
Might e.g. a button get stuck because button-press event was
sent but button-release wasn't?


> >   How will non-linux guests know what to implement?
> 
> There are some docs on the linux input layer and evdev events in
> Documentation/input/ in the kernel tree.
> 
> cheers,
>   Gerd



-- 
MST
