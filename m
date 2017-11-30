From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v18 05/10] xbitmap: add more operations
Date: Thu, 30 Nov 2017 06:39:52 -0800
Message-ID: <20171130143952.GB12684__30841.0025005744$1512052833$gmane$org@bombadil.infradead.org>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<201711302235.FAJ57385.OFJHOVQOFtMSFL@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201711302235.FAJ57385.OFJHOVQOFtMSFL@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 30, 2017 at 10:35:03PM +0900, Tetsuo Handa wrote:
> According to xb_set_bit(), it seems to me that we are trying to avoid memory allocation
> for "struct ida_bitmap" when all set bits within a 1024-bits bitmap reside in the first
> 61 bits.
> 
> But does such saving help? Is there characteristic bias that majority of set bits resides
> in the first 61 bits, for "bit" is "unsigned long" which holds a page number (isn't it)?
> If no such bias, wouldn't eliminating radix_tree_exception() case and always storing
> "struct ida_bitmap" simplifies the code (and make the processing faster)?

It happens all the time.  The vast majority of users of the IDA set
low bits.  Also, it's the first 62 bits -- going up to 63 bits with the
XArray rewrite.

I do plan to redo the xbitmap on top of the XArray; I'm just trying to
get the XArray merged first.  The IDA and xbitmap code will share much
more code when that happens.
