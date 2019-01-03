From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/2] virtio_pci: use queue idx instead of array idx
	to set up the vq
Date: Thu, 3 Jan 2019 10:57:20 +0100
Message-ID: <20190103105720.48e6c2c6.cohuck@redhat.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545963986-11280-2-git-send-email-wei.w.wang@intel.com>
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

On Fri, 28 Dec 2018 10:26:25 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> When find_vqs, there will be no vq[i] allocation if its corresponding
> names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> with names[2] being NULL because the related feature bit is turned off,
> so technically there are 3 queues on the device, and name[4] should
> correspond to the 3rd queue on the device.
> 
> So we use queue_idx as the queue index, which is increased only when the
> queue exists.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
