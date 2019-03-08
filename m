From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 7 Mar 2019 21:21:03 -0500
Message-ID: <20190307211506-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
	<20190307191720.GF3835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190307191720.GF3835@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2019 at 02:17:20PM -0500, Jerome Glisse wrote:
> > It's because of all these issues that I preferred just accessing
> > userspace memory and handling faults. Unfortunately there does not
> > appear to exist an API that whitelists a specific driver along the lines
> > of "I checked this code for speculative info leaks, don't add barriers
> > on data path please".
> 
> Maybe it would be better to explore adding such helper then remapping
> page into kernel address space ?

I explored it a bit (see e.g. thread around: "__get_user slower than
get_user") and I can tell you it's not trivial given the issue is around
security.  So in practice it does not seem fair to keep a significant
optimization out of kernel because *maybe* we can do it differently even
better :)

-- 
MST
