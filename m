From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 04/15] virtio: defer config changed notifications
Date: Mon, 6 Oct 2014 17:25:25 +0200
Message-ID: <20141006172525.4b663de6.cornelia.huck@de.ibm.com>
References: <1412608214-31944-1-git-send-email-mst@redhat.com>
	<1412608214-31944-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412608214-31944-5-git-send-email-mst@redhat.com>
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

On Mon, 6 Oct 2014 18:10:55 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Defer config changed notifications that arrive during
> probe/scan/freeze/restore.
> 
> This will allow drivers to set DRIVER_OK earlier, without worrying about
> racing with config change interrupts.
> 
> This change will also benefit old hypervisors (before 2009)
> that send interrupts without checking DRIVER_OK: previously,
> the callback could race with driver-specific initialization.
> 
> This will also help simplify drivers.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h  |  6 ++++++
>  drivers/virtio/virtio.c | 57 +++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 54 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
