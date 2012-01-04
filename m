From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] virtio_blk: lock() => unlock() typo in
	virtblk_config_changed_work()
Date: Wed, 04 Jan 2012 13:02:55 +1030
Message-ID: <87wr98ci3s.fsf@rustcorp.com.au>
References: <20120103144513.GB21712@elgon.mountain>
	<20120103153127.GA8440@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120103153127.GA8440@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 3 Jan 2012 17:31:28 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jan 03, 2012 at 05:45:13PM +0300, Dan Carpenter wrote:
> > This will deadlock.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index f3d77b3..ba73661 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -352,7 +352,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
> >  
> >  	set_capacity(vblk->disk, capacity);
> >  done:
> > -	mutex_lock(&vblk->config_lock);
> > +	mutex_unlock(&vblk->config_lock);
> >  }
> >  
> >  static void virtblk_config_changed(struct virtio_device *vdev)
> 
> Good catch.
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Indeed, I folded it into that patch.

Thanks!
Rusty.
