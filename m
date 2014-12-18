From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 17/20] virtio-net: enable virtio 1.0
Date: Thu, 18 Dec 2014 17:57:56 +0100
Message-ID: <20141218175756.4b5387cc.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-18-git-send-email-cornelia.huck@de.ibm.com>
	<20141216131004.GA4504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141216131004.GA4504@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 16 Dec 2014 15:10:04 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Dec 11, 2014 at 02:25:19PM +0100, Cornelia Huck wrote:
> > virtio-net (non-vhost) now should have everything in place to support
> > virtio 1.0: let's enable the feature bit for it.
> > 
> > Note that VIRTIO_F_VERSION_1 is technically a transport feature; once
> > every device is ready for virtio 1.0, we can move setting this
> > feature bit out of the individual devices.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> So to use this with e.g. tun, you need to make tun device LE.
> I posted a kernel patch 1418732988-3535-1-git-send-email-mst@redhat.com
> with TUNSETVNETLE/TUNGETVNETLE ioctls to support it.
> 
> But you still need to call them in qemu, and disable virtio-1.0
> if not there.

I had planned on playing with this a bit, but didn't come around to
doing it. I'm afraid it will have to wait until next year.
