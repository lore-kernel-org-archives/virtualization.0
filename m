From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Thu, 15 Dec 2016 17:09:10 -0800
Message-ID: <f517bfbe-18b8-6962-5c57-545f6ef47ad0__4711.14364122531$1481850559$gmane$org@intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<0b18c636-ee67-cbb4-1ba3-81a06150db76@redhat.com>
	<0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
	<d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
	<060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C31D0E6@SHSMSX104.ccr.corp.intel.com>
	<01886693-c73e-3696-860b-086417d695e1@intel.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C32985A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C32985A@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Li, Liang Z" <liang.z.li@intel.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: "mhocko@suse.com" <mhocko@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/15/2016 04:48 PM, Li, Liang Z wrote:
>>> It seems we leave too many bit  for the pfn, and the bits leave for
>>> length is not enough, How about keep 45 bits for the pfn and 19 bits
>>> for length, 45 bits for pfn can cover 57 bits physical address, that should be
>> enough in the near feature.
>>> What's your opinion?
>> I still think 'order' makes a lot of sense.  But, as you say, 57 bits is enough for
>> x86 for a while.  Other architectures.... who knows?

Thinking about this some more...  There are really only two cases that
matter: 4k pages and "much bigger" ones.

Squeezing each 4k page into 8 bytes of metadata helps guarantee that
this scheme won't regress over the old scheme in any cases.  For bigger
ranges, 8 vs 16 bytes means *nothing*.  And 16 bytes will be as good or
better than the old scheme for everything which is >4k.

How about this:
 * 52 bits of 'pfn', 5 bits of 'order', 7 bits of 'length'
 * One special 'length' value to mean "actual length in next 8 bytes"

That should be pretty simple to produce and decode.  We have two record
sizes, but I think it is manageable.
