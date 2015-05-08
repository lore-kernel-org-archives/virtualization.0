From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch v2] virtio_console: silence a static checker warning
Date: Fri, 8 May 2015 12:47:35 +0300
Message-ID: <20150508094735.GD16501__12374.8963968412$1431078494$gmane$org@mwanda>
References: <20150508091624.GS14154@mwanda>
 <554C8221.9070304@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <554C8221.9070304@bfs.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: walter harms <wharms@bfs.de>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 08, 2015 at 11:30:09AM +0200, walter harms wrote:
> 
> 
> Am 08.05.2015 11:16, schrieb Dan Carpenter:
> > My static checker complains that this sprintf() can overflow but really
> > it can't.  Just silence the warning by using snprintf().
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: the overflow is not possible so just leave the buffer size alone and
> >     silence the warning with snprintf().
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 50754d20..8283989 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1492,8 +1492,8 @@ static int add_port(struct ports_device *portdev, u32 id)
> >  		 * Finally, create the debugfs file that we can use to
> >  		 * inspect a port's state at any time
> >  		 */
> > -		sprintf(debugfs_name, "vport%up%u",
> > -			port->portdev->vdev->index, id);
> > +		snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
> > +			 port->portdev->vdev->index, id);
> 
> 
> would it help to use %03u (or so) to make it more obvious ?
> 
> Note: i prefer a leading 0 in my programms to make it more easy
> to work with grep and friends. you may thing otherwise.

That's an user API change so it's probably a bad idea.

regards,
dan carpenter
