From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RESEND PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Sun, 23 Oct 2016 11:29:25 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A0F9FA3__3475.31065713174$1477222192$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<580A4F81.60201@intel.com>
	<20161021224428-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161021224428-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Fri, Oct 21, 2016 at 10:25:21AM -0700, Dave Hansen wrote:
> > On 10/20/2016 11:24 PM, Liang Li wrote:
> > > Dave Hansen suggested a new scheme to encode the data structure,
> > > because of additional complexity, it's not implemented in v3.
> >
> > So, what do you want done with this patch set?  Do you want it applied
> > as-is so that we can introduce a new host/guest ABI that we must
> > support until the end of time?  Then, we go back in a year or two and
> > add the newer format that addresses the deficiencies that this ABI has
> > with a third version?
> >
> 
> Exactly my questions.

Hi Dave & Michael,

In the V2, both of you thought that the memory I allocated for the bitmap is too large, and gave some
 suggestions about the solution, so I changed the implementation and used  scattered pages for the bitmap
instead of a large physical continued memory. I didn't get the comments about the changes, so I am not 
sure whether that is OK or not, that's the why I resend the V3, I just want your opinions about that part. 

I will implement the new schema as Dave suggested in V4. Before that, could you take a look at this version and
give some comments? 

Thanks!
Liang
