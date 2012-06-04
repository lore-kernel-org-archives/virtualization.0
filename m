From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/3] Fix hot-unplug race in virtio-blk
Date: Mon, 04 Jun 2012 10:11:15 +0930
Message-ID: <87oboz3o44.fsf@rustcorp.com.au>
References: <1337913289-23486-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1337913289-23486-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 25 May 2012 10:34:46 +0800, Asias He <asias@redhat.com> wrote:
> This patch set fixes the race when hot-unplug stressed disk.
> 
> Asias He (3):
>   virtio-blk: Call del_gendisk() before disable guest kick
>   virtio-blk: Reset device after blk_cleanup_queue()
>   virtio-blk: Use block layer provided spinlock
> 
>  drivers/block/virtio_blk.c |   25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

I've applied these (the revised spinlock patch, thanks to mst for his
feedback).

I think a cc: stable is in order for these, so I've added it.

Thanks,
Rusty.
