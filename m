From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 2/6] virtio: balloon might not be a legacy device
Date: Wed, 1 Apr 2015 13:57:58 +0200
Message-ID: <20150401135758.7d79b29e.cornelia.huck@de.ibm.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<1427884468-23930-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427884468-23930-3-git-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 1 Apr 2015 12:35:48 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> We added transitional device support to balloon driver,
> so we don't need to black-list it in core anymore.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
