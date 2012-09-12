From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-balloon spec: provide a version of the "silent
	deflate" feature that works
Date: Wed, 12 Sep 2012 15:54:28 +0930
Message-ID: <878vcfdahv.fsf@rustcorp.com.au>
References: <50487382.8030303@redhat.com> <20120906105301.GC32325@redhat.com>
	<5048935A.8090308@redhat.com> <87wr06hg0l.fsf@rustcorp.com.au>
	<20120907054202.GA3452@redhat.com> <87vcfqfia1.fsf@rustcorp.com.au>
	<20120907104306.GA17211@redhat.com>
	<87sjatf6iv.fsf@rustcorp.com.au>
	<20120908223724.GB20588@redhat.com>
	<87fw6qfya7.fsf@rustcorp.com.au>
	<20120910055150.GA16819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120910055150.GA16819@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: fes@google.com, aarcange@redhat.com, riel@redhat.com, kvm@vger.kernel.org, yvugenfi@redhat.com, linux-kernel@vger.kernel.org, mikew@google.com, yinghan@google.com, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> We have several options:
> 1. No memory overcommit feature. This is always the case ATM!
> 2. Do not hot-plug assigned device.
> 3. Hot-unplug assigned device.
> 4. Some assigned devices can be able to handle memory errors
>    e.g. using ATS. Limit hotplug to these.

OK, let's leave it alone, and the first person to try to implement it in
a device can figure out how to fall back.

I replied on the other thread: I think a SILENT_DEFLATE option is
a future optimization.

Cheers,
Rusty.
