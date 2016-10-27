From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RESEND PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Thu, 27 Oct 2016 00:51:13 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E3A0FEBC7@shsmsx102.ccr.corp.intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<580A4F81.60201@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A0FD034@shsmsx102.ccr.corp.intel.com>
	<5810F1C7.4060807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5810F1C7.4060807@intel.com>
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
To: "Hansen, Dave" <dave.hansen@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On 10/26/2016 03:06 AM, Li, Liang Z wrote:
> > I am working on Dave's new bitmap schema, I have finished the part of
> > getting the 'hybrid scheme bitmap' and found the complexity was more
> > than I expected. The main issue is more memory is required to save the
> > 'hybrid scheme bitmap' beside that used to save the raw page bitmap,
> > for the worst case, the memory required is 3 times than that in the
> > previous implementation.
> 
> Really?  Could you please describe the scenario where this occurs?
> > I am wondering if I should continue, as an alternative solution, how
> > about using PFNs array when inflating/deflating only a few pages?
> > Things will be much more simple.
> 
> Yes, using pfn lists is more efficient than using bitmaps for sparse bitmaps.
> Yes, there will be cases where it is preferable to just use pfn lists vs. any kind
> of bitmap.
> 
> But, what does it matter?  At least with your current scheme where we go
> out and collect get_unused_pages(), we do the allocation up front.  The
> space efficiency doesn't matter at all for small sizes since we do the constant-
> size allocation *anyway*.
> 
> I'm also pretty sure you can pack the pfn and page order into a single 64-bit
> word and have no bitmap for a given record.  That would make it pack just as
> well as the old pfns alone.  Right?

Yes, thanks for reminding, I am using 128 bit now, I will change it to 64 bit.
Let me finish the v4 first.

Thanks!
Liang
