From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [virtio-dev] Re: [PATCH v11 3/6] virtio-balloon:
	VIRTIO_BALLOON_F_PAGE_CHUNKS
Date: Wed, 28 Jun 2017 08:04:50 -0700
Message-ID: <20170628150450.GA1402@bombadil.infradead.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-4-git-send-email-wei.w.wang@intel.com>
	<20170613200049-mutt-send-email-mst@kernel.org>
	<594240E9.2070705@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <594240E9.2070705@intel.com>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, amit.shah@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, liliang.opensource@gmail.com, dave.hansen@intel.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 15, 2017 at 04:10:17PM +0800, Wei Wang wrote:
> > So you still have a home-grown bitmap. I'd like to know why
> > isn't xbitmap suggested for this purpose by Matthew Wilcox
> > appropriate. Please add a comment explaining the requirements
> > from the data structure.
> 
> I didn't find his xbitmap being upstreamed, did you?

It doesn't have any users in the tree yet.  Can't add code with new users.
You should be the first!
