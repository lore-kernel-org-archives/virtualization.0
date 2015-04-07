From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/7] vhost: support for cross endian guests
Date: Tue, 7 Apr 2015 18:08:20 +0200
Message-ID: <20150407180820.473d54be__21239.7825708196$1428422949$gmane$org@bahia.local>
References: <20150407120929.4213.8225.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20150407175443-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150407175443-mutt-send-email-mst@redhat.com>
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 7 Apr 2015 17:55:08 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 07, 2015 at 02:09:29PM +0200, Greg Kurz wrote:
> > Hi,
> > 
> > This patchset allows vhost to be used with legacy virtio when guest and host
> > have a different endianness.
> > 
> > Patches 1-6 remain the same as the previous post. Patch 7 was heavily changed
> > according to MST's comments.
> 
> This still doesn't actually work, right?
> tun and macvtap need new ioctls too ...
> 

Yes they do. I already have a patch but I wasn't sure if I should send it
along this series... Since it looks like there will be a v4, I'll add the
tun/macvtap patch.

Thanks.

--
Greg

> > ---
> > 
> > Greg Kurz (7):
> >       virtio: introduce virtio_is_little_endian() helper
> >       tun: add tun_is_little_endian() helper
> >       macvtap: introduce macvtap_is_little_endian() helper
> >       vringh: introduce vringh_is_little_endian() helper
> >       vhost: introduce vhost_is_little_endian() helper
> >       virtio: add explicit big-endian support to memory accessors
> >       vhost: feature to set the vring endianness
> > 
> > 
> >  drivers/net/macvtap.c            |   11 ++++++--
> >  drivers/net/tun.c                |   11 ++++++--
> >  drivers/vhost/Kconfig            |   10 +++++++
> >  drivers/vhost/vhost.c            |   55 ++++++++++++++++++++++++++++++++++++++
> >  drivers/vhost/vhost.h            |   34 +++++++++++++++++++----
> >  include/linux/virtio_byteorder.h |   24 ++++++++++-------
> >  include/linux/virtio_config.h    |   19 +++++++++----
> >  include/linux/vringh.h           |   19 +++++++++----
> >  include/uapi/linux/vhost.h       |    5 +++
> >  9 files changed, 156 insertions(+), 32 deletions(-)
> > 
> > --
> > Greg
> 
