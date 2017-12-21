From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v20 0/7] Virtio-balloon Enhancement
Date: Thu, 21 Dec 2017 04:14:37 -0800
Message-ID: <20171221121437.GA22405__36117.0130120174$1513858392$gmane$org@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<5A3A3CBC.4030202@intel.com>
	<20171220122547.GA1654@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F73938CC3E@shsmsx102.ccr.corp.intel.com>
	<20171220171019.GA12236@bombadil.infradead.org>
	<5A3B2148.8050306@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A3B2148.8050306@intel.com>
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
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, amit.sh
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 21, 2017 at 10:49:44AM +0800, Wei Wang wrote:
> On 12/21/2017 01:10 AM, Matthew Wilcox wrote:
> One more question is about the return value, why would it be ambiguous? I
> think it is the same as find_next_bit() which returns the found bit or size
> if not found.

Because find_next_bit doesn't reasonably support a bitmap which is
ULONG_MAX in size.  The point of XBitmap is to support a bitmap which
is ULONG_MAX in size, so every possible return value is a legitimate
"we found a bit here".  There's no value which can possibly be used for
"no bit was found".
