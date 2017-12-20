From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v20 0/7] Virtio-balloon Enhancement
Date: Wed, 20 Dec 2017 04:25:47 -0800
Message-ID: <20171220122547.GA1654__43443.0195637562$1513772697$gmane$org@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<5A3A3CBC.4030202@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A3A3CBC.4030202@intel.com>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, quan.xu0@gmail.com, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 20, 2017 at 06:34:36PM +0800, Wei Wang wrote:
> On 12/19/2017 10:05 PM, Tetsuo Handa wrote:
> > I think xb_find_set() has a bug in !node path.
> 
> I think we can probably remove the "!node" path for now. It would be good to
> get the fundamental part in first, and leave optimization to come as
> separate patches with corresponding test cases in the future.

You can't remove the !node path.  You'll see !node when the highest set
bit is less than 1024.  So do something like this:

	unsigned long bit;
	xb_preload(GFP_KERNEL);
	xb_set_bit(xb, 700);
	xb_preload_end();
	bit = xb_find_set(xb, ULONG_MAX, 0);
	assert(bit == 700);
