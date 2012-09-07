From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Fri, 7 Sep 2012 13:43:06 +0300
Message-ID: <20120907104306.GA17211@redhat.com>
References: <1346917610-14568-1-git-send-email-pbonzini@redhat.com>
	<20120906084736.GF17656@redhat.com> <50486BB2.7070108@redhat.com>
	<20120906094442.GA22816@redhat.com> <50487382.8030303@redhat.com>
	<20120906105301.GC32325@redhat.com> <5048935A.8090308@redhat.com>
	<87wr06hg0l.fsf@rustcorp.com.au> <20120907054202.GA3452@redhat.com>
	<87vcfqfia1.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87vcfqfia1.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, yvugenfi@redhat.com, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 07, 2012 at 04:09:50PM +0930, Rusty Russell wrote:
> > So it looks like a bug: we should teach driver to tell host first on leak?
> > Yan, Vadim, can you comment please?
> >
> > Also if true, looks like this bit will be useful to detect a fixed driver on
> > the hypervisor side - to avoid unmapping such pages? Rusty what do you
> > think?
> 
> So, feature is unimplemented in qemu, and broken in drivers.  I starting
> to share Paolo's dislike of it.

What is broken in drivers?

To me it looks like it works exactly as advertized: linux and bsd ack
TELL_HOST and tells host first. windows does not do either.  Do windows
drivers currently are not broken: they just do not support the feature.

The claim that drivers and hyprevisors do not support it is false:
qemu does not support it but drivers do and in non trivial way.

> Don't understand why we'd care about fixed drivers though, if we remove
> the feature bit....
> 
> Cheers,
> Rusty.

Do we really know there are no hypervisors implementing it?
As I said above drivers do have support.

-- 
MST
