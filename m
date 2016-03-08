From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [Qemu-devel] [RFC qemu 0/4] A PV solution for live migration
	optimization
Date: Tue, 8 Mar 2016 14:17:59 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E041481F9__40409.5699581832$1457446722$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <20160303174615.GF2115@work-vm>
	<20160304075538.GC9100@rkaganb.sw.ru>
	<F2CBF3009FA73547804AE4C663CAB28E037714DA@SHSMSX101.ccr.corp.intel.com>
	<20160304083550.GE9100@rkaganb.sw.ru> <20160304090820.GA2149@work-vm>
	<F2CBF3009FA73547804AE4C663CAB28E03771639@SHSMSX101.ccr.corp.intel.com>
	<20160304114519-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E037717B5@SHSMSX101.ccr.corp.intel.com>
	<20160304122456-mutt-send-email-mst@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E04145231@shsmsx102.ccr.corp.intel.com>
	<20160308160145-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160308160145-mutt-send-email-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Roman Kagan <rkagan@virtuozzo.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> On Fri, Mar 04, 2016 at 03:13:03PM +0000, Li, Liang Z wrote:
> > > > Maybe I am not clear enough.
> > > >
> > > > I mean if we inflate balloon before live migration, for a 8GB
> > > > guest, it takes
> > > about 5 Seconds for the inflating operation to finish.
> > >
> > > And these 5 seconds are spent where?
> > >
> >
> > The time is spent on allocating the pages and send the allocated pages
> > pfns to QEMU through virtio.
> 
> What if we skip allocating pages but use the existing interface to send pfns to
> QEMU?
>

I think it will be much faster, allocating pages is the main reason for the long time of the operation.
Experiment is needed to get the exact time spend on sending the pfns.

Liang
