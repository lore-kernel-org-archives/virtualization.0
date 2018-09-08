From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: RE: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Date: Sat, 8 Sep 2018 01:46:02 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397924FE@shsmsx102.ccr.corp.intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
	<20180723122342-mutt-send-email-mst@kernel.org>
	<20180723143604.GB2457@work-vm> <5B911B03.2060602@intel.com>
	<20180907122955.GD2544@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180907122955.GD2544@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "riel@redhat.com" <riel@redhat.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, September 7, 2018 8:30 PM, Dr. David Alan Gilbert wrote:
> OK, that's much better.
> The ~50% reducton with a 8G VM and a real workload is great, and it does
> what you expect when you put a lot more RAM in and see the 84% reduction
> on a guest with 128G RAM - 54s vs ~9s is a big win!
> 
> (The migrate_set_speed is a bit high, since that's in bytes/s - but it's not
> important).
> 
> That looks good,
> 

Thanks Dave for the feedback.
Hope you can join our discussion and review the v37 patches as well.

Best,
Wei
