From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH kernel v4 7/7] virtio-balloon: tell host vm's unused page
	info
Date: Tue, 8 Nov 2016 10:30:30 -0800
Message-ID: <2dcef4a7-4909-a994-a7d0-bc54a268e991__25663.7475606569$1478629868$gmane$org@intel.com>
References: <1478067447-24654-1-git-send-email-liang.z.li@intel.com>
	<1478067447-24654-8-git-send-email-liang.z.li@intel.com>
	<b25eac6e-3744-3874-93a8-02f814549adf@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A106DAA@shsmsx102.ccr.corp.intel.com>
	<281acd8d-fd94-6318-35e5-9eb130303dc6@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A108196@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3A108196@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>
List-Id: virtualization@lists.linuxfoundation.org

On 11/07/2016 09:50 PM, Li, Liang Z wrote:
> Sounds good.  Should we ignore some of the order-0 pages in step 4 if the bitmap is full?
> Or should retry to get a complete list of order-0 pages?

I think that's a pretty reasonable thing to do.

>>> It seems the benefit we get for this feature is not as big as that in fast
>> balloon inflating/deflating.
>>>>
>>>> You should not be using get_max_pfn().  Any patch set that continues
>>>> to use it is not likely to be using a proper algorithm.
>>>
>>> Do you have any suggestion about how to avoid it?
>>
>> Yes: get the pfns from the page free lists alone.  Don't derive
>> them from the pfn limits of the system or zones.
> 
> The ' get_max_pfn()' can be avoid in this patch, but I think we can't
> avoid it completely. We need it as a hint for allocating a proper
> size bitmap. No?

If you start with higher-order pages, you'll be unlikely to get anywhere
close to filling up a bitmap that was sized to hold all possible order-0
pages on the system.  Any use of max_pfn also means that you'll
completely mis-size bitmaps on sparse systems with large holes.

I think you should size it based on the size of the free lists, if anything.
