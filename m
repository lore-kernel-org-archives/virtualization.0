From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 2/2] virtio: don't allocate vqs when names[i] = NULL
Date: Thu, 3 Jan 2019 10:59:16 +0100
Message-ID: <20190103105916.3f3431c6.cohuck__43114.6704512232$1546509441$gmane$org@redhat.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<1545963986-11280-3-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545963986-11280-3-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 28 Dec 2018 10:26:26 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> Some vqs may not need to be allocated when their related feature bits
> are disabled. So callers may pass in such vqs with "names = NULL".

s/=/==/ (here and in the subject)

> Then we skip such vq allocations.

> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
>  drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
>  drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
>  drivers/virtio/virtio_mmio.c           |  9 +++++++--
>  4 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
