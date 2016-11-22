From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/2] virtio_ring: fix complaint by sparse
Date: Tue, 22 Nov 2016 18:50:43 +0100
Message-ID: <20161122185043.25638147.cornelia.huck@de.ibm.com>
References: <1479793910-120188-1-git-send-email-arei.gonglei@huawei.com>
	<1479793910-120188-3-git-send-email-arei.gonglei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479793910-120188-3-git-send-email-arei.gonglei@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gonglei <arei.gonglei@huawei.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 22 Nov 2016 13:51:50 +0800
Gonglei <arei.gonglei@huawei.com> wrote:

>  # make C=2 CF="-D__CHECK_ENDIAN__" ./drivers/virtio/
> 
> drivers/virtio/virtio_ring.c:423:19: warning: incorrect type in assignment (different base types)
> drivers/virtio/virtio_ring.c:423:19:    expected unsigned int [unsigned] [assigned] i
> drivers/virtio/virtio_ring.c:423:19:    got restricted __virtio16 [usertype] next
> drivers/virtio/virtio_ring.c:423:19: warning: incorrect type in assignment (different base types)
> drivers/virtio/virtio_ring.c:423:19:    expected unsigned int [unsigned] [assigned] i
> drivers/virtio/virtio_ring.c:423:19:    got restricted __virtio16 [usertype] next
> drivers/virtio/virtio_ring.c:423:19: warning: incorrect type in assignment (different base types)
> drivers/virtio/virtio_ring.c:423:19:    expected unsigned int [unsigned] [assigned] i
> drivers/virtio/virtio_ring.c:423:19:    got restricted __virtio16 [usertype] next
> drivers/virtio/virtio_ring.c:604:39: warning: incorrect type in initializer (different base types)
> drivers/virtio/virtio_ring.c:604:39:    expected unsigned short [unsigned] [usertype] nextflag
> drivers/virtio/virtio_ring.c:604:39:    got restricted __virtio16
> drivers/virtio/virtio_ring.c:612:33: warning: restricted __virtio16 degrades to integer
> 
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
