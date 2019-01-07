From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390/virtio: handle find on invalid queue gracefully
Date: Mon, 7 Jan 2019 16:06:32 +0100
Message-ID: <20190107160632.06b6f624.cohuck@redhat.com>
References: <20190107123147.97038-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190107123147.97038-1-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon,  7 Jan 2019 13:31:46 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> A queue with a capacity of zero is clearly not a valid virtio queue.
> Some emulators report zero queue size if queried with an invalid queue
> index. Instead of crashing in this case let us just return -EINVAL. To

s/-EINVAL/-ENOENT/

> make that work properly, let us fix the notifier cleanup logic as well.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> This patch is motivated by commit 86a5597 "virtio-balloon:
> VIRTIO_BALLOON_F_FREE_PAGE_HINT" (Wei Wang, 2018-08-27) which triggered
> the described scenario.  The emulator in question is the current QEMU.
> The problem we run into is the underflow in the following loop
> in  __vring_new_virtqueue():
> for (i = 0; i < vring.num-1; i++)
> 	vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1)
> Namely vring.num is an unsigned int.
> 
> RFC --> v1:
> * Change error code from -EINVAL to -ENOENT, so we are in line with the
> other transports.
> * Push down the detection of the error into virtio_ccw_read_vq_conf().
> ---
>  drivers/s390/virtio/virtio_ccw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, applied.
