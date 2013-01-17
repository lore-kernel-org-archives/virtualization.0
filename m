From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [QEMU PATCH v3] virtio-net: introduce a new macaddr control
Date: Thu, 17 Jan 2013 13:40:18 +0100
Message-ID: <20130117124018.GA6830__13512.5516834252$1358426497$gmane$org@stefanha-thinkpad.redhat.com>
References: <1358418646-29626-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358418646-29626-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 17, 2013 at 06:30:46PM +0800, akong@redhat.com wrote:
> From: Amos Kong <akong@redhat.com>
> 
> In virtio-net guest driver, currently we write MAC address to
> pci config space byte by byte, this means that we have an
> intermediate step where mac is wrong. This patch introduced
> a new control command to set MAC address, it's atomic.
> 
> VIRTIO_NET_F_CTRL_MAC_ADDR is a new feature bit for compatibility.
> 
> "mac" field will be set to read-only when VIRTIO_NET_F_CTRL_MAC_ADDR
> is acked.
> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
> V2: check guest's iov_len
> V3: fix of migration compatibility
>     make mac field in config space read-only when new feature is acked
> ---
>  hw/pc_piix.c    |  4 ++++
>  hw/virtio-net.c | 10 +++++++++-
>  hw/virtio-net.h | 12 ++++++++++--
>  3 files changed, 23 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
