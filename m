From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] virtio: graceful failure with get == NULL
Date: Tue, 13 Jan 2015 21:49:09 +0200
Message-ID: <20150113194909.GO21393@redhat.com>
References: <1421160167-18498-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421160167-18498-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 13, 2015 at 04:43:07PM +0200, Michael S. Tsirkin wrote:
> virtio 1.0 says device configuration is optional, but most drivers treat it as
> mandatory.  Even if presented by device, guest bios might disable the BAR
> holding that configuration, so we can't assume it's there, but we also don't
> want to fail if not in case drivers can cope with it's absence - such as caif
> or rng.
> 
> Add code to drivers to check presence of get callback and fail gracefully.

Rusty, in case it's not clear: I'd like to hear
your opinion on these patches, since virtio pci modern
driver I'm now preparing for submission, depends on this.


> Michael S. Tsirkin (6):
>   virtio/9p: verify device has config space
>   virtio/blk: verify device has config space
>   virtio/console: verify device has config space
>   virtio/net: verify device has config space
>   virtio/scsi: verify device has config space
>   virtio/balloon: verify device has config space
> 
>  drivers/block/virtio_blk.c      | 6 ++++++
>  drivers/char/virtio_console.c   | 6 ++++++
>  drivers/net/virtio_net.c        | 6 ++++++
>  drivers/scsi/virtio_scsi.c      | 6 ++++++
>  drivers/virtio/virtio_balloon.c | 6 ++++++
>  net/9p/trans_virtio.c           | 6 ++++++
>  6 files changed, 36 insertions(+)
> 
> -- 
> MST
> 
