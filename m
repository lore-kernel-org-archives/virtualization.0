From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio_blk: fix panic in initialization error path
Date: Mon, 9 Jan 2017 21:11:14 -0700
Message-ID: <5fd8cbf0-cca1-d38c-33b8-8b71a1e40457__22590.9825684086$1484021491$gmane$org@kernel.dk>
References: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
	<20170110060937-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170110060937-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/09/2017 09:10 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 09, 2017 at 11:44:12AM -0800, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> If blk_mq_init_queue() returns an error, it gets assigned to
>> vblk->disk->queue. Then, when we call put_disk(), we end up calling
>> blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
>> only assigning to vblk->disk->queue on success.
>>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Jens, do you mind picking this one up as well, since
> you have one virtio-blk patch already?

No problem, in fact I already queued it up.

-- 
Jens Axboe
