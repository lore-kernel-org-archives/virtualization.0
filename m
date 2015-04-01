From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 6/6] virtio: drop virtio_device_is_legacy_only
Date: Wed, 1 Apr 2015 14:04:20 +0200
Message-ID: <20150401140420.7dcc9113.cornelia.huck__7091.96791654012$1427889885$gmane$org@de.ibm.com>
References: <1427884468-23930-1-git-send-email-mst@redhat.com>
	<1427884468-23930-7-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427884468-23930-7-git-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Paul Bolle <pebolle@tiscali.nl>, Pawel Moll <pawel.moll@arm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 1 Apr 2015 12:36:03 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio_device_is_legacy_only is now unused, drop
> it from core.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h  | 2 --
>  drivers/virtio/virtio.c | 6 ------
>  2 files changed, 8 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
