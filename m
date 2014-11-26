From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 19/42] virtio_blk: fix race at module removal
Date: Wed, 26 Nov 2014 10:53:32 +0100
Message-ID: <20141126105332.6ea70c08.cornelia.huck@de.ibm.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-20-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1416933600-21398-20-git-send-email-mst@redhat.com>
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
Cc: rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Nov 2014 18:42:46 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> If a device appears while module is being removed,
> driver will get a callback after we've given up
> on the major number.
> 
> In theory this means this major number can get reused
> by something else, resulting in a conflict.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

This and the previous patch are independent of virtio 1.0, aren't they?
Maybe you should put them at the top of your queue :)
