From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Mon, 02 Jul 2012 09:59:16 +0930
Message-ID: <87obnzxaxv.fsf@rustcorp.com.au>
References: <1340742778-11282-1-git-send-email-fes@google.com>
	<4FEA1E2E.4020806@redhat.com>
	<CAK+C7kWKtoYC=1fBQ45RTFfNc3p2PwZbLMOefMTtzOfsqe_k8w@mail.gmail.com>
	<20120626214709.GA15406@redhat.com>
	<CAK+C7kUN-kYVK9AnEhcof98p+eZN1dkt9qVyYppETOeS2n3CMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK+C7kUN-kYVK9AnEhcof98p+eZN1dkt9qVyYppETOeS2n3CMQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frank Swiderski <fes@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mikew@google.com, Ying Han <yinghan@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 26 Jun 2012 16:21:58 -0700, Frank Swiderski <fes@google.com> wrote:
> On Tue, Jun 26, 2012 at 2:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Let's assume it's a feature bit: how would you
> > formulate what the feature does *from host point of view*?
> 
> In this implementation, the host doesn't keep track of pages in the
> balloon, as there is no explicit deflate path.  The host device for
> this implementation should merely, for example, MADV_DONTNEED on the
> pages sent in an inflate.  Thus, the inflate becomes a notification
> that the guest doesn't need those pages mapped in, but that they
> should be available if the guest touches them.  In that sense, it's
> not a rigid shrink of guest memory.  I'm not sure what I'd call the
> feature bit though.
> 
> Was that the question you were asking, or did I misread?

Hmm, the spec is unfortunately vague: !VIRTIO_BALLOON_F_MUST_TELL_HOST
implies you should tell the host (eventually).  I don't know if any
implementations actually care though.

We could add a VIRTIO_BALLOON_F_NEVER_TELL_DEFLATE which would mean the
deflate vq need not be used at all.

Is it altogether impossible to know when a page is reused in your
implementation?  If we could do that, we could replace our balloon with
this one.

(My deep ignorance of vm issues is hurting us here, sorry.)

Cheers,
Rusty.
