From: Ren Mingxin <renmx@cn.fujitsu.com>
Subject: Re: [PATCH 4/4] virtio_blk: use disk_name_format() to support mass
	of disks naming
Date: Mon, 09 Apr 2012 11:47:51 +0800
Message-ID: <4F825BE7.80204__6181.23256504095$1333990827$gmane$org@cn.fujitsu.com>
References: <4F7581D4.4040301@cn.fujitsu.com> <4F7582B0.5010609@cn.fujitsu.com>
	<20120330152606.GB28934@google.com>
	<20120330152808.GC28934@google.com>
	<4F78FE89.2070707@cn.fujitsu.com>
	<20120402072009.GF30360@redhat.com>
	<20120402185259.GA16226@dhcp-172-17-108-109.mtv.corp.google.com>
	<1333392978.2971.25.camel@dabdike>
	<20120402190045.GC16226@dhcp-172-17-108-109.mtv.corp.google.com>
	<20120404080149.GC22658@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120404080149.GC22658@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, SCSI <linux-scsi@vger.kernel.org>, KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, VIRTUAL <virtualization@lists.linux-foundation.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  On 04/04/2012 04:01 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 02, 2012 at 12:00:45PM -0700, Tejun Heo wrote:
>> On Mon, Apr 02, 2012 at 11:56:18AM -0700, James Bottomley wrote:
>>> So if we're agreed no other devices going forwards should ever use this
>>> interface, is there any point unifying the interface?  No matter how
>>> many caveats you hedge it round with, putting the API in a central place
>>> will be a bit like a honey trap for careless bears.   It might be safer
>>> just to leave it buried in the three current drivers.
>> Yeah, that was my hope but I think it would be easier to enforce to
>> have a common function which is clearly marked legacy so that new
>> driver writers can go look for the naming code in the existing ones,
>> find out they're all using the same function which is marked legacy
>> and explains what to do for newer drivers.
> I think I'm not the only one to be confused about the
> preferred direction here.
> James, do you agree to the approach above?
>
> It would be nice to fix virtio block for 3.4, so
> how about this:
> - I'll just apply the original bugfix patch for 3.4 -
>    it only affects virtio

Sorry, about only affects virtio, I'm not very clear here:
1) Just duplicate the disk name format function in virtio_blk
     like the original patch: https://lkml.org/lkml/2012/3/28/45
2) Move the disk name format function into block core like
     this patch series but only affects virtio(not affect mtip32xx).
Do you mean the 2) one or something else?

> - Ren will repost the refactoring patch on top, and we can
>    keep up the discussion
>
> Ren if you agree, can you make this a two patch series please?
>

Sure.

-- 
Thanks,
Ren
