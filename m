From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v20 3/7 RESEND] xbitmap: add more operations
Date: Tue, 2 Jan 2018 06:09:06 -0800
Message-ID: <20180102140906.GC8222__47484.2772972353$1514902067$gmane$org@bombadil.infradead.org>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
	<20171221210327.GB25009@bombadil.infradead.org>
	<5A3CC707.9070708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A3CC707.9070708@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, penguin-kernel@I-love.SAKURA.ne.jp, mawilcox@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 22, 2017 at 04:49:11PM +0800, Wei Wang wrote:
> Thanks for the improvement. I also found a small bug in xb_zero. With the
> following changes, it has passed the current test cases and tested with the
> virtio-balloon usage without any issue.

Thanks; I applied the change.  Can you supply a test-case for testing
xb_zero please?

> > @@ -25,8 +26,11 @@ idr-test: idr-test.o $(CORE_OFILES)
> >   multiorder: multiorder.o $(CORE_OFILES)
> > +xbitmap: xbitmap.o $(CORE_OFILES)
> > +	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o xbitmap
> > +
> 
> I think the "$(CC).." line should be removed, which will fix the build error
> when adding "xbitmap" to TARGET.

Not sure what build error you're talking about, but yes that CC line
should go.  Thanks, deleted.
