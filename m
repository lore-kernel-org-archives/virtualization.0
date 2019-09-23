From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC v3 1/9] ACPI: NUMA: export pxm_to_node
Date: Mon, 23 Sep 2019 12:36:55 +0200
Message-ID: <20190923103655.GG6016@dhcp22.suse.cz>
References: <20190919142228.5483-1-david@redhat.com>
	<20190919142228.5483-2-david@redhat.com>
	<f4d8204e-71a1-855e-3992-35f7ec90440c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f4d8204e-71a1-855e-3992-35f7ec90440c@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Len Brown <lenb@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon 23-09-19 12:13:11, David Hildenbrand wrote:
> On 19.09.19 16:22, David Hildenbrand wrote:
> > Will be needed by virtio-mem to identify the node from a pxm.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  drivers/acpi/numa.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> > index eadbf90e65d1..d5847fa7ac69 100644
> > --- a/drivers/acpi/numa.c
> > +++ b/drivers/acpi/numa.c
> > @@ -35,6 +35,7 @@ int pxm_to_node(int pxm)
> >  		return NUMA_NO_NODE;
> >  	return pxm_to_node_map[pxm];
> >  }
> > +EXPORT_SYMBOL(pxm_to_node);
> 
> FWIW, this is a fairly old patch I dragged along and I think I'll
> convert this to EXPORT_SYMBOL_GPL now that I know better :)

All other exports in this file are EXPORT_SYMBOL. Why is this one
considered special to restrict the access?
-- 
Michal Hocko
SUSE Labs
