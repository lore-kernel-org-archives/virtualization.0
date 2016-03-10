From: Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Thu, 10 Mar 2016 12:30:08 +0300
Message-ID: <20160310093007.GA14065@rkaganb.sw.ru>
References: <F2CBF3009FA73547804AE4C663CAB28E0414516C@shsmsx102.ccr.corp.intel.com>
	<20160304163246-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E041452EA@shsmsx102.ccr.corp.intel.com>
	<20160305214748-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E04146308@shsmsx102.ccr.corp.intel.com>
	<20160307110852-mutt-send-email-mst@redhat.com>
	<20160309142851.GA9715@rkaganb.sw.ru>
	<20160309173017-mutt-send-email-mst@redhat.com>
	<20160309170438.GB9715@rkaganb.sw.ru>
	<1457552332.17933.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1457552332.17933.24.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Li,
	Liang Z" <liang.z.li@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 09, 2016 at 02:38:52PM -0500, Rik van Riel wrote:
> On Wed, 2016-03-09 at 20:04 +0300, Roman Kagan wrote:
> > On Wed, Mar 09, 2016 at 05:41:39PM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Mar 09, 2016 at 05:28:54PM +0300, Roman Kagan wrote:
> > > > For (1) I've been trying to make a point that skipping clean
> > > > pages is
> > > > much more likely to result in noticable benefit than free pages
> > > > only.
> > > 
> > > I guess when you say clean you mean zero?
> > 
> > No I meant clean, i.e. those that could be evicted from RAM without
> > causing I/O.
> > 
> 
> Programs in the guest may have that memory mmapped.
> This could include things like libraries and executables.
> 
> How do you deal with the guest page cache containing
> references to now non-existent memory?
> 
> How do you re-populate the memory on the destination
> host?

I guess the confusion is due to the context I stripped from the previous
messages...  Actually I've been talking about doing full-fledged balloon
inflation before the migration, so, when it's deflated the guest will
fault in that data from the filesystem as usual.

Roman.
