From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-gpu/2d: add
	docs/specs/virtio-gpu.txt
Date: Fri, 12 Sep 2014 13:08:03 +0200
Message-ID: <1410520083.30411.11.camel@nilsson.home.kraxel.org>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
	<1410448173-12960-3-git-send-email-kraxel@redhat.com>
	<5411BFF9.9030102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5411BFF9.9030102@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Blake <eblake@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > +++ b/docs/specs/virtio-gpu.txt
> > @@ -0,0 +1,165 @@
> > +virtio-gpu specification
> 
> I know you are just following existing bad practice in this directory,
> but it would be nice to declare copyright and license on this file.

Added copyright for now.
Dunno about license, IIRC GPLv2 isn't good for text, suggestions?

> > +  This creates a 2D resource on the host with the specified width,
> > +  height and format. Only a small subset of formats are support. The
> 
> s/support/supported/
> and can you delineate that subset?

enum virtgpu_formats (text updated).

> > +  This sets the scanout parameters for a single scanout. The
> > +  resource_id is the resource to be scanned out from, along with a
> > +  rectangle specified by x, y, width and height.
> 
> Is it worth a mention here or generically up front where 0,0 is in
> relation to the screen, and in which direction positive numbers move?
> I'm assuming 0,0 is top left, and larger x moves right, larger y moves down.

Correct.  Text updated.

> Are there restrictions against rectangles that overlap beyond screen
> boundaries?

Backing resource must cover the scanout completely.
With multiple heads (and therefore multiple scanouts) it is legal for
the scanouts to overlap or even be identical (=> screen mirroring).

Text updated.

thanks,
  Gerd
