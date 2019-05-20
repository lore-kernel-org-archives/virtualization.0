From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
Date: Mon, 20 May 2019 08:52:59 -0400
Message-ID: <20190520085207-mutt-send-email-mst__11222.1746168629$1558356797$gmane$org@kernel.org>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 17, 2019 at 12:29:48AM -0400, Jason Wang wrote:
> Hi:
> 
> This series try to prevent a guest triggerable CPU hogging through
> vhost kthread. This is done by introducing and checking the weight
> after each requrest. The patch has been tested with reproducer of
> vsock and virtio-net. Only compile test is done for vhost-scsi.
> 
> Please review.
> This addresses CVE-2019-3900.

OK I think we should clean this code some more but given
it's a CVE fix maybe it's best to do as a patch on top.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Dave do you want to merge this or should I?

> 
> Changs from V1:
> - fix user-ater-free in vosck patch
> 
> Jason Wang (4):
>   vhost: introduce vhost_exceeds_weight()
>   vhost_net: fix possible infinite loop
>   vhost: vsock: add weight support
>   vhost: scsi: add weight support
> 
>  drivers/vhost/net.c   | 41 ++++++++++++++---------------------------
>  drivers/vhost/scsi.c  | 21 ++++++++++++++-------
>  drivers/vhost/vhost.c | 20 +++++++++++++++++++-
>  drivers/vhost/vhost.h |  5 ++++-
>  drivers/vhost/vsock.c | 28 +++++++++++++++++++++-------
>  5 files changed, 72 insertions(+), 43 deletions(-)
> 
> -- 
> 1.8.3.1
