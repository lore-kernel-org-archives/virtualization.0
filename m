From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 0/5] Extend virtio-balloon for fast (de)inflating &
	fast live migration
Date: Thu, 13 Apr 2017 13:44:11 -0700
Message-ID: <20170413204411.GJ784@bombadil.infradead.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
> 2) transfer the guest unused pages to the host so that they
> can be skipped to migrate in live migration.

I don't understand this second bit.  You leave the pages on the free list,
and tell the host they're free.  What's preventing somebody else from
allocating them and using them for something?  Is the guest semi-frozen
at this point with just enough of it running to ask the balloon driver
to do things?
