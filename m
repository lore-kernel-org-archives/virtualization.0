From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/16] virtio ring rework.
Date: Tue, 19 Feb 2013 10:15:36 +0100
Message-ID: <512342B8.7060203@redhat.com>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 19/02/2013 08:56, Rusty Russell ha scritto:
> OK, this is (ab)uses some of Paolo's patches.  The first 7 are
> candidates for this merge window (maybe), the rest I'm not so sure
> about.

Cool, thanks.

> Thanks,
> Rusty.
> 
> Paolo Bonzini (3):
>   scatterlist: introduce sg_unmark_end
>   virtio-blk: reorganize virtblk_add_req
>   virtio-blk: use virtqueue_add_sgs on req path
> 
> Rusty Russell (13):
>   virtio_ring: virtqueue_add_sgs, to add multiple sgs.
>   virtio-blk: use virtqueue_start_buf on bio path

Something wrong with author and commit message in this patch.

I'll send two follow-ups for virtio-scsi, one to be added before patch
7, one after.

Paolo
