From: Ren Mingxin <renmx@cn.fujitsu.com>
Subject: Re: [PATCH 4/4] virtio_blk: use disk_name_format() to support mass
	of disks naming
Date: Sat, 31 Mar 2012 09:14:26 +0800
Message-ID: <4F765A72.6090006__40429.7775043689$1333381139$gmane$org@cn.fujitsu.com>
References: <4F7581D4.4040301@cn.fujitsu.com> <4F7582B0.5010609@cn.fujitsu.com>
	<CAFO3S427vWXHBDaRmfwqZrGZ2Y8RPUn7CQswQou9EGMh43jU8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFO3S427vWXHBDaRmfwqZrGZ2Y8RPUn7CQswQou9EGMh43jU8Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias.hejun@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, KVM <kvm@vger.kernel.org>, SCSI <linux-scsi@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, VIRTUAL <virtualization@lists.linux-foundation.org>, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi, He:

On 03/30/2012 07:22 PM, Asias He wrote:
> On Fri, Mar 30, 2012 at 5:53 PM, Ren Mingxin<renmx@cn.fujitsu.com>  wrote:
>>   The current virtblk's naming algorithm only supports 263  disks.
>> If there are mass of virtblks(exceeding 263), there will be disks
>> with the same name.
> This fix is pretty nice. However, current virtblk's naming still
> supports up to 18278 disks, no?
> ( index 0  ->  vda, index 18277 ->  vdzzz ).

Sorry, I intended to type 26^3+ (26^2+26)...
It may still be a restriction which should be improved though.

Thanks,
Ren
