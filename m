From: Amit Shah <amit@infradead.org>
Subject: Re: [PATCH v3] virtio_console: allocate inbufs in add_port() only
 if it is needed
Date: Wed, 04 Dec 2019 14:58:51 +0100
Message-ID: <108357faa8d7add057a8dc0870b42c482eec34ee.camel__7950.6383671955$1575467951$gmane$org@infradead.org>
References: <20191114122548.24364-1-lvivier@redhat.com>
 <ae3451423c18f2e408245d745d1f28e311a2845c.camel@infradead.org>
 <20191203103840-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191203103840-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2019-12-03 at 10:42 -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 03, 2019 at 03:46:50PM +0100, Amit Shah wrote:
> > On Thu, 2019-11-14 at 13:25 +0100, Laurent Vivier wrote:
> > > When we hot unplug a virtserialport and then try to hot plug
> > > again,
> > > it fails:
> > > 
> > > (qemu) chardev-add
> > > socket,id=serial0,path=/tmp/serial0,server,nowait
> > > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> > >                   chardev=serial0,id=serial0,name=serial0
> > > (qemu) device_del serial0
> > > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> > >                   chardev=serial0,id=serial0,name=serial0
> > > kernel error:
> > >   virtio-ports vport2p2: Error allocating inbufs
> > > qemu error:
> > >   virtio-serial-bus: Guest failure in adding port 2 for device \
> > >                      virtio-serial0.0
> > > 
> > > This happens because buffers for the in_vq are allocated when the
> > > port is
> > > added but are not released when the port is unplugged.
> > > 
> > > They are only released when virtconsole is removed (see
> > > a7a69ec0d8e4)
> > > 
> > > To avoid the problem and to be symmetric, we could allocate all
> > > the
> > > buffers
> > > in init_vqs() as they are released in remove_vqs(), but it sounds
> > > like
> > > a waste of memory.
> > > 
> > > Rather than that, this patch changes add_port() logic to ignore
> > > ENOSPC
> > > error in fill_queue(), which means queue has already been filled.
> > > 
> > > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > > Cc: mst@redhat.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > 
> > Reviewed-by: Amit Shah <amit@kernel.org>
> > 
> > Thanks!
> 
> 
> Thanks, however this has already been merged by Linus.
> I can't add the tag retroactively, sorry about that.

Right, no problem - but I wanted to ensure it's on-list :)

> 
> For bugfix patches like that, I think we can reasonably
> target a turn around of a couple of days, these
> shouldn't really need to wait weeks for review.

Sure, thanks for picking it up fast enough.  Life happens, etc., and
it's not always possible to reply in a couple of days.  Since we had
already covered the main comments in v1 and v2, v3 wasn't going to need
much attention anyway.
