From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 13/42] virtio_blk: v1.0 support
Date: Tue, 25 Nov 2014 18:55:16 +0100
Message-ID: <20141125185516.7570c6e7.cornelia.huck__8569.77107837356$1416938137$gmane$org@de.ibm.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-14-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1416933600-21398-14-git-send-email-mst@redhat.com>
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
Cc: Thomas Huth <thuth@linux.vnet.ibm.com>, rusty@au1.ibm.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Nov 2014 18:42:18 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Based on patch by Cornelia Huck.
> 
> Note: for consistency, and to avoid sparse errors,
>       convert all fields, even those no longer in use
>       for virtio v1.0.
> 
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_blk.h | 15 ++++-----
>  drivers/block/virtio_blk.c      | 70 ++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 36 deletions(-)
> 

Is this sufficiently unchanged so that the original r-bs still hold?
