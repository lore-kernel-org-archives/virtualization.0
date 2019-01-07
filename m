From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/3] virtio-balloon: tweak config_changed
Date: Mon, 7 Jan 2019 14:40:23 +0100
Message-ID: <8eaba95f-5d3f-f225-31bf-65e6425330be__18985.2831689224$1546868309$gmane$org@de.ibm.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Can you please cc stable? Right now 4.20 does not work under KVM.



On 07.01.2019 08:01, Wei Wang wrote:
> Since virtio-ccw doesn't work with accessing to the config space
> inside an interrupt context, this patch series avoids that issue by
> moving the config register accesses to the related workqueue contexts.
> 
> v2->v3 ChangeLog:
>     - rename cmd_id_received to cmd_id_received_cache, and have call sites
>       read the latest value via virtio_balloon_cmd_id_received. (Still
>       kept Cornelia and Halil's reviewed-by as it's a minor change)
>     - remove zeroing vb->num_free_page_blocks in probe since vb is
>       allocated via kzalloc.
> v1->v2 ChangeLog:
>     - add config_read_bitmap to indicate to the workqueue callbacks about
>       the necessity of reading the related config fields.
> 
> Wei Wang (3):
>   virtio-balloon: tweak config_changed implementation
>   virtio-balloon: improve update_balloon_size_func
>   virtio_balloon: remove the unnecessary 0-initialization
> 
>  drivers/virtio/virtio_balloon.c | 104 ++++++++++++++++++++++++++--------------
>  1 file changed, 69 insertions(+), 35 deletions(-)
> 
