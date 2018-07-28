From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v2 0/2] virtio-balloon: some improvements
Date: Sat, 28 Jul 2018 02:00:13 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397114A2__28527.7086696171$1532743095$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
	<20180727170605-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180727170605-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, July 27, 2018 10:06 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 27, 2018 at 05:24:53PM +0800, Wei Wang wrote:
> > This series is split from the "Virtio-balloon: support free page
> > reporting" series to make some improvements.
> >
> > v1->v2 ChangeLog:
> > - register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is
> negotiated.
> >
> > Wei Wang (2):
> >   virtio-balloon: remove BUG() in init_vqs
> >   virtio_balloon: replace oom notifier with shrinker
> 
> Thanks!
> Given it's very late in the release cycle, I'll merge this for the next Linux
> release.

No problem. Thanks!

Best,
Wei
