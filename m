From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Mon, 27 May 2013 20:02:59 +0300
Message-ID: <20130527170259.GA18800@redhat.com>
References: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
	<51A381D9.5010800@redhat.com> <20130527160437.GA18270@redhat.com>
	<51A38552.9050808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A38552.9050808@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 27, 2013 at 06:09:54PM +0200, Paolo Bonzini wrote:
> Il 27/05/2013 18:04, Michael S. Tsirkin ha scritto:
> > I don't think we need a new feature. Hosts do not in practice
> > treat the feature as "negative" (that is, required), whatever the spec
> > says.  Further, windows guests don't treat it is such either.
> 
> Windows guests not treating as such is what makes the spec change work.
> 
> > So if we
> > don't want to require all guests to tell host first, all we need to do is
> > admit it's not a bug.
> 
> I think we want the possibility for the host to require that.

But why? TELL_HOST makes some optimizations possible, but if
guest won't cooperate, balloon is useless anyway.
If guest cooperates we don't have to require anything,
just go with what guest tells us it will do.

> > Please see
> > 	[PATCH] virtio-spec: balloon: MUST_TELL_HOST is optional
> > that does exactly this.
> 
> That patch mandates a change in guest behavior that is not compatible
> with the existing Windows driver.  Mine doesn't.
> 
> Paolo

Hmm I don't see it.
In fact the goal was to document the Windows driver behaviour
as correct.
Can you explain the incompatibility please?


-- 
MST
