From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 05/10] mm: Allow to offline unmovable PageOffline()
 pages via MEM_GOING_OFFLINE
Date: Tue, 14 Apr 2020 17:32:27 -0700
Message-ID: <20200414173227.ac71566702c0561f42baa83f@linux-foundation.org>
References: <20200311171422.10484-1-david@redhat.com>
        <20200311171422.10484-6-david@redhat.com>
        <20200414123334-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200414123334-mutt-send-email-mst@kernel.org>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Oscar Salvador <osalvador@suse.de>, Mel Gorman <mgorman@techsingularity.net>, Mike Rapoport <rppt@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, Anshuman Khandual <anshuman.khandual@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Apr 2020 12:34:26 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Andrew, could you please ack merging this through the vhost tree
> together with the rest of the patches?

Acked-by: Andrew Morton <akpm@linux-foundation.org>
