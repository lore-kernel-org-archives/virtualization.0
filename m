From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v25 2/2] virtio-balloon:
	VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Thu, 1 Feb 2018 18:03:52 +0200
Message-ID: <20180201175115-mutt-send-email-mst__27560.2132235237$1517500976$gmane$org@kernel.org>
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com>
	<1516871646-22741-3-git-send-email-wei.w.wang@intel.com>
	<20180125154708-mutt-send-email-mst@kernel.org>
	<5A6A871C.6040408@intel.com>
	<20180126042649-mutt-send-email-mst@kernel.org>
	<5A6AA107.3000607@intel.com>
	<20180131011423-mutt-send-email-mst@kernel.org>
	<5A72E13A.9030701@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A72E13A.9030701@intel.com>
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
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 01, 2018 at 05:43:22PM +0800, Wei Wang wrote:
> 3) Hints means the pages are quite likely to be free pages (no guarantee).
> If the pages given to host are going to be freed, then we really couldn't
> call them hints, they are true free pages. Ballooning needs true free pages,
> while live migration needs hints, would you agree with this?

It's an interesting point, I'm convinced by it.

-- 
MST
