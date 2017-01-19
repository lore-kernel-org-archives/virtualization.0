From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 kernel 0/5] Extend virtio-balloon for fast
	(de)inflating & fast live migration
Date: Thu, 19 Jan 2017 18:24:59 +0100
Message-ID: <b11c5cbe-6c63-e9dc-0313-e2dff3830951__28617.1042862863$1484846726$gmane$org@redhat.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<2a32f616-25a8-ba5a-f74c-d619fc8ab333@redhat.com>
	<20170118173139-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170118173139-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


> As long as the interface is similar, it seems to make
> sense for me - why invent a completely new device that
> looks very much like the old one?

The only reason would be that this feature could be used independently
of virtio-balloon. But this would of course only be the case, if
ballooning is strictly not wanted in a configuration, or the current
balloon driver gets replaced by an alternative solution.

I don't have any strong feelings about this, just wanted to double check.

Thanks,

David

> 
> So this boils down to whether the speedup patches are merged.
> 
> 
>> -- 
>>
>> David
