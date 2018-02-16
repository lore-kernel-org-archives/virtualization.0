From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v21 1/5] xbitmap: Introduce xbitmap
Date: Fri, 16 Feb 2018 10:30:32 -0800
Message-ID: <20180216183032.GA7439__7925.47617243162$1518805744$gmane$org@bombadil.infradead.org>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com>
	<1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
	<CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm <linux-mm@kvack.org>, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, Matthew Wilcox <mawilcox@microsoft.com>, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, quan.xu0@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amit.shah@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 16, 2018 at 07:44:50PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 9, 2018 at 1:10 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> >
> > The eXtensible Bitmap is a sparse bitmap representation which is
> > efficient for set bits which tend to cluster. It supports up to
> > 'unsigned long' worth of bits.
> 
> >  lib/xbitmap.c                            | 444 +++++++++++++++++++++++++++++++
> 
> Please, split tests to a separate module.

Hah, I just did this two days ago!  I didn't publish it yet, but I also made
it compile both in userspace and as a kernel module.  

It's the top two commits here:

http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-2018-02-12

Note this is a complete rewrite compared to the version presented here; it
sits on top of the XArray and no longer has a preload interface.  It has a
superset of the IDA functionality.
