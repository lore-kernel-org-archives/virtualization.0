From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost-blk: Add vhost-blk support v5
Date: Wed, 28 Nov 2012 11:26:48 -0500 (EST)
Message-ID: <20121128.112648.12434052000954493.davem__39630.4632923149$1354120034$gmane$org@davemloft.net>
References: <1353315222-27685-1-git-send-email-asias@redhat.com>
	<20121119202641.GB12283@redhat.com>
	<20121126151416.GB21016@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121126151416.GB21016@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: axboe@kernel.dk, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 26 Nov 2012 17:14:16 +0200

> On Mon, Nov 19, 2012 at 10:26:41PM +0200, Michael S. Tsirkin wrote:
>> > 
>> > Userspace bits:
>> > -----------------------------
>> > 1) LKVM
>> > The latest vhost-blk userspace bits for kvm tool can be found here:
>> > git@github.com:asias/linux-kvm.git blk.vhost-blk
>> > 
>> > 2) QEMU
>> > The latest vhost-blk userspace prototype for QEMU can be found here:
>> > git@github.com:asias/qemu.git blk.vhost-blk
>> > 
>> > Changes in v5:
>> > - Do not assume the buffer layout
>> > - Fix wakeup race
>> > 
>> > Changes in v4:
>> > - Mark req->status as userspace pointer
>> > - Use __copy_to_user() instead of copy_to_user() in vhost_blk_set_status()
>> > - Add if (need_resched()) schedule() in blk thread
>> > - Kill vhost_blk_stop_vq() and move it into vhost_blk_stop()
>> > - Use vq_err() instead of pr_warn()
>> > - Fail un Unsupported request
>> > - Add flush in vhost_blk_set_features()
>> > 
>> > Changes in v3:
>> > - Sending REQ_FLUSH bio instead of vfs_fsync, thanks Christoph!
>> > - Check file passed by user is a raw block device file
>> > 
>> > Signed-off-by: Asias He <asias@redhat.com>
>> 
>> Since there are files shared by this and vhost net
>> it's easiest for me to merge this all through the
>> vhost tree.
> 
> Hi Dave, are you ok with this proposal?

I have no problems with this, for networking parts:

Acked-by: David S. Miller <davem@davemloft.net>
