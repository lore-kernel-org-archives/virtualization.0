From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/3] virtio-balloon: tweak config_changed implementation
Date: Tue, 8 Jan 2019 08:10:34 +0100
Message-ID: <20190108071034.GA32048__15069.4591262893$1546931321$gmane$org@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
	<1546923005-40517-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1546923005-40517-2-git-send-email-wei.w.wang@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2019 at 12:50:03PM +0800, Wei Wang wrote:
> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> The cmd_id_received is also renamed to cmd_id_received_cache, and
> the value should be obtained via virtio_balloon_cmd_id_received.
> 
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/virtio/virtio_balloon.c | 98 +++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 33 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
