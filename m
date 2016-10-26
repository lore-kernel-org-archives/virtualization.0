From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RESEND PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Wed, 26 Oct 2016 10:13:47 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A0FD05E__18965.1071130813$1477476866$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<580A4F81.60201@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A0FD034@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3A0FD034@shsmsx102.ccr.corp.intel.com>
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
To: "Li, Liang Z" <liang.z.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> > On 10/20/2016 11:24 PM, Liang Li wrote:
> > > Dave Hansen suggested a new scheme to encode the data structure,
> > > because of additional complexity, it's not implemented in v3.
> >
> > So, what do you want done with this patch set?  Do you want it applied
> > as-is so that we can introduce a new host/guest ABI that we must
> > support until the end of time?  Then, we go back in a year or two and
> > add the newer format that addresses the deficiencies that this ABI has with
> a third version?
> >
> 
> Hi Dave & Michael,
> 
> I am working on Dave's new bitmap schema, I have finished the part of
> getting the 'hybrid scheme bitmap'
> and found the complexity was more than I expected.  The main issue is more
> memory is required to  save the 'hybrid scheme bitmap' beside that used to
> save the raw page bitmap, for the worst case, the memory required is 3
> times than that in the previous implementation.
> 

3 times memory required is not accurate, please ignore this. sorry ...
The complexity is the point. 

> I am wondering if I should continue, as an alternative solution, how about
> using PFNs array when inflating/deflating only a few pages? Things will be
> much more simple.
> 
> 
> Thanks!
> Liang
> 
> 
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
