From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v6 7/8] vhost: cross-endian support for legacy devices
Date: Mon, 27 Apr 2015 11:17:29 +0200
Message-ID: <20150427111729.06a9492e.cornelia.huck__17824.4496034042$1430126280$gmane$org@de.ibm.com>
References: <20150424122211.19156.97626.stgit@bahia.local>
	<20150424122632.19156.88058.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150424122632.19156.88058.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 24 Apr 2015 14:27:24 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> This patch brings cross-endian support to vhost when used to implement
> legacy virtio devices. Since it is a relatively rare situation, the
> feature availability is controlled by a kernel config option (not set
> by default).
> 
> The vq->is_le boolean field is added to cache the endianness to be
> used for ring accesses. It defaults to native endian, as expected
> by legacy virtio devices. When the ring gets active, we force little
> endian if the device is modern. When the ring is deactivated, we
> revert to the native endian default.
> 
> If cross-endian was compiled in, a vq->user_be boolean field is added
> so that userspace may request a specific endianness. This field is
> used to override the default when activating the ring of a legacy
> device. It has no effect on modern devices.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
> 
> Changes since v5:
> - fixed description in Kconfig
> - fixed error description in uapi header
> - dropped useless semi-colon in the vhost_vq_reset_user_be() stub
> 
>  drivers/vhost/Kconfig      |   15 ++++++++
>  drivers/vhost/vhost.c      |   85 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/vhost/vhost.h      |   11 +++++-
>  include/uapi/linux/vhost.h |   14 +++++++
>  4 files changed, 122 insertions(+), 3 deletions(-)
> 
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
