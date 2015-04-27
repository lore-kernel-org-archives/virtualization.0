From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v6 6/8] virtio: add explicit big-endian support to
	memory accessors
Date: Mon, 27 Apr 2015 11:14:22 +0200
Message-ID: <20150427111422.10564c9e.cornelia.huck__44082.6696729802$1430126098$gmane$org@de.ibm.com>
References: <20150424122211.19156.97626.stgit@bahia.local>
	<20150424122521.19156.65586.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150424122521.19156.65586.stgit@bahia.local>
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

On Fri, 24 Apr 2015 14:26:24 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> The current memory accessors logic is:
> - little endian if little_endian
> - native endian (i.e. no byteswap) if !little_endian
> 
> If we want to fully support cross-endian vhost, we also need to be
> able to convert to big endian.
> 
> Instead of changing the little_endian argument to some 3-value enum, this
> patch changes the logic to:
> - little endian if little_endian
> - big endian if !little_endian
> 
> The native endian case is handled by all users with a trivial helper. This
> patch doesn't change any functionality, nor it does add overhead.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
> 
> Changes since v5:
> - changed endian checking helpers as suggested by Thomas (use || and line
>   breaker)
> 
>  drivers/net/macvtap.c            |    3 ++-
>  drivers/net/tun.c                |    3 ++-
>  drivers/vhost/vhost.h            |    3 ++-
>  include/linux/virtio_byteorder.h |   24 ++++++++++++++----------
>  include/linux/virtio_config.h    |    3 ++-
>  include/linux/vringh.h           |    3 ++-
>  6 files changed, 24 insertions(+), 15 deletions(-)
> 

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
