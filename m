From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC qemu 0/4] A PV solution for live migration optimization
Date: Tue, 8 Mar 2016 16:44:43 +0530
Message-ID: <20160308111443.GN15443__738.061898346309$1457435718$gmane$org@grmbl.mre>
References: <1457083967-13681-1-git-send-email-jitendra.kolhe@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1457083967-13681-1-git-send-email-jitendra.kolhe@hpe.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, liang.z.li@intel.com, dgilbert@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mohan_parthasarathy@hpe.com, simhan@hpe.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 04 Mar 2016 [15:02:47], Jitendra Kolhe wrote:
> > >
> > > * Liang Li (liang.z.li@intel.com) wrote:
> > > > The current QEMU live migration implementation mark the all the
> > > > guest's RAM pages as dirtied in the ram bulk stage, all these pages
> > > > will be processed and that takes quit a lot of CPU cycles.
> > > >
> > > > From guest's point of view, it doesn't care about the content in free
> > > > pages. We can make use of this fact and skip processing the free pages
> > > > in the ram bulk stage, it can save a lot CPU cycles and reduce the
> > > > network traffic significantly while speed up the live migration
> > > > process obviously.
> > > >
> > > > This patch set is the QEMU side implementation.
> > > >
> > > > The virtio-balloon is extended so that QEMU can get the free pages
> > > > information from the guest through virtio.
> > > >
> > > > After getting the free pages information (a bitmap), QEMU can use it
> > > > to filter out the guest's free pages in the ram bulk stage. This make
> > > > the live migration process much more efficient.
> > >
> > > Hi,
> > >   An interesting solution; I know a few different people have been looking at
> > > how to speed up ballooned VM migration.
> > >
> >
> > Ooh, different solutions for the same purpose, and both based on the balloon.
> 
> We were also tying to address similar problem, without actually needing to modify
> the guest driver. Please find patch details under mail with subject.
> migration: skip sending ram pages released by virtio-balloon driver

The scope of this patch series seems to be wider: don't send free
pages to a dest at all, vs. don't send pages that are ballooned out.

		Amit
