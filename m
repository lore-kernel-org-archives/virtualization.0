From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 kernel 0/7] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Fri, 21 Oct 2016 10:25:21 -0700
Message-ID: <580A4F81.60201@intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, amit.shah@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 10/20/2016 11:24 PM, Liang Li wrote:
> Dave Hansen suggested a new scheme to encode the data structure,
> because of additional complexity, it's not implemented in v3.

So, what do you want done with this patch set?  Do you want it applied
as-is so that we can introduce a new host/guest ABI that we must support
until the end of time?  Then, we go back in a year or two and add the
newer format that addresses the deficiencies that this ABI has with a
third version?
