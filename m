From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 10/15] virtio: add API to enable VQs early
Date: Mon, 6 Oct 2014 17:29:42 +0200
Message-ID: <20141006172942.12271379.cornelia.huck@de.ibm.com>
References: <1412608214-31944-1-git-send-email-mst@redhat.com>
	<1412608214-31944-11-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412608214-31944-11-git-send-email-mst@redhat.com>
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

On Mon, 6 Oct 2014 18:11:16 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio spec 0.9.X requires DRIVER_OK to be set before
> VQs are used, but some drivers use VQs before probe
> function returns.
> Since DRIVER_OK is set after probe, this violates the spec.
> 
> Even though under virtio 1.0 transitional devices support this
> behaviour, we want to make it possible for those early callers to become
> spec compliant and eventually support non-transitional devices.
> 
> Add API for drivers to call before using VQs.
> 
> Sets DRIVER_OK internally.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_config.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
