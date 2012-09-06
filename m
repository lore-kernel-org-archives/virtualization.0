From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Fri, 7 Sep 2012 02:41:27 +0300
Message-ID: <20120906234127.GC1873@redhat.com>
References: <1346917610-14568-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1346917610-14568-1-git-send-email-pbonzini@redhat.com>
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
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 06, 2012 at 09:46:50AM +0200, Paolo Bonzini wrote:
> VIRTIO_BALLOON_F_MUST_TELL_HOST cannot be used properly because it is a
> "negative" feature: it tells you that silent defalte is not supported.
> Right now, QEMU refuses migration if the target does not support all the
> features that were negotiated.  But then:
> - a migration from non-MUST_TELL_HOST to MUST_TELL_HOST will succeed,
> which is wrong;

It need not be wrong. It depends on how host behaves.
The right thing for qemu to do would be to assume that
since this bit was not acked it can not assume specific
guest behaviour.

Even ignoring that, looking at this at a high level: basically you have
configured two different machines with different qemu flags, and are
complaning that migration did not fail cleanly.

However
- This is still a user/management bug. You should not even try
  such migration. Yes I put a sanity check there but it is
  just a debugging aid. It is not indended to be exhaustive.
  This is far from the only case where user error might cause
  problems silently.
- Yes clean failure would be nicer, if
  you want to guarantee this just teach qemu to send
  all host
  features and verify they match on destination.
  Or more generally send machine configuration.
  No need to change spec or special case this bit at all.

> 
> - a migration from MUST_TELL_HOST to non-MUST_TELL_HOST will fail, which
> is useless.

It is correct. device feature bits should not change across migration.


> Add instead a new feature VIRTIO_BALLOON_F_SILENT_DEFLATE, and deprecate
> VIRTIO_BALLOON_F_MUST_TELL_HOST since it is never actually used.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virtio-spec.lyx | 36 +++++++++++++++++++++++++++++++++---
>  1 file modificato, 33 inserzioni(+), 3 rimozioni(-)
> 
> diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> index 7a073f4..1a25a18 100644
> --- a/virtio-spec.lyx
> +++ b/virtio-spec.lyx
> @@ -6238,6 +6238,8 @@ bits
>  
>  \begin_deeper
>  \begin_layout Description
> +
> +\change_deleted 1531152142 1346917221
>  VIRTIO_BALLOON_F_MUST_TELL_HOST
>  \begin_inset space ~
>  \end_inset
> @@ -6251,6 +6253,20 @@ VIRTIO_BALLOON_F_STATS_VQ
>  \end_inset
>  
>  (1) A virtqueue for reporting guest memory statistics is present.
> +\change_inserted 1531152142 1346917193
> +
> +\end_layout
> +
> +\begin_layout Description
> +
> +\change_inserted 1531152142 1346917219
> +VIRTIO_BALLOON_F_SILENT_DEFLATE
> +\begin_inset space ~
> +\end_inset
> +
> +(2) Host does not need to be told before pages from the balloon are used.
> +\change_unchanged
> +
>  \end_layout
>  
>  \end_deeper
> @@ -6401,9 +6417,23 @@ The driver constructs an array of addresses of memory pages it has previously
>  \end_layout
>  
>  \begin_layout Enumerate
> -If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set, the guest may not
> - use these requested pages until that descriptor in the deflateq has been
> - used by the device.
> +If the VIRTIO_BALLOON_F_
> +\change_deleted 1531152142 1346917234
> +MUST_TELL_HOST
> +\change_inserted 1531152142 1346917237
> +SILENT_DEFLATE
> +\change_unchanged
> + feature is 
> +\change_inserted 1531152142 1346917241
> +not 
> +\change_unchanged
> +set, the guest may not use these requested pages until that descriptor in
> + the deflateq has been used by the device.
> +
> +\change_inserted 1531152142 1346917253
> + If it is set, the guest may choose to not use the deflateq at all.
> +\change_unchanged
> +
>  \end_layout
>  
>  \begin_layout Enumerate
> -- 
> 1.7.11.2
