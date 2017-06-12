From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 4/6] mm: function to offer a page block on the free
	list
Date: Mon, 12 Jun 2017 07:10:12 -0700
Message-ID: <b92af473-f00e-b956-ea97-eb4626601789__26.4634531506047$1497276623$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Please stop cc'ing me on things also sent to closed mailing lists
(virtio-dev@lists.oasis-open.org).  I'm happy to review things on open
lists, but I'm not fond of the closed lists bouncing things at me.

On 06/09/2017 03:41 AM, Wei Wang wrote:
> Add a function to find a page block on the free list specified by the
> caller. Pages from the page block may be used immediately after the
> function returns. The caller is responsible for detecting or preventing
> the use of such pages.

This description doesn't tell me very much about what's going on here.
Neither does the comment.

"Pages from the page block may be used immediately after the
 function returns".

Used by who?  Does the "may" here mean that it is OK, or is it a warning
that the contents will be thrown away immediately?

The hypervisor is going to throw away the contents of these pages,
right?  As soon as the spinlock is released, someone can allocate a
page, and put good data in it.  What keeps the hypervisor from throwing
away good data?
