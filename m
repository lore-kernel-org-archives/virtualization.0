From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio-balloon spec: reintroduce "silent
	deflation" feature
Date: Wed, 29 May 2013 12:25:31 +0300
Message-ID: <20130529092531.GJ4472@redhat.com>
References: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
	<1369762818-8787-3-git-send-email-pbonzini@redhat.com>
	<20130529074950.GC4472@redhat.com> <51A5C08C.1030708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51A5C08C.1030708@redhat.com>
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

On Wed, May 29, 2013 at 10:47:08AM +0200, Paolo Bonzini wrote:
> Il 29/05/2013 09:49, Michael S. Tsirkin ha scritto:
> > On Tue, May 28, 2013 at 07:40:18PM +0200, Paolo Bonzini wrote:
> >> The original idea of the VIRTIO_BALLOON_F_MUST_TELL_HOST feature was to
> >> let drivers skip usage of the deflate queue when leaking the balloon
> >> ("silent deflation").  Guests may benefit from silent deflate by
> >> aggressively inflating the balloon; they know that they will be able to
> >> use ballooned pages without issuing a (blocking) request to the device.
> >>
> >> The previous patch redefined the feature to ensure correctness of the
> >> operation when drivers do not correctly report deflation.  This patch
> >> adds back the optimization.
> >>
> >> The new feature bit is for the host to tell the drivers if silent
> >> deflation is actually supported.  The meaning of the feature bit is
> >> reversed compared to the original, because the original meaning was
> >> not safe against migration.
> >>
> >> For features to be safe against migration, they have to be defined as
> >> "this is true if the guest _can_ do X".  For such a "positive" feature,
> >> migration is possible if the destination supports it, or the source
> >> didn't set it:
> >>
> >>     dest support      source set          ok?
> >>           T                T              T
> >>           T                F              T
> >>           F                T              F
> >>           F                F              T
> >>
> >> Instead, the old feature was defined as "this is true if the guest
> >> _cannot_ do X".  For such a "negative" feature, migration is possible
> >> if the destination supports it, or the source sets it:
> >>
> >>     dest support      source set          ok?
> >>           T                T              T
> >>           T                F              F
> >>           F                T              T
> >>           F                F              T
> >>
> >> However, the negotiated features are supposed to be the AND of the
> >> device- and driver-supported features.  In the F/T case, the feature
> >> would be negotiated by the source as T, and become F when negotiated on
> >> the destination.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Do you have any numbers showing how this new feature improves
> > performance?
> > We are able to batch quite a lot of pages in a single deflate
> > request - is the overhead measureable in practice?
> 
> It's not only about better times, but also about better algorithms.  I
> started writing this after seeing the Google fileballoon driver.  For
> that implementation, the deflateq cannot be used at all.
> 
> Paolo

It seems weak to claim the algorithm is better without trying it
out in practice.

I asked the fileballoon driver author whether
it can use TELL_HOST or if that will be too much overhead.
He said don't know.


And in particular, I think a feature bit is a bad fit for deciding how
page will be reclaimed.  Whether you will want a page back soon can
change over time depending on load etc.  So if we can't just tell host
first always, then I think we need to give guest control to do this per
inflate command.


-- 
MST
