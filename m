From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: rework
	VIRTIO_BALLOON_F_MUST_TELL_HOST feature, support silent deflation
Date: Mon, 27 May 2013 17:55:05 +0200
Message-ID: <51A381D9.5010800__1886.35080489821$1369670131$gmane$org@redhat.com>
References: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1368007813-1264-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 08/05/2013 12:10, Paolo Bonzini ha scritto:
> The idea of the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is to let drivers
> skip usage of the deflate queue when leaking the balloon ("silent
> deflation").  Guests may benefit from silent deflate by aggressively
> inflating the balloon; they know that they will be able to use ballooned
> pages without issuing a (blocking) request to the device.
> 
> The problem is that this feature is a "negative" feature: if
> set, the guest _may not_ use ballooned pages directly.  Negative features
> are not safe against migration; here is an explanation why this is so.
> 
> For a "positive" feature, migration is possible if the destination
> supports it, or the source didn't set it:
> 
>     dest support      source set          ok?
>           T                T              T
>           T                F              T
>           F                T              F
>           F                F              T
> 
> For a "negative" feature, migration is possible if the destination
> supports it, or the source set it:
> 
>     dest support      source set          ok?
>           T                T              T
>           T                F              F
>           F                T              T
>           F                F              T
> 
> However, the F/T line violates the virtio specification because the
> negotiated features are supposed to be the AND of the device-
> and driver-supported features.
> 
> Furthermore, this assumes that the destination host knows which features
> are "positive" and which are "negative", which obviously cannot be the
> case in general.  (The original spec assumed that every device supports
> VIRTIO_BALLOON_F_MUST_TELL_HOST, but this was not explicitly documented
> and in practice it turns out not to be the case).
> 
> Not all is lost, however.  First, all known device implementations support
> silent deflation, hence they do not negotiate the feature.  We are thus
> somewhat free to redefine what the host should do about this feature.
> 
> Second, by chance, coincidence or an evil plot, the only known driver
> that does not negotiate VIRTIO_BALLOON_F_MUST_TELL_HOST is also using
> pages before telling the host.  Thus, even though the feature used to be
> just for communication from the host, known drivers are really using it
> to communicate was in the other direction, as if the feature was named
> "VIRTIO_BALLOON_F_GUEST_TELLS_HOST".
> 
> Adjust the spec to conform, and add a new feature bit for the host to
> tell the drivers if silent deflation is actually supported.  With this
> new feature bit, the host can distinguish all three cases: will never
> do silent deflation, will do silent deflation if available, will always
> do silent deflation (as in the above buggy driver).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Ping?

Paolo

> ---
>  virtio-spec.lyx | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 258 insertions(+), 6 deletions(-)
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index 73e22e7..033362f 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -63,7 +63,7 @@
>  \author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
>  \author 460276516 "Dmitry Fleytman" dfleytma@redhat.com
>  \author 1112500848 "Rusty Russell" rusty@rustcorp.com.au
> -\author 1531152142 "Paolo Bonzini,,," 
> +\author 1531152142 "Paolo Bonzini" pbonzini@redhat.com
>  \author 1717892615 "Alexey Zaytsev,,," 
>  \author 1986246365 "Michael S. Tsirkin" 
>  \end_header
> @@ -7179,11 +7179,49 @@ bits
>  
>  \begin_deeper
>  \begin_layout Description
> -VIRTIO_BALLOON_F_MUST_TELL_HOST
> +VIRTIO_BALLOON_F_
> +\change_deleted 1531152142 1347020601
> +MUST
> +\change_inserted 1531152142 1347020602
> +GUEST
> +\change_unchanged
> +_TELL
> +\change_inserted 1531152142 1368004486
> +S
> +\change_unchanged
> +_HOST
>  \begin_inset space ~
>  \end_inset
>  
> -(0) Host must be told before pages from the balloon are used.
> +(0) 
> +\change_deleted 1531152142 1347020625
> +Host must be told
> +\change_inserted 1531152142 1347020617
> +Guest will tell host
> +\change_unchanged
> + before pages from the balloon are used.
> +
> +\change_inserted 1531152142 1368005603
> + The host should always propose this feature.
> +\begin_inset Foot
> +status open
> +
> +\begin_layout Plain Layout
> +
> +\change_inserted 1531152142 1347022389
> +This feature used to be named VIRTIO_BALLOON_F_\SpecialChar \-
> +MUST_TELL_HOST.
> + However, after a few years it was observed that drivers were not using
> + it as specified.
> + The virtio-balloon spec was then adjusted to what the drivers had been
> + doing.
> +\end_layout
> +
> +\end_inset
> +
> +
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Description
> @@ -7192,6 +7230,20 @@ VIRTIO_BALLOON_F_STATS_VQ
>  \end_inset
>  
>  (1) A virtqueue for reporting guest memory statistics is present.
> +\change_inserted 1531152142 1347020627
> +
> +\end_layout
> +
> +\begin_layout Description
> +
> +\change_inserted 1531152142 1347020648
> +VIRTIO_BALLOON_F_SILENT_DEFLATE
> +\begin_inset space ~
> +\end_inset
> +
> +(2) Guest does not need to tell host before pages from the balloon are used.
> +\change_unchanged
> +
>  \end_layout
>  
>  \end_deeper
> @@ -7342,9 +7394,27 @@ The driver constructs an array of addresses of memory pages it has previously
>  \end_layout
>  
>  \begin_layout Enumerate
> -If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the guest may not
> - use these requested pages until that descriptor in the deflateq has been
> - used by the device.
> +If 
> +\change_inserted 1531152142 1347025663
> +the VIRTIO_BALLOON_F_\SpecialChar \-
> +GUEST_\SpecialChar \-
> +TELLS_\SpecialChar \-
> +HOST feature is set, and 
> +\change_unchanged
> +the VIRTIO_BALLOON_F_
> +\change_deleted 1531152142 1347021706
> +MUST_TELL_HOST
> +\change_inserted 1531152142 1347022257
> +\SpecialChar \-
> +SILENT_\SpecialChar \-
> +DEFLATE
> +\change_unchanged
> + feature is 
> +\change_inserted 1531152142 1347025674
> +not 
> +\change_unchanged
> +set, the guest may not use these requested pages until that descriptor in
> + the deflateq has been used by the device.
>  \end_layout
>  
>  \begin_layout Enumerate
> @@ -7535,6 +7605,188 @@ VIRTIO_BALLOON_S_MEMFREE The amount of memory not being used for any purpose
>  VIRTIO_BALLOON_S_MEMTOT The total amount of memory available (in bytes).
>  \end_layout
>  
> +\begin_layout Description
> +
> +\change_inserted 1531152142 1368005515
> +Silent
> +\begin_inset space ~
> +\end_inset
> +
> +deflation
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005515
> +
> +\series medium
> +Some implementation of the balloon device may not require the guest to deflate
> + the balloon explicitly; instead, the guest may just take a page from its
> + reserve and start using it.
> + This is called 
> +\begin_inset Quotes eld
> +\end_inset
> +
> +silent deflate
> +\begin_inset Quotes erd
> +\end_inset
> +
> +
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005515
> +In order to use this feature effectively, both the guest and the host need
> + to know how the other part intends to use the balloon.
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005515
> +
> +\series medium
> +Guests may benefit from silent deflate by aggressively inflating the balloon;
> + they know that they will be able to use ballooned pages without issuing
> + a (blocking) request to the device.
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005515
> +Knowing that the guest will 
> +\emph on
> +not
> +\emph default
> + deflate silently also benefits the host.
> + For example, if the host is pinning the guest's memory, it may unpin ballooned
> + pages and pin them again upon deflation.
> + This allows cooperative memory overcommit even if the guest's memory is
> + pinned.
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005515
> +Thus, there are two possibilities for the host (either it does not support
> + silent deflate, or it does), and three for the guest (it doesn't need silent
> + deflate, it may choose to use it if available, it requires it).
> + Because there are three possibilities for the guest, support for silent
> + deflate is represented by two different feature bits.
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005515
> +The feature bits are used as follows:
> +\end_layout
> +
> +\begin_layout Itemize
> +
> +\change_inserted 1531152142 1368005671
> +the host will always negotiate the VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +GUEST_\SpecialChar \-
> +TELLS_\SpecialChar \-
> +HOST feature.
> + If the guest does 
> +\emph on
> +not
> +\emph default
> + negotiate it, the host should assume that the guest will use silent deflate.
> + If the host does not support silent deflate, it must not let the guest
> + discover any virtqueue, so that the driver will fail to start.
> +\end_layout
> +
> +\begin_layout Itemize
> +
> +\change_inserted 1531152142 1368005515
> +a guest that 
> +\emph on
> +must
> +\emph default
> + use silent deflation does not need to negotiate any feature.
> +\end_layout
> +
> +\begin_layout Itemize
> +
> +\change_inserted 1531152142 1368005676
> +a guest that 
> +\emph on
> +will never
> +\emph default
> + use silent deflation only has to propose VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +GUEST_\SpecialChar \-
> +TELLS_\SpecialChar \-
> +HOST.
> + It need not do anything if the host does not negotiate the feature.
> +\end_layout
> +
> +\begin_layout Itemize
> +
> +\change_inserted 1531152142 1368005686
> +a guest that 
> +\emph on
> +can optionally
> +\emph default
> + use silent deflation should propose both VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +GUEST_\SpecialChar \-
> +TELLS_\SpecialChar \-
> +HOST
> + and VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +SILENT_\SpecialChar \-
> +DEFLATE.
> + The guest driver can then use silent deflation if and only if the host
> + has negotiated VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +SILENT_\SpecialChar \-
> +DEFLATE too.
> +\end_layout
> +
> +\begin_layout Standard
> +
> +\change_inserted 1531152142 1368005690
> +Old hosts may fail to propose the VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +GUEST_\SpecialChar \-
> +TELLS_\SpecialChar \-
> +HOST feature.
> + This is not a problem as long as these old hosts support silent deflation;
> + when running on such a host:
> +\end_layout
> +
> +\begin_layout Itemize
> +
> +\change_inserted 1531152142 1368005515
> +a guest that 
> +\emph on
> +must
> +\emph default
> + use, or 
> +\emph on
> +will never
> +\emph default
> + use silent deflation will just work.
> +\end_layout
> +
> +\begin_layout Itemize
> +
> +\change_inserted 1531152142 1368005691
> +a guest that 
> +\emph on
> +can optionally
> +\emph default
> + use silent deflation will typically not use silent deflation, because these
> + old hosts do not know about VIRTIO_\SpecialChar \-
> +BALLOON_F_\SpecialChar \-
> +SILENT_\SpecialChar \-
> +DEFLATE, but the guest
> + will otherwise work normally.
> +\end_layout
> +
>  \begin_layout Chapter*
>  Appendix H: Rpmsg: Remote Processor Messaging
>  \end_layout
> 
