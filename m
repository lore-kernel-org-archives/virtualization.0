From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Fri, 07 Sep 2012 09:15:46 +0930
Message-ID: <87wr06hg0l.fsf@rustcorp.com.au>
References: <1346917610-14568-1-git-send-email-pbonzini@redhat.com>
	<20120906084736.GF17656@redhat.com> <50486BB2.7070108@redhat.com>
	<20120906094442.GA22816@redhat.com> <50487382.8030303@redhat.com>
	<20120906105301.GC32325@redhat.com> <5048935A.8090308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5048935A.8090308@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> Instead, VIRTIO_NET_F_HOST_MUST_SEND_GARP would be a "negative" feature:
> if set, the host _may not_ rely on the guest to send a gARP.  Similarly
> if VIRTIO_BALLOON_F_MUST_TELL_HOST is set, the guest _may not_ use
> ballooned pages directly.
>
> There are _no_ other negative features besides
> VIRTIO_BALLOON_F_MUST_TELL_HOST in the spec, and for a good
> reason---because they're broken.
>
> (Hmm, actually we have one, VIRTIO_BLK_F_RO.  It is also a bit broken,
> but it is not so important because it depends on user input more than
> hypervisor version).

Yes, this is the key observation, and an important lesson for the
future.  Thanks!

Note that these two negative features were in the original spec, where
it's assumed that every device supports them.  That's not explicitly
documented, however.

I like killing the totally unused feature.

Cheers,
Rusty.
