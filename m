From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v16 5/5] virtio-balloon: VIRTIO_BALLOON_F_CTRL_VQ
Date: Fri, 13 Oct 2017 16:38:34 +0300
Message-ID: <20171013163503-mutt-send-email-mst__12419.51643392$1507901948$gmane$org@kernel.org>
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-6-git-send-email-wei.w.wang@intel.com>
	<20171001060305-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73932025A@shsmsx102.ccr.corp.intel.com>
	<20171010180636-mutt-send-email-mst@kernel.org>
	<59DDB428.4020208@intel.com>
	<20171011161912-mutt-send-email-mst@kernel.org>
	<59DEE790.5040809@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59DEE790.5040809@intel.com>
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
Cc: "aarcange@redhat.com" <aarcange@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, mhocko@kernel.or
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 12, 2017 at 11:54:56AM +0800, Wei Wang wrote:
> > But I think flushing is very fragile. You will easily run into races
> > if one of the actors gets out of sync and keeps adding data.
> > I think adding an ID in the free vq stream is a more robust
> > approach.
> > 
> 
> Adding ID to the free vq would need the device to distinguish whether it
> receives an ID or a free page hint,

Not really.  It's pretty simple: a 64 bit buffer is an ID. A 4K and bigger one
is a page.


> so an extra protocol is needed for the two sides to talk. Currently, we
> directly assign the free page
> address to desc->addr. With ID support, we would need to first allocate
> buffer for the protocol header,
> and add the free page address to the header, then desc->addr = &header.


I do not think you should add ID on each page. What would be the point?
Add it each time you detect a new start command.

> How about putting the ID to the command path? This would avoid the above
> trouble.
> 
> For example, using the 32-bit config registers:
> first 16-bit: Command field
> send 16-bit: ID field
> 
> Then, the working flow would look like this:
> 
> 1) Host writes "Start, 1" to the Host2Guest register and notify;
> 
> 2) Guest reads Host2Guest register, and ACKs by writing "Start, 1" to
> Guest2Host register;
> 
> 3) Guest starts report free pages;
> 
> 4) Each time when the host receives a free page hint from the free_page_vq,
> it compares the ID fields of
> the Host2Guest and Guest2Host register. If matching, then filter out the
> free page from the migration dirty bitmap,
> otherwise, simply push back without doing the filtering.
> 
> 
> Best,
> Wei


All fine but config and vq ops are asynchronous. Host has no idea when
were entries added to vq. So the ID sent to host needs to be through vq.
And I would make it a 64 or at least 32 bit ID, not a 16 bit one,
to avoid wrap-around.
-- 
MST
