From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH] MAINTAINERS: copy virtio on balloon_compaction.c
Date: Thu, 3 Aug 2017 15:23:06 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73928C9A1__1741.84675929627$1501794479$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1501764010-24456-1-git-send-email-mst@redhat.com>
	<20170803133622.GD26205@xps>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170803133622.GD26205@xps>
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
To: Rafael Aquini <aquini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "Hansen,
	Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "zhenwei.pi@youruncloud.com" <zhenwei.pi@youruncloud.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Gioh Kim <gi-oh.kim@profitbricks.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday, August 3, 2017 9:36 PM, Rafael Aquini wrote:
> On Thu, Aug 03, 2017 at 03:42:52PM +0300, Michael S. Tsirkin wrote:
> > Changes to mm/balloon_compaction.c can easily break virtio, and virtio
> > is the only user of that interface.  Add a line to MAINTAINERS so
> > whoever changes that file remembers to copy us.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index f66488d..6b1d60e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13996,6 +13996,7 @@ F:	drivers/block/virtio_blk.c
> >  F:	include/linux/virtio*.h
> >  F:	include/uapi/linux/virtio_*.h
> >  F:	drivers/crypto/virtio/
> > +F:	mm/balloon_compaction.c
> >
> >  VIRTIO CRYPTO DRIVER
> >  M:	Gonglei <arei.gonglei@huawei.com>
> > --
> > MST
> 
> Acked-by: Rafael Aquini <aquini@redhat.com>

Acked-by: Wei Wang <wei.w.wang@intel.com>
