From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [QEMU PATCH v5 0/3] virtio-net: fix of ctrl commands
Date: Wed, 23 Jan 2013 08:42:03 +0100
Message-ID: <20130123074203.GA4121__33863.9318281368$1358928428$gmane$org@stefanha-thinkpad>
References: <1358869486-22777-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358869486-22777-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: aliguori@us.ibm.com, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 22, 2013 at 11:44:43PM +0800, Amos Kong wrote:
> Currently virtio-net code relys on the layout of descriptor,
> this patchset removed the assumptions and introduced a control
> command to set mac address. Last patch is a trivial renaming.
> 
> V2: check guest's iov_len
> V3: fix of migration compatibility
>     make mac field in config space read-only when new feature is acked
> V4: add fix of descriptor layout assumptions, trivial rename
> V5: fix endianness after iov_to_buf copy
> 
> Amos Kong (2):
>   virtio-net: introduce a new macaddr control
>   virtio-net: rename ctrl rx commands
> 
> Michael S. Tsirkin (1):
>   virtio-net: remove layout assumptions for ctrl vq
> 
>  hw/pc_piix.c    |    4 ++
>  hw/virtio-net.c |  142 +++++++++++++++++++++++++++++++++---------------------
>  hw/virtio-net.h |   26 +++++++----
>  3 files changed, 108 insertions(+), 64 deletions(-)
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
