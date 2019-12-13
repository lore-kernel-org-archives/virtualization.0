From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v4 01/13] ACPI: NUMA: export pxm_to_node
Date: Fri, 13 Dec 2019 10:47:07 +0100
Message-ID: <CAJZ5v0iqgnhOF1UQQBfv7C_b5RyoAz=U3JYLt3a0U+UnZ48DUA__21973.1514154532$1576230451$gmane$org@mail.gmail.com>
References: <20191212171137.13872-1-david@redhat.com>
 <20191212171137.13872-2-david@redhat.com>
 <5687328.t4MNS9KDDX@kreacher>
 <ec81db03-b970-420a-9c1b-29849b5e8902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ec81db03-b970-420a-9c1b-29849b5e8902@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Len Brown <lenb@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 13, 2019 at 10:41 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.12.19 22:43, Rafael J. Wysocki wrote:
> > On Thursday, December 12, 2019 6:11:25 PM CET David Hildenbrand wrote:
> >> Will be needed by virtio-mem to identify the node from a pxm.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: Len Brown <lenb@kernel.org>
> >> Cc: linux-acpi@vger.kernel.org
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  drivers/acpi/numa/srat.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> >> index eadbf90e65d1..d5847fa7ac69 100644
> >> --- a/drivers/acpi/numa/srat.c
> >> +++ b/drivers/acpi/numa/srat.c
> >> @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
> >>              return NUMA_NO_NODE;
> >>      return pxm_to_node_map[pxm];
> >>  }
> >> +EXPORT_SYMBOL(pxm_to_node);
> >>
> >>  int node_to_pxm(int node)
> >>  {
> >>
> >
> > This is fine by me FWIW.
>
> Can I count that as an Acked-by and carry it along? Thanks!

Yes, please.
