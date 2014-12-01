From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v7 14/46] virtio: add legacy feature table support
Date: Mon, 1 Dec 2014 12:23:58 +0100
Message-ID: <20141201122358.7c9aee19.cornelia.huck@de.ibm.com>
References: <1417359787-10138-1-git-send-email-mst@redhat.com>
	<1417359787-10138-15-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417359787-10138-15-git-send-email-mst@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 30 Nov 2014 17:10:26 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio-blk has some legacy feature bits that modern drivers
> must not negotiate, but are needed for old legacy hosts
> (that e.g. don't support virtio-scsi).
> Allow a separate legacy feature table for such cases.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h  |  4 ++++
>  drivers/virtio/virtio.c | 25 ++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
