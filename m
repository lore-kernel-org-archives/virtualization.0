From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-balloon: some improvements
Date: Fri, 27 Jul 2018 17:06:27 +0300
Message-ID: <20180727170605-mutt-send-email-mst__33254.8548271463$1532700269$gmane$org@kernel.org>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 27, 2018 at 05:24:53PM +0800, Wei Wang wrote:
> This series is split from the "Virtio-balloon: support free page
> reporting" series to make some improvements.
> 
> v1->v2 ChangeLog:
> - register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is negotiated.
> 
> Wei Wang (2):
>   virtio-balloon: remove BUG() in init_vqs
>   virtio_balloon: replace oom notifier with shrinker

Thanks!
Given it's very late in the release cycle, I'll merge this for
the next Linux release.

>  drivers/virtio/virtio_balloon.c | 125 +++++++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 53 deletions(-)
> 
> -- 
> 2.7.4
