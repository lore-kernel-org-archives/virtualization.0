From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc
	fallback options
Date: Thu, 26 Apr 2018 18:59:40 +0300
Message-ID: <20180426184845-mutt-send-email-mst__27498.0261609473$1524758284$gmane$org@kernel.org>
References: <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>
	<alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
	<1524694663.4100.21.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426125817.GO17484@dhcp22.suse.cz>
	<alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
	<1524753932.3226.5.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com>
	<1524756256.3226.7.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, dm-devel@redhat.com, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 26, 2018 at 11:44:21AM -0400, Mikulas Patocka wrote:
> =

> =

> On Thu, 26 Apr 2018, James Bottomley wrote:
> =

> > On Thu, 2018-04-26 at 11:05 -0400, Mikulas Patocka wrote:
> > > =

> > > On Thu, 26 Apr 2018, James Bottomley wrote:
> > [...]
> > > > Perhaps find out beforehand instead of insisting on an approach
> > > without
> > > > knowing.=A0 On openSUSE the grub config is built from the files in
> > > > /etc/grub.d/ so any package can add a kernel option (and various
> > > > conditions around activating it) simply by adding a new file.
> > > =

> > > And then, different versions of the debug kernel will clash when=A0
> > > attempting to create the same file.
> > =

> > Don't be silly ... there are many ways of coping with that in rpm/dpkg.
> =

> I know you can deal with it - but how many lines of code will that =

> consume? Multiplied by the total number of rpm-based distros.
> =

> Mikulas

I don't think debug kernels should inject faults by default.

IIUC debug kernels mainly exist so people who experience e.g. memory
corruption can try and debug the failure. In this case, CONFIG_DEBUG_SG
will *already* catch a failure early. Nothing special needs to be done.

There is a much smaller class of people like QA who go actively looking
for trouble. That's the kind of thing fault injection is good for, and
IMO you do not want your QA team to test a separate kernel - otherwise
you are never quite sure whatever was tested will work in the field.
So a config option won't help them either.

How do you make sure QA tests a specific corner case? Add it to
the test plan :)

I don't speak for Red Hat, etc.

-- =

MST
