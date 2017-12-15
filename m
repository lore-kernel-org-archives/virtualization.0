From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/3] virtio_pci: use put_device instead of kfree
Date: Fri, 15 Dec 2017 13:21:27 +0100
Message-ID: <20171215132127.71c33352.cohuck@redhat.com>
References: <cover.1513083885.git.zhangweiping@didichuxing.com>
	<e397f504c0a796481d8aaf0e558cc8425286012c.1513083885.git.zhangweiping@didichuxing.com>
	<20171214205538-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171214205538-mutt-send-email-mst@kernel.org>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, weiping zhang <zhangweiping@didichuxing.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 14 Dec 2017 21:13:28 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Dec 12, 2017 at 09:24:02PM +0800, weiping zhang wrote:
> > As mentioned at drivers/base/core.c:
> > /*
> >  * NOTE: _Never_ directly free @dev after calling this function, even
> >  * if it returned an error! Always use put_device() to give up the
> >  * reference initialized in this function instead.
> >  */
> > so we don't free vp_dev until vp_dev->vdev.dev.release be called.  
> 
> seeing as 5739411acbaa63a6c22c91e340fdcdbcc7d82a51 adding these
> annotations went to stable, should this go there too?
> 
> > Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>  
> 
> OK but this relies on users knowing that register_virtio_device
> calls device_register. I think we want to add a comment
> to register_virtio_device.
> 
> Also the cleanup is uglified.
> 
> I really think the right thing would be to change device_register making
> it safe to kfree. People have the right to expect register on failure to
> have no effect.
> 
> That just might be too hard to implement though.

Yes. The main problem is that device_register() at some point makes the
structure visible to others, at which point they may obtain a
reference. If that happened, you cannot clean up unless that other
party gave up their reference -- which means your only chance to get
this right is the current put_device() approach.

It *is* problematic if all of that stuff is hidden behind too many
calling layers. If you have the device_initialize() -> device_add()
calling sequence, having to do a put_device() on failure is much more
obvious. But as you usually don't pass in a pure struct device but
something embedding it, the put_device() needs to be done on the
outermost level.

Commenting can help here, as would probably a static checker for that
code pattern.
