From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH kernel v5 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Wed, 7 Dec 2016 08:57:01 -0800
Message-ID: <d3ff453c-56fa-19de-317c-1c82456f2831__14844.1585748971$1481129829$gmane$org@intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<0b18c636-ee67-cbb4-1ba3-81a06150db76@redhat.com>
	<0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>, "Li, Liang Z" <liang.z.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Removing silly virtio-dev@ list because it's bouncing mail...

On 12/07/2016 08:21 AM, David Hildenbrand wrote:
>> Li's current patches do that.  Well, maybe not pfn/length, but they do
>> take a pfn and page-order, which fits perfectly with the kernel's
>> concept of high-order pages.
> 
> So we can send length in powers of two. Still, I don't see any benefit
> over a simple pfn/len schema. But I'll have a more detailed look at the
> implementation first, maybe that will enlighten me :)

It is more space-efficient.  We're fitting the order into 6 bits, which
would allows the full 2^64 address space to be represented in one entry,
and leaves room for the bitmap size to be encoded as well, if we decide
we need a bitmap in the future.

If that was purely a length, we'd be limited to 64*4k pages per entry,
which isn't even a full large page.
