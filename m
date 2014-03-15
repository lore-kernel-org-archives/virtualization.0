From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Sat, 15 Mar 2014 09:20:45 -0400
Message-ID: <20140315132045.GA14196@thunk.org>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
	<990f1cbc-fa54-4cb2-a9ee-394a1a6d5f07@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <990f1cbc-fa54-4cb2-a9ee-394a1a6d5f07@email.android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Frank Swiderski <fes@google.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 15, 2014 at 06:57:01AM -0400, Konrad Rzeszutek Wilk wrote:
> >+	pr_info("%s: using queue depth %d\n", vblk->disk->disk_name,
> >+		virtio_mq_reg.queue_depth);
> 
> Isn't that visible from sysfs?

As near as I can tell, it's not.  I haven't been able to find anything
that either represents this value, or can be calculated from this
value.  Maybe I missed something?

						- Ted
