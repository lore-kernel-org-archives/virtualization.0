From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v29 1/4] mm: support reporting free page blocks
Date: Tue, 27 Mar 2018 19:07:22 +0300
Message-ID: <20180327190635-mutt-send-email-mst__2600.29040878198$1522166746$gmane$org@kernel.org>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
	<1522031994-7246-2-git-send-email-wei.w.wang@intel.com>
	<20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org>
	<5AB9E377.30900@intel.com> <20180327063322.GW5652@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180327063322.GW5652@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, huangzhichao@huawei.com, pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, nilal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 27, 2018 at 08:33:22AM +0200, Michal Hocko wrote:
> > > > + * The function itself might sleep so it cannot be called from atomic
> > > > + * contexts.
> > > I don't see how walk_free_mem_block() can sleep.
> > 
> > OK, it would be better to remove this sentence for the current version. But
> > I think we could probably keep it if we decide to add cond_resched() below.
> 
> The point of this sentence was to make any user aware that the function
> might sleep from the very begining rather than chase existing callers
> when we need to add cond_resched or sleep for any other reason. So I
> would rather keep it.

Let's say what it is then - "will be changed to sleep in the future".

> -- 
> Michal Hocko
> SUSE Labs
