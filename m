From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 3/3] virtio-net: using single MSIX irq for each TX/RX
	queue pair
Date: Fri, 26 Dec 2014 18:17:02 +0800
Message-ID: <549D359E.7080401@redhat.com>
References: <1419562425-20614-1-git-send-email-jasowang@redhat.com>
	<1419562425-20614-4-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1419562425-20614-4-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 12/26/2014 10:53 AM, Jason Wang wrote:
> This patch try to reduce the number of MSIX irqs required for
> virtio-net by sharing a MSIX irq for each TX/RX queue pair through
> channels. If transport support channel, about half of the MSIX irqs
> were reduced.
>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>

Note: an issue with this patch is it may trigger tx irq handler if at
least one more used. We could solve this by checking the used idx and
bypass the tx irq if host does not signal us. (Or just does the old tx
skbs reclaiming before the checking.)
