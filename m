From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_blk: add helper function to support mass of disks
	naming
Date: Thu, 29 Mar 2012 14:46:10 +0200
Message-ID: <20120329124609.GA12341__27962.5779753134$1333025186$gmane$org@redhat.com>
References: <4F72B5B3.6020602@cn.fujitsu.com>
	<20120328105819.GD6194@redhat.com>
	<4F73F4E6.4060104@cn.fujitsu.com> <4F744FAB.9070403@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F744FAB.9070403@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-scsi@vger.kernel.org, kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ren Mingxin <renmx@cn.fujitsu.com>, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 29, 2012 at 02:03:55PM +0200, Jens Axboe wrote:
> On 03/29/2012 07:36 AM, Ren Mingxin wrote:
> >  On 03/28/2012 06:58 PM, Michael S. Tsirkin wrote:
> >> On Wed, Mar 28, 2012 at 02:54:43PM +0800, Ren Mingxin wrote:
> >>>   Hi,
> >>>
> >>> The current virtblk's naming algorithm just supports 26^3
> >>> disks. If there are mass of virtblks(exceeding 26^3), there
> >>> will be disks with the same name.
> >>>
> >>> According to "sd_format_disk_name()", I add function
> >>> "virtblk_name_format()" for virtblk to support mass of
> >>> disks.
> >>>
> >>> Signed-off-by: Ren Mingxin<renmx@cn.fujitsu.com>
> >> Nod. This is basically what 3e1a7ff8a0a7b948f2684930166954f9e8e776fe
> >> did. Except, maybe we should move this function into block core
> >> instead of duplicating it? Where would be a good place to put it?
> > 
> > Yes, this was also what I thought.
> > 
> > How about placing the "sd_format_disk_name()"
> > as "disk_name_format()" into "block/genhd.c"
> > ("include/linux/genhd.h")?
> 
> Yes, that sounds like the appropriate solution (and name, and where to
> put it).

OK, once this is posted I'll get your ack and
queue for 3.4 with other virtio fixups.

> -- 
> Jens Axboe
