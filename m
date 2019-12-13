From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Date: Fri, 13 Dec 2019 12:15:56 -0800 (PST)
Message-ID: <20191213201556.GC26990@char.us.oracle.com>
References: <20191212171137.13872-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Robert Bradford <robert.bradford@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Pingfan Liu <kernelfans@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Wei Yang <richard.weiyang@gmail.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Samuel Ortiz <samuel>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 12, 2019 at 06:11:24PM +0100, David Hildenbrand wrote:
> This series is based on latest linux-next. The patches are located at:
>     https://github.com/davidhildenbrand/linux.git virtio-mem-rfc-v4
Heya!

Would there be by any chance a virtio-spec git tree somewhere?

..snip..
> --------------------------------------------------------------------------
> 5. Future work
> --------------------------------------------------------------------------
> 
> The separate patches contain a lot of future work items. One of the next
> steps is to make memory unplug more likely to succeed - currently, there
> are no guarantees on how much memory can get unplugged again. I have


Or perhaps tell the caller why we can't and let them sort it out?
For example: "Application XYZ is mlocked. Can't offload'.
