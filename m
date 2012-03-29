From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio_blk: add helper function to support mass of disks
	naming
Date: Thu, 29 Mar 2012 14:03:55 +0200
Message-ID: <4F744FAB.9070403__30045.6850477078$1333381099$gmane$org@kernel.dk>
References: <4F72B5B3.6020602@cn.fujitsu.com>
	<20120328105819.GD6194@redhat.com>
	<4F73F4E6.4060104@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F73F4E6.4060104@cn.fujitsu.com>
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
Cc: linux-scsi@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 03/29/2012 07:36 AM, Ren Mingxin wrote:
>  On 03/28/2012 06:58 PM, Michael S. Tsirkin wrote:
>> On Wed, Mar 28, 2012 at 02:54:43PM +0800, Ren Mingxin wrote:
>>>   Hi,
>>>
>>> The current virtblk's naming algorithm just supports 26^3
>>> disks. If there are mass of virtblks(exceeding 26^3), there
>>> will be disks with the same name.
>>>
>>> According to "sd_format_disk_name()", I add function
>>> "virtblk_name_format()" for virtblk to support mass of
>>> disks.
>>>
>>> Signed-off-by: Ren Mingxin<renmx@cn.fujitsu.com>
>> Nod. This is basically what 3e1a7ff8a0a7b948f2684930166954f9e8e776fe
>> did. Except, maybe we should move this function into block core
>> instead of duplicating it? Where would be a good place to put it?
> 
> Yes, this was also what I thought.
> 
> How about placing the "sd_format_disk_name()"
> as "disk_name_format()" into "block/genhd.c"
> ("include/linux/genhd.h")?

Yes, that sounds like the appropriate solution (and name, and where to
put it).

-- 
Jens Axboe
