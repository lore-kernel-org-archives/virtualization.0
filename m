From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v33 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Fri, 15 Jun 2018 14:42:23 +0300
Message-ID: <20180615144000-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
	<1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1529037793-35521-3-git-send-email-wei.w.wang@intel.com>
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
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 15, 2018 at 12:43:11PM +0800, Wei Wang wrote:
> Negotiation of the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature indicates the
> support of reporting hints of guest free pages to host via virtio-balloon.
> 
> Host requests the guest to report free page hints by sending a command
> to the guest via setting the VIRTIO_BALLOON_HOST_CMD_FREE_PAGE_HINT bit
> of the host_cmd config register.
> 
> As the first step here, virtio-balloon only reports free page hints from
> the max order (10) free page list to host. This has generated similar good
> results as reporting all free page hints during our tests.
> 
> TODO:
> - support reporting free page hints from smaller order free page lists
>   when there is a need/request from users.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/virtio/virtio_balloon.c     | 187 +++++++++++++++++++++++++++++-------
>  include/uapi/linux/virtio_balloon.h |  13 +++
>  2 files changed, 163 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 6b237e3..582a03b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -43,6 +43,9 @@
>  #define OOM_VBALLOON_DEFAULT_PAGES 256
>  #define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
>  
> +/* The size of memory in bytes allocated for reporting free page hints */
> +#define FREE_PAGE_HINT_MEM_SIZE (PAGE_SIZE * 16)
> +
>  static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
>  module_param(oom_pages, int, S_IRUSR | S_IWUSR);
>  MODULE_PARM_DESC(oom_pages, "pages to free on OOM");

Doesn't this limit memory size of the guest we can report?
Apparently to several gigabytes ...
OTOH huge guests with lots of free memory is exactly
where we would gain the most ...

-- 
MST
