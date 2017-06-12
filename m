From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Mon, 12 Jun 2017 09:42:36 -0700
Message-ID: <9d0900f3-9df5-ac63-4069-2d796f2a5bc7__29179.063338279$1497285763$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<20170612181354-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170612181354-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 06/12/2017 09:28 AM, Michael S. Tsirkin wrote:
> 
>> The hypervisor is going to throw away the contents of these pages,
>> right?
> It should be careful and only throw away contents that was there before
> report_unused_page_block was invoked.  Hypervisor is responsible for not
> corrupting guest memory.  But that's not something an mm patch should
> worry about.

That makes sense.  I'm struggling to imagine how the hypervisor makes
use of this information, though.  Does it make the pages read-only
before this, and then it knows if there has not been a write *and* it
gets notified via this new mechanism that it can throw the page away?
