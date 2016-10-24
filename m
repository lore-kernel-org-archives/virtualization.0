From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 kernel 3/7] mm: add a function to get the max pfn
Date: Mon, 24 Oct 2016 09:53:10 -0700
Message-ID: <580E3C76.3010205__36846.5637475767$1477328009$gmane$org@intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<1477031080-12616-4-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477031080-12616-4-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>, mst@redhat.com
Cc: kvm@vger.kernel.org, amit.shah@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Mel Gorman <mgorman@techsingularity.net>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 10/20/2016 11:24 PM, Liang Li wrote:
> Expose the function to get the max pfn, so it can be used in the
> virtio-balloon device driver. Simply include the 'linux/bootmem.h'
> is not enough, if the device driver is built to a module, directly
> refer the max_pfn lead to build failed.

I'm not sure the rest of the set is worth reviewing.  I think a lot of
it will change pretty fundamentally once you have those improved data
structures in place.
