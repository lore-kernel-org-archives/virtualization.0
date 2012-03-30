From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] virtio_blk: use disk_name_format() to support mass
	of disks naming
Date: Fri, 30 Mar 2012 08:38:28 -0700
Message-ID: <20120330153828.GD28934__21466.6959633634$1333121924$gmane$org@google.com>
References: <4F7581D4.4040301@cn.fujitsu.com> <4F7582B0.5010609@cn.fujitsu.com>
	<20120330152606.GB28934@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120330152606.GB28934@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ren Mingxin <renmx@cn.fujitsu.com>
Cc: Jens Axboe <axboe@kernel.dk>, SCSI <linux-scsi@vger.kernel.org>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, VIRTUAL <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 30, 2012 at 08:26:06AM -0700, Tejun Heo wrote:
> On Fri, Mar 30, 2012 at 05:53:52PM +0800, Ren Mingxin wrote:
> >  The current virtblk's naming algorithm only supports 263  disks.
> > If there are mass of virtblks(exceeding 263), there will be disks
> > with the same name.
> > 
> > By renaming "sd_format_disk_name()" to "disk_name_format()"
> > and moving it into block core, virtio_blk can use this function to
> > support mass of disks.
> > 
> > Signed-off-by: Ren Mingxin <renmx@cn.fujitsu.com>
> 
> I guess it's already way too late but why couldn't they have been
> named vdD-P where both D and P are integers denoting disk number and

So, if a device name ends in digit the partition code adds delimiter
'p' automatically and this is already in use by md.  So, partitioned
md devices are named mdDpP where D and P are base 10 number indicating
the sequence like md12p4.  So, let's please add comment that new
drivers should name their devices PREFIX%d where the sequence number
can be allocated by ida.

Thanks.

-- 
tejun
