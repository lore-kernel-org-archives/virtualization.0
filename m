From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Wed, 27 Jun 2012 00:47:10 +0300
Message-ID: <20120626214709.GA15406@redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<4FEA1E2E.4020806@redhat.com>
	<CAK+C7kWKtoYC=1fBQ45RTFfNc3p2PwZbLMOefMTtzOfsqe_k8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK+C7kWKtoYC=1fBQ45RTFfNc3p2PwZbLMOefMTtzOfsqe_k8w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frank Swiderski <fes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ying Han <yinghan@google.com>, mikew@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2012 at 02:31:26PM -0700, Frank Swiderski wrote:
> On Tue, Jun 26, 2012 at 1:40 PM, Rik van Riel <riel@redhat.com> wrote:
> > On 06/26/2012 04:32 PM, Frank Swiderski wrote:
> >>
> >> This implementation of a virtio balloon driver uses the page cache to
> >> "store" pages that have been released to the host. =A0The communication
> >> (outside of target counts) is one way--the guest notifies the host when
> >> it adds a page to the page cache, allowing the host to madvise(2) with
> >> MADV_DONTNEED. =A0Reclaim in the guest is therefore automatic and impl=
icit
> >> (via the regular page reclaim). =A0This means that inflating the ballo=
on
> >> is similar to the existing balloon mechanism, but the deflate is
> >> different--it re-uses existing Linux kernel functionality to
> >> automatically reclaim.
> >>
> >> Signed-off-by: Frank Swiderski<fes@google.com>
> >
> >
> > It is a great idea, but how can this memory balancing
> > possibly work if someone uses memory cgroups inside a
> > guest?
> =

> Thanks and good point--this isn't something that I considered in the
> implementation.
> =

> > Having said that, we currently do not have proper
> > memory reclaim balancing between cgroups at all, so
> > requiring that of this balloon driver would be
> > unreasonable.
> >
> > The code looks good to me, my only worry is the
> > code duplication. We now have 5 balloon drivers,
> > for 4 hypervisors, all implementing everything
> > from scratch...
> =

> Do you have any recommendations on this?  I could (I think reasonably
> so) modify the existing virtio_balloon.c and have it change behavior
> based on a feature bit or other configuration.  I'm not sure that
> really addresses the root of what you're pointing out--it's still
> adding a different implementation, but doing so as an extension of an
> existing one.
> =

> fes

Let's assume it's a feature bit: how would you
formulate what the feature does *from host point of view*?

-- =

MST
