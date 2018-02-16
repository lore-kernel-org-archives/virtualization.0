From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v21 1/5] xbitmap: Introduce xbitmap
Date: Fri, 16 Feb 2018 13:58:48 -0800
Message-ID: <20180216215848.GB32655__1632.72298309511$1518818238$gmane$org@bombadil.infradead.org>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com>
	<1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
	<CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
	<20180216183032.GA7439@bombadil.infradead.org>
	<CAHp75Vd_tt0bV_OqAOwc=_uWrsF2zP9pMSbxPw_AxF_s9zj-pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd_tt0bV_OqAOwc=_uWrsF2zP9pMSbxPw_AxF_s9zj-pw@mail.gmail.com>
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

On Fri, Feb 16, 2018 at 11:45:51PM +0200, Andy Shevchenko wrote:
> Now, the question about test case. Why do you heavily use BUG_ON?
> Isn't resulting statistics enough?

No.  If any of those tests fail, we want to stop dead.  They'll lead to
horrendous bugs throughout the kernel if they're wrong.  I think more of
the in-kernel test suite should stop dead instead of printing a warning.
Would you want to boot a machine which has a known bug in the page cache,
for example?
