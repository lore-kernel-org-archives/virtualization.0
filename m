From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH 0/2] use larger max_request_size for virtio_blk
Date: Thu, 05 Apr 2018 08:24:27 -0400
Message-ID: <yq1lge1alj8.fsf@oracle.com>
References: <cover.1522922101.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1522922101.git.zhangweiping@didichuxing.com> (Weiping
	Zhang's message of "Thu, 5 Apr 2018 18:09:58 +0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Weiping Zhang <zhangweiping@didichuxing.com>
Cc: axboe@kernel.dk, mst@redhat.com, cohuck@redhat.com, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Weiping,

> For virtio block device, actually there is no a hard limit for max
> request size, and virtio_blk driver set -1 to
> blk_queue_max_hw_sectors(q, -1U);.  But it doesn't work, because there
> is a default upper limitation BLK_DEF_MAX_SECTORS (1280 sectors).

That's intentional (although it's an ongoing debate what the actual
value should be).

> So this series want to add a new helper
> blk_queue_max_hw_sectors_no_limit to set a proper max reqeust size.

BLK_DEF_MAX_SECTORS is a kernel default empirically chosen to strike a
decent balance between I/O latency and bandwidth. It sets an upper bound
for filesystem requests only. Regardless of the capabilities of the
block device driver and underlying hardware.

You can override the limit on a per-device basis via max_sectors_kb in
sysfs. People generally do it via a udev rule.

-- 
Martin K. Petersen	Oracle Linux Engineering
