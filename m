From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH v1 2/3] virtio-balloon: deflate up to oom_pages on OOM
Date: Sun, 22 Oct 2017 13:11:13 +0900
Message-ID: <201710221311.FFI17148.VStOJQLHOFFMOF__39796.1119808771$1508645515$gmane$org@I-love.SAKURA.ne.jp>
References: <1508500466-21165-1-git-send-email-wei.w.wang@intel.com>
	<1508500466-21165-3-git-send-email-wei.w.wang@intel.com>
	<20171022062119-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171022062119-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, wei.w.wang@intel.com
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mhocko@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On Fri, Oct 20, 2017 at 07:54:25PM +0800, Wei Wang wrote:
> > The current implementation only deflates 256 pages even when a user
> > specifies more than that via the oom_pages module param. This patch
> > enables the deflating of up to oom_pages pages if there are enough
> > inflated pages.
> 
> This seems reasonable. Does this by itself help?

At least

> > -	num_freed_pages = leak_balloon(vb, oom_pages);
> > +
> > +	/* Don't deflate more than the number of inflated pages */
> > +	while (npages && atomic64_read(&vb->num_pages))
> > +		npages -= leak_balloon(vb, npages);

don't we need to abort if leak_balloon() returned 0 for some reason?
