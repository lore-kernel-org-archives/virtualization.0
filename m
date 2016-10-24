From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 kernel 1/7] virtio-balloon: rework deflate to
	add page to a list
Date: Mon, 24 Oct 2016 09:46:05 -0700
Message-ID: <580E3ACD.1080906__43517.7912972451$1477327582$gmane$org@intel.com>
References: <1477031080-12616-1-git-send-email-liang.z.li@intel.com>
	<1477031080-12616-2-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1477031080-12616-2-git-send-email-liang.z.li@intel.com>
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
> Will allow faster notifications using a bitmap down the road.
> balloon_pfn_to_page() can be removed because it's useless.

This is a pretty terse description of what's going on here.  Could you
try to elaborate a bit?  What *is* the current approach?  Why does it
not work going forward?  What do you propose instead?  Why is it better?
