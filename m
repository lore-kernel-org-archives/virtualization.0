From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 12/15] virtio_blk: enable VQs early
Date: Mon, 6 Oct 2014 17:42:34 +0200
Message-ID: <20141006174234.6c65d251.cornelia.huck@de.ibm.com>
References: <1412608214-31944-1-git-send-email-mst@redhat.com>
	<1412608214-31944-13-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412608214-31944-13-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 6 Oct 2014 18:11:22 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio spec requires drivers to set DRIVER_OK before using VQs.
> This is set automatically after probe returns, virtio block violated this
> rule by calling add_disk, which causes the VQ to be used directly within
> probe.
> 
> To fix, call virtio_enable_vqs_early before using VQs.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
