From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] virtio_blk: fix panic in initialization error path
Date: Mon, 09 Jan 2017 14:55:56 -0500
Message-ID: <x49zij0gg8j.fsf__24487.3984055177$1484064050$gmane$org@segfault.boston.devel.redhat.com>
References: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
	(Omar Sandoval's message of "Mon, 9 Jan 2017 11:44:12 -0800")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org, kernel-team@fb.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Omar Sandoval <osandov@osandov.com> writes:

> From: Omar Sandoval <osandov@fb.com>
>
> If blk_mq_init_queue() returns an error, it gets assigned to
> vblk->disk->queue. Then, when we call put_disk(), we end up calling
> blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
> only assigning to vblk->disk->queue on success.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
